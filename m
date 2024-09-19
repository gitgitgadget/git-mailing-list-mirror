Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE671B2EEC
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726789695; cv=none; b=iYlR/5bPmB0I6kz1yx5SA879mvG7y1f7R7JSwandSF1+KHpLms2HcMuPL0pr9RsWiXPEjFqTrv75pE+eh6+cp+saAE/MCOPpwoRSDuWTToVJq4lzhVy1HKCdX6sGwYKB+IGqHd57mDKCgdkjfmDytvqF8r2DLeXKP6Tk30he3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726789695; c=relaxed/simple;
	bh=wlvNBjKmkGmOpW91QW9mXuu91sm3w2FFDsfS4DVxqLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bANSZvp0T1I1JQ+euQjl7Xgf7RDzDm9pKwBZB6/OPGqniqEyih7TS8iw8fpavVpPFEX+fajSiWJPBVFmsAX7eAnxWJw7W6xIuLx5QgFbFhR2ZEpptkXOmXpIC86hR+URWU5KwGumrifvnDoIkbtZGJvbBC7yfIPXtFnsDCBDRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYxpafaI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYxpafaI"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db0c10238eso834791a12.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 16:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726789693; x=1727394493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=myjAVU5IDraI014GD1w0Uiby4V3b5ji0banNFW8B4X4=;
        b=eYxpafaIoq1ECBYId2CEH7rfpdKtkf0+6o6wr8VRYdnOudsztiP41oa8RgPH6028OV
         CB+l7gNI3oVwhAHXLLPz/MxPOoh80uYDKJI4dcpD0o8Wn9rJuX7zS5nCDWocxAMmGTvg
         8x1Uo1BL5RVThLY+CF4xs+hZ16SoRUc+zi7ad6qHk1ZcedrLXknzGEw8siacNkJ1Oa7M
         eJk9svvjc3Epp3UYM8p5DK9m6DWx8OCY4uEHkUgxl2Rx/LXaYvKrtq+lopxRvm2P9hNy
         ajctGk1twLC3r7PhiGhbjchkP5fsebHdtBjyN3bVqol4ITxBWTJOkyyMFLNk9zmPWSne
         qb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726789693; x=1727394493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myjAVU5IDraI014GD1w0Uiby4V3b5ji0banNFW8B4X4=;
        b=RTZeZMVnnahe+cxnBTPocU/dfpQT84Gf56KXfu0CW8eKJzKkguFFBVDer2ECb7r/h0
         Bz5PXDh03PK3GWuFDV+Mc/TjVyV9dhmO5aReRz4p97zX5bLY/l8VDsxxq/kXJTR2y3jh
         9iDT6dl7K0D8SflzBixPTwNld2FspoRE5WiHhQLCXz1Sl41oCvNGE75BPkfr2clMPwVq
         M1nTwFtSLe4tlisln5Te16dh93Ft7sOfhyf+GhRIuf+CTm3142vajA+5SsDsXmtQ6YKv
         uoDHtyawzeJCsH8kQT+tj/Mtn8V1jxWDWBXGULpUyX0hWIhT/Qp48rXKJXJika4PSJ9V
         iZug==
X-Gm-Message-State: AOJu0YwqAfPausOY+lwM9kd+D1gY1I/NZWsNQ4541nTl+DlbG/K0pcSX
	skizHgAY/lNGbW4QIiYJ2jo6DtTxbq9MN6SMng5JM/I1zFsev3ZTs2aD0cMkI5G0Oz+tqtN+K0r
	3F9L38BkxdlkZ3nz0E6n7l/sCFB/Mrk+uESjvP5ykZqnSpVwGdtTFiaR23/ENk70RHbZg0Ag4Ev
	3LNv+cVU5BeRsDqT+A7Y4jxTg9zF1xsVee/YW7/5UxQkCs
X-Google-Smtp-Source: AGHT+IFSUg4ZeFBx5fdO76b8SSbXA3ndqfOsR39mhAEjUcNqRsPzhpoB10oOstweQFrorRV+6PgjrfjxgGd8ZNM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:a0a:0:b0:72b:5113:ec05 with SMTP id
 41be03b00d2f7-7dcb781aca6mr662a12.5.1726789691678; Thu, 19 Sep 2024 16:48:11
 -0700 (PDT)
Date: Thu, 19 Sep 2024 23:47:41 +0000
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919234741.1317946-3-calvinwan@google.com>
Subject: [PATCH 2/2] fetch-pack.c: do not declare local commits as "have" in
 partial repos
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, hanyang.tony@bytedance.com, 
	jonathantanmy@google.com, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"

In a partial repository, creating a local commit and then fetching
causes the following state to occur:

commit  tree  blob
 C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
 |
 C2 ---- T2 -- B2 (created locally, in non-promisor pack)
 |
 C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

During garbage collection, parents of promisor objects are marked as
UNINTERESTING and are subsequently garbage collected. In this case, C2
would be deleted and attempts to access that commit would result in "bad
object" errors (originally reported here[1]).

This is not a bug in gc since it should be the case that parents of
promisor objects are also promisor objects (fsck assumes this as
well). When promisor objects are fetched, the state of the repository
should ensure that the above holds true. Therefore, do not declare local
commits as "have" in partial repositores so they can be fetched into a
promisor pack.

[1] https://lore.kernel.org/git/20240802073143.56731-1-hanyang.tony@bytedance.com/

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 fetch-pack.c             | 17 ++++++++++++++---
 t/t5616-partial-clone.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 58b4581ad8..c39b0f6ad4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1297,12 +1297,23 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 
 static int add_haves(struct fetch_negotiator *negotiator,
 		     struct strbuf *req_buf,
-		     int *haves_to_send)
+		     int *haves_to_send,
+		     int from_promisor)
 {
 	int haves_added = 0;
 	const struct object_id *oid;
 
 	while ((oid = negotiator->next(negotiator))) {
+		/* 
+		 * In partial repos, do not declare local objects as "have"
+		 * so that they can be fetched into a promisor pack. Certain
+		 * operations mark parent commits of promisor objects as
+		 * UNINTERESTING and are subsequently garbage collected so
+		 * this ensures local commits are still available in promisor
+		 * packs after a fetch + gc.
+		 */
+		if (from_promisor && !is_in_promisor_pack(oid, 0))
+			continue;
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1405,7 +1416,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	/* Add all of the common commits we've found in previous rounds */
 	add_common(&req_buf, common);
 
-	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
+	haves_added = add_haves(negotiator, &req_buf, haves_to_send, args->from_promisor);
 	*in_vain += haves_added;
 	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
 	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
@@ -2178,7 +2189,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
+		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send, 0);
 		in_vain += haves_added;
 		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
 			last_iteration = 1;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8415884754..cba9f7ed9b 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -693,6 +693,35 @@ test_expect_success 'lazy-fetch in submodule succeeds' '
 	git -C client restore --recurse-submodules --source=HEAD^ :/
 '
 
+test_expect_success 'fetching from promisor remote fetches previously local commits' '
+	# Setup
+	git init full &&
+	git -C full config uploadpack.allowfilter 1 &&
+ 	git -C full config uploadpack.allowanysha1inwant 1 &&
+	touch full/foo &&
+	git -C full add foo &&
+	git -C full commit -m "commit 1" &&
+	git -C full checkout --detach &&
+
+	# Partial clone and push commit to remote
+	git clone "file://$(pwd)/full" --filter=blob:none partial &&
+	echo "hello" > partial/foo &&
+	git -C partial commit -a -m "commit 2" &&
+	git -C partial push &&
+
+	# gc in partial repo
+	git -C partial gc --prune=now &&
+
+	# Create another commit in normal repo
+	git -C full checkout main &&
+	echo " world" >> full/foo &&
+	git -C full commit -a -m "commit 3" &&
+
+	# Pull from remote in partial repo, and run gc again
+	git -C partial pull &&
+	git -C partial gc --prune=now
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.46.0.792.g87dc391469-goog

