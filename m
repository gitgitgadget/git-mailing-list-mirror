Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8453B8D4B
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445393; cv=none; b=m21FBPNBjaZpMax1vurZrT6zQ/Phx9t7EOhWt23bIcismtVSp5b/6ydiKsY61zCH24Nm6nv80/AJNnyfOFBnZ3VUoZvBLSN3TioTgWOxh46yk/58d7+seVm3C9DGoFHojO2BLeXNhbU30skF1Ck/9JN9wZg7kGhPn0wDAoD7/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445393; c=relaxed/simple;
	bh=gKOfY8VBSBnflKd8c0zGWRziYLQXs/KVrYGx1MrKoAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teodmE6Lsm6oyrnBTbvoCH5e38v5cOa6bTgxEaLh1Plwzetk13VTykDX7W2/3cLX4/hTQX6WYPhw194i7TzMFrRk9wBIti4yKZbLIBC4E1jrTR8K83I1uJPDVsbQMYkMdawtDWR/3FVZXysvcWGJcYtk16Qaf9uwEKGFaSS6vRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NBiqBLg8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7gEjnHf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NBiqBLg8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7gEjnHf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D4637A0126;
	Thu, 11 Dec 2025 04:29:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 11 Dec 2025 04:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445389;
	 x=1765531789; bh=owcOA5eQWbNJ9fynpITXlmKdFTYow3rdBhKyWnhQll0=; b=
	NBiqBLg8KkUgJqs4TAYYDmWIP4zz/eB20vGC1ul8lOJeBqL+NTHDppTwn7cTvAqr
	0A1KkGditwbhLLkeRJn6XSnJwVv5zwbwF6nKLVrqijord9EDjb9TWqTwM9EIbjI7
	Vo00jktqfST5gacJJWz+9V8a7IsNJTlolNJn9xzbIBU4dnA4tQcD10wenFwvUTdR
	nSb5PjP8/cOe4OYrr8cwhO66f5GUBix7HElZkn3RNFHaSplFQoyua9mbeQRM01ZL
	8Xlji3WpC/yd+nkI4GgKOw1HKvMErz6UsZF0Hqp9MZU9k73W7CPlwWJ3xrrT0IFJ
	cr7HGe7IM+EI1W2vMi+6hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445389; x=
	1765531789; bh=owcOA5eQWbNJ9fynpITXlmKdFTYow3rdBhKyWnhQll0=; b=G
	7gEjnHfHmo0hBBRxDMJkbkjy4ihEZ/gbuRW2zNtBJ2bCVDoUtjayjtrTUX36Dr8M
	LMbxpii3KdzGqcTN+/HJkkmgqSwHf0TKghCXyIiUTyF3RZ6Q8xEbeoToiJFNi1q8
	Y3UaMcGJRDRz5x+Nn+9UuML6EwpajhN7j1UYU1EhGQl9qcZ7kBOdcJdYafrXOCKc
	0L9SPeTnhv9NUCyHUSk2fmq5QtEqrCTVlmSAfLjNJ4yPNWTYobEKSUxAgobcWfWk
	RX4AMCcz0+zeRDWiMVe/JEt2FYb8oOjGVxMZ70XAQkb4xzE3+vcRmKkJGh2VetE4
	uh8dn/n7z6Ap+EhdFLvIA==
X-ME-Sender: <xms:DY86afYZcfVcH3L8kTXwwyQ9P3V9lA2EYcgwYWN3_K22DMx7pTDadw>
    <xme:DY86aV0JFRPc2Wp4_QBTZCvCW8_jYsMEMPQ2FZ-wpIgLDWfdggbi-qdt9A1FPI_PD
    xDYOnWiq5GQbjOuYo0nA-_4uIoFDGSVpSYOCCR8S9ba_M17s8FbWg>
X-ME-Received: <xmr:DY86afWSmILsTuPccrR_LfZj1_4xQCoEs44yzODDcDcEw2L5R8IU8ccAZ-KQ9LyKSsYBRBGYwyW4omvvgQWZbgDn1oo_QCBnmf2s9N06QXfp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:DY86afUzpYcCmsroOHYb3n03GptA-VwQRkF1OnnvCqqkh2oOqHfAhA>
    <xmx:DY86aee4QvQQ8oIprATlZu-5xJiILK57hHdQMZf_PS9ZL_aD0gRdLQ>
    <xmx:DY86aYXFDcTbp3cGjvPUi7CXtyHoMPU6_Js0HvcLcZBQ_vk1LAFNGg>
    <xmx:DY86aXehwbMAVQxqVH4sZm-wYu2kOblgqhf9wsPNKFxJJYudP0BTRw>
    <xmx:DY86aXRvFaCAh-XoRWPGytUutDO8lzp3GsahKUcCah_SgTehjsxTsnjc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:29:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 736ab96d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:29:46 +0000 (UTC)
Date: Thu, 11 Dec 2025 10:29:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 4/8] odb: adapt `odb_add_to_alternates_file()` to call
 `odb_add_source()`
Message-ID: <aTqPBygCfm1hWtL-@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
 <20251210-b4-pks-odb-alternates-via-source-v2-4-eb336815f9ab@pks.im>
 <aTpxB8gS7wG7rRJQ@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTpxB8gS7wG7rRJQ@szeder.dev>

On Thu, Dec 11, 2025 at 08:21:43AM +0100, SZEDER Gábor wrote:
> On Wed, Dec 10, 2025 at 04:32:37PM +0100, Patrick Steinhardt wrote:
> > When calling `odb_add_to_alternates_file()` we know to add the newly
> > added source to the object database in case we have already loaded
> > alternates. This is done so that we can make its objects accessible
> > immediately without having to fully reload all alternates.
> > 
> > The way we do this though is to call `link_alt_odb_entries()`, which
> > adds _multiple_ sources to the object database source in case we have
> > newline-separated entries. This behaviour is not documented in the
> > function documentation of `odb_add_to_alternates_file()`, and all
> > callers only ever pass a single directory to it. It's thus entirely
> > surprising and a conceptual mismatch.
> > 
> > Fix this issue by directly calling `odb_add_source()` instead.
> 
> OK, but:
> 
> > diff --git a/odb.c b/odb.c
> > index e314f86c3b..d97e50fb61 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -338,7 +338,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
> >  		if (commit_lock_file(&lock))
> >  			die_errno(_("unable to move new alternates file into place"));
> >  		if (odb->loaded_alternates)
> > -			link_alt_odb_entries(odb, dir, '\n', NULL, 0);
> > +			odb_add_source(odb, dir, 0);
> 
>       CC odb.o
>   odb.c: In function ‘odb_add_to_alternates_file’:
>   odb.c:341:25: error: implicit declaration of function ‘odb_add_source’; did you mean ‘odb_find_source’? [-Werror=implicit-function-declaration]
>     341 |                         odb_add_source(odb, dir, 0);
>         |                         ^~~~~~~~~~~~~~
>         |                         odb_find_source
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2864: odb.o] Error 1

Hrmpf, I only fixed this callsite in a later commit indeed.

> Note, that several commit messages also refer to this non-existing
> function from the previous round.

True. Will fix both of these issues, thanks!

Patrick
