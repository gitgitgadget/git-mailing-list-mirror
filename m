Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F07285050
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218455; cv=none; b=mJF32RiLpThtTdA8HF78zO/aj9NilDwM97mXyOwJXTACoV/vDjY+r3Nr7v3p2tz4qfpdxseUKivTukqYEn8SteEnxjakPgKkjrOBflWjntZcpklv3rRMmCX2nrFu7ZIxktdYP7qI+qhdjhVsi3ARytmS86UidcsmSknSs4YhmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218455; c=relaxed/simple;
	bh=NQTXcGIFBBzxt+6J3axbCmBjDxJU4OQFI/cYd8qc3pw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TJnQpzv79PJNxZ/kKODSGKc7S/RqmewUsLnZpk9QhBj6vzd9RvScoSveoD2BHmjwcQUbra6aDeYuK+yEWYBsyQk4HPZupSRyX0bX7DVPLeIJEsdSeWM7V45xSLiCWUJ+QDIVrZQpi896GjZA8FR80rvt910VZMPnwu+NHjD7zxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LSuC0suz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JSBH/If9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LSuC0suz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JSBH/If9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B4D8FEC0579;
	Mon,  8 Dec 2025 13:27:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 13:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1765218453; x=1765304853; bh=FBy4gOUwRn
	OMO96uP4jKq41qg7V8yp3zq/Fr1ztWH0o=; b=LSuC0suzYM3XQoM6bDSRzi4s4D
	x6176Ma96uVryOJ3X8P7D4jjWSDNNOakZyOiIlWaHEX5h37MOPAQGI5VpB6AfrxY
	nF01e4mOesjffNcsPovKsd525AdO4nShvigLBRu4Q1cQBSAHlpH0P3dq7WfMwwVJ
	IJICo/wrmQGk71DcM+kqFVtM+hJDPCvyQOsaznhxZ+xe/DwGF8KR9+8c2fuq0jvl
	5tS/zDlU8Uye54NiXVitY1UFSR18mPIE9p2oaZnPJH4X2OOb+DxQuEaItvw88/4q
	WBYjiY6AMRe6hm3dO36wYyX5fyhukFulLYCSSYwguQXi7qj/9/9dPZNPq28Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765218453; x=1765304853; bh=FBy4gOUwRnOMO96uP4jKq41qg7V8
	yp3zq/Fr1ztWH0o=; b=JSBH/If9HXylhfusAqCTJRr4yWFB+WNa5cWAInuunuzU
	IA7IqZNUj0cTJ+ZOoyUp6M7UCVFfunVHUL2Sxe3mp9219uIQ/ESFflH/XYqlm5r+
	VNvQENGJIJlA2XKPm3cyIwR01vovNLssRlzKFxntbQMpPTKASCFJtwDAbnx2INbz
	nroiXKhq5LAllNvMxZM2wszIkQqFMN6HKYMAjNqvQSRN1c1JwfcIN2Szv/IvLIvL
	OQc7tXkt7y0ROEsp4k33pHeBxg2zySNF08ahG5pGwUxJ3MoD9FSuQMxE69GZokNf
	03jI9TLktWsIeUy4U2oa+cghEPHfLCSyzbCYrHwIAA==
X-ME-Sender: <xms:lRg3aUxugBnEOlpl_EdR9J_NnthRe9J6xVYhG35coOwo9btHk1p84Q>
    <xme:lRg3afs1qYZCBEMD3kh1A6SnL1I6akpYzhfyBkH9iPGNSKxA3cfvo4WaB19q5zbk8
    jmVNEJyZkfNP_RnGJKZW83ZJW3RWKa9ag3hLWKalJKMUzE6cffHeQg>
X-ME-Received: <xmr:lRg3aTuGbf5T7DgPjwVHwGQ8ipZTHCBupzhCtYdZU9OyuJrC73RKoCyy7CdraQnQ4KlSfWXo9jFjxCiIzGi6UxAeKp-SzHkpRG1ucSG_kw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:lRg3acOsaYyOOJiBmhZxk58xsPaUTWk_rUGog4fsyGd2ln0k7rX1mA>
    <xmx:lRg3aZ08W4LBk57BvCjzbo2xah4aWfMYr1f5bLsiG7LU6pFQtX4sbw>
    <xmx:lRg3aQNem4rj_8bF4WHGjv6S_EXf19l8fmn9-ga7mtnPmn4r5lu-vQ>
    <xmx:lRg3aR3DNE049iqnou9PHIKwnEQhWk4Q68D7ju5Rjd9Iao4uvPCO_A>
    <xmx:lRg3afK1MnBs9oOxFDGHx1-1s09qIMkHEumxhXomdgbfF19NT1iiqPlZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:27:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24f1269b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:27:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/repack: avoid rewriting up-to-date MIDX
Date: Mon, 08 Dec 2025 19:27:13 +0100
Message-Id: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEYN2kC/x3MSwqAMAwA0atI1gbaivi5iriQGjUIbUlEBfHuF
 pdvMfOAkjAp9MUDQicrx5BhywL8NoWVkOdscMbV1pkW066oOycMMSYUuoQPwqqdm8VY33S+htw
 moYXv/zuM7/sB9fUWL2cAAAA=
X-Change-ID: 20251208-pks-skip-noop-rewrite-38d7f01c79c5
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces logic to avoid rewriting the
multi-pack index in case it's up-to-date already. This is especially
relevant in the context of geometric repacking, where we may decide to
not write any new packfiles, but we'd still rewrite the multi-pack
index.

This is a follow-up for the discussion that happened at [1].

Thanks!

Patrick

[1]: <20251025191550.GA279793@coredump.intra.peff.net>

---
Patrick Steinhardt (2):
      midx: fix `BUG()` when getting preferred pack without a reverse index
      builtin/repack: don't regenerate MIDX unless needed

 midx.c                      |  2 +-
 pack-revindex.h             |  3 +-
 repack-midx.c               | 90 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 55 +++++++++++++++++++++++++++
 t/t7703-repack-geometric.sh | 80 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+), 2 deletions(-)


---
base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
change-id: 20251208-pks-skip-noop-rewrite-38d7f01c79c5

