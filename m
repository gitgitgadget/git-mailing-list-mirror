Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611D720987
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964947AbcJVXdF (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:05 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35525 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935287AbcJVXdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:00 -0400
Received: by mail-it0-f52.google.com with SMTP id 198so53154488itw.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b7r6XvtDWO+t5VnLx1UdQv59ASo89PYnLyFUibI7pwQ=;
        b=n6Qph1soM4vkyYiN/i2x3EFA06Mco9p2F5RBmpMmN5lMxivOJewvYt/lq5Ad7Bv87L
         ez/WjFIKQlMwVwRpBfQH1rXsy7PNOyG2xwJ7j2vbzobWJebDdf5vA6skalZ/kMBY1jJB
         zdneRxwTvfEhXid/7oKMRSURvNBdYkWibgrqi66YlEs1rzCpJA8+lD4NVmpVOrLzbz9e
         gY32+CcrKgLiYF94omG/JBJgVxM82epMBUHKBgd7LM3hdJBWcKkylf/C1yJXre9/YaAb
         VDMfwGP/80a/iiKwIubWhcK3krja4XYOyRgNhiORhsabh0XpOmbQ3vDXr1NJImvQnbTs
         LS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b7r6XvtDWO+t5VnLx1UdQv59ASo89PYnLyFUibI7pwQ=;
        b=gLkMNwsT1vG8DtxNdm3z7EYfDkuLVlK8uU2CT4yFvUxygTV/F/ytev5rEoj69zxt8L
         iZD0vPDuo73anAitLwPyTod66NgdQozNcW6dp5IsdlfXYyO3TfDWSIET0r+sV1EuQ9LN
         YyW/LG1x8j5vUSLAAjyniq4Reo+pyPnyd7yF6LIy3dHsiJnhiRLDmMACowbtjUaUPRkQ
         dEZFmsh3/XPdOd99DnG7FNg/3I7eNz60ZhAQ1cidkjCS0/GaYa8uz+0+6yk+nq21p1NG
         UZLDNvbUUFQx+YwXJFN6i67nCD0WWlqPXm88ykUajG1M1f9fE/0XTeGe9Zkl+MzlXQpi
         K70g==
X-Gm-Message-State: ABUngveEFp0zMSBrlZYusXUkXdMrabnadAOwV27Kttvu6McsqE9JYIdeWAMq/To2nY5bMf+f
X-Received: by 10.36.14.145 with SMTP id 139mr4669632ite.63.1477179179002;
        Sat, 22 Oct 2016 16:32:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id k2sm1983463ith.11.2016.10.22.16.32.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/36] attr: retire git_check_attrs() API
Date:   Sat, 22 Oct 2016 16:32:03 -0700
Message-Id: <20161022233225.8883-15-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Since nobody uses the old API, make it file-scope static, and update
the documentation to describe the new API.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-gitattributes.txt | 82 ++++++++++++++++++---------
 attr.c                                        |  3 +-
 attr.h                                        |  2 -
 3 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 2602668..92fc32a 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -16,10 +16,15 @@ Data Structure
 	of no interest to the calling programs.  The name of the
 	attribute can be retrieved by calling `git_attr_name()`.
 
+`struct git_attr_check_elem`::
+
+	This structure represents one attribute and its value.
+
 `struct git_attr_check`::
 
-	This structure represents a set of attributes to check in a call
-	to `git_check_attr()` function, and receives the results.
+	This structure represents a collection of `git_attr_check_elem`.
+	It is passed to `git_check_attr()` function, specifying the
+	attributes to check, and receives their values.
 
 
 Attribute Values
@@ -48,49 +53,51 @@ value of the attribute for the path.
 Querying Specific Attributes
 ----------------------------
 
-* Prepare an array of `struct git_attr_check` to define the list of
-  attributes you would want to check.  To populate this array, you would
-  need to define necessary attributes by calling `git_attr()` function.
+* Prepare `struct git_attr_check` using git_attr_check_initl()
+  function, enumerating the names of attributes whose values you are
+  interested in, terminated with a NULL pointer.  Alternatively, an
+  empty `struct git_attr_check` can be prepared by calling
+  `git_attr_check_alloc()` function and then attributes you want to
+  ask about can be added to it with `git_attr_check_append()`
+  function.
 
 * Call `git_check_attr()` to check the attributes for the path.
 
-* Inspect `git_attr_check` structure to see how each of the attribute in
-  the array is defined for the path.
+* Inspect `git_attr_check` structure to see how each of the
+  attribute in the array is defined for the path.
 
 
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
-. Prepare an array of `struct git_attr_check` with two elements (because
-  we are checking two attributes).  Initialize their `attr` member with
-  pointers to `struct git_attr` obtained by calling `git_attr()`:
+. Prepare a `struct git_attr_check` with two elements (because
+  we are checking two attributes):
 
 ------------
-static struct git_attr_check check[2];
+static struct git_attr_check *check;
 static void setup_check(void)
 {
-	if (check[0].attr)
+	if (check)
 		return; /* already done */
-	check[0].attr = git_attr("crlf");
-	check[1].attr = git_attr("ident");
+	check = git_attr_check_initl("crlf", "ident", NULL);
 }
 ------------
 
-. Call `git_check_attr()` with the prepared array of `struct git_attr_check`:
+. Call `git_check_attr()` with the prepared `struct git_attr_check`:
 
 ------------
 	const char *path;
 
 	setup_check();
-	git_check_attr(path, ARRAY_SIZE(check), check);
+	git_check_attr(path, check);
 ------------
 
-. Act on `.value` member of the result, left in `check[]`:
+. Act on `.value` member of the result, left in `check->check[]`:
 
 ------------
-	const char *value = check[0].value;
+	const char *value = check->check[0].value;
 
 	if (ATTR_TRUE(value)) {
 		The attribute is Set, by listing only the name of the
@@ -109,20 +116,39 @@ static void setup_check(void)
 	}
 ------------
 
+To see how attributes in argv[] are set for different paths, only
+the first step in the above would be different.
+
+------------
+static struct git_attr_check *check;
+static void setup_check(const char **argv)
+{
+	check = git_attr_check_alloc();
+	while (*argv) {
+		struct git_attr *attr = git_attr(*argv);
+		git_attr_check_append(check, attr);
+		argv++;
+	}
+}
+------------
+
 
 Querying All Attributes
 -----------------------
 
 To get the values of all attributes associated with a file:
 
-* Call `git_all_attrs()`, which returns an array of `git_attr_check`
-  structures.
+* Prepare an empty `git_attr_check` structure by calling
+  `git_attr_check_alloc()`.
+
+* Call `git_all_attrs()`, which populates the `git_attr_check`
+  with the attributes attached to the path.
 
-* Iterate over the `git_attr_check` array to examine the attribute
-  names and values.  The name of the attribute described by a
-  `git_attr_check` object can be retrieved via
-  `git_attr_name(check[i].attr)`.  (Please note that no items will be
-  returned for unset attributes, so `ATTR_UNSET()` will return false
-  for all returned `git_array_check` objects.)
+* Iterate over the `git_attr_check.check[]` array to examine
+  the attribute names and values.  The name of the attribute
+  described by a  `git_attr_check.check[]` object can be retrieved via
+  `git_attr_name(check->check[i].attr)`.  (Please note that no items
+  will be returned for unset attributes, so `ATTR_UNSET()` will return
+  false for all returned `git_array_check` objects.)
 
-* Free the `git_array_check` array.
+* Free the `git_array_check` by calling `git_attr_check_free()`.
diff --git a/attr.c b/attr.c
index 76f0d6b..d427798 100644
--- a/attr.c
+++ b/attr.c
@@ -778,7 +778,8 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attrs(const char *path, int num, struct git_attr_check_elem *check)
+static int git_check_attrs(const char *path, int num,
+			   struct git_attr_check_elem *check)
 {
 	int i;
 
diff --git a/attr.h b/attr.h
index 0d94077..506db0c 100644
--- a/attr.h
+++ b/attr.h
@@ -52,8 +52,6 @@ extern void git_attr_check_free(struct git_attr_check *);
  */
 extern const char *git_attr_name(const struct git_attr *);
 
-int git_check_attrs(const char *path, int, struct git_attr_check_elem *);
-
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
-- 
2.10.1.508.g6572022

