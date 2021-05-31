Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9AEC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87DD61220
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaHpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhEaHov (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 03:44:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BC7C06138A
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:43:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f22so8438618pfn.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QxX2PifdCEOZWnic0h16Frl8BoVKaGxenssmWHFjkQQ=;
        b=ppPI8ZHVJ/UDsXLKBrR0oEwHaQ8CZHTQt11dq66XMSlDAuUW+g72pTlDx8ENEl/1tv
         dnYLFFaxtZv52IhhT5gaVYTa/jLbKE+4e6Bcov7N7hQoMegyof5LD5PlvPVfZ0DD8JfS
         IvRPaniJAylhxtvU4UZ/SmY5P0ksHFUWX/savRxXqMMTgi1evVHbVLnXsGRgdBBFDxX+
         HIpUFbFkIhDjBK7gRWqN5hpG5M77Uu9Wh9rYUdk+nDTdJz/iqi+QFO2uRA+K4YKMclnm
         R3JeGADruQOc6OFeWH1Cl3/q8fxxBVnQrVsdLJ0WluMcXpc3t5A1gD4ZfnfyCr29UzgY
         waBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QxX2PifdCEOZWnic0h16Frl8BoVKaGxenssmWHFjkQQ=;
        b=XdSPXaySi4hz60EpZ3n+jYtk5kUzTBhmzwm030utkPKGyZEAHoSNubF98fRRj4elOw
         48Qp8NP3ph24NmzG21hdbxVVsvDFqLAgZ0mrsDDh4HGma8IpFcYBDGzAWUGfBViAJixB
         /O7WpJ2HQa2fMcqH6QJRBOj8X4sea+wkRkRc4UVMpoEIp4FEw0I446Tk2lNSquqQ2R3o
         +jwYXYRLRYmFnlOCNxvBUbH0jRT97YK8UEdsYkqm1mmmyoVntjlNalaPNarTmnpXqw4J
         bVcq2VqW/r+IYkrjfFPTn0YiLT4qbjfa/b/Ed1/gTkxLGRF4jp45/NIWq/VctF/Su9Sr
         +WAw==
X-Gm-Message-State: AOAM532oBGhEqP+yy+jj84U92lp+toF1Pu/CmNdRahUi+6Zit7tkzwjo
        R7U0EdEVFhELlus0Oi7zx6s=
X-Google-Smtp-Source: ABdhPJzGCK4aOugtQcVkwOgKjWiz0KfWZte1LlmyyWotHJ6HJ6lWQdlIT3tRN12f2hRKCtALhrQbLQ==
X-Received: by 2002:a63:fe53:: with SMTP id x19mr21673884pgj.372.1622446991476;
        Mon, 31 May 2021 00:43:11 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id 4sm10059248pji.14.2021.05.31.00.43.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 May 2021 00:43:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] My Git Dev Blog
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <2691ddbb-940d-34e2-6865-85890a96ec90@gmail.com>
Date:   Mon, 31 May 2021 13:13:07 +0530
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <56956774-0BE8-4598-85EB-E92E495C80A3@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com>
 <2691ddbb-940d-34e2-6865-85890a96ec90@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31-May-2021, at 12:25, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> I think it's better to post link to each blogpost as separate threads, =
because we can discuss each posts at its own merit.

Sure, I can do that next week onwards.

> --=20
> An old man doll... just what I always wanted! - Clara

