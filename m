Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BD149C64
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424181; cv=none; b=u/M3s4nFC2WO3uTYQ93U0ml+7LS+UFeLONpDRQcRshBHlB9J+7q7CmC8pxxJ9mrp4S5RfGQ6qnThAAUbMgO8u1Wh/8vE3G2xf0qF24Hz11OBma13TsrljPiODZiYXk6dcQJcmf/tyJluQGTdWxjtkIHnQRa35f5PLyfeWRzBdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424181; c=relaxed/simple;
	bh=ibDYrqgn5eCDqPxzPLXzl7t0QyeqlcAdYXExDbwEC0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2/BNQn48pizjWemmddVdcRh9IQINWGecl8Gi6W3iY4YklZq6J69FuRzQC6NkYZ+DKDSSQdbA2e6WunzArGIXgEYF5jcpBP/n/MjISpx//2pLcrkLOM05Ch2IiGH2Y7ohhquEv7/Z4cEri+6Gu8YgaYsbQ/gK2yn5B1FvfxNSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g1oJwXEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3trJqmq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g1oJwXEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3trJqmq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AEDDEC0255;
	Tue,  1 Jul 2025 22:42:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 01 Jul 2025 22:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751424174; x=1751510574; bh=pcu81iOFkU
	+1WS7tYKGzzFMwowSAaW9u9EnagAWfE60=; b=g1oJwXEUdTodhaFfb2NZJHFSHB
	8aJJjrwGvh9Q3xBOpVPbjhEbONxHG/C3zDRs14V7d58KrWZqRxcrlEHFwhjtg4b0
	xtmMSBpFXA8wE7StEKexx55jH6oeVxUhZynEgeeFzm8WTrP0HlsZvamJvsGAl/os
	YaVaiUyEXfhgeTu/2F5XVVF5ivOrmNX5i5mY5mseKeb8ufjiHoY0ngMoKwCQ1S/4
	B4jEHYt01NZCQilqXaA46AROe4CrOnWaBENUqTirexRDNMHjxr3k3hiMDwzJdxkj
	D/tcVH9jtydWlcrdOd1OCfKBGXa/St9ZNLqHbdkUFROhRBuQzzGFYxEBwlMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751424174; x=1751510574; bh=pcu81iOFkU+1WS7tYKGzzFMwowSAaW9u9En
	agAWfE60=; b=g3trJqmqhg7tnAp2h4xwko4ZKjmRn+Ge/FqvZpXWJ4IKkf2Guk/
	nBy+2/Mic+m9UYEclqcOK12n28umhWCoAhcEC4Ul/DP2b82Zrh8ySdpnmhpVqNkb
	3G7562oPIzEm36EaZWSWHZiJAvzyK+jd/Ct3NfcMpC6BYtqDghTiZl7mTX97utBR
	jI1TOB1Q4XhJTucHBy2U6O2mNkztxvcLKjMFfiVHYbV7ABJMoIGOWkTkbgOq0UHW
	Sp8K7sRhduG30Dx3mlfYfQHGuPW3dT8n6RGnTwsMBTVygeldyGn0Q6EmMBQsVtSi
	lv1KsgE1FwkB6ekGN6THvKMzlRWa7h8Ckmg==
X-ME-Sender: <xms:rpxkaII6zNZXRWpjMjCNPY8eZk6NvpcJXFzBuqz6Iaeo8U4ye69Rjg>
    <xme:rpxkaILRU-XcmsqvOWZAYGSddPYOhXQOYSCJ4RhFdFCbID3R3qXZeQyMYnXTP62O9
    uZ9aEF9HFyPl6tljw>
X-ME-Received: <xmr:rpxkaItYI8qay7aHSzBPTuZf4M6H-BGKuIFfhXn-xBnjejNIV_pm6ntafPohyEmf3zChQYFGHNO06yaXWq1saxigZTtGfqTJOa6W707ZcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rpxkaFYBoUGUxGG5sdRUI6ezcQlEpeYM887QzLuvbI5rOaP99x98CA>
    <xmx:rpxkaPaZTKRr9KugOWzZAyYrLwjqlKGK9XKjllt3KMQXUObfV-Yhkw>
    <xmx:rpxkaBAun4qV7FxaKemfx79MJFHH_Iuo_cbcaeKE15VzPlEpOnsFdw>
    <xmx:rpxkaFaOhtJJ5qj40v7bc_rrug__W59pBLsJiDVZYF7M4ngkSifmUw>
    <xmx:rpxkaMK9ynt-pH4By4Fv4YO1bXYPsSc0tFbqvO7TkL80gGNoNCvA3Yyn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 22:42:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adcdf1bd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 02:42:52 +0000 (UTC)
Date: Wed, 2 Jul 2025 04:42:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #01; Tue, 1)
Message-ID: <aGScqbG2SGSK8Hwg@pks.im>
References: <xmqqwm8rh00m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm8rh00m.fsf@gitster.g>

On Tue, Jul 01, 2025 at 06:08:57PM -0700, Junio C Hamano wrote:
> * ps/object-store (2025-07-01) 17 commits
>  - odb: rename `read_object_with_reference()`
>  - odb: rename `pretend_object_file()`
>  - odb: rename `has_object()`
>  - odb: rename `repo_read_object_file()`
>  - odb: rename `oid_object_info()`
>  - odb: trivial refactorings to get rid of `the_repository`
>  - odb: get rid of `the_repository` when handling submodule sources
>  - odb: get rid of `the_repository` when handling the primary source
>  - odb: get rid of `the_repository` in `for_each()` functions
>  - odb: get rid of `the_repository` when handling alternates
>  - odb: get rid of `the_repository` in `odb_mkstemp()`
>  - odb: get rid of `the_repository` in `assert_oid_type()`
>  - odb: get rid of `the_repository` in `find_odb()`
>  - odb: introduce parent pointers
>  - object-store: rename files to "odb.{c,h}"
>  - object-store: rename `object_directory` to `odb_source`
>  - object-store: rename `raw_object_store` to `object_database`
> 
>  Code clean-up around object access API.
> 
>  Comments?
>  source: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>

From my point of view this should be good enough now. The only
contentious point really was the renaming of `struct object_directory`.
The current iteration of `struct odb_source` seems to be something that
everyone can agree to, so I don't plan to iterate on this series any
further.

Patrick
