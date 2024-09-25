Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8515AC4
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291851; cv=none; b=CHgxKLNHwsD0D1ysBKAQE092TMYUX0zFRJ0RXD/PJNqJ1HWTX911lHUPdahDLlzKrAnG73FYGEr82jK6bewbfx89WKCVCaAJD+x5IpBIxH+6ns+g8WptvtOLuhS9fGBJV5Ns57DgioPl6u+IosbVLTxWsRbozvbpa6sFP9VCIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291851; c=relaxed/simple;
	bh=23ajDEKoqUF3ADz7Jeo4PSKVn8jmVh7nTGgiz49FREs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGPvXsZf1t1eNXD4ONErnWwzuqat8U4P4tQKDRzQVz90OK3Zyv5Az+G97mSP/x0l4O1h3CXF79EVmiEitHNkjtxnW0SGgCWow50twhzXn7uzIW+vbXz0ycRKxZOcSjXvC5J9nmSeIDw/AYEMfep+45EavQTTBbvIJnTWAh1Y1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QOi0XsZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iud1h4RF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QOi0XsZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iud1h4RF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 278651140184;
	Wed, 25 Sep 2024 15:17:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 25 Sep 2024 15:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727291848; x=1727378248; bh=MKmmcs0e14
	Crd5Tf+tam31h60O4KSmnPUuP1NMFw+cQ=; b=QOi0XsZMOWcd/dDxoqtIhLaOQ2
	1wJLvsmsNOGBewlrNMqYohp1sK0uC3vMP3GXXW17k/Y7Z0mkMu9ezamm91Dog4p/
	Qbz53h9oXd6/tQMwIFU+qs/pBuHkDZoTA178riojqOU2sfk6ydLJRFKmhalHWqc1
	ayZbUSE4Zhu9tgEU3cNCOjqkj6+3l7sWBV6XLFQlTvQeeCxLZS6T0xDsMWLSzeUO
	8yHS/1w/2sC6KyTYnZmZK21t0lRNc+DaHWHmYxVKFwWlN9810/Vsnoo5fXRvnYPb
	KlGZFtNcRvk845y8WtE9mUQX0KOiRdXmks3XxkChcwaJBWs1riwAi2xReJBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727291848; x=1727378248; bh=MKmmcs0e14Crd5Tf+tam31h60O4K
	SmnPUuP1NMFw+cQ=; b=Iud1h4RFEksVW9hHVk4T8459wdrBRd53pcjoyWkxewWn
	+AxJyg0skB0SFsMpyg7zLrm4g4kSZPXsjDbhcUsVQqJjngJ79LAVx4vqs/opwY/7
	xtqrJ+02ofc3lVYPXIB63ztrdPniZ+WFBGzDuBSQaXXhlsLQ9rHeHSVio6cyZ8XJ
	t/56FZcO+qNlq6R2imAFQgQeJmDDk2ra41NWOzHZ49EbPypm8oRphidXG7IVna9T
	xSLWnf3TPaX8okPOaNTe+ycDqlOvZBjNi+CG4JpOl5yjpbMVueuJRhj52r4Y0zLP
	VpiVVHK30mZYpgVHQed+vAqorlLmNzEATEM3NInYNg==
X-ME-Sender: <xms:x2H0ZoGfcYhaVB7HvsIpvMfk21Bz26-HRVxmbc2Il183EK0BFSQlVw>
    <xme:x2H0ZhXskF77zYtleTNUbDLg6Gs8l4kfZo5Im9ZRbjEphEaoTx0vYimHhq4cPDHQe
    5THqrgZozym4XAABw>
X-ME-Received: <xmr:x2H0ZiK7i0jXwTPEWRpRB7-hQpY0GM8kjLlFaq75rn7laTfuKwV_4vjZg45zhllFXC0tiuPnZDVsy-veFH5RqgZgPgcCdPX2VF0PmBmjWM2T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohephhgvnhhrihhkrdhhohhlshhtsehouhhtlhhoohhkrdgt
    ohhm
X-ME-Proxy: <xmx:x2H0ZqGl2rGE4Vqh3rNfAO5Q1Vgvnazq1ajJ45uk1xrKOoO1P2nlcw>
    <xmx:x2H0ZuXvlrW18WehC7_UM6147ojHgy8TYJYekTfv1_EVxx11IRII3Q>
    <xmx:x2H0ZtN-ziqHVQm5UST34YEw4KDHa19XVI1XRJvqpRMp6b7Ne7qMHQ>
    <xmx:x2H0Zl0j_xaKKqX6RNuxK7A-hzufOZdd84SPYiqcicV6RZrSEfykxw>
    <xmx:yGH0ZpGlkfDs_fs-za4pVetIc_bY2hCAXN8XxUgKHEB-CKZ1JcfYazxL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 15:17:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0963a1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Sep 2024 19:16:49 +0000 (UTC)
Date: Wed, 25 Sep 2024 21:17:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZvRhwYgWZJb87TZj@pks.im>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
 <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
 <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im>
 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im>
 <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvRhUWcQL2hN4rWU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvRhUWcQL2hN4rWU@pks.im>

On Wed, Sep 25, 2024 at 09:15:36PM +0200, Patrick Steinhardt wrote:
> Hey Eli,
> 
> dropping the mailing list for a bit: I really want Meson to start become
> a thing in Git. I very much feel that the current build infrastructure
> is antiquated and has lots of issues. And while we do have CMake wired
> up somewhat already, it neither is a replacement due to it lacking heaps
> of features/autodetection, nor is it a direction I really want to go.

Well, so much for dropping the mailing list :P Anyway, it's not like
there's anything in here that I haven't already said in the context of
the Git contributor's summit.

Patrick
