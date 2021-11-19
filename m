Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C786C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52D861ACE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhKSMtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhKSMtn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:49:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D6C061748
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p18so8364691wmq.5
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2XYysDQyq6cl43Qp4X2ey92pLM889HD3ZlO/aRooU3Y=;
        b=KPPRJi8NLHGGRh/W2KekHuTvrr6syyLVOHMpGzD/7JfiSvfKtDtyL0jTEkJl2ELuCM
         qg3iRYhFn3l9cAI5x5EvAHMD7g280a22qti/tqe1mAjNYC2v83Us9grKjizSTIHisDZD
         qj8sCbq9GcQR/mYnvcW+FGo29poPAQVQkcqsubdJuQ5ydPoZioCNgkaZaLiqxtDtwPnI
         J4jSJI/DVWGQziDmepY1q3gwXSAtv+2DZ3TGgO/ygODtt60t0T/mME2sVRGqk1Xo2smJ
         gwf314151rSk9k34Th/JTG5rj6jTN12qkNkcjoNY40mcmoou0KJXUXjOwih07Hnh+nFF
         of2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XYysDQyq6cl43Qp4X2ey92pLM889HD3ZlO/aRooU3Y=;
        b=wySCTqVQowWaynYhBh9rtwoN46u4ec5H6YNhksvtKru67wKcckWOLdbvv7CBs+17gv
         fYDoLW+1kd4af5gcVCaY3ODl9wPiRqVYCAmqyG+APtMkM1rtOmovgrJKDJR+ekeEwX/A
         EnlYdzh1To7SuTrvgXdyYaamfCLG6PMsNQ8Crng50i7xtoB1q/wFfSjtiiytJdfXn+Vd
         I1B8eJ/Sf2005udu5VKX/jyFnS1Vh53UK4LHVJqcZN+R9zZCK9i32UuhaIgL3h7WF3eN
         0sM+IysC8fGub+B/duW8o8V4uavbwgezFzKIrM+1m94HOigTRL2M6Fuv9O25Qeam7Uew
         hxBA==
X-Gm-Message-State: AOAM5301Y4WGl7X+fQCH2JZcmJxZsSAkm9QxDuTIvoxeAUs7PVIUO5dt
        VXpMx/K+pbqcPVy8L7P3SvbrzUk0jKwm3g==
X-Google-Smtp-Source: ABdhPJwc9UiRIY3AyDqTThAgZW3i3U5uMU6mD+j44MdG9dhuumIWw0ZIXL+ydnfypo+X4mOoCsqXuw==
X-Received: by 2002:a05:600c:1e1c:: with SMTP id ay28mr6675328wmb.131.1637325999908;
        Fri, 19 Nov 2021 04:46:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm2857567wru.51.2021.11.19.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:46:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] json-writer.[ch]: remove unused formatting functions
Date:   Fri, 19 Nov 2021 13:46:26 +0100
Message-Id: <patch-6.6-e14ee1f8c47-20211119T124420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.817.gb03b3d32691
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were added in 75459410edd (json_writer: new routines to create
JSON data, 2018-07-13) for future use with trace2, but have not been
used by anything. These are easy enough to bring back should we need
them, but until then there's no point in carrying them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 json-writer.c | 24 ------------------------
 json-writer.h |  3 ---
 2 files changed, 27 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index f1cfd8fa8c6..8a81c2d5fce 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -331,36 +331,12 @@ void jw_array_false(struct json_writer *jw)
 	strbuf_addstr(&jw->json, "false");
 }
 
-void jw_array_bool(struct json_writer *jw, int value)
-{
-	if (value)
-		jw_array_true(jw);
-	else
-		jw_array_false(jw);
-}
-
 void jw_array_null(struct json_writer *jw)
 {
 	array_common(jw);
 	strbuf_addstr(&jw->json, "null");
 }
 
-void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value)
-{
-	assert_is_terminated(value);
-
-	array_common(jw);
-	append_sub_jw(jw, value);
-}
-
-void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv)
-{
-	int k;
-
-	for (k = 0; k < argc; k++)
-		jw_array_string(jw, argv[k]);
-}
-
 void jw_array_argv(struct json_writer *jw, const char **argv)
 {
 	while (*argv)
diff --git a/json-writer.h b/json-writer.h
index 209355e0f12..563c7e0e004 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -95,10 +95,7 @@ void jw_array_intmax(struct json_writer *jw, intmax_t value);
 void jw_array_double(struct json_writer *jw, int precision, double value);
 void jw_array_true(struct json_writer *jw);
 void jw_array_false(struct json_writer *jw);
-void jw_array_bool(struct json_writer *jw, int value);
 void jw_array_null(struct json_writer *jw);
-void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value);
-void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv);
 void jw_array_argv(struct json_writer *jw, const char **argv);
 
 void jw_array_inline_begin_object(struct json_writer *jw);
-- 
2.34.0.817.gb03b3d32691

