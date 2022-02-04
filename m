Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A186EC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378342AbiBDXxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378292AbiBDXxM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5A7C103DFB
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:53:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u15so14091148wrt.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5iR5X2y5OvtUAZcKm2+js850VNVqvo8pdy2WJ7qA6Ew=;
        b=gKEw51/R/c9S/Ug+f04GClVD6LDy75Rk603U/oXgXgJDCBMPvheo2qwqQqbmO3rybo
         DnlirHBvVbexRES22uVWvsljBxU3bNJemtFusA+BxBtbqpIwAWvvLo/eLsHBipj+5WxH
         OW62a1Bulhdr4bmbSSO9pwbHHgDptBg/MFZS2/DkPhGfovXoY078K1pWzfGKDaDZClpK
         I0MgFdMXIOGAgFXsM9n74PyDQXehCLzQtvDa5NyPz5GLmF8QqYhhJsvd4WqRELASjb/+
         kFmQpybGuNOiFSnBE1CJqM0ZVT9iQV+GvWNBXjYp+cZ5ZiFyDYPij1dMQ7XvrcMMrQru
         1eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5iR5X2y5OvtUAZcKm2+js850VNVqvo8pdy2WJ7qA6Ew=;
        b=Bs/66WfgeJIh2/Ybd6dFF2dWtgM+3av9cBrkhL6SXE1xWUECitYlEHErc3ZfnKSDnG
         KvKh6j3zJMiNre0GAUf7OUVjxhp8VPTj9UvXyE+omOAgrIY6RDf1mYExMJK1tFbz/slT
         E2wFJmS+qrfGMfc3eOMyUdaLVUjqDYxyUzrv/Tmy4b4FkikS/09Fws/uB0M9ufJVT775
         CF5Apo67RAear1UN5eW7rPau/YCrBIm6hIwZT1Acb/29z14houVG8D9El4LuqQR++u+j
         g/KyOLyFyt6G5cQ6O+x9eIy24LPwyz8rVA5vZktlW8l2xN+eZdw5Fj6TUaBWN655iMNJ
         nVIg==
X-Gm-Message-State: AOAM533kc79r7FZSIYHZRl96C0lsx2lzIxle608U/p0EznC81NrdZOIb
        YMNUay2hV7/CH0EfvwJXpZOnAah2+A6ZYA==
X-Google-Smtp-Source: ABdhPJziFCuYUEHcJzqrEJqvQBn3f2c0fW6t8CSkeOotopkDuLilTrnmeqqYYiQGPvF5V2I4wmxoAA==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr961352wri.429.1644018790149;
        Fri, 04 Feb 2022 15:53:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm3304507wrw.5.2022.02.04.15.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:53:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] cache.h: remove always unused show_date_human() declaration
Date:   Sat,  5 Feb 2022 00:53:02 +0100
Message-Id: <patch-v2-1.5-fb21bd7b2c5-20220204T235143Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has never been a show_date_human() function on the "master"
branch in git.git. This declaration was added in b841d4ff438 (Add
`human` format to test-tool, 2019-01-28).

A look at the ML history reveals that it was leftover cruft from an
earlier version of that commit[1].

1. https://lore.kernel.org/git/20190118061805.19086-5-ischis2@cox.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cache.h b/cache.h
index 281f00ab1b1..49b46244c74 100644
--- a/cache.h
+++ b/cache.h
@@ -1586,8 +1586,6 @@ struct date_mode *date_mode_from_type(enum date_mode_type type);
 
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
 void show_date_relative(timestamp_t time, struct strbuf *timebuf);
-void show_date_human(timestamp_t time, int tz, const struct timeval *now,
-			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
 int parse_expiry_date(const char *date, timestamp_t *timestamp);
-- 
2.35.1.940.ge7a5b4b05f2

