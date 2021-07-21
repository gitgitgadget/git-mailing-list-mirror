Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EB8C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C00C61009
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhGUUhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhGUUha (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 16:37:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE16C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:18:06 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u15so4389717oiw.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fD6rNItE2lFWjtg4dd3ql2qcAyqGHYjARfhmQIuHxPE=;
        b=EbG2nlTZ0zsnmx9f4nfIGHWucAJI7eInLDjZKZ0O5Arc3wPnk/OMWPq18/VyBYXjNE
         PYbsaej+z7ZkfTs6t4HTZP8LPh+Aivh/KeaDaLSsTTannWlvzAcEwGGJK9qN3DBcxhqp
         PP80LBzOD3hb5frgo77i9xhrz1bMAZYnjpfruTqy52HEICf8Y+o+c9TGiZR/Q977d848
         +s5FXklldGG8H7384HElOYc1inKfge+/3EjAIVO1bZb8JhAqJYz/EQr1BbyGzmh+q8ed
         /ILwgj7ClT6MOldX/v6h5SxPwKoTrwoTHgtto0fdO9lYs2EC3z1EXz1lSun2BrDJJ7Dg
         HWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fD6rNItE2lFWjtg4dd3ql2qcAyqGHYjARfhmQIuHxPE=;
        b=k3MhJKy/piW7wbjUpoAGPu4Rxb4jX6Ac1ECCZ0GDhPjPiz8s1vHTtplb6q4qBybDkU
         xUqLMiYEpj7lxHORkbQYEZ3kx5FXctBbiYvF8uBsKfSh01ZPNz63gvsYqmmThgIpbRlw
         Bl4SZwfXKuTjXq4eu+Poa3mENLNGzRgwhie5TSvry4OQDc+QXiNC8dNrVtfK4PFCtZ18
         iSZkwTywy3Geq+B0+4oWZ2QFmks3MUoK56QZ/WqbY4hP9L090OeGo+EnWMXDzbaKyNTs
         3nyzaKNatfms1TgIWJ2A3XDsO9vJkHKTOd/pZnFHawCZW0cW/azzA1jIw+7Mc8ijX48e
         T0VQ==
X-Gm-Message-State: AOAM531NzCnX1ueuA4MTnpWMIb17C9lingbg1wO6ZVEP02NdGjw1heTm
        Kq3GH4RjqrGCLZqBOyNi/Bc=
X-Google-Smtp-Source: ABdhPJxvua5oc1ZP7tVDfBUe1QBzNOLFwyMBAmbvHqKIZn5watWWcV5bAZFcBUBU5LyZ8dHoBbwTWQ==
X-Received: by 2002:a05:6808:1388:: with SMTP id c8mr3812800oiw.68.1626902285613;
        Wed, 21 Jul 2021 14:18:05 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l17sm4960731ota.20.2021.07.21.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:18:05 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:18:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f88f0b8776b_1c9e6920863@natae.notmuch>
In-Reply-To: <5f334459-26ef-6bf6-d72e-31564b10cd2c@aixigo.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
 <1a821d3b1ddf22b62b14d3b573015c3d8c90e2de.1626831744.git.gitgitgadget@gmail.com>
 <5f334459-26ef-6bf6-d72e-31564b10cd2c@aixigo.com>
Subject: Re: [PATCH v2 4/8] pull: since --ff-only overrides, handle it first
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten wrote:
> On 7/21/21 3:42 AM, Elijah Newren via GitGitGadget wrote:
> > There are both merge and rebase branches in the logic, and previously
> > both had to handle fast-forwarding.  Merge handled that implicitly
> > (because git merge handles it directly), while in rebase it was
> > explicit.  Given that the --ff-only flag is meant to override any
> > --rebase or --no-rebase, make the code reflect that by handling
> > --ff-only before the merge-vs-rebase logic.
> 
> Great. That now will work as I would expect it to.

Yes, but what about the current users that have setup pull.ff=only
already?

They are already relying on existing behavior.

What do you think users currently expect this to do?

  [pull]
    ff = only
    rebase = true

  git pull --no-rebase

-- 
Felipe Contreras
