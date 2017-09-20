Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017F220A29
	for <e@80x24.org>; Wed, 20 Sep 2017 18:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbdITSsm (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:48:42 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:47179 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdITSsl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:48:41 -0400
Received: by mail-it0-f49.google.com with SMTP id z8so3322070itc.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UWep6pgO53ozaby3VSdHO01+PjT7MYjLzCpjV2blzkU=;
        b=dDTCE9Fxp5QiCycduxPSUmol7iqD+lQSNFn9NQKH6VUu+Cg1xQTqHF1GnbH6u2qkVe
         5GbyR1btZP+5a5/LfmN0Nq425egftfL+YlTwKZHIM3LEeNJkjpemjUhD6eFvbMV/5U2S
         +jdc6qxLJyxTqy+DQ/3hhjhWCSOSPiciwIJUnZPqc0ofx+wqyIrYEvxIm14qzZs5iYqB
         yLHzrp6TvNvugyBPNxwaeiqmav2qteoO0zgEFpI8FcJshXtTZVfSKbxDA+4JGRacl0aI
         fBign/99mom00dkuYNQXq7ly2Xs/+iM9QmgmKFpuEdHpXC9djb61AoFyOyKZJMVFsqgp
         JyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UWep6pgO53ozaby3VSdHO01+PjT7MYjLzCpjV2blzkU=;
        b=QpsVF/tqMUU5TuN2wV/6DI8LC2xfOilce40qhmnPveV/y9UIUeTf5KF7nDNU++2v9A
         WijLAKQue93m4SblExi/0zglCbk3KWxPhadDNkPuS+GfBnmppXfckYuQDuQ7vEP6kkEw
         fDnz9e1xLtk0NSTha28QKwc6sZ6rLw5sQBH9p8Ocj3R41eK0Okgqrotg5WvzwlfJcPWF
         tR9Qa4OSmWEC9SrLDG6eeLyLC0tXwvkQ/i7kY5rsZt59Qg39MixcdTJlIsruR22gcmaB
         34T2v8UQYMQ1IWHfwbrmQ/379bNSj8MXLhu9JaPyd7x/f3FyJxar8I7muN1z8RvQdHgr
         z2Lw==
X-Gm-Message-State: AHPjjUjLzwnlKZrk+/gjGM5SA/c8+f2L3Yqz/nZoDVtyLuc1uGcvMurx
        5RLc2f75kA0C4nw+gBGlHQ4cFEN3kZE=
X-Google-Smtp-Source: AOwi7QCOYhaWujBoTD3hh5/fIatjk8EDiih67ujBR31xMFybnzGlJmVrM1YtbjhOHeBLIT1Cqt0IDw==
X-Received: by 10.36.2.204 with SMTP id 195mr4338306itu.35.1505933320148;
        Wed, 20 Sep 2017 11:48:40 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w132sm2559985itf.4.2017.09.20.11.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 11:48:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com
Subject: [PATCH 1.5/8] connect: die when a capability line comes after a ref
Date:   Wed, 20 Sep 2017 11:48:32 -0700
Message-Id: <20170920184832.146564-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit eb398797c (connect: advertized capability is not a ref,
2016-09-09) taught 'get_remote_heads()' to recognize that the
'capabilities^{}' line isn't a ref but required that the
'capabilities^{}' line came during the first response from the server.
A future patch will introduce a version string sent by the server during
its first response which can then cause a client to unnecessarily die if
a 'capabilities^{}' line sent as the first ref.

Teach 'get_remote_heads()' to instead die if a 'capabilities^{}' line is
sent after a ref.

Reported-by: Miguel Alcon <malcon@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
This is a fix to the bug we found when internally deploying this series.  It
just makes it so that a capability line wont cause a client to error out if its
not the first response, because it won't be the first response come protocol
v1.

 connect.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index df56c0cbf..af5096ec6 100644
--- a/connect.c
+++ b/connect.c
@@ -124,10 +124,11 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 * response does not necessarily mean an ACL problem, though.
 	 */
 	int saw_response;
+	int seen_ref;
 	int got_dummy_ref_with_capabilities_declaration = 0;

 	*list = NULL;
-	for (saw_response = 0; ; saw_response = 1) {
+	for (saw_response = 0, seen_ref = 0; ; saw_response = 1) {
 		struct ref *ref;
 		struct object_id old_oid;
 		char *name;
@@ -165,6 +166,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,

 		name_len = strlen(name);
 		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
+			if (seen_ref)
+				; /* NEEDSWORK: Error out for multiple capabilities lines? */
 			free(server_capabilities);
 			server_capabilities = xstrdup(name + name_len + 1);
 		}
@@ -175,7 +178,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		}

 		if (!strcmp(name, "capabilities^{}")) {
-			if (saw_response)
+			if (seen_ref)
 				die("protocol error: unexpected capabilities^{}");
 			if (got_dummy_ref_with_capabilities_declaration)
 				die("protocol error: multiple capabilities^{}");
@@ -193,6 +196,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		oidcpy(&ref->old_oid, &old_oid);
 		*list = ref;
 		list = &ref->next;
+		seen_ref = 1;
 	}

 	annotate_refs_with_symref_info(*orig_list);
--
2.14.1.821.g8fa685d3b7-goog

