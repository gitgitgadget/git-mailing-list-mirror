Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE9C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766B520BED
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 07:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgLCHqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 02:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgLCHqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 02:46:32 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F3C061A4E
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 23:45:52 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b62so929940otc.5
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 23:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2EIYU4ACxkZM6MmsTT59kt2PAUN/h1k0Fx/T86XKy8=;
        b=ZmRx5wvWIhGJONTfGTuD8VkCdieCrS43fro+nG4NROhkXPgyLSBKL5AWcyFovlZ9Lz
         QoBhb2hhpw+1LsG5oC8xbbKTd5dVxlEAwrKlm8DRzyuQpTfSitwtV5aoPeEn4MXawNYF
         /YdidojQF9pd/s3ibB1suDRE2eEy3yJOJwzRUON2klgi/VYQluSKRhg6ffHBAXuSvkkW
         UV0csMLHjq4M0D/3XSCgDEYeXaTes8NpBimHUL3N2hU4caxq/6u5BiFIQA4gewVHc2LC
         yBB/IPa8lNZzKajjOzmqecCp+6bftcadTRKO07p/58jblAmiojZIhQUUWCiqZ1QihOjL
         aalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2EIYU4ACxkZM6MmsTT59kt2PAUN/h1k0Fx/T86XKy8=;
        b=ZEQYPSDKE8bxNCRl3xH/VVLdavYdoKH4yG1/WbRrQtlYkVfE/5U9Ib0lYhgPHM3Y5+
         0CRABOnI4Q8IacyeEa/vb7c9dzZNkdBsnhCpcoMz3bUYcMN7DISSo6cLpTtEuMzZH6ul
         hXGaNjtzCaIY/guVV0f7gKzJ4SAB4/bLGam+b2EHHFdarAz60sHuv73al1tDpxLVQLm8
         zbdUmtJ8O/elXHARjYlaEF3tcYFq1eR9oVQa8fWNixW6H47VypwiLzNuMaj56gnDS4ac
         aE3rgWCT9Wv4YO+b2Q7PfqsEkRgEwm2Ie+rmqbnbtf8KToP6mLtpHw/IoXGUQtvdeOw1
         DFbA==
X-Gm-Message-State: AOAM530FFUPW35ERXs9K6cdeaAjhaud4FXdtHSQT+Aik5N7N4xQH02po
        3CGVd9Kpga3tRpnZs0oi3xXTFeXuzIqjMUj+g1V/zTpa0pg=
X-Google-Smtp-Source: ABdhPJxyKCIhPA9w2SQ9i+l3A9PLpPi2cJukOWd4BF0e2LuAcciJ+etNTS07oo+zsGSoXg77FDTVQlaN9KuCurtxYx8=
X-Received: by 2002:a9d:3a76:: with SMTP id j109mr1253426otc.186.1606981552058;
 Wed, 02 Dec 2020 23:45:52 -0800 (PST)
MIME-Version: 1.0
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
In-Reply-To: <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Thu, 3 Dec 2020 08:45:16 +0100
Message-ID: <CAN0XMOKEG9HLuzf9ZRXyUs_uHTXagyCdghtP98rLVoPj_75UYQ@mail.gmail.com>
Subject: Re: BUG in fetching non-checked out submodule
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, peter.kaestle@nokia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

Am Mi., 2. Dez. 2020 um 18:20 Uhr schrieb Philippe Blain
<levraiphilippeblain@gmail.com>:
>
> Ok, you don't add '--init' but the submodule gets checked out,
> so it looks like you have 'submodule.active' set to a pathspec
> that matches 'sha1collisiondetection'. Did you clone the git repo
> with '--recurse-submodules', which would add '.' as the value of
> 'submodule.active' ? Or maybe you manually configured that value
> in your global gitconfig ?

Sry, I did not mention that I started with the submodule already
initialized and checked out. IIRC I deinitialized the submodule with
'git submodule deinit -f sha1collisiondetection/' and ran 'git fetch'
to see if it happens on the git repo, too, since I encountered the
issue on another repo first.

I can see the same misbehaviour when I run
$ git -c submodule.recurse=false fetch --recurse-submodules
too, so I think it doesn't have necessarily something to do with
the 'submodule.recursive' config, but with 'recurse submodules'
in general.

Ralf
