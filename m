Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8F01F454
	for <e@80x24.org>; Tue,  5 Nov 2019 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbfKES4c (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 13:56:32 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49286 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390651AbfKES4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 13:56:31 -0500
Received: by mail-pg1-f201.google.com with SMTP id o3so13469297pgb.16
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B3A26f1JtL76B3swLJogxltKOzLPlS3gCLZiIdixMKA=;
        b=HPDOxt6f6VfvOdJPdipOzrpeE1tMxoAVO9BAtGLU+QfCbzkQQ0nSWSHT5j40hlvle2
         ik4hXWaV7/DwqLG8jRVNpopLyVF3QBJ1B4ARuoJFLIRj/gAlTYrZ4FDZ6SIlpLQDO0/h
         dLMF7pZ5RhRmcIuHu2njkT0miIUbaK09TeEgSFyvCaoDHp3wdyKSI/34s/Y0JiedDPHB
         QKZ2nqDUOPV+nQ5Z/Ugv7R+wO/4fbXXqJqvCUQcB4XAF2R3FKkYpxkptaKa1Gi5TGp0f
         745Dw6fhx+MeNqP2aPjJyzxjr3cPMs/fRp07DdAxUbAKviC3jjGuTJc3Tmdd4VZy6d0Q
         7NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B3A26f1JtL76B3swLJogxltKOzLPlS3gCLZiIdixMKA=;
        b=EcdEurnqB/WI9fRmkXTlCXP7MKD7vtm6u847Bx3Qp2i5Kg2s9Corumi2nQuOk9b2Kk
         vHpvnSfHkPrWicuMdBLxO62KlmC3fUlpzAAC/qHd7aP9zBjjSry7kCYQnQk+NmE6p1vg
         TvNY6cv10kL6DSKktdMl1ZKTQLGyg0xva/TObghLPXW+C1Z8GDNdqzrqo/RCNvvmQ+vh
         KumzWYlDqJ7j99F5NMs9JKNVaTnyjIW4/ZUcHtFHMrVMvIbR/+cr5Ot6k9dIrB3AaQ74
         e/PzxaMlV2HRiU/YvkmJ10hld2Fs8F267uC/jHfbFocJPWtMe0uzt8pOOcj78G5BDEJu
         rbrA==
X-Gm-Message-State: APjAAAXWE7CbkiVOjUm14PnTM0zzdj6+YVsOnmA0ZHuNWB0R4x6ny5g9
        j+rL7E0srCe6eoU1Ej/Xjwew3KCvCN+T+/+cYffjtEK7rsm9sHAawKsG7sWIXhkPnVeyAsAUB5r
        W0LZV5VbVJtAQ8tpjTzCuuYDZVBfPjdg8mWJyF/SmrANGUSinJKthipZPEaODlM/wAWiVns7Gvg
        ow
X-Google-Smtp-Source: APXvYqwjovpnCCr03LbLL+sSAMI90DgmtZG70AjpSV9FnLgaYqygb6lglTaDnlxsLMrUxJLOvOzU0WtupptDrPQTQyZt
X-Received: by 2002:a63:2d81:: with SMTP id t123mr38219785pgt.306.1572980190602;
 Tue, 05 Nov 2019 10:56:30 -0800 (PST)
Date:   Tue,  5 Nov 2019 10:56:19 -0800
In-Reply-To: <20191101203830.231676-1-jonathantanmy@google.com>
Message-Id: <20191105185619.207173-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191101203830.231676-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v2] fetch: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fetch_pack() (and all functions it calls), pass
OBJECT_INFO_SKIP_FETCH_OBJECT whenever we query an object that could be
a tree or blob that we do not want to be lazy-fetched even if it is
absent. Thus, the only lazy-fetches occurring for trees and blobs are
when resolving deltas.

Thus, we can remove fetch_if_missing=0 from builtin/fetch.c. Remove
this, and also add a test ensuring that such objects are not
lazy-fetched. (We might be able to remove fetch_if_missing=0 from other
places too, but I have limited myself to builtin/fetch.c in this commit
because I have not written tests for the other commands yet.)

Note that commits and tags may still be lazy-fetched. I limited myself
to objects that could be trees or blobs here because Git does not
support creating such commit- and tag-excluding clones yet, and even if
such a clone were manually created, Git does not have good support for
fetching a single commit (when fetching a commit, it and all its
ancestors would be sent).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes from v1:
- Added NEEDSWORK in test, suggested by Jonathan Nieder
- Used printf in test, suggested by Eric Sunshine

Range-diff against v1:
1:  f52c8d4c11 ! 1:  8e93cb8b02 fetch: remove fetch_if_missing=0
    @@ Commit message
         ancestors would be sent).
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *ref_map)
    @@ t/t5616-partial-clone.sh: test_expect_success 'partial clone with unresolvable s
     +setup_triangle () {
     +	rm -rf big-blob.txt server client promisor-remote &&
     +
    -+	touch big-blob.txt &&
    -+	for i in $(seq 1 100)
    -+	do
    -+		echo line $i >>big-blob.txt
    -+	done &&
    ++	printf "line %d\n" $(test_seq 1 100) >big-blob.txt
     +
     +	# Create a server with 2 commits: a commit with a big blob and a child
     +	# commit with an incremental change. Also, create a partial clone
    @@ t/t5616-partial-clone.sh: test_expect_success 'partial clone with unresolvable s
     +	git -C client remote set-url origin "file://$(pwd)/promisor-remote"
     +}
     +
    ++# NEEDSWORK: The tests beginning with "fetch lazy-fetches" below only
    ++# test that "fetch" avoid fetching trees and blobs, but not commits or
    ++# tags. Revisit this if Git is ever taught to support partial clones
    ++# with commits and/or tags filtered out.
    ++
     +test_expect_success 'fetch lazy-fetches only to resolve deltas' '
     +	setup_triangle &&
     +

 builtin/fetch.c          |  5 ++-
 fetch-pack.c             |  3 +-
 t/t5616-partial-clone.sh | 70 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0c345b5dfe..5ff7367dd7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1074,7 +1074,8 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 * we need all direct targets to exist.
 	 */
 	for (r = rm; r; r = r->next) {
-		if (!has_object_file(&r->old_oid))
+		if (!has_object_file_with_flags(&r->old_oid,
+						OBJECT_INFO_SKIP_FETCH_OBJECT))
 			return -1;
 	}
 
@@ -1755,8 +1756,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch");
 
-	fetch_if_missing = 0;
-
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
diff --git a/fetch-pack.c b/fetch-pack.c
index 0130b44112..37178e2d34 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -673,7 +673,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		struct object *o;
 
 		if (!has_object_file_with_flags(&ref->old_oid,
-						OBJECT_INFO_QUICK))
+						OBJECT_INFO_QUICK |
+							OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
 		o = parse_object(the_repository, &ref->old_oid);
 		if (!o)
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 79f7b65f8c..e785fba7ed 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -296,6 +296,76 @@ test_expect_success 'partial clone with unresolvable sparse filter fails cleanly
 	test_i18ngrep "unable to parse sparse filter data in" err
 '
 
+setup_triangle () {
+	rm -rf big-blob.txt server client promisor-remote &&
+
+	printf "line %d\n" $(test_seq 1 100) >big-blob.txt
+
+	# Create a server with 2 commits: a commit with a big blob and a child
+	# commit with an incremental change. Also, create a partial clone
+	# client that only contains the first commit.
+	git init server &&
+	git -C server config --local uploadpack.allowfilter 1 &&
+	cp big-blob.txt server &&
+	git -C server add big-blob.txt &&
+	git -C server commit -m "initial" &&
+	git clone --bare --filter=tree:0 "file://$(pwd)/server" client &&
+	echo another line >>server/big-blob.txt &&
+	git -C server commit -am "append line to big blob" &&
+
+	# Create a promisor remote that only contains the blob from the first
+	# commit, and set it as the promisor remote of client. Thus, whenever
+	# the client lazy fetches, the lazy fetch will succeed only if it is
+	# for this blob.
+	git init promisor-remote &&
+	test_commit -C promisor-remote one && # so that ref advertisement is not empty
+	git -C promisor-remote config --local uploadpack.allowanysha1inwant 1 &&
+	git -C promisor-remote hash-object -w --stdin <big-blob.txt &&
+	git -C client remote set-url origin "file://$(pwd)/promisor-remote"
+}
+
+# NEEDSWORK: The tests beginning with "fetch lazy-fetches" below only
+# test that "fetch" avoid fetching trees and blobs, but not commits or
+# tags. Revisit this if Git is ever taught to support partial clones
+# with commits and/or tags filtered out.
+
+test_expect_success 'fetch lazy-fetches only to resolve deltas' '
+	setup_triangle &&
+
+	# Exercise to make sure it works. Git will not fetch anything from the
+	# promisor remote other than for the big blob (because it needs to
+	# resolve the delta).
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+		fetch "file://$(pwd)/server" master &&
+
+	# Verify the assumption that the client needed to fetch the delta base
+	# to resolve the delta.
+	git hash-object big-blob.txt >hash &&
+	grep "want $(cat hash)" trace
+'
+
+test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
+	setup_triangle &&
+
+	git -C server config --local protocol.version 2 &&
+	git -C client config --local protocol.version 2 &&
+	git -C promisor-remote config --local protocol.version 2 &&
+
+	# Exercise to make sure it works. Git will not fetch anything from the
+	# promisor remote other than for the big blob (because it needs to
+	# resolve the delta).
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+		fetch "file://$(pwd)/server" master &&
+
+	# Verify that protocol version 2 was used.
+	grep "fetch< version 2" trace &&
+
+	# Verify the assumption that the client needed to fetch the delta base
+	# to resolve the delta.
+	git hash-object big-blob.txt >hash &&
+	grep "want $(cat hash)" trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

