Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF62DE6F4
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652704; cv=none; b=GuA9G/On7Ygq8ROPa9OHuaFC4aicOCTkz4aQ81ytPGxicF5P6yzc8m8N7iJAjOB707FBmVV4slYRL871tJ/LazToh93EWhxz5QppQRjzeKtHK2kcOmqoRU6uktEAiSoOXz3J6w70Xhsxy9XBRS3+bJcL/+MRjkrSv/ij7ucLHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652704; c=relaxed/simple;
	bh=zV1SvffJ/6eWlr4GZ3JFxctkbPDLgd3haAPKNu4NBIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBrKBkCPL/wx+fXklXJR9iR8IZhhQR4/5LwbzyGM1DvbO9Cv4tEXUSpYnlr0Nr5qGcwc68iEoFrVaJyjZLygdG/LqW7nwomFT75oXJEYZaYpKO//+Kg0HDR6/hPU2sZe3BQHu/19znWoz2s4rY7E+KUxNzSe5DlxZdko5/GO+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BiIOngd6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fhhd/fvC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BiIOngd6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fhhd/fvC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 94B3B1D0002F;
	Thu, 16 Oct 2025 18:11:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 18:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760652701; x=
	1760739101; bh=A4H9JusJMRh7gac3X4hn8jsH+euAjyiK7qA713pyGLI=; b=B
	iIOngd6Ou3v8SlnOpZp9Tz1By+WbP5slX98Zk2lZYYRBWH9k5K1Gap/1D9RNQBZj
	pKPgEEYZro0DJWEr0PPKqN95Uhu1iAdQIX/sbBzZAaS5l1RYx20mXEWdigyvYk2g
	stPfnkeqeJ6AtQcyVVIkRWKXnc2ECkBAfMAp8tG0lTosZuO4KR+WIUCy/UYwrshc
	9YlD33ITT6dWo4rpns686s3W4hLKVb6Xd0Ch0gPac3BKUlk+hnSdklY/38bp6Lot
	CNgGKcnypAXDJ0GIZXNMH6KWUZ0rmZsEPY7lr8NGdzWUE0P99hE68xbXYAw/50bi
	Ya9wwyfvYthUVprZajEGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760652701; x=1760739101; bh=A
	4H9JusJMRh7gac3X4hn8jsH+euAjyiK7qA713pyGLI=; b=Fhhd/fvCpegvQLJnV
	PtZJA+5Ko2c9gtKrXnczRxe36gwbqil0z9gabYoZq6Cx/FT+DBtqPrzeCq2nqVUU
	3b1LWfHCtFOjhGxJcos+uky2y8FsOhBiD1uRe/d2cTFAKw3LCBuM6yBgKLzHkEYx
	bft+y93AsPbHZqP3cOeGy6ZFdPApvlXW6WO90BP/eqQ1yKOYUM7mEOmrq0lc8/sn
	OPTSmxwF3JKioZ8T8zEEplo1J0HP8sZf/OdxcR2k8Yhn0LSf5+zKOeEmDfNHV+lr
	WsH9MZJNMFEe0LpY1ghp3SKQDzydvlEuSIvUhqmDjG11w6qrT32fo9zQBs2gj6Yj
	DbDrQ==
X-ME-Sender: <xms:nW3xaLxTUQLJ5WX4LFCu5-rtADgsp-3xdUPupg2w54C5dr24XKNXb0M>
    <xme:nW3xaKJ1WGKf_z5mZY0vEzrZUI392zYAjhilYqrcL4XCohclz3AwxJJcD6ppLL4LT
    kSy4wLFtsWE_7fdxjQhoYJyU-OX4azySyIn_NfbSGWNQR3RfsxCoA>
X-ME-Received: <xmr:nW3xaNo0xOnTqM190EC3ujoWsozoJeTAEmnubakF9U2qPwWDBjDoWW8vihAaQCgnmAlSsV-fnnZiPAmQU7xgvTKXnP1UMXNKUHuvtuolJhL_3-X-ke115xZqxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeigtd
    ertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhenucggtffrrghtthgvrhhnpeeuleeiuddvfeehjeeftdetgfeluefhie
    ejleeiieeuudeigfegteefueevteekgfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhn
    shdrtggr
X-ME-Proxy: <xmx:nW3xaBKHnxriN3NBgfAODroFXxqEhQUbZmF0My6pDq-nYioV68Mmmg>
    <xmx:nW3xaKRr9P6Qde_RXd4Nv_44XQ8TdzNjLzX3dvU8bncXhlhmr1RrWQ>
    <xmx:nW3xaIuG8516vczHFuxz8CP2-8cUlsu5gVGCw5l23fYB88nuk8tXag>
    <xmx:nW3xaDZz7vPqUbdkOAQdp_A646NBBlIIYQaERk7W6VC4PoqKbi_Bcg>
    <xmx:nW3xaMazdK-1KECpBthi1-_0fnrMIPNdgRQVw4ai1oqkiIcVVn92uTU1>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 18:11:39 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: kristofferhaugsbakk@fastmail.com,
	git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	julia@jvns.ca
Subject: [PATCH resend] doc: git-checkout: fix placeholder markup
Date: Fri, 17 Oct 2025 00:11:30 +0200
Message-ID: <54bc6875cc5.1760652634.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.1.498.g8f0801f1c10
In-Reply-To: <359afc34863.1759430054.git.code@khaugsbakk.name>
References: <359afc34863.1759430054.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The placeholder markup is underscore (_), not backtick (`) as well.

The inline-verbatim markup (backticks) handle interior formatting. This
means in this case that it applies HTML `<code>` to the underscores and
`<em>` to the placeholder.

That is the effect, anyway; we can see from the rest of 042d6f34 (doc:
git-checkout: clarify `-b` and `-B`, 2025-09-10) that this was probably
an unintended mix-up.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Since this has landed in `master` now.

 Documentation/git-checkout.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 431185ca0ba..6f281b298ef 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -61,7 +61,7 @@ uncommitted changes.
 `git checkout -B <branch> [<start-point>]`::
 
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
@@ -155,7 +155,7 @@ of it").
 
 `-B <new-branch>`::
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `-t`::
 `--track[=(direct|inherit)]`::

base-commit: 83a9405e59e9cdfb587b19c50f0c040f346dd4ea
-- 
2.51.1.498.g8f0801f1c10

