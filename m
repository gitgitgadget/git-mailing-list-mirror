Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC15443C33
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926477; cv=none; b=QyU9UXyXCBa54S0F0ifFWLIWvxU7fwOzFOwGwYiBJKxVczZsjwZYuf+kg0pBB4F5g4hduIES2EVoa5qryNqdh4Mxi6diYKL0rpYfROy4bO9lITF3BELDxxEr57fp2fYeEPIQ2v3IkaLqEcFHZYaRVhu2xidXbpO/e53Aq5lIk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926477; c=relaxed/simple;
	bh=3nj050sKaFz00cSpX7lVG94p2cRpXEWmZ3x9ZUyfdQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GL2WeNuJZRIKrwQQ0kuu6Mjb6qZ7hq5Uo8BJS83oPO6m7Htsv5tOx8yhL1lcGu4UfTX7uaPovwu5bhr11m6yq3baRo91V5j99pTQaBm0yskbcDxDaZCa2u8jr9vj4Nm8YhCYFoINRlhMPDN0A8y8vP1uA92HaKucPl0EIpFm8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HXd31x17; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HrfO93IN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HXd31x17";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HrfO93IN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A3C214000F3
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 03:34:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 03:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790926474;
	 x=1791012874; bh=i7MMlsiFQFgRQw/1gco7buh4QjxUBe6fVBlLMegv2ao=; b=
	HXd31x17XLkV6qF99nZ60LfJPcDWircRSCrYSacN4BpXTy87uAUiMvFcuRxFm+yh
	p2Iy1iuRta8oo/0fff/GL9BSPl4MXL9n+fjHu7cUouSpCfYn5BTD+PoLxgB2fiMY
	mb3DjbsCmGA72zBjl2TPT8MgyJ9SlsKS1c8xc8lahQPcmYj3spWe4SC6KpY2f2ui
	s1sL9B1JTd5iuzUmkEw/ARjqNZVyTso4YLukzyonTGHMw+J5G4zmxWmY3o5Lpl00
	Euq2z3juXSIJTrA5/+L/j+RyJawKelI94d7jn8YXramSaXURzO1mCApsgrM5fbgo
	6S5K2wBPVCyBzM+mvFb7Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790926474; x=
	1791012874; bh=i7MMlsiFQFgRQw/1gco7buh4QjxUBe6fVBlLMegv2ao=; b=H
	rfO93INGC+pYvAXVCaZ1Tmr5UqqrzK1/zaRJAA43ASFY00YE9BgTN0rO3vPZqCsy
	pc9kF/K5Q453mxOfgpEgCls0JhzlFZk39Po7Qm0CZMCrmRPbummMrAQyUAV1Vw7z
	kVnjbNxBUatjB4uKP2ID0u32vbWwR0rEdyLD4cy9wgNwjJIhY6LbQIbBB47rE/4i
	egK5/25UXiPngXO7fhrjJcVNI9pifLkaGR4M2WPfGptw56Xt0e4DtQ1wVqhGqS7c
	eSbZW1dbj11YhvKE62F7Xgyc+TSx4udQ1iwMu5Ha++21yIKVqZMBpdxt/Aid/Yyb
	KhxQj3xn8YOmG042U5FjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790926474; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UiTD1TTCXZ7diF1xk+tIZyj44Glhqfij1tLP75QjiP9Tv2w
	/N1Yd6r/p68mwK+uGUXmwgEQAEy5qKWXeNdVLotrBG5ycDMWQxNrRXzomKrCNaKG
	2Mu8gQz1ptcS+QsLh6+cGTaCtPXDt/GU7FYVnh7yg0k+YFVP9wY1Bebypk4op/LZ
	HF1ZoQHKiMrC4MZuFi4FU+h+5ge1l9J1od6rd9Hg11JapM/G5OWUUfcUrXXoPaT2
	9jMEHqYurSNSeiG4BUO/p9ujNCsmjbUPk3SJjo1EKZs9xIOt9YQfQoh6PArLkNwF
	w0u9nqDNXWJRmY6FOxfLx41jvhcwhOF8pOqU9xA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bTfJjDVO/gWlLhfzne2eqHoBRE1GrDuZdo+wsicNjCw=:3nj050sKaFz00cSpX7lVG94p2cRpXEWmZ3x9ZUyfdQg=;
X-ME-Sender: <xms:il6_ahziAi1zlrf_4uTmupw3raW8C2akPHFhgHQ1W046vNCUWw4W8w>
    <xme:il6_aotlAS2RxfLwKDMmgZqy4GDHXZsEPDEewHf1mcZwe3qADt3t-Ehc4pUrMnJ0N
    8UpR_QbY8EJxonA_FWna9XH4ZV_aTAgIJKSJcG-vkZ9Cd4yDMRKmS4q>
X-ME-Received: <xmr:il6_aosmdcX92gsGgHLKstvp6GhNqD2gs0hJlziw9oZ27VsalJswsg>
X-ME-Proxy-Cause: dmFkZTEP3KwCkB75OTcWIBCH0pP2HWg7IV8j4L/feKxyHCflRWjjUONKg5GANVXbd+6KEw
    cfHynXX7LNmxY228ewmjje5LjD6dh/fR4cg4Ds+FB+K1w8g5pGIHkzr5255AATqTZGMhPL
    RDGH+lEP4yKFRyhPmIyX0ISWFdOJjSVaVRgsruWX8DgET8M8BDp76hB5AJvDQbprcQkWui
    W70Yhj4RFRYD4w9002sNY94TA7BtZebQ6N5Y3TJplM38pNVszWS1mfEvFsXVJrRJ4eBcbo
    E/jtqwMNQaXjZvS4FqJfyENB+Vud9IMpWpB/FHWM1FKYyW92YnybG4ozKiv2U+sAJdlnsM
    qNc6N6V1uHRbMrzV8PMa5oGbg6PwwfudM0b0Io6JSZhwUktsVw1KKXLlMyEP8LA8aFcW3v
    zSdnYgVPj6xIaZuH8y8PZK2AwqxNjxonGHoh98gblENBq7+LbRS16pykP5cCZsCWptGM91
    djxw1d/WOI4gPP/cOIKFsGcvbNe8Dm0kSG2f1yQMdW/tJKFCuJf8yarZmqE146PWQocr9U
    YoyGZRKUGEdYhue91qjYT97R2tb00UGESTR7TLy81rHVr9GnE0ju9tjZinaGQ8j45lGCKW
    RTmb6vW5vt1gOS5JBk8sfYMV+7+Uun+hqXMAoszJHXw0nOOCAGflXTLfIjTg
X-ME-Proxy: <xmx:il6_atPOcE4AElyGajYa7Bx20qQ8yt9Q9u53iIUp_OGqsvEDLAxOGg>
    <xmx:il6_am0dv847imyjt59mGafoFYZq0bnrb0j3CkH17icvDhHFkRCWbQ>
    <xmx:il6_apP23GznAE0Mg_o1L1F6DogO9tUa6GEpzeCSr5tChx7bdltJCg>
    <xmx:il6_am0Y9Baus_1sW6vjjsWwlk9csKfUnLi6rReuxJ6wxwrH9ZFKMw>
    <xmx:il6_aoJe5xAWz8et9MT0MEgO89wu8wRnEj2n5Z94ouM8MuGXUM7sha_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 03:34:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53341b8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 07:34:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 09:34:07 +0200
Subject: [PATCH 2/2] packfile: fix corruption due to stale delta base cache
 entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
In-Reply-To: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
To: git@vger.kernel.org
Cc: Guillaume Chauvel <guillaume.chauvel@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.15.2

The delta base cache is a process-global hashmap that is keyed by the
address of the `struct packed_git` plus the offset of the base object
within that pack. Entries part of the cache are never removed when a
pack is closed, and neither when the pack is subsequently freed. As a
consequence, the cache may contain stale entries.

For a long time, the worst consequence of this leaking cache was that we
held on to memory that we could've released. But the reason for this was
that we didn't even free the packfiles, either. That has changed in
6f1e9394e2 (object: fix leaking packfiles when closing object store,
2024-08-08), where we plugged that leak.

Now that we free them, a new packfile may be allocated using the exact
same address as a previously allocated one. And if the new packfile has
both the same address and a similar layout, it may happen that a
preexisting entry from a previously-allocated in the delta base cache
would have the exact same key.

All of this sounds very theoretical, but we can actually trigger this
bug somewhat reliably! When doing a merge with "--recurse-submodules" in
a repository with lots of submodules that have similar-looking packfiles
we end up opening and then closing the object databases of each of the
submodules in sequence. Because of the above mentioned commit we would
close and free each of the packfiles part of the respective databases,
but we wouldn't evict thire delta base entries from the cache.

When using glibc, one of the packfiles will eventually get the exact
same address, and that will then cause Git to read the wrong entry from
the cache. Git detects this and aborts with an error:

    $ git merge branch-b
    error: Could not read 584ef938be4a749bfa13f68d5ac5545bc029e529
    error: could not parse commit 584ef938be4a749bfa13f68d5ac5545bc029e529
    error: failed to merge submodule G (repository corrupt)

Now in this case we're lucky that Git detects this error because we try
to read a commit from a different submodule via an object database that
doesn't have it. But potentially, in an even more contrived scenario, we
might even silently yield wrong data from the cache.

Fix this bug by evicting cache entries that belong to a specific pack
when closing it.

Note that the added test reliably reproduces the above bug on my machine
that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
specific allocation behaviour of glibc it is very likely that the test
will not work on other platforms.

Reported-by: Guillaume Chauvel <guillaume.chauvel@gmail.com>
Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c                 | 13 +++++++++++++
 t/t6437-submodule-merge.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/packfile.c b/packfile.c
index af1b837974..365c54c7dc 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1253,6 +1253,18 @@ void clear_delta_base_cache(void)
 	}
 }
 
+static void delta_base_cache_evict_entry(struct packed_git *p)
+{
+	struct list_head *lru, *tmp;
+
+	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *entry =
+			list_entry(lru, struct delta_base_cache_entry, lru);
+		if (entry->key.p == p)
+			release_delta_base_cache(entry);
+	}
+}
+
 void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
@@ -1261,6 +1273,7 @@ void close_pack(struct packed_git *p)
 	close_pack_revindex(p);
 	close_pack_mtimes(p);
 	oidset_clear(&p->bad_objects);
+	delta_base_cache_evict_entry(p);
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 1546d5f773..0ee3684206 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -514,4 +514,51 @@ test_expect_success 'merging should fail with no merge base' '
 	)
 '
 
+test_expect_success 'merge with many packed submodules reports conflicts' '
+	test_config_global protocol.file.allow always &&
+
+	# Create 16 submodules with two divergent branches each.
+	submodules="A B C D E F G H I J K L M N O P" &&
+	for name in $submodules
+	do
+		git init source-$name &&
+		test_commit -C source-$name $name-main &&
+		git -C source-$name switch --create branch-a main &&
+		git -C source-$name commit --allow-empty --message $name-branch-a &&
+		git -C source-$name switch --create branch-b main &&
+		git -C source-$name commit --allow-empty --message $name-branch-b || return 1
+	done &&
+
+	# Create the superproject and add all submodules.
+	git init many-packed &&
+	for name in $submodules
+	do
+		git -C many-packed submodule add --branch main "file://$PWD/source-$name" $name || return 1
+	done &&
+	git -C many-packed commit --message main &&
+
+	# Create two divergent commits in the superproject that update all
+	# submodules to the divergent branches.
+	for branch in branch-a branch-b
+	do
+		git -C many-packed switch -c $branch main &&
+		for name in $submodules
+		do
+			git -C many-packed/$name switch $branch || return 1
+		done &&
+		git -C many-packed add $submodules &&
+		git -C many-packed commit --message $branch || return 1
+	done &&
+
+	# Clone the superproject to ensure that everything is well-packed and
+	# then merge the two branches, creating conflicts for every submodule.
+	git clone many-packed many-packed-clone &&
+	git -C many-packed-clone submodule update --init &&
+	git -C many-packed-clone switch branch-a &&
+	test_expect_code 1 git -C many-packed-clone -c advice.submoduleMergeConflict=false merge branch-b >out 2>err &&
+	grep "^CONFLICT (submodule)" out >conflicts &&
+	test_line_count = 16 conflicts &&
+	test_must_be_empty err
+'
+
 test_done

-- 
2.56.0.353.g0856645cf6.dirty

