Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44338D00E
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002620; cv=none; b=uty1TPTr0Bw3n2qANwsHk0u1/mVDVDcSwrjP/pCruVFtFtKdXSOjX4bGy8/wAwlEf40NT5EsbpJ2Sp7J+g4Rs0LfbtNYI/pyNwkdiZnWw9ghNNax597hiHpccriBnX6J3eV8S0+v/oNJmpSGROntA/2P+E989tBPBpOhfNN9nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002620; c=relaxed/simple;
	bh=yZtk8WrgLj1h3bmbMeTi/PI+CoS5tseNjwic1paCV2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/hathuf2VeLw8D2ikTJUb+FnyJYvBNmL2k2C2TU02gp4Iqm4zw2G/UZbE5NOrlFGCLs679xkMTwfMoMLYTv75vwgpuxVpJDkKgB23teaCwjDd0evWUqdSdxkc3nt4y4fXQNe9ec2zqOiuPbq+3bi4e+4bgpd/Hs/3BB8WVh2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JPs0/Ll+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xBBNAxG0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JPs0/Ll+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xBBNAxG0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D08AEC01DC;
	Fri, 20 Mar 2026 06:30:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 06:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774002618; x=1774089018; bh=qyU7HnBIXs
	uCipBwc7dk1FBR/hogutbrqlHxXOxrKrE=; b=JPs0/Ll+ykcO6Q71jTLrJNt7pV
	66hyLJkcrpTf0X3kUibR29LWzRPqPMyeCmQTu3cW20Zn70GENTpzYn9HG320MU05
	BaO7D5N88H+bd9w63CMphXuYYvMUjn2F5j52ycwLPs779oW9X+AaYCjdjAm754Sc
	6vUj8QYJqo/GY3/1plR9I4TKYW3SMAu19Seitp0lVdO2jCO2gUHtBIXOWYdOkKk8
	LX1JqgySGsDcg/074SZx9mppTPhnJZ+DSoYOY71lMmhod/7DaPK5HgVGW4NGqhyf
	V07D8Ea3HDtkg094s24Z66acxP4A6BwWbRwbXnRrXyfQ4FGQFEG9iIxB+4Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774002618; x=1774089018; bh=qyU7HnBIXsuCipBwc7dk1FBR/hogutbrqlH
	xXOxrKrE=; b=xBBNAxG0w5NEHn0mk0EBAntHAohDxdO1WWwzfi8EE3um7oAisDj
	MQpNQrNpE3DRetJOgEITK0sEg7wOFC+48xHxRLtKk7FflpAPzuvQoM7sWZtLL8Yi
	q0yvn82TL3h/yiDTQeDMpXLa+eNYnPK0e2wBu3tSChmpoZ+nC9FKh8HrF7lW0Mur
	0nGbZrdJBbaYmz9M/1fbdSg13yLcc9Zj01EMTLWG6yaH9Uh+mfZ4mRGa+xluz8Nv
	wlQkGjqK3aDOoynejRoHzBoTzHjST17cYIWy8VMDpZe4dUJFtC4KyKS6RTCmxyv4
	POBsQc/ASpRMQv4CbcXEZMah/K19T6E/bYQ==
X-ME-Sender: <xms:uSG9aVE587H1wIw1I0xcw1tYt4CyRt4h6F8jtp1hHB4sQKX1UYunsg>
    <xme:uSG9aQXNTTcj3ai-rM9bNt2pGrgt2oJufQXAjO0x8CC8eiBmk4c9E6SnBPOXkgbKf
    6Q5VbSzYND1oNl0pJsXGEA-ozvIRd9U5dMf-x38FLSXUIeFlGB7>
X-ME-Received: <xmr:uSG9aUy_N_1Qku50kh6Swlnz4cpCcR4Rq2Vsz1pQ7sqe6qieOPbNxancA6g-v-m_UeEl3apAsY2qpwU6JuWDgEdiYecVUVbB_4vigeYGsGEn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uSG9aWMEhVD0cKs6Hkk-rNSzX40ApwauMAKSa-o9Qo6G67zAm5I-0Q>
    <xmx:uSG9ad5NnplKyGEbdi7-4uesNLdBpxMPlVMNwlhHyjFw3vkti0zRow>
    <xmx:uSG9afOGnIyLh0ZUZBWQPuedBn0Zhmc57KeKyEp0pGsNWL6aHcy5GQ>
    <xmx:uSG9aTl6fH06xNMqT7WHuxlALwAFIYCVAjVLwiqvGgLMQmQHA-ygrg>
    <xmx:uiG9aV2h-arVJN-ENNa4qdaXMuYcw1i9cqo-T8B5vVUY9QULTJVuTHFJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 06:30:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7db26006 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 10:30:15 +0000 (UTC)
Date: Fri, 20 Mar 2026 11:30:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/14] object-name: simplify computing common prefixes
Message-ID: <ab0htJ0fafNdsXeR@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260319-b4-pks-odb-source-abbrev-v1-11-5ddebad292b0@pks.im>
 <CAOLa=ZRU3=FqDo8SiJ=+qTsU79NEfoyAVp1uZYBX57SNPTZomw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRU3=FqDo8SiJ=+qTsU79NEfoyAVp1uZYBX57SNPTZomw@mail.gmail.com>

On Fri, Mar 20, 2026 at 03:01:48AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/hash.c b/hash.c
> > index 553f2008ea..e925b9754e 100644
> > --- a/hash.c
> > +++ b/hash.c
> > @@ -317,3 +317,21 @@ const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop)
> >  	/* Otherwise use the default one. */
> >  	return algop;
> >  }
> > +
> > +unsigned oid_common_prefix_hexlen(const struct object_id *a,
> > +				  const struct object_id *b)
> > +{
> > +	unsigned rawsz = hash_algos[a->algo].rawsz;
> > +
> > +	for (unsigned i = 0; i < rawsz; i++) {
> > +		if (a->hash[i] == b->hash[i])
> > +			continue;
> > +
> 
> Instead of transforming the bytes into 2 hex components we now compare
> the bytes themselves and perhaps then compare parts of it?

Yes, exactly. It should be more performant overall compared to first
converting to their respective hex presentations, even though I doubt it
really matters in practice.

> > +		if ((a->hash[i] ^ b->hash[i]) & 0xf0)
> 
> Okay so if the 4 MSB are the same then we end up here and return i * 2.
> Makes sense.
> 
> > +			return i * 2;
> > +		else
> > +			return i * 2 + 1;
> 
> If not, its the 4 LSB.

Yup.

Thanks!

Patrick
