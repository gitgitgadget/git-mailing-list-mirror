Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CF2BB13
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735187; cv=none; b=E4tvyVJ5NnPa+3BwgCcdEdixjZXeKkpGq4dhQ/4jyL/KIGgADgIANc71DLBEQBOU0hZCBKvJKgVgQZROuf1cP6xEDG8/omTw3O6ZdP78gj3IF4/T/Q5jpHtPg7EEZb7Xm4RRTgZEO5jbGowCbCfC+4jq62T9KxmcxAriqykbJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735187; c=relaxed/simple;
	bh=LVYn2mwpjNajqmpx8caAXUnPHY10sw4xdm+IR7hzjr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK3a92h3lRzYRPZcLz6kkwePOu6e1Rqxb6ZZc26UVoNY2NTfqmr+hhK3fLfnRPBLagGfUPkHpAQmiSs6tmZHstFBOGv52D0CrUog3i9+K64ci38MVPJn7+Rh3W7HDuwKSePyum1q/HAOghL4Y9KjrwXos1R19SjGT+N9PkrcmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tYwa8/Ru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LcDDID6R; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tYwa8/Ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LcDDID6R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3904C1400015;
	Thu,  9 Apr 2026 07:46:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 07:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775735185; x=1775821585; bh=aIgqx7GGfs
	Ke1tkFCPL2XsJPtoL02sYAt7yIcVR8l4I=; b=tYwa8/RuW9VKAx/b2cpYVQRs5U
	fBnxlMLUOhR5VJg3liIEef0XSp05LZcXKohBJqR768YDgMrVz1svs/qSjquPx+eg
	njSeKoZZiVt/YPhiiK4qlpy6EpGAuncuuMrVk7AnFp0CBrw2LTqLHQ3ebN+YFsGN
	SvUojdvHbTEzpb4Lr7973yKQBIpYc/iL8vGNPjJk8vzOjuC74zO/IoYGNY+fhe84
	GpqpfU+wbaCRquvHdgjR6kW05/7VZBuelG/Z5Qpkom9Y+hKNRdZbkztPfgO3EWaq
	s78NbEPPgpx2HBedKLvfhzKYHEEqSQeRRGQzLKo/kRG6j7IJx8hA3Zjgreow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775735185; x=1775821585; bh=aIgqx7GGfsKe1tkFCPL2XsJPtoL02sYAt7y
	IcVR8l4I=; b=LcDDID6R3l6cAfGQn5B1inHT3h6QCzCAz+qBGx52nV/rKh4N/jQ
	SgZcaZsZqyNRFgGTwDg4jLyCUXh0lpZwMSBvwrJRpi/Zb00rL+UzK5MGoRf9DCvv
	+ioiWwcjfXPUNJfCtN4hQT2OWwwwyn84y31x+4261I/1uRVsUQhDgoaHR3bTyrzz
	S8it68viQ2LCUxzD/oRM8ohQODTqR4eq1geY3snxZAld+dxC4HFE4VmNX9WXmcsf
	iBJPsc7BfmljTnq5hyPSIncpr/ZwIttr7VFNDY9Rui5D0yYurwltu9VpMFUNxHYq
	q4ggI0edUZUDsJKvnQAaSvFfTXyoLGET/4g==
X-ME-Sender: <xms:kZHXaQ56J_x4okhcBd0F0r6waoC5ZWPAdUu0KvMzbd6k71Cul0bVIw>
    <xme:kZHXaY5MjuDeuaKqKdDqkZC0JDY19cM03XKAibLRK_60xPfYM5YatY5TzZDyfwYBf
    B0V-kH03NiepjqvYEE04MLugkZRe34fWHYneDqd1WfpbRHupMLh>
X-ME-Received: <xmr:kZHXaUc6MJrtyYYjasuIl6QT7BVjmjsWImyAEN3Gz5uvASnkhtIH4lwsGvY_uStYNK5cm54defewMQru8_XnRc7j51GDz7hyJftZqgjD1fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kZHXaUCoeB-y9k4QM3baRiIpcPDK0RGo3Oi-F8K5AFBrxZCh8N0vow>
    <xmx:kZHXaf9YyhXjYZxEafnC1l6XEGOErnnbxDB7kSrRd-dReVheRIv-Mg>
    <xmx:kZHXaXJMx4419WJiUfS8t3NVRQou2LkOC0OC2C5c8lw9dd4G3aiZXg>
    <xmx:kZHXaQgMjbY5I1xcwm4A9gZBqqx2Fm1sPLy6y1H6M4YvYivlr0ZBPA>
    <xmx:kZHXaT9f4agVX3YfV-TO_4yoJ1-VYnThWFt5p9KteY9htzqZo3Kv6pLx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 07:46:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84a1a70c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 11:46:22 +0000 (UTC)
Date: Thu, 9 Apr 2026 13:46:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 09/17] cbtree: allow using arbitrary wrapper
 structures for nodes
Message-ID: <adeRjBmWsRX1rLDi@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-9-f02b4f1c0f13@pks.im>
 <CAOLa=ZREniG1jkqk4SW6W1s6hLHh42fLQK+8tox59jprn2hPPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZREniG1jkqk4SW6W1s6hLHh42fLQK+8tox59jprn2hPPg@mail.gmail.com>

On Thu, Apr 09, 2026 at 07:36:50AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/cbtree.h b/cbtree.h
> > index c374b1b3db..3ce0d6b287 100644
> > --- a/cbtree.h
> > +++ b/cbtree.h
> > @@ -23,18 +23,19 @@ struct cb_node {
> >  	 */
> >  	uint32_t byte;
> >  	uint8_t otherbits;
> > -	uint8_t k[FLEX_ARRAY]; /* arbitrary data, unaligned */
> >  };
> >
> 
> Seems like we need to update the comments at the top of the header file
> which still talks about this field.

Good eyes, will adapt.

Patrick
