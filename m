Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3333020248
	for <e@80x24.org>; Thu, 21 Mar 2019 01:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCUBV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 21:21:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33413 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfCUBV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 21:21:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so4848971wrp.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RAaCzXpNeZ6IzroxeC41sdkJMdXfKzf/yFLSFcwhm5M=;
        b=jx9aBqQHqqzwVs5kB5dTZM0BTijQAnKVrSCQTK7OaFuuVQbFJMI6M79XekAwNYhiuA
         xW1hggK2f4w+CZb/Ff0dnljFE46kHK26yHY5+oLLyM9c2prfmpJ4qyFpmoUXgVU6Fuqf
         +LonBSptZr46s33jVloP3mv+Fimfich7GLmPsmfHta3ST3FSoHKPGI4Q0JrSZja5YBFh
         xCUepNnmsMdtSYslBbELPihwisqd4oU49zp05k05UDutd0iB02xkpcvHr3U/k/12zrz0
         l3xkJ4sMSQMm20ofTr2UxWh6hKprrhhkK39Gx9YTqBKSKTzw3N5cgC2BR1TbiTTEi986
         nGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RAaCzXpNeZ6IzroxeC41sdkJMdXfKzf/yFLSFcwhm5M=;
        b=j+H7nAlfIW7sKi31CxPdJbA2bfJ8jGWYbvhaG0XpUIZa8e3dwQ8K++onTZMtccQljf
         hIWMgkidoGpptNC3fc65S5JZWRxBcPxGJEr57BfIEHD5Uf5csKw+MsndWUm/+WslRQJ2
         skEuJhbQlSDT2d8Ziui+dVS8fHp87X2OWNsSvm/nHczoBgHA7rd73oFKAWL+WXVhY8lA
         eMfq/3PHgBdglg292jasJm4tfb83zje9WYJVXyS8ZmtCVAe8sHUlOZ1mMIG5Fd3TL8tb
         uF9CKyei6gkAlTZSDmVOf0YjXZudP5xPISl6+dVLq16aLyqXceZhYQylmTv6UILAJQXM
         cMlw==
X-Gm-Message-State: APjAAAWyYP0rh+RB1SsqzO+Dktj0uXkw+IIFMVmgXlIeda+BAkVye9Xi
        af+U8R26wcrFRx/pQ7+Lhpb1GYlhwKw=
X-Google-Smtp-Source: APXvYqzot/mK4QFAp8+Sc7VZcpXnSxBVA43gYLpJWzKQH/wfZKuScnLpQTZZr67Ohrxa6lio2ZV0Mg==
X-Received: by 2002:adf:afd0:: with SMTP id y16mr615949wrd.328.1553131287701;
        Wed, 20 Mar 2019 18:21:27 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 11sm4987567wmg.27.2019.03.20.18.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 18:21:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
References: <875zsdu41d.fsf@fifthhorseman.net>
Date:   Thu, 21 Mar 2019 10:21:24 +0900
In-Reply-To: <875zsdu41d.fsf@fifthhorseman.net> (Daniel Kahn Gillmor's message
        of "Wed, 20 Mar 2019 08:24:46 -0400")
Message-ID: <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Kahn Gillmor <dkg@fifthhorseman.net> writes:

> I understand that git tags can be easily renamed.  for example:
>
>     git tag push origin refs/tags/v0.0.3:refs/tags/v2.3.4
>
> However, for tags signed with any recent version of git, the tag name is
> also included in the signed material:
> ...
> But git tag doesn't verify that the internal name is the same as the
> external name (note that it still returns an exit code of zero):

That is all very much deliberate.  A few additional things you may
want to consider while assessing the proposal in your message are:

 * "git tag -v $(git rev-parse v1.0.0)" should work, but the command
   would not even see which ref the 40-hex object name it is
   verifying came from.  As "tag --verify" is about verifying the
   crypto signature over the data in the tag object, the lack of the
   information (and verification) is perfectly fine when "tag -v"
   does not begin with a refname but works from an object name. 

   I.e. your proposal to additionally check the refname of a signed
   tag must be made optional, something like "only when a refname is
   given, teach 'tag -v' to additionally check that the refname
   matches the tagname".

 * There are movements to push tags you obtain from upstream to a
   somewhere not directly underneath refs/tags/.  Instead of your
   artificial "confuse users by calling 2.3.4 what in reality is a
   mere 0.0.3" example, what would more likely to happen in the real
   world is "we see v2.3.4 at the upstream repository; copy it at
   refs/tags/origin/v2.3.4 in our repository".  If you literally
   followed your proposal, your users will be hit with "You told me
   to verify origin/v2.3.4 but the data in the tag itself claims
   that it is v2.3.4 without 'origin/' prefix--this is an error".

   Perhaps checking only the tail-match is good enough?  It is when
   you consider only this example, but that is merely one example
   and is far from exhaustive.  Your proposal needs to be fine tuned
   after thinking these details through.

 * "git describe" knows that the path under refs/tags/ and the
   tagname could be different, so after you rename v2.20.0 to
   g2.20.0, you would see something like this:

   $ git checkout --detach v2.20.0
   $ git update-ref refs/tags/g2.20.0 refs/tags/v2.20.0
   $ git update-ref -d refs/tags/v2.20.0
   $ git describe
   warning: tag 'v2.20.0' is really 'g2.20.0' here
   v2.20.0

   in today's Git already.  Porting this warning logic (which is a
   dumb one that reports any non-exact match) to "tag -v" might be
   sufficient, as long as you do not make it an error.

We may want to teach "git fsck" to notice discrepancy between the
tagname and the refname, but the same care needs to be taken to
allow sensible renaming as the second point above.

Thanks.
