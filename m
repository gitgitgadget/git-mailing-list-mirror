Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA661F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbdL0XAx (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:00:53 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36071 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbdL0XAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:00:50 -0500
Received: by mail-wr0-f195.google.com with SMTP id u19so31498571wrc.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fan/Ea0pxU1kuBBhIw2Di2+e2dxxEiFUhiLQJDXBlCQ=;
        b=DDjvmzjv4vt2FsfW9I2ZnfWEHnMrWLgbWJ+pim5cM/Q0rJ7Oa76I2hCLp6hk+9FUZm
         /hrOSZbmn6Lk6hgv1mSRgcqdeHP8garyPy+tF5f02GrAlN6oHgYdpFpUHDNrkteTyi8C
         lYLMDT8kXcOFTPwdm3C3UTDNqhCi6zcQZ3aa8XSZB6hLqlsFmMTjSJHQR97ZdlPQ5QPs
         kFQM85Ja8WPejdQgasPA5ZIXZE+DCpL4EAAegMhvdLzRGWIouVcUO8jGL2hBE2OmpFN6
         8UfwPS9aNg6B2K/cr8BXjZTqCZVOn1vE5debPEJdVV5417ddISRrCZSw3x7X+T/gIPKE
         VEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fan/Ea0pxU1kuBBhIw2Di2+e2dxxEiFUhiLQJDXBlCQ=;
        b=eaYEV2WtC7WN6Z60s//ct9j2eD9hBLZl+h/T7hewUIhppUToQOdzmq18J2oq1v8b2N
         LdQpv5BEXUYzId+FDwp5A5UFgewA0NOHI059eFkaiFtLtzEtrv28pOYgEVo0QcTjQpYq
         Y0L0t3bqgg7CEMemOMaiSf5F1b/1Ai1Ngh/jl4T4P8OlnRoWVXe6ZAIg6WUtBiinSn+c
         CnwzdfNGnwu+hFB1dCH0oi4/nrcFYgmulatVAYt2arBwFVYZaMN1jaRTqCgXahU2o6g3
         SDHw+np/1orc34NDPR2WgYYEWgL4t50A2rMzhijqpBmnepkPZsHbKnEBQV8d7P+sxv1A
         Eliw==
X-Gm-Message-State: AKGB3mJk9COKpmu1WWhu4gHgPIXtQZCyXZelg01Z0YtA1TbAbrMTioIh
        FANihC8tBKsvbi3iyork0TcRRPjT
X-Google-Smtp-Source: ACJfBosjDKP4ENDkE88ZgCmeNEw+jsGXgubH01w3eNvF38I56RdXBSdd/A3JDZwZa8KCDsR4rc2YOw==
X-Received: by 10.223.135.227 with SMTP id c32mr29572839wrc.183.1514415648358;
        Wed, 27 Dec 2017 15:00:48 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k61sm21467411wrc.84.2017.12.27.15.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 15:00:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] When DC_SHA1 was made the default we missed a spot
Date:   Wed, 27 Dec 2017 23:00:36 +0000
Message-Id: <20171227230038.14386-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When SHADC was made the default in 2.13.0 we forgot that NO_OPENSSL=1
would still turn it off implicitly, and that Windows would use
BLK_SHA1=1 by default thinking it would be getting the OpenSSL
version.

Ævar Arnfjörð Bjarmason (2):
  Makefile: NO_OPENSSL=1 should no longer imply BLK_SHA1=1
  Windows: stop supplying BLK_SHA1=YesPlease by default

 Makefile         | 2 --
 config.mak.uname | 1 -
 configure.ac     | 1 -
 3 files changed, 4 deletions(-)

-- 
2.15.1.424.g9478a66081

