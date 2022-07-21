Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B780C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiGUMBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiGUMBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:01:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B07B7A8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so908209wmn.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxPjBoqxyuQfwTsVk9XyGwL1XhjjKrXhRc8FW3eRg90=;
        b=d/zC0mW+Bs5Guiu1Y37YVOIRt94gCIOtm2kg3eJ+UWTrz4kbLiXH4olYo96ixwO7LM
         hE6nH6DDCkFNlvMAUapdfXv09mukXz1P6dR5HCY7EWxTIBnND8rMMIE0frpfTpRPOnx1
         1HCI7ygNCCv8LuEeV2vl8kTD/D8dcb7pD5wQ8qKW4Xa8r4MIYZFWxNquD5dM8HKV8Hoz
         aMoblgD5a6T3qkxtPE940Xd5d4ar2lHowTTm/RQkxqiXmbPoFSunMVGYdXzrNTIWdAj9
         Wvz9VzGFqE+K5hV5Feo6Ew8yv/64XnmfhbOgB+3eBPLbZZJeCJ0PZgFB2upsXNuaA9ov
         zPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxPjBoqxyuQfwTsVk9XyGwL1XhjjKrXhRc8FW3eRg90=;
        b=c1IuWVJm6IKSDcSCazPsLAQShdveUaxNUWPJCFSo4EGNiR1tTpMeENzHsZXd3+n0sk
         W6yty6uKdjAukrlPENaGy651ajL5us604Js/Lnu7m00qcBNZcxgJY43PQKUnBmCy8Rvi
         ODBc4NB1udTxgPMEiZFm//u8SXgguK3Lb/F5lR/Y+RRaPkWK/zni8094fOaOVLvoDWcq
         HHz5xR4QkYC7frHaV2dd9fl19Z5Cp4zmghtSnRTv8AMO1qXIk2+N0KZkSymISraB2bo+
         DkulKOwUrBEry95UwqkZZOSm50QfqvfCKskzikTPtNzoFG79C2mG3G1tPiL28cGaDbiH
         mv1A==
X-Gm-Message-State: AJIora/Zqk9q3za0d+lBFRfh7Z5O2BeQo/am1KCntm5Mt911m8Tdo/Wr
        m3EOqSm3TvO1Fzv/Vt2Q1Ua20fED/ZTNKA==
X-Google-Smtp-Source: AGRyM1tShZyZuSQyfEzxABJL86Q4ef6YrVnGaksMhgH2qYN4+RPTbHjPapB9eXc6wS1YXTnWHbT+0g==
X-Received: by 2002:a05:600c:1ca8:b0:3a3:19c9:5448 with SMTP id k40-20020a05600c1ca800b003a319c95448mr8104586wms.40.1658404873172;
        Thu, 21 Jul 2022 05:01:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm5226069wmh.33.2022.07.21.05.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:01:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] cocci: add "string_list" rule to swap "DUP" <-> "NODUP"
Date:   Thu, 21 Jul 2022 14:00:51 +0200
Message-Id: <patch-v2-4.6-2d858c49243-20220721T111808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule to swap "NODUP" and "DUP" initialization in
cases such as [1], which as this change shows produces an identical
change.

We happened to have only one change in-tree that matched this
criteria, but now we're more certain of that, and will convert these
sorts of cases in the future.

1. https://lore.kernel.org/git/xmqq7d471dns.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/remote.c                         |  3 +--
 contrib/coccinelle/string-list.cocci     | 18 ++++++++++++++++++
 contrib/coccinelle/tests/string-list.c   | 13 +++++++++++++
 contrib/coccinelle/tests/string-list.res | 11 +++++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d9b8746cb3c..c713463d89d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1229,10 +1229,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct string_list list = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
-	list.strdup_strings = 1;
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
diff --git a/contrib/coccinelle/string-list.cocci b/contrib/coccinelle/string-list.cocci
index 5d285d5732c..63bb2abc93a 100644
--- a/contrib/coccinelle/string-list.cocci
+++ b/contrib/coccinelle/string-list.cocci
@@ -6,3 +6,21 @@ struct string_list *P;
 ... when != P
 - (P)->strdup_strings = 1;
 + string_list_init_dup(P);
+
+@@
+type T;
+identifier I;
+constant INIT_NODUP =~ "^STRING_LIST_INIT_NODUP$";
+constant INIT_DUP =~ "^STRING_LIST_INIT_DUP$";
+@@
+(
+- T I = INIT_NODUP;
++ T I = STRING_LIST_INIT_DUP;
+... when != &I
+- I.strdup_strings = 1;
+|
+- T I = INIT_DUP;
++ T I = STRING_LIST_INIT_NODUP;
+... when != &I
+- I.strdup_strings = 0;
+)
diff --git a/contrib/coccinelle/tests/string-list.c b/contrib/coccinelle/tests/string-list.c
index e77822b7682..1821ed4ebb4 100644
--- a/contrib/coccinelle/tests/string-list.c
+++ b/contrib/coccinelle/tests/string-list.c
@@ -1,7 +1,20 @@
 int init(void)
 {
 	struct string_list *list;
+	struct string_list list2 = STRING_LIST_INIT_NODUP;
+	struct string_list list3 = STRING_LIST_INIT_DUP;
+	struct string_list list4 = STRING_LIST_INIT_NODUP;
+	struct string_list list5 = STRING_LIST_INIT_DUP;
 
 	CALLOC_ARRAY(list, 1);
+
+	/* Exclude these */
+	string_list_append(&list4, "str");
+	string_list_append_nodup(&list5, xstrdup("str"));
+
 	list->strdup_strings = 1;
+	list2.strdup_strings = 1;
+	list3.strdup_strings = 0;
+	list4.strdup_strings = 1;
+	list5.strdup_strings = 0;
 }
diff --git a/contrib/coccinelle/tests/string-list.res b/contrib/coccinelle/tests/string-list.res
index 7e666f5bf48..58b3733dec2 100644
--- a/contrib/coccinelle/tests/string-list.res
+++ b/contrib/coccinelle/tests/string-list.res
@@ -1,7 +1,18 @@
 int init(void)
 {
 	struct string_list *list;
+	struct string_list list2 = STRING_LIST_INIT_DUP;
+	struct string_list list3 = STRING_LIST_INIT_NODUP;
+	struct string_list list4 = STRING_LIST_INIT_NODUP;
+	struct string_list list5 = STRING_LIST_INIT_DUP;
 
 	ALLOC_ARRAY(list, 1);
+
+	/* Exclude these */
+	string_list_append(&list4, "str");
+	string_list_append_nodup(&list5, xstrdup("str"));
+
 	string_list_init_dup(list);
+	list4.strdup_strings = 1;
+	list5.strdup_strings = 0;
 }
-- 
2.37.1.1095.g64a1e8362fd

