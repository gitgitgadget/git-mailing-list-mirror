Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777317A31C
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564826; cv=none; b=Jnuu+oVVYtbHCofpRu88h7YVXiEH+Kp/K4sOUtmkzXv//SBOlQEmxs/1c5nOeCKG3dLMUQ+Oym5mRnvMFF/ekUBf4x7zky3DV0x5DAQyli+rdmpgnusrtOw1A+qZUBZs/OEuNhIrgn81mh1vEcKxELhoTJwSclrk914mcgex9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564826; c=relaxed/simple;
	bh=CKAhHTgNi52IMFEyYxAjwUCXqDubsvyd0M96xHe92A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBkEA1VKxpnK7dLODOarek062h9o8+gv8rwOg3QqwtBe3q2C3L+O61wWwGrLICfBY9YNaCzEnEgIgTGfCdN44YLkYL21jZXnd5cGpZ3p1mkEDwpMRynE+PH/br9zM6PKTanQlvAQzRh/O0O/Ai6sE+Tt8+e8hSPihJCvaE2XZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QVEdMwKp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2BfoV67; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QVEdMwKp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2BfoV67"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B73D11380201;
	Fri, 25 Apr 2025 03:07:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 03:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745564823; x=1745651223; bh=zjXZ+DziGH
	9F7wVmblz2H6BjkECHMluMG8582pP5dig=; b=QVEdMwKpjcHemijAUaCuEg1HNu
	Fo+rXAAZPlb+4dQqIqIBHvQ+kZZz26IHkC0FJgr+XJ+zTPLyyLBobaqU5yJYZc3X
	zBW+p1KyhMOTePx/OaOIK3R23GIeBKB3PVa3BPXbHKh6dOcNHAp4QtEj9DGKf+7/
	Qh8aQjoBU9JG+aNpbwv4dhrrFgWFKkGGJjOLzCQPSht4LLUOXmyLStd4JuIjpHfJ
	h3w2hY/sKTLwbnHjmQdw9yeL9WsV6o7lMvcz7vbke00exEZ8gXTkhuzqvm+M1fH4
	9/wCz8QCS49Mo0FTrpVKnE7M+sptYLUFNccuIcIgfpTu0SP318BQEgqV8zjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745564823; x=1745651223; bh=zjXZ+DziGH9F7wVmblz2H6BjkECHMluMG85
	82pP5dig=; b=C2BfoV67qRADw79clkPIbA6P0lUVBQTnMyHaGhxOiU9PO45FVSm
	cUiyjvZno8L04BouFsZ6UpbtfxNKx7KeCMCcwycXs5dUOX22XSVOtMke1jXVYWAo
	k+VzEeZSMkOIkDbwjdCl3gNExe0oDqwIeoy+6vWg2XMH9GOzq8vv6RwW3YZgdV1S
	4IEf+pdb0svgbmarqVFn3RqVRZC7Ru8/HLeQ8cAl5UTd04cZWLsBnPZ+Z6zhTG+v
	hxVHZfS4/qg+KtS0BTorb6+6b+EpArVhkc5Wrv0cUynrIXxL9h95d8elX3jtCfYI
	hQGG2rRFBHcSiRW0H0IO1l2SwFv51dwY8iQ==
X-ME-Sender: <xms:lzQLaAQmKd_XtrNY81j6NSxduips3h84HtwzjNaY6L1iB7OXwFl5RQ>
    <xme:lzQLaNzjUsiY5k0kShetznNOXq8UiVoPKk3aPhWIUwEdu0pe-O3mSDnOrEPqgmgkY
    1SGDijoHLP7vPMRoA>
X-ME-Received: <xmr:lzQLaN0EM5LdghZlrGvMyX9ZgsuTEEY512lqTBooVcKqvJlskXtvQZ7qZav_aVyGm6UlmKTmiqynwhcTeU0c_ueDCw48fhy8NfAy1Lju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lzQLaEAMt3zIqXa_mwbC1fbKnEjjIdlYvqCqSbCAWaFfb99693aCwQ>
    <xmx:lzQLaJh7NZYRuaEr2Q6cx-v6fwrCZuTGWOECAr0gN1LF-GOkKnyPlQ>
    <xmx:lzQLaArM1kIxws_IExVh4Grx5HrMN7vi9ZuWAFrnC5kQpJlkV8jQrg>
    <xmx:lzQLaMhtm6iXiQ9nK_qKfZsK33ZRn8HanDvVufyJyhNEx2-QhZ1i7w>
    <xmx:lzQLaA-8Duhmz9HCtCZ7NP0uDiP0_zHTMbFnw15naeWx4CWcQ3Lyesor>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:07:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70604ba7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:07:02 +0000 (UTC)
Date: Fri, 25 Apr 2025 09:07:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] object-store: a handful of cleanups
Message-ID: <aAs0lFpGqL6_a-y2@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
 <CAOLa=ZQ45v33yj2bUNrN6ZJYawR2KVyjHAtsY0RZ58fkhkTbSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ45v33yj2bUNrN6ZJYawR2KVyjHAtsY0RZ58fkhkTbSw@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:20:18AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series contains a handful of cleanups to the object store
> > subsystem:
> >
> >   - A couple of definitions are moved out of "object-store.h" as they
> >     belong to other subsystems.
> >
> >   - Some functions are dropped and/or renamed.
> >
> >   - The biggest part is the removal of `repo_has_object_file()`. This
> >     function and its `_with_flags()` variant are marked as deprecated,
> >     with the replacement being `has_object()`. The benefit of that
> >     function is that it doesn't reload packfiles and doesn't fetch
> >     promisor objects by default so that it becomes more explicit when
> >     one really wants to do so.
> >
> > These cleanups are in preparation for getting rid of `the_repository` in
> > "object-store.c".
> >
> 
> Apart from the few nits I mentioned, the series looks great! I must say
> the split of commits was really nice to go through :)

Thanks for your review!

Patrick
