Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401726CE13
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781180; cv=none; b=OvyiaYV037Ck1WQ8zI/Vrufyapf7ybRlUpUNVcOCKfBtIEKvAdMjxp0oY8dfIOsgmr/1nLUX77HShVBI1DKDs6MIcq+kkI8ghQW5twOYl+K0Oxx0l3tul0at5GIUK0niEscqsVwyP9UBOgZcU0hBRtJlTy8x5ZSLSFe51LyZUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781180; c=relaxed/simple;
	bh=REfZqDK/VS2LIrHq/Y2wUJmkIa2nCI54I7Ep/URp01o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rAt0vs3fRO+UJ7F9xG2E96vw/on+keGdteZE3vUsz0ICU1us4cwlaU0YJtuoMrQzA2ro7zr9ey567kaeS0Q5v7fqlGiyXKISK+VGz8RLQNacltyAV6oqYVQof6PtCcIjhWb40eAgX8hPCI+WPPv4kvVsuxMCfuBh+DBYYPmIF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FyB/u8s4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iu8+1Vdk; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FyB/u8s4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iu8+1Vdk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DBF281D0016B;
	Tue, 24 Jun 2025 12:06:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 24 Jun 2025 12:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750781177; x=1750867577; bh=5My+LERUpd
	90CWz42MZRapPi2s6kvFLxBU0qIVJW3+Y=; b=FyB/u8s4SSqag2F6yWK/PsR2cG
	riRWwYoLiOkr4fZq1zElyISkVpbhvl+XaLKGToJKQ8d/BIgUt6jpQbnGSU8lAuM8
	5gpkWOYQnWOAzHcKIZCJa6sFtCRCffW7yEBvn7Rc/1bc1AdlSV6h+Fqm47x85pAf
	CDmesJUPFzEfZIhmGBLhroAdSVdNaAY+hwIEmfATMwydAWG5kz46xFbKhtwQACxE
	LLqH3vII7GHmvv5QuEYPiIJnVP3prybNXRPyC6qliePN+11JhL7ty//7AYQKxUK0
	Wp4ukn4q4poNf6btMXB03OrmU9acX7n7TYvyDrL3ycxZvSP/MmVb+374Wo6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750781177; x=1750867577; bh=5My+LERUpd90CWz42MZRapPi2s6kvFLxBU0
	qIVJW3+Y=; b=iu8+1VdkZx9ArxdUDyEWvd+AjhgmDCuo8i7BRpGsmxrZQshzDdQ
	UX3jK7bLek90oRZdtOWg1gq4v7OwK1FxVS56MdE7aj7grvNSgiOcL/Qxly39Ts32
	iYQjDHOfIcvFjEyaMBFCATTmF1FP15O2tWDMewBrlwPQxAlhXwjpn1ttNnRbcTMy
	x/Hg87QqG4bFLhkxlB1htUXlu+vXQzFXyWnF4Jp5wduOCpXDHQh/qiK1KfNFk3Ou
	Tv/kd+sPpxAjjzKd4Iiy8JjbDSJMj7y3D2Utw9Jl5n7BirLu6iI4LUejsmjxU7uv
	+pOlXynUM2Qq9ytIVsnF2Wd0ZdQC5WUAHpg==
X-ME-Sender: <xms:-cxaaIxzW9BOa9Y-2JyJ1vbrUBC426oaqlC5_nXKmI3BgUgPBNtsvA>
    <xme:-cxaaMQWxhWiShOT0Ai1w7y859m5VXHkmwQ7Bn1N6Np7LYFqfGwBKFv_awBac0kUo
    GqHjm3YivYwfoomNQ>
X-ME-Received: <xmr:-cxaaKUh3Cn41J_3lwqwXSJKq4EC5KhAwIS1uOdMP0cMYHBVgNHKRwMvihBedXbYcuVjIAHlmDPTKyZBIJAB2y32JBFo5HLNGQSa-og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrgigihhmsehguhhigihothhitgdrtghoohhppdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-cxaaGj98_fIS7qAG9HK8ctQVhOQijdBgoGchwqvzhquajt8xfZdcg>
    <xmx:-cxaaKAZstCkMOUx-olaZs-jOfrHTtuPMF1mwxpaDg8h6KWKgRdW8w>
    <xmx:-cxaaHJFQb-cSB8G6yxyrZbH9Baqt6ywUxDiEvRlBeB5y3SwgxWEkg>
    <xmx:-cxaaBCP5GZbH31Jf8Jbal0TFycYojNEtlnFJAz7B5XqHZPD-sAduQ>
    <xmx:-cxaaM41LBjsG-zv_1FJPLNlPkUZNKN106R-o5WOJQ_hFTy1h3k9LdLq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 12:06:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] contrib: better support symbolic port names in
 git-credential-netrc
In-Reply-To: <20250624014857.3748-4-maxim@guixotic.coop> (Maxim Cournoyer's
	message of "Tue, 24 Jun 2025 10:48:57 +0900")
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<20250624014857.3748-4-maxim@guixotic.coop>
Date: Tue, 24 Jun 2025 09:06:16 -0700
Message-ID: <xmqqa55x15vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxim Cournoyer <maxim@guixotic.coop> writes:

> +	git send-email -1 --to=recipient@example.com \
> +                --smtp-server-port=bogus-symbolic-name \
> +		--smtp-server="$(pwd)/fake.sendmail"
> +'

There is a funny indent-with-spaces here.
