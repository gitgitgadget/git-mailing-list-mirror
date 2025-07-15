Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DE273D82
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568040; cv=none; b=dtrsBlLahifINDJNZ5+krnUuxeqqu9hRxYJ0KyIpxT5rdMXOHCbd936b1QACBujKvgynKTQ5ChoNUl/xQpVyL8AgqWIUYit1Q9r+1ctDFDcE6iuk3KWCRy3rpggAaXBtLl2ehyzO3swdPoaTMnWMCBdQum+OHx8ubcAECan4PTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568040; c=relaxed/simple;
	bh=DNkv5TAzHar2mmuU5kGSAhwqgYHK7f6Z8GiXjWBk54I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X82mbZgjMPmvlPn2CxQkZjb/giVKW3YcYEJWrlNIFzrZ6TDgHHk6Xa9PuB/xuY0ydRVXnMjo14/AYdeD1P9+M+RAcZqvQC/mqhJeuSFnJnNjZa6KDzTW+VcSZyjAe39+rpgoswxznf4duJwh4bBrounGPHc0jHF9rNuE1o+GK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y6luWZoz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0otTGG8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y6luWZoz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0otTGG8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01CDD1400246;
	Tue, 15 Jul 2025 04:27:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 04:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752568037; x=1752654437; bh=NmaDd3X8yw
	DKgi11f3RW/BcWMe7lzHJ8PdUoSWRSD90=; b=y6luWZozJ4XPOj1OQPscHf+t/u
	sRSKsdGdN5goDok8yL9fUzfB6b9xF7NdW8xteL/oYDcn4WkxRnv/PKQM/6nauYnh
	JJ0cyAa1lyVogs2yZJhZSTtEigeukhSfnldjL8bbGUr3OUsP3xGPQGRTvr7WnE5R
	qqEuVJ50WYjPbHaK2+XS/cC/ZXx52gdCYuhTPr7vjSVlqGeODhu75zuO/6lgyk3S
	6cIu2z+vn+6JewR+gCNcLeZb/INk3Zx2+I4KCj6MBZEOV8k4/ZIU/EQxAjGR7Lrr
	vcH9K3WrQZVsvt58UBElLfNH+ANKF/Wq6WaGxQRe34/GH1HWyZQiAGoHUc2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752568037; x=1752654437; bh=NmaDd3X8ywDKgi11f3RW/BcWMe7lzHJ8PdU
	oSWRSD90=; b=P0otTGG8BP+KgeTPfg6qmlaGLRhuMk9I835CPuBzz+DcUeojuOi
	7JxRVTGBBwaV2SDUJajfgRkPV5ZuI3Zy61MH70CFEdJpwrVDhxwXvYlwX9C4sYh7
	Ta9OFSh4xtr32EMBceNIiYGPKwij+iwcfuLgwF9fkTe1yZT64mYbMivJSGw9Irli
	Rsdr3npMk6oJKYJAvRWmuW7Ln9MSNeCegbqtKWHRPkdk9JNQ1a5quBLWoLREucWw
	L9WluFhU1rMpBGa2IQIEcxq/CzfutW7L0KogYnv4ZSZv1KV4QmedgNyaxigNp8jq
	8g3kp17NKj3EmORWmZeU7vpnICyDekl+XxA==
X-ME-Sender: <xms:5RB2aN9F7ZooPRInSvOhGYsyLbdH7j3ya-CcEpFPG01VU3AmLa7k8g>
    <xme:5RB2aJedK9h8qJh9UWYF-wBgnVWeHxSs1gDxoyjm_mh3-4zpyiKrzj-82Uke6v-Jw
    pahAWoE0UIBh30jSQ>
X-ME-Received: <xmr:5RB2aOE-vd1fAtVV_AALQJKm52r7NxxTVgNkzjko7oinGYSgUSPq6uc93sZ7mIJ7_0bvlsrlXMrYaP1PIYbTqeluA-1AsnaoM2f6PEknxjJB6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5RB2aPdsD5DZ0CVxDycf-jGJGomxquUemNkiyX6yHg_3ha0cnpLUWA>
    <xmx:5RB2aAFZ_kUXWRxJqN4bSIfuR51CyRe1q_JarKTn6A4bXunTAEE9_g>
    <xmx:5RB2aAWMXZ8I3ICS3knZCK6DBwoYkV45CF8xz-zPHM6ggC2bqOo3Jg>
    <xmx:5RB2aPIpJ7_nGQxk_LAy7GR9uiNPpPlxi7_9xnB_OftN8um9FRHvNQ>
    <xmx:5RB2aOoEFoejiyMykHfqT9RfvjaoMtj7TYm3ngHuFNcVsCqhX_fsBdY4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:27:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 410a8c76 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:27:16 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:27:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] odb: track multi-pack-indices via their object
 sources
Message-ID: <aHYQ4P-2brVDuewF@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <xmqq34b5aumb.fsf@gitster.g>
 <aHBTsm6fUexaTKB4@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBTsm6fUexaTKB4@nand.local>

On Thu, Jul 10, 2025 at 07:58:42PM -0400, Taylor Blau wrote:
> On Wed, Jul 09, 2025 at 03:04:44PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > This patch series thus refactors the codebase to stop tracking MIDX's
> > > globally. Instead, they are being pushed down one level so that every
> > > `struct odb_source` has an optional MIDX itself. This simplifies some of
> > > our code and will make it easier in a future iteration to move the data
> > > into a packfile-specific object source backend.
> > >
> > > This series is built on top of a30f80fde92 (The eighth batch,
> > > 2025-07-08) with "ps/object-store" at 841a03b4046 (odb: rename
> > > `read_object_with_reference()`, 2025-07-01) merged into it.
> >
> > You do not have to deal with it just yet, but FYI, another topic in
> > flight has a commit that adds a few more callers to a function this
> > topic renames away.  Namely, 5ee86c27 (repack: exclude cruft pack(s)
> > from the MIDX where possible, 2025-06-23).
> 
> Yup, there are a handful of new get_local_multi_pack_index() calls in
> that topic.
> 
> > If this topic needs to be rerolled after the other topic graduates
> > to 'master', we may need to see this topic rebased on a newer
> > 'master' with something like the attached patch squashed in, but
> > because the other topic is at least a few more days away from
> > 'next', and it might still need another final finishing touch
> > iteration, let's keep these two topics independent from each other a
> > bit longer, and let me deal with this trivial semantic conflict
> > resolution, at least for now.
> >
> > Thanks.
> >
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index a74b2ca7f3..21723866b9 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> 
> Assuming that in these three cases that the first entry in
> the_repository->objects->sources refers to the local object database,
> then I agree with the proposed changes.
> 
> Thanks for flagging it :-).

Indeed, thanks. As the topic has been merged to "next" by now I'll
rebase my series on top of it.

Patrick
