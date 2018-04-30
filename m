Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40989215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeD3WIA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:08:00 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36387 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbeD3WH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:07:56 -0400
Received: by mail-wr0-f175.google.com with SMTP id u18-v6so9376652wrg.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvADi3249fotDeg8egf4T8Jw4VN8OwjA2e7Q7rIAVjw=;
        b=RpSNfEDUsbCxcbVtW/U+kZG1MlArjCaPFTjlMGhnDWx0ieJrPIin6mKZWQ2deNRyef
         ZhAispG+f85qmKorpJ0/wRjg3FKuPKuW1R1kyqWtEW/XjaCC2i/U33QTWSSzeaYJ98ha
         RKEtu2y3sd4VXx74xdFkzYnvMgPh2G06adLnXufLhMsBW5WFqCfPQvDC6xi97eb/em0/
         xaTz5f0JHBZn3g2zx5/fZg6CP0RBTlP44/pxy9AmQ77sZjPUpuHZSPd11gcJM+DuaI03
         tanQmxVhUbp+StZ9du2Y7w9CiqH1qeAeGsa0ISDuOnKHPakTaPbtHfGYAhxdUYkp2RKK
         +PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvADi3249fotDeg8egf4T8Jw4VN8OwjA2e7Q7rIAVjw=;
        b=NF+zRJMr6E7s7s/hqlVZWCKYD17QEuPJLGoCUHX2wNDBKJGlqERRiXSFZ/KoOhgfjU
         RXfQct1O8olpNo/4jxMuBP1pxHMG0FlFEuKn2d0VsIWgCMg1Y1MbnkcgCMK/MNC+k3Be
         RklC0BYOAOd2KPz7+3NO36KjeB/uSgxeGvnAESFIBuj9Hr3VsQ7JuuC8hx1itt1F5X+U
         hCV+0RYmqgXqIhp7r3uA/XzYgiZSzuVyUGSnALhLsURaRWSKcknPJ9CtVm7T4hBbh8iq
         EIOFHk3Z1piUqEBfjoORLNpUV3IHzhd9MSULOqBQDsEbWL3IqSGieK31Q+00B4nwndDR
         cM4w==
X-Gm-Message-State: ALQs6tCEH9KrkGBZbztEuHt/YC5mX4CjHomDqOaDuHa7s2mjn1Je0A0i
        QMOWatwhXUN8CkijeEDnSHPIt0RM
X-Google-Smtp-Source: AB8JxZphzAiQsCCBMs62YwkW7k70WWlh3RtHQMdbr/0gUlX+kvQ1F5jZ9DA6jEc/AjC0CfoZi8vQ/w==
X-Received: by 2002:adf:988c:: with SMTP id w12-v6mr9613069wrb.215.1525126075052;
        Mon, 30 Apr 2018 15:07:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:07:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/9] get_short_oid: sort ambiguous objects by type, then SHA-1
Date:   Mon, 30 Apr 2018 22:07:29 +0000
Message-Id: <20180430220734.30133-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output emitted when an ambiguous object is encountered so
that we show tags first, then commits, followed by trees, and finally
blobs. Within each type we show objects in hashcmp(). Before this
change the objects were only ordered by hashcmp().

The reason for doing this is that the output looks better as a result,
e.g. the v2.17.0 tag before this change on "git show e8f2" would
display:

    hint: The candidates are:
    hint:   e8f2093055 tree
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f25a3a50 tree
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2650052 tag v2.17.0
    hint:   e8f2867228 blob
    hint:   e8f28d537c tree
    hint:   e8f2a35526 blob
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2cf6ec0 tree

Now we'll instead show:

    hint:   e8f2650052 tag v2.17.0
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob

Since we show the commit data in the output that's nicely aligned once
we sort by object type. The decision to show tags before commits is
pretty arbitrary, but it's much less likely that we'll display a tag,
so if there is one it makes sense to show it first.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-array.c | 15 +++++++++++++++
 sha1-array.h |  3 +++
 sha1-name.c  | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/sha1-array.c b/sha1-array.c
index 838b3bf847..48bd9e9230 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -41,6 +41,21 @@ void oid_array_clear(struct oid_array *array)
 	array->sorted = 0;
 }
 
+
+int oid_array_for_each(struct oid_array *array,
+		       for_each_oid_fn fn,
+		       void *data)
+{
+	int i;
+
+	for (i = 0; i < array->nr; i++) {
+		int ret = fn(array->oid + i, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int oid_array_for_each_unique(struct oid_array *array,
 				for_each_oid_fn fn,
 				void *data)
diff --git a/sha1-array.h b/sha1-array.h
index 1e1d24b009..232bf95017 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -16,6 +16,9 @@ void oid_array_clear(struct oid_array *array);
 
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
+int oid_array_for_each(struct oid_array *array,
+		       for_each_oid_fn fn,
+		       void *data);
 int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
diff --git a/sha1-name.c b/sha1-name.c
index 9d7bbd3e96..46d8b1afa6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -378,6 +378,34 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int sort_ambiguous(const void *a, const void *b)
+{
+	int a_type = oid_object_info(a, NULL);
+	int b_type = oid_object_info(b, NULL);
+	int a_type_sort;
+	int b_type_sort;
+
+	/*
+	 * Sorts by hash within the same object type, just as
+	 * oid_array_for_each_unique() would do.
+	 */
+	if (a_type == b_type)
+		return oidcmp(a, b);
+
+	/*
+	 * Between object types show tags, then commits, and finally
+	 * trees and blobs.
+	 *
+	 * The object_type enum is commit, tree, blob, tag, but we
+	 * want tag, commit, tree blob. Cleverly (perhaps too
+	 * cleverly) do that with modulus, since the enum assigns 1 to
+	 * commit, so tag becomes 0.
+	 */
+	a_type_sort = a_type % 4;
+	b_type_sort = b_type % 4;
+	return a_type_sort > b_type_sort ? 1 : -1;
+}
+
 static int get_short_oid(const char *name, int len, struct object_id *oid,
 			  unsigned flags)
 {
@@ -409,6 +437,8 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 	status = finish_object_disambiguation(&ds, oid);
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
+		struct oid_array collect = OID_ARRAY_INIT;
+
 		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
 
 		/*
@@ -421,7 +451,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 			ds.fn = NULL;
 
 		advise(_("The candidates are:"));
-		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
+		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
+		QSORT(collect.oid, collect.nr, sort_ambiguous);
+
+		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
+			BUG("show_ambiguous_object shouldn't return non-zero");
+		oid_array_clear(&collect);
 	}
 
 	return status;
-- 
2.17.0.290.gded63e768a

