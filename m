Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316D213E81
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568233; cv=none; b=gz2imK7EFeJ/hr+OF2YBo3xqWYKagf1tA8T2ZcfhDkWtwBg7NNW5eOtRHYq5Im1HECwGQBj4T4+uEv+ieOGqNtOJ1+wZ7IgtKJ46n8HLn6nrZz1XusduWmGhP5HuisGSToMnGwHYOLZF4QGilUdF7RIQ1FHBj3YU1KTj80T1FRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568233; c=relaxed/simple;
	bh=f8J360nG+jsUrfAoiAFcwGcDU7TvSmiBBtwlPgFIdL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4ZgLkBftMuYDJ84qmIKZQSepAtEG66NalyCold8TJqE9ZHFlXWehftuFsfLl8QhpuhTVuWj6iZ48oo57zDHJjNx0NkveuuqHbVV4VtHS0EgQM5FjOQDWaOJEQbXHdN2JCJwhkur+ewl2nG6MHmGIDGF+ZvX2CZP47BBBP2/J6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nUYz3zRD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JD1C5XzW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nUYz3zRD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JD1C5XzW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E267B25401EE;
	Wed, 22 Jan 2025 12:50:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 22 Jan 2025 12:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737568230; x=1737654630; bh=f/mnMb1wHk
	mN6bivZsZ26s7zrO9g/RW9ozJ1JsXjoNY=; b=nUYz3zRDPbpG7sF+tG8PSHPDP4
	z7cyS9HnU38ol89zqoYNWAAfWlbjReKZ+4DumRqo4BN1pYHRpcvho7CuG8jnl063
	lEoYURXaAlhrPI44EuDqOOhIiaI1yWTf5NgjAl9x4bK3zcd28Zi4VatT0qyHc5M8
	dY/7po//ERW+bszH4wrzMgR9sRGMeEEVtx40junYJ4sGDwm7YvU5O7mj8UANKl6V
	IDxdMK5Dx21jvuJCQsN+wxUHQDJA5BU/ERr+fOLD/TQGtGg4JW7CHtNa9UJNqJ/f
	2Qfx8aulzcKB2QvwCqoTZNL8fk+csMWAifVBXcozMYpPC/6agfV44SyiHMNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737568230; x=1737654630; bh=f/mnMb1wHkmN6bivZsZ26s7zrO9g/RW9ozJ
	1JsXjoNY=; b=JD1C5XzWUeDB42zN0Qjjl4j7KluxAMVgKWR5JEsBIa9PWKxqBj4
	43cwZA4nPKuPPLX2oU7smYUogpqTjOpllJ0dOX0k7VZh93U+AYPwqWkDqhzIatPY
	EuBbgZ766cHVIBH3V8bziSPXgTj7Jp2HmmhanLrLyf7FiEq8A7OJ6IVKw2YVTtSz
	6KHkTnwYkIxCELdHy6nDyltKM7mmV5tRfSM+CPsTqEi2JMzRJggbz1ywLXIAu9Q0
	JsUOfhmRGVxSSZUdl3v+1vERV7Hj6qN4NkN7LLYk6oN8MUe+biTVgC+eNoKku6HL
	chK482uhhAq5gk3lv7xUgt4rgGA00NJcuZQ==
X-ME-Sender: <xms:5i-RZ2EcanweP6Znt9lfbI6TDkJ1Yw8JRoEzBK1jgiyDH-ZTEQm2Cg>
    <xme:5i-RZ3VXD95nsxWnIV_lOEgYbnUYy5h16tLEHhkRdkUhlH37Z0GLfCU7bSOhFi8Fd
    q1Z9huAgHGsluYNyQ>
X-ME-Received: <xmr:5i-RZwKzV2LKsDtxgMnqNmYgnf6ToEvMsIAHZTfckOYZ61ZyFi2FYaAIdd1_n1Mk6b8L9mfyBVQmKNpwmDcB90_m_cKWbTGEE3PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5i-RZwFw5rA36c_a3-c-WwfSK9VVpBeC8N4zAUX3pRMILNP_T2ngUw>
    <xmx:5i-RZ8Va7rVzsX-nF_rVkIQoItHPVrZX4UaINK96xoFC6zChqdyO1A>
    <xmx:5i-RZzNAjKC5zYqDIrPZ04ivqD-MUxKR723Easkj8TZgrygPtbV0AA>
    <xmx:5i-RZz25BjnEVPpNlNnnvMqyeF6aaXZ3WCbCJTkLRvkuM8idhNHsoQ>
    <xmx:5i-RZ6xSrYSJ7XsktGbPGIW4t6i8b96KDSjLQ8ZGjjnHMeNzR3swHyRH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 12:50:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] reftable: prevent 'update_index' changes after
 adding records
In-Reply-To: <Z5DgxQuc2j_-5GHg@pks.im> (Patrick Steinhardt's message of "Wed,
	22 Jan 2025 13:12:53 +0100")
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
	<20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
	<Z5DgxQuc2j_-5GHg@pks.im>
Date: Wed, 22 Jan 2025 09:50:29 -0800
Message-ID: <xmqqzfjiwxei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +static void t_reftable_invalid_limit_updates(void)
>> +{
>> +	struct reftable_ref_record ref = {
>> +		.refname = (char *) "HEAD",
>> +		.update_index = 1,
>> +		.value_type = REFTABLE_REF_SYMREF,
>> +		.value.symref = (char *) "master",
>> +	};
>> +	struct reftable_write_options opts = {
>> +		.default_permissions = 0660,
>> +	};
>
> Nit: it's unnecessary to pass write options. Other than that the test
> looks good to me, and this nit isn't worth a reroll.

This write_options opts is used later in this call.

	err = reftable_new_stack(&st, dir, &opts);

and "git grep reftable_new_stack" finds many hits, almost all in
t/unit-tests/ hierarchy, only two among many of them passing NULL as
the "use the default set of options" signal.  And majority of them
initialize their opts like so:

	struct reftable_write_options opts = { 0 };

So I agree that this one should pass NULL to be more explicit that
we do not exercise any special features from the API, but so should
many other existing callers that pass such meaningless &opts, I
would think.

Thanks.


