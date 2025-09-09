Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54324225D6
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452815; cv=none; b=t9K+NgFmDjvRHgGo+mi0iVEIHZtZ/mHYn/jEAP4Z5169/Mt7+olgWc3Xi5A2qCux+k6xxZcdG0otH+wQltt/h9uu4GcYUY/ase9EkM8PSiQb3WWKPC0Pn4CphKam1kfKay/NJG+4Hm3hs0mexXv+Uw9iLs+gOEGTWVVo93FlqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452815; c=relaxed/simple;
	bh=duHfTRqpktsWPF5GNLjYSrKGd0P4h/NicSmLNEGWBDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QUhGoM2f6jTH2RywvdfocwJ+7gf/jo4ilXpGmRgJ2Vs+yXVzfbRL4ad2N6mJBo4VG+wDk5o/FZknnqgamx68C5F3wP7PywnZG8cQcl7UoUKanHuaOjQyNgboO0JOvfVgUEvy2dh4SB5xYAspuWtXmoxA50lzldZtVjkLmZaCm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gSlKkJZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjdNdYVW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gSlKkJZd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjdNdYVW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 376797A012B;
	Tue,  9 Sep 2025 17:20:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 09 Sep 2025 17:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757452811;
	 x=1757539211; bh=Ep952oUPcVAR+GxE2SmR75t5XOTAyQ3yENuvspE6O2g=; b=
	gSlKkJZdhSVBrnsvanNGFAwwxWtGDqqpBkFeDVoO5/tYbd+kJFIGO7yCnpZzgOVH
	oEYz9TWbbyp5hgcr/cqDZHnb637SLcN6eaB6w4A/BYjnfsGq2ugX0tadCdYi9Vyv
	h6i7MlDGWPfVZH1B2biw0WmbAvQBqdfWAHki8m7T3Nnqdhji3M2tgJTk/PTI+cuY
	H/QYDSxbVNG/aA1NbPOlpnjOkhihoJC6tKROaUhK32FZj48Sazx9jw4GTCK15zIA
	3RhnLMUigJZ/ZSAeOyldLPdtv1NIKLiMOqYWOAcE4f6YrYB/+98P7yXeAeLMkNj3
	kFiWve65NgpI4NBLQy5ONA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757452811; x=
	1757539211; bh=Ep952oUPcVAR+GxE2SmR75t5XOTAyQ3yENuvspE6O2g=; b=B
	jdNdYVWEAl197vVCOfJtTFtNNmy0CeVgq6/pav6EyQE5X+IjY1sDFAGLRWwAlDRr
	tAdPJathF9Nq0sAAccqPMpsnUTTMjBxnojHfHWDcJWUOOdSoaoS1mSgKAMjBhk4K
	JUVYLOdO0IkvyEOLmWNMc/GIBWc5p46K/dhmWkS20OSmiig1Paoxutqee3FUQUMB
	zHMsKPop2Ct1A9zht0CPN86oO9d67Aokxqw2TB6bsUIZMcry29sFiv0gkLEewTOE
	HvHRsZC0FyqayRUzismbUEV3xQdvdMIUOYh6ONzlxCuPdDRf6ChNObF4ynp1om9I
	vJ8RAseDl/f/CsaD6AbTw==
X-ME-Sender: <xms:CprAaMTQDcn1oeTWTAp8Eq_MMq0X4hwgwnH7Ryq2G0cGjPTIlQAONg>
    <xme:CprAaEUJDN9VQ_iMa1L1LhdxbdsZ-1kYTJ6wfmEEifTGv-WmjWs2TkWpipqQiOn4h
    l1tf947UC4HBrDjfg>
X-ME-Received: <xmr:CprAaGb-LwOSazh0BpJDOzZcy8B_a3Vurq9z7BkD92Z8EJkS5xojKZZdu9odsD7EXn1TRiU8F0exk5uXMSGpLYMdJSfW9wh7WnAA5QE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CprAaC0rSCEsy7-53GDUfHv9MY3drzgwC-HtwephAWV_Z2-feKD9kg>
    <xmx:CprAaAgelyQddHyhYuAkzhhwJTLEnrh9b02Da84CfeKyzHOygTqtLg>
    <xmx:CprAaOYMnoDMjRRY8RXfgh5y2-2bJrE5qQ1po6oaGZeXQGmFJXTS8Q>
    <xmx:CprAaIQIFzYs5v9QYJVYjhGYxA6rj4LIr11vyL0poaLFS3WeB74w0g>
    <xmx:C5rAaMPL178OA8LkDZ8VOsjxxho_e3Uo5YAgQkpZuE-HoHTBE3Xynlfk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 17:20:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
In-Reply-To: <e76a86b3-f913-49a9-a886-32d8d3baefb4@gmail.com> (Derrick
	Stolee's message of "Tue, 9 Sep 2025 15:35:06 -0400")
References: <xmqqjz28v21e.fsf@gitster.g>
	<CABPp-BGxzRmkqdkpsVE=b9hQUsA9QO8iTNL=Wan1Vwatq5bMMQ@mail.gmail.com>
	<e76a86b3-f913-49a9-a886-32d8d3baefb4@gmail.com>
Date: Tue, 09 Sep 2025 14:20:09 -0700
Message-ID: <xmqqo6rjtjau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Derrick Stolee <stolee@gmail.com> writes:

> On 9/9/2025 2:58 AM, Elijah Newren wrote:
>> On Mon, Sep 8, 2025 at 6:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>> 
>>> * ds/sparse-checkout-clean (2025-07-16) 7 commits
>>>  - sparse-checkout: make 'clean' clear more files
>>>  - t: expand tests around sparse merges and clean
>>>  - sparse-index: point users to new 'clean' action
>>>  - sparse-checkout: add --verbose option to 'clean'
>>>  - dir: add generic "walk all files" helper
>>>  - sparse-checkout: match some 'clean' behavior
>>>  - sparse-checkout: add basics of 'clean' command
>>>
>>>  "git sparse-checkout" subcommand learned a new "clean" action to
>>>  prune otherwise unused working-tree files that are outside the
>>>  areas of interest.
>>>
>>>  Rebased not to depend on ac/deglobal-sparse-variables
>>>  Will merge to 'next'?
>>>  source: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
>> 
>> No, please.  Responses to review comments are still needed, as noted
>> over at https://lore.kernel.org/git/c3c0fbef-f395-4972-8352-dd89af6799d5@gmail.com/
>
> Indeed, I am delinquent with responses to those review
> comments. I hope to have a v3 this week.

Thanks, both, for helping the maintainer who often fails to keep
track of things X-<.  Very much appreciated.
