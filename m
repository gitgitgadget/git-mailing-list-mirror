Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD9C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhLQNaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhLQNaa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A0C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j18so4110490wrd.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk4uLQxhkbUfFwjdRuHRonDrxF+1YTZfN/rRT8JbRUM=;
        b=qlMf1xHQ2Tcow+m6x3mFKq6QDoApDwrnIM4f6wY+SUVbtL0+AS6aA9VAi6j2fhCXhX
         Gfzr9pGBzvFJ1wF7rndkj/eOmAa5EbT7XABtmxN3g3KMYWIYXs+GzmJPR0n0g/ORXiWH
         QwR8moQSGv8a/tKK3BvYCDm7DdyiPary7EIKi+pJibI9iPsZ6JRTCMkPN8/dHDhR16SQ
         7i7x7PlXlnNrgQNXrVTIOLFFwcvNY3qjsz3UO5zodaucD2a5boNC/C4HiCDm0cBjAB8x
         WDKTjxaSS7ALmjd6D3W/KkDxxdL1R5f3sPdF76+JUdVKkQ4advXCs7N3vRomlhQKkaQA
         0DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk4uLQxhkbUfFwjdRuHRonDrxF+1YTZfN/rRT8JbRUM=;
        b=oxrTOKUrAPDuzzmk0+hyQsHXnWMeRO8a4y21qmBwiG+PGFEEx2Li6bqRGjh2UT/rlT
         hPE5AJ/7F+1PGnh7PaCsnlzggMLUmER4S0N53v1m3RjaU5ga91LS2YC+fQbtAyCQ3Rg8
         w+CURBrxfVfJMjPIKJ55DUhAy2aslOLVL5eRhUHdqSWrL0184K3LYVo/TmeaQzogXHf9
         HQFz7A0L3DFU7u16PStdhkXV9D8Uvqyb+GFIwqRNDrSbHqQ5G6541QooqFhnxQxa7hVO
         GD+YRHV30Hkq+ux0y03abgVQ1WCzsthNoU1wH5XNrvoL/bF21LArbanRWNQKvkniW/qm
         ZpKw==
X-Gm-Message-State: AOAM531RvmYekvBvT+ObCzXdP12teh5onTT2GN+xNV/gbjatEUL8IkrS
        srXCyX9RnQrlK9xG0ab9a4548BQMZ5DDLQ==
X-Google-Smtp-Source: ABdhPJwVyVA4yK6Ejms2IktaNkMxPksrLtmkT+HmW+zy3HHUSvltDJD1XhEqf5h+PWDlw9veJ4ZHwg==
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr2676377wrq.194.1639747828014;
        Fri, 17 Dec 2021 05:30:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/7] ls-tree: add missing braces to "else" arms
Date:   Fri, 17 Dec 2021 14:30:18 +0100
Message-Id: <RFC-patch-2.7-8b34ee653ff-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com> <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing {} to the "else" arms in show_tree() per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5f7c84950ce..0a28f32ccb9 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -92,14 +92,16 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				else
 					xsnprintf(size_text, sizeof(size_text),
 						  "%"PRIuMAX, (uintmax_t)size);
-			} else
+			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
+			}
 			printf("%06o %s %s %7s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
-		} else
+		} else {
 			printf("%06o %s %s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev));
+		}
 	}
 	baselen = base->len;
 	strbuf_addstr(base, pathname);
-- 
2.34.1.1119.g7a3fc8778ee

