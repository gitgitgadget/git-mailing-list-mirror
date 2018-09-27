Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829FA1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeI1BoN (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:44:13 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45704 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeI1BoM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:44:12 -0400
Received: by mail-qt1-f202.google.com with SMTP id t17-v6so3251906qtq.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7L6GRv8XGzkdEJ4/sYfyFR8klFyTmaI0c6m1lnrIAh4=;
        b=n5fnWXdvhBHo8lIDMfG7z0ucInqovicwPzOhUiEEmi1Y9ZAE6lxtkk5yQ9nQvOYPjo
         UsxMyNXUlF5uDFEdVjiZ0hPt8gppk4tUZ9nCZdfPSJVmHbAmw4dR7rm1ex3Xyh+IQBy4
         Fiq290rY3EIOb0b1Vb6J9t0QdRxt9udeMSUWAZSeToHCHw8ZpsCkueDqMNVpJ6Llzquj
         pgfKF5Xt4Iv3zEFUxLJZzVqoir6gNcsW+b5BImmLuOMRNerpwDgfczynkdhT3KaLdWo7
         9LeVwkRY9xDRHTYsJ4SRJSk5VEwipqt4qY10BWNSgqyiIVaErDWfSoJ70zTqWzTVdfMP
         ic6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7L6GRv8XGzkdEJ4/sYfyFR8klFyTmaI0c6m1lnrIAh4=;
        b=eBFy4JCbwAokF02mXVRMKsw3z0lrxBsPlXEuF+Q7qAx6Sx+Cr6UpiDpG3BxD8R3iaJ
         GVvDF6gYMUqvRn/2W1bK+s+WvW5Eoh+1whKs9mkkhDbBlsdloAXqy83VbdFPA22TyNWi
         1zIojsdrNe0P4/DfSjauUNmY9B0Nsg33FEZxDKjNr8L3LXvbhmHaz8jJdyGA2EtRDbQZ
         X/0QrNUJ6Zh4laOvEjB/zBMmcmIEZcuusKKX7GrZ31CMIPnUAnwOsgMjXJ4jNSJGyQ81
         VqEciIODOo4BW5sJtpigS0l5CSqHcrzFaUI8c4gWDXvCpBvzYyU9Meytfl9Lt7l29GTg
         lZDw==
X-Gm-Message-State: ABuFfogCNWY9vVLcnVRDdhIGBhR5VldcLOyjT5UMM7pAcoqwrtjoK+RP
        4FIDiD6tawm38IYCJFYHup62yPHLOjBWKZvZF7McK/sxG/mKftBAEapdkOWJto1T8wzmJ+0fDAl
        4WJvaQAC5Mzi9fRB1tt0WOsg9Mq0Bvc//aVVHkXb3v+De+EwlBCQZNPpunYXicZVCRsKciC0P7Q
        rg
X-Google-Smtp-Source: ACcGV606snQ1EELSYBGCBwkSPVjzFGeqtPhzqpOzHOrM8ZJf2ATt8c/NOCClIeiluKXADv5FgG2Zqg6PeAU3BG//U2zI
X-Received: by 2002:a37:9ed0:: with SMTP id h199-v6mr4518748qke.11.1538076265067;
 Thu, 27 Sep 2018 12:24:25 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:24:04 -0700
In-Reply-To: <cover.1538075680.git.jonathantanmy@google.com>
Message-Id: <1baf4254c928865ca83f35a1b6ed2d2a9ffcc941.1538075680.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180925225355.74237-1-jonathantanmy@google.com> <cover.1538075680.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH v2 1/4] transport: allow skipping of ref listing
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_refs_via_connect() function both performs the handshake
(including determining the protocol version) and obtaining the list of
remote refs. However, the fetch protocol v2 supports fetching objects
without the listing of refs, so make it possible for the user to skip
the listing by creating a new handshake() function. This will be used in
a subsequent commit.
---
 transport.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 1c76d64aba..5fb9ff6b56 100644
--- a/transport.c
+++ b/transport.c
@@ -252,8 +252,18 @@ static int connect_setup(struct transport *transport, int for_push)
 	return 0;
 }
 
-static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
-					const struct argv_array *ref_prefixes)
+/*
+ * Obtains the protocol version from the transport and writes it to
+ * transport->data->version, first connecting if not already connected.
+ *
+ * If the protocol version is one that allows skipping the listing of remote
+ * refs, and must_list_refs is 0, the listing of remote refs is skipped and
+ * this function returns NULL. Otherwise, this function returns the list of
+ * remote refs.
+ */
+static struct ref *handshake(struct transport *transport, int for_push,
+			     const struct argv_array *ref_prefixes,
+			     int must_list_refs)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
@@ -268,8 +278,10 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
-		get_remote_refs(data->fd[1], &reader, &refs, for_push,
-				ref_prefixes, transport->server_options);
+		if (must_list_refs)
+			get_remote_refs(data->fd[1], &reader, &refs, for_push,
+					ref_prefixes,
+					transport->server_options);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -283,9 +295,18 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	}
 	data->got_remote_heads = 1;
 
+	if (reader.line_peeked)
+		BUG("buffer must be empty at the end of handshake()");
+
 	return refs;
 }
 
+static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
+					const struct argv_array *ref_prefixes)
+{
+	return handshake(transport, for_push, ref_prefixes, 1);
+}
+
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
-- 
2.19.0.605.g01d371f741-goog

