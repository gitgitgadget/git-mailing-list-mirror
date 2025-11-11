Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7520C00C
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855989; cv=none; b=dzahGwiXwbC6hn619M2xO5/5XeSL7rovMP//Mel/fHw0pHMGrSnl08Fj+y/o+XiaFJcTgzJycwrL8NCI/4Hvo5ZfRfHm1sUnCDBQPLHGWIWtJDyUM5R9TQPAlBKSPYl2Bj0U8ztPR7QoDTWiMe97X1/LL/gFghO2+4Tod3Zg4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855989; c=relaxed/simple;
	bh=DkYjsibuTSPDZ37TU474qB3mo3Py96H4lpaTeNlgohI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=po0Nul6HW8UQkz1Yx8fXtwupBzsgbcVQRcmBS1ygDtgRokAdViLGwVo6ktmrnc1xmGh4C88j9dYoCd1tHO08/I2lRf4723m3wGT5FzPC9Z2qyNyLOTnIPN/OiH0c7KLvDblo0dlBSI2kG81v1tPnHOCTCUwCHAdbJ14wAOLLgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nqSHJIbp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0PzVMMG6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nqSHJIbp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0PzVMMG6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 74EE8EC01E9;
	Tue, 11 Nov 2025 05:13:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 11 Nov 2025 05:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762855985; x=1762942385; bh=MCDpT+hjTG
	ardaX9vZNEvTwNfElhUSHbMaY49f51EVE=; b=nqSHJIbpHZKMzpbxpdpr88mAKA
	nD8NfTx1FxtcJ8Dkd4Mcr1dUxm/9/i8w6lVy5gIBoNdIDjsSkQTVbQlB/+k09gG3
	IpMy+OfoI6IcI9ddJTZUskIOTA+7/zqMmA4LwmFf06rID4cBgDY/AzWd67IViI8F
	lzPM/VPYqAO/4NKXjapuoYaVsmFXwCGC5aLE+WBIpqI+6P8sYGrTy5CLp1yunQEi
	HUsugwqhSgMDtWskoFetikgyA0bjwS+5RoGYgplJUTEE0iB+8JSy7TiVh1t9vvRR
	TA3HwCuHqik5c8qDNvjUt80b0pU3Z2GnQkafDA90lWEsbT7Ta0tEQPZabVCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762855985; x=1762942385; bh=MCDpT+hjTGardaX9vZNEvTwNfElhUSHbMaY
	49f51EVE=; b=0PzVMMG6XYZQl3OzIn9mXJDb6H3xAIX7RBlK2lW9oyTCTtlwwA1
	5Lr3qigeJOFu1WQJyFkaTJ9jNBJiCweMSh44H406N923mBHvjCFi5vq8NyZKE5T7
	YLocKcSYhJedRxjgzbJ2Nd/Ex0JwYDC/6pP7zn3Beb1c6ihsa9Ra2a1K+sC4NfYs
	tLEL+ffc0VhdthN4wTc5aNyczgeUaVtFzBPGxrDuAvsZtm7QPYyocSGxKK6nJydQ
	XOG6oZ9siJCVopdo9r6rq2gTQbVIxu6p3hOGxcGmNNqKUlI8IfX+xUyRI/ynzSRh
	b0AC0rF9zXegu5jKNJ1Q2hQmZxwWk2j/maA==
X-ME-Sender: <xms:MAwTacytbZVqT1vK_VwZBtBhrF8-Shx6hbl2h70dNcJcvPDqLA8Tew>
    <xme:MAwTaShMtkj_I6lLHlArM4GTm5U5U0KqL-CBzrx9Ul0lPJ7Rvf6krJfypzXfVINih
    Jz-YlDJOteWH28rp8TiK7HrU99l42_YMqBdMn4lpHl_xUp4eAJScSg>
X-ME-Received: <xmr:MAwTaQk5Lo5XUsb2EcGAKJzcjyRKQN28aUmd0CoEbnlHcRjcpxIpeN-muV3LKyxiX_-pUS4egHP_1WCQY5PLi5oaWIDKaVd9dUgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MQwTaQjN5wGpS238fRTkfJNZ0K2EUy7hCqflvwe1LdmxqCDXPGszmg>
    <xmx:MQwTac1Q_Ew-AP2XQhl043ld5wnzo4fh5CT1I_IlfIkDw-XZNgrzQQ>
    <xmx:MQwTaRL1Tw0R79RDXzxnuYyT7SAwZ6u-Zyrp65YKuae5-FUhbJtPsQ>
    <xmx:MQwTaUzgq31p4AbKqtUkKxu9wUQChRCGFgKf5h36tPF77FIsLeVzKQ>
    <xmx:MQwTadXz5uyctZ7oEhHu8RYfWK90ZsXrg8QGM_dAXTG7OpNgWNMIdVzV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 05:13:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com> (Julia
	Evans's message of "Mon, 10 Nov 2025 10:56:03 -0500")
References: <xmqqo6pde90w.fsf@gitster.g>
	<D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
	<xmqqa50v4x8n.fsf@gitster.g>
	<150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
Date: Tue, 11 Nov 2025 02:13:03 -0800
Message-ID: <xmqqfrakyj0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Like you noticed in the tag object section, I think saying that the tag
> object "refers to an object" works well in that context, but in the context
> of explaining what a branch is it makes the text more confusing.

Sorry, but I do not understand your objection, as I cannot see what
confusion it would bring in in saying "a ref refers to an object"
(or "a branch refers to a commit object").  A ref refers to an
object, just like a tag field in a tag object or a tree-entry in a
tree object refer to another object.  They do so by recording the
name of the object they refer to.  So what's so confusing if we said
that straight?

Are you saying that the noun "reference" (or "ref") is a sufficient
clue to readers that their objective is to "refer to" something, so
"refers to" is a redundant thing to say?

Maybe its just me, but I find it a quite roundabout thing to say
that a ref refers to an object name (or "ID" if you like), simply
because name or ID *is* a way to refer to the thing that is assigned
that name, so you are making a ref to refer to something ("name")
that refers to what it ("ref") originally wanted to refer to
("object").

That is what I find the most strange in the construction "A branch
refers to ID" at the conceptual level.  I am much less unhappy with
"A branch records an ID", but stopping at that may make readers ask
the obvious question "what goal does that design aim to achieve?"
(whose answer is of course "to refer to the object that is assigned
that ID").

"A branch refers to a commit object by recording its object name",
"A branch records the ID of a commit it refers to", "A branch
records the ID of the commit at the tip of its history".  Any of the
phrasing that does not make "ID" the object/target of the verb
"refer to" would work to avoid that strange construction.

By the way, Ben used a word "unwelcome", but the words that are more
appropriate to describe my reaction were "frustrated" (for not being
able to explain what I know to be true clearly to make others
understand) and "disappointed".
