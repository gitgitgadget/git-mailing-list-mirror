Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110EE186A
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346042; cv=none; b=JzAdw02b38eNX/GvPiZMqIPPTAei32oknStQSsU4kteJwd8bOBG/T8OrwUF/yWRWqDpdWUbTPoklmoX1b2xk0qvnJ+MXdcEFwuu3sUVxESzA5xcWgJ0A4O/qyaY0pw9EWVpK68q1WoUmJq09PtmBieRJFEoijSmY25cWJ/NPpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346042; c=relaxed/simple;
	bh=+EjBNrkd8NJHJA5D2TwtyQLpfPetuNYCGZeh6KV18dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7EchIKULyk5Ixr2jBxNGlY+qH2eTN7pDu1iSALoe7+bOnhzZOKRP5eOXn7lFp5TOADuVqmEe+oEokTizs3nKBM3tLGX1+M0InRSSpXz9Xbs1LP95L+1lkRt2e95hPQb1nWN2blWxpsFn1HmhLxMDf3dnBwh1SfATodPV9eTZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dZ1MMGtw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8c3wa5o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dZ1MMGtw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8c3wa5o"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F21EAEC01CB;
	Wed, 10 Dec 2025 00:53:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 00:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765346037; x=1765432437; bh=+EjBNrkd8N
	JHJA5D2TwtyQLpfPetuNYCGZeh6KV18dc=; b=dZ1MMGtw6GggwzMNdb+/masJzV
	sLbpkwH6vq5zyIkKp4JBDaZBRX604E+kV5w0w+bG1nxXPYx5CkiIdwglA013DVpZ
	9rFHM0spNl1mTvJyAQw7B9NPFZLy5LqJga4MJUkeLQ1wBDpAA4nEJgjSmopS15eF
	6piUJwL2vyrHKvfy3tX83rMOaQXA+ewyRIJhm2K2wJ40Ld8GTc1jJ62iLYE3BK0h
	Kb/581pvUegP0cj1kzZjcGdYreNGAtOXJplaMFPMP7GlWXtRzdDJzqSwAnOTVPp2
	kbEJkpyAxSB2ACJaOVfyeW24AboEPDSlOS7txu4FycHAc6URshQgMHtVjbEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765346037; x=1765432437; bh=+EjBNrkd8NJHJA5D2TwtyQLpfPetuNYCGZe
	h6KV18dc=; b=X8c3wa5oJb6rAIGlH4LCJwtATkUu+uskPaCsjKQ3mh+wUdxCKSX
	A6YTeB27fBHmMA8J/1+h+oI1kVM1FXWuuMEGnhb/ttOHvtmH1UYjtd6dW2/omf80
	jtswYwflezuMPQi1iYGt0cSECW1Q6ytZIsekpE/P/KTKxC9F3+3ylE7i1tCHF+5i
	0WSHnPavTSTogNrKG/aqDfxv08ouoeA4bNxnEFEdl1sbsdhw8K2lUHnPhF7QB+n7
	coHme+svwRKVH0Uj6I3hxtuYrUztFE0OSI6t6SqALtjzVKhA2FluqjTe19trsVFY
	oud1xla8nShgMUDs12olRA4+gcMNF4Ruvpw==
X-ME-Sender: <xms:9Qo5ac08BW44JPV93tnMR_J-FoVtsasCC5C6sqpVc_qSrYl2zIdfOA>
    <xme:9Qo5adGwajglYv7fo7s6aTBKmtnzO_gGcXorx5ddMfCOa0-bRoS6VZb4ZY06qtDDg
    J6UYwzVsH2ieCYLmW9BsrH7N1-hYG67hScxq6SEdGAw1ue0ETYU3A>
X-ME-Received: <xmr:9Qo5aSgFPlPsXDoqGAZgcL1zRsUszsA8UdT-EvPt6wUXEnNiGAVQ9IG3IqN4uuwErf0G0FsuD94yn5CkaNVZGIvI27RO0FVImXiQ_G31m0bq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9Qo5aQ9rxMLXDVk5hegImcS4swRpdYbKV9kGuUh5LQfZ7GcXvoRbOA>
    <xmx:9Qo5aRqNawOcIrXPFRnCVGAATwIj0u2utIRlKuzhGaqtxYkNrXRGzA>
    <xmx:9Qo5aX9bIFNYhzp8HEW--j5B4FiCkG8ElQIacYwfK6fpr7po8hwD7w>
    <xmx:9Qo5adXBo82G0fJwa2h4WEKbMfDI6RMFMOHMobNLH3LkKieZpW_adA>
    <xmx:9Qo5aZl8PjPdgAoZN8bRhqVL1Z8dO6K76DrM9hcKYiVmF3GeBjJpwhe_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 00:53:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd86aabb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 05:53:55 +0000 (UTC)
Date: Wed, 10 Dec 2025 06:53:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] odb: resolve relative alternative paths when parsing
Message-ID: <aTkK79sZPkYQ87aS@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-2-e7ebb8b18c03@pks.im>
 <kz2eftlrmaxpxjybhjwqlewy3dx44sdznimzs6reoqtev4qtox@hl3s2gxz3sk2>
 <aTfYBGr-0SIDinYF@pks.im>
 <5lkaw3kfqzjt45jhomeb34cqu6nxigapmobtqrzpyoq7mh6655@3zgqsyfui23j>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5lkaw3kfqzjt45jhomeb34cqu6nxigapmobtqrzpyoq7mh6655@3zgqsyfui23j>

On Tue, Dec 09, 2025 at 12:06:09PM -0600, Justin Tobler wrote:
> On a semi-related note, part of me thinks it would be nice if alternate
> sources were a bit more first class in `struct object_database`. IOW,
> explicitly defining the primary and list of alternate sources
> separately. From the perspective of reading objects, having a single
> list of sources is nice, but when writing objects only the first source
> is used. This isn't too big of a deal, but certain operations like ODB
> trasactions will reorder the source list to change where objects get
> written to which feels a bit fragile to me. I guess another way to
> resolve this concern could be to change ODB transactions to use a
> separate mechanism though.

Agreed, especially the writing side is a bit weird, and reordering
sources when we create transactions is one of the weirdest parts. I
think this is out of scope for this patch series, but I certainly think
that we should address this by polishing the ODB transactions a bit
going forward.

Thanks!

Patrick
