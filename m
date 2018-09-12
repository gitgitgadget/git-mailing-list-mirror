Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68FB51F404
	for <e@80x24.org>; Wed, 12 Sep 2018 15:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeILUwz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 16:52:55 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:33092 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeILUwz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 16:52:55 -0400
Received: by mail-ua1-f74.google.com with SMTP id z12-v6so955280uao.0
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xcTIXo7gtWLZrN+H3N58BQs6TPjxzld49znyDDEfQ8M=;
        b=iL/YRXdJI+eUXdKlcV4uVoklBVFXTzUTpev0jZgfX7PN4e/L+QCgJXnShONBztrwp6
         Ict07vFUHs+P8K6BUijij2a0ik4C6OuRhXQFD6kwq9MFjr9ZDnhXxJsxAhB000VjxE+F
         hL9zNeTGO0ZUCF29lrQpZnADjMrfjJ752YnDcVU5tbHtXi1ZjafU2UyxDVm3Km10s86v
         mNKMCyXAdiU/1vNTi628lyPL4K3RfJwMVbXusR6uakEykjJNE+u4qCpJJ6qyCUGjVWVq
         Agy1fJlQ5bmGJ4iCxW4v8FM8n3CsFximXGO0+SNh2rHZhCb5Vx5hVdpfq8PQlF/1ydX0
         L/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xcTIXo7gtWLZrN+H3N58BQs6TPjxzld49znyDDEfQ8M=;
        b=DMAm1bJ5MX/fZIPcjOzEsqztWnmuTu2eRUZOni695zo5nsb2k57U5xEXGrrDhmoPo1
         TsfCvNLAg+jOb02pxqCYOn7Xa2BdaxXX40FkK7Gab5vc8v9hQGs4PxJMdAPuVNO+xyoa
         +curhRYpdj8/4pHyANBluWOx7I/JgubL0pJ32wxlcd5WsRv7LCMuIYm3Xoz4C3w8x0kb
         RhNKipoJ7xBefiQjjHkw4uy6L/UpWrb/MxYdUth8bpoCqNRH1RtTBMNkAaokiUyfxlrd
         6qgGPX0ocu/TsCgzyIpvL4EYidOh+d8UGE/bh8h8sQi6Gks/SAOtkeNgcc/NTe7mJw06
         /J2A==
X-Gm-Message-State: APzg51Am87uUh8JSZA1Bt1L8taFH4zJPo5wAET3Hhlm1qzEPZt63INoT
        aqhWcfif+AqrjbfkxKdywSTd+Q8HzBvuVwptMiUaGAaGFmi3/J4fBa47Op0aDDogtO//njUAKoI
        ppRXhxTwOfzsEqbZSxNSw2yCLx2iuz1GYM+YY3UEv7TU0Fb+tNjUFMbkh1lrctcEUJOgQKy4xlO
        Vm
X-Google-Smtp-Source: ANB0VdbW5agxZ2ndGhHMaE+mktmZOAFFURcrdelK3VFR73stKf206vISGdWiOPiCvEkaZjtCTM91CXGuF5tHK131mK3j
X-Received: by 2002:ab0:264e:: with SMTP id q14-v6mr563047uao.49.1536767268988;
 Wed, 12 Sep 2018 08:47:48 -0700 (PDT)
Date:   Wed, 12 Sep 2018 08:47:38 -0700
In-Reply-To: <cover.1536767071.git.jonathantanmy@google.com>
Message-Id: <ac5abaa46d41afe46a944264277e75ce4365d6fd.1536767071.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1536767071.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 2/2] fetch-object: set exact_oid when fetching
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fetch_objects() currently does not set exact_oid in struct ref when
invoking transport_fetch_refs(). If the server supports ref-in-want,
fetch_pack() uses this field to determine whether a wanted ref should be
requested as a "want-ref" line or a "want" line; without the setting of
exact_oid, the wrong line will be sent.

Set exact_oid, so that the correct line is sent.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-object.c           |  1 +
 t/t0410-partial-clone.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fetch-object.c b/fetch-object.c
index 1af1bf857..426654880 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -32,6 +32,7 @@ void fetch_objects(const char *remote_name, const struct object_id *oids,
 	for (i = 0; i < oid_nr; i++) {
 		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
 		oidcpy(&new_ref->old_oid, &oids[i]);
+		new_ref->exact_oid = 1;
 		new_ref->next = ref;
 		ref = new_ref;
 	}
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 128130066..0ab02c337 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -170,6 +170,18 @@ test_expect_success 'fetching of missing objects' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
+test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
+	# ref-in-want requires protocol version 2
+	git -C server config protocol.version 2 &&
+	git -C server config uploadpack.allowrefinwant 1 &&
+	git -C repo config protocol.version 2 &&
+
+	rm -rf repo/.git/objects/* &&
+	rm -f trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C repo cat-file -p "$HASH" &&
+	grep "git< fetch=.*ref-in-want" trace
+'
+
 test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	rm -rf repo &&
 	test_create_repo repo &&
-- 
2.19.0.397.gdd90340f6a-goog

