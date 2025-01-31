Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594291E0E0A
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340606; cv=none; b=JUiDXuBIpN6Siyq8VTDbbr7+Ep/JJg729H24PtpGriFn/eCmlPQOgEr29BLkvL9KrR+KZJaSbMBp1BWAhlXGFz2X9KX0ykWW6+KbF5gJTjahCjJJW2twEf5ZX/RgOtK1ijxmbFWZ8K6cOCEJ6/uPRDLyA6omfsjD5Gwra3Yeu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340606; c=relaxed/simple;
	bh=v5/jxzJkBRRx5JGpURo5fAQ+WgpGE6iueeq4FSSxV4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PyEhEzJRLh6f0kkdDgEjN7to3KwBcteP1pwr83XsxDgirJ4qbUw8BJpgJ9pAMMReYTypoUCtcHbt+Wa0PcIk9DHOwT6An3qugTEHimEKwfVMhlPs97j1AVBB7YFhp0IxKukt9oMP47/xtKCbVoHXS8W9IDDltqk8nT8Js5WaY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WT0BPryb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puvT9aww; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WT0BPryb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puvT9aww"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49E18254010C;
	Fri, 31 Jan 2025 11:23:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jan 2025 11:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738340604; x=1738427004; bh=ISilI2Jeq7
	I6TguUxnqVlaSxypU7D8DPLTSgOIRvaMQ=; b=WT0BPrybJX17BjrsSa+RJiT/3H
	yiWHdYQlh6LBLY7eHjfOQ564EuNw6zqV0fEvYilHssbbf/uIES8gDmu34UY/mzTF
	ATn5qVct0cBF2GFEBEQXy8uS0jAFtU9nY/2FOR0UFZ4SNJUGjTzmA1eOMHmwLMme
	STNZhNbgOFTk+dtUGKKdqy1Gz8FtfoYwRbFyP2OMHNSh7NxJIaqxdMsfVcguCP8n
	dqOGwqqxsuuIH06PpJ27SHN/dxPC6J23+kxBwoQxjrp08ZuQLnk2ovM8DnFkf6XR
	JLjbYWgx8HVXiUW+0wYQJq8BWs4u3MBUNwohuOC5EeCSvtd2F/aHLcRyOLQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738340604; x=1738427004; bh=ISilI2Jeq7I6TguUxnqVlaSxypU7D8DPLTS
	gOIRvaMQ=; b=puvT9awwkHxEnVcWKqeIreCCfTwtu9HRxf7iYQyYo20ztqG9GuZ
	/W8+kJOy/N4j9/HBjYfDkmR26oAZhZIiP56/jUCqDeP3HTx2N+I84nLRYF8jP3xX
	/QNaHwRGt3gyOITVDc0VlPBSHJ1YbGTw+RF1boAFN/CR5hNiWfiws86oQi80sLn2
	rTG47OJ+54GNZLO9WGwhget0DYeS/JjZjRcv+oHCl8TFVhiSMepqEb0WrSDxX50V
	syfGoOJ+TyF8bkMVF6LP+d+LVWMR0lp9PrQE0jU/1ezI1BBm3fQgEyVBFYD65GGu
	950fQegrEgJ5WPysKwp0gXybjO4eC40oRQQ==
X-ME-Sender: <xms:-_icZ8oZAhApK3UoM4W34FwCbwaKUn8POkFpWgwNAxBExxR24EL5iw>
    <xme:-_icZyqTPu7M8bAzRzq_YiUGaOeRlWShe4yvO_6qx4gYBhJs59ZSKwHeQKDfuk6pQ
    ImRC1NeuWNFLUyAPQ>
X-ME-Received: <xmr:-_icZxO99Lb161uh2bZuNeWxEUvVC0qFkIqI7uBlXVjXLSyabQNFzuZ0cTcGWozsvc0uQjsUZmutHqDYIVCD4s_W5Hkl92dzuerO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-_icZz7_etS3VSPx9Rev0qH-fYFXhyXEysnd5KF6VF4EA2MPtD4d4w>
    <xmx:-_icZ74lHEdvhVj3ZCutZ5estdl5QjFCxGlebyDmNR1J7c4MX91VtQ>
    <xmx:-_icZzhi86B6fK_tXkfLFrqGrQLPnbX2jlGgbXdwMSRbCwl0ia8E_Q>
    <xmx:-_icZ16zHMBsx1Wf62gr9HMUUD-9CovzusEOOdxhTuLQPOPWbPIgGA>
    <xmx:_PicZ4uFsS82Yt1CO3xr4yQhOjo1hf_AvWxEPllxF52qi7HPbiqMhbWP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 11:23:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/8] packed-backend: check whether the "packed-refs"
 is sorted
In-Reply-To: <Z5zfx0E2neO5MNKs@ArchLinux> (shejialuo@gmail.com's message of
	"Fri, 31 Jan 2025 22:35:51 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r7KvL1bvSO4UQY@ArchLinux>
	<xmqqwmecceh1.fsf@gitster.g> <Z5zfx0E2neO5MNKs@ArchLinux>
Date: Fri, 31 Jan 2025 08:23:22 -0800
Message-ID: <xmqqed0j9clh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Thu, Jan 30, 2025 at 11:02:18AM -0800, Junio C Hamano wrote:
>> shejialuo <shejialuo@gmail.com> writes:
>> 
>> > We will always try to sort the "packed-refs" increasingly by comparing
>> > the refname. So, we should add checks to verify whether the "packed-refs"
>> > is sorted.
>> 
>> Do this _ONLY_ when the packed-refs file has a header that declares
>> "sorted" trait.  Insisting on a packed-refs file that does not would
>> mean you are stricter than the runtime contract allows.
>> 
>
> From my perspective, we should check whether it is sorted when the
> header has a "sorted" trait.

So the three-lines you wrote is not accurate, then.  That is why I
said that "should add checks" should not be unconditional---we
should not check if the file contents is sorted when "sorted" trait
is not declared.
