Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961342E8B8A
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780760; cv=none; b=Sz3CMJ1LVHIbdXvEkRczz4Xly5cMWdcPAVTERQkr10csJg4wQv1/VYnHXYf00WFicQVqFcb1Iz79ePi7p+bYlNLnJha5DQ5oojlu4Qgbbgl5dER251XbDOiA2AFHIMAXjTSeDSqm+OjWWQKfhB8bzgO5Wk8mkrwmI8LunAmo/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780760; c=relaxed/simple;
	bh=aqdERfJbJu4NMbzkwqsUQ9dpsFXMYoNLl5+P7ipH5ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox9UTcpfbtCsSc7ndkcMvrB9hy2GwFV2rbE85BpJDfiXgR/H9rabWvK1ODQHs71eTE+MYHUkeeV6CyBhA/TOksD1vCU1z+r3O0GblsgAFvztzNq7V79cF+S3usfd1M3P3hWeJjFqCFYsbI1Wn15bkRQt0PtWktmt1MegwF8GoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SF4s2ClR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAUGq4Dn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SF4s2ClR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAUGq4Dn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7692E1D000CF;
	Thu, 25 Sep 2025 02:12:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 02:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758780756; x=1758867156; bh=RWAS2WIbrX
	vpHDtiWchGTpfdhmQPyFpD8XpLTRSCt4w=; b=SF4s2ClR+bFEu7uP88gYSoHfwP
	umxWEMl7diZ8x4B2iSBthUHUygMcH+VfyoUAPW/zZVDMzSuwprvzPO1lxxtsVu6g
	ZqYSnwqxelIc+WQptbtrNuhFzgbdLa2+rEAM2MzCXpRUG65xPUzihTXu2ppX68Np
	dTKgNzDlHkOh11f2Daeh+XtJEjxmaX6bdqtXA7h4GjQ/8PT6afPLTyrm6T8yU+XH
	mZThyx96K9kLZ/OQneN3YGD0+iwKUod3R81ome+EUBHQup3pRTFQkXLNdfwwAPeo
	NOBFxg9dio9zN03R2QRplaxJYJa9HPBPOc8PmcEKqEZUZZHqiG34x5HZppew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758780756; x=1758867156; bh=RWAS2WIbrXvpHDtiWchGTpfdhmQPyFpD8Xp
	LTRSCt4w=; b=oAUGq4DnpB472Bkm5X46z4PMsnModTYPjOuQV+IXz2V3Bbclp4O
	HNRxhopsgX0plnywsBSeAL38T8MrvYPH/HzmohUwoR2LT1GXYlItiXQM7YiDVzEA
	zMDH1kGrEpYVXIgQzoT6r2tkfSB0sRyhqYo1KU8W2oWuZ+fpUvUU1C/DmaFSCfxc
	OCeZD9Vpc/79/uPpgynUfUK8lwHSfSt6qD9IzKm14mljFkfO3mcmilKrmITnO9Mn
	8w2cgm6T9z7HNCMkctkM8ytHmm5a2hPdqzNf+Ph62nx/63ZWvOZKQQ62zcBHoa5h
	u8kIUhRCABLCikA9zylXgED6rfSrDRSV5lA==
X-ME-Sender: <xms:VN3UaPFXRrqa3M4kx8K9kXrbWJ_bN9sZHXQbz5-v6I__kxn3T-Yy2g>
    <xme:VN3UaDW4UPaIqz-3hD6G_TmGITqUpqEhY3k2y8sIldVxCLE2awKOLuh4WY4oOtwxV
    F6rPIEARE9I2ZTCsqFR9CkbpTgUulJ1unl5q8fAZaQrIntWj5A>
X-ME-Received: <xmr:VN3UaGIapJpFrfJBaBxcVXoBE8-m0uRIRSy8jVvf689yhNZ1uBkdjjsU0tTFhl5ivLbmRlL_OaLOal86JGbTT-ARCFsCUXQ44ZekPFzbljg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:VN3UaL9VC2-W8CzLSNJqPO8coODTYiYvTJFRCH2QMPwJuzmL2HlyeA>
    <xmx:VN3UaBJSMtK7okjrmZ8wxYiIta-sPWGmmB_Cw9dY2s-M_ZKTxGXpgA>
    <xmx:VN3UaIlrV0j7cCcOGvJSJuch-DjKGl6gogGoYuvj101nmeDC862QAA>
    <xmx:VN3UaNPyDNDYwHDvIRO641qFkWJv6d_r6XyyD5hM62Sr1VUTBYTXyA>
    <xmx:VN3UaBpP6QVQg_04S5LhErvR2YN9m3jU5GDtAZVaAO6s4eXDYYepSGlS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:12:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f94e2951 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:12:33 +0000 (UTC)
Date: Thu, 25 Sep 2025 08:12:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	shejialuo@gmail.com
Subject: Re: [PATCH v3 4/8] reftable: ensure tables in a stack use sequential
 update indices
Message-ID: <aNTdTu08kKugIr7j@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>
 <aNOHl65jYyoNXou_@pks.im>
 <CAOLa=ZTf7KL23+=Fggfg=4LXt1Dsd6nRCFg3q_Dhuom2Bk+L7A@mail.gmail.com>
 <xmqqikh7lob7.fsf@gitster.g>
 <CAOLa=ZQxM_iRMLoKt2ZoTSngkQ3EzXiJJ9hiJxRqHSaq2o0Nfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQxM_iRMLoKt2ZoTSngkQ3EzXiJJ9hiJxRqHSaq2o0Nfw@mail.gmail.com>

On Wed, Sep 24, 2025 at 01:13:51PM -0700, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> 
> >>> Now if we compact the second and the third table, the compaction will
> >>> realize that r2 is deleted and thus no longer needs to be part of the
> >>> compacted table. So the new state is:
> >>>
> >>>   - A base table with record r1 and update index r1.
> >>>   - The compacted table with record r3 with update index 3.
> >> ...
> >> However, I think your point  holds. I do think eventually we could
> >> optimize this to ensure that we do something like you described.
> >>
> >> I will make changes accordingly.
> >
> > If you allow gaps in the indices, it is a bit confusing to call them
> > "sequential"; "monotonically increasing" is less confusing and it
> > conveys the author's intention to allow gaps clear (otherwise the
> > author wouldn't be using such an awkward two-word phrase instead of
> > "sequencial").
> 
> Wouldn't 'monotonically increasing' suggest that
> prev_table.max_update_index can be equal to cur_table.min_update_index?
> I have locally changed it to 'ascending order' for similar reasons.

I guess the correct phrase here is "strictly monotonically increasing".

Patrick
