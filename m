Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C0BC55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57903206ED
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4lfx8+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgJ2AqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbgJ2Apd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:45:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A24C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:45:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t3so908631wmi.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vcrjSbJKder3d8GNRcIaeopJM3iPjISoijvmDWzaGZU=;
        b=H4lfx8+L47yzPvsKYA2tRbTBuoeGwokjhZyyelg3wRg0kNP0N8T6o1eCbR4rSraSrP
         pIndzppuv4b52pC3+YQQpJ3woG5VfaHLLu8IhyGkbL+TgztznZN0MzKfqQMr0+ra+6mp
         UZAHAiCDvy4v9SD4Of3vhS3aNAKhDg2Tng+m75Zu62xphzLAZR6PoEkT+iaX3I8LXMdY
         +DCC7Gaf8h7p5B529+yjYSToxu27EsRvkYPWUtaXHij0QoOztx2GqpJmatowZ3eSvsXq
         iM54Hkm/iWCrbsU3UsH8wK8vsYlL/MxqJftPvaL2OMNDx5Yf8qP34h2MaJxUt5ez6m48
         ZkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vcrjSbJKder3d8GNRcIaeopJM3iPjISoijvmDWzaGZU=;
        b=h2mP+IKxCaHG0pwhz7G5h8s9ikCjE0vUAL8imz10sWXP2BFAarvS2IHmErn8Hlyb5M
         QwwfBsnT/oax1tigdE1kNPdQjp4wYLX3ILqqUgX7VLcwpzUbn0wgoYEkg7cQVISEiqr2
         IwBnPNZYV69sS3VjdkRs7AK/qZ5pQSgyu0IN8xY+AE7PXANcsjvEpnCa29p4NSGeQ0sy
         SGjD89gh/PfONc4sZqMdM5juwF4b2mlFKgaqarRDPwriwVgl9DuYzOPfFu15YRlPvYV2
         8oLBTdFd3wD9D1JIrzuuRACZr1Of8k3NJoVJtAvuBZjPeWU7WLEcsdZ4UMqIKk0KB+NS
         7lYQ==
X-Gm-Message-State: AOAM533jO+OD1fynzuO9i5Flai3Z3z0+vsFCdVxZGIbtGqKv6sYqdack
        y1hL4/RNA8Hlf12y7gULo5D8MWnDg2v8amgv8cmVJY2hWWewVDlF
X-Google-Smtp-Source: ABdhPJyY+23OhCTaJDWxUjj9PQZ604DIrVHnN9yqWmSHc8eIunbEcrkqb6FuenmFJQAjPxHrQ3p5/0OAP1b08598V4c=
X-Received: by 2002:a1c:4604:: with SMTP id t4mr5558443wma.48.1603849511054;
 Tue, 27 Oct 2020 18:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com> <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
 <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
 <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de> <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
 <xmqqwnzbbfsi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnzbbfsi.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 27 Oct 2020 19:45:00 -0600
Message-ID: <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>, Stefan Haller <lists@haller-berlin.de>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 2:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =D0=9B=D1=91=D1=88=D0=B0 =D0=9E=D0=B3=D0=BE=D0=BD=D1=8C=D0=BA=D0=BE=D0=B2=
  <lesha.ogonkov@gmail.com> writes:

> So,... even though it may look to more experienced zsh users that it
> is unnecessary to document it in this file, in your opinion, it is a
> good idea to mention "compinit" to help less experienced users?

The first time you run zsh you are greeted with a configuration dialog
that includes this question:

---
The new completion system (compsys) allows you to complete
commands, arguments and special shell syntax such as variables.  It provide=
s
completions for a wide range of commonly used commands in most cases simply
by typing the TAB key.  Documentation is in the zshcompsys manual page.
If it is not turned on, only a few simple completions such as filenames
are available but the time to start the shell is slightly shorter.

You can:
  (1)  Turn on completion with the default options.

  (2)  Run the configuration tool (compinstall).  You can also run
       this from the command line with the following commands:
        autoload -Uz compinstall
        compinstall
       if you don't want to configure completion now.

  (0)  Don't turn on completion.
---

If you don't turn on completion, the completion doesn't work for *any* comm=
and.

I think most users would understand why git completion doesn't work if
completion doesn't work for any command.

> In any case, the patch in question is the only thing in flight that
> conflicts with Felipe's 29 patch series, and the change to zstyle
> line is common between both efforts, so it is just between adding
> the "autoload -Uz compinit && compinit" near the fpath=3D(...) thing
> or leaving it out.

I would rather leave it out.

If we add this configuration, I would do it in a separate patch that
includes text explaining what that line is, and why it might be
needed.

--=20
Felipe Contreras
