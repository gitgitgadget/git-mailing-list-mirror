Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848FD1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 20:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJSEq1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 00:46:27 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:35869 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 00:46:26 -0400
Received: by mail-qt1-f201.google.com with SMTP id u28-v6so34006544qtu.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NSzVcoZSc+icWJS0d/8THM3sqajd5P7VQopNBNBjuwQ=;
        b=Wnye9thuV8QVXHlMZ+6Gdde1Aoy/vuaRbd4I5TPC8GrYOHjndA6/2/+5kxfpBBcYhW
         vmwMLqr9sol5WA1jpEM7KuB5WFbf6A2wuklpuFZWphW4fZqMDe4eY0uQkKy+HGFo8ek7
         3I2j6Ecs6V9oFCXwlTJBazfoQ5Sx7RIKPg9T7S3kDM3fifbjtLloVlHwJ8whHhX2Qnip
         AJKJBwXP/FlGoYcXd1K856ULoI0UMgXtr4hZaTaBlRXdXEmUgm01nwODDTaHWvmEOnAw
         WAhaiAD/LUAYUnusN6RgTWCrvN0i7IT+d2UZyro7+bKHk0/Ux8rurI9iuM2hi+BsbfiN
         gHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NSzVcoZSc+icWJS0d/8THM3sqajd5P7VQopNBNBjuwQ=;
        b=jcDIYCztWV3sIVBqJqHUOnnxzBbkI1PsWijCBO/mKLKIYGSh2u0JtDZUaOiZgzBqkM
         z285Vic0Ff88Gkv3AxOs6vTsObdyhyqVXX7Z/0Vg2eBbdi9meB6i4N9u6EsZyKXlov5R
         HIyiTIGumpTXTMICMHDtrsH4YKfbR+occV3jQTXzsG4Vtn7BaRlvgwIuqjrE7Pp9y0ke
         7pTSkaicPora4hMjsJ//HsLyhqKVznfhFgRgx8TU0lvJNsM/rUOfCMY7LhhRkaGR43po
         bs0lnGqxxA4KqgnDRHpSBwoEcj8jtgIv5HRjtla98YgNntMN/VHuuXJ/3Xvm2niEUv39
         kzFw==
X-Gm-Message-State: ABuFfogL3Kwhcwzokxevo6iozv3GHQLkSs5VHh3judS/8sltrPCzcW25
        MLzVkFjOQEghPDER3UqGETYpH0D1Hf5yrrP6orAOaici0x5CgHuZ3Pe7X78+ZzQtzLMCYBllAIA
        k4nmPljFok1Ui3/n2icf4X0s0oO/9e5oZOHWxIVDxFo+a0PcRQkdjBENPrMi7jE/SuZ/z7f70mA
        Ci
X-Google-Smtp-Source: ACcGV61SgUBNpW2oylcGbLQupYl5UiYhMxbmaeDob/TQ7kM3ghRyx7kzO4cWTSDjJsabNC4UjpxkCn+OTEz4h1ZcJp1o
X-Received: by 2002:ac8:396b:: with SMTP id t40-v6mr25470005qtb.16.1539895420220;
 Thu, 18 Oct 2018 13:43:40 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:43:29 -0700
In-Reply-To: <cover.1539893192.git.jonathantanmy@google.com>
Message-Id: <d50b8bc81f4380ee4dea87e9131d67aeddfffe48.1539893192.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016215850.47821-1-jonathantanmy@google.com> <cover.1539893192.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 3/3] upload-pack: clear flags before each v2 request
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose a server has the following commit graph:

 A   B
  \ /
   O

We create a client by cloning A from the server with depth 1, and add
many commits to it (so that future fetches span multiple requests due to
lengthy negotiation). If it then fetches B using protocol v2, the fetch
spanning multiple requests, the resulting packfile does not contain O
even though the client did report that A is shallow.

This is because upload_pack_v2() can be called multiple times while
processing the same session. During the 2nd and all subsequent
invocations, some object flags remain from the previous invocations. In
particular, CLIENT_SHALLOW remains, preventing process_shallow() from
adding client-reported shallows to the "shallows" array, and hence
pack-objects not knowing about these client-reported shallows.

Therefore, teach upload_pack_v2() to clear object flags at the start of
each invocation. This has some other results:

 - THEY_HAVE gates addition of objects to have_obj in process_haves().
   Previously in upload_pack_v2(), have_obj needed to be static because
   once an object is added to have_obj, it is never readded and thus we
   needed to retain the contents of have_obj between invocations. Now
   that flags are cleared, this is no longer necessary. This patch does
   not change the behavior of ok_to_give_up() (THEY_HAVE is still set on
   each "have") and got_oid() (used only in non-v2)); THEY_HAVE is not
   used in any other function.

 - WANTED gates addition of objects to want_obj in parse_want() and
   parse_want_ref(). It is also used in receive_needs(), but that is
   only used in non-v2. For the same reasons as THEY_HAVE, want_obj no
   longer needs to be static in upload_pack_v2().

 - CLIENT_SHALLOW is changed as discussed above.

Clearing of the other 5 flags does not affect functionality in v2. (Note
that in non-v2, upload_pack() is only called once per process, so each
invocation starts with blank flags anyway.)

 - OUR_REF is only used in non-v2.

 - COMMON_KNOWN is only used as a scratch flag in ok_to_give_up().

 - SHALLOW is passed to invocations in deepen() and
   deepen_by_rev_list(), but upload-pack doesn't use it.

 - NOT_SHALLOW is used by send_shallow() and send_unshallow(), but
   invocations of those functions are always preceded by code that sets
   NOT_SHALLOW on the appropriate objects.

 - HIDDEN_REF is only used in non-v2.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5702-protocol-v2.sh | 25 +++++++++++++++++++++++++
 upload-pack.c          | 13 +++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 88a886975d..4adc4b00e3 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -429,6 +429,31 @@ test_expect_success 'fetch supports include-tag and tag following' '
 	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
 '
 
+test_expect_success 'upload-pack respects client shallows' '
+	rm -rf server client trace &&
+
+	git init server &&
+	test_commit -C server base &&
+	test_commit -C server client_has &&
+
+	git clone --depth=1 "file://$(pwd)/server" client &&
+
+	# Add extra commits to the client so that the whole fetch takes more
+	# than 1 request (due to negotiation)
+	for i in $(test_seq 1 32)
+	do
+		test_commit -C client c$i
+	done &&
+
+	git -C server checkout -b newbranch base &&
+	test_commit -C server client_wants &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch origin newbranch &&
+	# Ensure that protocol v2 is used
+	grep "fetch< version 2" trace
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/upload-pack.c b/upload-pack.c
index 451bf47e7f..42c5ec44cf 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -37,6 +37,9 @@
 #define CLIENT_SHALLOW	(1u << 18)
 #define HIDDEN_REF	(1u << 19)
 
+#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
+		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
+
 static timestamp_t oldest_have;
 
 static int deepen_relative;
@@ -1409,10 +1412,10 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
-	/* NEEDSWORK: make this non-static */
-	static struct object_array have_obj;
-	/* NEEDSWORK: make this non-static */
-	static struct object_array want_obj;
+	struct object_array have_obj = OBJECT_ARRAY_INIT;
+	struct object_array want_obj = OBJECT_ARRAY_INIT;
+
+	clear_object_flags(ALL_FLAGS);
 
 	git_config(upload_pack_config, NULL);
 
@@ -1464,6 +1467,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	}
 
 	upload_pack_data_clear(&data);
+	object_array_clear(&have_obj);
+	object_array_clear(&want_obj);
 	return 0;
 }
 
-- 
2.19.0.271.gfe8321ec05.dirty

