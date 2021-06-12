Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC3CC48BE5
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA475613AD
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFLLRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 07:17:24 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37506 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFLLRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 07:17:23 -0400
Received: by mail-wr1-f50.google.com with SMTP id i94so8774689wri.4
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3Fid+7OckGySR2AJZFibe1HMckvBm8uS33f/PmUPjFg=;
        b=Kxcby+ZRfUVQFsN56wc3RSQSV1sShdwOAdbOJt6w4FS96FuuuHDQWmEtDxGMXnwoRo
         ofzVHWy08NHiKpBDjOPQf8XX933FqwqYx5bF/c1I+cMTyU4NdbB33cVuV50pbfAPxWPW
         yrNLq+nGanVceUwXaKy4MMx1OI43cGOeBrzbUIxTdkipn0B4zBXsAINkgGrvWNNQai4w
         /iWz9jlGv1Lf+8JQkg8EEJpEXAAUPSO0isfph/WNvV/QNgqcM3DsdPoQKqqD4PYORSm3
         sHiIb3/NBFw5H1pRfiCPTOvMrP2MxW2/ioYF1ygnDLCDm9avK8to0gVQWP41d3IvNYFy
         ZQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3Fid+7OckGySR2AJZFibe1HMckvBm8uS33f/PmUPjFg=;
        b=g1cswH3/1K7clqFXxfSTKQmUIREyOjh2M2Xm+6nWZ4OLZ/0ShUoAANRpjzvUXct7uT
         UBA1mvv+Ww81p9nrybh2LHKDBRhFrtWBFWAL7II2QxdZq09Hzs5E1tStY4zpTm2vl1OZ
         KWHZeMCgBV+VGTj7yEGtFoHINHpniesZAwoe41I6wVrceAhdVECQXupIMXpHrbbCiFyD
         CmTpbN7sOd8nsXpz2QGBSUYkzMBFYeAV0cB/QUujtdqDaEenHGZX8mLP3i0CaD3Z459+
         f2Yey6hI/xLP3ZNvWGSSxFlbY4IjVqIKKSAIi27LhADPQPOqdyZwAIgy4KTdfFNGV2bR
         uKWw==
X-Gm-Message-State: AOAM532y7zJ18DeZ1zPXF0TyNdZVnUU/Ri/vhdsUrWCYtXVJafxGxfPU
        9jHh5N/7iORSM/RAe0zqzyn0i38K8BQ=
X-Google-Smtp-Source: ABdhPJx/g1v+4XgMMiQ/4D5CfLOcpMcSYXLV9I3dQ8GekHDlmecTTMdnxq8ABc/yaJQAc04X0pA2lQ==
X-Received: by 2002:adf:f5c9:: with SMTP id k9mr8446187wrp.180.1623496463022;
        Sat, 12 Jun 2021 04:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm11179042wrc.42.2021.06.12.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:14:22 -0700 (PDT)
Message-Id: <c208b8a45d66556a3f905063bc7c5026ac4f1e82.1623496458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.git.1623496458.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Jun 2021 11:14:14 +0000
Subject: [PATCH 5/8] [GSOC] ref-filter: teach get_object() return useful value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Let `populate_value()`, `get_ref_atom_value()` and
`format_ref_array_item()` get the return value of `get_value()`
correctly. This can help us later let `cat-file --batch` get the
correct error message and return value of `get_value()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8868cf98f090..420c0bf9384f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1808,7 +1808,7 @@ static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
 static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
-	int i;
+	int i, ret = 0;
 	struct object_info empty = OBJECT_INFO_INIT;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
@@ -1965,8 +1965,8 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
-		return -1;
+	if ((ret = get_object(ref, 0, &obj, &oi, err)))
+		return ret;
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -1997,9 +1997,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 static int get_ref_atom_value(struct ref_array_item *ref, int atom,
 			      struct atom_value **v, struct strbuf *err)
 {
+	int ret = 0;
+
 	if (!ref->value) {
-		if (populate_value(ref, err))
-			return -1;
+		if ((ret = populate_value(ref, err)))
+			return ret;
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
@@ -2573,6 +2575,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int ret = 0;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2585,10 +2588,10 @@ int format_ref_array_item(struct ref_array_item *info,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
-		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
+		if (pos < 0 || (ret = get_ref_atom_value(info, pos, &atomv, error_buf)) ||
 		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
-			return -1;
+			return ret ? ret : -1;
 		}
 	}
 	if (*cp) {
@@ -2610,7 +2613,7 @@ int format_ref_array_item(struct ref_array_item *info,
 	}
 	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
-	return 0;
+	return ret;
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
-- 
gitgitgadget

