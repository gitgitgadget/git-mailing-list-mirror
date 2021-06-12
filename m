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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13974C48BE5
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C606138C
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFLLRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 07:17:39 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:44830 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFLLRj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 07:17:39 -0400
Received: by mail-wm1-f53.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so6945182wms.3
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=okALitkcKva7heF8096V0K05WIWu9EcjbHVSTAoEeTI=;
        b=DQCUsFgzTKwz7rbddWUgpUegq2Y6yXdS9XDxcH8nFybkuUXSsGGj7KZ1Pt34Du/uQt
         r79l5qbJc5FbtfUpsiUSBHR+0LVB9T3AJtehxEeJ+N7YZEZD6pyb/o0dDMXlrlA0X/bD
         Hpmdv130t27ALPtySBiGtyi+KMZMH/Y8/e5JaOoZPz44CcrYixZ42Th7Ifb4amr9zYGS
         l5xE+2nXAuQ3gDHD48ZNIWdGMY+MkHXUEBHtAzj03PnlwzBZGp93eHJMlgr7S4/Owuce
         zkQSZ3D/XMm/Ny4UTolYBot/G2lqflitSyg+PnKHLQ7Afy7zy3BcMFaT/XXv5d2uK4Lw
         CFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=okALitkcKva7heF8096V0K05WIWu9EcjbHVSTAoEeTI=;
        b=uMI4fZDKj2vmWY96NKEv9YZ8R54vFe9Oqps/N1jZ0WJJ+0eWCByYWCEObxLg9Ec7Od
         kuJRmieTyBMVte/kLB3+vM5QtSuSR+H1zWhETPuoiLGJcKtoKSgnNSW0a3cYAPr13fR0
         A+pLuG+179qQ+7hKJz804b1aPJuhchWbwp4UQifdju3pKzsTi1xWZ8aMz89QSdryNs/R
         dF3rHJgn/E7CCJIsw90LBoelaJx1nZCLCso7dKQ8GjHnuHdvMzVot05CyCYnHaJVEgVV
         j91JX5EtdhSOBgTJOIyobeXJFXkmHY1DDw2nMfAk8D2w74rrmC8r8uC2nxyWuQQQkrOD
         fU1Q==
X-Gm-Message-State: AOAM531GJe1Z/wWGzRsqTGFjRqWZ7Lk0+DEIneDCRJkrC88y0tZJuQiL
        8dfIvZ38IpqYDNnLYWHxxVBZKFs3ESQ=
X-Google-Smtp-Source: ABdhPJyInkZAQQQJpN1na52vW94CWyjIJeYpWZiz1arX7t7bPQf+1BV2WPpipbYBLcgsVnnYLt+K/A==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr24729662wmd.187.1623496464227;
        Sat, 12 Jun 2021 04:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm8492764wmj.36.2021.06.12.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:14:23 -0700 (PDT)
Message-Id: <d31059c391d0c3f40ba45be0803a5ac6d49d5c6f.1623496458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.git.1623496458.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Jun 2021 11:14:16 +0000
Subject: [PATCH 7/8] [GSOC] cat-file: reuse err buf in batch_objet_write()
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

Reuse the `err` buffer in batch_object_write(), as the
buffer `scratch` does. This will reduce the overhead
of multiple allocations of memory of the err buffer.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0bc524e656e1..1a73c3d23dde 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -212,33 +212,32 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
+			       struct strbuf *err,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
 	int ret = 0;
-	struct strbuf err = STRBUF_INIT;
 	struct ref_array_item item = { data->oid, data->rest };
 
 	strbuf_reset(scratch);
+	strbuf_reset(err);
 
-	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
+	ret = format_ref_array_item(&item, &opt->format, scratch, err);
 	if (!ret) {
 		strbuf_addch(scratch, '\n');
 		batch_write(opt, scratch->buf, scratch->len);
-		strbuf_release(&err);
 	} else if (ret < 0) {
-		die("%s\n", err.buf);
-		strbuf_release(&err);
+		die("%s\n", err->buf);
 	} else {
 		/* when ret > 0 , don't call die and print the err to stdout*/
-		printf("%s\n", err.buf);
+		printf("%s\n", err->buf);
 		fflush(stdout);
-		strbuf_release(&err);
 	}
 }
 
 static void batch_one_object(const char *obj_name,
 			     struct strbuf *scratch,
+			     struct strbuf *err,
 			     struct batch_options *opt,
 			     struct expand_data *data)
 {
@@ -292,7 +291,7 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
-	batch_object_write(obj_name, scratch, opt, data);
+	batch_object_write(obj_name, scratch, err, opt, data);
 }
 
 struct object_cb_data {
@@ -300,13 +299,14 @@ struct object_cb_data {
 	struct expand_data *expand;
 	struct oidset *seen;
 	struct strbuf *scratch;
+	struct strbuf *err;
 };
 
 static int batch_object_cb(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
 	oidcpy(&data->expand->oid, oid);
-	batch_object_write(NULL, data->scratch, data->opt, data->expand);
+	batch_object_write(NULL, data->scratch, data->err, data->opt, data->expand);
 	return 0;
 }
 
@@ -362,6 +362,7 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	struct strbuf format = STRBUF_INIT;
 	struct expand_data data;
 	int save_warning;
@@ -390,6 +391,7 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 		cb.opt = opt;
 		cb.expand = &data;
 		cb.scratch = &output;
+		cb.err = &err;
 
 		if (opt->unordered) {
 			struct oidset seen = OIDSET_INIT;
@@ -414,6 +416,7 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 
 		strbuf_release(&format);
 		strbuf_release(&output);
+		strbuf_release(&err);
 		return 0;
 	}
 
@@ -442,11 +445,12 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, &output, opt, &data);
+		batch_one_object(input.buf, &output, &err, opt, &data);
 	}
 	strbuf_release(&format);
 	strbuf_release(&input);
 	strbuf_release(&output);
+	strbuf_release(&err);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
-- 
gitgitgadget

