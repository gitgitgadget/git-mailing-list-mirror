Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFA3BB54
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918847; cv=none; b=dZuY4ww4A2AIYBfNsm2/wUKCyHx5Hyr/XwivQ2RFV3xVZg0Lxv+xYgNNlM10Pq/PQzR0xlOZyq+pAcc6SYkGvK9ipp2el2kVDdhRUhfM2Ufk4I+eTlctz0E6xjnyd9FQhQJFg0VYrhDvJlRGPE+asIqDnR4SYBKt/0scP8tfW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918847; c=relaxed/simple;
	bh=RH3Rl+2hRjauVGHgAfBIYgcwzlWpzY6qLbXtwDiYdF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Za9O3+wIS6JXc/kLcuVlxRPRWOJZ+MZOU00MUvstdk9ffUkOyXfG0+Qcwg051OfNnsx9vg2MMmBd4XaSvg9AwARzcb+a32fcjR7eD/qd2NOml3tsJKYG0zKcETibu9YPxr73CDaLZofqMXH73LG7XRZYapTAMrSKcx2cXf2FWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V1EhVqtV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v7jiGqMM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V1EhVqtV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7jiGqMM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F15B25401CD;
	Wed, 15 Jan 2025 00:27:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jan 2025 00:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736918842; x=1737005242; bh=Ep/zzAcs6B
	AfMltGYvpflJD7wvXaKr3SRmTD+XfEkfA=; b=V1EhVqtV51FIgIjg6JowuvPYHe
	Eni/T4PmgtLkpRHDosgXb5GUxGiugGmAI0NNDBI1jk/VXugUXpy1nuZ+aCLGb1Vw
	ez011yJQTXIFjyQ8hxaWhv7tUOKiS3RYqsHe6zVQN69+ceBSC7f/oDgE+BWJTekb
	Nxi7XCxho6KZieNsfQtRP7rXXjTqFjWRS2JjTS/xI4oV5ERVaxGoLmJxbIQ6KHfR
	W5KB593zifnRw6TUKLItLeMJQVg5loK4YIjRrxBn+zd55P5YefviBrm/r+CXlzNq
	B+OFAwE99z8+5xg0VmHyZuePG1PAloX7Xm6/FmMH5nJQDIId8OWBFXizXiLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736918842; x=1737005242; bh=Ep/zzAcs6BAfMltGYvpflJD7wvXaKr3SRmT
	D+XfEkfA=; b=v7jiGqMM+/YXTx0Ro7fR5CPnya3gp51N12qOBx/tAli63K6jndF
	pxMJJrpy9lEbKfzE1/re/UelM7YsJrhmEK025klqbjWLXRAtkRl0ctl51Y98X1nh
	LkUDRqLv1bHfI83F13z6N5iU0Nsfpbpe5y1RXUnQqObGA5/wf0g4Kcv6cYzgrl8W
	ck9r8uqjozZYDhQJEcAhbIgLBv+jUrypOgIVCGk/NZmFMXxUjBMFTFY0jXSj647N
	bggzq/lOEExmDIm2DfhpcotET5AzYHcVeG912rZKi7duYHZlUnTxb5jZ00KUaW3k
	M2QIY4xVTklqKEhjlJsmW9elJQZgdjpFn9w==
X-ME-Sender: <xms:OkeHZwQqjeHMwmFmw0XFr5lX3cY8zs8c8YnBceOdnaGldbuBIQordw>
    <xme:OkeHZ9yXgFhzlMFdPvX8skG5ObSOBJT_RYf7NTXj3nGfRI9pDknjx5nzAsDFJxFmA
    o-ocMOorEKPi9Acdg>
X-ME-Received: <xmr:OkeHZ92oYPW0LgKcaamLV6XoyTv3IPQkWzWqne_E-kjQIvlFwY3luyXPtjJBpCtbWdbkJWVzcfIgpIgFqN3HYPYYzrs_l1w_CrKn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrse
    hnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgvrhhssehgohhoghhlvghgrhho
    uhhpshdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OkeHZ0Dgfehy2robjB7drCX9qVn4rjMPPA3vkEa5zpbytBZg9pM6Wg>
    <xmx:OkeHZ5i_VYzRdtogI74AIG6On5eJ42n_KH1_IVzTTHOedlRUgCYMkA>
    <xmx:OkeHZwrAq7tgm4VQgWDDhXinbDnwXjrdaHmBnWBHGI3vFkg6Fyf12Q>
    <xmx:OkeHZ8hRf14QKVj_0mfHdAMlj-_ENCoNW1DDwJom0ie6y1mCiyCOrw>
    <xmx:OkeHZ3Zd480sjDKBymE-v77XEjP6jcwFOf3ufUpKXyyEQoaWqqjJOXdx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 00:27:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
  <git@vger.kernel.org>,  <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.48.1 and friends
In-Reply-To: <047401db66f1$f4ba6790$de2f36b0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 14 Jan 2025 21:05:25
	-0500")
References: <xmqq5xmh46oc.fsf@gitster.g>
	<4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de>
	<041901db66b7$c0c759a0$42560ce0$@nexbridge.com>
	<41d5de4e-c4b5-9564-6210-d9b8efddacb7@gmx.de>
	<045701db66da$36a358a0$a3ea09e0$@nexbridge.com>
	<xmqqo70827df.fsf@gitster.g>
	<047401db66f1$f4ba6790$de2f36b0$@nexbridge.com>
Date: Tue, 14 Jan 2025 21:27:20 -0800
Message-ID: <xmqqikqg1wav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On January 14, 2025 8:28 PM, Junio C Hamano wrote:
> ...
>>Will it be the resulting checkout of "git clone --single" of that tag?
> Then you can go
>>there and say "make", and as Dscho explained, what Dscho wrote in DEF_VER
> does
>>not matter.  The tag that points at that checked out commit is v2.47.2 and
> that is
>>what resulting "git version" would say.
>> ...
> In order to accept our builds, the NonStop community needs to be able to
> correlate what we build to a real commit from the git git repository. We
> cannot
> build from tarballs, as this cannot be certified by the community users.

So you are going to build by having a clone of my repository that is
updated via "git fetch" to have these latest tags, and you will
check out the v2.47.2 tag or the "maint-2.47" branch whose tip
happens to be at that tag.  And say "make" in there.  We may have a
wrong string in DEF_VAR in its GIT-VERSION-GEN file, but as you read
already in the above, it does not matter.  Saying "make" would run
GIT-VERSION-GEN script, which notices that you are in a Git
repository and not in a tarball extract, and runs "git describe" on
the commit you are building from, instead of blindly relying on the
value in DEF_VAR.

Which means your build will result in a version of git that says
"2.47.2" when "git version" is run.

So is there still a problem?  I am puzzled.
