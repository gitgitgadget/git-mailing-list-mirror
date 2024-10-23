Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461D17625C
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673564; cv=none; b=ktvwmcyCYzr4tYb6NmuljU7CKBRRIy2SD5BLOYdPx6jjb2uLJyNoj6W3Au3nTVYsLQGq9IjdhcUXJiZQRwXibeIH5gfWyHWGs52JUr+P8ThqOILJneM9khx307cKvSLIgPqbJS3XqaqxTMBlIn0jUdNyvqgeMRIR26c3kbgfo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673564; c=relaxed/simple;
	bh=GpDSa13NLd8U5T950j8KF6p3wv/GtCE9BEXLqP1qAqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cltw+Zdihk2klsn4XtE3Ol2b+BIh7efdRmdm23zpJL0IU6liyGgGI/wYxHa+N2/wwk6jBBr7ceQo6tmQIiW0qJUMzTm9p9iMyl6QIDpfO3suCnOsRSmhaSZJuF/F5MxoFyxTlnjEvsgXIBmCjpWKuIMHEdL6cGDhV/Aa0n8vUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Glj6v4Qc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHYImBi/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Glj6v4Qc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHYImBi/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC5861140110;
	Wed, 23 Oct 2024 04:52:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 23 Oct 2024 04:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729673561; x=1729759961; bh=ZA/WZfhJuR
	2NdcdjJc1l9Yo4fibLazDBh4h2WkOvO44=; b=Glj6v4QciyyV4hrX8eow1bwWR1
	z1faOjEjB3vZ0p5Pz4MxFrRngyQKBv1MSaQP8nOoyaiGgLied67kqQIaVSQNPsE5
	xlCUMcNJKVD9/cGmsf7pVAwq9dYLhldtjN9+LWxkb2qw0BLW4mUni1s2IXoUwQtj
	O0ZADuPSXQ3+XFDCdNtWru1a+aqkm/v+gIxB8sX6RZ1yMajwosww2t2yWPdNGgU7
	f3Bwr0CwV1ArCAC5s4VXS2Yc/WCBufeCGqprZXEjeY6gfHTGNgN8conP6ygkv76G
	MnnVKED65LBHu+jIwhHFMWLDhokt8CavjtQX4i5m5tOeWf9mnfDm5UiDSldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729673561; x=1729759961; bh=ZA/WZfhJuR2NdcdjJc1l9Yo4fibL
	azDBh4h2WkOvO44=; b=KHYImBi/I2Akt90p6shfauzLCCSCvIkQvOoY0Tsc0L5+
	fbJA3O/ddBXLPUUydZakAdvLWgvUo1kGX7cpoNoIAX+bHmixzEhwjEjyv5HakD6O
	N9wjGl4J1N2wnk4o46eYrFBKj3fl5xv3mDhGN/+RGSJUAb4D0A73JBFFdnjHTMEl
	2nLxKyf6l5fboeCB9oLGE6X6yeQ7T4Ysgo/i3y8qpjy2Zr3gyR5vwbVFq7gXgCmd
	Ri3DMUPdejhrc4H8R3nZY7vweU8hrewYSnr3+AV5Hsqll8NKKyMUNzBr+S0Pi8cu
	H8OYyAJSELjo5nKDg+FDKDuyPEcRCXD+c0Qp17VECg==
X-ME-Sender: <xms:WbkYZ4LRjyJGfOYztJYWAdm43WwE0uqixUDPOkszomX-QJvHpVGSVQ>
    <xme:WbkYZ4IcRRULciQ3O39bc4wrPDqCi7fF6xyMgaYCJROvxVyYfmFpFShCL_EtrxAYG
    PzSwKc8seCMtO8a8Q>
X-ME-Received: <xmr:WbkYZ4tHQiEnEGX1Aq1-AkNKa5ZT4IqKH4Mbfwj816x1z8KpCukJvP-Oj-88LS77x5HqGQCe-M8QvDoF5KB5Xh9Z1OQrqZqkEzbGb60NpIbZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehushhm
    rghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WbkYZ1bEhng7AUgzEsN4JmjMNO4R3VkOtGw6OlopcqjYxdk4REFopA>
    <xmx:WbkYZ_agUjXF5G_HEWLFAme3vPjM3xDWJtvP8xFb60JaZLX6sic-VQ>
    <xmx:WbkYZxApeihnlN3UG2FOhq6WBjTGNlOZEr2RXZGUbUtJjgN-hc1pAQ>
    <xmx:WbkYZ1ZtRSoELG-KYXC57A16H07Wtolwv7fUqb94cTHECNvBh6C9Zg>
    <xmx:WbkYZ-UQOx6ua-_blsq1GNP_llKfvSt4InTvV8T-Xa8a2ABjaTfnsqwE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 04:52:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6312b20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 08:51:06 +0000 (UTC)
Date: Wed, 23 Oct 2024 10:52:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v5 0/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <Zxi5TeHM9qD3lrbx@pks.im>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>

On Wed, Oct 23, 2024 at 07:40:17AM +0000, Usman Akinyemi via GitGitGadget wrote:
> Changes from Version 4:
> 
>  * Fix incorrect indentation and remove unnecessary braces to avoid
>    confusion.

Thanks, this version looks good to me!

Patrick
