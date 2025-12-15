Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539218C02E
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776790; cv=none; b=W+LutSwzfdAQdmvO0II66qIAoBNAtK6IjkbBjenL4IWhchdg8jZILEmmeuQbLcyVzVlVjptYOq2M7yRKC/HFIFsgtJwQmx4dVZ5aVZ/HVYhvdtghmz898MBeT18Ukr+xzlAys7ZUnJOz3pZz7R+ceezH+ZisEJNKL2wqpXVp6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776790; c=relaxed/simple;
	bh=nuiSwGJBbh7UgKZhZNYBlECpNLDyhvt59YQOcnDXDT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4Fe8jzNx2USdAVQrhIPrGQNRkwmaci7zstj8Si2uon8lqLlX7h1InNibBsCaqC9W3O9HNZpEKF6Gsk+ewS3PThXFE3ga37fte9gKx6gokVBB+rFy8nQAq/SauCzVTEfO0zJ3nYdq0Bb4k0gdfHEoEarmURLqwpQxkloCei/s08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DyuZyo46; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZITvlV/c; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DyuZyo46";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZITvlV/c"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B9F6EC00B8;
	Mon, 15 Dec 2025 00:33:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Dec 2025 00:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765776787; x=1765863187; bh=qwP46CKL8T
	m1orddIdZAVgazOG2FZgQMPs82BsxfLso=; b=DyuZyo46A+q8ECF7+Nr6+P40xa
	IEJDwHcn/8qBkLpxCY1uw+t0KKaEdlCYCAmY3Iva94ohDi6biSi8TPpLpUToTWn3
	Y/NPg0o3uzIrtAIDusv/FaYf4pYOuDK9CHI15QdOW8WJlp78hKz3SMNJPJcuzcj+
	wjdjzWM9746aoSjxXI431eWj4kz+lbRJ9blHgtJaeu13Obaq1Dea1QETQCVbGQJY
	z4+/mSZjG8cTz33OY75t4nirSqSdZ4fgJYP7xsFvN7ZgF+MOgEnks96OPgM8RC2o
	af0O4QVHbjvLTWG+OAGa+HVK27LVtXtVFa39vsgQEf7hEc9YpcBAj+IPPJkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765776787; x=1765863187; bh=qwP46CKL8Tm1orddIdZAVgazOG2FZgQMPs8
	2BsxfLso=; b=ZITvlV/cwmhQ1Q/JcO+UAWyRLMYZs0ICazh9kLZ+AycOlWXv4+m
	X3m4X5b2/He+2NA14YrJ45Hbll1dURDkDq6D8EYqZRNsRC+re5+mpcNAa4EEgvl2
	hrglh45LDYZ3HqSiHbNbb0IYKKDQpUMMXsuu6TjM0jdwx6QTEIU4wZzg0sHbTTXp
	lmC3ReerkWFn1V92+LGnTP1tz0tna1aOul59gyW7y4B7F2GDxW4hTaLygeMlHhXn
	oBplul6IOx1wUVowczL04MfQg1CWvLclJJaTHR8cPibcj8x14vpCtlOU0cdJYCJV
	/fldE/QuJOUOMvk9vkwu1SuPiEmjWy1inCg==
X-ME-Sender: <xms:k50_aeOMKiLypqxzQUAPLOj8hsKSx8zEvWPhoQ84DQc1_kMVsYkW3Q>
    <xme:k50_aS-OiVqleptRVxzEBIVEVI4mSWi-Sa8PoQZRZrfzIT6oIwGdXXqV4Yz8P3DTN
    SVu5_HPBc2pqhUd_cX8Q2zNRqk8jMn4SlJXP_1dfI0hQ7qYsdZYyQ>
X-ME-Received: <xmr:k50_aS667CuD9Tgmc-JqYlPE3hZjgZhpESyDCVBxVxK6-mX055sllMvHFo99kCC3VrgxgcCSk6voN48fE5QjB21y9Qyj4PFoUPNgxMv_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k50_aZ3iUhESwn8E6uPPtY2AKpa7yCFp-xopzwbadMwNgh2Z9jiR2A>
    <xmx:k50_aZAIZtBPKWjC12gNjhtnSaBhp1zrpedPXO3OAkPmx-D5gn2DpQ>
    <xmx:k50_ab3weskndKTvbUFQ9udy_rIs_kA0QqyyvmaSzlw1g-pkQueE7Q>
    <xmx:k50_aTsBc-2vArtVcZim2srr-n666ejJj23oAUvcrJg3Ltq7eb7KnA>
    <xmx:k50_aQ9e8AjNZNmZeD8b3nmO0k249tc7BS-mL7bZj_1fVLoNWeTIHE5y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 00:33:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed8f68e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Dec 2025 05:33:05 +0000 (UTC)
Date: Mon, 15 Dec 2025 06:33:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
Message-ID: <aT-djS-TrQJxxV8i@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-6-jltobler@gmail.com>
 <aTkTCplQuSX_Y3oG@pks.im>
 <54kuvik2ecbkygjp57osmqjxiy7xtyjeffbzavuxbhuvta2oc5@mkqufah7cb3z>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54kuvik2ecbkygjp57osmqjxiy7xtyjeffbzavuxbhuvta2oc5@mkqufah7cb3z>

On Fri, Dec 12, 2025 at 02:40:24PM -0600, Justin Tobler wrote:
> On 25/12/10 07:28AM, Patrick Steinhardt wrote:
> > On Tue, Dec 09, 2025 at 04:58:19PM -0600, Justin Tobler wrote:
> > > @@ -106,16 +137,12 @@ test_expect_success SHA1 'keyvalue and nul format' '
> > >  		objects.tags.inflated=132
> > >  		EOF
> > >  
> > > -		git repo structure --format=keyvalue >out 2>err &&
> > > +		git repo structure --format=keyvalue >out.raw 2>err &&
> > >  
> > > -		test_cmp expect out &&
> > > -		test_line_count = 0 err &&
> > > +		# Strip object disk usage from output due to platform variance.
> > > +		grep -v "objects\..*\.disk=" out.raw >out &&
> > >  
> > > -		# Replace key and value delimiters for nul format.
> > > -		tr "\n=" "\0\n" <expect >expect_nul &&
> > > -		git repo structure --format=nul >out 2>err &&
> > > -
> > > -		test_cmp expect_nul out &&
> > > +		test_cmp expect out &&
> > >  		test_line_count = 0 err
> > >  	)
> > >  '
> > 
> > We could test disk sizes here test if we use git-rev-list(1) to compute
> > disk size by type:
> > 
> >     git rev-list --disk-usage HEAD --objects --filter=object:type=blob
> >     git rev-list --disk-usage HEAD --objects --filter=object:type=commit
> >     git rev-list --disk-usage HEAD --objects --filter=object:type=tag
> >     git rev-list --disk-usage HEAD --objects --filter=object:type=tree
> > 
> > The `--disk-usage` option also supports `--disk-usage=human`, which we
> > can use in the next commit to verify that our computations are the same
> > across git-rev-list(1) and git-repo(1).
> 
> So, I'm not sure we can use git-rev-list(1) in the manner suggested
> above. It looks like user-specified objects are always included in the
> output. When using "HEAD" this means the referenced object will always
> be included regardless of the filter used. In practice, this means
> reported disk-usage when filtering by trees or blobs will likely be
> inflated by objects not specified by the filter. As far as I am aware,
> there is not a way to suppress user-specified objects in git-rev-list(1)
> output.

There is, you can use "--filter-provided-objects".

> I am somewhat curious if always including user-specified objects in
> git-rev-list(1) output regardless of the specified filter is
> intentional. Looking at git-rev-list(1) --filter documentation:
> 
>   The form --filter=object:type=(tag|commit|tree|blob) omits all objects
>   which are not of the requested type.
> 
> doesn't indicate this limitation. From looking at the code in
> list-objects-filter.c:list_objects_filter__filter_object() though, it
> does somewhat seem like this behavior is intentional.

It is intentional, but I've been bitten by it in the past. Hence I
introduced the above option in 9cf68b27d5 (rev-list: allow filtering of
provided items, 2021-04-19).

Patrick
