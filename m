Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534633BBEA
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731872086; cv=none; b=EwHxsLosDS6XtQ/cO7VFEc7+V+jUdjb4G6I310b5VxwGwOlUTskTUMbd4QozdnIiu9rW82x0jxXPDZiA5PcaIMG7z7p50jofkXsD8/0uDlJmD0VViZ4aUP7goa4tQ0K2X29jPeLQmh7N9EtnPjHbPKM2nhbGOc0gZv1j5lmSii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731872086; c=relaxed/simple;
	bh=MKLVcSy4jaQ/6PWDOTfPHXmNkCmciBIaPISBWvn1+bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjxWENwRuI+u20lg+xhltkiXDyFbP5Qo/AvFqi1i3r0FbUegDlkAY1V5y/5e9movB1ikjnzsmyKUuvRKFcOyuDCtTiYZglnpkbVwhDAGCh15quABhX5+EWymHmVfZ8qPIZWswkG6DQJilUj00iAZDwlsfEEp42jMoRqgEaEXusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NjofMFW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHNLfGfX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NjofMFW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHNLfGfX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 668A41380479;
	Sun, 17 Nov 2024 14:34:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 17 Nov 2024 14:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731872083;
	 x=1731958483; bh=DQHeY4fQURmbdqnbEQX7UMCCffK4WfJfiTCA2WjBlPU=; b=
	NjofMFW9ZfcyULUOpV56l85m/wTKwKNTJDGdEzvbp6xoZRmsgXp63MF2oKEGvbEI
	GljxRKMOJcB3QtaZwtlt3J63mgF6/3Plm7Dadc9JEmf4kyeIAa/31MQjXRksvW6K
	rTShRvNjT7IF/fYQ01BzFDpzUoBjJ3kKuojwn0KxZcNL/+RMMUpklPkuI+idl/sL
	Q0+/OwuhIlsmvNarNEIHwLopkREg5WNc7rSRzkI0R8vSSuH2kxEn76x4wnc5tTQk
	nth/NO6A85UHoKFqHzwRFNzYYglKVNspaFqSneAwUlSD6eflLcK+35/s55vwijbt
	/bL66IjFAZy+H/ByJLUzQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731872083; x=
	1731958483; bh=DQHeY4fQURmbdqnbEQX7UMCCffK4WfJfiTCA2WjBlPU=; b=Y
	HNLfGfXi0Ny9WLANtoo+D3S5M+xYZzOCSycPpqp4XEjW7wR656H9IGpr5CrbPq+q
	UBcLw9g5DRwYQEtI8uzO17iTlFsdDhKsjnTfGaNugMgdd8Th7M4qAqflAxklxexz
	plUdZCf5jgrsBdud4HPEqq1iQ5FGv/Gs86As9D54DDOudhe30i45DU7WNvBLLpYK
	4ATyFWYX2F9m7LTiJx1Kbwx2fuIPtHZn+0Bxo8SqBwIKzLyAEsoNpHo+8m0F3NWV
	1N7s3/KAN2IyepIV6ukf3NL4vJ6eUkOKJXcjn3aeLuo1m1kAarXGlFL7L62AG736
	TlfvkYrHOp0LBI5rpuN7Q==
X-ME-Sender: <xms:U0U6Z_DB75gTs8EUGTH0TjZxEaeSQW59zXWA_Es10FiOHB1r5AITTlU>
    <xme:U0U6Z1hPibfcVo7PdX3H-QJn78HlkhtB2gbzxoYy2Fd1kQP40zOoqTrHPeQDlpygI
    hVlVYEs4YlCGBBq7w>
X-ME-Received: <xmr:U0U6Z6kwQO-Ku2S6G7KaLaefF5R4U__y1M431Wh-2_MV2JvijluSmqBqNjjxD-UWo2KTFWP7P7Z6GzpSO9Hv_OwV8CZKDj3g3Ls54O2qJl12hOWRVegdYOIoIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdekgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepueetue
    ehjedvueegffeuleeuleeukefguedtieelteetgeeiuefhjefhgedvveeunecuffhomhgr
    ihhnpehgohhoghhlvggrphhishdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepfhhfjhhlrggsohesghhmrghilhdrtgho
    mhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:U0U6Zxz6uzgpqbDTM4DsbvdiDLlRilTocMuXXPHHDIilTM13MlT3Yw>
    <xmx:U0U6Z0Rq0iDQB4Jh-behnAT-o1Efabm0p8MGnitYHwUNa4NadlfGWw>
    <xmx:U0U6Z0bzpnTQDnIlvecDvXpCc8UeDYij0Pq1zn-m_u7GX2lT-XtEiw>
    <xmx:U0U6Z1QKzBQ8E2pyYfpLik0oi0vCqEToqfuD3PpP2q7-aB4t5BUAjA>
    <xmx:U0U6Z5IQ6WbPMOqgKM0aCNA08Z--IxrKg0SmM9h10Te2zd20v3KBzxZv>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 14:34:41 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com,
	ffjlabo@gmail.com,
	christian.couder@gmail.com
Subject: [PATCH] Documentation/glossary: describe "trailer"
Date: Sun, 17 Nov 2024 20:33:49 +0100
Message-ID: <ba35ba3ec212860a3151cfad582a384a50c55e6a.1731871683.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <xmqqa5e2ahqf.fsf@gitster.g>
References: <xmqqa5e2ahqf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    On Wed, Nov 13, 2024, at 23:31, Junio C Hamano wrote:
    > Christian Couder <christian.couder@gmail.com> writes:
    > > [...]
    > We do not even have an entry in the glossary for "trailer", and that
    > probably is the first thing we need to fix.
    
    ---
    
    • Tags: What the Linux Kernel uses
    • Footers: Lots of people around the Internet apparently. Like on
      Stackoverflow. Or Chromium: https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/git-footers.html

 Documentation/glossary-content.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 42afe048691..575c18f776e 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -696,6 +696,11 @@ the `refs/tags/` hierarchy is used to represent local tags..
 	that each contain very well defined concepts or small incremental yet
 	related changes.
 
+[[def_trailer]]trailer::
+	Key-value metadata.  Trailers are optionally found at the end of
+	a commit message.  Might be called "footers" or "tags" in other
+	communities.  See linkgit:git-interpret-trailers[1].
+
 [[def_tree]]tree::
 	Either a <<def_working_tree,working tree>>, or a <<def_tree_object,tree
 	object>> together with the dependent <<def_blob_object,blob>> and tree objects
-- 
2.47.0

