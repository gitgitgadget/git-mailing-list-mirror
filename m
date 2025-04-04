Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADDA16132F
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759267; cv=none; b=gA4ZQbiC5R+Xj3iYSjllgwVO6D//REK1jRtq21dYDfut+6HSi+hU+xlMWTPYxCiHdql3hWH1s4X8LzdhpAYbCV3M6dlzsYhWq7Qhwt8uxf03yMUv1qJ0EqRcCvYy6tdIH5gD3tNUu9fNz35hs4oKZ+8hEKgZDCv+DlDyq29Urv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759267; c=relaxed/simple;
	bh=BGdGGmMhYVI437+Nayy1YHMGN6x65lVpeYBx1ubVnqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNGw8HRq12NFyF5oYzv45MTudXOMHCuh7MCLIxOdatodLVQe9Fw/GDLdseOChA+e4vfA50mOnSCRGbxIRfkCgM8NtAGuN1s94qI9FShqaf+w4NX+9Di42sN4ILRGzQ8JR76FdjQdyl1Djuh2xJWP4ik1OSZiIc3fst6YIl9wx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dilg4Zgp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBmKG1KB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dilg4Zgp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBmKG1KB"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C45425400D7;
	Fri,  4 Apr 2025 05:34:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 04 Apr 2025 05:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743759264; x=1743845664; bh=EfvkY31+aR
	QQX9fBnP5sNdRP3CDT9/teUGc9Cp1j7Qw=; b=Dilg4ZgpxJzJqIcauFB8C6fMEX
	COM3608LqMTYRmxErKHrA3YsOIqSjLgf/7na5KOGA9u1e2kkqiz58nJ9aLaYocEv
	W0H7sZAUni47HcAC6ZWwNc4TF7dkys2lYhUZfYt1CCKzil8CYYaOwrka8J7K35mh
	zyktM5byqGIh/hLYGLZi7/DzQNvoy6SHIg7W9WiwXa3KzqfRgPm0eOqh3eQYtNTb
	NPRdTgPJlLT06yVOT1EAlq3/fdyi0PYxcjhySxbcxTS2Oj/mEgBEFTXTOHqmrpfF
	maAx39h9lFhgza7hTpxkPbd1RkiSpj92KiVU2UhJDbqyc4lQPRpGNkmK1zNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743759264; x=1743845664; bh=EfvkY31+aRQQX9fBnP5sNdRP3CDT9/teUGc
	9Cp1j7Qw=; b=jBmKG1KBhWWQWGIlsMMri2j8ReHVeuMfVpguY7qMyQwssZAvULE
	voO8M24hK+p8dTeYc3sYI/k4xOu2RCR+SoZvupLdfVMIYX5p7PQdZQqnMuZTc+tw
	Pkr7ZReJrsTkCmJ0CvxlOMMJE7j5jSuvrytq5J8xrjc6410O+OAbM8f1BhnrX535
	c7LlTxI3sedesu56GoxQyYVY2OnEC7QvTrhQQgxEH80H5oYhN65PmhWUxH4fXjdi
	sHJX2kFxQwWy6lSMz1ZqU+SqwATjdl1pMBQXtlivZwnVhFV0p0jGYHwc6U3B5xSC
	YAQtEimrtqklZ4db98z3PDt8wghhIbOyPIg==
X-ME-Sender: <xms:oKfvZ24DMVk5jhebfxYmFIVTstEAadlY3v7XRjL6zPs5ZaZ04ZBc6w>
    <xme:oKfvZ_5lUdgzMfCnOIqsvMagMVTemM4iqWZDaNUK4-OYxhBubKqMhXE_JxTjDpT6E
    RN5eeASw1eRsDibhA>
X-ME-Received: <xmr:oKfvZ1f50n2tCzIl--rTfRrqp2dJmldxkW8hwTNkrq1zzmzlBmjgDLwSddvokNsTbniWzdENldX9vWJkhgFFWjTsaHsHI_4n3WNDpiHMapA6VNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledutdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtg
    homhdprhgtphhtthhopehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthhdp
    rhgtphhtthhopehrvghmohessghuvghniihlihdruggvvhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oKfvZzLA77H81D7LTF7T_sXxS3mE9VupVNjcIoXi1Ph-K3Brf35-jg>
    <xmx:oKfvZ6KFHfBmKcum5wLl6xO0JS9ZxtQI6dkjEvkGMJtk921YjKJcXA>
    <xmx:oKfvZ0wO4PCmDRS57O6JwcsrMnjfmXZ1eGs4hWdxfsFnu0S6KZHE-Q>
    <xmx:oKfvZ-Lv62QOwjq50THf815INUkGCKAB1Dp-9TycXo-21QWRNtDKtQ>
    <xmx:oKfvZ5dzCyhKHeMvRzt8hBl2xe396GV4PGI0KQ9ONF0Yj1EYhXJCFw4j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 05:34:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d444065 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 09:34:21 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:34:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Nico Williams <nico@cryptonector.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z--nnOhsUCaqo45z@pks.im>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby>
 <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
 <Z+9N2REkYZhrbkzb@ubby>
 <CAESOdVCekFDxOWTTF71dpH1id_H2t9SaNo6buJ1MbvTnaENY7g@mail.gmail.com>
 <Z+9ez7kbh/L0Iq4k@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+9ez7kbh/L0Iq4k@ubby>

On Thu, Apr 03, 2025 at 11:23:43PM -0500, Nico Williams wrote:
> On Thu, Apr 03, 2025 at 09:08:59PM -0700, Martin von Zweigbergk wrote:
> > > and even then still not workable because Git might
> > > have to search _many_ branches to find commits matching the given change
> > > ID.  (Fossil could have an index on change ID and trivially make that
> > > search possible, but for Git adding an index is more complicated.)
> > 
> > Yes, I understand that it would be significant work to add support in
> > Git. I hope that Git can gain the feature eventually, but we have no
> > expectation that it will be implemented soon, especially not the UX
> > part (the preservation-on-rewrite part should be simpler, I think).
> 
> Ah, well, Git does have an index: refs.  You could use
> refs/change-IDs/<change-ID> to index by change ID.

I don't think references are a good mechanism to track change IDs. The
expectation around refs is that users can change them basically at will,
but it certainly does not make any sense to let them update change IDs.
Furthermore, as we have already discussed, change IDs are not unique,
but refs can only point to a single commit ID. So that's another
mismatch that we cannot address.

I think caching the information in an auxiliary data structure would
thus be a lot more reasonable. This could for example be part of commit
graphs, but could also be a separate index specific to change IDs
themselves.

Patirck
