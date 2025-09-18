Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C72D77ED
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173873; cv=none; b=kACDfEalyk2itQS3j0Hs6a1ZbuXLTyu1P3laXzq1sQeB5YpAgsO6pg39gljLJN/QywI/TTTKqsD5cAGzEaskRqzq4nwFaA7yQycTd+inANDlau9Lsc2lkSO4pO7q/M0ia2/BU6UkBdRwYCLJdc/lIVwUrocvpZnVqxMRT6rk4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173873; c=relaxed/simple;
	bh=JuHc73BlaWu7PDeybivWQIlhpsf6MDyFJNgBwp5D9X4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hS3vFsHUtEHBCLhba5esRucdgszGZJNIZy5xqPOXd42g+bPxHIh9SKgGq5jqlp0st2Co/e7XJ2sFMFZwGOyGZGqsO3dZ0N3XJqxKCptDNURIYxFNTtI7yXyJwEMMWA8jD+NW2VS7nvgK0I4rcHrNNuirC1E0JpE0xHRO49y5sBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kGQ4/VIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RioBdI3G; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kGQ4/VIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RioBdI3G"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7243E1D00237;
	Thu, 18 Sep 2025 01:37:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 01:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758173869;
	 x=1758260269; bh=jg/zjxUMwB67LVQ1x/bOTDOjdSSiOuIdRGsYWqW6Bh8=; b=
	kGQ4/VIExooIyEEnjKYqVSC7yO4/yH7Hg7/YqA7CiBPveDgeBOk2NYRnC/bGsBNI
	flByuUH2fY8p9rhtz7B5jHMYWbP+sOG7KfGgLb8QcOWXAz/LTAiAur95T3KeAML8
	2wEl+mSG3lkVLfVCJ+hJIDBgNdM+EP6pKGAU5ILIOMehL62O/pGlFKwzfzexJQE3
	YzENO8fecWSpIaLn9/iXmHrl66G1WiNg98ZZ/sr3xsP0vNqIgCSZ4gg8aQBF05Zr
	bR4Ne4HY5hcUmAW9TMI/5dUwwYYTscDEVMb8GtxL7h2VAnpcGMtiIXZahtRPn/lD
	vwC2NPWXu8miMKa6XIGDlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758173869; x=1758260269; bh=j
	g/zjxUMwB67LVQ1x/bOTDOjdSSiOuIdRGsYWqW6Bh8=; b=RioBdI3GNvaiwJwOG
	CVVvJows8j5qlWDx42kGyVG4Y6k95Yr4dq0SdlK5g0SUvyjcJ7Vpan6uo/Jm9Ewl
	fyCwJE7KAQPcWqrnxp7V+Fw+XC4gB08WqkASpyssvqREdr2ZsQt9EImYB5n/DQMk
	mWNqEZZdD5/OcTFCAsyI0CdvqrI//wH3A/RTMOxS2rGkESgohyRglC7J9zoLhSGL
	PvG1vEWNLDawA40x9PYhwuCLDZmRR6PqdPbH9HHawOpMyfzwFdIqMNBg8o53kt6g
	qa5RZILJ8JvXO1bZSnmJo7bhVzlbbYqEE/1pZBCtX7I8VRTp7B6WVlCGekYeUH/t
	ACnUQ==
X-ME-Sender: <xms:rZrLaPU5vR_BLOfHyMqUBSzjy-lWYPoIECM7OwzkiQpGLI0KKR0Alv0>
    <xme:rZrLaHnndbFU60GsCShoRHn4nib_oBDUU253ygM_282y6KX34M4ZWY0jUNZrm2Rtk
    1ANbZzWc2ce9U8pVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefh
    ffetteeludevheetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehhrghmihgusehhrghmihgurdgttgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rZrLaHYG8VcUAiOgpimx3x9Usankd-Loz1bCbK5QvIkVpoiesbKciA>
    <xmx:rZrLaPVB_C8eeyJ9ONWcUMQMxpKbXc3t_m0gjlIADPo65rslbMnY1w>
    <xmx:rZrLaL4eHvOn9vcNzj7aTEViF_d69Ixba0loWdqEgujGFPM2NU9yJg>
    <xmx:rZrLaKh9LorLqmdTuUmrRL3DougNXbKEcE0opV2QppULV6EGdAX0hA>
    <xmx:rZrLaHwvD9Pi6LkAKml7unnWs1bG9j-8R4RaTrJxawwFknaHYQv7s1m2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 094C41EA006B; Thu, 18 Sep 2025 01:37:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATjmsVr6bc1s
Date: Thu, 18 Sep 2025 07:37:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Hamid Ghadyani" <hamid@hamid.cc>, git@vger.kernel.org
Message-Id: <74d75807-3e33-40e6-bbeb-d713302aa173@app.fastmail.com>
In-Reply-To: <C86F5767-CA24-4E19-BBDB-D7B4B8FF4295@hamid.cc>
References: <C86F5767-CA24-4E19-BBDB-D7B4B8FF4295@hamid.cc>
Subject: Re: I still use it
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Thu, Sep 18, 2025, at 07:15, Hamid Ghadyani wrote:
> Please keep 'git whatchanged'

You can replace it with

    git log --raw --no-merges

Which works the same way.

-- 
sent from mobile
