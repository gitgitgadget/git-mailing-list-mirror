Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37783B640
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968361; cv=none; b=J/vBntL6urR6AWEvlVjETCGddoSaq+M1SwkXo0HQ8vz3qy7FYhCyEE2iqWZH8r8pnkeCI8SyY7XdjyIW1vkphONQAK/IripOVJeBLhUNVKL5S1OdbgsXEJMKeMSFHTdEnV8ThydxmnoyDW2hDp3eaqEmxlpihHkQZYlK7BTVRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968361; c=relaxed/simple;
	bh=eUc4iuutP0CVhIQ+ylQq7Ta6e6uTAcg1lxFQLwVT0Ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dA5ND4QL6l2OWg6lTdWQEExC/E88l3FHAWi1EgjXIzAFdDL6oAyD5YOCSAQWdHuhWq0uMtMzpx2lgh3STOKww5cVgZdHjgaBEN56QJpqNGxWwMf1JPwAd6AwIyomIds9Si5YYPN05y6SZm7YzEgHs6YzUHG6fpvOu22Fa4IVdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zw8Zu8VL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EayaxW+G; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zw8Zu8VL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EayaxW+G"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D56801140176;
	Wed, 11 Dec 2024 20:52:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 11 Dec 2024 20:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733968357; x=1734054757; bh=RjxaaJTqbe
	lpoEEhjIYzQWBWTlMhXbOUQ7lwigS1ps4=; b=Zw8Zu8VLNs3FUOW71fDoWLEn8s
	GiBDN+WaTYqG/SazRW4wyVJEKxwTDp1fTZvIdRa/Hj796jCqaPb1oqB3k5IB3Ogp
	s0T2eNfKRPBKRu7Ezk9+tu43tv01RaL6jPwXSPcA3hO8E1NoL5bypsMbLuFBewbI
	x6rHOlSXunVatuQKMoJi6D32BZAvk6TsLujcoGSUOcg0QFpxwhJvqBYu291g7wic
	FWK6OToZH/cY+AJMbncGbKUuLhYBNxaxeGxQsfIP+xixQ5aFp7HIxkItqHGYIOgi
	1dMzc2kjbGIF3dzfMEQc0Tu5VYDZnV9J2ukd/R1xWfJaXKX2Wq3kM/NMLGNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733968357; x=1734054757; bh=RjxaaJTqbelpoEEhjIYzQWBWTlMhXbOUQ7l
	wigS1ps4=; b=EayaxW+Gb5OC5VmcpAWlXG4siaoiRDFJ/idR1Ep8X11OJXUZuv6
	DFdyljQht0f42ws72D07vL5zA4VigiouPdcaybAjtR8DcA0i8uR0rQ0Z/7+Jf1wG
	3ovx3EaR7yXNauIKLFZ26Mrl/Bfhy74OwIckxKZ6AIJxBFSX34dv456TzJvkdFTy
	IGjBzqjGVjzohkyfFdGXkC0X7JWfCrXNpdMsxgaGIIXaBUqRF9BKjHQ6e2qDdGu6
	BgDJpPRslGd8ELQ+8q1f5BYIqUvdBbIWY/4MMu0HWM1xyOfN7+TIVXaE1HxPAeSB
	FlYYRuHEzoAB7Wgjn9eLJjfHSqF1qViatmg==
X-ME-Sender: <xms:5UFaZzqmrp-NxPKy-qkQWvE1_-AGGZ0DQYu-DVZdPTD6Yma10Jtp9Q>
    <xme:5UFaZ9r-IrimuxLu9XWxIzGHM1QmuXeU1bXQiAenyR-IOY524RUlJXuf7IioJo7D4
    KGvvnMTgFaDFGkxSw>
X-ME-Received: <xmr:5UFaZwO3NsyJRC8CxBBFUIJSlDcK57bPY4EvaMxhCIGcLlKljJmvwEa5p0xp8hhUHVyh6XJkeOansK2Vzu4jXI37AOkYAZNFClja2T8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5UFaZ24KYLFmubDS7B_tJ_DZckGGdwK00FdhlK6qO4Q50r5mq0qbfQ>
    <xmx:5UFaZy4J7wws6b-qG-kEl7uPOsFyK1vrevW3MqAMYt91pDOhj9PLtQ>
    <xmx:5UFaZ-jYVB-QEjv12HFboIDFVfw-sk0hUiwBZQsshdaKScsYsRNC0g>
    <xmx:5UFaZ05cfipAF_g8Ud7q-2CfzGJEtzZtDKVc8AUQphUske1U4xszlg>
    <xmx:5UFaZ93m1RMyj7UkSihzeE9H4Kfso9BuGmKwVvo_nN3Www5k4YK170pI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 20:52:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org
Subject: Re: branch description as a note?
In-Reply-To: <ldbhbymjanp5xg4suatp2bgbnk3etkgxqivytpqzyqkmsiuotk@hnro3pu2zqtj>
	(Justin Tobler's message of "Wed, 11 Dec 2024 11:34:10 -0600")
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
	<ldbhbymjanp5xg4suatp2bgbnk3etkgxqivytpqzyqkmsiuotk@hnro3pu2zqtj>
Date: Thu, 12 Dec 2024 10:52:36 +0900
Message-ID: <xmqqzfl1fz17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> One problem I see with notes is they all live in a single notes tree and
> are associated with individual commits. Therefore, I'm not quite sure
> how a specific note could be correlated with a branch without having a
> separate notes tree for each branch. Maybe the notes mechanism could be
> extended to also support storing notes associated directly with a
> reference in its tree? That might allow for notes to follow a reference
> as it gets updated.

The "in a single notes tree" part is easily surmountable by having
more than one (see "git notes --ref=..." option) and that indeed is
how I maintain the mapping from each commit to the message-ID the
commit comes from.

But you are absolutely correct to point out that notes are attached
to individual commits, and it becomes unwieldy once you start to
have more than one commit on the branch.  You can attempt to work it
around by enforcing a convention, like "the commit at the tip of the
branch has its descriptions", but then "git commit" that advances
the branch by one commit needs to move the notes, "git reset" to
rewind and "git branch" to repoint would need to transplant, but
then there needs ways to differenciate a forking (you are creating a
new branch from the tip of an existing branch, you do not want to
copy the old branch's description) and repointing.  It easily lead
to UI nightmare.

Abusing notes tree by storing branch name in a blob and taking the
blob object name as the key in a notes tree will absolutely not
work.  The names of branches are ephemeral and local (what I call
the ps/build branch may be called junio/ps/build by Patrick, and
both names are valid in the scope around these names), so using such
a local name as a key would make it even harder to share such notes
tree (not that "git notes merge" is a great end user experience to
begin with).

