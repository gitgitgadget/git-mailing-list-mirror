Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D771EA7FF
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372292; cv=none; b=Da400nJz4f1sien3v+un4hRFNPlJ3bL9cKdbX8FzRkX7qKWWkclzpuYxssovTT6mwxBrh3JD49d6dWTMnFKSHrJWHjvFq2KvXjdmvI3nLNWtFcByCtJMqCEEHMNBbuCi7pHEiELboZN0gZXUdgbJxXCxgV3Uw3W+ETjq+wIWzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372292; c=relaxed/simple;
	bh=BAEp99Lsgq+SVl5iLJs/Ko4KJ/FY728HPSdOvfL77zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwvV9QpHi/Bnd37Ov8WOFlaO/Jd6NoWlpvGuPLKJ2CMJUBriewWQrb4oKrOYoB21F9vYHkXgwkwXo8v00Oh5lPKK0r5xzpiqpKb6x8Fy/+XvxCQ6bEwiSvVZWL5iKeAbnqO+wZuVh/XU7rSZ25c3Hq2gaUUwCOKG9KLrcbRxfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JInteKd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gR9sxtMc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JInteKd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gR9sxtMc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA9281400207;
	Tue,  1 Jul 2025 08:18:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 08:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751372289; x=1751458689; bh=ObQ/ET9QNu
	9zEVfIxYmlsCWdtxpSD6wJFck+ldMF4h4=; b=JInteKd7Km8iJoOLXZ54HOheUP
	AvhGuXnqfFdZ9Z5/tfjvn74z4GlCbaC9/vfkmnTRlGTLdnYY6vNrgDNfBJyuqDVg
	l6hdMoB9p26d5higDHQmZ3yi+m2urj1kU/68ERI2rZGKA3egOXDIY4U6m2cYh6kK
	rIIbrNUDl5Z/aHDmkWcak8YIGb2aGfmJ2M/RR8TB/gMWuJapG6wDMA4Jqjipn9OP
	vgKvJuCCI0euZScnO3MDI1/8Ftts/9bs8ofCG4pH8Q8KiDfKeYzTvUz+7mSJynwI
	La4oL7rtwxzE7+M5C7JDyA6lmmHZSZCoWJXb3btUIvpCQPfDz9sQnYN8iuCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751372289; x=1751458689; bh=ObQ/ET9QNu9zEVfIxYmlsCWdtxpSD6wJFck
	+ldMF4h4=; b=gR9sxtMc3ICzljNdxdj06zn8oVZVxhdYrmC262vXca2+4DOxR1R
	+leKUTzwqDX6jZZIJsHZ9drLUdLYe49sfHED2c2Tif5Alj0vbrbPms4/V+WPrIXM
	XK/iYRHomYMTPUqWhGbU7v7OirP7lwqZPnGTdhycptx4N7HabkjmB3ue/kalWA91
	s+9mc6Or8NbhxGL3kr1RmzWBdeSveg2tWPjaQHWJ/RWZi8jOJ9DT/pic0auGTDy7
	eR/K46gCClnDHTueURVsH74fF74ruattXWWyczqrHTW7by/NmEJynF7RsZ3vyvIf
	CaR+5jQ7lXeQZI8dBoG2cgEKXfqYGtK2KRQ==
X-ME-Sender: <xms:AdJjaMKeOcVBoAJ3P4ntOadzuap5DgXpr54WDQNBkMYcRfcPeOViFQ>
    <xme:AdJjaMIA-ZwzRRaMtXbZ_Cj77UZ1Iq5CmzkaHk5Wn1ZNRruuOjTyzTdxttGugZgvr
    kD9Aa6Vh79ufezaKw>
X-ME-Received: <xmr:AdJjaMv263LYXfHALVKnhg-vHaZ35r44jwVw4zroEdHbqMV12FALi-vy9OUoiaie-oT17TDYT6S6_WcXDSR4kAvt8Skc_mvQ79q27pBkjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AdJjaJbiOcD4tIWFyWLJnHCggfBMDQ60yFqVqUMVg7SLy6Hb7OGiBw>
    <xmx:AdJjaDYCxAxL-ghzmRbU4a2S33zyktmjz5VslnmqQCzF42IdPKaecA>
    <xmx:AdJjaFARIOgKnh_WsTMaNHMGFR1VtFG4UAa_5RaTqaSWni_6q13jYA>
    <xmx:AdJjaJbQkm2QraVYg2kTwuAoqO9YiiGWl0Cs4yT70-6rxhaWRxltBA>
    <xmx:AdJjaMD-Szi69bP4QWeuXF3FCIprC3Pd_RrgfsXLqn7ylOMgAtUUSlHX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:18:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9592b7d9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:18:07 +0000 (UTC)
Date: Tue, 1 Jul 2025 14:18:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 08/17] odb: get rid of `the_repository` when handling
 alternates
Message-ID: <aGPR_L__pP-4gBJl@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-8-779d1c28774b@pks.im>
 <zsrwwg5mhxx7xk53i7czza5sageivnm2hxj5nlvunpe4gzrrjq@n5ne6qwovyom>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zsrwwg5mhxx7xk53i7czza5sageivnm2hxj5nlvunpe4gzrrjq@n5ne6qwovyom>

On Sun, Jun 29, 2025 at 09:56:05PM -0500, Justin Tobler wrote:
> On 25/06/05 08:46AM, Patrick Steinhardt wrote:
> > all callers. The functions are renamed accordingly.
> > 
> > Note that right now the situation is still somewhat weird because we end
> > up using the path provided by the object store's repository anyway. This
> > will be adapted over time though so that we instead store the path to
> > the primary object directory in the object database itself.
> 
> Just to clarify, are we walking about the path to the alternate odb? I'm
> not quite sure I follow.

Yeah, this is phrased a bit weirdly. What I wanted to say is that we
basically end up using `repo_git_path(odb->repo, ...)` anyway, so we
could have just passed in the repository itself.

I'll rephrase the commit message a bit.

Patrick
