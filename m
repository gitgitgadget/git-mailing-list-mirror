Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42528C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 11:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiCAL5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 06:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiCAL5s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 06:57:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80E93981
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 03:57:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a23so30980220eju.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 03:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MBJo7SRNltLSn0hVrhJpx7r+C0/MF2pRG22+vkaOjHU=;
        b=6Vm0YI1UJj/cd661wL7s2IWgR6mZeE9XGpnK3rMUZowlPVLcVf179i5u9fqcxdKdE1
         R9alnLLA2qqpexWNny5qwT9qm7owOSxBnfE9N/+RGcOvYHOs0unm850J+Volzpcj8dYg
         VcNXTwOp9vEfs9b1kB8EpCt7Eexze0Fh4HsmXDiMCt1AIcwRjo/gN+cgEMDoM+GKJMJu
         uDG/jefjYrUe6LqCwkMuR7HptSOD4Rq+MT7P7K8lKPeNJss8BNqLLV529VdfglYrkIos
         Dkf47tA/gUNwMKXvwlIlywmj824iSw9dZ43+M9KA0pbIt3eYEjQ8qxV2T5XAMCVCdnOm
         tDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MBJo7SRNltLSn0hVrhJpx7r+C0/MF2pRG22+vkaOjHU=;
        b=iRrkKXoophDV7HiphDQ+CKEOWAJjowOZulixV3UvHGtFFl5pc/aAYOXOz88ruNAh/D
         2mw/Qz3ZPWWFUWf0bb233BIBcHu8XGfos9trm3s5xkqk1yVQI6Dhza7X+0uAWFUcUMTf
         pjq4bje5LPslszQjUM9Ve6xDgTc5Gkc3++UAjVZ9g1vMcnWCKqs88t4ZO/KL1Mhfo2Mt
         DETp7NgAKniZuCOe7MfcIf66lAACfxWY8E78t7H9fFc9UEJRpS+CI3uc028B+dPrVlqu
         royJQ/CVsqMX+ZPme7J2FF815PyCZZsYm34WQ2rytjQr4GHClW4gPfS/H1kVEhaJBicX
         kLwQ==
X-Gm-Message-State: AOAM530NlT+GuIOzgLuiXaIznkAMVidnz9L8FFM6k6V6kwyfw1wmympT
        EXYlAvJxMOWMfXQJPFXHVJCGonBH5NdedW1V2C5/bQ==
X-Google-Smtp-Source: ABdhPJwSN9nhadbGq6Fd8uQceZ9D71GrKJO1KaRK6xGa9rUHEdWwkWEqF1EFvoORYaB2tNAEfzDGTsaPf2ew330Aozc=
X-Received: by 2002:a17:906:ce23:b0:6cf:7203:ded6 with SMTP id
 sd3-20020a170906ce2300b006cf7203ded6mr18281494ejb.170.1646135824871; Tue, 01
 Mar 2022 03:57:04 -0800 (PST)
MIME-Version: 1.0
References: <xmqqee3q73e1.fsf@gitster.g> <CAPMMpojgTcp7qGmpK0vm8_WTOaSJ6r=NBa3sEO0EC7XRBF_dXg@mail.gmail.com>
 <220228.8635k35chr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220228.8635k35chr.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 12:56:52 +0100
Message-ID: <CAPMMpohJsZahwzhstoqxPZz=UbJ_7+vrUQZbk0DOrGFJ4Xq-nw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2022, #07; Fri, 25)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 2:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
>
> Perhaps something like this:
>
>     The performance of the "untracked cache" feature has been improved in
>     common cases where "--untracked-files=3D<mode>" and
>     "status.showUntrackedFiles" were combined. This change benefits Windo=
ws
>     users using it in conjuction with the "fsmonitor feature in particula=
r.
>
> Perhaps adding:
>
>     There's an obscure case where the performance is now worse, but it's
>     thought not to matter.
>

I really like it, thx! I would change "combined" to "aligned", and little e=
lse:

   The performance of the "untracked cache" feature has been improved in
   common cases where "--untracked-files=3D<mode>" and
   "status.showUntrackedFiles" were aligned. This change benefits Windows
   users using it in conjunction with the "fsmonitor" feature in particular=
.
   There's an obscure case where the performance is now worse, but it's
   thought not to matter.
