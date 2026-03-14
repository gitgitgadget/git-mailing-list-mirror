Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391377082D
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524223; cv=none; b=T5heKSF5LPrOHbTG10ugBiMBNpwIS4TvS83wGtAdoIETuUdYkDkOgbtfHUXlN2RTCabGFSBJ1fwaWLk6vDmdt8YcyGG44pFbXx2mTFOGwHCNMuXPVufeHpI2uI+FG1qJUIM3drKYUZiOaYuvZS+djuHasND9lzCMSslPLi9cyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524223; c=relaxed/simple;
	bh=NDTVpXyg70fjDPTbKCiXYt+1QB8rBJCAm7bcfAfifNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=g0/ZSdu6coIbYZvqRdrUVLzUqsNQo0q7Iqp9itEm6mMDCzMwQEEPnoxwWdiiT0nrem5G9ILbtXNuqh6uDB5Pha6U8Yj9YQLbrtOo2wLYn8nQnAS/SiRq4vh9nua4lhzvLekFZXpPAHuv6FMJfO36F0w8b/0LtaALQ0Yhw+EYte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=NuEpR4Fj; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="NuEpR4Fj"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1w1WfC-006rFa-LP; Sat, 14 Mar 2026 22:36:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
	References:To:Subject:MIME-Version:Date:Message-ID;
	bh=VZNPJOAuJr2l+jPON+RmTbxGfxXdvuj0sYbbr4e2MIc=; b=NuEpR4FjNd8iEl+2STYbyqbETW
	ABixSYKufYPBahinQZ8GTkqNN6eKtijUoC8fCvZYbeFdexWhh3QYwCtrFDGWJGQPVKOmBOPlAqT8O
	1cZXz8VfWs5co47cmQ/m7JZ02qKOkJA4NDR2W0ddsyOh4srMnmlgMKtI2oKlNOjkOWnpnlpH+HBG/
	PVUThDgN4iAd1RRsdq4YLQhLKhN3/fB8bSBKFlYGymWRfRQhy5X0euHRmatIBH6k65ij5Gi8GYCpI
	grBKg1sdbA1xKagWC8uK0GNZvi6Y+zYa9UfdgaXbR2iMbaTy7xh+xGMf7wb3JlNRMguofcmcaMrGA
	XP9aI+GA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1w1Wf7-0003Ci-4e; Sat, 14 Mar 2026 22:36:45 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1w1Wes-004KRu-6E; Sat, 14 Mar 2026 22:36:30 +0100
Message-ID: <454235b2-139f-40bd-a4ac-fb7664962471@howdoi.land>
Date: Sat, 14 Mar 2026 16:36:27 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug report: mutual recursion in the git-subtree shell script
To: Arun Sharma <arun@sharma-home.net>
References: <CAN7rbOve-EFOGPjr1wrD77r-3RQ+3+qso82_oV5Qud-skobL7w@mail.gmail.com>
 <YEzwOqgFcva4fmoV@camp.crustytoothpaste.net>
 <CAN7rbOuOaHY553KX1Qcr_XWGG6DFo1yUjdYVu5mn=HYPmOj6vQ@mail.gmail.com>
Content-Language: en-US
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <CAN7rbOuOaHY553KX1Qcr_XWGG6DFo1yUjdYVu5mn=HYPmOj6vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Arun,

I found your git-subtree bug report from several years ago.

On 3/13/21 10:06, Arun Sharma wrote:

> So I'm trying to split out a directory from postgres source code
> (which has 52k commits).
> 
> $ git subtree push --prefix=src/interfaces/libpq libpq master
> /usr/lib/git-core/git-subtree: 647: Maximum function recursion depth
> (1000) reached

On 3/14/21 12:31, Arun Sharma wrote:

> I was using ubuntu 20.04.
> 
> $ git --version
> git version 2.25.1
> 
> $ bash --version
> GNU bash, version 5.0.16(1)-release (x86_64-pc-linux-gnu)
> 
> To repro, you can try to split a week old version of:
> 
> https://github.com/postgres/postgres (subtree: src/interfaces/libpq)

Is this issue still relevant to you?

I have prepared a patch series that I hope will correct this problem. If 
you have the time, can you please test and review:

<https://lore.kernel.org/git/20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land/>

Code reviews are eagerly solicited.

Colin

