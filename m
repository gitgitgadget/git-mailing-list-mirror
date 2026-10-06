Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D093D9DDF
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282034; cv=none; b=ZdwytBj+8dGOtTKQuT6rzr/2Y2EKOPHPyFxz5oLEnbKobGZL1SAqhqM2lqsRKHHbpcSUaqKoYpVhK5uQmIiMeNtQsxZX14sGB8IO6VqE5MPGdyY2YLGst2+R5LOzKyr9PKwfPHVda/rYDV/3bKT69aCw+WeXGRgq2jgX+qlSV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282034; c=relaxed/simple;
	bh=78iM40R6LPD2NrkWVbXrjDymsWTuUUITi62nHIYN5qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyrHUgVCjQVt98L5or5dpaaUeqndZdNuNxrd7puFlMYSptjwGcOEyZ/fDPk3s4r7lg4yhkXWvTKyURpqDeZtlE6Ffy6gjgIPs+lonHpOVQGLe2LPuzOxQtBcB4/rn1eAlcF+ZkqJkYbWmCtrCioMfq3IOurpjLxLfeTt2pGB+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L+89FATS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sHeXjkz0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L+89FATS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sHeXjkz0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 74F99EC098A
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 06:20:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 Oct 2026 06:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791282030;
	 x=1791368430; bh=vjvWZFThQYvbzq6YuALvApKUBKbsvZvoyRvMuUZxIJ4=; b=
	L+89FATSguJEexDFsv8HFXT7zJzxlt6rVCqe5EVBYnsDj7a5fnsZrUnZZZs5C/Kd
	EhMF88/Y/Q0bsPj0yOFcGZDOIwqiX90dOrC1dRvXhrGKBEApw5XXE5XODnbqff1S
	4CtSRMPTCIn4WBGlBTXehxO9Emj5w9BPoWVvldgjVbTUEvwPxAw1DQVrzeBs5khy
	TNGl9RgAFsv5GF7nFNXKzxCIqzPOIihAv2UtuvYY5CeDGzvMH8ZNo3MMzIy6MCMT
	wCq0bi51EWCB8jC7Oa5qvjTiwar2OaFfhhwJh0Mi+9CIB1wS+H2z4NDT9tX23hK9
	F5I0JV3nSSFUohOXOwlzJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791282030; x=
	1791368430; bh=vjvWZFThQYvbzq6YuALvApKUBKbsvZvoyRvMuUZxIJ4=; b=s
	HeXjkz0a/BiIde5Tv/dGlw7Oc0AZ9kTOPD+UCnYMaFIRd0/iRuj6aOaXr4oZP1T6
	j2KZDA4gcnUQ+GgCL08BBQtFbobNC337pCoUqaCyEX1M1d7+ZxyGnIOB8wO9cgRr
	l9KpQHudksjfxnXd6cvLAWGN4EGF50uEeE9kZaOH/eEM04Pe5vajlrDq+91ocexb
	yQ9BahoD/PZDeOKw0MR+h7xKtI/rWOWfEdufTdjiI56oM9Bo9je2KiLFfhtOrN40
	KxD/fk2bNLG5rBIzZEUhOkjiLtmXwCIVu/UxfV+0XWuva+Ch5Ktp5wBHUTzDT6ks
	7q5Dxbhmdy0r+r7mxkoLQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791282030; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Y19uLjWPeoNYSBa6JoHyu/USe48RizSiHSc1o99VZlCsasB
	NgIu24i/zB8B3yHCgtOqALgpyW2qKwCTzRT2YOaCF55o2vQSOqROv/7+Wakeren7
	HyUGlBXAIwUSQ7gC3UOXTAhlyt7vQd3Rm9LN9q6uQ/bI9lLvlLyXkABgAldh7aOE
	MiQg47p3r6RXJt4acKvp01ue3ubP8tm3vakeb/YPAq8n5CB3IrOCHL6VDax6WLKr
	8cHaniMJyWtMoJzN/P1hNQ3sLqXYqaB7DoBv4VdWrK00INUSCsnVP8Nz3xKNXFC9
	5AwNdE3aDSsAmBsnBlwnf0vzlBtjZgb6r4cY/Yg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nzZPxQfMeOpxKHF77ENS29wx1IT/jbTuEFPa7yq3oTo=:78iM40R6LPD2NrkWVbXrjDymsWTuUUITi62nHIYN5qw=;
X-ME-Sender: <xms:bsvEav5Go6JhMV-97vwGUGaEmcDyifZXwUdnJk7cc6J8mHONRK1g9w>
    <xme:bsvEarxUosJw4I02K8zeZ4vU4BxUeneJmKFoth0z8ZMA_g_vwgZyQmDuxuQcYLvfd
    ciRdpLwrGMS6QYLq9bcPIcjdH9FIZ5j9_SFpReOU9iypgZhGfY-tg>
X-ME-Received: <xmr:bsvEauyOoX9JAYISMuCGxUs9uClTzPiQi_B3BDgLy787mY4OhPJ7c5GHBNKmEKdB-b3UsA>
X-ME-Proxy-Cause: dmFkZTGtIPVPTLP04MdOnnaOqZRqNwrYoAQaxlBhIn8OGZ+8KIw0hSwvCVW38EDZiEaqw8
    rZjMnHlS6zAHlfSnZwCmC1mBuVR4gYA6xeWot+JBzsi50McNWl3weNIlPg/xxv/9Hp54nq
    WNA//EOcyHDISddxJPx0iOqO3bgLdGHpw8lRt2ojPpW4Z/ZY8oBQXkbnhbLe1hzLK5rTeF
    nghZaGMUexYJofkGmLab+vjWDZ17okQsZh5r2S+NmkcV9yPwIPSdJIacCyuXnLPufh5a2s
    rVCdlydK/lzH6b50DlEhqRENAPRA8rI2L9Q19JZop1SQKiSbbPt1+S59A7W/XgE2lxYOYt
    m2h/oFCYwEiv9ci9TsK5u4+aOKpdTDiGzhnP9OJncjiRq33aozKf8u9j3bp4ScdHMteEcn
    btYwZyqTSXPZCP38XLh/glYRSZCxA4AjZ9sZ18ofA3+D27QyZQQa3mWKDYtOyo9U3mH64w
    /F6EIyzN4uN3e8N0cw4X+qQd08pKGceuH9jmnu7IFqMeYD+canwd+gmueVNUF2InaNumLU
    T+IPxixfXt3TTWM7ASV+FCyKe5eoGEBFtmFbZ0r0h8iBeqCyd/9nwlysyJjEcg8m2EgX7b
    cKtMmET7LwVwcqQypgTkzOfwz47eomfVcfd23qkoJ+Y68ZOqR4AuxZVUCrkA
X-ME-Proxy: <xmx:bsvEarwMY23llUKZ5Klq988Z321uA9n1Kd_O8rlm_t5gHPOa3RcZXw>
    <xmx:bsvEagYRA4t68w-NKhxd5wQprXe1Sq1qnVH6QXnKYojqy-3_W0-KPQ>
    <xmx:bsvEakX9HdvKVz4w-lj9ADnQEqP6YsyzzDYyfno0cVHdAt2ZbGJMFw>
    <xmx:bsvEamgcJuXdLxND8jAIN0lkdMCvTejDRZpMzd5qm8jW93ZvXDa3Aw>
    <xmx:bsvEakTFIxgn7Ur9KD2pfrzis8DP-gmqtMFHruBv8MWFN-dtIvQpCkXp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 06:20:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ce95c6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 10:20:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Oct 2026 12:20:15 +0200
Subject: [PATCH v2 2/2] packfile: fix corruption due to stale delta base
 cache entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-pks-packfile-stale-delta-base-cache-v2-2-69669a2fc6ce@pks.im>
References: <20261006-pks-packfile-stale-delta-base-cache-v2-0-69669a2fc6ce@pks.im>
In-Reply-To: <20261006-pks-packfile-stale-delta-base-cache-v2-0-69669a2fc6ce@pks.im>
To: git@vger.kernel.org
Cc: Guillaume Chauvel <guillaume.chauvel@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Jeff King <peff@peff.net>
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
bug somewhat reliably! When doing a merge in a repository with lots of
submodules that have similar-looking packfiles we end up opening and
then closing the object databases of each of the submodules in sequence.
Because of the above mentioned commit we would close and free each of
the packfiles part of the respective databases, but we wouldn't evict
their delta base entries from the cache.

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
2.56.0.406.ga2d225a756.dirty

