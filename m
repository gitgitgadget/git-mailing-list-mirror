Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606339C002
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511275; cv=none; b=sNW79OAG0mkuEkWZ+T+z2u81Y/jtRxJs0qPG/a7c+Aq2zNhLrknQaNHrogg0xpnOKzFG2iBNAdpqJOUC5XF39ZwLUpblLwo/zrnwC7teW7v/RlHfwJ0vxv7Za8ngQDTupYye5vjeDbr0O3aCpctmYSQx42ONuEe1CmGUZIbz15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511275; c=relaxed/simple;
	bh=s8hzuT6rE3u9flSQdxNp4UcktJ3eVE18EIOXmvQ71xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGLGHs0OkpgZZmMEz7ufVt3rfKtBVc+0EPWgK5OvvAQ84n76PBoxll/MhPUOTMuFQ5Ha7D1Sb6oXFjiFLJf421k4iCrCuH7No1V5THXKw7Nr+3jdKlJTnABAOXdYPWJjyZfRAtb7ZtLhcgp8uyTe+edErd7momIGDS3RkxYRtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V191FFnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vrRGydTy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V191FFnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vrRGydTy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 84AF0EC0434;
	Mon,  6 Apr 2026 17:34:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 06 Apr 2026 17:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775511273; x=1775597673; bh=YvkhnznHM2
	tmprcobPhRnPf+icxQSwsALge98lHngAY=; b=V191FFnBI7yxJzVM7d1KHXKXP3
	90SKItub8oXUp/X31rmab+X92DcmtMpfIYHaJDp4VbwAtxwAvcjTN3CjXy2qZ8rd
	8HYck9zb1bqUL3OiAkm3iGwPqdykYl6MTyWat0E7HP8PewFREffgb6hvL+H4UwYT
	9YOQQx9BdAVZM4+AljFE6n5MnU+eZ7wq8QOnUrWpxr41PXqV1IS+84GdYQyr7WvM
	GyXI7VcDc2+TelvO+CV9LQZjBZdyREfmY7TROZIT2+MZ2tyzFAhHETXJrYos7nqh
	0gGg9fOIYxjmCm39C1OFqNgQ6VvcluH2SftOgYuogdhBUyh8RZg8Bedo+E8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775511273; x=1775597673; bh=YvkhnznHM2tmprcobPhRnPf+icxQSwsALge
	98lHngAY=; b=vrRGydTyxhlBxnSY7VXCcs18pi+JAFPnL8Vi05flczPc4LA5Mhb
	4y0SayreGC/XSGsf6J61EJgAJSD47hCPUufOjTb4eYYEu4aKqhMuU43Z4Dzs+9QY
	yHAIezxybea2PX8xwmPdAMXt2Q6lE4eWF4rqPjyd83uk8s5upAPbMpPG+mC4Mohu
	SD9oCU/NzugieMLKL1Lcx6TcY1Hxpt0KIu9Po3AnPxhtDmuRqmBEQzbfibOwjorc
	3KqJBFWvSzTEhqx9A/bdubJzDd0O41e0iD6dtgkcdxO1cUNkDqxCyd3ZzJ0WfKEM
	baHnDLfLFqq0VFcF3rMAOjWJnQQODXEiqMw==
X-ME-Sender: <xms:6SbUaQvIdDY9eAkknlMkgXm0PbFkhCQnnw2XCBDi9ZnFgtHdadLYdw>
    <xme:6SbUacgJAJ7Rw-UQnMGG6nFMehqjYcoHuY6407r-2gzuNcoE5Z8C-4k581s2wREtc
    qcP4pojB7qDSelAzI8mbSZmxJWUR55OooKrD14yRRgY_jQyrjdqKA>
X-ME-Received: <xmr:6SbUaR-YulaNQlwQfwnl4W_LLn5FMI46T-6xw5DOArSIOCF0sjwJmsYbmZulK-gAEYIeNbh2WB3Yx3NBaqn-2uPjX0wFPd7JRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlohhrvghniihordhpvghgohhrrghrihdvtddtvdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:6SbUafu8myVlen0N7eUiNNCAXXaYAgWzhHoBQ28Qj_hpt5b6SE8S5w>
    <xmx:6SbUaVqHu_gURduMtYYIwemtL4VzK839xTAeFLBN_MKZSmRTK81nfg>
    <xmx:6SbUaTp7Ixfi76_vQwtNEV9gcGQYkj_wYcQMyg_HH2md3O0E1NYXgw>
    <xmx:6SbUaUbkDCOE7VpSOrCJ_UxbUXngrIk3oFIznRL1Jsx25nVLIMMRFQ>
    <xmx:6SbUafSfVBsICvy6tRyeQJzHWPe2b5j7XKFdPZ_PIQ9Q5S4ObQLOxyfM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 17:34:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor
 file after repack
In-Reply-To: <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Mon, 6 Apr 2026 02:24:53 +0200")
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
Date: Mon, 06 Apr 2026 14:34:32 -0700
Message-ID: <xmqq8qazai3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> A ".promisor" file may contain ref names (and their associated hashes)
> that were fetched at the time the corresponding packfile was downloaded.
> This information is used for debugging reasons. This information is
> stored as lines structured like this: "<oid> <ref>".
>
> Create a `copy_promisor_content()` helper function that allows this
> debugging info to not be lost after a `repack`, by coping it inside a new
> ".promisor" file.

"coping" -> "copying"

> The function logic is the following:
>  * Take all ".promisor" files contained inside the given `repo`.
>  * Ignore those whose name is contained inside the given `strset
>    not_repacked_names`, which basically acts as a "promisor ignorelist"
>    (intended to be used for packfiles that have not been repacked).
>  * Read each line of the remaining ".promisor" files, which can be:
>     * "<oid> <ref>" if the ".promisor" file was never repacked. If so,
>       add the time at which the ".promisor" file was last modified <time>
>       to the line to create the string: "<oid> <ref> <time>".
>     * "<oid> <ref> <time>" if the ".promisor" file was repacked. If so,
>       don't modify it.
>  * Ignore the line if its <oid> is not present inside the
>    "<packtmp>-<dest_hex>.idx" file.
>  * If the destination file "<packtmp>-<dest_hex>.promisor" does not
>    already contain the line, append it to the file.
>
> The function assumes that the contents of all ".promisor" files are
> correctly formed.
>
> The time of last data modification is used in place of the time of file
> creation, because the former is much easier to obtain than the latter
> one.

The time of file creation is not recorded anywhere if you are
dealing with the usual UNIX filesystems (ctime is not creation
time), so it is not the issue of "easier to obtain".

The reason why this design chooses to add time is because in a
never-repacked .promisor file, the modification time of the file
itself can be used when you compare the entries in it with entries
in another .promisor file that did get repacked.  By having
timestamp, the debugger can tell at which time the refs at the
remote repository pointed at what object---the same ref may appear
twice in the same .promisor file and having timestamps would help
understanding what happened over time.

