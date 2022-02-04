Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F356C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378034AbiBDXs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357249AbiBDXss (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCBFE0090BE
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v129so2065324wme.2
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jgactRXJRnNfPZMloFi1ME32D7helXp0vZlDUH1SD7s=;
        b=pZWyk98T+FlESn/v+3UqedUGwAmJ3mUQlXuy/qlFZX0vvn8/JX+kVhAXrAp/gZvtlm
         RhR3idPNyfAbhUP8CEprUxsv91xHZ9bSBEmtVTRWJ9YL1dOMPJB7lhj3EJchdE8+AXIq
         E+OZWetBIy3uLlzff2bAuHfXX9nvQMabMpGLhxyR4nq0enUUWJWtQFEpIIPrLWh85UP3
         t2iUXjt3xT0YsmShlUO41ixdDRzAjvJymdYQdiGaTk9gSVTfnhKkIL144nTEC49qLYN2
         57VsFqE3Nafs+cewj96K/tcQyO5k3zg98wOUdPt5KcdVJPs7m9zUS2+OHiXX+LdH6nj2
         ZJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgactRXJRnNfPZMloFi1ME32D7helXp0vZlDUH1SD7s=;
        b=EutNh0iojTBdVvQk8RlD1sT/XLEsBEC78SjFwrnQesBltPlEgAtvMW+QfiJghMDzIz
         wkWY7D/K7DUcayXv3QOowywLpF2iJl9HI+/AWzstbFSF1SdG+VYLeqzljRgeBMVljdwt
         SGSUthie3F3U+XlkWK+1FfNqYs5tOZkPjPZioCx+ketWhVJOBkMtmhzPVlzjGBGRP1pi
         ZrXuRmmX1blhXTyj/wHtvooQKmhQBqdNzaWoIxlK4YAnyfhquGe8IShWGG182qmhvPRo
         zGg1n9H0qVbUNmz53Gonk8g5Eg9f2v5DXS1Xvb5DZXwQRP69uAFBtjozVZYXFtQRBQiC
         03Dw==
X-Gm-Message-State: AOAM53140Nrs6LSKqrqT6eD6445SJwjox1IQCCrEueQnaaMgUUIB/YHr
        WW6w1YMeJHpXS37i0ZgL2AqRkI4++a8RXg==
X-Google-Smtp-Source: ABdhPJxAJ7vmlRG+n53bCZt3/giiWo5obDHSccp1Xn36l3JB36MyJs+SCg2OcRg4o3tEJqSmSsUaOg==
X-Received: by 2002:a05:600c:17d2:: with SMTP id y18mr4220829wmo.165.1644018524755;
        Fri, 04 Feb 2022 15:48:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/12] object API: correct "buf" v.s. "map" mismatch in *.c and *.h
Date:   Sat,  5 Feb 2022 00:48:27 +0100
Message-Id: <patch-v3-05.12-6faf46277b5-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the name of the second argument to check_object_signature() to
be "buf" in object-file.c, making it consistent with the prototype in
cache.h

This fixes an inconsistency that's been with us since 2ade9340262 (Add
"check_sha1_signature()" helper function, 2005-04-08), and makes a
subsequent commit's diff smaller, as we'll move these API docs to
cache.h.

While we're at it fix a small grammar error in the documentation,
dropping an "an" before "in-core object-data".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 59eb793e0ac..271acf4dd15 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1067,13 +1067,13 @@ int format_object_header(char *str, size_t size, enum object_type type,
 }
 
 /*
- * With an in-core object data in "map", rehash it to make sure the
+ * With in-core object data in "buf", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
- * With "map" == NULL, try reading the object named with "oid" using
+ * With "buf" == NULL, try reading the object named with "oid" using
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size, const char *type,
+			   void *buf, unsigned long size, const char *type,
 			   struct object_id *real_oidp)
 {
 	struct object_id tmp;
@@ -1084,8 +1084,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	if (map) {
-		hash_object_file(r->hash_algo, map, size, type, real_oid);
+	if (buf) {
+		hash_object_file(r->hash_algo, buf, size, type, real_oid);
 		return !oideq(oid, real_oid) ? -1 : 0;
 	}
 
-- 
2.35.1.940.ge7a5b4b05f2

