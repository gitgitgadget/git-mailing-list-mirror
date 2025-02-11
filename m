Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D7191
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233156; cv=none; b=WlZm9NKCNr3J9ZThPQRLFEdY1c4ASZyZT0uiy9X/dYzn2iW3yDuddL5gMAOiw0vCaevDeY3b5oHd/7y5Q4LyKJNzSzc1w0fpFm9JFFdVBmPfW4AmJMnxHWYnp3qduJb2EA2P5n+UEycfG8Uqrgp431dNZzDe1MaYlkEVuYMJM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233156; c=relaxed/simple;
	bh=hcYgvDscCVnPWUT84/Y5Tfabgwt81V+F4ROiAGN7Drc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ij1q/7flFAPbourHOt9G171T4L8lLs2xL2mGysWPc6S9Xx0bNwiVgxsRO2I4/ho3LubTCvVMC5A7NfjIgMBC+4fhSJPkXmpUMi1zuaVpYs0MGMn1SgIpUvdFwVoQwA53xkO+O35Xsvb+SKFDocOEYUqZiEB61MiTkh6VgDj4gZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=REBcT1St; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAeq8Amg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="REBcT1St";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAeq8Amg"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C9A2114013A;
	Mon, 10 Feb 2025 19:19:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 19:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739233153; x=1739319553; bh=zmbBCoT8oY
	Y++RN4aCQ7RblSCdmqYVzhqA49IAFbJHg=; b=REBcT1StZOHU7djAV8rvEbsiW5
	QLO9PO8At8tvSTyhI9z9fYHd7ZVlF+UItN39inB03mdDjryjRDLCxQp3BiTpVYq0
	vxB1dQh1epvNidBoKyhs1ctwIbD38BdhathlIjknCIDQAIpi5jQOrfRZaUkK9Es+
	0QXmCEPBs6W3ykFN51aO0k8lPB5Yb8DnUUZnWJZH0Nlhqq/oxgH3S1hswOQsfu+U
	ci2RWWd+vGYj8/60qsRkaUeXV2D4xP8RboYwy//frBzv90EmXiLRa9cHeOax1CF3
	08w+d1jh9SeP77OXboR/4BvAHwFSx+BdKBhue68CAv4K/JZMNK7+gXoww7QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739233153; x=1739319553; bh=zmbBCoT8oYY++RN4aCQ7RblSCdmqYVzhqA4
	9IAFbJHg=; b=rAeq8Amg2vH+yugGA6Y32xgR86EsiZkAwFSlA2zw9jarJA+u8gD
	8yzNMoMKF4Lp3tS3J1nuikYQV68fatOikY3GeiRJp0tV45XPl7ZPpIF9yxEw98OH
	LmsRfjLCV4IAisWCm8PYzCufKDIAH/Uw1r3V2FWkXJecIe2A9x5AqnaEmiAtPNVF
	CU6hAWeQtTE7uGlKAL+CjLszrBXrwv5nYsiSWuPWBKMGWKtw8wh7UPFlo7D2roMv
	DyVVMcrDjBn44gYr6+c4YpKHPb1V+wTPm1PW+rEqs2GQkLFSRQ8Lz2kFtKI0JBZr
	E44kbRQ5PVCvje7iWQO9z2QmV7Doay2nZCw==
X-ME-Sender: <xms:gJeqZ9TOoo3eV6j00oSk2_dtEAaiT33TwMsFMCd80QtcCq1ZBh9hpA>
    <xme:gJeqZ2ykil9A7ysrmNPtmbpLyo35Q4UTvg2Q_gsZyEvXkMyFWeFpWcPsKoQaaXC58
    ZXyY8V-UevfjnPcSQ>
X-ME-Received: <xmr:gJeqZy1isXCYm1QPXkPar7konclEEXlmiqRuCSRD0le78LYj8xfDZPqZvdPNUoHCHuhHYKZPkjglRAo-3nh1uOwNmlG55TCILYxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gZeqZ1CnGiaAs2FWOQS22uKsrDYWWnKbjxuSCfIgh7hEisu6JYdgcg>
    <xmx:gZeqZ2jhrgUu3r_ANMv-ng-zLCsOtWjLB_Dta_yj_4Yg2lq3ScjC7w>
    <xmx:gZeqZ5oFwAY1dxIsVBlFXbFqSFcMd_bygj3jln174iW0zkV8egGAPA>
    <xmx:gZeqZxhQYI2XtWPEPW-MCKkibvLSHfgXbQwIs84NiHWt9P-vpf8WvQ>
    <xmx:gZeqZ-fJktvfLznmgaJBjSfGKfXBfGvU_hKcEi7LZ2tZkjU9uo1hdkjn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 19:19:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] thunderbird-patch-inline: avoid bashism
In-Reply-To: <20250210234947.1317056-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 10 Feb 2025 23:49:47 +0000")
References: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
	<20250210234947.1317056-1-sandals@crustytoothpaste.net>
Date: Mon, 10 Feb 2025 16:19:11 -0800
Message-ID: <xmqqa5at9vuo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'll note that I could have just written '%s\n' here, but I think this
> is a little easier to reason about, so I didn't.

Yes, I actually was wondering why you didn't, as I find the "short
format string makes the command iterate over its arguments" easier
to understand, than how you wrote it.  Either is fine, but that
would also have been shorter.

> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
> index 1053872eea..fdcc948352 100755
> --- a/contrib/thunderbird-patch-inline/appp.sh
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -31,7 +31,7 @@ BODY=$(sed -e "1,/${SEP}/d" $1)
>  CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
>  DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
>  
> -CCS=$(echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
> +CCS=$(printf '%s\n%s\n' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>  	-e 's/^Signed-off-by: \(.*\)/\1,/gp')
>  
>  echo "$SUBJECT" > $1
