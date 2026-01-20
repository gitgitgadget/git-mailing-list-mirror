Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA64352941
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933620; cv=none; b=LIAt0sykBA9YkVRGmNk7osnhcyJ2HFsN5T+axhrDZwOuT2yQ9sn7KlRbnLpO5H/4yyeu2fueFw4eCpp9oH3pKq6y5JaUhoMFVFURf2712Sn1h8L5u2EIjoEEBXM+dwDWgsCebiYwaRZEXJMfq+FYC5rS0MoGCNSQCgG1wmiRWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933620; c=relaxed/simple;
	bh=JszDzGHc05gLsgyUAlAwkIBaGoeOyWwiiOCIn/ut9tE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4nKR4UYMgJYRrpza7U8L9cpgREr07wPoKeFDPl7jC7+xelNkPgpqb6fKEf4aGHD5dmiBdbb6r0+qvva2HPQJU97oxUdiogH0VA86jY4xbtC1HU9dCrk5Ly18OeTgBOl1H4vFE/lDG7wVEeS5Z784so0mFibf3QEHVSGTHbvSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nwTg8d2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfBqy3as; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nwTg8d2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfBqy3as"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7477A7A0088;
	Tue, 20 Jan 2026 13:26:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 13:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768933617; x=1769020017; bh=3RdSz70tWO
	nDCYnF/BnF6scfIEO6m2C1EGMzotSRWdQ=; b=nwTg8d2TxmC6ZatUvRMLEYPKJn
	y4jIq6O5CHm4YWUwqwKRcbeHtBbcH25iGLZltR87UukfATLSfmN1QI0vLn85CjSr
	TqcwHUkID4n3OquNx3JdiK98lo09dt9EnP7fQ76N6v/EIZ+yu3/mV2oSAMlyoLwB
	fdAJl2HV/sWWwGmuJBrid2hvJyI1GMtgdbOm/7WjNyQDU8vePHEx75JbYsKbcC7c
	Z32srBWerBHaDGcrXsfmr5NVhhNY/xyodY1vyDgTRO1kliiaifD0xfwX1ZKX5iNl
	VJOYEsi7H6mT3sVkpCMbapNzzMfsTBlLhD8AP2dn2znYgOlU9zwr96oxJ3cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768933617; x=1769020017; bh=3RdSz70tWOnDCYnF/BnF6scfIEO6m2C1EGM
	zotSRWdQ=; b=PfBqy3asTdqCtJzV5UNShqEjqqu8lxwEiuGFwTg7cWYDYqF9MUn
	dBhdPxE/RtKq3jvEpj1bM6uBPFLpAjzF0vVDfW4Ltz/RKB0XFHsh9GUHnkhmfhJX
	9Q7S7h0c8P8UTigQsVckpSikF2xEy/qJGh2kVrMAu6uZkzvq+jc86QyDHteVVh5b
	FyK7Q49KD4sLRYXt83uaKbfeSqkcq4ONN7A9vbOAQa9GVDopIMg+/DsUAbGeXzgT
	CC5eniT4KNan+JA8nwjuoEHrpUy8i9DS27x4E3HHTX6YohG1pg2kwTa2T3W/Q1iy
	XRm3ctdVfAhGkXpIRUtlXEUmE8ptStMA4Tg==
X-ME-Sender: <xms:8MhvaeamYiYLD6r0-ARDXN6igLNruyHkjd5nW2gUAZudPpvfFjx_gQ>
    <xme:8MhvaS7enM-1B5q28-Ft1holxVP5rVyV1GxTrZCKO9oG5_S_ZioJliPr2cOj0Oij9
    Lwi-ijuKG8Pb-I5fXsZDEqfN7S0GSujim5G8dmiCq7kVRS-krpNEg>
X-ME-Received: <xmr:8MhvaZCq5UCAHwXYp_0yNmfi4Fekz4n4DOAL4RJ_9psYx18-_vn1bIvnhCIZ63qKfd-nbPTUSpwH7VhCs_VmJ5PXjEPWSFVrXQ74jqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8MhvaQdZwxkcDdt07Uw2nlIsU2LpnHz8aiOCueFlT_B72Y3HSWpG3w>
    <xmx:8MhvaQJ61vQ1zopjgS-ihszQyYOfkpOdcXgrBsGtHcIFAF8WwrkwvQ>
    <xmx:8MhvaT0AOR6OJxYpVSu6O3MttV0uHxy1ZJYcRXrCYg_6zL1f_NBWww>
    <xmx:8MhvaahCe3tewP5HM5kIuRzoSwnYTEi9K9lt5_Uo5fE_VkNDYiLHug>
    <xmx:8chvaRv08DpWXA0AbARUD-yVp6k7ukIfYjLEDxYFR_4ZaplUvqvgjjTy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 13:26:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Git Mailing List"
 <git@vger.kernel.org>,  "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [PATCH] mailmap: add an entry for Phillip Wood
In-Reply-To: <5a4e7da4-d295-4beb-9f37-b2ce4e10df35@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 20 Jan 2026 14:52:48 +0100")
References: <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
	<5a4e7da4-d295-4beb-9f37-b2ce4e10df35@app.fastmail.com>
Date: Tue, 20 Jan 2026 10:26:55 -0800
Message-ID: <xmqqtswgywb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Jan 20, 2026, at 12:01, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> While all my commits appear under the same address, other addresses
>> appear in some commit trailers. Map those addresses to the canonical
>> one.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> I'm not sure if we actually remap the address in trailers but
>> we've certainly talked about doing it in the past.
>
> Yeah it does.

Hmph, are you sure?  My quick experiment tells me that the trailers
are not munged.

    $ git show --pretty=fuller -s | grep '@'
    Author:     Patrick Steinhardt <ps@pks.im>
    Commit:     Junio C Hamano <gitster@pobox.com>
        Signed-off-by: Patrick Steinhardt <ps@pks.im>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>
    $ cat >>.mailmap <<\EOF
    Junio C Hamano <no-such-user@google.com> <gitster@pobox.com>
    EOF
    $ git show --pretty=fuller -s | grep '@'
    Author:     Patrick Steinhardt <ps@pks.im>
    Commit:     Junio C Hamano <no-such-user@google.com>
        Signed-off-by: Patrick Steinhardt <ps@pks.im>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

By the way, this is totally expected as there is no guarantee that
what comes after these colons would look like a human-readable-name
followed by an e-mail address at all.  Some projects deliberately
omit e-mail addresses from reporter credits to protect themselves in
jurisdiction with stronger privacy laws, some trailers like
"closes:" do not even point at people, etc.

Or perhaps your "Yeah" is about "we've talkined about doing it"?
