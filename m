Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FD61F461
	for <e@80x24.org>; Wed, 21 Aug 2019 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfHUWUT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 18:20:19 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:47363 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbfHUWUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 18:20:19 -0400
Received: by mail-vk1-f202.google.com with SMTP id n185so1473708vkf.14
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NOIdeejJSo+ld3TRqxPdwXhoZelO4Zah8uc6JoL/wdQ=;
        b=L67SPCIcj5M0WzqMRdKrl9MX4gPpFTBKaTDezidCJomApsla7/ix7doLSlmK+8wvus
         f1xLZ0Tyiay5Qn69LRf0uYJNLUOl8XB8xcZrgdhIIlAIBEMicb9gO+kqrqi1b9XiULtB
         vDTDih/Yzzz+ww7vcWzF8bvjlxFM7rNIf1SYzYXwzgd4NgX7btqurEAyRZDNLyzoouPT
         gxcC/fAmbs9lIUp0Au9J/5TjOthyTT44bElplPZDx0QnGjJvEIqHrRbqHo3c4CcmpgM2
         KL0v+D2m/K1LmYudz+UVbuOX1p7rFwwdsEYql5ornpBgCTNkAKBxMvEP8scR4KT6XG0z
         L2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NOIdeejJSo+ld3TRqxPdwXhoZelO4Zah8uc6JoL/wdQ=;
        b=kTQupYF3mvcl30IFvimLpPSS726DLIxJhNlbN1OWC96T0Nm7EfaV8rxFkWdpphVFYk
         i71UFtlrGU6v6pNIgBXDOa74sfdAAITSAjf2zXouHI8FdPZtvU/yJDBqGn78sKRTlmU5
         wXmfldTfaUsb0BJrRTtXZHZobr0qq+kfbn95PqUjZ+xI94zxmKXlQ79KFCtQpK4DO52y
         LuvDKrVYF2FFJHJhbB9UzgmzNqHnqSiiYd93SZwf07INNh/e/ZsD6+1yyw057kIfGsel
         hUg/+mGsKqQ7KB3ZsdB/mJ5+5QDJeYKlWBef6NCAGW+TnlJoETbuJxCzOBzel2v09K7g
         yjqg==
X-Gm-Message-State: APjAAAVdNFz1iQUhYGbsy1k6numPGLDUA1OYyaraGvMLdhsi34uSMRYj
        xxw627cOwUGvA1EEhAZLnZshIU/VC164VUnvbUcxIz8aEwiBaQLyEuvFoMVu1jQhokz23+Z/wN3
        vvKE0QEB2ELVwRBCBI0awUbIwjaieyZsfa4AGu0H4jPQ/7eYq17GS49pNdy0qExcs/JdHzBC5TP
        HF
X-Google-Smtp-Source: APXvYqya9Kir74YvkJi6vw63QLaEZCVoYwXef1zv78C2lMXthRUNfkvY40QCv1+lzwLqBZSMJc8mixz4z+0NCKzKZ70l
X-Received: by 2002:a67:eb4e:: with SMTP id x14mr13861284vso.103.1566426018142;
 Wed, 21 Aug 2019 15:20:18 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:20:10 -0700
In-Reply-To: <cover.1566425828.git.jonathantanmy@google.com>
Message-Id: <5795a2a156af01966168176f9540ed1a8a7bb222.1566425828.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1566425828.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 2/2] transport: teach all vtables to allow fetch first
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only transport that does not allow fetch() to be called before
get_refs_list() is the bundle transport. Clean up the code by teaching
the bundle transport the ability to do this, and removing support for
transports that don't support this order of invocation.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5607-clone-bundle.sh | 11 +++++++++++
 transport-helper.c      |  1 -
 transport-internal.h    |  6 ------
 transport.c             | 18 ++++++------------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 2a0fb15cf1..b7a3fdf02d 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -83,4 +83,15 @@ test_expect_success 'failed bundle creation does not leave cruft' '
 	test_path_is_missing fail.bundle.lock
 '
 
+test_expect_success 'fetch SHA-1 from bundle' '
+	test_create_repo foo &&
+	test_commit -C foo x &&
+	git -C foo bundle create tip.bundle -1 master &&
+	git -C foo rev-parse HEAD >hash &&
+
+	# Exercise to ensure that fetching a SHA-1 from a bundle works with no
+	# errors
+	git fetch --no-tags foo/tip.bundle "$(cat hash)"
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 1fb31e1a6e..96955d4004 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1146,7 +1146,6 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 }
 
 static struct transport_vtable vtable = {
-	1,
 	set_helper_option,
 	get_refs_list,
 	fetch,
diff --git a/transport-internal.h b/transport-internal.h
index 004bee5e36..1cde6258a7 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -6,12 +6,6 @@ struct transport;
 struct argv_array;
 
 struct transport_vtable {
-	/**
-	 * This transport supports the fetch() function being called
-	 * without get_refs_list() first being called.
-	 */
-	unsigned fetch_without_list : 1;
-
 	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
diff --git a/transport.c b/transport.c
index 778c60bf57..662a2d9ae0 100644
--- a/transport.c
+++ b/transport.c
@@ -122,6 +122,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 struct bundle_transport_data {
 	int fd;
 	struct bundle_header header;
+	unsigned get_refs_from_bundle_called : 1;
 };
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
@@ -135,6 +136,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 	if (for_push)
 		return NULL;
 
+	data->get_refs_from_bundle_called = 1;
+
 	if (data->fd > 0)
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
@@ -154,6 +157,9 @@ static int fetch_refs_from_bundle(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
+
+	if (!data->get_refs_from_bundle_called)
+		get_refs_from_bundle(transport, 0, NULL);
 	return unbundle(the_repository, &data->header, data->fd,
 			transport->progress ? BUNDLE_VERBOSE : 0);
 }
@@ -742,7 +748,6 @@ static int disconnect_git(struct transport *transport)
 }
 
 static struct transport_vtable taken_over_vtable = {
-	1,
 	NULL,
 	get_refs_via_connect,
 	fetch_refs_via_pack,
@@ -892,7 +897,6 @@ void transport_check_allowed(const char *type)
 }
 
 static struct transport_vtable bundle_vtable = {
-	0,
 	NULL,
 	get_refs_from_bundle,
 	fetch_refs_from_bundle,
@@ -902,7 +906,6 @@ static struct transport_vtable bundle_vtable = {
 };
 
 static struct transport_vtable builtin_smart_vtable = {
-	1,
 	NULL,
 	get_refs_via_connect,
 	fetch_refs_via_pack,
@@ -1285,15 +1288,6 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	struct ref **heads = NULL;
 	struct ref *rm;
 
-	if (!transport->vtable->fetch_without_list)
-		/*
-		 * Some transports (e.g. the built-in bundle transport and the
-		 * transport helper interface) do not work when fetching is
-		 * done immediately after transport creation. List the remote
-		 * refs anyway (if not already listed) as a workaround.
-		 */
-		transport_get_remote_refs(transport, NULL);
-
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
-- 
2.23.0.187.g17f5b7556c-goog

