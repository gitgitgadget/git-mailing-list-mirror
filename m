Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4A229B15
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742618; cv=none; b=SmFRT4DL3d/wiQ+pfr5umQs98GMg49VIcNikHBBUNQ7eBjKs6mk+hAscQ2IcCXVo59yy7F+X6MIixPqWeCXweLpR3nAy3ZjMLuGiqs3GPUGPs5JB9W7AzKW6Mn915Vm3vBSwhn5AZ/YgL+foJLyCji4zhjXHPx19JUNhsb6Eyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742618; c=relaxed/simple;
	bh=9QI7NdvwFIxqf9tzvSwyQH6e5sg16LUeq0XhBZYXFVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXzEKXAW9SHqGFjxQNBIjGYw8oWh0w0Fu5TzTt/eu3R22/KlUwKvIqpbipP9/LXf2gqCmCdzqh/1jz0HdQLz7MyGnivhEZ1rDu0tF8R+q4fQ0pnJeb+HL08wvVWTIKv6LNYxjZuioF1SFxPXEyqp3AS1crF2y/IFsGhywsqmtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BHxmCK3Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nv2oIv/U; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BHxmCK3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nv2oIv/U"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C55061140141;
	Wed,  5 Feb 2025 03:03:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 03:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738742615; x=1738829015; bh=zbCwrrT4cA
	Bi7A35kqeyHk+pm+1jjcUE8QANZG8DIDQ=; b=BHxmCK3QYZE11OPJ75jgjWNjXk
	At/MVlZhFzV123CNwe5uGA1w1A24iXCCPt0wGIYBLAoI85W75rHG7x8aLKFgIr1U
	89qRI4P/NMsW0nOIHGrbYHCzppOt8poduFIT0cXDzPZt0dHKySV1CbGnjJQV5w8t
	FzaWCQOmrSWsyDqUyIG3Yd5Z672yO8JcLg2FIC7qihHtY/dGNIwuHJFcO6/8UPjR
	f8u/dbYVsZU0vGWkR4G2oi35GWQgYIKbXYzsWwVdpp8P2RKIQ/uwSCvgUiiSNgkY
	vigDptGc3VSkt+EUyXumieGerdqX/AY5i5VDuF7f2mMolY7Tlaxee5gpCXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738742615; x=1738829015; bh=zbCwrrT4cABi7A35kqeyHk+pm+1jjcUE8QA
	NZG8DIDQ=; b=Nv2oIv/UGYCKxPAjmKszggvnbH69QAf8MD9LgpY5WwiVHo+MyzS
	/dwD+XlCn7gAHN1nDRXgdHldLMW8+ACpyU3jDwrJlou732PXiUFzv4vmz0JaRnCz
	d7UyYsc6NJ0ZDxahCdYxi0OgcV+VaI5FDrm1n3l6elqgjqtM3LTMEuTF5bhjXKOJ
	sVXipyU+81N4n1rvSk4gHpewlrlIJCQIlsF4XLpsqhMmOd65Lv+IwVkPjbt9DCHy
	JPupkecSR6k4sSJtGZG21zQvc9EwcrOWpkGL4DTtvinyeHOCKhK2niqAJqRqF3dH
	7n+5GH34PeSFLiOMSMlmxUTUwteTI6l4wVw==
X-ME-Sender: <xms:VxujZ05_GhCP3FYT0uNMV6VZ-N-UagIGpbLfHETlu-7sk2MtfTTBFw>
    <xme:VxujZ15khvFVAANCxxlZlWEc9E0OIzneVvkCXxBJkNGQ66cp1XSrtbIwbQxdkRDRy
    6j9qBgBadkiRibXDw>
X-ME-Received: <xmr:VxujZzeIbZaPQzGS4ggi6rtuMBfTvG1BWeSgWC4qpY4umW6U_k_lZib-mc8nMFJk-ydL4i2S1pE2aZN-GImYIOMHlEIG4bo0IWG5OHe_iOLxtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhhsuhgthhgrnhgv
    khesshhushgvrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:VxujZ5LVm_6MeV5dExw7AEeQp1vGxFgvpSnxhx9aeOGWbS9t9BwG3A>
    <xmx:VxujZ4LfFiWt1l6hhgAXl1BGaHxOTZGuSjP65UjegohvffbIKbvX-Q>
    <xmx:VxujZ6ySSqCEnaYCyXtAaxrOcM-i5Fh7sQywdqXumOGOPQPZlfQ_pg>
    <xmx:VxujZ8KMtBDXrZXZM-gyZO5EYXj69O-vMr2QgeBOZio0cSbHqg8QqQ>
    <xmx:VxujZw9UfuYNGkK_oSVmDxrBsDX_5ddX-u8YCQGtkjqvPkR3hSjMf2Od>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 03:03:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a8d9f169 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 08:03:33 +0000 (UTC)
Date: Wed, 5 Feb 2025 09:03:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/7] parse-options: introduce
 die_for_incompatible_opt2()
Message-ID: <Z6MbVAwn15_h8Sxy@pks.im>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
 <20250204-toon-clone-refs-v5-6-37e34af283c8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-toon-clone-refs-v5-6-37e34af283c8@iotcl.com>

On Tue, Feb 04, 2025 at 10:34:05PM +0100, Toon Claes wrote:
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 1afc6d1ee0cb738fa7fa3f2b5c8ce0dd7802e7da..03d93afd77290ab556565f05bd424956b66ff01c 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -164,7 +164,8 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
>  	if (!rinfo.positive_refexprs)
>  		die(_("need some commits to replay"));
>  	if (onto_name && *advance_name)
> -		die(_("--onto and --advance are incompatible"));
> +		die_for_incompatible_opt2(!!onto_name, "--onto",
> +					  !!*advance_name, "--advance");

The condition isn't needed anymore, is it? As far as I know,
`die_for_incompatible_opt*()` handle the condition internally.

Patrick
