Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32795C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiBBVEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiBBVEG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:04:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA479C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:04:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s18so893862wrv.7
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKbpSuytatpembKr21M4AtX0toGhBPr1NoFfMMwLy/w=;
        b=I814NsHLv43sbi1nr/yAyPILvr0o18AlL2pw2C94p51FI5NquzGoDLiexmiQinVTS7
         naFeaKgy+qzUVd4Y0EQYSElmA8ClATfanvYKKN7IJBbcgz3dm52jSH8Fc2PWqwwPNvPg
         UNi7vsDUYrLP9i0VjtlPEqavtGuOe2aCRB15jnUsDziqZq1a7aIdeb2NajNTKkZfu+yG
         L4zG+QK4NK+vG+SGaxrSX3sGUE0cRpJgS4ppCWnUUIsajU3pRJYu6XnnDKwapqZwpaH7
         oM90DkXXqq/2lkjn3BadJMpYKNRvS+Nlvwb87SdBWs0IF5VF3lxbGWA4F8WCi+j74ZpY
         1nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKbpSuytatpembKr21M4AtX0toGhBPr1NoFfMMwLy/w=;
        b=5mkdP6WOtZq48mt04AX/esQdUiVjY9uGnt7ufZgKE5KX5dHuvOSmIlvsaCLGLCL9D1
         S2ieGMhfhqjG4vBzyjBgvI7RGeeY9ak/J+MHiX64oGCoKvI2atwvr5RyEMghh8XA0Yt/
         uQ6ugu4vGESlAGPXGnTyAcMvcE0wuU6MnnFEJkeIDxuld8v1jWlbiwevOTN4mYgTUed2
         xAJI4SdCxem38M7L7p4o3hBfdMNMdm4MwQZDvujw38MxGXh95C9OzjME9KW4GmlfC9du
         RaO5ohTMpyppk60Q5YXvaTryaPE2UXMG+Q2MeAXyh+3pFCQ0b92h1wuJlMjal33rZ2Wr
         lm5w==
X-Gm-Message-State: AOAM533K/Q75hiZkJh089M01hG+NqaQbCBDubyZXjAILgGwYIpW6ucT2
        Y3vVXiuf7/Ef51gf1GS5lxNlu4WF/WCcQQ==
X-Google-Smtp-Source: ABdhPJxp22udXL+39n3rW/5Nf1LWrRUWjFSRBFlv9yYPN1ZBPRPVlLQ2bi7nyQozhfxQFLJ17sQHmA==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr4310122wrn.543.1643835843908;
        Wed, 02 Feb 2022 13:04:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm17264592wry.50.2022.02.02.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:04:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] cache.h: remove always unused show_date_human() declaration
Date:   Wed,  2 Feb 2022 22:03:49 +0100
Message-Id: <patch-1.5-fb21bd7b2c5-20220202T195651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.920.g34be1f84792
In-Reply-To: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net> <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
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
2.35.0.913.g12b4baa2536

