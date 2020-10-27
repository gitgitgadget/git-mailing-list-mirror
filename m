Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2080C5517A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 04:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913EB217A0
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 04:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTKDEThI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505565AbgJ0E5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 00:57:18 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:40705 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505562AbgJ0E5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 00:57:18 -0400
Received: by mail-oo1-f66.google.com with SMTP id p73so29425oop.7
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ry30YJSkeBYANLb6mKvIEIuJOP9XQk7nmB5LAy6Prrc=;
        b=jTKDEThIpwFlOc8nshuyv3AiJgpE8GqOwNjOnfBZJQwYcu27NAFUw6bv52bw4cS0SI
         rMdJF6xZqIUtKArSduAS2RirvvkFB6L68AJJBlBvajJCmwjdTStQhI+W0o8RbllzMREk
         K4JoJa+KbDgXGvhCB02QgZLURqbt9r16Ihu2Zf1i1HrHNOl2ZXp35W7k3Nt5gIcAIqKa
         fR2lGMBs7SnttbsET3z0rqiJo4KJZQQgB5W5Wh/Dq6AkYWs+wUtZDTMJ6DRq8LBT87Qv
         zWW4jZMSw8gU73rZmJwt39Al20TCrz56yBSj4jG6kCpS69sAfXZgRCT2eSl8rwwcy/zN
         JVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ry30YJSkeBYANLb6mKvIEIuJOP9XQk7nmB5LAy6Prrc=;
        b=WGDMES7B9aSlo8OOcqHxXNZH13Us4ifFFp2qOLhaTXuc+PfCBO1tmCaLv/gvTV5RRN
         w+5l+R9o1nJISTwue5QKUOr87mvYuvw6KCf2oN0G3wEpZhp0hNvMmQPhCQh/FEGCzBw5
         3M+TfDk5AAVRnCvb2rmyYoybnDfFdPb/w3p0Bw1nOzHND5hjmAge79VkKCcyvGlNRUaY
         Ygbsd9etSKjjkrR5fggPFZvAMp07tSzofqGnihKBtdKWJDi430Dwps4OgUyIVrInoWw7
         AABGf1CJI4EmJ/hgpcoOQN6XpW+BcH2jr97Y9ifcPZvCovf5OOcmw6mmC/5tPLQslk3f
         OFwg==
X-Gm-Message-State: AOAM531kyUtmVNgXjqijbCy7uJhBQveIA7VzCvgILa2jbYDUHzXvWIsE
        gbJYOtvd16KoKoJNz8BzE7lriMVp29aoGnt886o=
X-Google-Smtp-Source: ABdhPJzQTXOxHHed/0xo19hChSmrmy6vBNERKtrLdLAl3Q16kVZrJO4P5QD6FLWP3B8OMa7tAk8/PUj2bChQ73FizaQ=
X-Received: by 2002:a4a:9806:: with SMTP id y6mr308956ooi.45.1603774637445;
 Mon, 26 Oct 2020 21:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
 <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com> <3357ea415e3437966f15bf73fbbeb21cda3df592.1603764490.git.gitgitgadget@gmail.com>
 <CAPig+cTkxP=aaCi8YrxbSYptkgwSYG_sd+P6FiXmtA6xuXxGSw@mail.gmail.com>
In-Reply-To: <CAPig+cTkxP=aaCi8YrxbSYptkgwSYG_sd+P6FiXmtA6xuXxGSw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Oct 2020 21:57:06 -0700
Message-ID: <CABPp-BEGG7GYH=1dWnC_vxQimB07xPAQHWYcL=yk3rcYOk5SkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] merge-ort: barebones API of new merge strategy
 with empty implementation
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 7:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Oct 26, 2020 at 10:08 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > + * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
> > + * as a drop-in replacement for the "recursive" merge strategy, allowing one
> > + * to replace
> > + *
> > + *   git merge [-s recursive]
> > + *
> > + * with
> > + *
> > + *   git merge -s ort
> > + *
> > + * Note: git's parser allows the space between '-s' and its argument to be
> > + * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
> > + * "cale", "peedy", or "ins" instead of "ort"?)
>
> You forgot:
>
>     git merge -s newren
>
> the "NEW Recursive ENgine" merge strategy. I won't bore you with some
> other backronyms I came up with[1].
>
> FOOTNOTES
>
> [1] Such as "Extended LInear Jump AHead", "UNabashedly Smart High
> INtelligence Eccentricity" and "UNsurprisingly SHallow and
> INsignificant Exception". Oh wait, don't read this if you don't want
> to be bored.

Haha, those are great!  :-)  Maybe we should come up with one for TUFF?
