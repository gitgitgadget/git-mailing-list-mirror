Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3F370AF9
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594443; cv=none; b=aAetOr8/p0W7eX/yrx6piftok8vJCp+KpGM2CSdG6TvSWPIZIcINV83VIt1G7gzMB+rJfQw1kvlpfXNtgNmr3gtRhMFXi9Zrt+Vwd7q34Dt7NR5XB6MLxuzmCPz5XCSmD0b/MNk9f6tkRIgSdVU0D4nKh1eNE1AcDA0/TfBpfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594443; c=relaxed/simple;
	bh=wiGkJcLQAbI0Mk8B6PmZI+Gjksv2BQs6I+nm2hJrt5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrHSytZGg+bMs/lQXGdFJt3qdLyKMaDwmmgS1mJHWo64sAugC/L09imlwE7zD1SDdDSVcH4zKnZBntQkbrFYwsI5NAa4yErRFJ+cQsVjY3ovURfc0WjgvMAC5SQq1p+RINEcCHd38IFo6mgTAk5Xc3rSa/Frg8y/45E9Lk0itvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FmLvGne0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPjMJrCR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FmLvGne0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPjMJrCR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 754C77A001E;
	Sat, 27 Jun 2026 17:07:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 27 Jun 2026 17:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782594440;
	 x=1782680840; bh=C5OE50pt4zdDVqtvYJOEar7yxHddmsObLHPTKo+/UgM=; b=
	FmLvGne0KLsdSfMlYvgI0T5HXyyIBKpBUL4Kd1jS6STNkx/671dveJBxABBeYBb4
	5WvmgldyPOKihVjG1etjyHNwrF2dKuPtmtKuWX+Yz+//A17GN073PcucEwtFYOzD
	8pyp55HxUMecDX5sN1xDp2tNzLM4YCrMzu+MR1dhVuMZEhrdEKgpqTMGVm0z84Ub
	FgW5oNiImBmg8qz+dZqRsZRc0Or9CpStg6/8OEeduT6hydn4I/tdACH0UHXMjmQ+
	qz6vtiSo+8OnwYn9yKTWjv5IE/aeuzZd4PQ409bcGxGkg7hah7Nnw/Ji2nR1AhRP
	w2udvqF14KC0E5dw6sDTzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782594440; x=
	1782680840; bh=C5OE50pt4zdDVqtvYJOEar7yxHddmsObLHPTKo+/UgM=; b=l
	PjMJrCRYEQbXiPn3pG7a71eyllSbyN/ogKR4rPx97cWcZdV9t/52AJwYy3EXU4Qp
	zNEksRzUiGznG5csUg+nLOUZ8SRswnG3U4XAEaj3523eLhEJJrE6MmxJHaG5qkAQ
	Dp3zXhN36++RvP///31k0F+dq63t8qQ9JRIysa3p64h2aujnxGXZ03Qdh+lzH5ZN
	ukj6s0fYHr1232WuVuoUYHp2rTvcBGFtHTBStMqCcgtDWtoJLOJdJtgeYLRCy7XL
	jzwYMltpAIkDnpwGh5f8osa2Oty69Q6kjujnP90s0tK9ILZD857gOnwg1IXRbAK3
	LrQsKTkZkJTx3QQMGQtoQ==
X-ME-Sender: <xms:iDtAatVNVBzFYZVqaImLb8s6eIXKI8hii-DkxWPm3F1pQerFnnsauw>
    <xme:iDtAajkhwhw3kXv4VXlIUwHRBGh9R8uAoW_9VXTFb1O_UVYePDcg8Daiu3EUS7Ppt
    F_Q3HinGjAbOFrzWF4ZaAYYWRl0mfrCm1yqxRxiJNnvy8FAlbTg>
X-ME-Received: <xmr:iDtAanBRVutTljQT-GOMt-zwSyxRbX2skTq7gfVG4qY50JwkBge_3KVCeFwaYsVzwK7UmzzMN5Rwb3K11yki5M7OSxiFi73pJSKXgmpTH1b9KCAPUe45RBI>
X-ME-Proxy-Cause: dmFkZTFQAgnEIRl5+aKRXqL1yhHxM+Dv+sw2g9ZE0BHmn8WtRjnGi23oMnrJVDY8JhsjL9
    lWPHReu9ZKQZ//iF2EzmOrd0SMHKVSw4FFLYcgTrFQIsFDvLLgwf6TeyW43p5huFGOJvyB
    CSc83NPAhD8TaWzpUjLzYkeY08db4aInISsMprOBpzEMAxJWHOkKjoKMYgM6jqQVp/9k7h
    02FDBnDEdIuQTt4ds6L9QcEvM5kxmwd6aZNf9ytnJLtijRH3QZwkFroIpZhzKRZoAif5yU
    mfAHLO2ftcoBGk1WAftDf/ti/cVPtNEvc5Jg6HuuFux+31S/C+56aAgn812MvBJcBAndVc
    ROBqq4F7kYQFo/31cpYqxHk7fpQGqRAXyL7ihg6gvbxd056IVqFtWnrglQ/9sWAb1d1BIS
    FUdqkRhlBjov0h7y6/wG9qxJ5x5y5dVZA2E73JWvBm0dclGCv7W1Q+gGaWU4KAI5yYOLdn
    KUWmOMyK7v1j8LXF9lhi9LSuQqod0xyK+A6gF8iYJNMI96tMbNvjPdTo+8cWpOH5UBKjd9
    KizGNR4OPlOZJE+cUIWKn2yWN4VL9/3u/FAhFGmRde5K3CcOknKYQ/De4C1rR1+snsfkaN
    QtfD9npCol79sEJip18FQqMwofdLk0AJ1HO4MDKV8KZ26V0es04OleWR4edw
X-ME-Proxy: <xmx:iDtAareVBRyXA6b0jCDI7SiKyvX-iyDKtSH_09e1NKx4DammPLAKGA>
    <xmx:iDtAaqKmXZO7BDUj3dgcXqoQxAeepKXBh_Hj2QmAoIWOIv4Lo2ZIZg>
    <xmx:iDtAamdqhZk3jItquD42rwsJ0omtIIc8kpUcZZ4wTgaHi0cOQ0--FQ>
    <xmx:iDtAap2K738BMNGRMkSLvNONjWeE-FamPbqbSUT17rZPmoh-NxR4qg>
    <xmx:iDtAav7uxobh4NtQPWZQMVY7bkTLCgLldhI7ud9WfyAkHivwkX6Pw2xn>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 17:07:19 -0400 (EDT)
Date: Sat, 27 Jun 2026 17:07:18 -0400
From: Todd Zullinger <tmz@pobox.com>
To: "Person, Tim" <Tim.Person@personent.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
Message-ID: <20260627210718.zl0eH_Sc@teonanacatl.net>
References: <SN4P221MB0713994458A94BFCB51F7AC494EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4P221MB0713994458A94BFCB51F7AC494EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>

Hi,

Person, Tim wrote:
> I am writing to determine when Git plans to release an
> update installer to patch the security vulnerability in
> Git 2.54.0 because of the included OpenSSL executable.
> This vulnerability is rated "Critical" in the CVE
> (https://www.cve.org/CVERecord?id=CVE-2026-34182). An
> updated version of the OpenSSL.exe fixing this problem has
> been available since 06/12/2026. I am just wondering
> if/when you plan to address this major security issue.

The Git project does not distribute any binaries.  You
likely want to direct this to the Git for Windows project¹.

That said, it's not even clear to me that the CVE you
reference affects git's usage of OpenSSL.

From a little skimming, the issue affects use of CMS (which
is something like the successor to S/MIME, as far as I can
tell).

The only place where git gets close to that area is if you
configure it to use x509 as gpg.program.  And then git uses
gpgsm, which is not affected by the CVE in OpenSSL.

¹ https://gitforwindows.org/

-- 
Todd
