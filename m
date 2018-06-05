Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5A71F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeFERwM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:52:12 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:32814 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbeFERwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:09 -0400
Received: by mail-qk0-f202.google.com with SMTP id x186-v6so3339211qkb.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=VZi83QdjM/67jwDV4MsmJQpfGMjyY/pQsdfkKghpIqk=;
        b=Yt77UPaYMdcKibqA63efnYUefZgPQZ57pLn2cbpj1DS4F3vqs0eCzBOj1+z1pS5htS
         aYSKw5eTa+xpmorjWj+5ORXzSqGHX792Gk9tg20kE0+K4HRi3M7YsdjU8SiYO0KAvcsQ
         Uxn80m1rHqR32EUfAbJjdqmz4RqzpA/3pooaG3bGTwnFPCS9CmxGs1ModIOrPdHsyEYE
         J+rZsfqmUhBVy180t58/HjNf6jbnJrMpDaVLWs+GcngeBtPy/yEWtcls41VdA8QIXV0m
         Oes7ueJPhP2+veOQjA6GsSBEt1E37kMS1dqi9AXi54mGLy9anBKzXbT8n6J+CzxKM+eJ
         3FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=VZi83QdjM/67jwDV4MsmJQpfGMjyY/pQsdfkKghpIqk=;
        b=BTd2ENknJjkR0kOghKYFgeIeIJzb0bsdVAwDNgY6ALkJImfn41M213K5QnE4YxIs25
         ZMpfw930BxNvMTI4T1z6v1qBR2U2rFvFLXs8jGFtIwvseIyETFkDKGzixgKPPA1glo0/
         HsGmknx5yLlsxdqDfQen5aE1nwsFJVJf8tdFmZ8KiUMh8f6eHFyYWFcH1YfwsPyEMye3
         HMaO7YRDyJTDdfvwmKoOX7BKIsOpUL6Cew052/bv1iuihGKOjISv9IcRTD56Jf6DQe00
         mBTIozDJIudm/ZOsGDZ9k672ztMj1cm6FIn64QCbt+NkTMfiMZYTT+SU/g1DXz3j8o++
         TwUw==
X-Gm-Message-State: APt69E3QRumz+jv4jwNNb/6dBYxSlo53vLSSaUxgeWRHez29fc4sntzy
        0VfofDwC6JklCMBSQrdyKWKRuroDezw4PFr3/k/pLsUNEvmtAnp7diOidzwlnEESW9KpVfXz28Z
        Z+VzHJBZ4lqke7TG52ICNp7lrcWTIcNedXBTjN+c9BEg1qcOgcXDpLIG/0A==
X-Google-Smtp-Source: ADUXVKKyY6xT74fYR8jo+7Gjp+/SUek8SSLfHeKCdUctzoSgChSHbmwje6DdCzBZ3knNq7lBg5O5juEbNbY=
MIME-Version: 1.0
X-Received: by 2002:a0c:aa8d:: with SMTP id f13-v6mr14368644qvb.54.1528221128919;
 Tue, 05 Jun 2018 10:52:08 -0700 (PDT)
Date:   Tue,  5 Jun 2018 10:51:42 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180605175144.4225-7-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH 6/8] fetch: refactor to make function args narrower
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
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
index ee8b87c78..b600e1f10 100644
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
@@ -1137,6 +1121,8 @@ static int do_fetch(struct transport *transport,
 	struct ref *ref_map;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
+	const struct ref *remote_refs;
+	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1152,7 +1138,21 @@ static int do_fetch(struct transport *transport,
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
 
@@ -1184,7 +1184,7 @@ static int do_fetch(struct transport *transport,
 	if (tags == TAGS_DEFAULT && autotags) {
 		struct ref **tail = &ref_map;
 		ref_map = NULL;
-		find_non_local_tags(transport, &ref_map, &tail);
+		find_non_local_tags(remote_refs, &ref_map, &tail);
 		if (ref_map)
 			backfill_tags(transport, ref_map);
 		free_refs(ref_map);
-- 
2.17.1.1185.g55be947832-goog

