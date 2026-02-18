Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02FD2EBB99
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389532; cv=none; b=fEEl4henHkxXosYPN05LC5SwaIJKTHNyKeWqc8JYuTjau3aWcQlz00IJ5GdnAATWnhjZ5uBzgf2phUrp2Ml2NANOPRmzIjUbI1ZmfQpgHnFPEe/U4mSCIZzrw5aiXOMyaVt+XQOIzINEm1msBLkvtdRnMVNTVLtroyKbOA1lKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389532; c=relaxed/simple;
	bh=lrionZRsyKY2aZx/+IkMOkgCX3Wu18+70urBU0oDdU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLXBDqcg+95qMycUvR5w1dTl4acgMfNppjczI+78YnyOqajkuyFOwEqxIkkXOYKvk8XN0B8CBptb2eEUUyevEEo2J6KoaznLQvHBYJGrP3oSpJ6XD02Z0aRpR7pnuQVNE9HSPFZYN5e2w2+x2/1C4n+du3rsVY2oUjmJl5xco64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fw12Jajf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVvpDrAA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fw12Jajf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVvpDrAA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 099881400179;
	Tue, 17 Feb 2026 23:38:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 23:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771389531;
	 x=1771475931; bh=Xaau4rXYqZbRbJA5U1E0W91I6LCb58EYIuJZeG2kpHM=; b=
	fw12Jajfg8SGEcS2IcO+WLxh1MVkeag+U+9mVvahp67TyC6q9m8Lw8UXlIVo/ESJ
	ywQ7iMe8bUCaEyg/Xok19INYpA5M+4hu/RtZa9ikhN67BmW0/0zOT91xe8C4A1ZL
	SV/jnRD2MypkrNjdvEmTrCrHEErnfA5y9LqRWI37/ybfpt7VXlzhVRlW3iD6nUEZ
	7kFLpEZxAO+YGCX+DOmd3YjndaXywiDSbJbjzxjinQGwPx3HD2pvaZUvlAYv3sTq
	PEBX61VIjT5APwThn21Myy2+/5bMtNJisae01jCJJU1VQMq8LfIrR97K9f4NMZuG
	xl5JNpjjKDK8X1cbPPYsZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771389531; x=
	1771475931; bh=Xaau4rXYqZbRbJA5U1E0W91I6LCb58EYIuJZeG2kpHM=; b=P
	VvpDrAASizhZSqt24B9QiuJ/P+MAcFZX6sgvqRIdOVeFH0YNDs7EnD8S2Nj6ASa1
	6bR1Qb9TK5+NuFiRKdpDNd2o1ENchrTqEq1xcf9gf8ZtE9nU0QAXvPQottPc51Ri
	/iC5bKJGDsufiyxvTlzhQH0oQlJZm5A7wJBi4Lp2nfIEKxySoCHYSCJJGjzOz3dw
	voLqwuHlvT76eRyZ45AyNuvYwc+8nzMD3Kvh4E2OXImaHgJipCOFSKny/nbQ6Frx
	bQyQNtMVoBp6JkrxPh19lh0Z5NC8RujDbmukHyfeXwMR7EG8AYFiQ/jF0OI6zECR
	DKXDvEqveohCVovQDjI3g==
X-ME-Sender: <xms:WkKVaTHJJsdPLnmviPUh2te0UwsZDR7hRcne-IqmozbPnRTK2eDMbg>
    <xme:WkKVaWVPBXSlWCkcc58O5_jaTOmllEprx9WzWsRYLlEgfxB0UygSQ3Ko7WqX6ECDC
    EJhmcFtzGogqVXOktW-sATrUFcVbWhDzuxiEak294Ku_ftrxzlVAA>
X-ME-Received: <xmr:WkKVaSyC_CatVITJNdMlBlHkoBYdlqMk5fW5vzDPkNS2ulRxg4U0wKkUSEDx6XMsC5sJ7C5zV5EIoH1hy0srtK81PD0kX3TDbf7MDyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WkKVacM94cbRYxD65f_5ejQ1xzZJ4LX0lBh_NsnT8_Hct2rLDAzUQg>
    <xmx:WkKVab777v6bSxaKx5kXhzG9aXndXw1Xz0LUHsigBF6p3hPOAJ_Utg>
    <xmx:WkKVaVPPrbZRs-s6oLWA8-aeixqt67T8s1oTOOIB18O2LD2v8CTa4w>
    <xmx:WkKVaRmLXuaiGF9cFso6P5ts0wc35SLHmgeQrfjCpzmEbM6yU8zNrw>
    <xmx:W0KVaedD9fSVbOd7MBHnhlG5YCA01jGOLaMZlP1IiAxKUzj5HaOUhztI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:38:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6d7163f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 04:38:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Feb 2026 05:38:39 +0100
Subject: [PATCH v3 2/5] t40xx: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-2-08c1ff3ffc9a@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

We've got a couple of tests related to diffs in t40xx that use the
iconv(1) executable to convert the encoding of a commit message. All of
these tests are prepared to handle a missing ICONV prereq, in which case
they will simply use UTF-8 encoding.

But even if the ICONV prerequisite has failed we try to use the iconv(1)
executable, even though it's not safe to assume that the executable
exists in that case. And besides that, it's also unnecessary to use
iconv(1) in the first place, as we would only use it to convert from
UTF-8 to UTF-8, which should be equivalent to a no-op.

Fix the issue and skip the call to iconv(1) in case the prerequisite is
not set. This makes tests work on systems that don't have iconv at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4041-diff-submodule-option.sh             | 8 ++++++--
 t/t4059-diff-submodule-not-initialized.sh    | 8 ++++++--
 t/t4060-diff-submodule-option-diff-format.sh | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 4d4aa1650f..4dd4954260 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -37,8 +37,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index 0fe81056d5..bb902ce94d 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -35,8 +35,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index dbfeb7470b..d8f9213255 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -35,8 +35,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)

-- 
2.53.0.414.gf7e9f6c205.dirty

