Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD11C683
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002888; cv=none; b=lpHpVw9P3XtvN1yjra0hs7X1Cxgal/aoew2+gzf1sFr6QwcpQ4RGSlWPdpMKHZhpcF2swphBVTReOGISGLTgY7UlL6bYRA0ep1P6D9jd3mWNXvMbpvsmCxMKQeBOK8uySqDF94avWMPmkmvTeg79nlo8HGetBehrpp2Fl2QaI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002888; c=relaxed/simple;
	bh=V09YbpTVH6vK7mqlSzAalp6eFaeV1Xo9UgHgnxSLkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlCymizvtobBxPTtxp2o5ahTvXmBuDSN+GC97Cl7zhnDgUPt3BiVZmPoBgNxoee47MvtgAfwl1eZ4DdemrH3uTAUikZEdWG/LPyyMi98FvSakKaXU8dGXQuv5hfdxQ+lWSr2mvSbV3TumRaZtwqFxyfGRtrFnFyo2giery5mVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kyAYQALg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2z+RTwf; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kyAYQALg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2z+RTwf"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 221E21800114;
	Mon, 10 Jun 2024 03:01:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 10 Jun 2024 03:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718002885; x=1718089285; bh=V09YbpTVH6
	vK7mqlSzAalp6eFaeV1Xo9UgHgnxSLkuk=; b=kyAYQALg510wn3T0v1XLKko6T8
	xLf/vT9qgPLUuubK9Y5BiLSx4oMBmu1qA4cb7XIKsCzcmoZfVpNAkKX6Yi/UpYSO
	pxe+bRW25a6oclXnxa/3UbNY7CCNdGf5cWMIXbiDTITY8m3MdXXn22bz21fiThip
	UcEweAyOrJh7mjMJtFDj+viMzXDecWQ7IgrfTzAehrkCyHqLBWCQ/irHdUuVORDS
	/D0P/BCBPVSTlfCwzsTJztiN30eazN40b69trfJHyLhoQWHZCh/h06IxhEGABfgZ
	EfbF1ZxRIFKFj4pChN02z0mqeCOPXJ2bZ3p6rlkHZBcFG5/5VVeCefFl50Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718002885; x=1718089285; bh=V09YbpTVH6vK7mqlSzAalp6eFaeV
	1Xo9UgHgnxSLkuk=; b=k2z+RTwfRAE/7qV94OGbJ3Z5DqZrD94p1yrW4yh/AG5t
	oI0NcLZnu8jjmYYkL9d/8o25joue8ZkU0pGzJadNBwEW9F6FKgtfA5Wak7TvBBpE
	fi6r9NR8aSzMBw8wpq7EgegBjMFdO0NUIK1dBe5Rd1oHcI2Bg/+h9oImQsBKdFTs
	/BrO+BtZaq552LRiM70vmCA0n8SwOml1sENGFVyXGRydQwB9ahbIC1H1VWOsCThr
	X1qppe9mAI5eOlZREJtkhsqr/j9Lb5FCZP53CrEqGL5ZZOhK8b9uKmLYX1bU6gaD
	9/LRHCGiJp9YYyT2bct/l7PbjFCu12tvCXEcTNfdzg==
X-ME-Sender: <xms:xaRmZh0YqrK0BNRYP3XNY4_UuKMXjm0M39xjRyZPMSS1qApyM1pFIg>
    <xme:xaRmZoFuyIwZrDmS-47Ndc2FlCsl7EnroUnP-IgqVLbpsIATdRfBr5KZ6S5CKsb66
    xmg5iqF_SCwvhqIAQ>
X-ME-Received: <xmr:xaRmZh5L67gbH41ppcj4FwKoW7o7d-KBUjnff5b8Vdg_adRCX_DHlyxvKLuH5fmyQDLJ-cmlhH4jR7J9zV4mdlnS6q0LWwfgZimyTyrw3ZQmVPyz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xaRmZu1bN6pt_vsEMqzHQCT6Pnasl6FnePmxhD2UNEb4RmzrMBAgtQ>
    <xmx:xaRmZkHW6LbzAYdPRBm8mK6-jXyB-DqQxnRtBXNdM2O2YRvik1Aiww>
    <xmx:xaRmZv87dHTVpjgmaN2LOf920_IKZwxIaya6ovaBvcUuD8RQEA4lSQ>
    <xmx:xaRmZhk3FueAtbakKrbLDz2rM0072QLe9_Ku1kqDNZUFuZGqxRvjBQ>
    <xmx:xaRmZpQKRkQtt5cQidAHEfWu2F9LZSBYXYD_rPSAjhaLabKopWMpiK0K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 03:01:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ea50b9cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 07:01:17 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:01:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] __attribute__: trace2_region_enter_printf() is like
 "printf"
Message-ID: <ZmakwSVBXbjfRpUi@tanuki>
References: <20240608183747.2084294-1-gitster@pobox.com>
 <20240608183747.2084294-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AjHfDXDdxsQac8Go"
Content-Disposition: inline
In-Reply-To: <20240608183747.2084294-2-gitster@pobox.com>


--AjHfDXDdxsQac8Go
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 08, 2024 at 11:37:44AM -0700, Junio C Hamano wrote:
> The last part of the parameter list the function takes is like
> parameters to printf. mark it as such.

s/mark/Mark, or convert the dot to a semicolon.

> An existing call that formats a value of type size_t using "%d" was
> found by the compiler with the help with this annotation; fix it.

Makes sense, as do all the other patches in this series.

Patrick

--AjHfDXDdxsQac8Go
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmpMAACgkQVbJhu7ck
PpTYHw/8Daqaz5DGTczNYfjv7dHvW1Wg3Hn0drK/x9wRQ7dnEvxrOX97GfyWlkOh
vV09cX4qxxGo9Evne8Tfiqrt72v8lUuM9SXZTst5p4gmmS1mxXVPriUyHvpJOBZe
l88WFS6i+kb73W+DtIGa5mlxrPaeI3dc4HEEO2D1/r9RtkrIWP8/3rITLTPjsTNv
+UvjaFWNpWsiN4jV6CDcmI798L35sUJcZko28esBTr9qruI7/xyeQ4csSMCWye/7
uYAPIwKn9r6Li7JLXJcjUL2bqPB62QW/SH0aulMsGK89jsT2cfRt49WZDefp7NAX
/WJg7IBWdHnkrYkWY5GTPmBjq/ezHZEvm5l4t79fRswSZQHOaPmVJkBSS2i7JR+W
fleZfMu30DhcR1DvQQAnJZhH9E2h6FnbNG9uQ3nBIx1jMFA2/PfhP1nNuhKIGtEw
1nbDuHe4UrwGAiOUmWSsvH5CBgQG/TDE6U9A0X17plGVqA6Ro3u3ttgzZ4lvWfWo
UHdez3lMn1ILchLBbdaJqiw2NiCKmBrI3fVJKIcFvqturV0OUsPc4y/29eOineh1
T0s3t4AUQPoIyOqeZ1yHgTNfrRQysPzm2bv/hfrC/X57XUOFZDIgkPoHs4iM0AoC
iK1xo62ekJ6gcCsY8I2kR01ee7rnoYQcuU2QqMrxVCWVBKLY0g8=
=YrNJ
-----END PGP SIGNATURE-----

--AjHfDXDdxsQac8Go--
