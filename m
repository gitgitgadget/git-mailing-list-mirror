Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E71C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 21:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjB0Vos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjB0Voq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 16:44:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F12006E
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 13:44:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso3600301pjb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 13:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgpcksWlt7LhacQQsbCwgMpAwzrTbhW2T9F1KwbL6so=;
        b=fg/tZ6HPCBx5eeXnDdP07VrStOmq/w7HpWp7K8TRtzJ0Ec9RhpaILHlQpviLn/Yyjf
         ez5YPgNVcbLUSJF8q2iDCpCii19bsV1zMWuAXbrW/cNpCpGn+bP/Xi2zGOrvSoP55dTn
         lqmAmEWjNAh4bYkEbQ1njdemmyglGQJ5drlGVkefEJv6w+pHigR0MGciBTS9KoiXmeog
         s1ChUlIMT3QTg9+h5VtRir34t1NYt1/mUG/Vf1ti+J5dx8yoh+HtzwXybDKk1+pCmeed
         +MVZbTjCIAh9qgprT8QcURb5fiCHvu4Ew9NODDqf391FxYjLzFUQFc8C+xIfOl36CclB
         0DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MgpcksWlt7LhacQQsbCwgMpAwzrTbhW2T9F1KwbL6so=;
        b=5q4dgVKW47uRwhUDvhSyJX4DvQ9LZf3+Q3or7yaKuS4YC+KRqqypNryeWhs6F59K8i
         CuRkMdC0Dr+dvdCJb8ztAeW1kT8ysZbAr8RBkX6HK9aMbRuF5qFxv/BROorS0qsUyAPA
         4OwpduZcjm19vXZriTGZ/jUIIaC3JqB7sjICchup0A6i+9fLVMbsub8AoNVIabaAnqxb
         c+Fg9yzh4KN8dwzMByJiEELs/gLppffu+QDzWHeQjm2wlJkp+3kZHURD6m7XNIGLQbJo
         ngKCpFgZTfL07VMPrU/Uv+5ElAZyNtWCZ17fKdvRjEoynyBjBQRoaQnMYh79rpBHEugO
         9HIQ==
X-Gm-Message-State: AO0yUKVTLOfNwaWSoQAVQMeWpzdF6+ugAZ2oSVu3CV5OnBNQoit0Mf+U
        f9/TI8iFkYyN4veH/0Y+6zU=
X-Google-Smtp-Source: AK7set+pk/cEK9A/1yTzRtdNDC+1bcqIsbx6euLnIcKRs1G93jwz42X/R6AgmUKj5zRiUxgk2dMfYg==
X-Received: by 2002:a17:902:d4c3:b0:19c:f84b:58be with SMTP id o3-20020a170902d4c300b0019cf84b58bemr528152plg.3.1677534282575;
        Mon, 27 Feb 2023 13:44:42 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id iw6-20020a170903044600b0019aa8149cb3sm5043448plb.219.2023.02.27.13.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:44:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] signature-format.txt: note SSH and X.509 signature
 delimiters
References: <20230210061611.124932-1-gwymor@tilde.club>
        <20230227202718.173698-1-gwymor@tilde.club>
Date:   Mon, 27 Feb 2023 13:44:41 -0800
In-Reply-To: <20230227202718.173698-1-gwymor@tilde.club> (Gwyneth Morgan's
        message of "Mon, 27 Feb 2023 20:27:18 +0000")
Message-ID: <xmqqa60ysrzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> This document only explains PGP signatures, but Git now supports X.509
> signatures as of 1e7adb9756 (gpg-interface: introduce new signature
> format "x509" using gpgsm, 2018-07-17), and SSH signatures as of
> 29b315778e (ssh signing: add ssh key format and signing code,
> 2021-09-10).
>
> Additionally, explain that these signature formats are controlled
> `gpg.format`, linking to its documentation, and explain in said
> `gpg.format` documentation that the underlying signature format is
> documented in signature-format.txt.
>
> Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
> ---
>  Documentation/config/gpg.txt          |  3 +++
>  Documentation/gitformat-signature.txt | 22 +++++++++++++++++-----
>  2 files changed, 20 insertions(+), 5 deletions(-)

Thanks, queued.
