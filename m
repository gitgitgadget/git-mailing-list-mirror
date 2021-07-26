Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F35C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 08:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A4660F44
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 08:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhGZIDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhGZIDS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 04:03:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CEBC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 01:43:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o5so15347379ejy.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 01:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LK5hQlBzpfUUI2Djwy1q+yJhhSRHrEu7L1aTBOXfqlo=;
        b=ueyFZKLUw0AyYT5GnOoidCKwy/wyam5cpVWZ/QrtgUCkKFkqDb8mNXobtsJmIVpHg4
         QEZzgdDIqFOPcoUKS5HzmXGvw7QffpYYt+/wyDmY+wjKIb06a26Kuejz+9I5U15ikL2c
         +KqbZ57Xd38KMm0Tuz1BN9XOz2Opn92ppSHo2w/uuusaq1ifmY3qcG656UM1QOeqU++T
         5SVLV45XlOWNqW39sGderiVQElOzLxWHTlHBYci4BwkC95FeFSzSlEih7IpD//XDaMVZ
         Dly5CWoyxqyrmFd3IX4eL4iiLz0+NmBt0hYEbzbBEgr3axozbrjR00rUwPaiog/6Z5HN
         Qvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LK5hQlBzpfUUI2Djwy1q+yJhhSRHrEu7L1aTBOXfqlo=;
        b=beuF304CD326M8dJEv1BokvjIEirOU/HTUbpEaf3rxZm0O2GlCHu4s6dCDZsA5h4PE
         Nx1biHUEy8XQPftYk7Nh4kbMNYtNhITizxno0CDLUcTAJkL6zTKH558uOkmgCozKrTM/
         +WtBEgGFm3SReB38YEHyy4q3ZQ9ztVfPHM4enxumEelvqbCCgizu6FddA84AvoG/mWJw
         9Agg++JQKquNWtv5b7f1Ap4zb5+pKcigjwBpAAbJNozAQiiJWyJmh+HHcbW3f5CvJZCH
         Ake+kwcbjqfpVjhel4SYtujp5THbbZSjR7fJLuDlvl2RmgeStXC3UDDEsac6g+IipgpR
         2YZQ==
X-Gm-Message-State: AOAM530LMrzVSIYpNJdaeJVYklcJQpT0ojEtx9eo97Qk2wNlxyHhG4Jk
        fuyrczFyZw2v60XpQ4KvmpUeR3XVVtvo6fmuQYk=
X-Google-Smtp-Source: ABdhPJySVLXk8gBlrq/EfvhIAERssBWt6UGROviqxEHZDRn2iIcz06jvwnPHoLIygeTUgfBCnWZL8K3gNzsfYppE+L8=
X-Received: by 2002:a17:906:af7c:: with SMTP id os28mr16240504ejb.341.1627289024641;
 Mon, 26 Jul 2021 01:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
In-Reply-To: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Jul 2021 10:43:33 +0200
Message-ID: <CAP8UFD3j4SpgiZ9UZOhWp7CdChpxutEyyKRb1EnXeprQssML_g@mail.gmail.com>
Subject: Re: [GSoC] A small survey + My Git Blog, week 10
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 25, 2021 at 2:22 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Hello all,
>
> Week 10 of my Git blog can be found here:
> https://atharvaraykar.me/gitnotes/week10

Great, thanks!

> As for the "survey part", jump to the section here:
> https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-workflow
>
> ...feel free to reply in this thread.

I use Gmail for email, Emacs (and sometimes vim) for editing, and Git
and command line tools, like make, gdb, etc, along with shell aliases
and functions, for building, debugging, sending patches to the mailing
list, etc.
