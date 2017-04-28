Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173D6207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 02:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968491AbdD1CgS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 22:36:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34861 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967136AbdD1CgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 22:36:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id s1so620444pgc.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 19:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mhmFxMiBJI+LhpvLEPJN/peFpiIhTcU0wbLSRayLNCI=;
        b=GM3ewNc7BIjTVxOWY0xX4W+j9G/MPSeTBcXiswhm8Gl/V3kUJd6kt37aUEEeJUBnLC
         PAlfgoELmpZqgucKNhRkTUho5En5ZoInFz9hITHMVTNWxAQCa1f58inQHJuEDhSqeER6
         iY5r3tPfrOiWB8q3l4WMZtzdgYH4s0PNfYjk/fBgXMrHpABLx11NelL0SAF8b+H6fBdJ
         btP8qpj5o2pWAIi+J3/lk1uk/PV7JhQx4XM+7O65/8Wbq0fUix39Po+LG1lGxz+OmbjY
         261X3cxb3k42hFVthWmBPWg5RtuTzkW3pdqyhAVyPtvuF6M23/CezoxaIJacLmX6TF+u
         Bqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mhmFxMiBJI+LhpvLEPJN/peFpiIhTcU0wbLSRayLNCI=;
        b=G4JrESvQyldkJCyRSflgrEmwTQ/JWCXl814KSrVmDx3hZf4Az0v5X7yZ9Xa2n1JjNR
         K5rUZYx5jKpdA23kMPP9nixRL93p9v8jIp0z2BvA1aaRTTY5Afl2DeX3Ut5PVe/ceJUq
         9L3+xZfVMw/EbgUfhY2V/Dpe2ps50OpkRWMJyqkx0njLvJwvR3BUKj254Frh4LGaRs9Q
         tdWUIO3aR/l9r/Ao35Kr5qJd2NTXjjt+J5+RZwjioDnLrrR8JWndcnTAHVbuuIDy0xn3
         YU+RXXzk94jpZtViilvH8UplFmXZKU4z1V1YeSV+U0Pyb+rFRTqwcQ2l7Ln9eLaezjkb
         Pmuw==
X-Gm-Message-State: AN3rC/6MpEtFA47BVmudKLAjeDkRBvle625G5i28Vs69uStykTK8rGBg
        M0ky/IxCc/g2Kw==
X-Received: by 10.84.224.141 with SMTP id s13mr11845479plj.169.1493346975997;
        Thu, 27 Apr 2017 19:36:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:51c2:e137:8e5a:b68b])
        by smtp.gmail.com with ESMTPSA id j73sm6649357pfe.108.2017.04.27.19.36.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 19:36:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
        <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704271607550.3480@virtualbox>
        <xmqqbmrhmlsw.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 27 Apr 2017 19:36:14 -0700
In-Reply-To: <xmqqbmrhmlsw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 27 Apr 2017 17:13:19 -0700")
Message-ID: <xmqqy3ull0m9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yes.  The "pretty_given" trick is one example that the underlying
> implementation can change over time.  If you wrote this patch before
> 66b2ed09 ("Fix "log" family not to be too agressive about showing
> notes", 2010-01-20) happened, you wouldn't have known to flip this
> bit on to emulate the command line parsing of "--pretty" and
> friends, and you would have required the author of that change to
> know that you have this cut & pasted duplicated code here when the
> commit is primarily about updating revision.c
>
> So I am very serious when I say that this is adding an unnecessary
> maintenance burden.

I _am_ sympathetic to your wish to have the compiler catch a
misspelt "revs.verboes_header = 1".  A misspelt "--formta=..." 
would not be caught until the execution time.

But the compiler's static name checking helps only one time while
you are writing _this_ patch, and it does not help at all to protect
this duplicated code from future breakages.  The way "rev-list" and
friends _internally_ implement "--format=..."  or any other options
sed by the rev-list command whose behaviour you are recreating here
can (and will) change in the future, just like it already did change
in early 2010.  We didn't have pretty_given field for several years
after "--pretty" etc. that currently set the field were originally
introduced.

In an ideal world, we would probably have specific methods to
manipulate "struct rev_info" and set_format_string() method, which
would be called when the command line parser is reacting to
"--format=..." in setup_revisions(), may encapsulate the
implementation detail of setting verbose_header and pretty_given
fields in addition to calling get_commit_format() method on the
rev_info object, and your new code may be calling that method,
without having to know the implementation detail.

We do not live in that ideal world, and it is _not_ the theme of
your topic to bring us closer to the ideal world.  Under that
constraint, a future-proof way to set up the revision machinery is
to have setup_revisions() parse an av[] array.  What will be done to
your copy of revs will stay compatible with what rev-list would do
after the implementation detail of setup_revisions() changes that
way.  It is true that a misspelt "--formta=..."  would not be caught
until the execution time, but once the code in this part is written,
it is less likely to get broken by a change coming from needs by
other parts of the system (e.g. the addition of pretty_given came
not because we wanted to enhance how --format or --pretty worked; it
came because we wanted to make sure they are not affected by changes
to another option).

So after being forced by your response to rethink about it, I feel
even firmer about this than I felt when I sent my first review
comment.

Thanks.



