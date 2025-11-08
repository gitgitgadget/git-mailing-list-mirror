Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F315285C88
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630991; cv=none; b=jXaaO6xJp9BMk7CexYBAd0NEFpO9KQpWkMYniw1gkMF68fAaU89ZzKohYsfT7L/o4XLooXm92mSvSWOSapGAbQUMVLBAQDB4SkwmTPQlTHLyF3eCvcTV3Mbpr6iyu3pxf+DKKR7Qma/k7textbqhsZYqWvFFXoYoJzJEnei8XWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630991; c=relaxed/simple;
	bh=jzhIGzdgNnTcrH/V8O7MyliX0Bo5+Bd7KMz/Tz6aIuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcBn/F3aDW0vzZfyVFB3thv/5xDkIt8YX4rsk0hpozODRJq5rV1x05Yqqvx6Il+Wsbrfr4KYP7DKujqZzJJui/anE8tGEdwgBzKunGmT714JEuXMzG0aA6Oo7drQz/m84poIOCPtizLgQiC2ddE/0muFLpd1d/6/lqWMTJA3XME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J4dTdQo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I9u8D0t3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J4dTdQo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I9u8D0t3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7761F140016D;
	Sat,  8 Nov 2025 14:43:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 08 Nov 2025 14:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762630986; x=1762717386; bh=zzFKhoMFR9
	huwPcQCBeyu+W4g3DK6gTRVCQyHzpHHzg=; b=J4dTdQo7pFHgUmSU8UsowZLLlZ
	9IO5JhOK3EMeQV+Jdad6yXPa1SvhrT0IxIsSCPhWaz5/+OTNjgv5NhBQ8rUXq1RN
	cSjOM9pOc521hi8OfI90VEsc+8LsKhdKLB9NmWIDms1jKl8Ods9cMOhmPwvbkZ49
	TUzFws5gsC6gkWOfQgMmkoL3ii57rvByH0NxyLviX29U6ILQqHSsRvTkf0qbio5+
	avhIddc0GvYzj5yFMJsmfgo9J4AhTcOXeZJzej7yuO8nmzYust40rhmy1/B7FoLP
	3rHVFnMoijwsK3gHLUE9aA338vshtbEO9ZWic0lNLEb444DBB/Hbuxq5IBKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762630986; x=1762717386; bh=zzFKhoMFR9huwPcQCBeyu+W4g3DK6gTRVCQ
	yHzpHHzg=; b=I9u8D0t3VfIgcZC38Czz8Qoj3nUGDXyFN6ofiFfQioDwe+ItGai
	8MF0Psd7GIEXnsmOpo/fjcXQZM1TGDAR96tfUOnybLijaks0HiCYm8Ef9k01FYW4
	cK/on0izW8A1+HNsjAAtK9zx7QO7cR6xdvrzpydRJ2iUOaV8q1KgqzN+U2tdj5vk
	kV8oNkAkELBPDKdFPwLvPifC2Y7f1jJ0U0nsOmpjdKotN1HNwrJnCWLr7gPdrYMt
	l49VCOIpowaOIgao+KklLBu4LhvwTxFzDSBRNnCph06YNRWO9PD/PjCrK9N/vZuU
	l6NjjLXH8CigJSmNZp9zU477/28tUJqboug==
X-ME-Sender: <xms:Sp0PaTd1OBHlC7RNf_YOsynl23L5HZ9DWKqvKRtRY8iU_jNUQfx81g>
    <xme:Sp0PabdW282H3kl13IIZRti6-dA5Ev5fvw1FL6mfTVqXbiUYDtnZ0DVRoQti5H_om
    3T4W6z0uBtaNBYzOdkg2S0rGRg1L8aEMHyP43NL3Yg7_zTigoJfVw>
X-ME-Received: <xmr:Sp0PaewxRETnFSP5_EZo_RXNto2iO9N1um5AzBzOwH2YqqgYXoIQk1v1XE1F8AGDSaHFsExMp1dIBWQi6WUrPg7-IxCPY55gR4Qp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleefgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjuh
    hlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Sp0Paa-3IpJsJibA1JeSmEdMsE99YVjaaOnPRuFClo3ISwtw3CxQeA>
    <xmx:Sp0PaehD2Mgfpacf0yEl4t-EzCMKgI8FVIp-GbVQUgjw4M7KdPr9XQ>
    <xmx:Sp0PaZG5RO0UwaVhFjdyzN3UyAyXK7w7zFI_mw3LdNutB8QOJbeusA>
    <xmx:Sp0PaV-kgQicpEDuj0YC7nOdnu8pSF8Pi8fj0wYWXT1FJ5m8cJDUVQ>
    <xmx:Sp0PaRSt71L7MJWTaNz28ow3OGnhDHJfWnWg7jIVMKQ24gLRZaFd-o3V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Nov 2025 14:43:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <xmqqo6pde90w.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	07 Nov 2025 15:07:59 -0800")
References: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
	<xmqqseepedue.fsf@gitster.g>
	<07cca81a-10fd-49aa-b175-17b49e4f1116@app.fastmail.com>
	<xmqqo6pde90w.fsf@gitster.g>
Date: Sat, 08 Nov 2025 11:43:04 -0800
Message-ID: <xmqqh5v448fr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Julia Evans" <julia@jvns.ca> writes:
>
>> I wonder if it would help to de-emphasize the octal representation
>> of the file modes, and instead give them names since (from a
>> data model section Git's file modes are really more like an enum with
>> 5 values than )
>>
>> Something like this:
>>
>> 	Git has 5 file modes:
>>
>> 	  - *regular file* (with <<object,object type>> `blob`)
>> 	  - *executable file* (with type `blob`)
>> 	  - *symbolic link* (with type `blob`)
>> 	  - *directory* (with type `tree`)
>> 	  - *gitlink*, for use with submodules (with type `commit`)
>>
>> 	NOTE: Git normally displays file modes in the same format as Unix file modes
>> 	(100644, 100755, 120000, 040000, and 160000 respectively), but file modes are
>> 	only spiritually related to Unix file modes.
>
> Then, I would suggest further deemphasize the "file modes" even
> more.  
>
>     * Git stores/tracks 5 different file types, which are
>       non-executable files, executable files, symbolic links,
>       directories, and gitlinks.
>
>     * Git uses one bitpattern each to mark these 5 different kinds
>       of things in tree objects.  These bitpatterns were loosely
>       modelled after UNIX file mode bits.
>
> The first half entirely avoids saying "mode" and that is very
> deliberate.
>
>>> Another thing we discussed and a better alternative offered during
>>> the last round was "base directory", to which Patrick mentioned 
>>> "we rather consistently use 'root tree'"
>>>
>>>  cf. https://lore.kernel.org/git/aQhcbHJjiI5GtV6Y@pks.im/
>>
>> I think it would be better to stick with "directory" here, because I've gotten
>> several reader comments saying that they do not understand the
>> term "tree" when it is used as a synonym for "directory".
>>
>> Maybe "root directory"?
>
> I am OK with "root" but that is conditional; only if it is not used
> together with the word "directory".  We are not talking about "root
> directory" where common directories like /usr, /etc, /dev and /tmp
> hang immediately below.  If we use the word "directory", I'd
> strongly prefer to see it with adjective like "top-level" that
> implies that it is something different from "root directory" but is
> relative to the project in question.

The above two points should probably be trivial to address.  I've
already squashed in the xml validation fixes to [v6], so let's
finish the rest quickly.

I have no more words to offer somebody, who says she does not know
why saying "branch records ID of the commit it refers to" is an
improvement over "branch refers to ID of the commit", when she
already accepts that "The *ID* of the object it references" is a
better way than "The object *ID* it references" to describe one of
the fields in an annotated tag object.  So I wouldn't mind if v7
still said "branch refers to commit id".  We can update it with
follow-up series as needed, and it is not worth blocking the rest of
the document.

Refs (including branches), refer to objects exactly the same way an
annotated tag refers to another object, or a tree entry in a tree
object refers to a blob, tree, or a commit object.  Recording the
hexadecimal hash is an implementation detail of the way how they
reference the object, and the phrasing used for the tag field in an
annotated tag reflects that by clearly distinguishing 

 - recording the ID 
 - referring to the object

as two separate things.  The former is merely a means to the end
which is the latter, i.e. the purpose of refs, tree-entry in a tree,
tag field in a tag object, and all other things that refer to an
object by recording its ID.

