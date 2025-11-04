Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5161FFC6D
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220046; cv=none; b=F+K7P6A2dCPoeAq4S1DvFUffW39/gqiQQ28MPPvyh4NL/41hN1lQIeQ+KiPf21ktZJTuCs7/OKQq61cX/YAqZhUPsHgQHQ7t35CvjhKl648FOROd8fkYxKwDV3xmixVAONEDObujyMqDN9lytSMBewxtWcqV6EkgoazXWNTSMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220046; c=relaxed/simple;
	bh=yeOb8rLuwuXQ+rvZF3jaGS7c5gmbK0abgadVToac5+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mn/lUkt7nvtYnphC68Q4Z2vCcBpXyKU3yvWej7vTwffPfb3DsgARJtxi+gTD3lSiMg6y0bbGwWvXx3+/pLFoMG9le5TgR1SeblqxVpexldA22Z/1txqp6KY1slH/vvBl1WcMmjtUxvZR5STsaj3mNu7Urda28Q0ucwDfQ2bsKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q4rYj8wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EXtoXq/3; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q4rYj8wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXtoXq/3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 65DC57A02CC;
	Mon,  3 Nov 2025 20:34:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 20:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762220042; x=1762306442; bh=4CsLHLmzhV
	LQuTbiWBPPHeWPxgkllg4cIGmvNu5Jn04=; b=Q4rYj8wlnuBjaF0Br0j4gNJ7QS
	1V0xPX8TeNg5FwOsTIUjLxArDLtXFr6/6mvwH9rGpANsV4rBUN5/EhF6dqLWYHuS
	AmO18JnBIx3cR6NPYFl2bfxZI98rWAYtVHZYvU0j7hZJEB5lx+yKo6vBGnnURt0u
	7a3tuYf2xlcM3B9gRqNQaIXBnkIzau1i4Njl/sbdPrh2YAD6kus5VlC6CIoP2jtG
	KRAEFVatNK31mOcEf+D/YGbGmyii6/KyKe5z7ujQ0/7YMxH+5znjSqD8i6XHftBJ
	iLr+m/AzlTAdgQ1PURiNFcwc+UTCwmWQ9oxSu3ytXWUvkt57HRrue0hlQ2xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762220042; x=1762306442; bh=4CsLHLmzhVLQuTbiWBPPHeWPxgkllg4cIGm
	vNu5Jn04=; b=EXtoXq/3R2YQI8bP64yMvUoiwEuEJfm3XQmEazxq18KINhKXEoE
	hJko1VRxWGZxGgaO5Sxl+ffp0Ym0iCpk4avOkajMnkGU1kLsLnUm4a6gAs+O4OgV
	9LkrWefVtXv/kHP/K0xyj9Q18B0LxUTdPMMaE5oGk1iEAVIXVyj65R4xgblwFjeM
	rDGOs5yJtMX44eHJTZSMXSANf3t6/Ei7RNjRf4KocmuHZGq5hrMOGVJItt7fYCwf
	1+w2FGXYt6PGFihlC9a4DHj/mBkwdz48B8qj11CMJEyACVthtnYwYj/YZdY11oXg
	cxsE9PCZwepYyZXC2HcpsVN8u03+7k7gmkw==
X-ME-Sender: <xms:CVgJac3-TnmO6VlQ9c2vcXiX_4PBXcwPvr-pJk6JZHE-ww_INA7PXQ>
    <xme:CVgJaZWvWElT-3kNUzFbvQC4ziagVZZJcsEzWlb2R3GM7gsNWnjrDxrrRZ0zLQg7J
    wBtD6f1ufAVkmWbaFcSZ1S1wdLbTGCiLD9iGO4_V4Wkk6KFS1IWfA>
X-ME-Received: <xmr:CVgJaXJ8IufCQR0fC4vyiDvA9WmDYAGhaEZ-tndpQJ8Uu8tAXW_yLN12B6KWJBBpSyfIwcHKJGzrTWbrAANUL9nA4OmVCGML051e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CVgJab3WRImcY7u2gi6lYpA-uprZ17ZwndiCrdfYSjov556E5Ym-gA>
    <xmx:CVgJad4QLm9Zsm481si7ws5GpaUHB30vN7Orvdnvj_A-kbijmUQP6Q>
    <xmx:CVgJaU8CuhwNWZlzaeswe1I6xZaNKIUyo5az4waBiqO7Zecs-0FjnA>
    <xmx:CVgJaUVR9G8cumSge6vpMVzP0H2qXiVJv87-MgHzL5S3nmUlcy_kKA>
    <xmx:ClgJaVIPEvPkW9MvgiCqi71q6yR2pAwEc1J7J1Z8r5IUReTNdNIuU6Yf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 20:34:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
In-Reply-To: <8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com> (Julia
	Evans's message of "Mon, 03 Nov 2025 14:43:39 -0500")
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
	<pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<xmqqtszf2kro.fsf@gitster.g>
	<8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com>
Date: Mon, 03 Nov 2025 17:34:00 -0800
Message-ID: <xmqqpl9yshrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>> +tree::
>>> +    A tree is how Git represents a directory.
>>> +    It can contain files or other trees (which are subdirectories).
>>> +    It lists, for each item in the tree:
>>> ++
>>> +1. The *filename*, for example `hello.py`
>>> +2. The *file mode*. Git has these file modes. which are only
>>
>> "has these" -> "uses only these" to clarify that this is an
>> exhaustive enumeration and users cannot invent 100664 and others,
>> which is a mistake Git itself used to make/allow.
>
> I like the idea to make it more explicit that this is an exhaustive
> enumeration. I'll try changing it to this instead: "These are all of the file
> modes in Git (which are only spiritually related to Unix file modes):"

The primary reason why I suggested "uses only these" was because I
thought it would strongly hint that random additions beyond the set
is unwelcome.  As long as that implication is not lost, I do not
have strong preference between "we only use these and nothing else"
and your "these are all that we use".

>>> +[[tag-object]]
>>> +tag object::
>>> +    Tag objects contain these required fields
>>> +    (though there are other optional fields):
>>> ++
>>> +1. The object *ID* it references
>>> +2. The object *type*
>>
>> I would rephrase these to
>>
>>     1. The *ID* of the object it references
>>     2. The *type* of the object it references
>>
>> because (1) a tag object references another object, not ID.  To name
>> the object it reference, it uses the object name of it, but just
>> like your name is not you, object name is not the object (it merely
>> is *one* way to refer to it). (2) unless it is very clear to readers
>> that "The object" in 1. and 2. refer to the same object, 2. invites
>> a question "type of which object?".
>
> That makes sense to me, will change it to that.
>
>>> +[[branch]]
>>> +branches: `refs/heads/<name>`::
>>> +    A branch refers to a commit ID.
>>
>> A branch refers to a commit object (by its ID).  Ditto for tags.
>
> What's the goal of this? I can't tell what misconception you're
> trying to avoid here.

This comes from the same place as the suggestion for the tag object
above, i.e. "a tag object references another object, not ID.".

Exactly the same reasoning applies here.  A branch refers to a
commit, and to name the object it references, it uses the object
name of it, but just like your name is not you, object name is not
the object itself.

Thanks.
