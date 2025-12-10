Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9530F819
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346051; cv=none; b=fGtNslcltaguTauDqxGMCrH1RU9TdDK/5aDWAoG4CGfsKJl4YW9xxF2ALW4rGJ0nLcyWB0S3MfuNmwIg6UKxTUqGjeAezP+mh9XFbEtCdcJx89Men0XZN4m+dIPTHEqANOM2g0NHOJVg0G+8OEl9bRFk7ALD29pOQdxKysKZtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346051; c=relaxed/simple;
	bh=ITZXHzTOQ31t0JIZRophzhODUMy/gEW5ajzlpcgJgkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKKZSmJ6wdj5ktJCU8HYTLPx+JlVqD1oTGamOcoHWmR1CBG+bQh8S87xZx16WC9PtYKFtdgLmasR2fx6MaB33QghSOdfLTPRA4QgL7lQ+kCa+8FGIpU7+5MWsNUxou9VN6RbcL1pGWNaSdLCD4HLjLeKF0wJhaSK5d1VxB42mPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XGv7FmiD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMOnA/Gl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XGv7FmiD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMOnA/Gl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6DD414000D3;
	Wed, 10 Dec 2025 00:54:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 00:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765346046; x=1765432446; bh=ITZXHzTOQ3
	1t0JIZRophzhODUMy/gEW5ajzlpcgJgkA=; b=XGv7FmiDMWbyEG5iPgnATsUUpD
	dinWTmIWnO+tbMXRVCyJe/Kh/c57fiElFx7Ge7lO3RTdeBwK2p2IriFJq/zjpLLX
	dkNIAC2x/7vhc6+g55+QLJqZJ04O6vRwbCtU6wv7ZXcUZIN3O6xwR1knZhIP+BXI
	fqCpa+aanj9BqwcBcCA7G7uK3d21O42P53X9GVENIKvKrs3CiRMSPI2Lw0He2Odt
	oRBsiO35MEP0jsg7bM9/p6Urnz/JaZ7r/zDjy8pRMYEmxDCdH2S9XAyqKpY+Wntj
	NfI+r0LysetF890abqliatlTALo+PN/AWbJhFvUMrsrZ2ufQXSDRkyhcktBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765346046; x=1765432446; bh=ITZXHzTOQ31t0JIZRophzhODUMy/gEW5ajz
	lpcgJgkA=; b=jMOnA/GlSR8bDEO5DMp7xdyrLemNOrbJqD927qyPC2xI5khaXp2
	rb1rw7dCUzNBA8mI5STvR0h1Y7blhVJCCRcLsZcbqWJLkLDxTNZyqgDP0LoUJQjI
	JL9gy1CgUPVZ2paEJgUHEPU2gM5wVDpwIdGoVsW8LOhSW9Rt2gJXcOgkAJ69fCI7
	S1LoDJSthCXhgrIJFYv/N6nBoPb1Zgyou1PTfX1vwoWn9rQe0PCfZp3IMv2sIAMz
	RasUZutDavAhJl9KaGjbU7v2fwlCfMlpeKnan/u24q/pFOwR5PSBioLwgGiQ+5/o
	EMAZX8Xm3w1NFwgJVcqMqBd1rBu2hUwSpNw==
X-ME-Sender: <xms:_go5aWGCFXsB84i8l05irUU6rLKO2KeP11pej7GM3Y6p-sLbtopo2w>
    <xme:_go5adVIS-NzKDNgK1ftycEACCZnGxk4U0rLpFSSkMKNYJ_J7Uhp7LebiCtS0RCaF
    7PrxilH6Xcck_ER_qhRGaMXSOOiuptGYKHh6WNBY2ejz6SH-dLsnQ>
X-ME-Received: <xmr:_go5adxWInk18DbSnHly-sgO122EOHCMMFXhL51GPKfh7HVb14P3HejneX7qV19xOFTqAk2X8MCNjT3OPfrH3WGir4YnXCtyXGcuAmoM89QL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_go5abPsUnCRrupOI6mNQno8vkrOhPr_C_X4RFHDPbwORBbwfCjpDA>
    <xmx:_go5ae4XwqwPcZVFwGpu34Tq_093xXcOE-fWjYq-e1ubgVaMPaNjpQ>
    <xmx:_go5acPvIwHWuDYbLAhxLhXfMUd0s1yjlpnnzk1HaEAmBINefkn5tg>
    <xmx:_go5acn6DsNLHs78fqHmpU-unuPRdZXbDQ484mSZ5CFsR84a3BMpmw>
    <xmx:_go5aW373Z8GNS_ib1RdW_ibIYXMuioJANHiV1tgRjzao-6unvhSk-qO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 00:54:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d1e03a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 05:54:05 +0000 (UTC)
Date: Wed, 10 Dec 2025 06:54:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] odb: read alternates via sources
Message-ID: <aTkK-ipzrsG21blw@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-7-e7ebb8b18c03@pks.im>
 <gmhqd5nkhpk5wqjnfrn6blnxo2owvfgomfbi652fi462nf3tny@eyhy6glagywx>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gmhqd5nkhpk5wqjnfrn6blnxo2owvfgomfbi652fi462nf3tny@eyhy6glagywx>

On Tue, Dec 09, 2025 at 11:49:55AM -0600, Justin Tobler wrote:
> Question: the interface of odb_source_read_alternates() still expects
> parsed alternates to be written to the output strvec. The sources don't
> get added to the ODB source list until odb_add_source() is invoked on
> the source. Does this mean odb_add_source() will have to be able to
> handle various different types of ODB sources? If so, will these be
> differentiated by some sort of URI?

Yes, exactly. The plan is to use syntax like "files://path" or
"postgres://127.0.0.1:5432?database=myrepo". See also the discussion in
[1].

Patrick

[1]: <aS2V4TKeS4V_oxAb@pks.im>
