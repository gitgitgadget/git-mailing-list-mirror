Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DF91F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeI1BoX (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:44:23 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42183 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeI1BoW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:44:22 -0400
Received: by mail-qk1-f202.google.com with SMTP id z17-v6so3689515qka.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yW07xfrG9F09zjKIND8N4BMCzKFoSNM01OoNXDTquLc=;
        b=SccTr4aMktpsVWJoFdU8wfjE5KM3koyDwLFweGQM7Li9Vu+XhzHHJzNhpiKA7kAW0z
         9pVV433AWg1BjNmBFVii7cJAadylEo0GXxvzqjdWatH4yo/5U5UULEkHSXTcJgvmxhyZ
         L1+fv6zQ/jeIPPIXpTVluoYMTFfDhwrUZPw5dSZJbIFOTIXSHHyOZIfCXxSXNQs3CezB
         IcO2BcBryTUdPXbSfGHIpDIZ7O9DBy83l0OVjgCQGdLJYZ+jLjorAbpX4AO2n2/dBGpR
         W9DmIU7Ly2IXpe4xE8tK45/PHFEQEhLvgK/pMqFS088tA3VYVC0mRLgSVXs30kqmuTwm
         hUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yW07xfrG9F09zjKIND8N4BMCzKFoSNM01OoNXDTquLc=;
        b=IAmP8AVfVzAP/Ypfuu93sOzyraNm1nxpZvZIViQt/HAdGTm9AcG95unq2EzE+cdX+b
         Aw6lEMdSEjaa9FtF6B/E1nRNMCKOrceDGucBMHfQSDs/iSxlLRI7xZDpaKAIHlpsNVS+
         QgkyUgdsxEdwflLCEAc7PybpAgpykWYa659olWDQFSmp7HW4sbnizp8BvmuQ4c3h0g4N
         pXl3c02E432h5dQQZgJsu9upLMt+RB+swux0I9Fw9AQM5eaJ5lmAD9aWIH39QeGlaQIc
         CQYV6RLBfLnu/i9D1EzYsszCXyig1ZQWgW3VvTfDbMHPBAQBNspDY+t3bbm1Zj1cCmj5
         hxwQ==
X-Gm-Message-State: ABuFfohUYOT2PC1xRvRsCzF12jXHW95MAYzPG2gX8PKHiknoYDe5Zolf
        VM05YQ7EJiMkseP2CEZQPxyrBawo4cRYfKhS0d4ebYxC3T1BEUjLzHnOLDzsIH89VlHnOGWFrl+
        /WLddq3uF4OK/zWEglvXaWpSgL2vcwZtUy6fcT+l48z5YnzZyBvlBLHYoFLvrPzJmrzKdS2/y/Z
        +p
X-Google-Smtp-Source: ACcGV63vqdsT5sWGUTx3OySINNSlDbA+g38lzJTspovYMMYlkONWNQ8qLdN2y2tGBdxNO8vojuFY7N18opkNJmAkY7ko
X-Received: by 2002:a0c:d2b5:: with SMTP id q50-v6mr5565697qvh.1.1538076274678;
 Thu, 27 Sep 2018 12:24:34 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:24:06 -0700
In-Reply-To: <cover.1538075680.git.jonathantanmy@google.com>
Message-Id: <33b22cf96ee27053a6de22fdfb48f58cc8012644.1538075680.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180925225355.74237-1-jonathantanmy@google.com> <cover.1538075680.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH v2 3/4] transport: list refs before fetch if necessary
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The built-in bundle transport and the transport helper interface do not
work when transport_fetch_refs() is called immediately after transport
creation. This will be needed in a subsequent patch, so fix this.

Evidence: fetch_refs_from_bundle() relies on data->header being
initialized in get_refs_from_bundle(), and fetch() in transport-helper.c
relies on either data->fetch or data->import being set by get_helper(),
but neither transport_helper_init() nor fetch() calls get_helper().

Up until the introduction of the partial clone feature, this has not
been a problem, because transport_fetch_refs() is always called after
transport_get_remote_refs(). With the introduction of the partial clone
feature, which involves calling transport_fetch_refs() (to fetch objects
by their OIDs) without transport_get_remote_refs(), this is still not a
problem, but only coincidentally - we do not support partially cloning a
bundle, and as for cloning using a transport-helper-using protocol, it
so happens that before transport_fetch_refs() is called, fetch_refs() in
fetch-object.c calls transport_set_option(), which means that the
aforementioned get_helper() is invoked through set_helper_option() in
transport-helper.c.

This could be fixed by fixing the transports themselves, but it doesn't
seem like a good idea to me to open up previously untested code paths;
also, there may be transport helpers in the wild that assume that "list"
is always called before "fetch". Instead, fix this by having
transport_fetch_refs() call transport_get_remote_refs() to ensure that
the latter is always called at least once, unless the transport
explicitly states that it supports fetching without listing refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 transport-helper.c   |  1 +
 transport-internal.h |  6 ++++++
 transport.c          | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 143ca008c8..7213fa0d32 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1105,6 +1105,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 }
 
 static struct transport_vtable vtable = {
+	0,
 	set_helper_option,
 	get_refs_list,
 	fetch,
diff --git a/transport-internal.h b/transport-internal.h
index 1cde6258a7..004bee5e36 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -6,6 +6,12 @@ struct transport;
 struct argv_array;
 
 struct transport_vtable {
+	/**
+	 * This transport supports the fetch() function being called
+	 * without get_refs_list() first being called.
+	 */
+	unsigned fetch_without_list : 1;
+
 	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
diff --git a/transport.c b/transport.c
index 4329cca8e5..ea72fff6a6 100644
--- a/transport.c
+++ b/transport.c
@@ -733,6 +733,7 @@ static int disconnect_git(struct transport *transport)
 }
 
 static struct transport_vtable taken_over_vtable = {
+	1,
 	NULL,
 	get_refs_via_connect,
 	fetch_refs_via_pack,
@@ -882,6 +883,7 @@ void transport_check_allowed(const char *type)
 }
 
 static struct transport_vtable bundle_vtable = {
+	0,
 	NULL,
 	get_refs_from_bundle,
 	fetch_refs_from_bundle,
@@ -891,6 +893,7 @@ static struct transport_vtable bundle_vtable = {
 };
 
 static struct transport_vtable builtin_smart_vtable = {
+	1,
 	NULL,
 	get_refs_via_connect,
 	fetch_refs_via_pack,
@@ -1254,6 +1257,15 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	struct ref **heads = NULL;
 	struct ref *rm;
 
+	if (!transport->vtable->fetch_without_list)
+		/*
+		 * Some transports (e.g. the built-in bundle transport and the
+		 * transport helper interface) do not work when fetching is
+		 * done immediately after transport creation. List the remote
+		 * refs anyway (if not already listed) as a workaround.
+		 */
+		transport_get_remote_refs(transport, NULL);
+
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
-- 
2.19.0.605.g01d371f741-goog

