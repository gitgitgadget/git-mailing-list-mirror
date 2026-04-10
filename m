Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337B3E123C
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844654; cv=none; b=lT4O2AZgbXhpyOzOs/qhAjcJ26Z/iqGPPZlJgyu+tq7WYVWBUm2WKvi1EjECBrB8indEA3Q9A8eJX3XrkDiZU00Zd0rdm4iYc6kYeWw9E4FM+PR0BJlRRvdLrBy/j29urPhNBh67rC7h2cD3Il+mN7v5dr10eOF7OJQNatkz8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844654; c=relaxed/simple;
	bh=UxFrID2WlgWEvWYJSu19EEElBEWdGOf/rGjHl6Kza6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GH13Wa8oCQuYCBYBXpzxtVsRLnAI21G2fRD3YVClcxT6LKyZXUFHeIQEHJLoqy7/KHobBItvMPwJVlfJZ1+oDkoR5yfn4X0ddclyCbrNSeU+LuseVuIynzNbjsgtNY9NaqJpTTabVlRFN56UaLXexrKh+AQ3UZ6ntYBFuO33gnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KFEzu56Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DXGZzHex; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KFEzu56Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DXGZzHex"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F23917A006C;
	Fri, 10 Apr 2026 14:10:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 10 Apr 2026 14:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775844650; x=1775931050; bh=uiou12cAoK
	0jH0w0RV1i0UY/LpLIeIYz5jhCKLTXUGk=; b=KFEzu56Yc1WKXbrZJPDBvK81cr
	9jfjStlCxOt3+PjXhTKVDA0c7H6+KInrkvMttyNdvhbW8Se7udbeRDaKIfX3sDIS
	IeZWuvnqqZyqeNKGZlKoEcb/IN721Z9NNVZoxfW++H1zzn9UDGjdH+Fadwdmcnm8
	Xvv6XDZAwh23Cmh5dhSEuLk+HjxvR8AOOIirfQ5SZ6Enj5rE6gNb5HGjwbVX7967
	ECH9jszYyer96h1SWuuMzDdXZqVweP7OFFcaW/U9a2D/mbsgT3+YMMqwQsLuHgzQ
	kovvWz0reT9UGPAPmFTDPSYzQG1EArqvm2qGVAPe7tumnri/4z2PaudSBlng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775844650; x=1775931050; bh=uiou12cAoK0jH0w0RV1i0UY/LpLIeIYz5jh
	CKLTXUGk=; b=DXGZzHexebk0rNzpLBu3qAvWkZvoJ0pfQagHFM1QPbnMxBLCUll
	+jLkKPzSwDmIu8F0Ajrvz/LyDxwBeiu7hdQvkSkh8dYSudsIVVJPVs72yKkjEyzU
	FHX+/+5WzrDJhUlPoHomsa4qN0c3l1ZEYQ7HeESU7wpKkuqVSezqegqbNa2KqY9v
	DvMknwx2BJv2j2pEQdPalLg7pc+HqaViVGZOF7jjrpkh0eFasi+2Z/dRQf1yaj4G
	rtA6kqcS8spieG+s+/1yCXtoP4MZeBKz61bE+2r/gFxzysLMGVPkRwUUqsKVCuCp
	RFdM0ggHmFtWI2+TeXaYMZmhdT7AkggAZBg==
X-ME-Sender: <xms:Kj3Zafp1nF34DdVJnAsyEIzONc5qU2SHO7IY_akaMKG3lG8iIBZGtw>
    <xme:Kj3ZacO3yC7u8F7iB_APokovxXwxlO1P1YMK-mpUdi45pinC63gImL-XERvN9YpAb
    OhNrbVwMF53fPZbQ8PV4H36cji9U95G2C9Z7UwcU_k1VO3OKSYHxw>
X-ME-Received: <xmr:Kj3Zaf1EcUkXIdHGFcnGhoSB_s9SOV3EiW0hb-Tmb8DKz9sX_znKaqrMsPlWwOnB6c8VB-DdF99RY8DnYv1bUumyAms-5Q-zFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghv
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Kj3ZaTBj_hV5jC541mnk5FmbCfEE3P3ilLjaRqz2-lgfsgDK1I062g>
    <xmx:Kj3ZaUKLLXw0IlqjZcDuqUYu2sLG4VGqOdDKU1D1aVlzZuw7MiKd0Q>
    <xmx:Kj3ZaUlN-3g9CrCRkWtt7kqzAKqEzOoGHxmI3-UKarNa3_v3RR3jcA>
    <xmx:Kj3ZaVZ6wqAkAtf2PGCrOdbV-w8SeXudVaD9bGawrTfIErjTKQcu9g>
    <xmx:Kj3Zac84of7PHDbU1-zFcBRrs53Dp6ny08Gm_-5DFpBK7li_xD3u4ZmF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 14:10:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>,  Elijah Newren <newren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Tian Yuchen <cat@malon.dev>
Subject: [PATCH] CodingGuidelines: st_mtimespec vs st_mtim vs st_mtime
In-Reply-To: <xmqqo6jqpzxv.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	10 Apr 2026 09:01:16 -0700")
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
	<34c4e793113f22c393a6196d6e99a96d78cc3ab9.1775832056.git.lorenzo.pegorari2002@gmail.com>
	<xmqqo6jqpzxv.fsf@gitster.g>
Date: Fri, 10 Apr 2026 11:10:48 -0700
Message-ID: <xmqqzf3aofdj.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Most unfortunately macOS does not support st_[amc]tim for timestamps
down to nanosecond resolution as POSIX systems.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 4992e52093..4e54139fd7 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -693,6 +693,12 @@ For C programs:
          char *dogs[] = ...;
          walk_all_dogs(dogs);
 
+ - For file timestamps, do not use "st_mtim" (and other timestamp
+   members in "struct stat") unconditionally; not everybody is POSIX
+   (grep for USE_ST_TIMESPEC).  If you only need timestamp in whole
+   second resolution, "st_mtime" should work fine everywhere.
+
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
