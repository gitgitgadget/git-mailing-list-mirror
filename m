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
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DDC1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 20:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKAUii (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 16:38:38 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48958 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKAUih (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 16:38:37 -0400
Received: by mail-pl1-f201.google.com with SMTP id t5so5190439plz.15
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=He/4NA0AtuczFFH5OlkRGsTW+UIFUxScS1zUcx+WzCc=;
        b=emrA09UmwF5V9dvL5v/6cO1q41EISXlAa6I3d9uVRi7jK3JuWJzV3l0foqmOP9gXFQ
         keh+RjFESpsZJSywdQBGBlCI3IfwnkDXLahAWEuqpZOeFyDhfSfdrij0RZMgAyS48uLe
         XjL5385n6/Gn6+mT0/SSYjbXgc29zWzO1q89BZ2jB+h6fBy5alVezBGgPAMc74IbQnB9
         K8E4X9rzg5yh1GOXkrIOdu+Vv1PAQtyezeEKunhlfZeGQ8rf2j0f4GF6Xm+NukTSALUR
         yMT5VEP1J24wSL8mbE5VO+zWQAZvL0OAz2dK24KOc0Uoa7lrs0knvGPRDMWhEtyJz23Z
         b8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=He/4NA0AtuczFFH5OlkRGsTW+UIFUxScS1zUcx+WzCc=;
        b=QUmh8fZ+LGL6MV+dquhFToCqqL9yhyYsKPd8gts+1AuVd3ybjdJI3CcRmVtkUJdpdM
         uJcF7Kk+Z9xuzI3ao0nI/mnYtW8xkI8HF7D4IGciHOCljUkhmISt9o43yIeW8nPPUSAO
         M+56lAn/nZ2m7WmU6V4W5JznPg6IU/nPxocoy7BRvn4KYLheLhugCr0gSXZw/ROTk/D+
         9E5sZ0LJ2vO7fnw5ojbdS8wq4cZIMLYcp4Xr2b0JQLqaw8q6+7zQNkWF5InjOuxbTAHn
         F+EKudn6rMp5Ejf36HrmimM+S4eTlLyatqY/bSkAr75AKcw/QVfUhsErs7Glz1lH/WMW
         2hOw==
X-Gm-Message-State: APjAAAUbaIr9+B1WsuNeiTDK0BqSNhHzTWg1Z/FZVjN9K+k6RlgE979C
        tLDTT8wIZdQZVBcZMLcE3EysHOusk/lfO4dSrCzjSRaEi4tqYnC6a/50tSJZAZ4/RQ0R/+4gHcv
        nDoFsAHaugKfen5xDkddf3LhWHxeTsvtCatEAPY5z0IX44X8qtf/lXT/wSOwkDjR3PnqPgWSI2o
        Fx
X-Google-Smtp-Source: APXvYqwHfipDLMN9Tx0jqDNT9ByFhSzGsEXLKgzu6KFcILsHZihew9DtAvHBgpNgcNJWdL8VdXQoPuC2lnI34grWW0g7
X-Received: by 2002:a63:1703:: with SMTP id x3mr15834698pgl.263.1572640715277;
 Fri, 01 Nov 2019 13:38:35 -0700 (PDT)
Date:   Fri,  1 Nov 2019 13:38:30 -0700
Message-Id: <20191101203830.231676-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH] fetch: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
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
I've verified that this also solves the bug explained in:
https://public-inbox.org/git/20191007181825.13463-1-jonathantanmy@google.com/

Quoting what I wrote from there:

> (Alternatively, we
> could add the equivalent of OBJECT_INFO_SKIP_FETCH_OBJECT to functions
> like parse_commit() that are used by files like negotiator/default.c, or
> split up commit parsing into object reading - which already has that
> flag - and commit parsing.)

This commit adds OBJECT_INFO_SKIP_FETCH_OBJECT to functions, but not the
parse_commit() mentioned - as stated above, this commit only handles
objects that could be trees or blobs.
---
 builtin/fetch.c          |  5 ++-
 fetch-pack.c             |  3 +-
 t/t5616-partial-clone.sh | 69 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 4 deletions(-)

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
index 79f7b65f8c..1081ed2de0 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -296,6 +296,75 @@ test_expect_success 'partial clone with unresolvable sparse filter fails cleanly
 	test_i18ngrep "unable to parse sparse filter data in" err
 '
 
+setup_triangle () {
+	rm -rf big-blob.txt server client promisor-remote &&
+
+	touch big-blob.txt &&
+	for i in $(seq 1 100)
+	do
+		echo line $i >>big-blob.txt
+	done &&
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

