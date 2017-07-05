Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3BB202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 23:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdGEXP0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 19:15:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34359 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbdGEXPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 19:15:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so896973wrc.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 16:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rFx81qT9JFO0XLzHujv6dO9B6CN1DvaULUaHJ6V/WMs=;
        b=uo4I6FAUS6bDTLsO26mF3Kbf1jayqFUwpO7uXSBvYQbrmgUlsD6DMZJO7zyYAImdZa
         7MHUkzMwbfiUmYhuMyq6ISUlkUupjyFMxv3yJX9Korrx1gPx45gYq9KntgqTq6OaD82W
         mj05/fBk//MGWpoC3tW7fIQMv+Wsm+Ogqwcp5XnEAZEyaLH1pjyPzof9hIWeks2XIBk8
         N4cLDOCFpVFPCytunpzSdJgfUlGR9R6r2eCUhTeu5RVIXLyusYnZw3CIKlTjpofJtbb0
         EA+dsm9frxLkbZq7z73kOS5pq/QrN0Bs7DWfsr8gFeplU5Qb+r33aagjV0tbHBmecxmd
         WEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rFx81qT9JFO0XLzHujv6dO9B6CN1DvaULUaHJ6V/WMs=;
        b=BXkSHF8oatEDLAOhw8fekI3ifG/C8GlUpB3kuiqPelAIAHoHvWK4GtGuKbgb1dUqvP
         aUyr2f1DAiDsSU4dgfCcBmen84sDqAsURKhv6rBOxKW+opBcp6INxiv3HXJecfD+cY2l
         uPHP3xHq3MPoSUVMaUDS0hD0w5sP5IZwUGLDcnJCB4emRLj2vsJThE5M68F552w8/fkA
         sPNOpaObGsSn26txyQm0/xsKt3aKls7FzviF5sxs9H2oNcHKDzRYjOJWtAN7CUWp3Ki8
         U+sox2pOnGpc4kSCAxh56ZUIopAGNjSosdPFfsVEn+yAQwQEUHrOhk+3/CmgBAWpj52E
         Hy/w==
X-Gm-Message-State: AKS2vOy/xQ3u69CsvurxAQgcstikrnCmd+s9tXtmnXywroELebyNMPst
        aOdCD8+Z+bajyKnPjDA=
X-Received: by 10.80.206.22 with SMTP id y22mr23860904edi.20.1499296522482;
        Wed, 05 Jul 2017 16:15:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x36sm8834938edb.64.2017.07.05.16.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 16:15:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sahil Dua <sahildua2305@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 1/3] config: create a function to format section headers
Date:   Wed,  5 Jul 2017 23:14:52 +0000
Message-Id: <20170705231454.15666-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170705231454.15666-1-avarab@gmail.com>
References: <20170705231454.15666-1-avarab@gmail.com>
In-Reply-To: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sahil Dua <sahildua2305@gmail.com>

Factor out the logic which creates section headers in the config file,
e.g. the 'branch.foo' key will be turned into '[branch "foo"]'.

This introduces no function changes, but is needed for a later change
which adds support for copying branch sections in the config file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 config.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 4638b0696a..b7afb5941b 100644
--- a/config.c
+++ b/config.c
@@ -2244,10 +2244,10 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static int store_write_section(int fd, const char *key)
+static struct strbuf store_create_section(const char *key)
 {
 	const char *dot;
-	int i, success;
+	int i;
 	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store.baselen);
@@ -2263,6 +2263,15 @@ static int store_write_section(int fd, const char *key)
 		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 	}
 
+	return sb;
+}
+
+static int store_write_section(int fd, const char *key)
+{
+	int success;
+
+	struct strbuf sb = store_create_section(key);
+
 	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
 	strbuf_release(&sb);
 
-- 
2.13.1.611.g7e3b11ae1

