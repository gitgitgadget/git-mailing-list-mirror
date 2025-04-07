Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF5248896
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029081; cv=none; b=MFvI2+Q7t9ZHuG+92404Fpnal7/Abb+Kuk15Xm23Dy/heHbVYiaDu5PYW6B58OcDIOA4rSvWCebOu3BDxpzX4bJRJUeR4tKKMEy7PMN+jK+8F+ukO2S4/oiUr9EflOu3keBkt0TpIGC5irCI1g1augt5780gyOSM2rD73oaohYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029081; c=relaxed/simple;
	bh=FKGbYh10IlIdzz0aDxNpTx6zhSylbCSFECe95p51cys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucs3uqYJ2yVBGWPqQHqZcPpDPceRagyzx95FDRp7VgwsYyyFzkYNJ8sN/HgOa8/oTsWAYcOnpqhcvh/znaSQT2fS5fvE2go+UpFuvrNyYYsG3QbWjX0/BS/rZQiRYOPzZu1pPtJKo+whFqnrLHGDoOYTEvx+Qn5wj1bwokSYE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m1OPkR/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeGftZ77; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m1OPkR/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeGftZ77"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 74BAF1380116;
	Mon,  7 Apr 2025 08:31:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 07 Apr 2025 08:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744029077; x=1744115477; bh=IJ7Hgi0T/S
	K6Nj5QBf0b+7lngjAcgWtrfdJQm02Mvw0=; b=m1OPkR/xeymsy2sEW9cAMmzKqv
	7f97jsTsrQYNnPgVZsWBnhmF5YQovB+UXn5GhoP1G3ir6kOZbdMVGHd2TwgXRWO8
	6xBdZk4jMofKFG1LiQRO/Dy9nsuB5lKvGNtRvYK9Sbnm6R/KLc7rV1Ash04XVpCh
	/iW2WQqqpJGG4MsLc4vs6dXTbdG0gVxcYM26+oCH0UTFUQwKvx7YzY1aUHlda3m6
	6aWNlMPZrk4FY6jMX7Ennf6VwnG7b3LKr+67Moyvnng+XSLKj7Lm9ojDgPwIzVei
	hHkmR0cq4BYOtQ2s7Zqf0VQgZUOgkRUvG/OnbrQSam200GZjnfKfQ5WwmaAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744029077; x=1744115477; bh=IJ7Hgi0T/SK6Nj5QBf0b+7lngjAcgWtrfdJ
	Qm02Mvw0=; b=FeGftZ77j44dSQeVmSqR9yjA/NEupKfZa0wN4oQy8qNhvWnvug3
	V4t3NkYtD+hIRT7XW/e8EeBrEoL8TOUq6hUkewOCSuhMkVZ+yWHUvOBe2g5REnAk
	MIx5h0mo4+2k1lKQvW9/Ycm07+0EKpXmYpuQdle1x7Fk3hzTlqo+VlXQ+3E33a+R
	RldnB6AASeUIFHVn4VKlOyakmClddODkq4ftcCFBZwQYvmw10EpYCRmhzepGQmQc
	6cYhnli1aqgb3ySaxq0qUHgnKqBRvIpu00JI4fboAW2idvM8SgagjU7pZLEmPQCg
	Wzx7W49yEeha0P4sXFMq3uEbNkgqn9zyCZQ==
X-ME-Sender: <xms:lcXzZ9UeDwIKmn7BqmUiYf7P5LS0KFpohmMgnBCjUNMpAKJAqpONyw>
    <xme:lcXzZ9madeDE7kFW7Z0UhGI58UbCIaGmy4vn1iYCVbPegMUruPR2pDJSP12rtJRu5
    bJShIiDD9b3MBAz-A>
X-ME-Received: <xmr:lcXzZ5Y8niBcuAzrMH5Er5ek-Bvgj07dqWy8BWzPd7nso_9yJZB4-jNkklyEF5w6iskQawR-s5oItZB8-8LMrnoSS1oR-KX7NJ-TSpf0sRZSug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lcXzZwX8-UB5ZdKPIGW9Z90aNLpiqNjT25T4O5a0ZzPZqYyHnWhx_g>
    <xmx:lcXzZ3mQvCmy30fnLpOEnKnsUneYrPoU80W_MeJa1xKMgW91rIbLtQ>
    <xmx:lcXzZ9fViM2rRgh-PMV2WHxKBmPTAKRfuGXpfPGc9Teeo5Z5G4EbQA>
    <xmx:lcXzZxHIM3ohKX4YiHwXY43B-OHLlnidWsR49t_JJHhrmZfldc2-_g>
    <xmx:lcXzZ_AZ5DUjZNcz_uOwRKGMzN2HLONuy_HVdPeDbCUtAu5Khw9R8FKh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 08:31:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42f5acd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 12:31:15 +0000 (UTC)
Date: Mon, 7 Apr 2025 14:31:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/16] reftable/table: introduce iterator for table blocks
Message-ID: <Z_PFkoNgCXrqZUwl@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-14-ebed5247434c@pks.im>
 <q6shqgjoe5vlt3fduj6cq6473plz7mmlmnmyuwft7huuod5hhn@je7sijo3v54z>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q6shqgjoe5vlt3fduj6cq6473plz7mmlmnmyuwft7huuod5hhn@je7sijo3v54z>

On Wed, Apr 02, 2025 at 04:46:06PM -0500, Justin Tobler wrote:
> On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> > diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
> > index a78db9eea7e..f0f1784c664 100644
> > --- a/reftable/reftable-table.h
> > +++ b/reftable/reftable-table.h
> > @@ -10,6 +10,7 @@
> >  #define REFTABLE_TABLE_H
> >  
> >  #include "reftable-iterator.h"
> > +#include "reftable-block.h"
> >  #include "reftable-blocksource.h"
> >  
> >  /*
> > @@ -99,4 +100,19 @@ uint64_t reftable_table_min_update_index(struct reftable_table *t);
> >  /* print blocks onto stdout for debugging. */
> >  int reftable_table_print_blocks(const char *tablename);
> >  
> > +/*
> > + * An iterator that iterates through the blocks contained in a given table.
> > + */
> > +struct reftable_table_iterator {
> > +	void *iter_arg;
> > +};
> > +
> > +int reftable_table_init_table_iterator(struct reftable_table *t,
> > +				       struct reftable_table_iterator *it);
> 
> Any reason we don't call this `reftable_table_iterator_init`? Seems like
> it would more closely match the other functions.

No, good point. We should change the parameter order in that case, as
well.

Patrick
