Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90611C33CB6
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 15:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621AA2071E
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F4O3zbY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAVP0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:26:46 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45591 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgAVP0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 10:26:45 -0500
Received: by mail-vs1-f67.google.com with SMTP id b4so4375332vsa.12
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3pgsvT73lan+hdL0vfY9qTR1QZQW+lVlxd56DUcoUA=;
        b=F4O3zbY5NurklR9oSHO9yU/FzJXOSZtokUIN0P+KqX4/72PbWfWnwMYTBJUBL0lRpI
         SHlz6xIt9QMIsMYp/3O1apvCcJ2Tt18x3M7gR7apFpA/32bWz4pc98CUm9ZvLltFLvQO
         /zg8YVSvaWq8TyQ2YUzi49SrXUGu0Mf0tR25RmmcQTfAI1ldCXXqWvlYO7BiuP3M5byq
         1OfTD3pwZs/x+U9cJnbu+QK+h9G2ARMoa5/gLiMmUZz4itfQhhxZF2M6X7Gbg+T12liJ
         IGn7nYPMm54N7geEV2yuL39ca/m1JNnm16qwrgC29IrFkQNGap3Z+oa4+SfMWWvX3wSa
         eEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3pgsvT73lan+hdL0vfY9qTR1QZQW+lVlxd56DUcoUA=;
        b=jjBxk/CTQHfRmPESimBgbnyCANkvWEkX3th9EjAhAx7AhSApmnojMPxThZHlaBEeH/
         dLlvKnbbpH/iO+vX8jDRCxmci0FxHXXpDTcS+Ymm4QzQ442nZiyP6SBkpSH1GOcIUXZg
         vVOdPKVOGIoAWYU9+OtIrvz0onK1EYxYCmkzpY4Ci6PVTC1SUfk9cS/59owVeeRE7zz3
         DePVrt5cevpIhLKFlipXl0Pz00CMLe04N/Nf1ZmTlC4E0D7RhMFxyAzy5VuvYhjsjouf
         KDHsxgySnqZYdIElv4vSc43w10UYvbcyagY8ZN6NLNmBf1ReM6+Ka/rryzNuQQk9TXvD
         F8ag==
X-Gm-Message-State: APjAAAVhfwjvmMw4QYil2bE8vbYcSKwCcvUbQ/DhydRaeJCqmJxfkj2H
        gjMBdjXx8Cr8FIy/j3YXdk/hgRnh8U3ap0j6ZGuekQ==
X-Google-Smtp-Source: APXvYqxh9Oz9QpcdcVD+KKg85Zp7YK4GAh/ICQmqUWu3Z3OX1+KcxztypTGLbljs+G7eoZSBrM1Yt/dZjv/NwmUvu08=
X-Received: by 2002:a05:6102:7a4:: with SMTP id x4mr2858563vsg.85.1579706804104;
 Wed, 22 Jan 2020 07:26:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
In-Reply-To: <cover.1579598053.git.bert.wesarg@googlemail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 22 Jan 2020 16:26:32 +0100
Message-ID: <CAKPyHN3=pw8qiL_jut9Say7qz54ceR0hNCNoJxbzJyR73qCBGg@mail.gmail.com>
Subject: Re: [PATCH 0/7] remote rename: improve handling of configuration values
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

I think 'git remote remove X' needs similar improvements to
'handle.*.pushremote = X' and 'push.default = X'. Will be handled in
the re-roll.

Bert

On Tue, Jan 21, 2020 at 10:24 AM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> While fixing that 'git remote rename X Y' does not rename the values for
> 'branch.*.pushRemote', it opened the possibility to more improvements in
> this area:
>
>  - 'remote rename' did not accept single-letter abbreviations for
>    'branch.*.rebase' like 'pull --rebase' does
>
>  - minor clean-ups the config callback
>
>  - patch 5 will be replaced by/rebased on Matthew's work in 'config: allow user to
>    know scope of config options', once 'config_scope_name' is available
>
>  - gently handling the rename of 'remote.pushDefault'
>
> Bert Wesarg (7):
>   pull --rebase/remote rename: document and honor single-letter
>     abbreviations rebase types
>   remote: clean-up by returning early to avoid one indentation
>   remote: clean-up config callback
>   remote rename: rename branch.<name>.pushRemote config values too
>   [RFC] config: make `scope_name` global as `config_scope_name`
>   config: provide access to the current line number
>   remote rename: gently handle remote.pushDefault config
>
>  Documentation/config/branch.txt |   7 +-
>  Documentation/config/pull.txt   |   7 +-
>  Makefile                        |   1 +
>  builtin/pull.c                  |  29 +-----
>  builtin/remote.c                | 168 +++++++++++++++++++++-----------
>  config.c                        |  24 +++++
>  config.h                        |   2 +
>  rebase.c                        |  24 +++++
>  rebase.h                        |  15 +++
>  t/helper/test-config.c          |  18 +---
>  t/t1308-config-set.sh           |  14 ++-
>  t/t5505-remote.sh               |  52 +++++++++-
>  12 files changed, 254 insertions(+), 107 deletions(-)
>  create mode 100644 rebase.c
>  create mode 100644 rebase.h
>
> --
> 2.24.1.497.g9abd7b20b4.dirty
>
