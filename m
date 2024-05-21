Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363C14A0A9
	for <git@vger.kernel.org>; Tue, 21 May 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326068; cv=none; b=N6nZbmDTcSzfEnBvU49+rEr2JI3lvh4alzPBEGFk6zUoCgIKotPh9+fghZEZatR46GypQ7NRxEOcZeia+J/vIlOh/gqRKBCwgkfZ9bchH61oKW3kBYOTj9TrkkaRjrD/9mtwULVmAl07e0itT0Edxf8Ebn5mLkicEUcelbZ8uP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326068; c=relaxed/simple;
	bh=ve4IW4QGf/2D7m+JZd/G4ruuv65uKWoVVAKaVPf6mS4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NsYln4Wyq/mC8cpXIpYuQJyKgdTbG49e7QOU4416d1MdQIRo3UCSvREwr5t5a+mkcXTIAl+2QHjGOMDUis8G2DUb6sSSEXtzkggRzolM4cywYifu99R/G/iW1qRJ6vAc98bLb58cvIceZsi2Kdp8dQjgHBqCvL8UTUi6haEXc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=UOEnTZer; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="UOEnTZer"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716326060; x=1716930860;
	i=johannes.schindelin@gmx.de;
	bh=ve4IW4QGf/2D7m+JZd/G4ruuv65uKWoVVAKaVPf6mS4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UOEnTZerF/1+QiIZjvfC9+JxbNlalUKRofbzm0cHfYrSYC4HuvQOtYEERe06w/Cy
	 icZPhDWLptY6wcqBdRBs6mJ3Ogq9jQ6uj0ipREFcQTL9l4DDOQls9jqXlsf+heh1B
	 mFwVi0n+AQ2ru2s0n1qKcczLQxOMC5DgfqXB3OVeqpp7sSDlX9F/FmifGDa6//iQ5
	 h3NS8RKoVCLOqgGqYQRxcG9fD5KNlL+/dGGGbZl8cWMNCKLag84zcgrQKy2y9ASMx
	 adeR2PbR9xcikK6i9lgipk9rf1iChAmxlRwOGBdfTbyLMQ8Rk87aeevkq95Sq5ias
	 1efl+Jg/QmVG702Dsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKKh-1sKIRW425R-00EgmL; Tue, 21
 May 2024 23:14:20 +0200
Date: Tue, 21 May 2024 23:14:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in 2.45.1
 and friends
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
Message-ID: <937e89c6-6161-42ba-670d-8f20ff90a7d0@gmx.de>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6HAhSZHyMbMWr9X6+7ksJG96d2BSWDBgswb2aWq07ga7gjCnORI
 wMdl4eRtMEV70wqWG3PEVnbHgM5KTTlAteLNwanB/3CPeoqiWFqhRz4Iv3Ih/KmoctW3DUi
 mofwY4M96V1NANg95c+kLRYQa4lbOEMDWsS2YI5Ba9hnz08rqYGuSqObjvuN9JOiujIEMCA
 jF0mokCEMOYp0iVSoCM2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QSlUyjCjGBw=;w/NYu8SegozbDX536elsiNlYgGT
 qZQX95+HVnxoMpEUtMi141XvhODJYz1pUrvds2Id9IxJbN7lj3pCo+DANg05JY11R53u5oOw+
 CsgkpdYUqeb0Uf91FBpnQ2scfzNpLTaOiF22E9+0XlNXjJdvpwaqo5h7GekpGs3vbkHgBKPT1
 2iIbTmLtSg6qg99UXoPptTyw9B7Y1y7QTb4Rwa9KPtxHI2wgireb6B9COfJHI2SoSid1EI1q3
 qs9OspCP+ngp5ak47iItFweWHeaiz7ec4wrn0omj+UY58nxwjL9Y3p0skdhztKA7b3e2cSFLz
 LWn09AbjxvVR3DgPFkc3pERpYg++lSyFlzv5+G/QgB1DNrhVg53nBCexpVUACWvmt7g5Z19+S
 VETVgqMMvtosmvSTy80Ig0kHJ65C6z1b4ZptLeEqkP2hGJkTaZPvHPvZ1AXf+EgEQeue6yQjk
 6KdFoH9+LeliiZL+/ncGERc1Qw7IOKrALZ9ONYOCd5SBGDGNLIrt9yeqPE0Nfpk8vQoGx99HY
 q8E5Czhnw5amtoobIzAY/MTc92XdWYnhq1+IdK1oyGb9okycYDQs0kOhFVXygprLNhUc/l1Sq
 Gvw8+McB11ijnMhRGrL0nJ73CffuwuJnfiyckGETQK3AdJSnXPzQe2VdgLPXHfOcmdvS3+DxX
 fLY69+VfWWCOJUKv6Jq2VkVFIjdLgFNn9c+ZKCfLIwjJq1tuQT7apnst3ro5TpLOzyqPWrp9G
 dQH+qlM6eTXm3nHjfIGvZ+WHESoe8TLS0PeeuqOMzAVyFozGRE/578WKjgmMNw2SKwTcGz5T5
 p6HIlqLNz1rgJDFe4MwG1Ld5rvMMiMMpkqcnE8GehJKt4=

Hi Junio,

On Tue, 21 May 2024, Junio C Hamano wrote:

> I'll figure out a way to convey conflict resolutions as this topic
> gets merged up to newer maintenance tracks on the list so that
> people can assist with ensuring correctness of the result by
> reviewing, and follow up. ("git show --remerge-diff" might turn out
> to be such a way, but I do not know yet).

I pushed 12/12 to https://github.com/dscho/git's
`various-fixes-for-v2.45.1-and-friends` branch, and updated the
`tentative/maint-*` branches accordingly:

 + b9a96c4e5dc...c6da96aa5f0 maint-2.39 -> tentative/maint-2.39 (forced update)
 + 4bf5d57da62...fff57b200d1 maint-2.40 -> tentative/maint-2.40 (forced update)
 + 5215e4e3687...616450032a0 maint-2.41 -> tentative/maint-2.41 (forced update)
 + 33efa2ad1a6...b1ea89bc2d6 maint-2.42 -> tentative/maint-2.42 (forced update)
 + 0aeca2f80b1...093c42a6c6b maint-2.43 -> tentative/maint-2.43 (forced update)
 + 9953011fcdd...3c7a7b923b3 maint-2.44 -> tentative/maint-2.44 (forced update)

Ciao,
Johannes
