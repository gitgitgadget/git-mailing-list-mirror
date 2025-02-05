Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93721D58C
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738741640; cv=none; b=dbUnKwnggF7Hk+4zpw80m482Zg44yIqGojefdSlVGpslto4QbtoR99cxeJmsd0pGgJd+CvA1OTJpq+GYEPBS9jq/2BFoerEGzJSNl0sCH/vOwOiFF95HXQoFzsdRPt+i+s44gea2a258NcZzLQLhlO+q/DREY80paEEHD4W4kKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738741640; c=relaxed/simple;
	bh=Czfh5ySbek/7IT5m2ojA+o9xSQMYr4R7EK3Ka2yGWqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+waCIDKgKDaAadam3gzTfyqf8gikhlSbJ5AxLQEn4D7BZSb5Cx8I1N8akwIrRjUBAorRC01u1Vq9UlBRVdv21uRQ36T3qJ8mSL6bznKLPmA4A5JyMboL22dsnXcbAeeRYoHXRH71UajnKF2JKQFXR84LR+obmDk5eOYCcGqBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ob/RO+bQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BULLZK9p; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ob/RO+bQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BULLZK9p"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F463138020A;
	Wed,  5 Feb 2025 02:47:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 02:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738741638; x=1738828038; bh=xlMYGpWruw
	widZv49C9RdSVHNsBltbB8iuwZxDb32cE=; b=Ob/RO+bQQdaq4gPCN5fPiSxe4l
	WBXKHrT80NSWWQYP2HQA7AweZK1vQ3V+IQ/mCAjUTxrW6nPy1XFL4NlApd8fBt1M
	Axz5/5oIa2rhuytXdUO/BCCu3MePypTFXK5SKVIGePHACwFkQjRUnXUKnXvQbaJn
	gLdoxdMgYp9I7MbfLjJ8g548F5Wc0A8ggBXLOuo+r3VyupWFU9m7z2y58kdrL3Ae
	LEdIkdoVH/442rb544+uFczcE64QjYpnWxgcpqJMhZYta4DNsfRoGGFrEG+nSIoD
	GgrZmTBaPkayBgWEBxDkAgdQoG8++CNFse2bp+5ueku2A892idcpDeLRLw+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738741638; x=1738828038; bh=xlMYGpWruwwidZv49C9RdSVHNsBltbB8iuw
	ZxDb32cE=; b=BULLZK9ppUb7UR1muwViMD7jse6NsqdA/2gr1eyGfsby4q6rlMp
	qNL4GZ8SBvIRwITVus6N4c4n4PrHcMug9PF7q5m9JgFCa1Feh8WepamUNzq0lORi
	LC0GEfB448CzMAHHG5xhgctwLqu2Dll+bYv4mojUC6thjAj+y2vnohq+vswDW932
	2vgfmdoVHLjSjwUhU05+33Nr3XzRqkDVOFowayHrfbP0/LxJQMs4lmLDDSOjRlCG
	IMqPAxMb79HVOka5a8QDmXugbZop8oQABBMMJzdYhJQJ8AsTqadlF1h27D+AV0c3
	yUE4W10rI2eD6CdbhOlXLESlgrmnsuG/9BQ==
X-ME-Sender: <xms:hhejZ6Y04s_gkLRLRPL5DrDCyJ8fTsZwcJbC9jmxetyBq1iY7D4GYg>
    <xme:hhejZ9aqm4NKxRZTq3mxrg_XT098m7HDVswqS5NBMiZQiizwlu-pCFZkRf2PLMB0t
    sXF-WfP4y5d1cfpQQ>
X-ME-Received: <xmr:hhejZ09ZbO3xLomWgR5_JjGfOnc4fQJgrIS5r3ltXdXzI_0Ndqkx1SGknAeInP3XT90C7GlQ7JpomyLKxix-N3PaSJsphB23GC8tnmjtny2Jzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjvghllhihrdiihhgrohdrgedvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hhejZ8psFov0EcKZ_SpPCeVAJhT_UGJihXnxcczgqZLsYpq5g2b31g>
    <xmx:hhejZ1qSxRAppI4kK6H0wB5BU9YrdL-Tspdbg-9qMZpxsMDNBu96pg>
    <xmx:hhejZ6TIeh3rsttEyuDn0b1HMA43ql9VxTi5tI8LKXBJeeofQjFBEQ>
    <xmx:hhejZ1pXWH_Er1wn38QKP6uLKsyOA6j3nIkrcy4EuMJURbYjM-3Mbg>
    <xmx:hhejZ83QKqmap1NVe3FqPBjucO_QDrQlduiE_WhsMBRUUuxmY3XI9J3r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 02:47:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 13af466a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 07:47:16 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:47:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC] Introduction and microproject selection
Message-ID: <Z6MXg0lzoioTew-g@pks.im>
References: <CAKfgWeZ5GSySF1N2oxoKJLnzeXOjyBh_DbhdFywXiv9L-JaRgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfgWeZ5GSySF1N2oxoKJLnzeXOjyBh_DbhdFywXiv9L-JaRgA@mail.gmail.com>

On Wed, Feb 05, 2025 at 01:50:49AM +0800, Zejun Zhao wrote:
> Hi everyone,
> 
> I'm Zejun Zhao, currently a first-year MSc student in Computer
> Science. I love the idea of open source and have contributed to
> several open source projects mostly about OS kernels.

Welcome to the community, and thanks for showing interest!

[snip]
> Please let me know if I had anything wrong or there is any other
> point that I should look into to do better. Any feedback or guidance
> is appreciated.

I see you've already sent a patch, so I'll be reviewing that patch
instead of answering here.

Patrick
