Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51231C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332916124C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhETIvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhETIvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:51:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90911C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:49:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y14so14678732wrm.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=33P2HMcatiUHNHDv3St0tmsxH0f2z0YEcxcnDD+M6cA=;
        b=hsa2+VUb1iO+meoLKxHB5CNeOjb4wNA2FUVgsMEY6VF4CU6n4VHl6vQP4wdqfQPa4q
         xYa53MnolddExoP6ksUp/mwkDFOoA8U8+njBoUfYbFS2LmuFIod2hQcvgqr2H/C3G+JW
         fr2sU0cufm93+6VOXw1PAzcS6KypaspGqGJyeMrZFi7ej+ifK5qoTLkET3UoF7ndykWw
         Z2OuDtVdiy0/4O3Nm5bvE1NjEmKfCdrQ/7AhZOwYSeLIBsuPubL3YZTJaSbAb+F6HG3l
         Nc7nFULD9BC3lkRD8khlylHAPOBtZ1ru0o+B1qp06/6IYCBRgC+mIYX+YGaPH8e2tn/D
         aRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=33P2HMcatiUHNHDv3St0tmsxH0f2z0YEcxcnDD+M6cA=;
        b=H6YcusXebaTWb5Xmn9Jjn31SQpc5fdB/412AKtgdB9F5fFuKOmByji+LZ2uNF7bW5f
         O9MMWB11i/y6JDvp8uMHgYL2OPkILzcF6KRA8xKG9u9x03omdPBOGpjXOmfMXzgEtw4j
         hkXZ9Vs01iSeS8klN0PSsJDDc/AfJj7JqXTn/ov0TaB44wpuHtwmnMFGjtd/B0LP7M29
         BfTd6hr9thVRJQ3fZVKLGtSTu/PhuNjivorapkib8Q3KEcQ76AAnREKzqaQ/BQLD26bp
         ruzpC8b0LMo74eFn0a9AsErKfxJqYTHBo77GO/KtDYVo+CiRRma3BiRRMUm7Hi1krI7a
         rlzw==
X-Gm-Message-State: AOAM533/kfNoH3h1OPi5cvf6mxEpkZOtggvzaPH64qq7Rz8aKMQlLUQD
        LwYHHojMsT5pwV9NL7J9EeWsX2kSZSU=
X-Google-Smtp-Source: ABdhPJw17dXo6z0wgjeB8z7BIbktSwO16rqM6mGYJk6w0E7PVuYJ/6o/Onflcfmx7TTYj8sROmm4Tg==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr3134685wrn.156.1621500594212;
        Thu, 20 May 2021 01:49:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm2316396wry.40.2021.05.20.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:49:53 -0700 (PDT)
Message-Id: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 08:49:52 +0000
Subject: [PATCH] [GSOC] ref-filter: add contents:raw atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add new formatting option %(contents:raw), which will
print all the object contents without any changes.
It will help further to migrate all cat-file formatting
logic from cat-file to ref-filter.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: add contents:raw atom
    
    Learn from Olga's %(raw):
    https://github.com/git/git/pull/568/commits/bf22dae7ca387dbc92c5586c92e60cd395099399
    
    We can add a %(contents:raw) atom to ref-filter, which can output object
    contents without any change.
    
    %(contents:raw) can work on the refs which point to blob,tree,commit,tag
    objects.
    
    It also support %(*contents:raw) to dereference.
    
    With %(cotent:raw), we can later provide support for printing the
    content of the "raw" object for cat-file --batch.
    
    Why not just use Olga's %(raw)? Because %(contents) can output object
    contents already, we can reuse it, instead of using another atom %(raw).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-958%2Fadlternative%2Fref-filter-raw-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-958/adlternative/ref-filter-raw-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/958

 ref-filter.c            | 27 +++++++++++++++++++++------
 t/t6300-for-each-ref.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e2eac50d9508..fc384a194c0c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -133,7 +133,7 @@ static struct used_atom {
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
+			enum { C_RAW, C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
 			       C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
@@ -347,6 +347,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 {
 	if (!arg)
 		atom->u.contents.option = C_BARE;
+	else if (!strcmp(arg, "raw"))
+		atom->u.contents.option = C_RAW;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
 	else if (!strcmp(arg, "size"))
@@ -1292,7 +1294,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
+static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
+				   unsigned long buf_size, enum object_type object_type)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1312,6 +1315,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 		    !starts_with(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
+		if (atom->u.contents.option == C_RAW) {
+			v->s = xmemdupz(buf, buf_size);
+			continue;
+		}
+		if (object_type != OBJ_TAG && object_type != OBJ_COMMIT)
+			continue;
+
 		if (!subpos)
 			find_subpos(buf,
 				    &subpos, &sublen,
@@ -1374,25 +1384,30 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
 {
+	void *buf = data->content;
+	unsigned long buf_size = data->size;
+
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, buf, buf_size, obj->type);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf);
+		grab_sub_body_contents(val, deref, buf, buf_size, obj->type);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
+		grab_sub_body_contents(val, deref, buf, buf_size, obj->type);
 		break;
 	case OBJ_BLOB:
 		/* grab_blob_values(val, deref, obj, buf, sz); */
+		grab_sub_body_contents(val, deref, buf, buf_size, obj->type);
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
@@ -1614,7 +1629,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content);
+		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0214076b4d..baa3a40a70b1 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -686,6 +686,17 @@ test_atom refs/tags/signed-empty contents:body ''
 test_atom refs/tags/signed-empty contents:signature "$sig"
 test_atom refs/tags/signed-empty contents "$sig"
 
+test_expect_success 'basic atom: refs/tags/signed-empty contents:raw' '
+	git cat-file tag refs/tags/signed-empty >expected &&
+	git for-each-ref --format="%(contents:raw)" refs/tags/signed-empty >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
+test_atom refs/tags/signed-empty *contents:raw $(git cat-file commit HEAD)
+
 test_atom refs/tags/signed-short subject 'subject line'
 test_atom refs/tags/signed-short subject:sanitize 'subject-line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
@@ -695,6 +706,15 @@ test_atom refs/tags/signed-short contents:signature "$sig"
 test_atom refs/tags/signed-short contents "subject line
 $sig"
 
+test_expect_success 'basic atom: refs/tags/signed-short contents:raw' '
+	git cat-file tag refs/tags/signed-short >expected &&
+	git for-each-ref --format="%(contents:raw)" refs/tags/signed-short >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_atom refs/tags/signed-long subject 'subject line'
 test_atom refs/tags/signed-long subject:sanitize 'subject-line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
@@ -708,6 +728,15 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+test_expect_success 'basic atom: refs/tags/signed-long contents:raw' '
+	git cat-file tag refs/tags/signed-long >expected &&
+	git for-each-ref --format="%(contents:raw)" refs/tags/signed-long >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_expect_success 'set up refs pointing to tree and blob' '
 	git update-ref refs/mytrees/first refs/heads/main^{tree} &&
 	git update-ref refs/myblobs/first refs/heads/main:one
@@ -718,6 +747,7 @@ test_atom refs/mytrees/first contents:subject ""
 test_atom refs/mytrees/first body ""
 test_atom refs/mytrees/first contents:body ""
 test_atom refs/mytrees/first contents:signature ""
+test_atom refs/mytrees/first contents:raw $(git cat-file tree refs/mytrees/first)
 test_atom refs/mytrees/first contents ""
 
 test_atom refs/myblobs/first subject ""
@@ -725,6 +755,7 @@ test_atom refs/myblobs/first contents:subject ""
 test_atom refs/myblobs/first body ""
 test_atom refs/myblobs/first contents:body ""
 test_atom refs/myblobs/first contents:signature ""
+test_atom refs/myblobs/first contents:raw $(git cat-file blob refs/myblobs/first)
 test_atom refs/myblobs/first contents ""
 
 test_expect_success 'set up multiple-sort tags' '

base-commit: 97eea85a0a1ec66d356567808a1e4ca2367e0ce7
-- 
gitgitgadget
