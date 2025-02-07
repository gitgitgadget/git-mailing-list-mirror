Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5C1A4F12
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929032; cv=none; b=OIeuYJKcVMfbX7cMz+9jlhckSEDP9JPIJr/kwho2DsNLQ2caddJpSPybzwc9VEDVa33A4o3ymBlrzZcXLZiJUV87eYMIOJi1HSicwisolbuYfXOcjhn8oAaIemnFneeWLczlq/Mk6ocwt++1xrtHzfWvoCIu7eJT3fElMtMoqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929032; c=relaxed/simple;
	bh=J3fwXcT+RrSxIU5eNEIV62Q8F3LpC6IjWRITAITS4AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/uNjOsbKue0HjTSq7HBZqdIAqbQDihN5H1glLDA6TcWVvUmfykRSs4m9jMvoPrDkAgabmSYz+k/eVaYBWghxDTtTRKzRdwDjvja/CQ6t+vU69HTFx7waAEUg6TTaFFJaujJwZndnCjwMNH+XvJ7WdiVLDx/K2+0boUVvotUuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BskemBQe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoG/kcnK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BskemBQe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoG/kcnK"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AEE1C13802EA;
	Fri,  7 Feb 2025 06:50:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738929029; x=1739015429; bh=UtoftOIaGc
	kKMKMXjHbwdwHckhxMI3TNncctpozZX6k=; b=BskemBQeREWnGKpWVVevMjwqFg
	uaqPxc1GWxZJ3xQ16Ul782rTPOEyBOqwRinrS/Q0/fbcbW+J8JmWV58pcwMI4g1t
	xUWRr2zSsLr8D6Vq6cXs0vWBozPi3DQoFK/z2qgN9ISSuPKXsLF1MeE9QPndp5p8
	mTZrWGdNbdLf6WyHbew14HDCo34gfXpH4WLzAE+HYECswxxpEp6lYXjvZK8bZT5T
	RG0lXbV2eBnhIz3VyS4GSBb+cKWr1SM5HxzzAR38nXBrQmauxNXAqfWXNmWD5Rcn
	twODQ8ujAKNPMYpx6Hpt6+xEUFb95gh1yc6jKT5V7t/HRizmiVNlorXvRzUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738929029; x=1739015429; bh=UtoftOIaGckKMKMXjHbwdwHckhxMI3TNncc
	tpozZX6k=; b=NoG/kcnK3RPWNWwALMeqoQZ0EVmRlnFoaM3TY+bSj4VKfQXugJl
	HP2qHGHiFxMfUM4QDuhMHyJ8exdfZPb8ZaSSWs2g57YbqInHanXf4JS8kG7Rpxyt
	58r1993rb9TW3pkajZgr1sBcyDeIzoiYTYdnqZLZfLy7PNpVr8zJTWqUq1T1yyF9
	qYrzr+fAJ4FjSUcZCNM7VmhvOLU1GZ0W+u6BF+q9fKFKQdvXVXUg0Hf7gYEMFE7v
	Db9UCRiVMBTOBJftnUBIBEQ3whQH0rzJtNoIHGiBJ4mjG0lfzaYtVovytYJKbc8h
	2WkYtE69cxFYkw9j7GOqxwTrHH1NSU6bPyQ==
X-ME-Sender: <xms:hPOlZ6Qka3rPM7gFVddJBwz7unqBbDOjy8fmoDDbA71vzY650TNcoQ>
    <xme:hPOlZ_wNsKnqpOVsJjLxB9vDQ0pn7o5_V2jZAHaB57E6fC3dZfc--BAt-Z4PDwgJ_
    m59Pc271fridV4Tjw>
X-ME-Received: <xmr:hPOlZ320NtAQsSpcluczJZdg1OFtbBRmGMJoAhqQ-IaKE3B37Iw1BUtmXxqktVKuQHUHP4f9pYoWd4GAeUvdG-936z6mdOwA03tK5jLqkNOhnpVt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegvthhhohhmshho
    nhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:hPOlZ2CTktsgwX0sN7rJHWMCc0X1VQTIRkvE8PyML021zyFpG8nigQ>
    <xmx:hPOlZzjElIZGcRBRMHBkXLXGiWQHD1gD7SVvUwfjpK9NpdakBQyd8Q>
    <xmx:hPOlZyp4KOoav3nanAXYZkgzmqSJi65OiNN8Dq4qwSBP93vPN0M8Pg>
    <xmx:hPOlZ2h3hrTy6LwjINPFV9bqTc0X2-oayY0920OwYaqvDWvPW1BYjg>
    <xmx:hfOlZ-X6OrHC4kY44knr7_0DAclhhayfkTVFEuRRHtRiq6GhSiZfZsEA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:50:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 370aa309 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:50:25 +0000 (UTC)
Date: Fri, 7 Feb 2025 12:50:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 14/18] reftable/basics: stop using `UNUSED` annotation
Message-ID: <Z6Xze8aEWbia8etK@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
 <20250206-pks-reftable-drop-git-compat-util-v4-14-603d276d5f95@pks.im>
 <87bjve3wd8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjve3wd8.fsf@iotcl.com>

On Fri, Feb 07, 2025 at 11:03:15AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Stop using the `UNUSED` annotation and replace it with a new
> > `REFTABLE_UNUSED` macro. The latter is a weaker guarantee compared to
> > `UNUSED` as it only suppresses unused parameters without generating a
> > warning in case a parameter marked as unused is in fact used. But it's
> > good enough, and by relaxing the behaviour a bit we avoid having to wire
> > up compiler-specific logic.
> 
> I see MAYBE_UNUSED is defined as `__attribute__((__unused__))`, which as
> far as I can tell is independent on the compiler, and has the same
> effect as the implementation in this patch. Would it make sense to use
> that defition instead? Or did you intentionally choose a statement that
> will sit on a separate line so it's more obviously that line needs to be
> deleted whenever the parameter is put in use?

Interesting. I was checking the definition of `UNUSED`, which depends on
the actual compiler we're using. But you're right, `MAYBE_UNUSED` is
defined unconditionally, so by that reasoning we should be able to use
it on all supported platforms indeed.

I'll revise this patch, thanks for noticing!

Patrick
