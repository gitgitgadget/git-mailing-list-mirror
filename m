Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA53019D6
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113600; cv=none; b=UV5j4oIR5UrFK+cRbRJtM8wRt68Aue7arVPta45Qc1WGkezEOt81p+f7bLK2DLLP5XBs+9Q/ReK8lv9O0wDVfQM9ih6eh/3xZYkzE36o1KmXcLunU1Xnu/cDiB1iQ9RCyMFmYpGBjzxgQsT4rIWoXDoUgX8VRuAzhj/T83cUDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113600; c=relaxed/simple;
	bh=rJW50BMI6191pFjj/W5kz+Ds2ySpqIXy7UYT7lJSSMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhLB0mo/DNFFjbT/OhAt0sMJVJhuBvTMCYnbTJ7IOMWqJFAzQpBgEm+xswTp+pa8mfTRAEs+ei0hxdtDkno0xHKFVwcZYrTc6wwx6orhn8TUjmpa8Otkp+qYSL81hNHWS/PmWOJsyG3VOeugju4oiHE5q0jwK9c2IKBWgTZJXeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOtsfFrY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOtsfFrY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486b9675d36so3957545e9.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113596; x=1775718396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jws4GJkw1/nu8arm+dAEBWCkxWnogL4oVLkMCUjWFY=;
        b=jOtsfFrYeho0TZFyTmzjItgoTeh+tmaXUNgvDoCu3IW78Okq+mnsOZ2VTVSjQZ4JrF
         LC4sWjpcfQPem7xXmh8jP7Ai9+A7GW5vrV7fD/CuUoci1SnVDeTna+TaAeoFhHmkez6+
         6Ila8koHyzXaBTTJ/0iSNa8PqD6wLhUfKNLF7RJonR4bzsMyEwTuMj1FYl2N6PkZF0SH
         ndSoQUCxLGG62C9BO6kBGxCu5/M9CzqKUC/2Nomc9eUcv/6VqoeO68EAcdKqodSZ54g4
         E2jStvup3sylka2/nPYJNrCJ+sNxXKY1bjcAs2XfWbySx0FXJjfC5qfjYN/mG1KLapnz
         +oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113596; x=1775718396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Jws4GJkw1/nu8arm+dAEBWCkxWnogL4oVLkMCUjWFY=;
        b=beSVUwOSOViVKthvqRPz5zS3WaexrPD0EgaAP4haXJm96WC1NjnY2Xrje6yLYfy0yu
         l3XLACdjj1JBvFfYk8yRWoq9Co3S1HxkSkqHysNZuOUi+MsDjlI9qBjLQpPy+UYkMglV
         uyusSylpjLNIj+F+9uAp//Er8xVdYEhfCmedR4fYjPMJp1WKHU0IcAXlBv1+faHSN4l6
         tkznTJZNU0JNGjFSamdm6PkJz9sv439WEh6KttGJ8QO2bnnH/zMago/LHxyLpYQD3Mn8
         CgHgnwyZQRSSaeh5x5lpL3Y1hCmBCl7rZ2DGPrSfU3fHtxdGSCcXAZttaOhL8mv3NNBO
         aHnA==
X-Gm-Message-State: AOJu0YxXKvb3hYPKN8fe70l49CKAbtWm/UGEj58B393UhejtaU+yW4Wc
	bPDCxq7w3szBR2TXQj0dX3Gf5qdOrBPLbUFXocHMsU5oyA3nW/JpF236DqaxsA==
X-Gm-Gg: ATEYQzwmidRFBIdMHkxQqfuHJ/jqFwVshYgYqGlvkb8TCnxL5JcCkNfwW87rufAXsl5
	2H0LWoNLiXUj6g6KtPbzvpib97vj7+kppSWdqyYgtCFvWKrGqOIaRs8fFrlcPbSHX2LqllqKgRR
	HlCQq13Bj+peYHX/9OTj9XB5E0us8ZEElGSaQKAiyHnXB6HSSOyztdSiYJQ1xRYUSsy2FQU/sSh
	9Dnsq+5QUJB24lH3CMyjJvSCIUleuBhycjQypc6710z1BM+NjKJ43sGLhPN1CKA0ZOJgRwmVrvy
	tP/V6ZY+OaKxHDZVT3Mfe0r9EgGpzrgXwN3MArZdA7TVxov3r1c6QyREDRNQ9zykWkeLazRk7v9
	mBoqphAuOQZ1zt2IPJsy253cwlgAl29xlxAzxAlU8aCJb8ZG7K7emu85zlzZ1O2EV7F+d0D3+w2
	38ktCWUPqYvxzDdI2WkvDyfkTtxGu4/BtI998muF+x77HIMWssySYF5x315cYeHuNRtR3Ssmqqm
	icjHhIXe9N0BUsqtoEO7jnMzOCKZutcPtX0zq4=
X-Received: by 2002:a05:600c:310a:b0:485:3d3e:167b with SMTP id 5b1f17b1804b1-4888b6d4a4fmr35583965e9.5.1775113596085;
        Thu, 02 Apr 2026 00:06:36 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:35 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/10] promisor-remote: try accepted remotes before others in get_direct()
Date: Thu,  2 Apr 2026 09:06:04 +0200
Message-ID: <20260402070613.85934-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a server advertises promisor remotes and the client accepts some
of them, those remotes carry the server's intent: 'fetch missing
objects preferably from here', and the client agrees with that for the
remotes it accepts.

However promisor_remote_get_direct() actually iterates over all
promisor remotes in list order, which is the order they appear in the
config files (except perhaps for the one appearing in the
`extensions.partialClone` config variable which is tried last).

This means an existing, but not accepted, promisor remote, could be
tried before the accepted ones, which does not reflect the intent of
the agreement between client and server.

If the client doesn't care about what the server suggests, it should
accept nothing and rely on its remotes as they are already configured.

To better reflect the agreement between client and server, let's make
promisor_remote_get_direct() try the accepted promisor remotes before
the non-accepted ones.

Concretely, let's extract a try_promisor_remotes() helper and call it
twice from promisor_remote_get_direct():

- first with an `accepted_only=true` argument to try only the accepted
  remotes,
- then with `accepted_only=false` to fall back to any remaining remote.

Ensuring that accepted remotes are preferred will be even more
important if in the future a mechanism is developed to allow the
client to auto-configure remotes that the server advertises. This will
in particular avoid fetching from the server (which is already
configured as a promisor remote) before trying the auto-configured
remotes, as these new remotes would likely appear at the end of the
config file, and as the server might not appear in the
`extensions.partialClone` config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/gitprotocol-v2.adoc     |  4 ++
 promisor-remote.c                     | 44 ++++++++++++-----
 t/t5710-promisor-remote-capability.sh | 69 +++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index f985cb4c47..4fcb1a7bda 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -848,6 +848,10 @@ advertised, it can reply with "promisor-remote=<pr-names>" where
 where `pr-name` is the urlencoded name of a promisor remote the server
 advertised and the client accepts.
 
+The promisor remotes that the client accepted will be tried before the
+other configured promisor remotes when the client attempts to fetch
+missing objects.
+
 Note that, everywhere in this document, the ';' and ',' characters
 MUST be encoded if they appear in `pr-name` or `field-value`.
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 96fa215b06..7ce7d22f95 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -268,11 +268,35 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
+static int try_promisor_remotes(struct repository *repo,
+				struct object_id **remaining_oids,
+				int *remaining_nr, int *to_free,
+				bool accepted_only)
+{
+	struct promisor_remote *r = repo->promisor_remote_config->promisors;
+
+	for (; r; r = r->next) {
+		if (accepted_only != r->accepted)
+			continue;
+		if (fetch_objects(repo, r->name, *remaining_oids, *remaining_nr) < 0) {
+			if (*remaining_nr == 1)
+				continue;
+			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
+							    *remaining_nr, *to_free);
+			if (*remaining_nr) {
+				*to_free = 1;
+				continue;
+			}
+		}
+		return 1; /* all fetched */
+	}
+	return 0;
+}
+
 void promisor_remote_get_direct(struct repository *repo,
 				const struct object_id *oids,
 				int oid_nr)
 {
-	struct promisor_remote *r;
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
@@ -283,19 +307,13 @@ void promisor_remote_get_direct(struct repository *repo,
 
 	promisor_remote_init(repo);
 
-	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
-			if (remaining_nr == 1)
-				continue;
-			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
-							 remaining_nr, to_free);
-			if (remaining_nr) {
-				to_free = 1;
-				continue;
-			}
-		}
+	/* Try accepted remotes first (those the server told us to use) */
+	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
+				 &to_free, true))
+		goto all_fetched;
+	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
+				 &to_free, false))
 		goto all_fetched;
-	}
 
 	for (i = 0; i < remaining_nr; i++) {
 		if (is_promisor_object(repo, &remaining_oids[i]))
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 357822c01a..bf0eed9f10 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -166,6 +166,75 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with two promisors but only one advertised" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client unused_lop" &&
+
+	# Create a promisor that will be configured but not be used
+	git init --bare unused_lop &&
+
+	# Clone from server to create a client
+	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.unused_lop.promisor=true \
+		-c remote.unused_lop.fetch="+refs/heads/*:refs/remotes/unused_lop/*" \
+		-c remote.unused_lop.url="file://$(pwd)/unused_lop" \
+		-c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that "unused_lop" appears before "lop" in the config
+	printf "remote.%s.promisor true\n" "unused_lop" "lop" "origin" >expect &&
+	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
+	test_cmp expect actual &&
+
+	# Check that "lop" was tried
+	test_grep " fetch lop " trace &&
+	# Check that "unused_lop" was not contacted
+	# This means "lop", the accepted promisor, was tried first
+	test_grep ! " fetch unused_lop " trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "init + fetch two promisors but only one advertised" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client unused_lop" &&
+
+	# Create a promisor that will be configured but not be used
+	git init --bare unused_lop &&
+
+	mkdir client &&
+	git -C client init &&
+	git -C client config remote.unused_lop.promisor true &&
+	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
+	git -C client config remote.unused_lop.url "file://$(pwd)/unused_lop" &&
+	git -C client config remote.lop.promisor true &&
+	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
+	git -C client config remote.lop.url "file://$(pwd)/lop" &&
+	git -C client config remote.server.url "file://$(pwd)/server" &&
+	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
+	git -C client config promisor.acceptfromserver All &&
+
+	# Check that "unused_lop" appears before "lop" in the config
+	printf "remote.%s.promisor true\n" "unused_lop" "lop" >expect &&
+	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
+	test_cmp expect actual &&
+
+	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
+
+	# Check that "lop" was tried
+	test_grep " fetch lop " trace &&
+	# Check that "unused_lop" was not contacted
+	# This means "lop", the accepted promisor, was tried first
+	test_grep ! " fetch unused_lop " trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.53.0.765.g57b94de1f0.dirty

