Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68C4C48BE8
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39A2613AD
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFLLRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 07:17:21 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44914 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhFLLRU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 07:17:20 -0400
Received: by mail-wr1-f44.google.com with SMTP id f2so8753102wri.11
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=iEnAxN3M7AKh35xWaFU+PJ3JcqAQZovQ9pf7H7LJDiIoOd3DvXiE1CV/gVnONoQ9KS
         d63DSiY1N59mEBU3gaUqyiTbnpCd9H0HJsX2jtzfnmqD2f8tILFIyfjYDr5d9sYIv4+2
         lsG2Qe9qvobfjFWHprJyT2fdHrloU0qzZXS7roYouU3+wg43TlrCwbLT6eCl613ulriN
         pOsjRKN3QIPjcnwFTGxyo35UMkOp815ipH6vS64O+XCvVqTEhvNShhhRroZaRqUZoize
         I6/e7kBzH0cs10pQE3EIMmDy8tStAxBPPhJjOPaeNhzb4IrWyEtWpv7KW9ZUSxjqKPtV
         lxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sslxU2Zj/H3zu0TbnQu1d/Mc+WxpiqXZj8t9ARAzits=;
        b=SG/zld2Nzbzwu7zgOBAxUhXcTmbcRqWtRawsYyTQ9RExiqIlj1tW2RsbATO7xM7pwo
         kyi28NlTXFnNX4P8SdRe8Qu1kWDDykaeuJjlDu4+4pAVantxvB49ukXuz1lGbGqTQE3i
         OemGD6PQn4WJ59V6yPebfsszZFil6gz9wiqAQxadA1I8A/X0WFJayZupBHyVcFnL2Dam
         M7zWN82OrAZBxGfzGMGwcycH1gjiojlyf2af6qT5xx1C77Q4mwO5OSTbo51FwjYjcVsE
         XmBIe/WMhNex+Tcyo3Dl7KtSXUzy6yHDdRR9mDzAm3KzRrX5eN6CPp6b+A2vy+A5K8hk
         58Vg==
X-Gm-Message-State: AOAM533O2FfWuMWLMa3XOJMeT+b4ieE2faauZB3qH1a/wyX9CILzD9aR
        mBc3ftJUc+j84IFAEXu4Hp7IkGQRXdE=
X-Google-Smtp-Source: ABdhPJwhB9duMpAuPCJdkDhVt2AYbgqIWQKXm2Gz79O2Nck7YYyHYGxcdf53paOuMwIG14lDbAmRUQ==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr8891002wru.380.1623496460522;
        Sat, 12 Jun 2021 04:14:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm9834344wrr.33.2021.06.12.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:14:20 -0700 (PDT)
Message-Id: <48d256db5c349c1fa0615bb60d74039c78a831fd.1623496458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.git.1623496458.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Jun 2021 11:14:10 +0000
Subject: [PATCH 1/8] [GSOC] ref-filter: add obj-type check in grab contents
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

Only tag and commit objects use `grab_sub_body_contents()` to grab
object contents in the current codebase.  We want to teach the
function to also handle blobs and trees to get their raw data,
without parsing a blob (whose contents looks like a commit or a tag)
incorrectly as a commit or a tag.

Skip the block of code that is specific to handling commits and tags
early when the given object is of a wrong type to help later
addition to handle other types of objects in this function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4c6..5cee6512fbaf 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1356,11 +1356,12 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
 	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	void *buf = data->content;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
@@ -1371,10 +1372,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			continue;
 		if (deref)
 			name++;
-		if (strcmp(name, "body") &&
-		    !starts_with(name, "subject") &&
-		    !starts_with(name, "trailers") &&
-		    !starts_with(name, "contents"))
+
+		if ((data->type != OBJ_TAG &&
+		     data->type != OBJ_COMMIT) ||
+		    (strcmp(name, "body") &&
+		     !starts_with(name, "subject") &&
+		     !starts_with(name, "trailers") &&
+		     !starts_with(name, "contents")))
 			continue;
 		if (!subpos)
 			find_subpos(buf,
@@ -1438,17 +1442,19 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
 {
+	void *buf = data->content;
+
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
@@ -1678,7 +1684,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
-- 
gitgitgadget

