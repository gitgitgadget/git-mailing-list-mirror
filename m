Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336A2F0692
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711316; cv=none; b=AujpQLsLS0WiyykfDcgyT4VrGqhqJcheBUF2+ZNx8ZITAZzNA8Vi63MICg3AwOIsq8B11EAuoV7lNbPrOMOMdXv+GB2IZA7qpw7ztjL581Vw0t9kdzxDdwfJcS6ZsdsL9I5k6ERq23Ku+HGfVTJT+cIBerdDLY7+DGeCEYMZVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711316; c=relaxed/simple;
	bh=zv9Ne2AgLjV+I75Jp4qZ7rVN6WsU6w5swI8wQ2i5sZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riZ+f2z6ELoCqX0plBEdrTOrvzxqqAHTpxmDvtUbPmRciftKgksI4F6aKQaZSKSO1MsLTs9o5H60EWpzCs/1+ZKmXR0rpElHE7CWYO9TxBdDNQOdvzszyI/52rPufsaZGbjRYs5C/rWMlrWu3l6XpCELJ2zicyOA9W/Q+K9Hv+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JiptLMPf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvVAhpgB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JiptLMPf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvVAhpgB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09C017A021D;
	Fri, 21 Nov 2025 02:48:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 02:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763711313; x=1763797713; bh=x+Kk7O5T5T
	MfNMuD/i/pzck5B/gc57lw+xxzSHvlupo=; b=JiptLMPf9rBAZDP7td++V3G2Wv
	T4Jm5H1J7iqh9/5DhnUWpF/2RLQF4y0LBQvRrwsJqU6dTQaAERcxonwGWnB0aEgw
	p4HaS3A/pmpBpntMQ7Lj6eCgjTTinL2sQ6hrhou3qdbRqYkfHFQTfu6PS6UhnrQX
	uQEhKFWngoLJGln22mZTUTZNdFy4nG/mbjN1NjXJhMfhRaJZ8Vd5RZbHpOfIo5rm
	5BO5X+S0T3vE7kVyMNsn/Yl06SkMuYr5TPn/R4DTrwQ4kKBZiSBcH1ORiIwcfAL3
	s1b9ZssmpsOHusX2gLcZDTsPBErlyUYQfG+DCpncXHewyiDTSY7twpR8Wo5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763711313; x=1763797713; bh=x+Kk7O5T5TMfNMuD/i/pzck5B/gc57lw+xx
	zSHvlupo=; b=mvVAhpgBThSVX+Dt9mAOdJL6UzT9VZ6jQrl8mf6NPTS9oKwgtiE
	KWe2aFV/FNvy/1v6wEaAZQLMaGgEYoom/IOtNCgI5FeC2c+aWPozTGYaeNqZJMbj
	SCyYfNh+EOjCsvVKnvfVsSmfX0HyXYbfB9ySiImFnS+7oESBituv/H82guPvwubh
	kp79T7vUapWLfJ0Qt6r1QJMJaKq70eeXyCqSgkhuUlaRGnbgSIcUCu2PL2y+pLH/
	I8lLkDcBGoVxlPRaFroCCLQ/9TOwdnRTh8aIVfdrDqIwdEbB2gk6EQXV30wKSJdn
	1hV1Ih/uUU0pgp+nm2/81Y53N7rBu+R/aWA==
X-ME-Sender: <xms:URkgac6N5H5WuIy5IHtOmlswiJ8HW-jqKOVqFBuF8zTGr1R6-CIs6Q>
    <xme:URkgaT4UM5Us5kWs-ZLdj01CxeDCTtL5mG4xGuuKWvl9JvYFpR1EO2XvCtpkg3wpO
    kcz8p0i0mzcgn5_A4VKPlLAkaK5Rd-8DyFQZw4g0t1K_fS5FZck>
X-ME-Received: <xmr:URkgaZFIYAyNoaVL58loGC8mZOY7NeHGAjdZ7iMD2TN2pctgyg7-TEoviVcLdwBh8ECGF0217I7j6lMsGZDqbIpGnBd8bVMrDKlCy9MsMmN7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:URkgacR0t5EVDwBqzGSZ38TjxqjI19ymodXHL48zS-Nxek5OLkIjmA>
    <xmx:URkgaStNe2Rf574PJSwjE9KEldKTsXcvxyn-8a8UeLtjJN9SgJAHyg>
    <xmx:URkgabxoEJvRu64Oif5nOsW220X9Sjmq2vOnfkJpFHF-Y7se0U9fSw>
    <xmx:URkgac4y-jREhA_148xQpq7Mcej4OhVUhITvKwD1wlUrf48WJwrvlQ>
    <xmx:URkgaQSbSkY9Ch4PcfpSoM98OzCk3C1gkyleWuxtQtH76LVnWD0H_JSl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:48:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 723dc07c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:48:31 +0000 (UTC)
Date: Fri, 21 Nov 2025 08:48:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/13] odb: move logic to disable ref updates into repo
Message-ID: <aSAZSyUzIMvn-IvR@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
 <20251119-b4-pks-odb-creation-v1-5-2b2ed2612cb6@pks.im>
 <xmqqcy5dbvay.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy5dbvay.fsf@gitster.g>

On Wed, Nov 19, 2025 at 12:51:17PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > ...
> > somewhat misdesigned:
> >
> >   - We can have multiple ODB sources, but only the currently active
> >     source inhibits reference updates.
> >
> >   - We're mixing concerns of the refbd with the ODB.
> 
> "refbd" -> "refdb"?

Ah, yes. Fixed locally, thanks!

Patrick
