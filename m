Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A034D3B6
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271154; cv=none; b=q8x4oNVIumq+OO6qIqCFJ6wypwOkz8RrWSxbJ5Qde5Z3k0WCRtahhA6Z1lvst82gGXx2Z3pyenfn0ykSc48OdH+bvwirsPqYuiWm9xGGNjVyyA6lcRjj43n6p0U0HQJljk6vSYq49RW1oehhgSvdTqhV0uFKR487Cx5F+sZx8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271154; c=relaxed/simple;
	bh=n21St7jOIqeHD7I9iXe7yNiueCnzqYHySoYsKVFWJIQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M27YMkVVnTC25Mr9Ju4kDJzMT2+CIcVoyl7DrG28eMIsCaABqdWuZJqlX9G6cJu0gQn/ArPcEVZLsJiy/XB6/sHt5SDDn9S0YNQZ2zlnrinmIva2lz9Msg0tHW0dIf75zAyv7KcVUzbRzu7bGEKDvsbiSsxI22wF5ayMh41HNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=0twt8roV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9KElBNc; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="0twt8roV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9KElBNc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 95D0F1D0039F;
	Tue,  4 Nov 2025 10:45:51 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 04 Nov 2025 10:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762271151;
	 x=1762357551; bh=4P+t0yWnuZOKNPwDnLraOS4YRCJzSmYLCiNWsprpBtk=; b=
	0twt8roVXqskuzrvvHUeX2bDFRqNr3/LFsVucvDfQjhPPugOg7qqWOsy97OwEJt1
	PWt09CFw6UP2WTbz2wjsAV8mV7tG/bcvBPVZF3PQP3mJ2n4kp+ZlO3LZZ/RxHXDq
	Fp3NFGx67+R3VxFHKi/ONS1VcuQbqUqwg+/9nq0bLKITe1eCuqZp/CMgYYk6OXhj
	j/M6FI5hUEzG1dU4DrcdEJ9uRSeyK+YbyNf/JdlY4rzSyFMldvRWrqKP5lu1GqWK
	6b9N9l4dJvMdXPV0gGSKWxXHRudLIQP3k/8HOYBKkgmf8qqrwZr/OqNLqIj09owW
	mcjQu5rQ/GpkogLPUvwiBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762271151; x=
	1762357551; bh=4P+t0yWnuZOKNPwDnLraOS4YRCJzSmYLCiNWsprpBtk=; b=M
	9KElBNcETvsimtgK9G6QXUdDXC4WDGL1Tu8AB4F9Nz4rkfzjVwkuvQHvWe5OXrSA
	n5Cr5OxLSjcbclUBON11tqKW9AYU6Fh86bT3IkySjVskZPtxUEcYhbhp6AQ+QNhu
	QrkaW/c8vEMhvG0Ck9t94IGBV4yJBIfDp41jwO5e+iqjYxW5++CfBurg/A2/jY0+
	YlmbuRDYdVXodCJltNXdYQ/lsCEcbtY+d2cnQzinnn16cg0tZCvi4WxK3MlC4pAY
	VRcHiV0JfK3qvyir/5P5KUlDXtUzNTVDInDRaKcgJWxk4R8krx5FenMhaVl/QhxI
	6c4OF/C09lgLcHpXnLPYw==
X-ME-Sender: <xms:rh8KabJm3-vo7ymzkK-Tc0x7S0tW4gp_7N_d94UsNCeiKhR-PHuQ2g>
    <xme:rh8KaZ95CQhlSerrY8UAlVVhAxCqm5M0J1ZE54OpQtOg2-DeuO19C_XCLqxTg1oHi
    efrJAZ_exr6IOhxvSigLc0YxkYO98Fx7nEgMo58bL27qL__ZcR2lic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rx8Kaa3QtOPuoHFjdtLu4-pnL0enz3XZ5SHK7FR_m4MGfEtW9xJKtA>
    <xmx:rx8KaWa34bDdOPiTqgxianJHkeMeCf5E7kaMb9hh2IFLcFG-KhtpUg>
    <xmx:rx8KaaKJXgdlzRusoYAXMbJbJY1Idkr3gSrJhHJai-aVe6D_yE3g5Q>
    <xmx:rx8KadFEcP8AESHAYbK5wX5MYjKl50sRVKdrkqmO3oMKXILLeTe1rQ>
    <xmx:rx8KaUjMNZ0Tl0tML4pi7cdS-Ue5Q5SARPR6j4UdtT1IEF5blP0yO_w1>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5E4B7800DA; Tue,  4 Nov 2025 10:45:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Tue, 04 Nov 2025 10:45:25 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <9ff9d97e-2fae-488c-990b-cb574fbe8c71@app.fastmail.com>
In-Reply-To: <xmqqpl9yshrr.fsf@gitster.g>
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
 <xmqqtszf2kro.fsf@gitster.g>
 <8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com>
 <xmqqpl9yshrr.fsf@gitster.g>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 3, 2025, at 8:34 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>>> +tree::
>>>> +    A tree is how Git represents a directory.
>>>> +    It can contain files or other trees (which are subdirectories).
>>>> +    It lists, for each item in the tree:
>>>> ++
>>>> +1. The *filename*, for example `hello.py`
>>>> +2. The *file mode*. Git has these file modes. which are only
>>>
>>> "has these" -> "uses only these" to clarify that this is an
>>> exhaustive enumeration and users cannot invent 100664 and others,
>>> which is a mistake Git itself used to make/allow.
>>
>> I like the idea to make it more explicit that this is an exhaustive
>> enumeration. I'll try changing it to this instead: "These are all of the file
>> modes in Git (which are only spiritually related to Unix file modes):"
>
> The primary reason why I suggested "uses only these" was because I
> thought it would strongly hint that random additions beyond the set
> is unwelcome.  As long as that implication is not lost, I do not
> have strong preference between "we only use these and nothing else"
> and your "these are all that we use".
>
>>>> +[[tag-object]]
>>>> +tag object::
>>>> +    Tag objects contain these required fields
>>>> +    (though there are other optional fields):
>>>> ++
>>>> +1. The object *ID* it references
>>>> +2. The object *type*
>>>
>>> I would rephrase these to
>>>
>>>     1. The *ID* of the object it references
>>>     2. The *type* of the object it references
>>>
>>> because (1) a tag object references another object, not ID.  To name
>>> the object it reference, it uses the object name of it, but just
>>> like your name is not you, object name is not the object (it merely
>>> is *one* way to refer to it). (2) unless it is very clear to readers
>>> that "The object" in 1. and 2. refer to the same object, 2. invites
>>> a question "type of which object?".
>>
>> That makes sense to me, will change it to that.
>>
>>>> +[[branch]]
>>>> +branches: `refs/heads/<name>`::
>>>> +    A branch refers to a commit ID.
>>>
>>> A branch refers to a commit object (by its ID).  Ditto for tags.
>>
>> What's the goal of this? I can't tell what misconception you're
>> trying to avoid here.
>
> This comes from the same place as the suggestion for the tag object
> above, i.e. "a tag object references another object, not ID.".
>
> Exactly the same reasoning applies here.  A branch refers to a
> commit, and to name the object it references, it uses the object
> name of it, but just like your name is not you, object name is not
> the object itself.

I agree the ID of a commit is not the same as the commit itself.
The reason I said "refers to a commit ID" is that it's a very concise
explanation and  I don't see any risk that the reader will be
confused by it.

Unlike with my name, commit IDs uniquely identify commits, so
I think it will be clear to the reader that the commit ID is going to
be used to retrieve the commit object.

The problem with "A branch refers to a commit object (by its ID)." is
that it introduces some more potential for confusion: it makes it
sound like there might be other ways to refer to a commit object
than by its ID.

Maybe there's another option? To me this introduces the potential
for more confusion and does not solve any specific problem.
