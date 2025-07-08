Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BD21FF53
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973845; cv=none; b=lAZZLM0unnMxOqn8F8a5+WRuxuguhESC83W42Q/Ox5i0mapKneyACjIddv+BoJtDHbBc1DVZ72SFaEIo7zWBHJ4f1zCrfOwhrHwFLBwbzDfecj7ROjixtLFc3UVNyjPWK5G7qv9+lDeT8VJyj4yJxkMJoJKAqb/83B58RfYZVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973845; c=relaxed/simple;
	bh=oEWTbIT8Tvb0ALSCxJ6bwXBShm5LuqajNDiXY3xpHMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hMAvEqFnDkuL2VfShslgLmd9vlhEugj2X7KotXMVWiOWg39iT0W8Zy4b9Wv0/toHbCGbzLuKM//aua+bF2q69/DIFVe6Q3/O1ko9xCmCCGrv7YoAI1syKVL1fXEvXw11uA09kbl0NJyijcNUvllwBDnneNOJntNePywKlB2MYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FavAdRRh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCC5cUsa; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FavAdRRh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCC5cUsa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6E49140016A;
	Tue,  8 Jul 2025 07:24:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 08 Jul 2025 07:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1751973841; x=1752060241; bh=9EmMn4rcBQ
	1dCZTwf6S7hR08a5Lbb8Sl+p572rlsYnM=; b=FavAdRRh4A1cDFHHaHLzWA0IoG
	4hZh50U+xj5iAh7DqU1qFMkgdpTsVTL8Bw7qFVJ6xf2q5hTv2icZ+n+U8TvCJe+9
	owDImrEwpw/dRaZBVMYkg9Wb+6PuP5pGQrUHcB3qCneYGfTGQtJE5QPYAfqV0NRk
	2vsbOPfmuO72lSseVSaCtTE6zF5+DTLMb9wP2YOO2SNkaPzLq+RiK48kVOhX1THm
	QqdLOG3Y+4gSewJW5SlBdgTpMrpc5010c+V7tb+0qhJT19XuYdGoT3j28mF5ERFZ
	n/RRdxm0UPzkXYO0XXzMSdQbjd2jLz0r6r/9LOTWMJ9tw8Ve2mNAQaHsUV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751973841; x=1752060241; bh=9EmMn4rcBQ1dCZTwf6S7hR08a5Lb
	b8Sl+p572rlsYnM=; b=XCC5cUsaDrq0TZHd1m7/BMUDzJNb0ovXePv7gcZhfsi8
	VILGa9KSznYdvDxm45IwWicj4KWK9yxrB7KS3ErcgeH48ohUcrbvrCVLEEKjMZep
	CBfTXd5Lm2StKw6JoJP88WY5lIkS3oZQ7RM6qDLlPmeBUVpeoeGZXZfrngU1t50B
	WyQGsnsdkm0RqTpSH3sxReb/kY7MpTW7uSVpM0Sxh+2VlozLHskQLzbvirhk7Onp
	YfjMozFCG51Gcy3exmws/rLkMmgFOVguyjLxiXjbQVjRU1SAxeu9dWM+Nl6SrdQw
	JlB+4z+FaBl7q4yNYxhhmU0oYT0h0tnADKItntCnaQ==
X-ME-Sender: <xms:0f9saBStuPuV-YI-Ybvc-sIk_LAMpWk5LpZnKDx8HjnHjDfjrS7VcQ>
    <xme:0f9saK-f2jPbbzWy5mr1QJrgZuUXFrKWH1bKfpRlJeYvFkycSn6KvVfHEPbnHiJRi
    QjCzzgC8QsTYYhHIQ>
X-ME-Received: <xmr:0f9saIqAu541OYz7cZQVRQLMJ0p7ba6UMJNw69fj3ssAw14qdDmq9FEZVkoVLkZ_A7yVN_vE7VmMntGNAcIVFy6C8v7EQ9crhgSxgTf_mgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepie
    fgiedtffffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0f9saHk0UCB96H76n178oNWpaEcVetUnHVNZK8XzoQBaJb2WtK9n2A>
    <xmx:0f9saPL4bryIb4yR2vxSoXXA8kidyy8YA1bRMlKj7RYUaRIS22uleQ>
    <xmx:0f9saMwdliXgeHaBzGP7xxIj-sjE2Ckc3mO1Quu47Y68AjotWymJcg>
    <xmx:0f9saHvvkfEKAEVEy9j4ePhQ4WntWpSOGhhukmhw_Tj1qpzBa87FTw>
    <xmx:0f9saCjrgvDRSu7oVB036EA3YbMRhmU4D7KDShsWdveuhkDwKrQmq9Kq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 07:24:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57e20c98 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 11:23:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 13:23:56 +0200
Subject: [PATCH] docs/git-pack-refs: document heuristic used for packing
 loose refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-pack-refs-document-files-heuristic-v1-1-e28d65a94573@pks.im>
X-B4-Tracking: v=1; b=H4sIAMv/bGgC/x2NwQ6CMBAFf4Xs2ZdUBAV/xXgo7VY2aGm6YEgI/
 27jcZLJzE7KWVjpXu2U+SsqcyxwPlXkRhtfDPGFqTZ1a26mw9AgTYpk3YTMQeFnt344LgjyZsX
 IaxZdxKHtbO/DxYe+uVLppaLL9n89nsfxAxi9m2p7AAAA
X-Change-ID: 20250708-b4-pks-pack-refs-document-files-heuristic-58a9df3df946
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `git pack-refs --auto` flag asks the ref backend to decide for
itself whether or not references need to be repacked. This is done to
ensure that we don't repack in cases where the backend is already in a
good-enough state, which is typically the case for the "reftable"
backend that performs auto-compaction on writes.

As such, we initially only had heuristics in place for the "reftable"
backend. The "files" backend didn't have any heuristics, so we'd repack
loose references every time `git pack-refs --auto` was executed. This
caused excessive repacking with that backend though, which is why we
eventually implemented a heuristic via c3459ae9ef2 (refs/files: use
heuristic to decide whether to repack with `--auto`, 2024-09-04).

The documentation for the `--auto` flag hasn't been updated accordingly
and still claims that we don't have any metrics for the "files" backend.
Update it to reflect the new reality.

Reported-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

a small fix for our out-of-date documentation, as discovered by Karthik.

Thanks!

Patrick
---
 Documentation/git-pack-refs.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index 652c5497715..42b90051e69 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -66,7 +66,10 @@ Pack refs as needed depending on the current state of the ref database. The
 behavior depends on the ref format used by the repository and may change in the
 future.
 +
-	- "files": No special handling for `--auto` has been implemented.
+	- "files": Loose references are packed into the `packed-refs` file
+	  based on the ratio of loose references to the size of the
+	  `packed-refs` file. The bigger the `packed-refs` file, the more loose
+	  references need to exist before we repack.
 +
 	- "reftable": Tables are compacted such that they form a geometric
 	  sequence. For two tables N and N+1, where N+1 is newer, this

---
base-commit: 41905d60226a0346b22f0d0d99428c746a5a3b14
change-id: 20250708-b4-pks-pack-refs-document-files-heuristic-58a9df3df946

