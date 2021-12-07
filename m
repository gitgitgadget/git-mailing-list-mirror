Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7310C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 06:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbhLGGEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 01:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLGGEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 01:04:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470EAC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 22:00:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e3so52602872edu.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 22:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r6XtIDptuvKyGF4+VVphaaW0iivqAr3c+E+CtVXK6fI=;
        b=maS0g9WFwpXyMdWizwKyUMWHHR4cqyS8LP0Bt9s387nDBBwCv3ln0/6XPn5E4A8Rkg
         fYA8EeDRwtRYCLVo8BiyEKNljXEeJdYciHj46c+E8vlktG/AmQTa03/FCRMqSvWCdw/B
         UeXCWmzEF5rX0vBHAP2pmAdeZazizcLahB+jW4wBdkoWSByAttq3OhLYRygvQ0uc01H9
         //+vwuRfB9afhqezXp1YLP9Hl8wdwuicpWYReVUMgIlaXdH+oV0mog8HmLc3GpQT3ioB
         Cs3goG5POALgu7gp1/3X9uZg5aCqsEpepc/Ls7ONe8vPGB5XhuRB3MhGzJSMgegTGT5G
         ldbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r6XtIDptuvKyGF4+VVphaaW0iivqAr3c+E+CtVXK6fI=;
        b=NRFEjNe0ejepNEDDRIxEft/kDt3xtcR2DYNG0IMxVgG2+aRwwdIZgNHFAYQUGFmU6J
         oyUYnKx2savHx8qZglCF2T9jgnCXuMEcGdYwHn+A5Qg1g+9i02wIm7zTPtci2sO+0mWf
         +PfXZehld1+30VfuJkrlF+DnWptjNQlUsR24JUCxPl/fIFM1rP71Fmpdr1V0dVtq78lV
         MUa2UXZU26aQGtXrkwHT/eOrrjlNPewMh0ON//AKHO99R+wyWXp9g++nO/iJJSaInv/0
         ZYzSRUv5IQfQehgMwcnVGn9hNAX6uTzTWCh9+ZauIGq4VdQgpPLdkI+gUcmW09xg8DTF
         pIlw==
X-Gm-Message-State: AOAM533/J/Sc5/ZXInojlQnBR6DmMiyvjRDEFACxl13PjpEgvJS2zFGY
        ftee1zCV3yaU58ss1mKjdR6umVAM+zfD0Yne8jTsvIMC+oA=
X-Google-Smtp-Source: ABdhPJwyRTj0s1+saGAx8WNaaCprsPHHvubw89pvw066oW08StFohD89+Hl+DLAXm0cAk1PosU1BK9VW4SE6vINxEtQ=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr5827542edb.175.1638856844186;
 Mon, 06 Dec 2021 22:00:44 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh7bpqhf0.fsf@gitster.g>
In-Reply-To: <xmqqh7bpqhf0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Dec 2021 22:00:32 -0800
Message-ID: <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
Subject: en/keep-cwd (Was: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 6, 2021 at 5:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/keep-cwd (2021-12-01) 11 commits
>  - t2501: simplify the tests since we can now assume desired behavior
>  - dir: new flag to remove_dir_recurse() to spare the original_cwd
>  - dir: avoid incidentally removing the original_cwd in remove_path()
>  - stash: do not attempt to remove startup_info->original_cwd
>  - rebase: do not attempt to remove startup_info->original_cwd
>  - clean: do not attempt to remove startup_info->original_cwd
>  - symlinks: do not include startup_info->original_cwd in dir removal
>  - unpack-trees: add special cwd handling
>  - unpack-trees: refuse to remove startup_info->original_cwd
>  - setup: introduce startup_info->original_cwd
>  - t2501: add various tests for removing the current working directory
>
>  Many git commands that deal with working tree files try to remove a
>  directory that becomes empty (i.e. "git switch" from a branch that
>  has the directory to another branch that does not would attempt
>  remove all files in the directory and the directory itself).  This
>  drops users into an unfamiliar situation if the command was run in
>  a subdirectory that becomes subject to removal due to the command.
>  The commands have been taught to keep an empty directory if it is
>  the directory they were started in to avoid surprising users.

Very nicely written summary.

>
>  Needs review.
>  There are some comments on earlier rounds; the latest one needs a
>  serious review or at least Acks from past commentors.
>  source: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>

If it helps, there are two parts to the review:
- Do we want this feature?
- Does this patch series implement the feature correctly?
Let me mention both:

Much of the discussion from commenters was actually related to the
first point.  While Peff suggested the idea, and Taylor and Phillip
(Wood) spoke up in favor (and I obviously cared enough to write
patches), =C3=86var didn't like it at first.  After a lot of back and
forth, we eventually discovered some misunderstanding after which
=C3=86var, while still not a proponent, dropped his strong objection ("I'm
much more sympathetic to this approach now."[1])  I was unable to
determine the opinion of other reviewers/commenters on this point,
though if I had to guess I'd say Junio is at least marginally in
favor.

[1] https://lore.kernel.org/git/211129.868rx6g0e0.gmgdl@evledraar.gmail.com=
/

On the latter point, several folks provided useful suggestions.  I
think I have addressed all their feedback so far, though no one has
explicitly verified that.  Further review and/or acks to verify that I
have indeed handled feedback to others' satisfaction would be welcome
if anyone has the spare time.
