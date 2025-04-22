Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F00242D73
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355744; cv=none; b=ovSpMgJQMI2Yl4Vg8P0efQJXvU7g1rs10vo4JAqqQ1AawuKV5B8cC8K6aq8NYydy8nqD17d9aXun469LGIYFOPiJcYiMUb2ZZTvAivlCrxUbFl83T5QuFb1KU0NIk7dQ3OjGUbF7hTsskXT8478fCUGfB7HJtoCUOB9mKVPtJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355744; c=relaxed/simple;
	bh=nnbxpLbxk+KTd0lzzVTnLQrbVi0ZCylVzQd5821zTeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tU05imMbM+lawOItFzuEgCdqSCdMoQ42RadMZlS4jCMRtvtFppo7o+LQGqlPcEfz7EFsAocvUksfs72IJXvkIPl6vmG6JlwKj1GUpTRmuS1EGEB++Cc4ZhkiyXIcHyBqmn/2AYJNzcwwu01pGU1ePWgXVUTjogCOFdkoudZJU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YAIlwlnP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bz8fLRQJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YAIlwlnP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bz8fLRQJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A6992540191;
	Tue, 22 Apr 2025 17:02:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 22 Apr 2025 17:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745355740; x=1745442140; bh=yZjjF0I9zw
	PiNS4BowGudS0f3Sb/qylp8okkiZLq7ZY=; b=YAIlwlnPSsYVXgs9LWP8Gxt+Oc
	5ls96HZnySD/CeDC+BkchkRWArXC3GWEhG6H3jxYhfzV1zjtfS6PHYQy+d/DFM7R
	lI2JgktIxDd9tqnljIylEDVhoIB+I5ilkl/TUzKfD/nHUT4iO9ePh+fjGoEyhlKj
	ENYAMKnAD3vD19nNa1OTllRvsiBDu9CHk+E9r59dPyIhnf2UQeztti1OSvBtJF3V
	idDNkbvC3Zuex7QCf1VqCag8Mhibok+faCEU4QRs0X9IphJMC7NNokt5OZK2MRYo
	8RkS/XK+9Ztwa+t9fzGyyzFXheeCXXJbPTea1xYKBzMBYCJZUP5PL/OYpJXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745355740; x=1745442140; bh=yZjjF0I9zwPiNS4BowGudS0f3Sb/qylp8ok
	kiZLq7ZY=; b=Bz8fLRQJss/sdv16wim0GTlfRwrIq7dXZhM7FEW049gzHonG+X6
	9f/XaXLZXDnQKkfo3EUayy3ZpJxpkl+ifZ4Zq6zW5zfdxdtj/aDqXHr4YmiuNaOD
	OGQjrHIL0gZNkWG8k3N0nowYuwMeBwDJ52ZJREezumI5Xa902iOd7hzdRPZHjO+n
	3KTnR3cxjJ+GusR/mzcd77cyW/c57fyx0NGVkoA003yaW7rYIF8zZmtC1/KofcGd
	EnZpXUviDopSPBXpd6sWCby3M4hBTkRqwsToJSdW0K5VdEWjeAUIrhh/420VmrQ2
	bBp1Yc2LukfBaE2jO7BViPjyhb/ga8VAP8w==
X-ME-Sender: <xms:2wMIaHo3nkxxElhSFr_QW9_x7Rr3LoskKrvwwTHprS-sVXIvfhh3hw>
    <xme:2wMIaBpXo_0F7OFYxxA4q74-9iPYUI1tFpmb8_dgr6ji9ozsNNjLvgOfS6mzEVYWI
    q5AznxkIBHG356r1w>
X-ME-Received: <xmr:2wMIaEPKJY68d3LMVX7aIoR6Wgi2WY7wVawz6K2r3cMP_tl5w6GV45sLVOYKlkWNbhmooLHcWXREURXC8YrF00eAl-6zz75u4HWu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2wMIaK68dk7CaG-c8VDswfVToouc6t7oHVFMaxNJFLsiDIAdxPPy3g>
    <xmx:2wMIaG5uvibIMsTZU6S4rZFwXDv4ED1xqxvET5gTW515kNC-omboJA>
    <xmx:2wMIaCh1mkgLMR9ePws1Jh6VD0eGEMC0odwymyLpa_pJ5cdB4n4gbA>
    <xmx:2wMIaI5jg9KgTcE32Gml2oxcaYyc0i3onbbxeGUs5flokpfdaUquFQ>
    <xmx:3AMIaMF8KEqR8DsAWrvSkBvhsF0n57UIBtMTCK6Gk93pI8NZB9MlL3Dw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 17:02:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/5] string-list: fix sign compare warnings
In-Reply-To: <aAett8cJuDJ_FSdw@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 22 Apr 2025 22:54:47 +0800")
References: <aAetW0dan8S3Fljq@ArchLinux> <aAett8cJuDJ_FSdw@ArchLinux>
Date: Tue, 22 Apr 2025 14:02:18 -0700
Message-ID: <xmqqy0vr3o6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> However, for "string-list.c::add_entry" function, we compare the `index`
> of the `int` type with the `list->nr` of unsigned type. It seems that
> we could just simply convert the type of `index` from `int` to
> `size_t`. But actually this is a correct behavior.

Sorry, but I am lost by the last sentence.

"this" that is a correct behavior refers to...?  That the incoming
parameter insert_at and the local variable index are both of signed
integer?

> We would set the `index` value by checking whether `insert_at` is -1.
> If not, we would set `index` to be `insert_at`, otherwise we would use
> "get_entry_index` to find the inserted position.

To rephrase the above (simply because the above is literal English
translation from what C says), the caller either can pass -1 to mean
"find an appropriate location in the list to keep it sorted", or an
index into the list->items[] array to specify exactly where the item
should be inserted.

Naturally, insert_at must be either -1 (auto), or between 0
(i.e. the candidate is smaller than anything in the list) and
list->nr (i.e. the candidate is larger than everything in the list)
inclusive.  Any other value is invalid.  I think that is a more
appropriate thing to say than ...

> What if the caller passes a negative value except "-1", the compiler
> would convert the `index` to be a positive value which would make the
> `if` statement be false to avoid moving array. However, we would
> definitely encounter trouble when setting the inserted item.

... this paragraph.  Not moving is _not_ avoiding problem, so it is
immaterial.  The lack of valid range check before using the index
is.

> And we only call "add_entry" in "string_list_insert" function, and we
> simply pass "-1" for "insert_at" parameter. So, we never use this
> parameter to insert element in a user specified position. Let's delete
> this parameter. If there is any requirement later, we may use a better
> way to do this. And then we could safely convert the index to be
> `size_t` when comparing.

Good.  As we only use the "auto" setting with this code now, as long
as get_entry_index() returns a value between 0 and list->nr, the
lack of such range checking in the original code no longer is an
issue.

Having said that, in the longer run, get_entry_index() would want to
return size_t simply because it is returning a value between 0 and
list->nr, whose type is size_t.   left/mid/right variables also need
to become size_t and the loop initialization may have to be tweaked
(since the current code strangely starts left with -1 which would
never be the index into the array), but fixing that should probably
make the loop easier to read, which is a bonus.

And add_entry(), since it needs to do the usual -1-pos dance to
indicate where things would have been returned, would return
ssize_t---or better yet, it can just turned into returning size_t
with an extra out parameter (just like the exact_match out parameter
get_entry_index() has) to indicate if we already had the same item
in the list already.  It is perfectly fine to leave it outside the
scope of this series, but if you are tweaking all the callers of
add_entry() anyway in this step, you may want to bite the bullet and
just go all the way.

Thanks.
