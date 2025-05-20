Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6972517A4
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763891; cv=none; b=uLBmeHjSZMp4PYmPpIG5dft0IfHqyHNdLgFD28UEzQpdYvWD9+9qE68IP8zl6etpBN/Ymn/YptlDBbMhYrHTEFiTUuc+FeIGJXFuZSOvtiurssxC3FLwEZ0VsuZUbKz5dsNZqR2RWfwRANvca+4F7ZnaEtJV7AVadqXy66XB0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763891; c=relaxed/simple;
	bh=mNzyOIBE1J1Pha5Xc/RX6AwbXJiFvDWnyGz5lMCxjZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBowrXFkGwWfGw35H/jSBOShHH/4g/XHXnEORyMDXXhTMzZsoKqycmKK3TlUPZahE6IiZC3SwZC1aYec4lSrlZSr3PU1WCUNjtYDWAelu+MxmyjMJUNkKb4n/Izxw8yX6TEym0vbLrsVXDV6dk/DGCgz8NpRPTfewMZhurOz53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=21t0bP/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BDiFyyt/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="21t0bP/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BDiFyyt/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 74113138043F;
	Tue, 20 May 2025 13:58:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 May 2025 13:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747763888;
	 x=1747850288; bh=FlOvimPFcHCm/G+CNODx2SjCSMt+2ADmlvkef5ylb4M=; b=
	21t0bP/23ZDpYZ5O82MLPFAbLQkCA36RkQNBIfqQlNz4BCRm7rFyb33SEyul1UQ7
	YQigKlnhHkluAYgqVoNbZv+U3UC19+lYbQSAtSqoB+59vzXFvIPV+Pbc1kwgO3RG
	DK+WBHKw5fZHDnEAfPfFfcR+YZI58kq2q+bTIwS8aImyCMcGXAEAjd7Ozr53Rs0c
	E5Dje38u7rBikpr+laxgyW7cz878VVYCkabO8kv2UvYmpLXLLGxKaX8msrYfL03R
	oNuP088OC2ZdT606mU7SPtlE+7mbhrxErObI/3yyA5wbOacudlR1dqLejXjNrQK5
	Udp73n+kcQar2LSv6Hh5AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747763888; x=
	1747850288; bh=FlOvimPFcHCm/G+CNODx2SjCSMt+2ADmlvkef5ylb4M=; b=B
	DiFyyt/nWikTizqrbvkkkoE15dKKYxsEnt8TbwZrgYAHqPYKY4YBgIa03jsc78fb
	5/3FNGuet4lc8gnBkKVvUvBX8fXedFDLG39aD+eo9eQpbQ39G6IJ9XTm52JwihXV
	xBo+X4QpXc5FNdmJl0UF/FPKa3OOBV3Kf40GAxvIC/QkKmfooDUUOSk1Y0NIR1qv
	Vy0saa9kk1gkgD5gHULi7PnoxMpZ7PuBQnXyS8iU6kLa7y7ljwjMcOTLOke1xXbI
	Jz39qD09SK4VtZkc/vJ7KXqacunVkRYHR7i0WcVnW1GwBuDMUvszMiQ2gXDhwx6Q
	44kDkp8iiRIKRKhRaA4lA==
X-ME-Sender: <xms:sMIsaNqh8FTDZRcH0k8w9kW3C_HLvxjJqVGxYLr2n-O9ADbMExkbutk>
    <xme:sMIsaPrhzOQaCL_u_dBsqHCjVrAUsgDx3jXqGJqdEbp_e3I7-eUeV26fbdhEsghU7
    nIyOQe6azYTNFK7Fw>
X-ME-Received: <xmr:sMIsaKMrG5SxvpPASGs5cOPDK397nSG5sWYjgG5kMRx5Mv1YkY2rvJkvneDje0401vBZT7FVCIW17AaXjR3lpFU2gdbIdSo8Bqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekjeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtf
    frrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeet
    udeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhs
    sggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sMIsaI5y7VHLRBQzL1lvLDsdRCx7dAKdfVBAYr21SLbQN6kQ-dq9rQ>
    <xmx:sMIsaM4eMTLr3JWEiY-RY_H4_ejxsPEhPDwm0VzJ8Syosg11wtNptg>
    <xmx:sMIsaAjOZQt-x_RTNuOgvXyoJCZtyY4Hsf7aPoYjmcE7morcQgMAVw>
    <xmx:sMIsaO56caOw30DB9JWk2P0ZL_fIKODmMCC2rqD9zME-W4RHubukew>
    <xmx:sMIsaMyA4vygcBO2svi0LOsBkD3MkQfYsrDywW9_R-IL2Bpj9-M8gKIV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:58:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 1/6] doc: stripspace: mention where the default comes from
Date: Tue, 20 May 2025 19:57:19 +0200
Message-ID: <630ef019786bdb0c7538cc9794a7ba53a0ac77d8.1747763769.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1747763769.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Also quote `#` in line with the modern formatting convention.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    “modern formatting convention”
    
    It looks like characters are quoted with backticks in the commits I’ve
    seen by Jean-Noël Avila lately.

 Documentation/git-stripspace.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stripspace.adoc b/Documentation/git-stripspace.adoc
index a293327581a..1132a4cf9a9 100644
--- a/Documentation/git-stripspace.adoc
+++ b/Documentation/git-stripspace.adoc
@@ -37,7 +37,8 @@ OPTIONS
 -------
 -s::
 --strip-comments::
-	Skip and remove all lines starting with a comment character (default '#').
+	Skip and remove all lines starting with a comment character (default `#`).
+	See `core.commentChar` in linkgit:git-config[1].
 
 -c::
 --comment-lines::
-- 
2.49.0.780.g892193c3f50

