Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D168467
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340441; cv=none; b=eWdg0y/QCDYtNTgsuCaLrUnR5sxnhFXiatd13Y8Uab/UexUEDDsNpHN3qLcAV5nHnAxuMszb0JT3BRDtlEHRdZWTMGtbP2gMT99Wu/nlWOlOutQmf4bPgQjc+HvEAPeQgb+GHZJBOwnLwC3LPl2NUGnLgf3Ku95YrA4l/yXJNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340441; c=relaxed/simple;
	bh=VzTyJMWCRqEOZ4fnzqY0RwmXqtE0htUnBKZJN22yuBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=urJ2lKlEAvLiVnV2zxUaPtpzp6qZivNYoCanWNyr1NcxmXpvP8F2SjbmfRGMLi0pbbTsuuNx4SG6WC74hhZfHS8v7OYBfugm4xIk16nuvaEnUxccTpSg0eJUEt+e8diRRl9ygd9Ojg3GU+j0sq9H9MSrpLRk2+pDEYVkoDUqaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lrx948wd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2RurUXh; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lrx948wd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2RurUXh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 825792540172;
	Fri, 31 Jan 2025 11:20:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 31 Jan 2025 11:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738340438; x=1738426838; bh=NhhRDDebo1
	voJy5jUzO/bAc0Ao/rBgfzPpaiKyE1Chk=; b=lrx948wdLXNttzziaS1SlGJWJa
	Yt7QcF7EliXUfP1nzw4B5uBUkLGjB2eOEwtbAnoyHeLcSQJtqhvIWP9xHtVlzSSh
	cT7ap7IEzNZQADjLsRlFaG7jWbw48o/vFYPXgmNfRpfIqYsUWkff3zxIxzB+3yqY
	8rz/mY0BzMoGqFNdNp0UvMWlJXEgeeCRHhrLd+K82llCIQLRXVL0ismYqUdXCGAt
	Dkzt2dIiR3p8x2uS5xPm6I6MZT+C+7aAIO3MfWUIRhesP04o/1RgZiQVAA0lwzCA
	M//G3JxhsWu3Wk1liKfLy8Te9+brwT/6/+gT4pea1qS8sCGknUdphRrGyXJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738340438; x=1738426838; bh=NhhRDDebo1voJy5jUzO/bAc0Ao/rBgfzPpa
	iKyE1Chk=; b=c2RurUXhjT0J5UTk6Jgt6eIQbi1RBhoydLIRgyZsWrc8OiF728P
	ywJZl0/4eCJwBhtqppSa7S6J4yx/TbnbRa6Sb+I5LzVWgAY4xC+Rxr2sq+hTH13M
	6S7c/MEe9k93W5NODHCSJp5F7Le2jQbWfa/xuJ1KrOrJIi74hBfXrtB9NM1kZBFo
	d2DEg2HH62RAWLHxQNcMhRiJ2HiAAW2wib189Z1E9dj3MRe60v7pv5xb2VGgX+w+
	urPPDouVzzvCRpv15E3REMu1LuLbRNPi9Qk0F6bNrdKLyVAnpMdCEAbhRZogUNSV
	svcpPct7Vh0P+EfbtpR0G+F1LgEI8PSslLw==
X-ME-Sender: <xms:VvicZz6H9MsRA0OZ5FvBJfUtQPm0bbtU0O8fG4f0EegmU2z3BnuDQA>
    <xme:VvicZ45lvUHwQX72jM4B5wk23JnaQjkVurCrq0J2exHmVHHjBucv9O73EPDoM---V
    7BhlqapM4MHZiuJVA>
X-ME-Received: <xmr:VvicZ6cpKuFzQyePqGRAGTc873vGN_JoBTBq8V_p7_xi5ays7a_ID7dXMnAz6a3PrgC_k_XwG4R0jNyeFSNmjgE8Cq4aSpJ0SmzK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvdefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:VvicZ0IyNz09aAQoy6wRoEKpGhvLTsDqXZ6gEbj8GusD1wkVbHR-qA>
    <xmx:VvicZ3J2w3QmMQRVdR_u50m24YaYpOM6CoyTqhQoTsxdZWUmU2ljEA>
    <xmx:VvicZ9x2ouG9RsswyD1sOiXUyFnkYiQZ3xGvtdPe9jcC_eFhQLmhuA>
    <xmx:VvicZzLVY9br1ePzU07Wu59hZChJSbQKaOPBWAbRYymrg7RRfKeOAA>
    <xmx:VvicZ_83quXS1bu026ZKudc2LPLNyDQbG6JNjfM5hpBDoh2emL4sHcQ7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 11:20:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] packed-backend: check whether the "packed-refs"
 is regular
In-Reply-To: <Z5zWE1M4u3NrROI-@ArchLinux> (shejialuo@gmail.com's message of
	"Fri, 31 Jan 2025 21:54:27 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r6-52eBgT4TUYG@ArchLinux>
	<xmqqplk4duuk.fsf@gitster.g> <Z5zWE1M4u3NrROI-@ArchLinux>
Date: Fri, 31 Jan 2025 08:20:36 -0800
Message-ID: <xmqqikpv9cq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> However, on a platform with O_NOFOLLOW, this situation will also happen.
> So, I think we may just use "open_nofollow" now and don't talk about the
> method one at all to avoid confusing readers.

Exactly.  That is what you see below ;-)

>> As long as both approaches are equally portable, I do not think it
>> matters which one we pick from correctness point of view, and we can
>> pick the one that is easier to use to implement the feature.
>> 
>> On a platform without O_NOFOLLOW, open_nofollow() falls back to the
>> lstat and open, so your "open_nofollow() is better than lstat() and
>> open()" argument does not portably work, though.
>> ...
>> OK.  I notice that the previous step did not have any new test
>> associated with it.  Perhaps we can corrupt "HEAD" *and* replace
>> packed-refs file with a symbolic link (or do some other damage
>> to the refs) and make sure both breakages are reported?
>
> As I have said in the previous comment, we cannot detect the error if
> "HEAD" itself is corrupted. However, we will check the referent in the
> later. So, we don't need to do this.

I still think you absolutely need to diagnose and tell the user
about the broken HEAD.  With your "don't check HEAD because a
repository with a broken HEAD is not a repository", a check run in
such a place may find everything else in the repository perfectly
fine, but because the user wanted "git refs verify" to tell them
about breakages, you would want to somehow tell them about it.
Either it is missing, malformed, whatever.
