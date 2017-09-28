Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B37B202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 16:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdI1Q5z (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 12:57:55 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:47005 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbdI1Q5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 12:57:54 -0400
Received: by mail-pf0-f175.google.com with SMTP id r68so1148913pfj.3
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j/MAhrqRcUPjd7EKAKOGplYM5S1f+3hk7eeofJlRdtQ=;
        b=cY7XGDdsWZiEnQuFNj/cy2+RukR6jFHEijWu5pBMMkpIgjORWcEcE29DzmoBL1Hwo5
         isVXBM5JtqKFJXxX7AAsOp4XXVCxoIo3JsiGaId1efQp04Y6WqzGih1X3vyIn0J4cc14
         bjq3CoeAkW0QxGQ3UmAvaau3we5f9eBAw4Zs1Zt355vNxrF21fkPfzd48k0/veMwWUiJ
         Zwk2Ae1p1CIWskKi38ycbmC8Q5txlEpsAksN1AajLNPvN9xMVS9MLvFXHWtaBoxBig3Y
         1XEbzbKeq+gPDv0ADOyO763pq0liEGXYPx9ZiVq0R7txSWz30O5bObMYTbprv+V7HG3b
         VkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j/MAhrqRcUPjd7EKAKOGplYM5S1f+3hk7eeofJlRdtQ=;
        b=Qgb2bYc5mhVZQTo5GqYOZ9OeAqX0jtCr7Uco3Q/bO7hqWAOK0Xhp4iGF9f8DHtZCmS
         Y9xeypX5b+ZIwCshVeN/jdHzQyzfjMlar/KYhZI2x67SrRKc63PUKs6LQL+sdo+26KdG
         ZmXXeD+i4Z6mC1h65tN8WnPFXHn26chOaZIFJV5NfuGs+CK7PrLD1/JvezsOcag5cF0Q
         osNdGFPwGtRfo3uotcxrqOOM3IAw5XrE1ADKBsc+m0d5h+qvN73+gJNDLQxKnJyN95O9
         dxl1WG69VrPy0gU5K2P6M/mastPdVnenySkaynYUzpf3QXGsF7Us9TFy2ow1pMmeBr+h
         05Lg==
X-Gm-Message-State: AHPjjUjNaiOlR09nZpEyc+qnPOjHO2uR4GmYy1kMOfHTcideFW3N8JlC
        LJ1ddfH0Ai51745wlZWjiGvLAQ==
X-Google-Smtp-Source: AOwi7QBvEIpNTXCeMrab//r8cPDeCW0q6k154BLLfSHrvfhHaCaaPoriBy/E+S+5Kx+BWSOf8Dks5w==
X-Received: by 10.159.247.131 with SMTP id e3mr4551068pls.296.1506617873784;
        Thu, 28 Sep 2017 09:57:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:880:967f:fa0a:fc13])
        by smtp.gmail.com with ESMTPSA id g5sm3948374pfe.94.2017.09.28.09.57.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 09:57:52 -0700 (PDT)
Date:   Thu, 28 Sep 2017 09:57:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 4/9] daemon: recognize hidden request arguments
Message-ID: <20170928165751.GA153914@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-5-bmwill@google.com>
 <xmqqzi9g67kl.fsf@gitster.mtv.corp.google.com>
 <20170927212258.GA68699@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927212258.GA68699@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Brandon Williams wrote:
> On 09/27, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> >
> > > A normal request to git-daemon is structured as
> > > "command path/to/repo\0host=..\0" and due to a bug in an old version of
> > > git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
> > > command, 2009-06-04) we aren't able to place any extra args (separated
> > > by NULs) besides the host.
> >
> > It's a bit unclear if that commit _introduced_ a bug, or just
> > noticed an old bug and documented it in its log message.  How does
> > that commit impact the versons of Git that the updated code is
> > capable of interracting with?
>
> You're right, after reading it again it isn't clear.  I'll change this
> to indicate that the commit is a fix to a bug and that the fix doesn't
> allow us to place any additional args.

Ok how about this wording for the commit msg:

  daemon: recognize hidden request arguments

  A normal request to git-daemon is structured as "command
  path/to/repo\0host=..\0" and due to a bug introduced in
  49ba83fb6 (Add virtualization support to git-daemon, 2006-09-19)
  we aren't able to place any extra arguments (separated by NULs)
  besides the host otherwise the parsing of those arguments would
  enter an infinite loop.  This bug was fixed in 73bb33a94
  (daemon: Strictly parse the "extra arg" part of the command,
  2009-06-04) but a check was put in place to disallow extra
  arguments so that new clients wouldn't trigger this bug in older
  servers.

  In order to get around this limitation teach git-daemon to
  recognize additional request arguments hidden behind a second
  NUL byte.  Requests can then be structured like: "command
  path/to/repo\0host=..\0\0version=1\0key=value\0".  git-daemon
  can then parse out the extra arguments and set 'GIT_PROTOCOL'
  accordingly.

  By placing these extra arguments behind a second NUL byte we can
  skirt around both the infinite loop bug in 49ba83fb6 (Add
  virtualization support to git-daemon, 2006-09-19) as well as the
  explicit disallowing of extra arguments introduced in 73bb33a94
  (daemon: Strictly parse the "extra arg" part of the command,
  2009-06-04) because both of these versions of git-daemon check
  for a single NUL byte after the host argument before terminating
  the argument parsing.

This way I'm citing when the bug was actually introduced as well as
describing why the 'fix' didn't completely resolve the issue.  I also
explain a little bit about how this change should work even with very
old servers which still have the bug.  (I tried to get the introp test
to work on a version of git that old but am having some difficulty even
getting the old version to launch git-daemon without hanging for some
unknown reason)

--
Brandon Williams
