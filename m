Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727ADC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiGUGkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiGUGj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:39:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559CF3AE56
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:39:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h9so867367wrm.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nx8I+O/QnBUB1b1kH/84sWVXnNb+k3EGj5r3DnOoWdc=;
        b=Wj3tUZajKEm5HJFDaAaH6wng8n6/6kuO2CPerbcMoa5wYKXatfYC0VMetRtTYa7qpv
         g0jVtwPTBOvk4ZmD6bU++WsQ1qM3n3tQcAbi7NgUXqGXOWGRN7V04LwPwsiDtnYQ4cKF
         glN9O1pkhVwjAM8vvSbmWBDaFxaU+YQDt06DmsmR47/q9fmvXL8aLS5/9cOiVpd205oH
         ausV6VT+5vJv/c6TiaMpHGUeKlQr886WkXbpCy1br7Oxgdk3TCRemTjXFM5BY4hjKGO/
         WRTKv8hGFkNxqqnThX3Tz6GpIeERJS3TnhFYQzJvFtN9PAvLFoeQTn5sWW6rWrJiva5r
         O+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nx8I+O/QnBUB1b1kH/84sWVXnNb+k3EGj5r3DnOoWdc=;
        b=qZOmjIvp802zgcEaOs5yPNLbZKn0ugbuDdNtaKUcEhU8VptRXhyDjZpS01Un6jrlVT
         6BhNBjPfjQ0fcDNqoz6KYb3hl6PBfVmFoa4xntV6usrdMGYIKbFTpYyccN1IXpLsPvq8
         GIHto7KaJV7dq08PkEQvKBBA73tv6UJoa2mxdrcH5VgR5ixOKry0yjC2UYfoaeiYwZSU
         gs6pSF4oAj6axbAZMhe9LWM16X+du9+vYK7ZyKptOgQVOhU/7p3y48oZ6ovUJRFnr3pU
         d4frgOagIVP6VEq95mD9s9pde//1j909hI8XO6HdyKVZlveWPR8n4Xsm/g0AbVQLnHKL
         6K0g==
X-Gm-Message-State: AJIora+v8o5C0I/6pfmjJwXAc3Rp0P3sCclMkeB1WS2klCPVVXkHwspf
        0147auMUygZiR9JpHtw2UU2Y0Bf+swDcbA==
X-Google-Smtp-Source: AGRyM1uIGy7gUJfFIqoAm3e0JHywf0bH5/r4DNgecyVbRVemWfBcOQFvVfAdOfDvUZZDfF3GJTilNQ==
X-Received: by 2002:a05:6000:901:b0:21a:a576:23cc with SMTP id bz1-20020a056000090100b0021aa57623ccmr31882742wrb.489.1658385596588;
        Wed, 20 Jul 2022 23:39:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r67-20020a1c2b46000000b003a308e9a192sm4641137wmr.30.2022.07.20.23.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:39:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] string-list API users: manually use string_list_init_*()
Date:   Thu, 21 Jul 2022 08:39:45 +0200
Message-Id: <patch-2.2-5d8baa9cbc4-20220721T063543Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert various code that didn't use string_list_init_*() to do so, in
cases where the only thing being allocated was the string list we can
change from CALLOC_ARRAY() to ALLOC_ARRAY(), the string_list_init_*()
function will zero out the memory.

This covers cases that weren't matched by tho coccinelle rule in the
preceding commit, which is conservative enough to care about the type
of what we're modifying.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 notes-utils.c | 4 ++--
 reflog-walk.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index d7d18e30f5a..73559d24ec8 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -129,8 +129,8 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 	c->cmd = cmd;
 	c->enabled = 1;
 	c->combine = combine_notes_concatenate;
-	CALLOC_ARRAY(c->refs, 1);
-	c->refs->strdup_strings = 1;
+	ALLOC_ARRAY(c->refs, 1);
+	string_list_init_dup(c->refs);
 	c->refs_from_env = 0;
 	c->mode_from_env = 0;
 	if (rewrite_mode_env) {
diff --git a/reflog-walk.c b/reflog-walk.c
index 7aa6595a51f..2b17408f9a4 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -120,7 +120,7 @@ struct reflog_walk_info {
 void init_reflog_walk(struct reflog_walk_info **info)
 {
 	CALLOC_ARRAY(*info, 1);
-	(*info)->complete_reflogs.strdup_strings = 1;
+	string_list_init_dup(&((*info)->complete_reflogs));
 }
 
 void reflog_walk_info_release(struct reflog_walk_info *info)
-- 
2.37.1.1095.g64a1e8362fd

