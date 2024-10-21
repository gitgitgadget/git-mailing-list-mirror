Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7D1E201E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543690; cv=none; b=I5Q+LLQVAEacDzZ3BKaBDHPnzSYExlQM3fdVUNm51qQX2Vjva8SUTpYKQ04xehImh8g93uWipPdv32hcK0kNS0XR6JjhI/glWqVN0U8JtftpUXvw0pRNRChIM7Zwt+wpZwD6v4nwK6ydgeEyxhESsGEtYf9Gtz3HdTCDdBCHvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543690; c=relaxed/simple;
	bh=KH4XG90Zyj/tMpPxH4LXiWdEnBmenWDM3i4MxRvLqmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KV+QznKErbZAmjsJO8LAec4eAGWEXPHdeSmdhlvGW2L/2v0pxJBHHQ2qktCY1tADZ3eqMxfI2tQZdAUcK9VqYoiTECxrzmfdXweAKNzB5mtW7aKXnREmWpo5Z41raELQ8/Dvw6KLVXp1hlfSVu15gKBKmJVniKhu1Dl4MBc/scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AzZumfYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOowOHmu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AzZumfYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOowOHmu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 129611380439;
	Mon, 21 Oct 2024 16:48:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 16:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729543688;
	 x=1729630088; bh=sbvdQzRuWW+1mdMbLBVYf3XpslpbevKHyRRqkITECQY=; b=
	AzZumfYvFk+KWVJet+w6n3hcO/sXyOqtYxyd44yR2Nd7pMi0TbnMRaJVZF/hRKM8
	dGvym+LsibHXVlsQLQ7de+3kBsIKXv7wzMjvPFZCtqDEb0h5xXM3ZZnCrDlxLOVw
	rVjSYoHZ8ha/w8XDPx+OvWOsOo/ikVQB1EYgWXXk0+E89wp3CEYXTnIghSz18l8U
	4HdhBdva0/xE1cMFk5Dug5mK+ZMl2R4GWIbSma9BGm7r7KLHqED3kcV0qbs2qXMI
	2Y89DPOXA0j1HuyJM/VzzQqoY2yJZ+GthY/Y6efaFwC4AZ4M2binczSaZ4hkpXwa
	6rv0AdYVWsobvwGfj3CRqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729543688; x=
	1729630088; bh=sbvdQzRuWW+1mdMbLBVYf3XpslpbevKHyRRqkITECQY=; b=T
	OowOHmu90wr273v18jROlGh20PSkcDoElkvNA7OLl+niWVg6mUKMIQk/Kdj6w2j7
	/UsIQEoviwKppQ4cZPR2SoRloDhVpA1tGElULDOt61LyNngGoNQ2cQPnYduUqLQ6
	xHqo39+w1TijpE1Lwfi28jX+u4pbpHWc42UZlydhF551xCYLKTSI3tzgT3ZCwsaR
	t0r/YnoXzRQCQPS/HZ7xnHdBiTtYKHEY51VMasj9TH87UEN5d6bIjVnEclLC5ci2
	NxnqA8WviIl5qh9SgGJTkBvIuX4Zg0XEfIyvmZDhCygfahAk7pSz3yOwyqfL217k
	Wfw9H8sfY7d7UkCZ65HGg==
X-ME-Sender: <xms:B74WZxj_00B_oJ_5kCSr23H_9aneyPlpKfegwJgrehqPNsNNY5GSF7g>
    <xme:B74WZ2BJiVPYyQT7nJZTf9MWdnlDX4kQaX1xzCB5wNE9BaCSorT9BNMxabN_bm4_d
    JWkKlzd5MLgXbqhcg>
X-ME-Received: <xmr:B74WZxHWQMV-wnkVgS2imNpYTFl0b2QTWhXeVeZ5-nmmgg-9b-EUE14bZe8FZwYEj1cq_V6YRoFi2OOlqXsDWbStCWO63WuJOl2erE1Kaleew1G1nyxUjJJ1ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:B74WZ2TXfZcSCpKMIGsRzCj__ALHM0R34U-ecAaU0Gpt71_5w7s8Uw>
    <xmx:B74WZ-xRjBSB5i3dOfYJQw1TGuQdVzSoSqOVofrRhAv_pAxTdcpEdQ>
    <xmx:B74WZ86Fz3_boz0iU16tbc_m_sUeK4advJ9GrYDbHb0CWDudYv40Vg>
    <xmx:B74WZzyeGE5qaszbRuc8FWNmzcIYledBzvE7hQYkKRVNcRg_LeBBZw>
    <xmx:CL4WZ9lkhS54lYGTw40DCPJyBxu4qNi9vcMu_D1-QEPhcvjwF-1gNjlt>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 16:48:05 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 4/6] Documentation/git-update-ref.txt: remove confusing paragraph
Date: Mon, 21 Oct 2024 22:47:27 +0200
Message-ID: <f6a70b3f70a8d92a40c2079961e1b060e891cf23.1729543007.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729543007.git.code@khaugsbakk.name>
References: <cover.1729367469.git.code@khaugsbakk.name> <cover.1729543007.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: f6a70b3f70a8d92a40c2079961e1b060e891cf23
X-Previous-Commits: 769fd20945dad7ec60f1109525466d916afa97a8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This paragraph interrupts the flow of the section by going into detail
about what a symbolic ref file is and how it is implemented.  It is not
clear what the purpose is since symbolic refs were already mentioned
prior (“possibly dereferencing the symbolic refs”).  Worse, it can
confuse the reader about what argument can be a symbolic ref since it
just says “it” and not which of the parameters; in turn the reader can
be lead to try `<new-oid>` and then get a confusing error since
update-ref will just say that it is not a valid SHA1.

gitglossary(7) already documents what a symref is, concretely, and quite
well at that.

Reported-by: Bence Ferdinandy <bence@ferdinandy.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Message: replace “this” with “the”, which avoids two “this” close to
      each other
    • Message: Mention that what a symref is (concretely) is covered
      by gitglossary(7)

 Documentation/git-update-ref.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 6aaa7339d71..61647ee8413 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -25,10 +25,6 @@ value is <old-oid>.  You can specify 40 "0" or an empty string
 as <old-oid> to make sure that the ref you are creating does
 not exist.
 
-It also allows a "ref" file to be a symbolic pointer to another
-ref file by starting with the four-byte header sequence of
-"ref:".
-
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-- 
2.46.1.641.g54e7913fcb6

