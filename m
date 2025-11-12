Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF402E973F
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984986; cv=none; b=Fd/QMWl6NyZo8ln43WvOjFbZQ01fYYzKtuSF/Sw8Tekb0wE3kjGRzZ8rL82HfNGaoqFzH0gHUQMeK+gDx3wue17ZdeULOWwLevtamtEksRQ9Nb4RB+wCNy5soGgdkuMmJr5FkaGB7/z3paie2WXYd5tJm57OP33FoL+XVg2cNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984986; c=relaxed/simple;
	bh=WCrANLAktrYAVNOIrnnSTGNLhoMnrHk/7ZTLQAHenr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCdh7C4gvCp8fMXTnLHIdGo6BxDS0B0eMP7hsSPv1+IwJMKmnVlNQ4yppVVoHggl6+BBK7+0urhQGDxjnzh8WvoBs1mvZth7T18iMJKXmxUGR3CiSjX3h6LqEO+sMULsvAwvwIUTzr2JO/K/BMae3UF0vzYmyNACCw4t80uL00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N2LN6Itl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpncR3zS; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N2LN6Itl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpncR3zS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECFC47A00BC;
	Wed, 12 Nov 2025 17:03:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 12 Nov 2025 17:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984983; x=
	1763071383; bh=s19esdMn7yS5nb7hKnMy5TRxJ0BIwiihExL5XGLUwuw=; b=N
	2LN6ItlNnTewD7okZcNyRqF2oxJmPTWwp3sbvtOGKab9V527bHQdejgCUn+2RZOR
	bcazJXCqMnZSaL4RQnbJ6aaJ69wxP4da1QiTi3gIl4W1iQuMJ+Ithe1UiIj1psHy
	4IpY6q2CiPouSeeZO4qgvE2L7ddkliTGjPy/IT2C5u96QLN3xvWYo04fAaPH2zJ7
	sH+hjSvTmYOCCHrzxgG1vne5fm3TWJc+9tcu4en/nc7iVa0F6SYG2t0sW4UMl4ko
	rV6/6cI3Mss/iCJTg9Nnq/C0g1XpTcp1GyZJtkBbB75IcX6k+M/ubbsxfPkLQrln
	0V9/+g/BHrn7ZmyZVdHNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984983; x=1763071383; bh=s19esdMn7yS5nb7hKnMy5TRxJ0BI
	wiihExL5XGLUwuw=; b=NpncR3zSzRn1oVfGQi8o3++C0QG7gwCuDkjt+5RLdOtB
	SGMKC/Nic+cVp345l9BwrSxh7gaJI039yw0V0FAF+v5uD+G3VcyNC+wz/GZ5JVKi
	UoEbOY3u0D9LS3zwREpiNAIzBPiOQS6RT0iqhbNH3OrFNKNQ5F5dn4LFCAKu7bnQ
	OEj6c/9dW8DcXNQuP5doQ9ZfQCsLNLp1DKXRk7O7gJ/flC0UmuU/1FM0aAZrKfNl
	EBoRRg2Gh+8v+Y4fQ+5M3xTiGkf+XhD4FqVDP7AUsZSXM40Y8iUFLvdqzARGHiTT
	lJuuRq3Y2+fFCgwhlA02r3RcaDur32qVUiNo94iBFA==
X-ME-Sender: <xms:FwQVaeHhZuK2X9nsYUNBOnl9vIbA96Op7MeE1tsvnyajYPOyXB2YDA>
    <xme:FwQVaVXyvQaNnLTrLGw2qwiJosMcXyatmqqJaJpZ7n4cmVsOe6LGXta3Dm5x2rZD1
    yfI8N9RR4JWZ8HKzEQvNOAY1nl3ZsDsBBY_968sV62Y4bls-jHPNg>
X-ME-Received: <xmr:FwQVaVyCPdcDb6fgej6FOLYPDiu4VciXjBgYlWkPoyBOPXaqMr_Bahkz4_izkaCmF92lH1eEUe5soQiW-xdHK9HV_3JcCwOo9dyr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:FwQVaTNy-QSUO-BbYUiIzm9T17zExv5SDs-IIPo1WICW7J-rRCGmlQ>
    <xmx:FwQVaW7vmaVPFSjW0Mw7707Ea2XjWr4FnpVggw2sh06OxnFOz3cY9g>
    <xmx:FwQVaUOxp4r3r9F-B_ZkddOSzGR6JmKSGHvTAK9UNMXhfm2_n17tbA>
    <xmx:FwQVaUleARIoqJamEGhsMPzPy17t9IT7pSu-uJ23ydwW7MF6y9AXjA>
    <xmx:FwQVaZd0H20uQhn1Wx8lRxqfdE20ohptIP4tLN0-ql0VAIoNbC7mnKz8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 02/12] diff: emit_line_ws_markup() if/else style fix
Date: Wed, 12 Nov 2025 14:02:48 -0800
Message-ID: <20251112220258.1009253-3-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply the simple rule: if you need {} in one arm of the if/else
if/else... cascade, have {} in all of them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 74261b332a..9a24a0791c 100644
--- a/diff.c
+++ b/diff.c
@@ -1327,14 +1327,14 @@ static void emit_line_ws_markup(struct diff_options *o,
 			ws = NULL;
 	}
 
-	if (!ws && !set_sign)
+	if (!ws && !set_sign) {
 		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
-	else if (!ws) {
+	} else if (!ws) {
 		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
-	} else if (blank_at_eof)
+	} else if (blank_at_eof) {
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
-	else {
+	} else {
 		/* Emit just the prefix, then the rest. */
 		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
 			    sign, "", 0);
-- 
2.52.0-rc2-441-g030905368a

