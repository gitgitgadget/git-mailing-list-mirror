Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0D78F5B
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831819; cv=none; b=IFLK9jG8ZwHnUrBYW1D9PTLLjd9H0QXUMQYdNbUFc7xrhjD24yLzz/3+FN/0bsX/GVlt6zY6XsEgbAwxnzdb87TQ8Lb4ww7fi1I3z9xDR34nuzhVXeRUr0NVqNRJA55SR0GebOZAEyiuKMHVMW3QnzX7x/ttpF3ptJX+PPoj2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831819; c=relaxed/simple;
	bh=7IX65RpsE1cOcMvEvG9l1luJO+oN1PP7h2cSL+8DF0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjX4jBK1C60ab6NVwq3FgVXQC6GxyX5HL1hhlIM6vc1TtDh41PooQUU6QrjpBSsFtHyFVAOxOs37mQPJunAtoflQiBNe8SL2Iz48mty+/LxspQa6ks+SLENlmjucn864MRW7rUzis3DiDOGyhXubc+RsezKqgoBsEvTVVydCBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E26VpVA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVZZY8e/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E26VpVA+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVZZY8e/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA0FE1140279;
	Tue, 10 Dec 2024 06:56:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 10 Dec 2024 06:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733831815; x=1733918215; bh=7cwdvniZhj
	KqbEFW8pLSPCMcXPD6Dk8Lu5oK7N5j73I=; b=E26VpVA+JiDxZ7hjLgPSG/uSCf
	8o9LmABZW48hL/08esRJcey+SmpdVeyZr0tjIQ8A7cdaANCQH0C9HXioPJB9B1m+
	qljq2lLcLSQToVjBE1+eaGIA2ZikDMVts9u6Ese3KqHAIJWay5ehguezVrPt+eqq
	4R+pwUirbcN8A/8qks8hPpwBx7vCUVRwWe6UBMlTP7FApnoA4Hq4Q7MIU0ddERC5
	Zt3/tEpcGyRmPsyro/cWwA94DNEv59nj9u/UQjU0+Ni2ABYaRoSkGaJhMiEoJsEm
	FXMtleQkDiHykIRRFlKLETZ/oKnCI9aEdbDAjOAfUDbQA+p8ulyrM1KtZP7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733831815; x=1733918215; bh=7cwdvniZhjKqbEFW8pLSPCMcXPD6Dk8Lu5o
	K7N5j73I=; b=AVZZY8e/3G4S6iRHK8mWucvSQguiwe+HaIr8VVAVGLrtpaLgARY
	WK8Sa0WK3x3ekikysiQIpjEv6A4XJETrfTVrBSlvQFKORMK1XGqAdLqDLGAe61/C
	3/woliSONGc/53mDzp9kV0WX76h6amp6T6WNcSPT0rc6CaBMd90znWtrc1yC9NTa
	KrnOiy3zllS8u537UNIvkETpTVq0xpDX+7CNaYf2nnG9cLQ9ec8xS0RgBZLb38A/
	LRkT0jbO49rS+j5QYsMCoou1XEWfNnQWE1qT9Ebh3O6ExvcXTCntbCIaV0QaQC8d
	U0ak2BpSNImOO69gRh0sxcHunsHYOhiGV9Q==
X-ME-Sender: <xms:hyxYZ7dYDhsazEBdn_8Jp9JYTFTR5A2f09ykuhKtaxKCALtft0Kqng>
    <xme:hyxYZxNMeityxVIK571vxRtPjr_JXl-CDaamj46u_ZxXnNDUhZF2ErZJdLELUel4S
    guz82W5i5EbE3jnrw>
X-ME-Received: <xmr:hyxYZ0jOT_ZgdsQUBVDNs8Hfu_KUM5VPthuVsjgz1EEz7hs0ObeYuPXQj0-te01vEOCweibHOP3jBexPlo4fRiMvXow-WuzWV0cwT6_6csFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:hyxYZ8_wknIZvVIfSD0v1yyStMmtZLcTq0BpmmuWWcgfi2vjytISlg>
    <xmx:hyxYZ3tGAookWPLl64n1UtbMlxPqWgfQlrtKDvoXw8A9B8SzUObDGQ>
    <xmx:hyxYZ7EglfKwX0sWHTTCE1VcYLAMBtj5huSDmcgWtA4pvfZr889ZTA>
    <xmx:hyxYZ-OCp1jsiJwGbTtEjmr7wmKRs4InuuRFy7eMB0A5bwqoxGG-3g>
    <xmx:hyxYZw6Io4XTNu2BV_1gExykCKh8Q8Cn1RGw8LPNMJkBMqg3bBD9piU->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 06:56:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 177ad26b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Dec 2024 11:55:20 +0000 (UTC)
Date: Tue, 10 Dec 2024 12:56:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci/lib: use echo instead of printf to set up sections
Message-ID: <Z1gscPivAADEvMGI@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
 <20241206-pks-ci-section-fixes-v1-3-7ab1b69e3648@pks.im>
 <Z1QRp8jFJPYdNmQk@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1QRp8jFJPYdNmQk@ugly>

On Sat, Dec 07, 2024 at 10:13:11AM +0100, Oswald Buddenhagen wrote:
> On Fri, Dec 06, 2024 at 12:10:15PM +0100, Patrick Steinhardt wrote:
> > We use printf to set up sections with GitLab CI even though we could
> > trivially use echo.
> > 
> probably not a good idea, because the file is also included from plain
> sh scripts, which may invoke an `echo` that cannot deal with \escapes.
> at least potentially.

Ah, true.

> > This may cause problems in case the argument passed to `begin_group ()`
> > or `end_group ()` contains formatting directives as we use them as part
> > of the formatting string.
> > 
> that can be fixed properly by using the %s expando.

Yup, will do. Thanks!

Patrick
