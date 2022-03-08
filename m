Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF43C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 05:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbiCHFql (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 00:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiCHFqk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 00:46:40 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85043BA7D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 21:45:44 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e13so16110810plh.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 21:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72t2hGJsZGKefZ9od9KgW8jzzMzA6JAJWgWYIgDtua0=;
        b=n1FQtoLKIlaPBiQrm54YmyQ5+jdyW3Rza03Gz7n4R0JnilLSyqF4n0uycElJwYmy35
         H5IH1//otEima5rLJUXayNadLL1m7mbyELY7WV6GAwu+Zmqr2xPHDFgT3HHHZb8OE7Cj
         hEukJBFcVF/dUIlV2OCJnVhYO5TGFE65WWjhIvsxFNV1vgv0X7oXS3kOMR4CUGiDJqfZ
         s26Y5Fp2gI9CXQp2Zsa5Fth6BXTZiTAu1EJK98cNuYwrQHKK7NirlIu++cl8hFcZtBiO
         VWmZ2KwgF9EOSnvrecY22DTLbtbX4wXW+0C3XGZfSIXRrzE+FxHa3uM7BhcCjuP767CA
         5y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72t2hGJsZGKefZ9od9KgW8jzzMzA6JAJWgWYIgDtua0=;
        b=rWbICneSWGyoRtjCvhU+7Qm6yweQssKpVzWerRD0HXGAM2+ATogPi0IFKTpr/pS63P
         xeO19IM45whng81ThYeGfuHU3gb+DToDfeGlSatu9wkiuiqWZFPamyOjr/C9e19Cjubd
         1Uau594AGPGY1vmM4Mk9498DxNPaGFavcU9/8TxlxxibA+5BbP+ivptb1rfb6ozyjs2O
         2B65rso8qV7vs2fvRkl/TULneWqmGFlkH36uC7VVWmLycGBxhSPKRorxD0yY04fdviXz
         4SGSqVToxgLzpAdJyBEkXYXOaSHKDxDdRi7bcuZRfiAP2rfO3GiK8JtloaYH/eij+p2k
         +iXg==
X-Gm-Message-State: AOAM533O1iH06kBHZu1ZhyH2gKvQfxty6gpPeMERxPRlFEotywsXlGZ4
        +3PZzDJ9UIrFHmAnmXuvorA=
X-Google-Smtp-Source: ABdhPJx2hthWaUos0W0y3nIid5v9mqGGpbZB1qWK51im154UOmpcMi6J+XJZy7eGDN8EqpbzLKDFig==
X-Received: by 2002:a17:90a:4bc2:b0:1b8:cdd3:53e2 with SMTP id u2-20020a17090a4bc200b001b8cdd353e2mr2855539pjl.219.1646718344136;
        Mon, 07 Mar 2022 21:45:44 -0800 (PST)
Received: from localhost.localdomain ([2409:4061:2bc3:d84b:ad4c:880d:38bd:cf58])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090aa00c00b001bc6f1baaaesm1202098pjp.39.2022.03.07.21.45.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Mar 2022 21:45:43 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Tue,  8 Mar 2022 11:14:16 +0530
Message-Id: <20220308054416.65257-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <nycvar.QRO.7.76.6.2203071709540.11118@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2203071709540.11118@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Yes, he is.

> And he wishes he had the time to work on it himself because it sounds like
> a really fun (if challenging) project.
>
> In other words: If you ever get stuck somewhere along the lines, please do
> push up a work-in-progress branch and reach out here so that I or others
> can help.

Thank you so much ^^
