Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CE24E4B4
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938815; cv=none; b=ENAO8rZ71NoBnJD7/rITBArNltK5DM6/MFhYyMNoEsJoo1msiZ91fAO3WzOZnvrS7ugLXhB3kRJnhc1//jXvxIIzEfsgq3wJF/c/zVkVLsgNBOHm5CVNOLQQcctUIe8r2V2llbcoj6MExJ3dWQgRTfozKHxpbxpC2ANwx/YBq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938815; c=relaxed/simple;
	bh=tF/3jvpvR5sMZ8x5tj3RtSRZ4f/Dz8VX01anc7aypfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FkHRGR+8l3eOWRh6j5pZnp6AMNDAIWTECOE6tyRmOBogesNCjZrIUDyIWKHTpm0xvnBYticqtZ4FaGb0K/1yhkACL4tICHAuoMoERtzRpXMTWGpbkYWZi+oDmk3f21CYHHDweaKzMZ9KBiJ0O1EuKKKB/lG3fBOmabsyYN4q6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J/yVY9wK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8P4XL5p; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J/yVY9wK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8P4XL5p"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D2BC7A009F;
	Wed,  8 Oct 2025 11:53:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 11:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759938809; x=1760025209; bh=D5Hd69SmZr
	YKDkT8sSR7Ky96cR8SUBD2F+6afqXKccg=; b=J/yVY9wKmpSKX6dro0GXVC5Vat
	16OeZ1LWO/XJ3x4MlllGHLPDCgNR+M2ZW4XG1K0HM3MDfVqA3A1EuPwHvd0afwCe
	LweSoCt4VcHQ5ff84Sz84L8q4nUDH0wFy3NTqOZO2z950caYTrR6jEEyGX8my0I2
	cjwKB5DFgTZmr0EuSoJRMx+HcWk5z8agGWkIbuPsl0Rhl7yCwYtyCdVdDYi9yViP
	eqbbOy+5Z4Okk8LTDJGJb3P0vnBMT08wSkYa3Iae9b/xAA5sJfpWFZ85prgl3NCD
	JIqX8QVF+wRLJCBsmgJv1igPUNa0YRN5rUyL85hfXy1WiIsPCxk2y1Dhpwaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759938809; x=1760025209; bh=D5Hd69SmZrYKDkT8sSR7Ky96cR8SUBD2F+6
	afqXKccg=; b=B8P4XL5pXfob1aXWxDihVuBVnybrvZPzGuiaT4+g6BYYeLJYrP9
	w2KlwpA806KO3vc/hXb9vY24EFKxf3KDtcKE5NiyHEgfV5biwXpdEMY8jAalSMiL
	2SzKbN3F8U4/PNzwu5NzwIW3Toq5PhoWFFkUGyV0XN/ibBMS6kh/bCxbc0BxqJsa
	GJ3XjjLgIWYQbz0JaY+jTopY4x694bCqSuW1Pfwd9DTeWYZnaZx2Wn1AqhL+HSlp
	JvBvEF5a8tB+DDpa8VMGhMER2O5uXfRg41QquYJWXwTFL3U8SAbnOJN5CnTBKYKJ
	cNHfb5dhCJaJZyYAmsH4jd/vG80IYa0qNxw==
X-ME-Sender: <xms:-IjmaFtlIW5H7YTVgkNNmkxLGrLf92mptFCt8nkeXhVZ9c66ylU7KA>
    <xme:-IjmaFXQWFriGkJkl74nW0uXB4IbQl-QIc1gbIycAjR4owLLkl_HijQRGFZjAqeff
    dYV6cVs6Kfir19R13rwdjK7e2pPad3DXsRCiZmclRextrie9udvNA>
X-ME-Received: <xmr:-IjmaBGla6oCDFPPcWh4jap3Uv7T2tADOuvT331Oib3ttCNEmEsv0-GXmb5V_yqDQN4rmB7mWI3dW6Y0WUm-TXbvwuukUkYcQAV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjuhhlih
    grsehjvhhnshdrtggrpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-YjmaH24b7WbCI6HwiXo79iit-B8AMY5Qozbt8HMbfuB0-v77a_uVg>
    <xmx:-YjmaDOYo05JsKthbCpFJAAIT-xNrbZZI3sM5aP-dRt2rUPArEi7cg>
    <xmx:-YjmaG75ZQOzgvI_v2ANtgQFmF8VLguUcqW9bejeXn0NBh93Ot6UrQ>
    <xmx:-YjmaN1PJbzsQlSI3TP-dKjPbv9-9WI_Bw1MEFYq3n9V9Xp26K8sQg>
    <xmx:-YjmaPG4ndOc3HPoT0JuMuXVu9Q-rg1dnUEtIooFo7n9beJwFoCCy3zT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:53:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: add a explanation of Git's data model
In-Reply-To: <aOXmA5L5LsUuXWEh@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Oct 2025 06:18:11 +0200")
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
	<aOUkZa4_fq1hho7Q@pks.im>
	<dbf0727d-66bf-4698-aa21-d69da86027c3@app.fastmail.com>
	<aOXmA5L5LsUuXWEh@pks.im>
Date: Wed, 08 Oct 2025 08:53:27 -0700
Message-ID: <xmqqecrdgzk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I sometimes hear from users that "commits can't be snapshots", because
>> it would take up too much disk space to store every version of
>> every commit. So I find that sometimes explaining a little bit about the
>> implementation can make the information more memorable.
>> 
>> Certainly I'm not able to remember details that don't make sense
>> with my mental model of how computers work and I don't expect other
>> people to either, so I think it's important to give an explanation that
>> handles the biggest "objections".
>
> Hm, fair I guess. In any case, if we want to mention this I'd leave away
> the details how exactly Git achieves this. E.g. we could say something
> like:
>
>     Storing a new blob for every new version of a file can result to a
>     lot of duplication. Git regularly runs repository maintenance to
>     optimize to counteract this. Part of the maintenance involves
>     compression of objects, where incremental changes to the same object
>     are optimized to be stored as deltas, only.
>
> We skip over the details, but this should give enough pointers to an
> interested reader to go dig deeper. We could also generalize this to
> objects in general, not only blobs.

Interesting.  It is of course not wrong at all, but it was not what
I would have expected for the first explanation to help confused
folks who say "commits cannot be snapshots as they take too much
space".

To me, it was a realization that even in a project whose tree (think
of "du -s .")  is huge, each of its commits touches only a handful
of paths, hence a large portion of that huge tree would be shared
with the previous snapshot.

>> > This misses "refs/remotes/<remote>/HEAD". This reference is a symbolic
>> > reference that indicates the default branch on the remote side.
>> 
>> Is "refs/remotes/<remote>/HEAD" a remote-tracking branch?
>> I've never thought about that reference and I'm not sure what to call it.
>
> No, it's not. I think the term we use is "remote reference".

Honestly I didn't know/think we have any special terminology for the
refs/remotes/*/HEAD symref.

Historically HEAD did not "track" the remote state, and we did take
advantage of that fact to use it as a place to record the preference
with respect to which remote-tracking branch we would want to
primarily interact with.

But these days because the protocol is capable of expressing where
the symrefs point at, the users can make it track just like all
other refs inside refs/remotes/*/ hiearchy.  So I personally think
it is OK to call it in remote-tracking branch.

Thanks.
