Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E429C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C84D6054E
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 09:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhH1JrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhH1Jq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 05:46:59 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAE3C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 02:46:09 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id m39so4870817uad.9
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPrc6/vH5A4Xci3aUvOYhtT+sXX6DdCiAUfZYOzuocE=;
        b=sj8swvZVP8XMfEsgLECcXVH4P7nCp2nT1DWnVKFqTTFecoIUDyCx5ptdl12H45oemE
         0b/gh6d26wZZT8+metkzpQWH4/EFjuhAM9TXIbOfRwvdHlZW2vaiDtknAHCD0TFly3xC
         S15ugcilQB4DqEH3E13fBixMXt9zuSZwTAMB7J1fXDNIZJ4Jq5BAoucQsTXA/CL8V2SJ
         ZQQvZSoCOrTEFo6JCgVTw6nEFH7vFATCpc61N4prbTAJY+wRPGl0vpLGeX43ApoKUx7b
         687DcMKUT9BDt6XbrmLoYndD10foABN5Nqv60FAmulUjX9YuG23cQIVikVHLcDZXQsOB
         d2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPrc6/vH5A4Xci3aUvOYhtT+sXX6DdCiAUfZYOzuocE=;
        b=apeDv/K2LUMxRYby9UbJXZNZl7Eo891+RcirBwEa1dZnV62ZCZ2NsWrqrAh/AZmcoO
         k/62uPFAjsgDaUfiasO0WOtTKkqYG4bNZpBgGF32KjBRdQQ62lfVEEJb7m9FSj08VzRI
         wZvoxNXqDON+u7wsf78AbRtP3IR/heV1rn5jy6abCE4TxRi1OoTMf4Sn8WF0UXlRNdYv
         ig6K1948a47xIlJcbdQtBN/uR7XDsrA48qpvEOE49l4iPG7NreW24VmOV1451bghyLf2
         iptohZuj6rChp6PPH03hKFh3jVkmQaQl8oiRf+/8acMjDNFfizRzu/dVZfIs0gsjedjG
         UtWg==
X-Gm-Message-State: AOAM532S0iXVLKUmQ8h3UA3LnyURB5AOD/mzsrfFcDYDVTaJpuzxGp3a
        5qW9V8ikFJ+vxMOgtXc5+e8OYk1vedoC/56UjfixnjLsd6w=
X-Google-Smtp-Source: ABdhPJyYL4UHnrV622C24AZXJtwy1HlBh4fD8OvCyi2L3mlhnWWZJXbmt9TNdd9bTjMXFp8c7lU2xsJDWS+8yvX2VYw=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr10583772uaq.15.1630143968703;
 Sat, 28 Aug 2021 02:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210809063004.73736-1-carenas@gmail.com> <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
 <xmqqpmumftry.fsf@gitster.g> <b554c82a-4da1-9676-4d93-b769ab6bbcbd@jeffhostetler.com>
 <xmqqsfyvbg8m.fsf@gitster.g> <CAPUEsphe0N6w_qCTAp46YPH7vBj2dkJa9kOm2HaixkFkVuk3GA@mail.gmail.com>
 <xmqq1r6ebyo5.fsf@gitster.g>
In-Reply-To: <xmqq1r6ebyo5.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 28 Aug 2021 02:45:57 -0700
Message-ID: <CAPUEspgDbi1v32p+H=afZSDVOo_VpJzKn7bU8_s+fPJxm=mtBQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 10:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> One thing I noticed is that simple-ipc.h can disable itself
> altogether with "#ifdef SUPPORTS_SIMPLE_IPC", so the unconditional
> use of "enum ipc_active_state" by fsmonitor-ipc.h would still be a
> problem.

That is why we also need an additional patch[1] to be able to build
(at least in macOS).

in windows additional changes are required, but I suspect that
configuration is probably not expected.

> fsmonitor-ipc.h is included even in help.c so it seems
> that with this topic, you practically will not get a working Git at
> all with -pedantic when SUPPORTS_SIMPLE_IPC is not true.

not sure if I understand the logic here, but there is a "mock" daemon
that is used in the platforms that don't have support that will be
available then (even if it just refuses to start), and that is still
IMHO a working git configuration.

Carlo

[1] https://lore.kernel.org/git/20210817082310.2157-1-carenas@gmail.com/
