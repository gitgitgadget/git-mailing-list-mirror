Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656D225A8
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967583; cv=none; b=ahyH0a8yqLUClVmL5udil6CTUfn8f2hKNA7SY7hmrtsmjyTHnIQ/ujmtZSz7LOe1QllWst7T4+oNhmkHPVox/iGws8z8GR9MhU5Og3mc5vGNr/H01IYDJTMi2yKemBQZ6WFzV+R+awS4Vbm91V4bdCxFtPONpqpQAZhlY0HAyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967583; c=relaxed/simple;
	bh=o3mwBTlGQ6lE5vgRMYE5ha2mV+3dm/qL0PHMFERFRvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hYJmUN7QR+cB8HafqDjQ4zBPzMY0i77b5pwePnjb2rLTi0jDkRKJX2lGKceJaWBqQAz4N/Ww/uMQuwWpuLBpNIkAf3NliYj0wVQ/DTChGANX4usejmwn0ADnzz1OKhVK77oCpwawrHnm5cZz57LlgRwKE/TDDww748Hj4sdopAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ex9rnPAh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0YZ6J7R; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ex9rnPAh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0YZ6J7R"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 37B4A11402F6;
	Wed, 11 Dec 2024 20:39:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 11 Dec 2024 20:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733967579; x=1734053979; bh=wmswlNQC2T
	rcgEem4OLk7fzB548sn0OpK/lYq9ZYV6Q=; b=Ex9rnPAhGCVsI43GafP3F49INM
	o0b/2oo9ZX9nNUcaqB705Og4SiJHbd6idis0fJRw6OE4DwaPWlNmnzx8s7K61o8C
	jVS2X3I8ydwH0TNjIf+dhgxaAjDx0tODydDAFfpTZq1HPEuDJEKttgxoJ8UoxzYE
	XA/HcNGyVb1FiRVSvKWD+BBffGwdRvdPOxOQVTkzx+IiYmz1VpmEu/J6XKVZGQnV
	oXaIktwvGMw09Op0a+LwHDHa1xnaR7nutz3W4BJxYrI2Eh5QrP/+ACLVvPYoUFTu
	uaTVArXerLlP9Ek3IjJzyRH5+MYeZRYP61kjpI/icAyJYw/MxSGEO379/NzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733967579; x=1734053979; bh=wmswlNQC2TrcgEem4OLk7fzB548sn0OpK/l
	Yq9ZYV6Q=; b=D0YZ6J7RIx5QxLFSpyhOmy0PwI1+MxMaQt+6TWAyCPhVo6T94qf
	FXOxvz8oDj/63/ciQGEilVNp0WSnGM3GKO9Z+cPuOkUz00/wk3VgNhBJKKoCJTpR
	Ccns13ykUQWQ9VPvm97MPNcwQQ899/gBCNKn3nHUrB0wvaTMSdDI+8bEbD2lMZBJ
	y4ft5qcRQAi8bvdc9IoGHxmt7gQqsvFgHWsbBXG+9l/S8u/ournouJ4Ycm5w9jmJ
	jElgI9IgE2M2jvtyfquSSAnKdvoOLHum681bqVQ5uqpqhkjNfxA9e6AtWfmXvXVX
	bk93urGaLLiEpnOTCO7BzFxspaaAdE5MOuA==
X-ME-Sender: <xms:2j5aZ-82qrnIjubpJYwHXVsuT4K4lYQSlG3qdyTknj3MrvmxQBewxw>
    <xme:2j5aZ-s5HimNb5k7s34OY1AwIUbF3lG4YG6d5-bi4n4OmWQCkVl2jL6llQKKDwAF_
    X9ojvgs132bEFGaaw>
X-ME-Received: <xmr:2j5aZ0Aj7M-mi0XTtji-v7Ndy9zl1FAMn-VL_C3VXlUabDDSmc12LDjtPQtUhlBvtfPTp3VW-zH_QZnf9PyyNWGxTtefi60Q0sgyAt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2j5aZ2fuGfMVovS0AIXPsoMjlE2mQRi_oj8MYm4prGYgrStS3HLjWw>
    <xmx:2j5aZzPQciNALi0FmEKtOBobkxe0fCkzx-SWWvPPF-drCWJVcPjhfA>
    <xmx:2j5aZwkU2-irGhy5UIY0n_fM3NmEt3phTNKZhiJOVyQHcpHwTuHfcA>
    <xmx:2j5aZ1svMbIFhvahnlZnj219ZfzOKibriZhBdSiwCmUf4e-qOCKpyA>
    <xmx:2z5aZ4ou2TYgZUPJO9CqJtXiYa-FfMQ-Sjvvss9M0mRLrIP96iiDmLel>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 20:39:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org
Subject: Re: branch description as a note?
In-Reply-To: <sem23vxg5c3xc62wvy5qn6gvoh6hc6m75mx35zgwsdyw36oexm@ayfez6uqghtt>
	(Konstantin Ryabitsev's message of "Wed, 11 Dec 2024 12:37:35 -0500")
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
	<xmqq4j3ai4it.fsf@gitster.g>
	<sem23vxg5c3xc62wvy5qn6gvoh6hc6m75mx35zgwsdyw36oexm@ayfez6uqghtt>
Date: Thu, 12 Dec 2024 10:39:37 +0900
Message-ID: <xmqqa5d1he7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

>> If this is about draft work, I would use an empty commit at the tip
>> of the branch.
>
> I think this was discussed a while back:
> https://lore.kernel.org/git/xmqqilnr1hff.fsf@gitster.g/
>
> I think it boiled down to having a merge commit at the tip that would indicate
> the base-commit of the WIP range. I still think it's an awesome idea if
> something like this was natively supported by git tools.

I suspect taht Bence misunderstood some assumptions behind the above
discussion, some of which might not match the use case he has with
his "branch descriptions".

So, forgetting Bence's "branch description" for a while, let's see
if we can summarize the assumptions the older discussion had.

 1. We want to summarize what is on the branch, to help the reviewers
    and also the original developers.

 2. When the branch gets accepted to another branch that is higher
    in the food chain (e.g., an individual developer has a topic to
    improve a kernel driver for one specific hardware, the developer
    describes what they did and give the branch to the driver
    maintainer, and the topic gets merged to the driver's tree. The
    resulting merge may not yet be in Linus's tree, but from the
    original developer's point of view, the topic is "done" for
    now), a merge commit will use the "summary" created above in the
    messages of the merge commit.

 3. Once that happens, as it is etched into the merge commit, you
    cannot update the description anymore (unless you and your
    maintainer arrange to discard the merge and take an updated
    branch), and that limitation is acceptable.

The idea to use an empty commit is to make it easier to communicate
the "topic description" between the author and the maintainer.
During the development on the branch, the empty-commit that holds
the description can be updated using the common "rebase -i"
workflow.  If the empty commit were at the tip of the branch[*], we
can teach "git merge B" (or "git pull") to notice that the topic
description is in the commit B at the tip of the branch, create a
merge with B~1 instead, and when recording the merge, offer the log
message of B to help the maintainer write the log message for the
merge commit.  The e-mail based tools would need some changes (like
allowing "format-patch | am" pipeline to pass an empty commit), but
the principle is the same.

If Bence's "branch description" is for a use case where the
description need to be updated even after the branch gets
"concluded" by being merged to the upstream, that is not a use case
the topic description stored in an empty commit on branch we
discussed earlier would cover, I suspect, as the primary focus is to
make it easier to maintain in point 1. above, and finalize it in the
merge commit to describe what was merged in point 2. above.


[Footnote]

 * IIRC, there were some who preferred to make the description empty
   commit at the bottom of the series, and while it is possible to
   arrange such layout, it makes the eventual "git merge B" a lot
   more cumbersome (i.e. you'd need to rebase B onto the
   maintainer's tree, except for the bottom of the branch, and use
   the message from the now-discarded commit for the log message of
   the merge commit), and it would force developer to rebase the
   _entire_ branch every time they need to update the description.
   So I strongly prefer "description at the tip" layout, but the
   choice between bottom and tip does not affect the 3-point
   assumptions above.

