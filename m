Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB6C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 11:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38903613D8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 11:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFCLMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFCLMH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 07:12:07 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2164C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 04:10:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id f30so4585039oij.7
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xXsuuUbqg8QCyal6TFg7KQEZQHaTMxb5wQfk1CsITCA=;
        b=NZggIiLi+TDjWg+tCFJvctBCzgBADENa9xFbdLFepps0E2jfyzFVOcIoI4Pw4+ywkw
         K5klwvtzsafX2Xbf8TwFfL4U2sqwdzVNkW7ASkwlaf5nYupacC0ViDsNmjN/7KbuFPOC
         acjDoLtW8NJLBTrL/Knr/yoQUW+4+JxKqn1ngwFbSFegDOKBFVpMbJtM1Dd0sC4d7+8f
         lO/vi9jyzYwhlPTQGUJlDPXuK9CFBhP31/mbHurplktmrglfhRdpKb6X0qrdfnpAOPHs
         CbTYe+n/F9txU9DTGQyI4ibd29SZ0M4YPPnpxZH0ExpzaM4vjmV0AnSb/p6bLfafo1jT
         pkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xXsuuUbqg8QCyal6TFg7KQEZQHaTMxb5wQfk1CsITCA=;
        b=FzYhSB/qSFDcHvB61ZLKIwaF2bOt8aA2rjdGiX0VLlUM1PhUU/uhY7uRVsXbXCx/zF
         waGzSgpA2Vec8aLTdOPYZre1aU0eCgHipYdAj+yo7Qa/F8R1EuR08zHdq8tbVkf8UdSU
         hgprtfT8kSQhF4hwYo9ovlbHztexifS9UjUbwcgsnIWvWDGwhaLSFHckv+zfpxn6UvHG
         MVuxVrmcTD7YhG7PUTAPn01b49o1qML4G9dESBj4MP9Ruy026FXGOWhz2ro16yls814Z
         QO78e1X1lhhxcSUtlVoRVXjCx9tqeb4+bw7M1uNW8rHywbX25qv/CnpA95rnaCf9NwnR
         HpgQ==
X-Gm-Message-State: AOAM530X/ZZN2JkVwypUkZr4x/REF8zm1mFK0MCAS6LdI7GpkJVlLT2b
        P/+US06xXhn87jvDZSnJx0Q=
X-Google-Smtp-Source: ABdhPJxlh1YSsGCb8NdxR9YUiH1FpkNPXYh2xTxvtjUF0smEr6TU1A2fGHW9F6ZgxZtRR5HFvcwDmA==
X-Received: by 2002:aca:6109:: with SMTP id v9mr6650080oib.65.1622718607021;
        Thu, 03 Jun 2021 04:10:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m74sm649550oig.33.2021.06.03.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:10:06 -0700 (PDT)
Date:   Thu, 03 Jun 2021 06:09:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b8b882b9dc5_1a0a2d208e9@natae.notmuch>
In-Reply-To: <87bl8n73om.fsf@evledraar.gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87bl8n73om.fsf@evledraar.gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Tue, Jun 01 2021, Felipe Contreras wrote:
> =

> >   1. Remove all the configuration that is not essential (just leave
> >      user.name and user.email or equivalent)
> >   2. Pick 2 configurations you think you can't live without. You are =
not
> >      allowed to change them afterwards.
> >   3. Every day you can add 1 additional configuration (and update it =
the
> >      next day).
> >   4. The moment you add a 4th configuration you lose.
> =

> This proposal is somewhere between picking which 2 of your 4 kids gets
> to live and asking an alcoholic to stop drinking for a week just so he
> can tell you at the end what his favorite drinks are :)

Yeah, but if you can't enjoy life without alcohol, you probably have a
problem.

Are you saying vanilla git is *that* bad?

> So I skipped the "disable most config", but for what it's worth I think=

> I'd miss these the most, I couldn't pick just N favorites, sorry:
> =

>  * diff.colorMoved=3Dtrue: super useful, but I'd be vary of turning it =
on
>    by default in its current form. E.g. on gcc.git's changelog files it=

>    has really pathological performance characteristics.

Very nice! I didn't know about it. I'll pick it for my third day.

>  * merge.defaultToUpstream: ditto other discussion, should be "true" by=

>    default.

That is the default. I used it as an example of a configuration that
changed default (I did it in 2014).

(I just noticed the documentation of the config wasn't updated).

>  * checkout.defaultRemote=3Dorigin: I introduced this, so I'm biased, b=
ut
>    I find it super useful. Usually because I do "git branch -m
>    new-branch" on master to create topics, and then "git checkout
>    master" to get a master back (or use the existing one).

That is useful, but I don't think it's aptly named, it should be
something like checkout.autoUpstream. The name of the default branch
belongs elsewhere.

I would say core.defaultRemote.

Right now for example `git fetch` defaults to a hard-coded "origin".
Doesn't make much sense that the remote for automatic upstream checkout
can be configured, but not the one `git fetch` uses.

>  * commit.verbose=3Dtrue: so you know what you're looking at in doing i=
n
>    "git commit --amend".

Aha! My alias had `commit -v` but I would want this on all commit
commands.

Moreover, I was thinking on suggesting this by default. Who would it
hurt?

>  * grep.patternType=3Dperl: Another personal soap box (but really, BRE
>    anywhere sucks).

Nice. `git grep` is the #2 command I use the most, and I often need to
specify another regexp because the basic one doesn't understand what I'm
trying to do.

> I also have a bunch of aliases that would not be useful to a general
> audience, but which I find I can't live without, some of the most
> commonly used ones:
> =

>     # Log with "less" n/p already going to the next/prev commit
>     log-psfd =3D "!f() { PAGER=3D\"less -p'^commit'\" git log -p --stat=
 --full-diff $@; }; f"

Very neat.

> Similarly rebase is "r", "--interactive" is "ri", "--abort", and
> "--continue" are "ra" and "rc".

I have almost the same, except rbi, rbc, and rba. My 'r' is reset, but
since I use rebase more often I guess I should switch them up.

Theres are a couple of mine:

  advance =3D merge --ff-only
  undo =3D reset --hard @{1}
  =

> If anyone's interested in the rest / full set:
> https://github.com/avar/dotfiles/blob/master/.gitconfig

Is thata private repo?

Here are mine:

https://github.com/felipec/dotfiles/blob/master/.gitconfig

-- =

Felipe Contreras=
