Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87EDC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F1F64E5C
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBWHh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:37:29 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:33274 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhBWHh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 02:37:27 -0500
Received: by mail-ej1-f46.google.com with SMTP id jt13so33128528ejb.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Vt6Dea7h/WJOOo2+gLeyQDinOhxXKP0TkdZtw4ue+k=;
        b=SjK6/Sd4cMR/bBUmqtCHfdkzRTE12zh/mrtvKxNwngZxsHjMb0b7agyWW2ASs14cct
         PqkrFJpAyxBTxyiQnN5qLHd+6ueC+sRZ3J6iga/sBkt3ab7SEr8BWIaHPYud/zeHHabb
         x2jAbhSinxchdl95zjWuxNyB8LARDqIQGhYkIvy3Ywd36Q/qeP8GKYRkbZzsS4fh82Tb
         ewnIT54atVh8Lj8QOR3opfa3ZgJgdNMf333gy0A40fcVIWJo98qSyaOMcsVi7sEb9Qm5
         8Hg4c8Epn0xhfWhZgegQmNqemQWCXvys1q8m/Z9X14sZ2QiUKrhhMnCoWXhZlfDK5slx
         heVA==
X-Gm-Message-State: AOAM531GKYIOrb+C7eZ8NQEky+v2oGNBmjaT00iKUcBPSbQ6A3WlBIh2
        /9QP6w/PQNm2ffAIPAMfXlUtBKulwoQuxvazMag=
X-Google-Smtp-Source: ABdhPJw5xRDqh4cLv5oxxL5V9wkk8Lkcr0PYj1xCR2qSyYP6OZUFstpTQCUjMBwI39ohmzwBGIHzCfvO/bxNXEF0aHU=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr24882642ejx.168.1614065805612;
 Mon, 22 Feb 2021 23:36:45 -0800 (PST)
MIME-Version: 1.0
References: <CABXAcUzRhkeQhVtwtx-NBR0hbkoo=aCTwN464Dsj8680GPMDxw@mail.gmail.com>
 <CAPig+cSvYLMtML5ya4GR30-nfNNt19okLjchkkdhdzAEB19H4g@mail.gmail.com>
In-Reply-To: <CAPig+cSvYLMtML5ya4GR30-nfNNt19okLjchkkdhdzAEB19H4g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Feb 2021 02:36:34 -0500
Message-ID: <CAPig+cTGe1=uqLw1Hxe+5=0WyWEJCOaqHEqLkuYmgR1pG+xVOA@mail.gmail.com>
Subject: Re: 'git maintenance' won't work on bare repos
To:     Clement Moyroud <clement.moyroud@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:03 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 22, 2021 at 9:02 PM Clement Moyroud
> <clement.moyroud@gmail.com> wrote:
> > So the proper solution is to do it from the bare clone itself.
> > However, 'git maintenance register' silently fails (with an 0 exit
> > code). There are two tell-tale signs:
> > 1. 'git config --global --get maintenance.repo' returns '.'
>
> I have a patch which fixes the problem with the bare repo path being
> incorrectly registered as ".", but I still need to create a regression
> test for it.

Patch posted here:
https://lore.kernel.org/git/20210223073107.40675-1-sunshine@sunshineco.com/
