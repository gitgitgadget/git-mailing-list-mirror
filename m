Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60EA61FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdALXzg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:36 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35501 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f176.google.com with SMTP id f144so20587031pfa.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYc4XplfCksUw12tDxN5G+mNadTP3kvQzQglgcrgsLY=;
        b=EOU9CYCPwmgm/mbckzozt0bG15TjbrKQGCm4u4EJnYwk88mi5TbZYpBGqIyF1MYi1c
         A8HQVCdrBQjU9RIi+3ZaxUdxxF9o9DTrfvawj2fyp/kfLA5KJLUQhnhRZUzpev9L9y/2
         4QzN0GbfhfYgpz2206O1lazb16yCI3Y/v/D+kUwsATi/uD5HcCRWdTZ+yzHXkMNRT/yK
         EvYnUYXJvaXtNcukISAvKd4WDgv1pz0SJjCys97Tm04tQlzIVZzbmlQ61pr+g3dAK9Qr
         HzUtZW4kTLt5kV+85StOpA/RcWSdfjpjJn7yc5gVPI9lmU5wB2jD4zdRp+dcSdRhD90u
         jubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYc4XplfCksUw12tDxN5G+mNadTP3kvQzQglgcrgsLY=;
        b=KVs46yfYSWrisn0OWDtDY9baMqXvIsWu02dTlJMQ7KolSy/VbmQai+xc1if0sKe4fs
         crh7VKFnP58/vhL8xn3AO68gV3AcGjPrK1vbm3GOgNmW5ak+OPsX0u0xaNMgiBYfxbPx
         evmnOoW88XY5sqMNhRYSXCQaqUMwYb5MrzzIEzkoaFr4JuKJmW1x3D1tinffRwe6h5MK
         xEicSOtYrEXO6b0lIE/TJj0rTii4w/7GQEeu2MZqjXYAPNkd9Yv0jHqH/DnSU1z0hq4z
         A71wCUaKz4s1d3ArGoxGIlxtW++9VEI8SsRykttiUwCS4hmGGZiKpvAc8DAE9yJ70g0O
         Ii7g==
X-Gm-Message-State: AIkVDXKu1EKWyhKofAUZs0Ds6onWgYvdr9d/b+E3HFt6DO1br+XdwAroW25hnX3FUAliWy+f
X-Received: by 10.99.37.2 with SMTP id l2mr20600253pgl.160.1484265270504;
        Thu, 12 Jan 2017 15:54:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 18/27] attr: retire git_check_attrs() API
Date:   Thu, 12 Jan 2017 15:53:45 -0800
Message-Id: <20170112235354.153403-19-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Since nobody uses the old API, make it file-scope static, and update
the documentation to describe the new API.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/api-gitattributes.txt | 86 +++++++++++++++++----------
 attr.c                                        |  3 +-
 attr.h                                        |  1 -
 3 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 260266867..82f5130e7 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -16,10 +16,15 @@ Data Structure
 	of no interest to the calling programs.  The name of the
 	attribute can be retrieved by calling `git_attr_name()`.
 
-`struct git_attr_check`::
+`struct attr_check_item`::
 
-	This structure represents a set of attributes to check in a call
-	to `git_check_attr()` function, and receives the results.
+	This structure represents one attribute and its value.
+
+`struct attr_check`::
+
+	This structure represents a collection of `attr_check_item`.
+	It is passed to `git_check_attr()` function, specifying the
+	attributes to check, and receives their values.
 
 
 Attribute Values
@@ -27,7 +32,7 @@ Attribute Values
 
 An attribute for a path can be in one of four states: Set, Unset,
 Unspecified or set to a string, and `.value` member of `struct
-git_attr_check` records it.  There are three macros to check these:
+attr_check_item` records it.  There are three macros to check these:
 
 `ATTR_TRUE()`::
 
@@ -48,49 +53,51 @@ value of the attribute for the path.
 Querying Specific Attributes
 ----------------------------
 
-* Prepare an array of `struct git_attr_check` to define the list of
-  attributes you would want to check.  To populate this array, you would
-  need to define necessary attributes by calling `git_attr()` function.
+* Prepare `struct attr_check` using attr_check_initl()
+  function, enumerating the names of attributes whose values you are
+  interested in, terminated with a NULL pointer.  Alternatively, an
+  empty `struct attr_check` can be prepared by calling
+  `attr_check_alloc()` function and then attributes you want to
+  ask about can be added to it with `attr_check_append()`
+  function.
 
 * Call `git_check_attr()` to check the attributes for the path.
 
-* Inspect `git_attr_check` structure to see how each of the attribute in
-  the array is defined for the path.
+* Inspect `attr_check` structure to see how each of the
+  attribute in the array is defined for the path.
 
 
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
-. Prepare an array of `struct git_attr_check` with two elements (because
-  we are checking two attributes).  Initialize their `attr` member with
-  pointers to `struct git_attr` obtained by calling `git_attr()`:
+. Prepare a `struct attr_check` with two elements (because
+  we are checking two attributes):
 
 ------------
-static struct git_attr_check check[2];
+static struct attr_check *check;
 static void setup_check(void)
 {
-	if (check[0].attr)
+	if (check)
 		return; /* already done */
-	check[0].attr = git_attr("crlf");
-	check[1].attr = git_attr("ident");
+	check = attr_check_initl("crlf", "ident", NULL);
 }
 ------------
 
-. Call `git_check_attr()` with the prepared array of `struct git_attr_check`:
+. Call `git_check_attr()` with the prepared `struct attr_check`:
 
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
+static struct attr_check *check;
+static void setup_check(const char **argv)
+{
+	check = attr_check_alloc();
+	while (*argv) {
+		struct git_attr *attr = git_attr(*argv);
+		attr_check_append(check, attr);
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
+* Prepare an empty `attr_check` structure by calling
+  `attr_check_alloc()`.
+
+* Call `git_all_attrs()`, which populates the `attr_check`
+  with the attributes attached to the path.
 
-* Iterate over the `git_attr_check` array to examine the attribute
-  names and values.  The name of the attribute described by a
-  `git_attr_check` object can be retrieved via
-  `git_attr_name(check[i].attr)`.  (Please note that no items will be
-  returned for unset attributes, so `ATTR_UNSET()` will return false
-  for all returned `git_array_check` objects.)
+* Iterate over the `attr_check.check[]` array to examine
+  the attribute names and values.  The name of the attribute
+  described by a  `attr_check.check[]` object can be retrieved via
+  `git_attr_name(check->check[i].attr)`.  (Please note that no items
+  will be returned for unset attributes, so `ATTR_UNSET()` will return
+  false for all returned `attr_check.check[]` objects.)
 
-* Free the `git_array_check` array.
+* Free the `attr_check` struct by calling `attr_check_free()`.
diff --git a/attr.c b/attr.c
index d2eaa0410..da727e3fd 100644
--- a/attr.c
+++ b/attr.c
@@ -821,7 +821,8 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attrs(const char *path, int num, struct attr_check_item *check)
+static int git_check_attrs(const char *path, int num,
+			   struct attr_check_item *check)
 {
 	int i;
 
diff --git a/attr.h b/attr.h
index 971bb9a38..3db9893ef 100644
--- a/attr.h
+++ b/attr.h
@@ -52,7 +52,6 @@ extern void attr_check_free(struct attr_check *check);
  */
 extern const char *git_attr_name(const struct git_attr *);
 
-int git_check_attrs(const char *path, int, struct attr_check_item *);
 extern int git_check_attr(const char *path, struct attr_check *check);
 
 /*
-- 
2.11.0.390.gc69c2f50cf-goog

