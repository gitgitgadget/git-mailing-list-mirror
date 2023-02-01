Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9432FC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBAWhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAWhv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:37:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F7A5593
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:37:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h9so11376086plf.9
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zj0JWZzdYYU+PmA2az4xETOaQhdVJTLto1tuNuWZqeg=;
        b=dgfTxbWoiE6YFzHd61HJu6MBT6/vUmgupd7wALhFYgdO46EhNcl3OPvrRm1mGlXytg
         66B0S9yhbMcWEh/mT+hi1ibPZo4zLxhhI3QxhzVMYsrLZZGR5JwPe/yCgRcn24KomUsH
         /HW1ZPschKPOCp5QEDuAXU/+dkNqbk+QuSLfITjm2kxbDKxSuSyVcil/AlgnRiDMcEkJ
         cjX0Sp7+VzdxnbB/JHAoo3/JzKPYPTo3M6Yb1y8w1NVf5LoG3+K/YlWPFovylZ931A5T
         oxdFmk58+HDPcQJnSWaY5qRE1bQXK6jL+MBM7+f9fxvmLC4niTBUss1Ip5Gcj1FdtRKy
         l26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zj0JWZzdYYU+PmA2az4xETOaQhdVJTLto1tuNuWZqeg=;
        b=YPDUDiumNcetm57ys90C4RoUkNrRTNkIqpYQR0O5nSlSlgKmU1AaTbWvrOEGbQ3FIT
         vDAFaYHKHwTi73AhS6pqQBqhPjGkXiFu2QzVLqrgGKlLlfG7dDEUON4HLPNJ0UeAIZMc
         5HQxdPlYvxKCx/mdxuTTPmSYENXNDHg8DTY+yaJhs/1IrYUwRFjjcSkLK308X2oD1s8L
         RHUuJK1OsKhsdQWHPje4y/8+UEcsGHk6qj01dMgcxUzOT0LeVvmaFailJzdn6AeOWVrH
         TzHsmNTBeHFN6u/36EZAbPX7Bt/IknJLDiub7hNy/dexr/IhEifmk4MQjCxSOFS04oPC
         EHhA==
X-Gm-Message-State: AO0yUKVmKJ08l9aDyeBuGNwzmqgsI+d8y7wSRNMS1EIyWaHlulMH9I8u
        tYz4BVv3+LryXMAv4Nayy3A6zocrZPA=
X-Google-Smtp-Source: AK7set/oGh2TTJTVLjYQlsrxtSIMoGT5JVKsr0C6OY6QBmvVoiyhGQdOw297ZeR8eLVVQ8gIysX0xg==
X-Received: by 2002:a17:903:283:b0:198:96d2:9181 with SMTP id j3-20020a170903028300b0019896d29181mr281500plr.56.1675291070522;
        Wed, 01 Feb 2023 14:37:50 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902b7cb00b001925c3ec34esm12167507plz.196.2023.02.01.14.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:37:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v4] compat/winansi: check for errors of CreateThread()
 correctly
References: <pull.1445.v3.git.git.1675262454817.gitgitgadget@gmail.com>
        <pull.1445.v4.git.git.1675290034144.gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 14:37:49 -0800
In-Reply-To: <pull.1445.v4.git.git.1675290034144.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Wed, 01 Feb 2023 22:20:33 +0000")
Message-ID: <xmqq357pyptu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> The return value for failed thread creation is NULL,
> not INVALID_HANDLE_VALUE, unlike other Windows API functions.
>
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---

Thanks.  Will queue with the Ack by j6t given earlier.
