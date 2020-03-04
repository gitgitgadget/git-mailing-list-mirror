Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE1C3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 03:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65582146E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 03:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUC57fuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgCDDbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:31:48 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38784 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgCDDbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 22:31:47 -0500
Received: by mail-ed1-f42.google.com with SMTP id e25so545549edq.5
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 19:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAh6eGUxGL5eFgVN+GlSa/7/WUmLkGB2hvxZamlJp1Y=;
        b=HUC57fufdmgiyHGS0/l138DV0AB3KC8XJdJVMc95ImhtRFms0fCPdV4xFbBfmwkgU0
         K8v9a+THwb0OZqWOqUaNT4Z1B7DXv4drPRYv+kuzxePypgxjdiVBFJN4z7pDC2QkR9im
         MsDKWCj3YmmJLHE7FfHmlNHQt4Jyd1V9Z+A5vmQiT9w7uhF8ERp90+oQWHbYeROF7cD8
         Rscp7D9IIIt5avKTNY7Up9fQ+TanK6z2Oz9+oF1uvsCyQ3IvMqFUGbiVVyQdXonreei5
         cTeWLBi3+ucEZdZR0QKuGTaaxu89TAfEpaTs14dGT7ukpyGxalKlVYJ4ELhybhjG1MAs
         iY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAh6eGUxGL5eFgVN+GlSa/7/WUmLkGB2hvxZamlJp1Y=;
        b=bHYDQ1RS33/u9KsKwbchfUP3Cm/3HPg/bsHWXh2MQdSdAftPehWguNvMlwqXe0/rwC
         nbuMoNOuOR1JsWwUijaueEEzbZ/5bUQkpIuQ4ec1s+uzwKJwJ0HX3wi6oKbJyASUBDlU
         Bk/VjGiWmdw8WDhsjbrfZJo5LIuzeT++Jm6wHMBNzP/xiflA3vBuNXQXwS9QPkvOj4t8
         uyvxRpUG7FdorlvJZIdd8Bd9V/zBYBkGx0QXrNtRO0DXLJr9aqUfJF+KrMjkcrMVu7/B
         Q/byehB9hifzyJU7uaYpjS/ejNzarGqy3gZcz29LriejMGNxyfVJrthM5DkGTZssaO1g
         oK7Q==
X-Gm-Message-State: ANhLgQ1uEmKKGpmoS8Lb6qJHV2Fwrq0YbiJmzlJ6XYXUAOEA6Ti/Awrt
        ImJT0qjFI84xKnd/PW6Z0o0yCPsSm3+k8hvPS0A=
X-Google-Smtp-Source: ADFU+vsIBP2sJo9nYlkIeOicJ3hAVo8zOW3r54xzCUTlw8RMblGZIrGY91DJoM/C4RiXO0O13gj9m5AbrbaRvuAZdPY=
X-Received: by 2002:a05:6402:b9b:: with SMTP id cf27mr765948edb.188.1583292704643;
 Tue, 03 Mar 2020 19:31:44 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 4 Mar 2020 16:31:33 +1300
Message-ID: <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * hw/advise-ng (2020-03-02) 5 commits
>  - tag: use new advice API to check visibility
>  - SQUASH???

A local change that needs to be squashed?

>  - advice: revamp advise API
>  - advice: change "setupStreamFailure" to "setUpstreamFailure"
>  - advice: extract vadvise() from advise()

Heba
