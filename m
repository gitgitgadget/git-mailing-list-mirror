Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17E846F
	for <git@vger.kernel.org>; Tue, 20 May 2025 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775430; cv=none; b=nT1YjaqM3uDxWp7lHP0njxsEiywsUPqsrs2mfZDtFVIZ9N6IX570epAk16ualdPCqT3z3qoNe7z5jwsZmLRa5BNuJVWokb1FQ2P1alqYaVTL/pjLXslqGte87OXGVZ+v5q1GpWbRF+Ctw6lGwTu2RHRp5mY+ZOHYi/OpfVMo73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775430; c=relaxed/simple;
	bh=2UivgZy/YqCSdcR7KTQ4XJFdzHvZa98izhExraoQzdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXZNHuBFCbZ70O7lH5jAjNhvcasP1T/IGB8EvwI28TcPDXxgLPYmuS495rhVxpFuT9xMafIeZUDhvJpyIf79sqZHqQIvdKcECHR64MCiIb0wWovMXYbRGMnvvVxPLVXfGVzq6JZTQ3J5gCRa1Cupzmb2pUlBk6k85bhNdMes3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n4EZfCUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wAqn7Do4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n4EZfCUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wAqn7Do4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D4A825400A9;
	Tue, 20 May 2025 17:10:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 20 May 2025 17:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747775426; x=1747861826; bh=3dotM7W0A9
	rjd2WY3+TIvFMupNznX5URmfE3PTlOew8=; b=n4EZfCUfc6LLPlYqJ8qvoh1c5V
	G1E1t54pjJbi3y/u7ZUU5Cf4uXiCPa7cPASUOlIeI5SpMqfrOqIpcEgjW+6tdFSV
	t7KcFaQIHT1lZIQt5V7W69Yzt0cpU42xYpyEo9LV5hQXDvF5DZyaPdOpWBx6Z2W2
	+vygBbYnyTFhN+5ehe3pN4KWwrWqzMx372vZsh2AB+UMtPgzRQuyPrN74ahYzXR/
	aHMO6h+Nis43ZOSChDtNDxL83Y87sN53aArIP+lXhIJ03K0darpmwUByZsMQnh9F
	jTpwRXT0n4u5qBSDL7XYsQQgVbkG042CgLBg9aK+2RDq0PLK0m5ighUKhXdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747775426; x=1747861826; bh=3dotM7W0A9rjd2WY3+TIvFMupNznX5URmfE
	3PTlOew8=; b=wAqn7Do4i+nXL/s/p3lvfk2lDpE0BvIVSWbEXHoV79nQn5cxt+Q
	EvIhgreXtIxKPGSKXknCdDV7EnLHJVS5YvygHsPxmZJMUxn7mrjFCn9yDj4Ti6ax
	RnglOy01We3KPLw98Q1pE5QK4aCj8mxg5R2cF7BzXaT97EE0ltz0Ig/pHs02vrfP
	oSDdvaziyJGXbDa/rz6CTjZIezUpgYZ1T8zlmC8rOY6S99lXSqStgwq7gmiMIi2M
	0TAOJeYb5FviNqFGNZE7xTbML2n2QXJnvp9GWFb+o8sDAZNRZyMOuPOgTwlAiczj
	kk2l68Hw1jWXhMnoELY9dq7OpxmU+Eo9YCg==
X-ME-Sender: <xms:wu8saI8bsaicAcqvMW3AWRZHQZaWbRwW1bsyHQJqb1f0dL2wOqHN8A>
    <xme:wu8saAtS9aNZgCaAcHl6iiuwila8nTNUbjC-x47F5drfwXbGJ5cn9P5aepwA7uUyd
    FUVgpL-U77FJMFpQg>
X-ME-Received: <xmr:wu8saOAorlq_ZxFveJluGbH33bgYovFVBwobigblkT6OS5WFz3kV9m8g-jofA2Swo2hlccbJlkBjotC7eLbP-xxo418cqIQP6G0IMGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghi
    nhculdegledmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrh
    homheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtgho
    mheqnecuggftrfgrthhtvghrnhepieeuieffleehudelleeffeehudefveetuefhiedtff
    egudeigeeigfefgeefgefgnecuffhomhgrihhnpehmrghkrdguvghvpdifohhrughprhgv
    shhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshgvihhjihehgeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghijhhiuhgthhhihigrmhgrsehgihhthhhusgdrtghomhdprhgtphhtthhope
    gvihhjihhutghhihihrghmrgesuhhsphdrsghrpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:wu8saIcTREgJC9e3zUCqcWVXum856ghQfJLHzYp93RyweGIqMm-ErQ>
    <xmx:wu8saNNePz1YlO52zdbpSmOaVBRgK0JMa6wrEBGXmWQGkhFFx74M_A>
    <xmx:wu8saCmOl-hCbC0KMtA8NpvfK2eXE_dO1DK82j6Fpa35Xaxw-JmzUw>
    <xmx:wu8saPvuqUC9jwQ94YPJ2VMWOJnaHwqNdA2ezG0ODT3Sto5zZwJGXQ>
    <xmx:wu8saOxiCSsyOVPTfr_zkjNLwC0MW4HcLmcq4WgGjJ0hWV8aUo94XtL6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 17:10:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Eiji <lucaseiji54@gmail.com>
Cc: git@vger.kernel.org,  Eiji Uchiyama <eijiuchiyama@github.com>,  Lucas
 Eiji Uchiyama <eijiuchiyama@usp.br>
Subject: Re: [PATCH] /: [FirstTimer] Remove DISABLE_SIGN_COMPARE_WARNINGS
 from file add-interactive.c
In-Reply-To: <20250520191859.136798-1-lucaseiji54@gmail.com> (Lucas Eiji's
	message of "Tue, 20 May 2025 16:18:59 -0300")
References: <20250520191859.136798-1-lucaseiji54@gmail.com>
Date: Tue, 20 May 2025 14:10:24 -0700
Message-ID: <xmqqplg3gf9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Eiji <lucaseiji54@gmail.com> writes:

> From: Eiji Uchiyama <eijiuchiyama@github.com>
>
> This is an initial contribution to git, based on the SoC 2025 ideas
> for microprojects. It removes the DISABLE_SIGN_COMPARE_WARNINGS macro and
> solves the warnings generated by running make DEVELOPER=1 -j4

Your first sentence is not something you want to carve in stone as
part of the official history, and should not be part of the proposed
commit log message.  Yet, it is very nice of you to tell your
reviewers that you are the first-time contributor and may want extra
help by community members.  If you want to do so, do it below the
three-dash line that is between the proposed log message and the
diffstat.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  I would expect to see something along the lines of ...

    Subject: [PATCH] add-interactive.c: squelch -Wsign-compare warnings

    A handful of functions in add-interactive.c compare .nr member
    of a string_list structure (which is of type size_t) with a
    local variable (which often is of type int), and triggers
    compiler warnings due to -Wsign-compare being part of the
    developer configuration.

    Squelch them by DOING THIS AND THAT.

... but I'll refrain from filling the "DOING THIS AND THAT" part.

> -	else if (index + 1 < list->sorted.nr &&
> +	else if (index + 1 < (long int)(list->sorted.nr) &&

Well, by sprinkling casts all over the place, you can squelch almost
any compiler warnings, but the real question you should ask is: is
it making the code more correct, or at least not worse?

For example, what does the above code do on a platform where size_t
is 64-bit unsigned integer, and "long int" is 32-bit signed integer?
For those who are reading from sidelines, "index" here is "int".

Very locally on this line, I think the more correct fix may be to
declare that "index" is of type "size_t" (not "int").  We may also
have to barf when "index + 1" overflows "size_t".

But do not go there yet.

I think the real culprit is that string_list is misdesigned in that
most of the code there work with platform natural "int" type
(e.g. get_entry_index() that looks for the location in the array for
a given string does bisection using "int", add_entry() that returns
where in the array of strings it inserted the new one using "int",
string_list_find_insert_index() that finds an existing entry or the
location a new entry should be inserted into uses "int"), yet it
declares the size of the array of the string using "size_t".

Those index-yielding API functions (and internal implementation
details) in string_list should be using "size_t" to express where in
the array they want to point at, or "int" that may be a lot shorter
(and has only half the range of "unsigned" on the positive side)
would never be adequate.  Or change the .nr member to "int" (of
course, the code that grows the array must be careful not to
overflow .nr and let it wraparound---but the code must be careful no
matter what type it is; declaring "size_t nr;" alone does not fix
anything).

The string_list API must be fixed first before fixing the calling
programs like this one, I would think.

I'll stop here, as all the other changes to this file were due to
the misdesign of the string_list API.

Please do not get discouraged by _our_ code being sloppy and GSoC
microproject ideas page being under-specified.  Neither is your
fault.

And welcome to Git development community.




[Footnote]

Quite honestly, -Wsign-compare is mostly garbage [*] and I wish we
did not add it to the developer settings.  A more effective way to
squelch them is not by sprinkling the casts like this, but to remove
it from config.mak.dev ;-)

https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

