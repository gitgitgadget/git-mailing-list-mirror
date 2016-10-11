Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0339320989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbcJKAVv (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34533 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJKAVs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id rz1so3952007pab.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YWpCxBz8FHLrJOWeopVq+QjfcYypdZzzW7cG3IvdREA=;
        b=MaooB+/NFQaUn+BHu3R/ul0mUbNUeX22IhYkSxOQFDT790kFmmGcO07xnaaS4ot6aJ
         LlEvg0lx75b6bykdeBAySykZpc7egUWDv62tR3RX0HG5FIvB/1JSkAXv1hz+YF/+SUV2
         mowCcUVSqKAWclPS36P20fRaNc01Unk/NhFhb8pvTxHqQ6NAlhKKsi5GzLAN39mUteuF
         tZMykRAQcZEQTGHhZakO7aTv9i/5Rl38wKIKZFQ5ESHXkabBAYyyoS9iwmqYzrx1AqK9
         pYwlO++YGE2+Ja8q4TALdMKuf5k1a8RiWbp4CXJC0BuZ/DuVQQPR1sjeDs/FX0dwvvPP
         8YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YWpCxBz8FHLrJOWeopVq+QjfcYypdZzzW7cG3IvdREA=;
        b=Q0HknXFranDYtOp8+GCqsGgpIWqMVP11zJEk4YVeESqYn7zKx7wpsFlw/eMoi+GW4X
         gXBXoaf2HskGY4wBb9Hs5TvFSdOnQoiKYpj89oWJvqw3WYtq19c1SU5a2cTzjoNhNs57
         zwRYzqknqG+Utby6G4r+BKIt6jxe2RydxQv3R0c7zGe/+2ZQyc4YCZM9RbxNIG7xKZbI
         fWt7h86U98fvGiy2Is00TazgRdczCAe2Px2FUxg0yA3ZLzBPkZADPso2QJvHNQlG3kyy
         KN7ajNsXml7G6OWcWf4+YmuQ9B/YxRKaZs87cCuVGzgmELk3yJZdqHNnnUxueU7i+w3m
         +10g==
X-Gm-Message-State: AA6/9Rm3iNKbQ03K6sW5woZIpq8smsraZmQacO1BwyusGXVJaMwDFTybwqQYoTRCOG2bbzdM
X-Received: by 10.66.184.74 with SMTP id es10mr1623885pac.187.1476145307649;
        Mon, 10 Oct 2016 17:21:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id fm6sm499221pab.37.2016.10.10.17.21.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/28] attr: retire git_check_attrs() API
Date:   Mon, 10 Oct 2016 17:21:01 -0700
Message-Id: <20161011002115.23312-15-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
2.10.1.382.ga23ca1b.dirty

