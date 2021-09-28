Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA8BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C924611CE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbhI1PMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbhI1PMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:12:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517EC061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so2581975wmq.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0ZmbgiWtjmd9rrUu3bWLFqXXee5YqU1DjQrE3yXWR7s=;
        b=HldQrA8UggM96K7gYRjw5MiqYP+J5kbZzjIFpQKUOZqFksTgl0QfGw28igwC8+MeZU
         /LGXN3WX6vmEWcsD6FlKZaCJnG2TuNvxhyU/OCtMSjW5eCYKnFeyEIDUcGDfFEOIyh5j
         8p0fc/68vb+ZrFGPNIBRhvNZhYnfEbyQydJ49xHLyTs18ZYk2dlYhnb6m/ce+6nA9m6N
         1URrWb01NKvlky/ECUjdVb52hEK++2p0xrJ5JG7veIHA8AN1neuCz9mZUrEYbgPS3znm
         4SHlDcEBg7lY1YMn0rx3rg2IxYqmBjZtjlD2FWZvtqjbh2UDqc4mZMZoX2HyevxlZ/9j
         e7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0ZmbgiWtjmd9rrUu3bWLFqXXee5YqU1DjQrE3yXWR7s=;
        b=WqoOp2W4+vEA0JgCbNdEv+f3jYp62U+jeqeT8C6vr0E0Fy758eKuUobljBiP25A3hL
         paxwBT8KjMJ2md+qOVnEztOOMyBze6YByrS0E7UE0pNyV3kI6EgrxxPUtFJfx9P4RQr0
         GFv2Dw1Cod49Gm1lUGS89iBCz1WJVEyNTl73Q2RKFZlXCda8hmuuJjYTJbzMWqfiNbBa
         Cf3xsKrm0ME7fYh0KbltHhmCfdWUfOL1Ll5QDMIOTaAvqgE7TTAHvvaKO+MAbunSZrUC
         ndmKdltWkRZpdt5g9GawsVfus7L34dNZ+RPPt4UN8IXJRk7XmmomuUBW/XLLtjkiSI9b
         CojQ==
X-Gm-Message-State: AOAM531wyzkSfg2hBOSfkmpxwTWmUSONnmwNLY5nQ2tIAIVVaWtEIU//
        aFt6xfK2eqrxyALXkSeddjHSG4rgYRM=
X-Google-Smtp-Source: ABdhPJzTYQVCaSGMrfdgG1NyohUFFgnjYwqlEzeOBWiBuLfAmgy/2mMberFS82KunLhqJgYxXmc7EQ==
X-Received: by 2002:a05:600c:3ba5:: with SMTP id n37mr1605860wms.46.1632841819478;
        Tue, 28 Sep 2021 08:10:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n186sm2983229wme.31.2021.09.28.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:10:19 -0700 (PDT)
Message-Id: <b2f8dc32bfcea771b8a6c10973cad6380b7a3f7a.1632841817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:09:58 +0000
Subject: [PATCH v3 01/19] hash.h: provide constants for the hash IDs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will simplify referencing them from code that is not deeply integrated with
Git, in particular, the reftable library.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 hash.h        | 6 ++++++
 object-file.c | 7 ++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hash.h b/hash.h
index 9e25c40e9ac..5d40368f18a 100644
--- a/hash.h
+++ b/hash.h
@@ -95,12 +95,18 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
 
+/* "sha1", big-endian */
+#define GIT_SHA1_FORMAT_ID 0x73686131
+
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 /* The block size of SHA-1. */
 #define GIT_SHA1_BLKSZ 64
 
+/* "s256", big-endian */
+#define GIT_SHA256_FORMAT_ID 0x73323536
+
 /* The length in bytes and in hex digits of an object name (SHA-256 value). */
 #define GIT_SHA256_RAWSZ 32
 #define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
diff --git a/object-file.c b/object-file.c
index be4f94ecf3b..0ed2a35de73 100644
--- a/object-file.c
+++ b/object-file.c
@@ -165,7 +165,6 @@ static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	BUG("trying to finalize unknown hash");
 }
 
-
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
 		NULL,
@@ -184,8 +183,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha1",
-		/* "sha1", big-endian */
-		0x73686131,
+		GIT_SHA1_FORMAT_ID,
 		GIT_SHA1_RAWSZ,
 		GIT_SHA1_HEXSZ,
 		GIT_SHA1_BLKSZ,
@@ -200,8 +198,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha256",
-		/* "s256", big-endian */
-		0x73323536,
+		GIT_SHA256_FORMAT_ID,
 		GIT_SHA256_RAWSZ,
 		GIT_SHA256_HEXSZ,
 		GIT_SHA256_BLKSZ,
-- 
gitgitgadget

