Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012D224B0E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665934; cv=none; b=l7ukUIH31YSRawLT0AFI4NLlAkSGHWr9sqCUcaiB+cp6Ip/LzOJNpsvDfRpqgILooj68lRaoidNu5QXFrTXX3uuNHTbaBUq8f9CTCeLJLiUjMX1mWODKDBSv1ql7v8tQ4iFzCGXGb0kfSSTz9eIOHt2mQ5yLDWH8Q6Zbcdf5Mxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665934; c=relaxed/simple;
	bh=2bAi/qLLCrX2Q2zEwal6h+rh/EVmyHAKBMsVwQ1Sk4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTykdvEiiqpWAyXV23r0OgIqh1D3rtY22ysWTKVyAebZZUSF4mu9SIaGyn7QTRauh2TaPIH44jKW33grb5hqEpg7G7fT1okb4kwmZ0G8rDfiQHz4nvJohmrg8Kp5JHz1LqOj0ShDrCQyL5sS5UPpqRAliiDLPyPG3+TSAfDKwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XznKeiCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJCoA4XH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XznKeiCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJCoA4XH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF3D11400394;
	Wed, 20 Aug 2025 00:58:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 Aug 2025 00:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755665931; x=1755752331; bh=Ayfue2yQge
	Ntzy2yWBHNn75ESKA7qpDm6RjyWq/X1gw=; b=XznKeiCvP7gdBr087YKiFlvl2t
	+uBDHQUqAsCbrIob7CjeNJ2Sddg/p02wt6IkWNtng6W166uKwjK9P+58K/MZond+
	2O7h0l5fo4DIDHWSax5GJt5UOrfdrQXPWrSQX9ahENXc2XPDJ6bo54+xGstUFgMH
	cJwKh8f39CmqZfpSdRe0YRAWhhWHYBbNHn/yrzBV7Nb+1QUkhFuGfWEkH1nGL3Ji
	ZVUikci7xH3XU84igqwRF9IJp5iZ8IWo3d54p1vmehETg5rsbnTh9fVPViKORTdz
	9DlRYYbrB9JZJe0B+1OYAz2KvzA00rdrHzg49yHHGQLXJb1q2D4PAqizImFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755665931; x=1755752331; bh=Ayfue2yQgeNtzy2yWBHNn75ESKA7qpDm6Rj
	yWq/X1gw=; b=JJCoA4XHtyyEj3Sw4r9r4RuyryOn/8VpT0Yug6jKF4dK3tJ6wFW
	LtLH+uxt0rFKA5iZ/zxtCy8HBJiKxYe5GBmhQ0leCD30V5+rPfo13Dh+9DHZAz7y
	jwJkLxVIu2KBNOu2tKqTBrnPwEseLVeEYcAd7+hjvb3oRn92DzfffsdNkSv6aQfg
	bCsQAVDWEzgv/fo4uaOpuS1+tkXHE9wTlgmjzUEhMl+pDDThGzThLBiv1/r75JTT
	qaFfGVB2U6J+WlTunPtLxJw8NO0fzBZHJnnZffdrtXlqJXHAsyWydMAr+iubSLQA
	+bvMHbknOqRzaGWR7K7Fvy7Wfa3HVWIc6Pw==
X-ME-Sender: <xms:C1alaLaLYY3TzXxxR6zIA68RsEKbgr_v5freDkz8zXhYALlE9NCniQ>
    <xme:C1alaKn2Hqqmvh4v1-BLa9bNTvJjdcYo5lt9tTavvy9LcyuuEkhOXLEoA5FDbvXc3
    a6xUSXG_sZTAYZblg>
X-ME-Received: <xmr:C1alaPwkcVogPf9TcoP1Qq68tBAgZMke4czKhAPzmUbUCBSLajT1QuLFf5fSPZEyGXoh0IoVjHasHG_Zowg3qpfm2rnpKQcQYzk_7VLv-Nnf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C1alaAOlfbO7-XIuPeDRRC6m_xdfRTwt36rOMUO5iR5aQqGDkmV42A>
    <xmx:C1alaLTfG6U7XJPEOLXSo0lbj3YBb6_sEsIYvkZ9SPZRrZCOai6Z5A>
    <xmx:C1alaGaqXoUQvMXnfJwxtvQbHkrPShoeR5jR0Tl2MDPaJoBhUlTL4w>
    <xmx:C1alaA0pQBIkl6Z9jLDVv2EBYljcnKsAMplms9en-D08kticPU16gA>
    <xmx:C1alaF-aQN63j5bjtr3z0K9fG-itCH527oXCad8B00l85rXNcRWmu-vE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 00:58:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fef02af3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 Aug 2025 04:58:50 +0000 (UTC)
Date: Wed, 20 Aug 2025 06:58:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/16] odb: move kept cache into `struct packfile_store`
Message-ID: <aKVWB0YAJlhbEUe8@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-6-1660842e125a@pks.im>
 <xmqq8qjfdts9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qjfdts9.fsf@gitster.g>

On Tue, Aug 19, 2025 at 11:56:54AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.h b/odb.h
> > index 2dc3bdc79d..f1736b067c 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -124,17 +124,10 @@ struct object_database {
> >  	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
> >  
> >  	/*
> > -	 * private data
> > -	 *
> > -	 * should only be accessed directly by packfile.c
> > +	 * Should only be accessed directly by packfile.c
> >  	 */
> 
> Hmph, would this be better done in the step [01/16]?  Or did the
> removal of kept_pack_cache make the last piece of "private data"
> disappear with this step?

Yeah, the latter. All packfile-related private data is now encapsulated
in `struct packfile_store`, so I felt like the comment became redundant
with this commit here.

I'll mention this in the commit message.

Patrick
