Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E97303A0D
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658566; cv=none; b=oAgkHcA6thBYCHJRiDVFB9Wb4njBvFHehgT2eJJNDgli3nwj+AeASPntVBBlTTW4SluZZv+x8ZVh17YGyd8CY2S9VgxA9dDOo3iJuNKuXhOd3vxlFWyTdAy51x6nX/AjaTUZRoWENd2lf6tXPb4UONxzu374M+iRxL+Sc+lAsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658566; c=relaxed/simple;
	bh=1rXuOXpPHTF20tdSnyapafWWB94nPez5npJB0qmda/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjRn2FNz3YU/78kFRWYYsuPzYNSi+gcZOdP7dNC6F/XPWvQaNWa90Yf9iWWtPSvyTvZABtx3M4lg8J5x2qZUL1K+Rg1mokf3sG8kr1snPA7Hn/faC4u5NYlNUcMrVyA7aMn+TYg5d+3M/SzSZKoHK2njgGiGe8JobmrXN9rsWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kXtQcmMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWMIArPs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kXtQcmMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWMIArPs"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D994EC05FC;
	Mon,  9 Feb 2026 12:36:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Feb 2026 12:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770658565;
	 x=1770744965; bh=jwJ9rpVykXHrGpsjftcPIguR6cvbuRVJXnp38I1W1ig=; b=
	kXtQcmMnqPNYM/dfJA2KEbBxCIowepwvtczWyFDP+/7TaA/SBK7l/LRc319QgLRn
	iaZSoZagNtKgmwPbCPURIA3ZY8tW7SFdIMyOt/4FQ18Kg+PXQviRa4tpHH+VmYgK
	HKYT+zpiWnJmyf8qWcCRzIQNQ7bi8jAv6JU+mip3wyIJfzkLm9JYtUEYPZV3LPGW
	d23ZRvLqt6ocPp3WieMeNGlJ0ljoMvMMU5UUAc2CY5PFCweW8NeoNRdT0n+9zMZ9
	zrXO4ldJWqPnZbx/cc+wVxqeYZury33jhLQ6uLRu5qcuOzlbJswiykmUaRnKSnkk
	2IjzFDl9aMebyFQ5++82yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770658565; x=
	1770744965; bh=jwJ9rpVykXHrGpsjftcPIguR6cvbuRVJXnp38I1W1ig=; b=J
	WMIArPspt8P764ax8D8j+Q1LLCQydutjYoCkjD3xsYOQMviaibp6mWX6aqisGtrD
	YrcuxlaR9Mew7IDYgUK4pYmDC8CWPqxYF+3KUASzdI55fj3JNl0U08m7wRyv6A6k
	LXP9VMGa/dexjJgadE2YUIamfvcGlToKaoEnbqHGUv5EV0t1eTKxPaMDTRvid1su
	SaqNlapSpGsfLPySVb1IahosVJeDT5IjNZhn1+YUFIMpUCBVR5SnZvX5sLHwm6f3
	K/8nERQohr5fbgLSPwOpep5fDI5xcxDeNsKohxrPSM5WwFsVIVpalyd4gzDkW7rR
	xH9p5zJPegx/K+38Vn2Hw==
X-ME-Sender: <xms:BRuKaUNQnrSJ1fRlaOc3Y-b_nRijHx0XzmT1D3eET-IiMGz_CLJXJ4I>
    <xme:BRuKaQ_-2xO6t-XAkPXwMXXKQihXQ7ClP8OAJ0ae5ttoxur_pY7J2A4oyh3hua3Pv
    CznDYoWoxcHYzYUUp-RCCNUegBFVJ1OA7TSqZTeRgL40ccbMldgww>
X-ME-Received: <xmr:BRuKaY6cCYeSthYc37mmjLH_x3faddE-zPFuJniKZvyo5Uh5fbOeaZaVA1Qtfy-CDKUm_Zk-KhEijZCTBWgbKz7WUk9mfPvzI2PDP0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:BRuKaX2FgcDi_uWnT4EixPhl9RtRigCs_teu0QjAZnOJ1C2B3v4zjw>
    <xmx:BRuKafChFrTTeg3ZOapEGWpdJs_wB_FstrVHEKxiIrTC23dus2skog>
    <xmx:BRuKaZ1--AmSe9UTK_m1T6s_hxpMoolTyWn3ZwgVRF0Ddb8Dklmhxg>
    <xmx:BRuKaZup3zoooGWDVfDXkdCmBP-tlDNXimj65KZR3EhtTZTcW-NsvA>
    <xmx:BRuKafm7ZzQTx0iZ67hq98KK1K-ubSeBy8M2NwYBmjmJg_R_oLY3cgCX>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:36:04 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/4] doc: am: say that --message-id adds a trailer
Date: Mon,  9 Feb 2026 18:34:35 +0100
Message-ID: <message-id_trailer.323@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
References: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The option `--message-id` was added in a078f732 (git-am: add
--message-id/--no-message-id, 2014-11-25) back when git-interpret-
trailers(1) was relatively new. Let’s spell out that it is a trailer
and link to the dedicated trailer command.

Also use inline-verbatim for `Message-ID`.

Also link to git-interpret-trailers(1) on `--signoff`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-am.adoc | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 70c605b4156..5e0d6e6fe02 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -37,9 +37,10 @@ OPTIONS
 
 -s::
 --signoff::
-	Add a `Signed-off-by` trailer to the commit message, using
-	the committer identity of yourself.
-	See the signoff option in linkgit:git-commit[1] for more information.
+	Add a `Signed-off-by` trailer to the commit message (see
+	linkgit:git-interpret-trailers[1]), using the committer identity
+	of yourself.  See the signoff option in linkgit:git-commit[1]
+	for more information.
 
 -k::
 --keep::
@@ -83,10 +84,11 @@ OPTIONS
 
 -m::
 --message-id::
-	Pass the `-m` flag to linkgit:git-mailinfo[1],
-	so that the Message-ID header is added to the commit message.
-	The `am.messageid` configuration variable can be used to specify
-	the default behaviour.
+	Pass the `-m` flag to linkgit:git-mailinfo[1], so that the
+	`Message-ID` header is added as a trailer (see
+	linkgit:git-interpret-trailers[1]).  The `am.messageid`
+	configuration variable can be used to specify the default
+	behaviour.
 
 --no-message-id::
 	Do not add the Message-ID header to the commit message.
-- 
2.53.0.26.g2afa8602a26

