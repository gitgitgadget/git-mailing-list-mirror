Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C2D1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdAYWD2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:28 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34856 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdAYWDY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:24 -0500
Received: by mail-pg0-f45.google.com with SMTP id 194so67614485pgd.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AoyJ1pbYSYnT2VDPJftIAahgKyQRo1wqhKjmyz9LT7A=;
        b=m+E0StlPLe0q+S+/1k1H4xdjgUTItlldRVeMsZVv42u/KyAonT8AcTrYJ7uGEi0Jqt
         nom0FzDSzdy7HTcEVIzJfgEE4xsxLCnQsVF+F4ZpZlEQXJS5smN4X7cZO8bWjADZ2442
         NUtGzEAz9kmC5jU+CDDc018kYiOFFPNXbhyOr94s7MOq6XgT/ELje13MgOeEGBsFsC9v
         kN8vC5Ek9HiFdKGzm3TZoKv7Cniin1p20g1LXS8KRosfPSJei9rBw3EVqOBd8MTIXTC9
         TwwDa1H/pX0xahU5E7g2teW6w61Rx6yHXnQPgV2GleMR4gC9h0plYw5vWOqkmOmDbOev
         2ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AoyJ1pbYSYnT2VDPJftIAahgKyQRo1wqhKjmyz9LT7A=;
        b=kpWU1q/XoX4c1wICeLv/tdJpXnV+nyxCcV8qNZ79r+g1U/G1AKHSGELVkPC399moBd
         hWO/P0K2NB/5zg48wpbmXIs5mGX+qw4jdFzFad8e+1exzzfaVKHjZAQdv63Vn5NGZFAY
         2hxu6BCeW5tbe4PMp9TIzVkM9KIuW5dqLJ4QUgotvfsyNjQFxo+7UpuQaE943jkDh0pV
         wS8QHb9fOQPZHBl0pJES3RA3oTPVxLFDzAo6SYI+lUPVXaz71DyEBFYrUa6SZrbB4IaR
         AssiwAiYJf8ytpnv/8aq8v68eVXQ5j9kXF/utDTvySKJ4kY35+C4C+7X4TXQsRAQPdvi
         yO+A==
X-Gm-Message-State: AIkVDXKN8uSCL2qVRRl+nWkh7W0/UGBKEmeVbumLh5J+Yhfnm6Hv9bwhjyh0Nff3E8ZxjAOU
X-Received: by 10.98.163.216 with SMTP id q85mr48847999pfl.123.1485381803135;
        Wed, 25 Jan 2017 14:03:23 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:22 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 06/14] fetch: refactor to make function args narrower
Date:   Wed, 25 Jan 2017 14:02:59 -0800
Message-Id: <4fc5ef88ae2135db475c557498e7a805afb693b9.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor find_non_local_tags and get_ref_map to only take the
information they need instead of the entire transport struct. Besides
improving code clarity, this also improves their flexibility, which will
be needed in a future patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 43e35c494..ae7c6daa1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -220,7 +220,7 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
-static void find_non_local_tags(struct transport *transport,
+static void find_non_local_tags(const struct ref *refs,
 			struct ref **head,
 			struct ref ***tail)
 {
@@ -230,7 +230,7 @@ static void find_non_local_tags(struct transport *transport,
 	struct string_list_item *item = NULL;
 
 	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
+	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
 
@@ -302,7 +302,8 @@ static void find_non_local_tags(struct transport *transport,
 	string_list_clear(&remote_refs, 0);
 }
 
-static struct ref *get_ref_map(struct transport *transport,
+static struct ref *get_ref_map(const struct remote *remote,
+			       const struct ref *remote_refs,
 			       struct refspec *refspecs, int refspec_count,
 			       int tags, int *autotags)
 {
@@ -314,8 +315,6 @@ static struct ref *get_ref_map(struct transport *transport,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport);
-
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 
 	if (refspec_count) {
@@ -355,8 +354,8 @@ static struct ref *get_ref_map(struct transport *transport,
 			fetch_refspec = parse_fetch_refspec(refmap_nr, refmap_array);
 			fetch_refspec_nr = refmap_nr;
 		} else {
-			fetch_refspec = transport->remote->fetch;
-			fetch_refspec_nr = transport->remote->fetch_refspec_nr;
+			fetch_refspec = remote->fetch;
+			fetch_refspec_nr = remote->fetch_refspec_nr;
 		}
 
 		for (i = 0; i < fetch_refspec_nr; i++)
@@ -365,7 +364,6 @@ static struct ref *get_ref_map(struct transport *transport,
 		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
 		/* Use the defaults */
-		struct remote *remote = transport->remote;
 		struct branch *branch = branch_get(NULL);
 		int has_merge = branch_has_merge_config(branch);
 		if (remote &&
@@ -404,7 +402,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		/* also fetch all tags */
 		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	else if (tags == TAGS_DEFAULT && *autotags)
-		find_non_local_tags(transport, &ref_map, &tail);
+		find_non_local_tags(remote_refs, &ref_map, &tail);
 
 	/* Now append any refs to be updated opportunistically: */
 	*tail = orefs;
@@ -1083,6 +1081,7 @@ static int do_fetch(struct transport *transport,
 	struct ref *ref_map;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
+	const struct ref *remote_refs;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1101,7 +1100,9 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+	remote_refs = transport_get_remote_refs(transport);
+	ref_map = get_ref_map(transport->remote, remote_refs, refs, ref_count,
+			      tags, &autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -1134,7 +1135,7 @@ static int do_fetch(struct transport *transport,
 	if (tags == TAGS_DEFAULT && autotags) {
 		struct ref **tail = &ref_map;
 		ref_map = NULL;
-		find_non_local_tags(transport, &ref_map, &tail);
+		find_non_local_tags(remote_refs, &ref_map, &tail);
 		if (ref_map)
 			backfill_tags(transport, ref_map);
 		free_refs(ref_map);
-- 
2.11.0.483.g087da7b7c-goog

