Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44908C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356498AbhKYQNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356422AbhKYQMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:12:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4572C06139B
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j3so12668414wrp.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uBrYERAbNA+nKYS59J7yvvLJABgzXblwiIGK1C6wKao=;
        b=A3U/L8WaD3i9kvQGn3wRu4KX4QqLC36Wye6HkDpHi+eDuhqvMeONfrwZ7Mb6ejV6kT
         8IXFerAB1eH/YJNa0dB7XsTgXebhk4lgnSoXusx/9dPY+wGR/aJA68VMqecBjguugPFm
         cPzrZThXfkTvZ6Ci19E3H4fMJYsLRXZylI5/BhBGmxZZVfF2IvnJzjdoYDFG0LOAZKHA
         XeYs81SgLqlV7D8ZWJRwmPPrCPlRGhIrrVRODzmm+MRYnxASo20aCSHZ2hDIOOiZe54k
         U1GrcWSdCNOpSYFu0Kv9PvVxl0NKVgc0PNm7eKwwmaQNOq3cCo+uKv7i1ffaFkCZqlAW
         xl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uBrYERAbNA+nKYS59J7yvvLJABgzXblwiIGK1C6wKao=;
        b=ihKQSnLY6shA/GhOmNlI9cdijE6OeFX73Xg9XpYOTc4V/mfxjm2sDh6pQCv8uH9SCy
         LGUu9RHADavHYcJbfR+T9bPsJJyjEXlOxIGuFwoNDGzcZnamhu/tD8CE6Dm21eIUlCwn
         DAmZq+zRNLGB2n1W+aeaqYT+pWTMse99W2G1Ng2O0+J6P9jWWOnbkhwONGmt6OK/8aoo
         ly6VjNPtiRnIZ0hA2MqnPf5k82WgQj3Pfa0Dxw2ntJURodMZMtmZ2Dtv/SvZ8d7fLrTD
         I4Gya1pxlaIMrR0RL9sRjPf+D9Nrs9J/a1HvNTEWiz2vGbd5doIbBhRdqAtAb6ehdO+t
         xv1g==
X-Gm-Message-State: AOAM532WHFZWFfUSBZllJD6202/s0geFzgbqNz8Vv2vY28Ayeoos622p
        7ddp4RBC8lcocWWoTJZyKJ3YjQHh6P0=
X-Google-Smtp-Source: ABdhPJzyzPg51QJPvCbo4CXhpB0hgrS/rJiXHi6Xf3Cp7NuxbKgkzf3DKMcaCVtClijOnj63RHTkMg==
X-Received: by 2002:adf:fe8e:: with SMTP id l14mr7850514wrr.177.1637855877088;
        Thu, 25 Nov 2021 07:57:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm3312002wrm.27.2021.11.25.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:57:56 -0800 (PST)
Message-Id: <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:57:52 +0000
Subject: [PATCH v2 5/5] refs/debug: trim trailing LF from reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

On iteration, the reflog message is always terminated by a newline. Trim it to
avoid clobbering the console with is this extra newline.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/debug.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 8667c640237..2631210795b 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -284,15 +284,21 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
 	int ret;
 	char o[GIT_MAX_HEXSZ + 1] = "null";
 	char n[GIT_MAX_HEXSZ + 1] = "null";
+	struct strbuf trimmed = STRBUF_INIT;
 	if (old_oid)
 		oid_to_hex_r(o, old_oid);
 	if (new_oid)
 		oid_to_hex_r(n, new_oid);
 
+	strbuf_addstr(&trimmed, msg);
 	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
 		      dbg->cb_data);
-	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
-		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
+	strbuf_trim_trailing_newline(&trimmed);
+	trace_printf_key(&trace_refs,
+			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
+			 dbg->refname, ret, o, n, committer,
+			 (long int)timestamp, trimmed.buf);
+	strbuf_release(&trimmed);
 	return ret;
 }
 
-- 
gitgitgadget
