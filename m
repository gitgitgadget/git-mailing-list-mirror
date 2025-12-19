Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394F2C21FE
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766126620; cv=none; b=nU4m3kgd4PbMscNTi2hOUJh5tdRCSOxauQ5oA91x/QzTWlsttFlbqZm556ImCeFzjApNKSw9a+EnIe3BR12OsKepzQxWCcpq70OExJtY3PZe0aa4YDhdyHvjJkJKYLlp/sG27K6qfeep2gaOE31+hNPOZyHrCuQ9q+HNDqCCUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766126620; c=relaxed/simple;
	bh=fSKK7a7i9vxS2o0PQqtgpf48VbbPZyBTKv4ENOxDFbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOoei9QajhRqFD3d9Qw66GJy8w1ADGZjTLoD3gJ1sFa93UUlEpEJ6HY8W6ceq7HTORsWJ+zMV3XgUslBRQ8gNcxem36QOUK9t9gZoZy0UjP5jQJ+iCSTnyI33RMEa4pY9ik/wgDhBYm88v0EUbKJ5xQR/uA893XB/eKLMOPsrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cg33iWJA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPkGdiCq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cg33iWJA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPkGdiCq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C9207A00DA;
	Fri, 19 Dec 2025 01:43:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 19 Dec 2025 01:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766126617; x=1766213017; bh=KgzhYOzGAs
	p0gMr8kEEStxemPg5TgR5lgWhkDznyfpU=; b=cg33iWJA0ksF3gaoDoC+T9Tltf
	cUniFIvA7ozKkoASkiB6/enFAABPJjEkE/yRD4B3ipyKJspRY9c8xE13p8TjQArS
	VHZWDdQMl3Sk1daOE/HLT16yrxcwsTJkOdDxo4UtQdp19Ts8fODuhpqNOoo9gK2W
	9ywGxeNBkLywd4d09SlrM1Ng6kdkGoavNdDV8WDBlhI3Mudmi/JN2BZ8C3MgPAw3
	rVffAx2+2B4Gabt3BMYVT1qPOFPcV+aDR20eiSnTterA2LSltpSPmg+v9y67RAke
	DwkRJqrfqkVOqSCI+f/3jfShDw/9d385hPjUTRLOzGp7ONf02g1MCI8LP9xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766126617; x=1766213017; bh=KgzhYOzGAsp0gMr8kEEStxemPg5TgR5lgWh
	kDznyfpU=; b=KPkGdiCqiIMnovUi923p4vF+TWfsHIvsrSJl2pvza+Fj6+wXgXk
	tKi/BIcA51F3dScrGMS5Ioi8yAbIo4WsaLLqPb5WV6nj9CJ92SLGvjrHojEd2zXv
	cqK7ImdEZTCJ2I/k1kWBshidMeAaePNdUoKMkq9lxdatplUDYq6gUgPCunnj8pyt
	undyHqSIwmCu/1I/940grY74OoF2RAXlyscysf0e9S453VfdtrPt2z6AF8s1DyqD
	x74qxopxgSiZGRA/KMPbRDEfCUA4POMQS5hbVYLDgk43gYrOumOkkQ+x0V6jnkSE
	4Y1Nil+vA5Kk8KNapaTQM4BI4NlaXe9Q/uw==
X-ME-Sender: <xms:GfREac5GNNOY7RZyMU_DAVri2leOo3lbRsNPT0mIqtwKtNeoiuVXNQ>
    <xme:GfREaVUxmYB58KeMnALI9jDHkwSyurYMdvvhNv5lUIs-G2IYUVAVGW_YIQGO6Yqo5
    aR5H_YUXiRxq36kWuC-GstHn-2qgdP5al9oqfEmvitFFZf3PoOqtGE>
X-ME-Received: <xmr:GfREaY1nZsgRRSW94wTVj32UB6GzSax-rDjE5E4lQbIbMxmcqQLaP2WQEUrC9AOnkU2PuRpkOCd4J4Z61wFgkLaQ8Yrd1W2q_WUwdLHqgJtc4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:GfREaa1IaflFuacqv7BmFc5SnWcfbW5KpotXW-05Vi3Ybo9fEs0AxA>
    <xmx:GfREaT_b_DgqnPFb_BSe6FXwX1t271OBsgNilwhd59D9xiQKcrao9g>
    <xmx:GfREaf10STvKsODcEQXF1jHwVru9K5_ePmgaFuXKoyOD70Kmv10lVA>
    <xmx:GfREaY8nceriAu1oulwOrm37mkXYUx3Ctqm6xCDLEg8SRE4pve9GKg>
    <xmx:GfREaY_-rIz4gMvL4HECzb0O-Dvi69kvLDNNolA4M4QoLHOTbMu2JcoS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 01:43:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e9256eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 06:43:35 +0000 (UTC)
Date: Fri, 19 Dec 2025 07:43:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test_detect_ref_format: fix comment
Message-ID: <aUT0FKKNTACtY1gF@pks.im>
References: <pull.2019.git.1766071259531.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2019.git.1766071259531.gitgitgadget@gmail.com>

On Thu, Dec 18, 2025 at 03:20:59PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 52d7759bf5..14e238d24d 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1724,7 +1724,7 @@ test_detect_hash () {
>  	esac
>  }
>  
> -# Detect the hash algorithm in use.
> +# Detect the ref format in use.
>  test_detect_ref_format () {
>  	echo "${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
>  }

An obvious copy-paste error indeed. Thanks for fixing, this looks good
to me!

Patrick
