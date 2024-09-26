Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15781849E7
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351221; cv=none; b=h+Ehsn9+XQCcW9IqgqRBH7AzO1ITTu0zdCABj4kHJiPEnBRsd49ctolvCbXBURdJeuQETZiFXQ8JHbVYmDnyP9XDwvmyptxgb/U8bV43vzIEAWALOkfLttZ8FPgHEu9dHGIPiX1JXzBfSPTgJP0MPBcwytBHrrxisZfuRHJxVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351221; c=relaxed/simple;
	bh=c/CV+UnPp6YyL1wTDy7nKvtM0F2D7zuI4L8ruv03+P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9s9S5MFC8oAs330fQn9FFEF/0MNFyqksEpM3EZJLB+03n5KZkVr310dwZu39xSj29xQ6maxnQlGiWSTincumbB8fRW26gkE4NzrBDvbE79LX++JVIF2/qPNFeRb/DSEd3yltJOGTjNKL8mSaOQMqnxlkjV77bN2hvXqx5LhnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=inm2hQqE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VweB1C0w; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="inm2hQqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VweB1C0w"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DECB0114024B;
	Thu, 26 Sep 2024 07:46:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 07:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351218; x=1727437618; bh=5V9VDGRbpc
	a0AU+XHre1obAgpVurqNz5tI0Tura1pUA=; b=inm2hQqEQ1rc6zdItHCOiz6MRx
	KlzX3NthZ1BbChaoICGCtggsHNiVqEwtSHQ84BgGEaTrxStPeXdVbgYX2JeYZAD9
	1cR3R8wJPHjRgtUJyEL5Q9MAm5g4ii0rcOUW0T3VsPyGRUKR5na0AQnHpbehrmqk
	LVheqatDY47PdZv5BgwCQ1F9XowOFZEofvbM6V68MWt+DYSGp6VteDtmRu6NrKKY
	mH4WergOr7QHSsAGyethHrPCLdDy6V2C2N1Ig3Y8CWgy4w1XSdPtSTA8W9fjA9CL
	pkwsk9JTSsJIv4DZJrm1/KFDe84xSztBupiF1Yb12nIVj6e6Czjiir2PcuQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351218; x=1727437618; bh=5V9VDGRbpca0AU+XHre1obAgpVur
	qNz5tI0Tura1pUA=; b=VweB1C0wVuEUwabfaDPM222ZtnnOaYtAnxIv58BDJu61
	4eY6GSh7/R7zI27swSZIk1rMElHjxUDa8XQ18+YWkBIQBfO59kSKqjZV+AxotKhF
	hepDgtQ0P//5thE1z8C2ZI9VSEDnAoNe7b54Tmrakbd+41grqaPqwlyZhK5QZX+w
	PEp8HJE6hGQmALSfVCBLN1tBdpbVS9JKjIJJilGAL3fx40y2bXGFpOwHV/pjJ7k0
	NBC3OUb+35U8358r+U8bImq06aVs2hBekzAJU708IzpL0tFEpdJacKFJhRV0rvVE
	oNrDhKKFjhIWVFHENMp29F39SRYqkRzVyGzcCc/t4Q==
X-ME-Sender: <xms:skn1Zsdu6C3Ljdf4TyvvkXNGYFhLPcK0KXGRsFNdL0FTnBb7Wp6n4Q>
    <xme:skn1ZuMQ6Fi7TsstDzn8BsCuhymyuLBL3eu5RqOKNTspTXcsdC-UxjYcC14YVv7sz
    HOjnCVR-0U6xucVFw>
X-ME-Received: <xmr:skn1Zth6n7yZ59IzWYghMdRaEEFpeqnWkUEicW-fihE-8VRbyJNxFY75onZCBfL__2vixMVfqbWuYjzlJO9mJ7sm631EpSnvhEQtmAVSbND_Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:skn1Zh_KSGx1ecGpGkEHDMOl9sn4kJtfdulPgrMkoO9EkNPBh16B7A>
    <xmx:skn1ZoutbfMABLXf6p9Wu24o3LPbRgHo4fXImtiVl3XCEq_H0Ge46w>
    <xmx:skn1ZoFiqDaDiAU8MHgGlDcknOdTxHC0MFqM4OP_e7nnMyzEtr0xmQ>
    <xmx:skn1ZnNou61DsjxXgE6QW0_zsc-aWQkKTk4Qm-gVJMTj33ImBX15ew>
    <xmx:skn1ZkI3MOIp_tuQq1pn1Sq6_SNKY-pU9Wl84Nfh3ocvHpRZ6lZ5tIHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f33725c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:19 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/23] grep: fix leaking grep pattern
Message-ID: <3d1cece660a622a2b4f7a068cdb4eeb5ac6f8a61.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

When creating a pattern via `create_grep_pat()` we allocate the pattern
member of the structure regardless of the token type. But later, when we
try to free the structure, we free the pattern member conditionally on
the token type and thus leak memory.

Plug this leak. The leak is exposed by t7814, but plugging it alone does
not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index e5761426e4..701e58de04 100644
--- a/grep.c
+++ b/grep.c
@@ -843,11 +843,11 @@ static void free_grep_pat(struct grep_pat *pattern)
 				free_pcre2_pattern(p);
 			else
 				regfree(&p->regexp);
-			free(p->pattern);
 			break;
 		default:
 			break;
 		}
+		free(p->pattern);
 		free(p);
 	}
 }
-- 
2.46.2.852.g229c0bf0e5.dirty

