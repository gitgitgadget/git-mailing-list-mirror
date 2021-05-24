Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88C1C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12FE61402
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhEXSKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEXSKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 14:10:16 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7FC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:08:48 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id b25so27904701oic.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vUIof33U7mlE0ZOfOM4LJgBM9TPTNTzLaeX11ecOOjs=;
        b=uniBi34F9MO3pBSJTx5JBlbJ4IGDEq/J2II1fWPBRif8cYaB58ebL140DhyAYqqSZe
         NUq/ZqzpU9+OPTgGOQSctPnZlgdL/+dbhhAmkeF/KODJwplCuey8impDqaxUwae3fBOX
         om2/KSJ8aJfu1yaPSojg+EqbP7Mb+g4gr8/u8HtvGqJ97NC98bA/WKhpHGx9nEU7PGV6
         +4zOkLfTlm0FVpsEEpQcx1GNKF4q+mGYuGpnAfvqsJ3RZi60jP52+sKnTPfGnuoLFs3s
         aCKSu3b7QsuLpf+Y+Bkf6x1gCwOc/jHPhh6+56IAxJteq5rXn7raXrLUoiXUcbbcgRyA
         B0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vUIof33U7mlE0ZOfOM4LJgBM9TPTNTzLaeX11ecOOjs=;
        b=gK58TfBsRKDEESnI1erG8AOAuGWIt//kPCsFyxdFUUmkhz1lLPHYDkXcJDn1RdZ+VD
         Jm11djusvagwTK8KXaRgvYjpzDjJa26Tlpfdvm2RbDgcJXJ69BglI37V2qzZMRuEltFH
         uz8KOvonnW+jxtZNdM6TiDq4r/DcpH/KtHxF/iBZXQAzVaudVH673WucF5iELlSYzBjd
         6WhuW+YatnshYBTPR1eY5aJXaCtq4vtGdd/JGssOPVmKmCRgsdrDhLRPZ2NDEZLsQNhk
         LehJqHKAEKoj1GwUR5JAEToXB3bzBe39Gm6EksqJkoRCLmN0kNnHxXTIdFRjLyVTFt7S
         Ygrg==
X-Gm-Message-State: AOAM5316osDLCchIRuZymHSGaO1g1pLk4TLxvavWxL0Zw/hDcXxWGxRG
        nNuPFYpSTPTiqa0M7M/ZMBI=
X-Google-Smtp-Source: ABdhPJzvfDdW5dxx/sMSs5VzfTJe+WhUEGzQsnuB4ncXTRVrmoep4zwER5xiXYFErQDtifxWVTe9WA==
X-Received: by 2002:a05:6808:8cd:: with SMTP id k13mr11892652oij.156.1621879728039;
        Mon, 24 May 2021 11:08:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id n17sm2810393oij.57.2021.05.24.11.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:08:47 -0700 (PDT)
Date:   Mon, 24 May 2021 13:08:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Message-ID: <60abebae78f95_1b20920898@natae.notmuch>
In-Reply-To: <20210524071538.46862-5-lenaic@lhuard.fr>
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-5-lenaic@lhuard.fr>
Subject: RE: [PATCH v4 4/4] maintenance: add support for systemd timers on
 Linux
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard wrote:
>   Concretely, a user that doesn=E2=80=99t have access to the system log=
s won=E2=80=99t
>   have access to the log of their own tasks scheduled by cron whereas
>   they will have access to the log of their own tasks scheduled by
>   systemd timer.

A user is not a person:

  a user that doesn't have access to the system logs won't have access
  to the log of its own tasks scheduled by cron, whereas it will have
  access to the log of its own tasks scheduled by systemd timer.

Cheers.

-- =

Felipe Contreras=
