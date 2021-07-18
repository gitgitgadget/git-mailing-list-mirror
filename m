Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA985C636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9126D61182
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 09:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhGRJ37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 05:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhGRJ36 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 05:29:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D016C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 02:27:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dt7so22776470ejc.12
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 02:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ol45g377jMpoxMT5lLlJioN0/iOSpwXI5U36ZCgaQYw=;
        b=LtxFfyXpewFSIAy49Wz+T+fGJ/hiTKWI+vs0EtcALx7KA3i7cD/zAHSGjIYk9MrSe+
         zFCenHS835/4jORrAMzaxBCNN560SoMydZtEF88wXCPA4W12NRA5vYPVEqyhOSleucbr
         G7r8cfvKUWvEUhHHJhn7NThB8UGOuWMdX3A9Woaufa8C0mfOrtwmn+DtocSukDpY5BJb
         Uk1kP3a62OGyuR68XnaU9z0lwNKksTCAIgTUL9sGQZKQTR49wKq0ddnrdAdHrzCwhHWO
         MXKvQTdMH3w2nK6uynk76Ao99i75ZqiDMpDURY6c4wfTDhgefZUimiliD8z0jEq8b/Pj
         r/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ol45g377jMpoxMT5lLlJioN0/iOSpwXI5U36ZCgaQYw=;
        b=l5Brp4JKfpRu5sPCHEY5+9zN0MCHOszB644UQ2ZLjcU2K6vFsHSICrl/tf0P4jHIEo
         uSxQUSzKE/PVVGUhElY0yCeeevzGXK0kqs78X938rROgq0m0RRZhCJOfszmyfvYvoR+d
         TdWrvCfhG++28t9hwU2odmJAMWu9ZdJ4qcruUOwG9+pIugRwgi8Q1235FvZ2J+OpyklL
         c2CUit3NaYcM7xnGhYCe9fWsmNTrjbzz94PAaligwzfjBNMsR+9XHFzD5kX8Q5YCHcj1
         7mU4ZsamR4OeyPdCjkDcqC0qBahPYAu/qdxm4+/vZSmEub9XUWHlJpfoWBYXVOmRvuLc
         o+eQ==
X-Gm-Message-State: AOAM533T0o/czv/fhUrV8kWdKyU/U8XcokWdWpJERwpc9dhJt6lpu59X
        D1KHXtG7+sagJURWNmsRC13HXXPrysh1ioSowOY=
X-Google-Smtp-Source: ABdhPJz72XH336WVbItygabnrEsHasfe39I5X4hQOoKGE5QjpDfFBTFKHh4KYknVjTOgIp8y8I4+a1U2X+ivtakOP7k=
X-Received: by 2002:a17:906:4784:: with SMTP id cw4mr21426704ejc.160.1626600419092;
 Sun, 18 Jul 2021 02:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <CD6968A1-179D-4B77-91C1-4EECB1B69951@gmail.com>
 <f5b12a75-bdaf-fe5c-ffc2-7b4c8cdfddd6@gmail.com> <D3F13902-A7DD-4186-8444-45FD9260CBC8@gmail.com>
In-Reply-To: <D3F13902-A7DD-4186-8444-45FD9260CBC8@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 18 Jul 2021 11:26:48 +0200
Message-ID: <CAP8UFD1bGm8r_M9_gLEtSf3EAKseHySJWhMOoJjGO4xy6R2+9Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=93_Week_8?=
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git List <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 10:46 AM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> On 13-Jul-2021, at 13:48, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:

> > ... Alternatively, you could explore how other sub-commands
> > handle recursing into submodules. To me it looks like they handle it by spawning
> > a sub-process is likely the easiest approach for achieving recursion. That would
> > solve the super-prefix problem as you have observed.
>
> Yes, I was hoping I would not have to spawn a subprocess for recursing on
> update, and it does look theoretically possible--it would require changing
> a lot of of existing code to use functions taking a repository objects
> rather than assuming 'the_repository'. But since that was outside the scope
> of my project, I did it like the other implementations that spawned a new
> process for the recursion of 'update'.

Yeah, it's definitely outside the scope of your project. So it's ok to
spawn a new process.
