Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E093C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36516128A
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFXXls (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXlr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:41:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC2AC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:39:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a11so13157102lfg.11
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqRhoFTTc/GpAS8ulxbFCPMQVOI0tjfS52FgjFQYG8k=;
        b=qJRclmYPesaJJyyTSyoGMMnn42n5yXR19hw4A48upd+3yJ3uG6OwYTu0GqPPlbpyws
         vif0EVPVd5+bGpwVV871YmPkLp7zlFsl6ByGQcI6RidtfFWawBTciIpY+xBRzvChqH6S
         NC8wz3AYSqQPLT76iri8Z9HkMXwx9Li+Bc7HJtauJYCVjd8dGmM0pOpmgTE1256jXtMd
         EDBBUr3qTXBIRRSf25tvNoHA5Gk+DBZpvJqrYcZnUT2JRsU0rR3okMn1k8JHI+QdUbUm
         /RXSPFQdujXuTBX7j9lwy+OayOgBg42NAzJcLSbSjRa44kxy05hYaejyW8gUFkMHMO35
         zYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqRhoFTTc/GpAS8ulxbFCPMQVOI0tjfS52FgjFQYG8k=;
        b=AbRnnI9Ak06+OfsW58rsHjBZtS4HwbEJ1eETN5sLBH8D9tgkWva+o6cFnDg6e9QJmE
         YRhhvGWUGBP/Eo8IDewOC82w2hC5W0hYUQjf10K2uVo5dSRiXRJZLFatflwOLHU+KK+t
         fUFMql65gRJ7Y9aerl9N5iOLVIyJFEKuttvn2ZwAtc6PbUlPzmGAg1KQmZTjFIspUeX/
         NKZilxGYuyBSpw7Fg+hGj3EeL/Of8O4V6ifZgEt5ClibzfhHgew37u+OMPEfYFZXaXsT
         xiw1Ug4nbBq8gUkDC6WiT6MJ7SvQxkbwoZCSDkOFXpYmI4dj5fK5EopS+8xEYCMzXuAm
         yN9g==
X-Gm-Message-State: AOAM533hYKlc1h9pviCzB+VCk59Iwd/uJn8JGyaJOedcJRnLuUJHmlaG
        uT7g1ni0b5CdEtv3fOFlshg=
X-Google-Smtp-Source: ABdhPJzwrXD0BiBm1lZatC5US+Q4WmXmFedGIqCJi3BgEjJUdl/CyPqzyDEqQwwPQT6SUNh1RZwCmw==
X-Received: by 2002:a19:c86:: with SMTP id 128mr3067330lfm.169.1624577963309;
        Thu, 24 Jun 2021 16:39:23 -0700 (PDT)
Received: from raspberrypi.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id s21sm410800ljp.131.2021.06.24.16.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:39:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     oystwa@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: Why the Makefile is so eager to re-build & re-link
Date:   Fri, 25 Jun 2021 01:39:18 +0200
Message-Id: <20210624233918.23699-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624233516.23564-1-oystwa@gmail.com>
References: <20210624233516.23564-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops, I missed that you had already discussed this idea. Sorry about about
that.

Øsse
