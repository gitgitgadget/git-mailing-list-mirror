Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFC3B9933
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673533; cv=none; b=Q3H+g0QzRtS6MOV5HcFmVnFV9oOHegNKEZGDYjU749goqCOVTt8RyuTHg4SPY9PBdsaKkZx10YEph8iHaFINYj0jHM6ZKc5mcAuh6Awunc4Tr7tmOlhB85BrewFCCO11gkhHvta+LUZdx9Gy56CUFqQEopIcE56E9cSSUcgTI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673533; c=relaxed/simple;
	bh=g1hRga1lz+L/zE/bKDlJ1nDSFxU1Xr0p8NFq2pqDxWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ez731m242gr0dNiU0/wv5tyFpqZJvKDP9EaRRdSbRZwDNoHiNLpmQTpu+1yeBlpRwMbVDtXSyl1uN8JKdAEKHpNchuABmY3GXXGmJXOtZKqYKVyxh8NVzSyxuDzZfPuhQYzwV2jvL0CLwkcqCSUyaJTqkCT+A5wzdLRZiDj8r2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KspuKB/c; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KspuKB/c"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ba5b151dso102254366b.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673530; x=1784278330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+tywoUdW5qOI83UdOkBCK2VIaPE19aAoEdl59jcK1A=;
        b=KspuKB/cVMk3nvcqAsBUPNCMAW2RpNgGCkZsE/Tlnzs7XwrpnCZQJsx4O4dO/8lLHX
         puPq8S9A0zA2EoOKr051yZ+VRLYYEI9X/uTtqRwxh6ssRxUaAmodvtscNk7fPZuIPeKu
         lgmLW8Ep3rE+Nb5p/SBRjtxjBauARN8mlETsMxcs2p/cqXHjAaghzC1jLyi6RajwNiN4
         p03jDjZUOHP3LOhF8AOo0BAuU7+gmccCMHkaETqqqpF+xAYZAX3gNDjz+E/gusX1sh+L
         u7rqmcvmFtuz7BipX1VTJLP1hn81ofsKgGINGq1ht1t4AgjDPUmYOzWgb84/SsQjJpSZ
         eKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673530; x=1784278330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+tywoUdW5qOI83UdOkBCK2VIaPE19aAoEdl59jcK1A=;
        b=S87x0+tkQLUkVIHcAvyBgdeyFqDg4Myb5C+AMZrqWngZxe7kScXuePfp/7UahCqVK2
         vwyEOpfUNfdQBM9kq7yH8E+AaOjvMv6ghKUGpiA8GiASBSQEl95iuqMBMru5WBoe06Tf
         iEZPMzHGQcV2sxdhwwIzoog3uQO/bthMNbZjYC2Ku6/aEMqaF3wugszgDYJEgRdgz4HS
         q5yNNfPjcbz88fbXHwqYUkRpJMVKICKMSEjCuy843ljLIfLk0cRONmd/uC0yKirdZD/2
         z+PKEh6PGJ41sZ0+h4eHM8rilZYJvOPDgwVwYldhxCq2xdr+RjAbMEh2TWfnfG5WC2yN
         E8Zg==
X-Gm-Message-State: AOJu0Yy9C2Xt4tRlplvRxHDHbIU6NxDFDNT4Ki3OJ/mpARKZwt3TDTfC
	EdX/dwtlqDy9SLEb4b3K9bpBY7abv9WrDAnLHSR2z1dV/0UqF9I/MgNFk+crcvaP
X-Gm-Gg: AfdE7cmaTdj/B6N1umzt6bR+FMuThy3mBuCLT9Zj4bXRFuJT6JvHySIsypfGUJ+Owuf
	0gsxLeTP2pdSC5Q2v0Qkd4TpxThxDPtAtHhv+f3ZWyJ3Bn0jF+lK8btlA6holBCLt03FpAGoPfx
	wX5nawexQPVbTyKlbytzjGI3nCAGhu0qRENWTpxmnOxNRioBfQDMIxbgQxRN++Ykh9t255gP8h7
	ENIHVM8776hyg5efNWQ9+wArq8rDkjFT2FqhBYaNfQpFI4zJ48NY9up09GPyaCx6wQ30jgoRvhk
	cB50ZiVoc4j5nWD3wMnX9EO6arg/9V46PXbjvjDJnNOwdNHCeEmhsLUMSQUQdFMiCP4tvefJQF2
	EDXphDy9oAsKCGtHf2lSaeioUMpl3J+N3OVaAbrdwAIh2oTH1L24J7riU44zJXBbP0dq5RZ+UmN
	NI1A6S+r/3bxUbcCnGXfmV+xWx1HYcMy6jdhhzUKfzfTefGyjm8CODXztEFH9mZII7iWJzpAoH4
	xzmwBUA184eVX8KPBm9gxSyWqkg
X-Received: by 2002:a17:907:c899:b0:c15:b9c3:a888 with SMTP id a640c23a62f3a-c15ce0fe16amr428290266b.42.1783673530093;
        Fri, 10 Jul 2026 01:52:10 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15eb1dbdc9sm199561166b.10.2026.07.10.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:52:09 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] promisor-remote: teach 'fromAccepted' to GIT_NO_LAZY_FETCH
Date: Fri, 10 Jul 2026 10:51:37 +0200
Message-ID: <20260710085137.4171240-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.125.g395cd2c8ec.dirty
In-Reply-To: <20260710085137.4171240-1-christian.couder@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `GIT_NO_LAZY_FETCH` environment variable can be set to 'true' or
'false' to enable or disable lazy fetching. By default it is set to
'true' when calling `git upload-pack` to avoid security issues, see
7b70e9efb1 (upload-pack: disable lazy-fetching by default, 2024-04-16).

Recently though, the "promisor-remote" capability was introduced into
protocol v2, which allows a server to advertise some promisor remotes
and clients to accept them or not.

When promisor remotes are advertised by the server and accepted by the
client, it means that they are quite trusted. So the security risks
which come from lazy fetching from them could be considered much more
acceptable.

Let's introduce a 'fromAccepted' option on top of 'true' and 'false'
for `GIT_NO_LAZY_FETCH` to allow lazy fetching only from accepted
promisor remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-upload-pack.adoc    |  5 +++
 Documentation/git.adoc                |  6 ++--
 promisor-remote.c                     | 14 +++++++-
 promisor-remote.h                     |  1 +
 t/t5710-promisor-remote-capability.sh | 49 +++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-upload-pack.adoc b/Documentation/git-upload-pack.adoc
index 9167a321d0..1c2ed9d7ba 100644
--- a/Documentation/git-upload-pack.adoc
+++ b/Documentation/git-upload-pack.adoc
@@ -71,6 +71,11 @@ This is implemented by having `upload-pack` internally set the
 (because you are fetching from a partial clone, and you are sure
 you trust it), you can explicitly set `GIT_NO_LAZY_FETCH` to
 `0`.
++
+`GIT_NO_LAZY_FETCH` can also be set to 'fromAccepted' which allows
+lazy fetching only from remotes that are advertised and accepted using
+the "promisor-remote" protocol v2 capability. See
+linkgit:gitprotocol-v2[5]. This is safer than setting it to `0`.
 
 SECURITY
 --------
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d..14a083bcdb 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -947,9 +947,9 @@ for full details.
 	pathspecs as case-insensitive.
 
 `GIT_NO_LAZY_FETCH`::
-	Setting this Boolean environment variable to true tells Git
-	not to lazily fetch missing objects from the promisor remote
-	on demand.
+	Setting this environment variable controls whether Git is
+	allowed to lazily fetch missing objects from a promisor remote
+	on demand. See linkgit:git-upload-pack[1].
 
 `GIT_REFLOG_ACTION`::
 	When a ref is updated, reflog entries are created to keep
diff --git a/promisor-remote.c b/promisor-remote.c
index 56f57c5267..c80319f966 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -35,9 +35,11 @@ enum allow_lazy_fetch parse_allow_lazy_fetch_env(void)
 		return LAZY_FETCH_ALL;
 	if (val > 0)
 		return LAZY_FETCH_NONE;
+	if (!strcasecmp(v, "fromAccepted"))
+		return LAZY_FETCH_ACCEPTED;
 
 	die(_("bad environment value '%s' for '%s'; "
-	      "only 'false/0' and 'true/1' are valid"),
+	      "only 'false/0', 'true/1' and 'fromAccepted' are valid"),
 	    v, NO_LAZY_FETCH_ENVIRONMENT);
 }
 
@@ -337,6 +339,16 @@ static bool lazy_fetch_objects(struct repository *repo,
 				 to_free, true))
 		return true;
 
+	if (lf == LAZY_FETCH_ACCEPTED) {
+		static int warning_shown;
+		if (!warning_shown) {
+			warning_shown = 1;
+			warning(_("lazy fetching from accepted promisor remotes only; "
+				  "some objects may not be available"));
+		}
+		return false;
+	}
+
 	return try_promisor_remotes(repo, remaining_oids, remaining_nr,
 				    to_free, false);
 }
diff --git a/promisor-remote.h b/promisor-remote.h
index 87fc24c9eb..0d05ff9d84 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -28,6 +28,7 @@ int repo_has_promisor_remote(struct repository *r);
 /* Enum for lazy fetching parsing */
 enum allow_lazy_fetch {
 	LAZY_FETCH_NONE    = 0,  /* No lazy fetching */
+	LAZY_FETCH_ACCEPTED,     /* Lazy fetching only from accepted promisor remotes */
 	LAZY_FETCH_ALL           /* Lazy fetch from any promisor remotes */
 };
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 549acff23f..1c61b100b9 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -173,6 +173,55 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with GIT_NO_LAZY_FETCH=fromAccepted and accepted promisor remote" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=fromAccepted git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with GIT_NO_LAZY_FETCH=fromAccepted and no accepted promisor remote" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	# Clone from server to create a client
+	# It should fail because the server cannot lazy fetch the missing blob
+	test_must_fail env GIT_NO_LAZY_FETCH=fromAccepted git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		--no-local --filter="blob:limit=5k" server client 2>err &&
+
+	test_grep "lazy fetching from accepted promisor remotes only" err &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone failure with GIT_NO_LAZY_FETCH=bogus" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	test_must_fail env GIT_NO_LAZY_FETCH=bogus git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client 2>err &&
+
+	test_grep "bad environment value" err &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.55.0.125.g395cd2c8ec.dirty

