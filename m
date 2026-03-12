Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F5373BF4
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298652; cv=none; b=Q1al7kKbiF2kWIBFhQsarwiZ8fyASJt3U4x7GjeANYmQSGyxqi1X276XWyONIOkFHvNjTwR8+6UK7+rjF5k14l/3un54RoJK1faEGZZvX1x4t02TMvfavqYXaAUHHci92SbsMzYgfXwg/QBKP4WbLGVqrLIZDq0hDXw5wJkOn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298652; c=relaxed/simple;
	bh=tWSNCImDArYVMOaIFal6BN0KQzPc4ybPowi1/zmdmJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIsp3hJ7+1doez5gum5R0F4tGnaVofoC+WsDjYp7vw87Xp+0njZeTi7yiVhzZI8VoAFkiYP7VbrvBhxNsFIAP07OvStLlPLwcg65dt78uezBditlI1fHpPjzbq64QB8YgfavLSu6yhaYt+xbC9tfZyxvXMBJ6iMm2PxGBPBjxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BisfR7Xm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uzZ4YMkD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BisfR7Xm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uzZ4YMkD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C2F16EC061C;
	Thu, 12 Mar 2026 02:57:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 02:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773298650; x=1773385050; bh=aoGoWk1adI
	SYYDC9z4CNtmNrirGZbCW/iuj7foUX7qc=; b=BisfR7Xmx9FZaGjYbXEB2o+k2s
	4/NMqHzR3oyq5xMjyNitFfXX/vxzoRDPRl60OPZE/ontfFwCtufZB82I97qv9ZoT
	yKSXINuq5Q5V+I1Q7fwn+AZvqlnDtPxVFoF69rIEg5jTVN4aPbjZr17eI5CmJGM2
	DsMNRjTBYmarLz67nyZeJZW2F+9hHkCei2A18qXRAoVSzRP3rYtlSjdpF9A4Pmwz
	3Ir028r8DcYr44/oplXNQKyAuH3cVKI7qd7lJu/OkS3Qle7dUx58RP0YQvSIT685
	pjL2I+RjcNedFy6HGng8lKkkGNOpjLEUCRJqPfD3qEJB1gHajQbmOzfNW3OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773298650; x=1773385050; bh=aoGoWk1adISYYDC9z4CNtmNrirGZbCW/iuj
	7foUX7qc=; b=uzZ4YMkDvpypZ56AsWPR6KYO1lZ6VLLhzC63+tJ6TAUyCEYuh1L
	0h61vNPxusJMlbw2WCATd9Ux7IuXLuP6asb+jdRSChdLtEdhL9qnop+V0fu/asde
	YYAzNykCw4nIjh7OOgfLt15Dg4LX/KIRgRgzhcKPSOq0WLjapRyoGDkMEPqwUKvj
	m7FI4ndJ4ZlULkPNXj27Khgn2Iu/K78Xrx0SZ1H+X8X5dbFM0r8SJuHpu2oMyf8x
	5T9mA6ABAE5Be7VvVj6QCAmA6o8IBpllMzUJV3jYgVW9/d1agw0IqfoZFX3nFtwy
	enaOEa6e3Y8csx/LXzzFrd57enOxv6cXCXA==
X-ME-Sender: <xms:2mOyaZrmuxXj4ozHlUvQk546X1hXdH0-O5XZd9iopGK3THW1beuZMg>
    <xme:2mOyaRoruwzP297UVvWJmOZAFAQHONK54RMVcRVewSqxLDnrUS1kbEcijDhpuKTuW
    TaK2jbPuRXx1zfJiIqy2TVZwS-3F1UCUVtwdlKUeGSh6lUKxpp56A>
X-ME-Received: <xmr:2mOyaT2sqxAZmOAGyWj6Mj8QyZ7KTG6Iajlc3TM4-zbc_HeUcgpk_SCfeeCZr2aiipJyP0yrjTMI8ZBx_ZJfEoT5O6S7Sjm7iXbL2NJB1i0e5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2mOyaQBt7St1HBzC_3-iI2_x5c9ZYAJ36aA8-dsG1uT3qTsxcVgK2Q>
    <xmx:2mOyabfmy2lPKTqaJHYMoWKjPIl7GTFkm8_U7LTd_vZcnB65Rgey1Q>
    <xmx:2mOyaViRZT0q_UPc2gSybyN8NaYCoqg96ZByoGTEUepfufRQFlIB_Q>
    <xmx:2mOyaTqliI2be9ez4F6LMADPfugrdjbkMcob_4Z7YvmWSsroLvaaxA>
    <xmx:2mOyadBJmkjD7LpDXSfvaSJOyMM9jPn8fnULXeIBErrnoe8G1-K-hXXS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 02:57:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2241198 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 06:57:28 +0000 (UTC)
Date: Thu, 12 Mar 2026 07:57:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb: introduce generic object counting
Message-ID: <abJj1THZrxtued7v@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-6-109e07d425f4@pks.im>
 <87fr66l6xh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fr66l6xh.fsf@iotcl.com>

On Wed, Mar 11, 2026 at 04:30:50PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.h b/odb.h
> > index e6057477f6..7b004f1cf4 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -112,8 +112,9 @@ struct object_database {
> >  	 * These two fields are not meant for direct access. Use
> >  	 * repo_approximate_object_count() instead.
> 
> This comment needs updating now.
> 
> Otherwise no comments here.

Good catch, will fix. Thanks!

Patrick
