Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185D18B0A
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311655; cv=none; b=so9cM8o+S12WOTMnMxyFiyBr4y4BdTOEzLdhMoZJ0c9CHo3Pr/eulAPU1KwSvkPFiAGl/00C1p6USa23/VRt9JZX9ydiN/18E9DRM/63tBcJFQl85x+TNebB/7HZBE1EIHSRJVc+iLfaCSNC5EnhFzZn8iOxihrfXvuLwg6yCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311655; c=relaxed/simple;
	bh=sEfqLFs1pT/peoYTBTF+m9mHYzAZLFDPSHaeVtiHWpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZyGtmBW6amy6VGhJPAHm5+OFiezAp4d/25QWadD82JI2kR8K622TUUtix442BJSj7w4CgyPzQ1tmlf3ctsd9smNgTAAscEg5rkOYVDvl3M9OaK9pDKeTXjWjbQRRVDqMYwnnt2TFfjpz5Nlqu7PVdKMsdAhyLHMHchviFX+b54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FZmkH1AS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwiarFXR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FZmkH1AS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwiarFXR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CF4C1D00084;
	Tue, 13 Jan 2026 08:40:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 08:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768311653; x=1768398053; bh=is8b0EuGx6
	CZbxvdF/Nat610ApjRZLW0f7SCpW7AMHs=; b=FZmkH1AS+k0SOmRdrwqq+mR3sE
	TfpxLA2QE32cYTMenUBtv/i3WrkdCijOFdiL3YSbaEX0DOLcELENmS9qORQLtb2a
	O7AyT7tYQdO7e6c8LlfZ2DzUps0PMkQEVfebJnPnriR6rB2qk0LVXAqgau8M3c2u
	I19L1cuxGEoSU/IBmO5X8s0HKvlVQ7CiNGskf5b1FiuhcCuzazcnBE6DrIdrpwaw
	AD34o/xv9jgALwgVWXApRLKqF4y6FIqvNwvrAwgj8c5hEx09UimUs6vixiAMLFfL
	gnds3jhIapr7rFUdmhgmPdKa5BP/DBxr1cSDa5BjlYvIq/UGJngr+9dcpJRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768311653; x=1768398053; bh=is8b0EuGx6CZbxvdF/Nat610ApjRZLW0f7S
	CpW7AMHs=; b=gwiarFXRDgIbK2YSV71CIHacghCTxVLPQKqS/BK8DLU9Jpmcokw
	nvQgwn4Boo8xF9uBRRJ9ccEZXIp8AkEcw5e94wFnRCqQnlhtRFj6RGzGNn1eDK65
	xZNup+30BppoeEsFrKwRK9DMnL5gep9Ol5i2fFLHZunOeFFA9O3pfmQuoQrHYPjt
	YMxdzdKWHdmujvjt/3RVA+j7TPCWP7e/SOC1H5Vd/HSNyfbcygLNsFAjTabRM73x
	ZuoQOLZmr8aGOb/Rq5ps9T8WAzgTUE5+m0z6qeR9vlz29W8N4bHNMHVGFBGK6fVS
	PSpJIzQhBMR5UmOi6yxj1osy28SKVRydsTw==
X-ME-Sender: <xms:ZUtmaWT5c-SDYYxN9upDzzksjwMKHuNYbCm6Rmlcchi2GP30jziclA>
    <xme:ZUtmaSzIz3pD1Mwq__lu8W65PuLSCaR2f5_uq8hmSBm2jfpXEVPZ-xLcSLN2KbCN0
    VXS-R6DGEFR-SUVIvBk5qYkN2cg3yEDK476qDWzl8OKw9PzdD_LMw>
X-ME-Received: <xmr:ZUtmaY3QyRZW6v9fo-xzxUjiJkuCAzZZySt4ymBMaZ0zKris61Kd4478VQEgTsD_FODRvCFE1xMiWfplBgXe-ZwC28xLFFWjN7rt8B0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZUtmaQ6IaGbBUqR0JlskZeXkG4pXtZaQQfSb9T1AeppTuWNAnKGz4A>
    <xmx:ZUtmabW358IlmdKYApPzqKNEA7B2IM_-2m_eMI97siW6X5p3ifINwQ>
    <xmx:ZUtmafAjKMubN2pgK1e-8uXFgcAprV-2kJzvSNhM6xsg-RfJ0mEH0Q>
    <xmx:ZUtmaa4AjFm8rIMsmUMk8bPXMF0KoDVOGa3TIlyUPqzWv5fK5O5vBg>
    <xmx:ZUtmaVgT39DIYtPlTxrPiMns5UJXF2pexctKEbbtxHFJvjKf_kbmsx_D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 08:40:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.i
Subject: Re: [RFC PATCH] t5500-fetch-pack.sh: fix suppression of Git exit
 code in tests
In-Reply-To: <20260113100145.436591-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 13 Jan 2026 15:23:55 +0530")
References: <xmqqpl7fnetj.fsf@gitster.g>
	<20260113100145.436591-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 13 Jan 2026 05:40:51 -0800
Message-ID: <xmqqbjixljfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> I think a much better approach, is to use test-tool pkt-line pack,
> which I believe handles the formatting issues internally,

And more importantly, that is a tool specifically designed for this
kind of thing.  Very nicely spotted indeed.

