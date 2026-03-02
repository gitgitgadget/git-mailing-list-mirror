Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE233261F
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475118; cv=none; b=cAEbpRk8J92Kq7f52a0mSRTJIMILykdhBN662zln1P+1BcM5T/wfG3KE6gzJrgF6aHqWFKDtgt9aFURUV+3DhcLRbgebeHz5MRXlmsXCh3SAo1mn/or9Y+rZO++mFRg/R7ewYnUJvCJ0hv8bCH4AI6pDvcsTGtDr04bCrfcUPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475118; c=relaxed/simple;
	bh=XLdoh6BxPwHMgOk6M5EVcVK3edo+ge24oRKctlZPM4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKRGl6sH9UPD5Ge5uqCM73wIG8Wl0eke/gE/U7Gu1KQKbl2LeuKJvEC3/kg0fVj3TEC/AYYyiE1QPdLM1xC3AQ2xZelgSyjkkmMT34iQ+F1bhDrcdqAXGO4o2DUppaWo93UemVAkGtl/8Fhf9qmyhNm459Yp45t7mcNYlF27F04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aKY+Oihz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7j1lxjW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aKY+Oihz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7j1lxjW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4375E140012A;
	Mon,  2 Mar 2026 13:11:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Mar 2026 13:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772475116; x=
	1772561516; bh=gCezoCLGPjhetxmravpXlYKB9wrjDy16PX0cYMFF090=; b=a
	KY+OihzI7ByqRTQYvNV6zR6Qok30oLUelO0tNJE7Y0NLKtgz5RwW70dYCIOT1dhk
	KWOkGZv+KkF9S0OvBFwwOMczAPXpIitJLZTEh4PeMxTMuWXbnSVKf8uEfxleT7eV
	4UlFEY6OxomH0dZS57jtYTCpnA8ZqiNvoWkwWj2wuwz4lOqDwzjkEYnDARr2jYR4
	aDtacFseS88kJOTUouYdF2zXK9ya6SljFv5JvUytGHrYfvIOJAofTF84Pc1n1tRl
	U5ahIF/gr2HKlW3CoBfLUno0Mm1wvOXE1IFd+vmddovNdV2fAL++0464Rj44dHLW
	pePZq12/C572/tsATyEZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772475116; x=1772561516; bh=g
	CezoCLGPjhetxmravpXlYKB9wrjDy16PX0cYMFF090=; b=G7j1lxjW1S/Bj9mx8
	IVNUhUhg/OelQ37sSayUOYX2zlrAH4X3AE6K4q5H6F2ZUIqr5A3e9y+YFDY3ddw5
	nf+JP+2knLnhaBY1pdIL7/gC6x3UMiHbzFpRqkruTdFQKFdNnsKKC4YV2t6bNxli
	+G1CqfLqBqPfyrTR8scCz3hRC33k8g7WU2u+gU2Kx4qlY0ZsUUn2/H3B1w2QVRmg
	J0ng8VOW7FzigsW2wtyMD8b7MZ1W7vIAqQLKCudDzCBPvPJFQvrr7R2xwnxP9qmb
	o0PS2Ss88oSpIw1f4b1YxuV5jpWUFjvu4wNz0wLAll2WvCRO6YfQECOsNjRpmTlU
	Ix7pA==
X-ME-Sender: <xms:7NKlaSNT0FEHmmagGYN8ym5JPmDuj0-SF_83ueVflk7dVgErmBfhVA>
    <xme:7NKladi-dHZ4Ee40ygPjZqDvtx4olkrEuzhMQAxd3VaXVeA6hLMmY5SNlVMh7SgtQ
    dQKRB0G1CB8phM5D9oMuD4re7G5IQ8FNXKPPhki53jv2w3fJ_x9>
X-ME-Received: <xmr:7NKladuK8QWYo1fC975zDvB8ruqdcv3HmkPqvt4BdDvhNoBcaRsJf0ibFEKOdEBv56YGAC0Ru0Ug68rvH27x9QfvNT_FC9d-Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfdvfeethfekgfeihfehkeeiffeugeeuhedtheefkeetieffheeuhfdthffh
    tddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrggssehlihhn
    uhigqdhmieekkhdrohhrghdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:7NKlaZji8aZNKlygQEMPEJk_X52ngERh0NRf90R4U2dcAAySt6wraA>
    <xmx:7NKlabbiz3ZjA3KO1P02LhFEaSqJ16exX87jhi7suD3yi2B3lRxK7g>
    <xmx:7NKlaQaD_QjZvVPTfjqnWBZV_5ti3Lw4kZqA-rLGYRlEQvLff_77pA>
    <xmx:7NKlaYyW8CicURei8v1i1O2Fy8Pmat3AC4DNJP1aT7kJY6ysJS9KtQ>
    <xmx:7NKlafZFY2PVMVAE30CO3IDE_wD-_g-laSAkylxXTqXVbqX5a_9Y7puM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:11:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	"D.  Ben Knoble" <ben.knoble@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] sideband: conditional documentation fix
Date: Mon,  2 Mar 2026 10:11:49 -0800
Message-ID: <20260302181149.3502811-4-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-549-g863838a955
In-Reply-To: <20260302181149.3502811-1-gitster@pobox.com>
References: <xmqqv7gcnwd4.fsf@gitster.g>
 <20260302181149.3502811-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicate a bit of text on either side of the ifdef/ifndef
conditional documentation in order to avoid "sentence assembly" that
does not fit well with translations, taking hint from the discussion
on a recent topic.

cf. https://lore.kernel.org/git/ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/sideband.adoc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 85205477b7..ddba93393c 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -2,14 +2,15 @@ sideband.allowControlCharacters::
 ifdef::with-breaking-changes[]
 	By default, control characters that are delivered via the sideband
 	are masked, except ANSI color sequences. This prevents potentially
+	unwanted ANSI escape sequences from being sent to the terminal.
 endif::with-breaking-changes[]
 ifndef::with-breaking-changes[]
 	By default, no control characters delivered via the sideband
 	are masked. This is unsafe and will change in Git v3.* to only
 	allow ANSI color sequences by default, preventing potentially
+	unwanted ANSI escape sequences from being sent to the terminal.
 endif::with-breaking-changes[]
-	unwanted ANSI escape sequences from being sent to the terminal. Use
-	this config setting to override this behavior (the value can be
+	Use this config setting to override this behavior (the value can be
 	a comma-separated list of the following keywords):
 +
 --
-- 
2.53.0-549-g863838a955

