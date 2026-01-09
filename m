Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E71320A0B
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968826; cv=none; b=QjwE4N89yr46ILvL0ejHTN3v+mUJPq1gFP7DdwBKkbswJtgAOjDfPctGP91eBR+QXKy8lbHbMI9YJRk7/uWNXN4uZnoDLsYcmZmXWSzS1yXdaYQHJSYPtMZiUymTIOx9A7RJs9tnoeuhfTsJWlMw8CaYzBpY0Uog0MWQ2TmeygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968826; c=relaxed/simple;
	bh=3SyhoR5/HtFqRJQkmAdGY1ECog+m2jzgPDFralcKdcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kumWOtZwJDRhvwwaGYsXPEY1htZ14UoCLXEI36PbaEIWJu4VOrznFO5/jGg3vpDwOyY1NolbAAEgpnPrYzDim6z6FnExI/QI28v5UTG+TLUXv1reLrj9JLV5hWk0crtThk8YQ5yK7LejjGUu21peeT4W/2h0y8O56UtvGbPuLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BPT8V0ez; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6CFfX8G; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BPT8V0ez";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6CFfX8G"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 427BC7A0159;
	Fri,  9 Jan 2026 09:27:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 09:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767968823;
	 x=1768055223; bh=ncdUfCjMGgpbw2QdPsaMg5X6QguiH0f4B7JzGwotpSY=; b=
	BPT8V0ezmSpm9M4btbIi8gpQ2rhJZ9JPiKGVj6reVSqUqan7Ic94MBuT02lXKFSf
	EETtQ2Uh2nB0k4h2T5OjWZ4D+M9pzywTMAzE58J6eT7h665Dp850cIwjH+7DD8J4
	bcPFvF7lEi2IEvdYTSZKDCG0putypkgCp47SbzXiUUeRxoFaYugFFyHdig4XGOU3
	CvJrHRNBa+rSA9I7pODxcgGUviHT6d50WYo1uszU8jnYIhOr4AT3mv61Vz2vLobV
	YsO2/WUJvpo7p3YPbEvLLJII2r3m3zTsdRmqofQB2JklvAu673pz1HHKSmidxBTx
	4tV4YVfMHK+tRuBj15ItvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767968823; x=
	1768055223; bh=ncdUfCjMGgpbw2QdPsaMg5X6QguiH0f4B7JzGwotpSY=; b=U
	6CFfX8G+CSD3N4PzgBL2vqt0siC5RK9qhoO9BDqHNPTisoPpBrpka5bwvqN0CR3y
	8+3plcXWneKnZ6BN7LLST7JTUJ/uW1M+mwZ1H7qObZzst/zvyMfgVCEsgtVj/NWU
	VxyF2TR55xR9PRDSzfx2FTN7dMaVd53lBE4idhrdbaWNulLr9fL1x8vJdGSYaqKb
	+YP0SEZtLkmSwwemhgnP4powF9aNPH4LeKe7HD/efjDzI83bIiEyf0rLaB0ggaRu
	UrGCe5UKF42g0iLFq27qG1oXSATVxozwM4nHwfTWyMkkqOc5jsA113fXlUyKD9FW
	YpHZ2MOvzVUGTWiv45svw==
X-ME-Sender: <xms:NhBhaQY_paUVpmdWtHjFxj6bXVBLq1s1kiVTmU-G9olCp6RbTwPo4x4>
    <xme:NhBhaSb6sa6bwhJSd7m6WxfFxLuasKxwaZ6WUWVxNNl83RPHAe4ELRySEXOjb5eno
    JX2g51GSHy9jeoGEYK7Sg654pN4LCK7opAmOgq4L-ZsMZvT3uRdKg>
X-ME-Received: <xmr:NhBhaf-zd0WxmhTwMpDHuU4GpnP7wsMYMzuyDgGqmtr2XrseMmzEFaPIwstSUjMIeyN_BOvGp8Vn-eD8BM8wFLtqtxV4GwfIDRtJ7Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhushhhkhgrrhhkuh
    hmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:NhBhaZjL4gl0ID-XhHBkZgHgPBbaLqqzqTlPFszGX-UUPBhRnD_PMA>
    <xmx:NxBhaXd13CX08ncL5eLvOlCTgPBikVnX39TEeTsQZrin1XcHytPo1g>
    <xmx:NxBhaYo7sfr--bTGiwcZ8wuxWW--Uts2HYKCasYvoOt7MhiBYUPxWQ>
    <xmx:NxBhaUBpFxBBova7iyO7ScYBo4CnmC54J-6OtiMMJGvsnGUAiszKAQ>
    <xmx:NxBhafcu5W18_k2SDcCPaUEm2tdCSh2HWbU7wYdLB8NnLePSRzZHiZSr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:27:01 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/6] =?UTF-8?q?doc:=20patch-id:=20don=E2=80=99t=20use?= =?UTF-8?q?=20semicolon=20between=20bullet=20points?=
Date: Fri,  9 Jan 2026 15:25:57 +0100
Message-ID: <V2_no_semicolon.1b3@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These bullet points are full-fledged paragraphs with sentences.  It’s
best to restrict semicolon-termination to the case when the bullet list
amounts to a list of items.[1]

† 1: Like “List: ... • first; ... • second; and ... • third.”

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 92a1af36a27..bac37db09d4 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -45,7 +45,7 @@ This is the default if `patchid.verbatim` is `true`.
   with two different settings for `-O<orderfile>` result in the same
   patch ID signature, thereby allowing the computed result to be used
   as a key to index some meta-information about the change between
-  the two trees;
+  the two trees.
 
 - Result is different from the value produced by git 1.9 and older
   or produced when an "unstable" hash (see `--unstable` below) is
-- 
2.52.0.421.gc32ead4fc78

