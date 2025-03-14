Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46420371B
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975005; cv=none; b=ptZgbbV5LkrQzHrImrLr0EW2rUlCFiu6CYfyPGVVLsT4aI3ndaU+t2z0ee3Rsbk3z+xYNC4+YBWulWC1Djc2baAg/OCm2LjVmYdd7s+ItTCEiwrATwlHKnHjU5rLQSBgqW1Ib71s3rH/CZ7vmSsWBC0iIcrv+um0mbQqyg0yrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975005; c=relaxed/simple;
	bh=sRUHrbPesbxeh/c3olgfgjhVlnmfGbj/z2bhzyAim0M=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q3h2zbABR7IOBAaGsSDgslkeGE+IK3nYYGHE8TXaa94SnzTqwhOght70LSNyfBK9MZWA7rUETPVHzXK7qztU4Iu//bKQiUI5JssJnbE8CR4FQRB2D1UUgXr8YhnbqWWsPL6Il9S6LnOwgOgNlRVVhjvSUB3ZKKjw735G6d68vB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RZ+G0XmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVVamNWf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RZ+G0XmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVVamNWf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3E7F11401BA;
	Fri, 14 Mar 2025 13:56:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 14 Mar 2025 13:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741975001; x=1742061401; bh=YhUnY3f9Uu
	uEEy2NCot9Edp+i/UOH3yxuqHWAsVTPFY=; b=RZ+G0XmJxzLfDby0X+zTb1BLsh
	ECpB08RTn7fsjBUO/zu525QzP74l+skgfNF1Gq4QQO73XjBTJZFHtSYTrFRrcai/
	BKmFcSE597UpLWHuoeJVKIMijDxC5CmSgEZF1YVa4l5lFkibsB6fBU8N89CeAGWM
	RoQuea5pJOOEiOZW1s7EkMPPiPyyDQ3VOhE4Y+qG0x9tRxbo5l/V1SZRhaHHQ6e+
	wtS8WIl+QDAx6SL+fgKt6Xrf85unaFl///WSqbO8QqZuLQdi7qbqI/AyJz+V0UxK
	MICwCGh956xEUArvEsUv29EPlfoxwLYjwaHcKoqxP7qVucLJbBB2hLsovgPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741975001; x=1742061401; bh=YhUnY3f9UuuEEy2NCot9Edp+i/UOH3yxuqH
	WAsVTPFY=; b=TVVamNWfLrZnF4JFQpO5YnV7HrbkWf3cC2586hqPI+99WfZK3jK
	Mv/F9VjYxvsqAR6wXwU3gWWrPjwKsOdnYdECNJhJPW3mwasMR9BEjyObG3eKJcWc
	RgEkHalQGIWKiHT+d7aDZhyMuATrFzEQKoRGwzhrx0ozo7tRFkt4Y4J3jDoDgE1z
	uQyRIF2IdpEr9P8QNFPfPGk4oR6eJJHHo0u4d1jxZpialRolwBi+J2OVBoTERruk
	IcZcwca25BP37h8wjRRT738AGbeVU5q08DSEa8rJSeMbIXeYfw0uGPuLJHEbjbUm
	XqZxW0oJZA5t6zeiar/3+2S8g+Ns/7y1gIw==
X-ME-Sender: <xms:2W3UZ_0eR7MygcEzR0AzsRb_WGXpsWopWKGUQP0-SGSK-vA6FkqkZw>
    <xme:2W3UZ-GbUXqjX3sPX5ZZG9sl9SfhMM6OvWzD8i59hIz85wolOkWRjELlBY2ljKoWg
    _DCdK84OwX9fzNKvw>
X-ME-Received: <xmr:2W3UZ_7cly9IZ5BPdiywZbwE2TRNVbMd5xElNBW4PmpSTSaWwmB4RWPA6TqEz2eCWNcnAAlcgPMy8h9gq5w2XAho9WPgo0c5WmmEGtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepge
    etkedvkeevfffgtdefveelleduudfgjedtteevkedthfdtfefhfeeukedthfefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:2W3UZ024QPewhhVMCyBXY1tbTesjimysV5lC2SMgvN2ZB0zJKUZE3w>
    <xmx:2W3UZyFrY1X74Z0_ObPy3NhmYETY0dEmpvyWhi3zF9XNfwTB-wgoww>
    <xmx:2W3UZ1_f5o6suJasHsxxP0PTDb_RC0jZBmIAgXUdkK48TJucjcPxhg>
    <xmx:2W3UZ_kGLgXy1bkWx6fKPd_bJ6Z4n5zEcxBaMHEl0p9KP0zSFtakpA>
    <xmx:2W3UZ3Rb6nhsMDRfczYLCQtZv-4njo2wfY3nmes1WiD4QEcNGs8KI5i4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:56:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [RFH] Issues and Contributions to friendly third-party projects
In-Reply-To: <xmqqwmd91zc2.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	28 Feb 2025 14:25:33 -0800")
References: <xmqqcyfdhp0t.fsf@gitster.g> <xmqqwmd91zc2.fsf@gitster.g>
Date: Fri, 14 Mar 2025 10:56:39 -0700
Message-ID: <xmqqldt7fqco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> After seeing a issue report on git-scm.com (and remembering number
>> of issues reported on friendly third-party projects on this list
>> and getting redirected to elsewhere), it may probably make sense to
>> document who they are, what they do, and how to contact them, in the
>> same document that drove these contributors to this list in the
>> first place.
>>
>> I am still not sure which of our document is the best place to do
>> so, but no matter where it eventually goes, it would be better to
>> first agree on 
>>
>>  - if doing so is a good idea to begin with (such a list in a
>>    document will incur maintenance cost)
>>
>>  - who to include on such a list (the list will become useless if it
>>    includes everything on earth that claims to be related to Git;
>>    where do we draw the line?)
>>
>>  - how the list will be maintained (are we responsible to ping them?
>>    will they update us to keep their entry from going stale?)
>>
>> As a discussion starter, here is what I added to the source to "A
>> note from the maintainer" message I send out every once in a while
>> (https://lore.kernel.org/git/xmqqr05a5wjv.fsf@gitster.g/ is the last
>> one I sent out).
>>
>> Comments?  Corrections?  Opinions?
>>
>> Thanks.
>
>
> Around here, no news is a bad news.  I'll rescind this update and
> the next edition of maintainer's notes (planned to be sent out in
> the middle of next month) will not list these updates.

I changed my mind and the latest edition of MaintNotes does have
these.  Corrections are welcome to the contact info listed there, so
are additions and removals.
