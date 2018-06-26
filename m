Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FC41F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbeFZUz3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:55:29 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:52638 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933992AbeFZUy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:56 -0400
Received: by mail-qt0-f201.google.com with SMTP id g8-v6so14568024qtp.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rvB4ELyLB2acVfOcLwY5g+fUNIVfjN/cz9VJYBid6jg=;
        b=rdpcFK62mTqxAsd1gZdO8hFfeT+VtMwTUpsYX+iLj+WoEglfkl9VaMjFqAjuEjRrP/
         dqT9VKGbsu0vOf/UtvWoute8P344rDpkJevnXqoVJoULi8p5xq7Oerstd5Y/ZJr7kV2a
         CbQ3lNV8LOFHt9nPwd8rrMe7fkFCZmLXM5rKCPYq2kJ5TY4lu+EBCYhh5FfPWF69B1Hl
         wLGf4BDj6v+aVB39jh50bXaqAH3grW1lUwVvfqAuzoXG1DK6rrhFwk7OhNRiMeadORMi
         TRcRM2msC1Y/w8PaOXgk+o9K/fEB3HGUziZNbI9irwqRVAo+gp2Wv2EVKqmIIx7xQeO3
         nRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rvB4ELyLB2acVfOcLwY5g+fUNIVfjN/cz9VJYBid6jg=;
        b=E+Ja/+SkPMh/8sEGD85ArOFJMQKfmvdKq6CUXIjqWjcbkaJRHrA4MGjeXmJzZraoCL
         ErTisrtkyxWRH9lNzc3FMYRhDu6EkAk7axSUbMY7ONFW0mI8BDKa/C2V2U4oodcEvZaG
         5/x0SrZhBHsYLNhRmS/vHz3LIbT5Rtd/Js2snrQTu5HwB3TBvL64FeRk1113DNUltHK5
         rF/uhVz7z9dVWWEMgA1B/XK84XLu5IW/2V4rBSSr42CnUGeIZ4vtk+EKHm+H9aPk2280
         mV5/CBRQPJKtMyLrtClzxSxkm90HzsC9CFwWxH1dHXxhZzdb56nom3nGfXOb14ffPJMj
         H8wQ==
X-Gm-Message-State: APt69E1HQAe3SeqWBW1yAqfOgdXvS3j1mcVKtzpLpmTHpxQmi3jAUTsI
        FErDgmj655lzHN0myKc6gN1DQ8LaBboa8UqfLbCqD8zsPfFZM7faNS3elWt/8xqAXw7A0R5VNSf
        46BtPb1tY9IwkVuIHz8OHdk0fIwNo0tJwdaqdSSb8+fGvNKmmbkRvRFkGXA==
X-Google-Smtp-Source: AAOMgpeSENoYxC4JzqcVNVJTwVLQVp59fpKLf5PXPxEz11QAta5qubqi2kyiMdN8wFNS1LX7//Px4jpxx7U=
MIME-Version: 1.0
X-Received: by 2002:a0c:d2da:: with SMTP id x26-v6mr1649340qvh.36.1530046496109;
 Tue, 26 Jun 2018 13:54:56 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:36 -0700
In-Reply-To: <20180626205438.110764-1-bmwill@google.com>
Message-Id: <20180626205438.110764-7-bmwill@google.com>
References: <20180625185332.164142-1-bmwill@google.com> <20180626205438.110764-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 6/8] fetch: refactor to make function args narrower
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor find_non_local_tags and get_ref_map to only take the
information they need instead of the entire transport struct. Besides
improving code clarity, this also improves their flexibility, allowing
for a different set of refs to be used instead of relying on the ones
stored in the transport struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2fabfed0e..bda00e826 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -254,9 +254,9 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
-static void find_non_local_tags(struct transport *transport,
-			struct ref **head,
-			struct ref ***tail)
+static void find_non_local_tags(const struct ref *refs,
+				struct ref **head,
+				struct ref ***tail)
 {
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
@@ -264,7 +264,7 @@ static void find_non_local_tags(struct transport *transport,
 	struct string_list_item *item = NULL;
 
 	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport, NULL); ref; ref = ref->next) {
+	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
 
@@ -338,7 +338,8 @@ static void find_non_local_tags(struct transport *transport,
 	string_list_clear(&remote_refs, 0);
 }
 
-static struct ref *get_ref_map(struct transport *transport,
+static struct ref *get_ref_map(struct remote *remote,
+			       const struct ref *remote_refs,
 			       struct refspec *rs,
 			       int tags, int *autotags)
 {
@@ -346,27 +347,11 @@ static struct ref *get_ref_map(struct transport *transport,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
-	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
-	const struct ref *remote_refs;
-
-	if (rs->nr)
-		refspec_ref_prefixes(rs, &ref_prefixes);
-	else if (transport->remote && transport->remote->fetch.nr)
-		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
-
-	if (ref_prefixes.argc &&
-	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
-		argv_array_push(&ref_prefixes, "refs/tags/");
-	}
-
-	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
-
-	argv_array_clear(&ref_prefixes);
 
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
@@ -403,7 +388,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		if (refmap.nr)
 			fetch_refspec = &refmap;
 		else
-			fetch_refspec = &transport->remote->fetch;
+			fetch_refspec = &remote->fetch;
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
@@ -411,7 +396,6 @@ static struct ref *get_ref_map(struct transport *transport,
 		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
 		/* Use the defaults */
-		struct remote *remote = transport->remote;
 		struct branch *branch = branch_get(NULL);
 		int has_merge = branch_has_merge_config(branch);
 		if (remote &&
@@ -450,7 +434,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		/* also fetch all tags */
 		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	else if (tags == TAGS_DEFAULT && *autotags)
-		find_non_local_tags(transport, &ref_map, &tail);
+		find_non_local_tags(remote_refs, &ref_map, &tail);
 
 	/* Now append any refs to be updated opportunistically: */
 	*tail = orefs;
@@ -1143,6 +1127,8 @@ static int do_fetch(struct transport *transport,
 	struct ref *ref_map;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
+	const struct ref *remote_refs;
+	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1158,7 +1144,21 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	ref_map = get_ref_map(transport, rs, tags, &autotags);
+	if (rs->nr)
+		refspec_ref_prefixes(rs, &ref_prefixes);
+	else if (transport->remote && transport->remote->fetch.nr)
+		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
+
+	if (ref_prefixes.argc &&
+	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
+		argv_array_push(&ref_prefixes, "refs/tags/");
+	}
+
+	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+	argv_array_clear(&ref_prefixes);
+
+	ref_map = get_ref_map(transport->remote, remote_refs, rs,
+			      tags, &autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -1190,7 +1190,7 @@ static int do_fetch(struct transport *transport,
 	if (tags == TAGS_DEFAULT && autotags) {
 		struct ref **tail = &ref_map;
 		ref_map = NULL;
-		find_non_local_tags(transport, &ref_map, &tail);
+		find_non_local_tags(remote_refs, &ref_map, &tail);
 		if (ref_map)
 			backfill_tags(transport, ref_map);
 		free_refs(ref_map);
-- 
2.18.0.rc2.346.g013aa6912e-goog

