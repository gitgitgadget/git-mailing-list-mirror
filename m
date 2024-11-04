Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E117965E
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720180; cv=none; b=IjKiHK9BjVlDE8Q7NEE+fOPRXxECxbVJYMgdviabOZ7eBO42UOcpguHBJzS87p66/b2fcl7b/9be1tGGMNRHQcCOYXFX0lkRO+rAQeo1YRxaiAoOxoWOpVHH4kLYSOols4AoMWucF/ToEoYTkBi/5x8e1STYeI4BCCqbMPaDmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720180; c=relaxed/simple;
	bh=wZRI6VNHTwyVJIgkF/ha3ClpeqZxDrkigMoKPcuZzM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3YvWsiSqJneVRVvl9XQZdeVuT4hjM8/iaAgMwo9wjUsk7Qm9FblaZ6nt4E84vZ3+054mNw++F2qT9G5hEt+3UlD9Eab+SWI4sLj2L6SqVlEcCcMMUjDyPCv7Xe1XCSE2NC1kor38mPkJxMi0337lYTso6KQVQYBrb3lL0pkbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BOKhd2fc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDJhghN9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BOKhd2fc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDJhghN9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 342C41140109;
	Mon,  4 Nov 2024 06:36:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 06:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730720176; x=1730806576; bh=QT4wC2nu6M
	1+SLFU0DmmrVSdWFWwRFfgFCtAcw4R1OQ=; b=BOKhd2fclnNQAz5HoP/PEbSOFN
	5j8VQY5xJT8aT+MX+NCnpgFgMjj7mEgW2T7YA0S0J9NVW4+gDwwlCktrIhkUIDdj
	RaC6dmmLN07pU2x2RXJgK206KKG+EaX5IVHOMXU3m++jny29R316dXSL/RQUf2qT
	4pl7KOpbik46ITfhTTjoSxCf7XxjPQ4NV5m9kQbSM894l2ggcCZE3CUq1H9U2dZj
	jaoP+XMjA/6yLImIxMdK1B1t2DHLmjMhLL3QqRO14vZ9hdnDIrJg1X7K1zvtjK0u
	udGtpppFNyjv7uUtwo/cnK09C2XND3jqZi4lLNL9cn1zXbeGDhWm91KEvNkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730720176; x=1730806576; bh=QT4wC2nu6M1+SLFU0DmmrVSdWFWwRFfgFCt
	Acw4R1OQ=; b=EDJhghN9DRjOgCIxLPLMxcow04/SZ5cJwmleoBkse5IPhjJAifq
	kI2sucgTNput15PY1qX8nXgSimY9S5K5IMVHTy3eJgKkrdlvVBCav8XWXlRaoFjc
	5+ed1Jk5a+F2M8GwezGZVjHHUxyDBW5AVs9VNaHXq9UgUMOYyH+rlhEO8hcWNnId
	CK4rSsBO5HKe30H1x8dzfTRzyGB8kfTirkNVRRx6aTNcFdYeyTuzrGjyIv4K54Cy
	zNE2rRCmQLsFDfKKiP47Idct/ZL3LJiI+qZHRe9h6u1zrPjIPLwUBU4LeE3MMSa+
	Bq/Tlwp747yMMq596VRjbEreu6rRWEQNeDg==
X-ME-Sender: <xms:r7EoZ_StT8F3cHHuJhR85VXfb1k3SKCUFrQESlndIaETFufozTCbxA>
    <xme:r7EoZwxlHCLvp9-fGkHXCFjuT8Vd6_8VmW1-m9YlQ3slMN1yPQYxdI80CZJts4szd
    g4RO80D4toHy7JiAA>
X-ME-Received: <xmr:r7EoZ00mUI8iFC8JCB3MhbyRwTDp1Et5pyI7nBpG8nlImKS-rkEggDGIzuKL4XFzrWbfdJODrheFV_U5hTE5tJKmJf_gnbD1ZE-KDYsAgp4bbKgMnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:r7EoZ_DoaGEsEW0Cu_reEu8ht7H6A16wgQywPuDEwl61m9N8pH1fNQ>
    <xmx:r7EoZ4iSdtT6xCPzoP_7L_gfLUS-kgYzxnk3UW-jnmVTmVGmBoZDPQ>
    <xmx:r7EoZzowaYTRRaJk_zXnlzeyN87scY5mfxaXrH5yI0_n4tezUVYyLQ>
    <xmx:r7EoZzg2MxZChH9f6bQOUZOO5fb7JoluhX5yrSLFuf8wha-_XtkC8g>
    <xmx:sLEoZwdUUJ5DYFRUow8AnU7RN8UymUE0sIbM2T1sG36AYTVPHgvhDmrl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 06:36:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f1cb974 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Nov 2024 11:35:51 +0000 (UTC)
Date: Mon, 4 Nov 2024 12:36:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/3] Improve CI testing of older systems
Message-ID: <ZyixnuBY5TcyrHEj@pks.im>
References: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031234934.3451390-1-sandals@crustytoothpaste.net>

On Thu, Oct 31, 2024 at 11:49:31PM +0000, brian m. carlson wrote:
> In many cases, we're not testing some of the older Linux distributions
> that we support.  However, we _are_ testing some old Linux distributions
> that we _don't_ support.  That means that it's presently difficult for
> us to make sure our code works on all the systems we want it to and that
> we're not accidentally requiring newer versions of dependencies than we
> claim to support.
> 
> The first patch removes Ubuntu 16.04, which is out of regular LTS
> support.  The second removes the clause in the CI job for that OS.  The
> third adds several new CI jobs to make sure we're adequately supporting
> older Debian and RHEL-compatible distros, and documents the dates at
> which they lose support (so it's easy to know if we need to update
> them).

The GitLab CI-related changes all look good to me, thanks! The GitHub
ones do, too, but I feel less qualified to comment on them.

Patrick
