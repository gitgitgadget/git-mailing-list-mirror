Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C8C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77D2613F8
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbhD2P0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbhD2P0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:26:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5EC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:25:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b21so4420410ljf.11
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dq9hJ7nvKw1U8FtdO3TJGHCmvQAg4hcrc0LxUvvDVnI=;
        b=E0j2KRVOVKbJeTqBqo+QGqSobF3M2fl9D9GIfOqBQhJZ9rQxlCuR4N0XNkhOF3RSiR
         b4xx1opSRkYLBkDpoYDqCi+jQPReEObLoEUWOvr5TIpM/iZaqeZwXOrQe0a+Dw4xY9l1
         BPfLRh83Upo9z0wet5A1b9Jit7WGCwYPU7MXXzhs5ymjcNgmKvp6rKidoz0WSHCjklpD
         6wr0XVR5/feKSssikeqPtcDn146NZNXgo+R/qeDrvA7B/CPkdMRbp/ao/8rhVGLJCaHt
         f/B+GrFJwo8yb5aqxhSNO81cOwhPlcq8tr7bskVTy3FGOkPNdRDneDVNdYBvlkrvb5jV
         uuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dq9hJ7nvKw1U8FtdO3TJGHCmvQAg4hcrc0LxUvvDVnI=;
        b=UNQfmyAGt6h5pSD2IRjwcNLfV/X7A7hK4StKmyn6tad1KPN3s9y+Z/qvTYSTThX+ru
         19hdLd0YR+TLdgBfgssbJOWDZ6TD8OaOZewD4njQdOJFgPAZcSpxjb6DOooU9XgzzS+F
         kQ4TY9KQ6T3ee5GA66CHQ5iSPLyY7MtvD5iT3+JpgFwsmnPsRX7/FBc6UPix6/DgU2qP
         qcYtpZZ+011yy3uHx2l0GUZOrBI/DN7R6WjSx6Nn2KlS4bsH+5U70JZGbiaBVPlbN/6F
         hSR9TogR5uQ7laako/TJIx5uMN38HqDe1gwxmACKmWjdmFH6WCvfpS4rqqSjIn4gNDkU
         AJtw==
X-Gm-Message-State: AOAM532MMhLJ8pHnqTqmQ+q4FE3U9p5qJVhSVESqX9wFcuXAHH75Tcij
        xuYSZOSuNiVC297CuIkHe42rprzRRvAyVfN8vjM=
X-Google-Smtp-Source: ABdhPJw5LY2u53/NC0JYi9mS8DRdPkMDdm5XQTCVQbjZBjaq5pMGToJMQplNbsB8boTd2wXuXEYwYqJl55/SP1nnzPE=
X-Received: by 2002:a2e:8699:: with SMTP id l25mr104944lji.429.1619709956043;
 Thu, 29 Apr 2021 08:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
In-Reply-To: <87im45clkp.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 29 Apr 2021 09:25:44 -0600
Message-ID: <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
Subject: Re: Why doesn't `git log -m` imply `-p`?
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 9:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Why do -c and -cc imply -p, but -m does not? I tried to use both `git
> > log -c` and `git log -m` today and was confused when the latter didn't
> > produce any output. Could we change this behavior in a future version
> > of Git?
>
> "[alias] lm = log -m" can be used when you only want the logs
>
>     $ git lm maint..master
>
> or when you want to also view patches your preference is to see all
> sides of diffs of merges
>
>     $ git lm -p maint..mater
>
> but depending on who you are that may be of dubious utility.
>
> It is best to move on, writing it off as historical accident, and
> embrace the new --diff-merges=m option, instead of wasting time on
> pondering "why", because accidents do not have to have a deep reason
> behind them ;-)

If the behavior is an idiosyncratic accident of dubious utility, let's
replace it with something that makes sense and is useful :-) If we
make -m imply -p then no alias is necessary, `git log` would display
the log without diffs and `git log -m` would display the log with all
the diffs.

On Thu, Apr 29, 2021 at 6:38 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> As the final purpose of all this is to have -m as user-friendly short
> option, I'd incline to finally let it imply -p, as --diff-merges=m now
> covers another side of the coin.
>
> What do you think?

I am 100% in favor of that proposal, and I can work on the code this weekend.

-Alex
