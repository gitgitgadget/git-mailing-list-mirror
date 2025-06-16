Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F05282EE
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113608; cv=none; b=HkU1PfnhdbNQZ9O1o9JKNwMpWKObBTBokVCYtSWH/UftsbG006+sHBQoCsiFl0q7T8aSkoRuwO0m8nzJweuiqlCMB7YlKB7L89nkopnDiAocQPEObtcQK1fwFg9t+KwLQtMPesd0lRTzYzU3IvY/2TA6bGZSxblbNicTwwoMY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113608; c=relaxed/simple;
	bh=+s19HHj/Q/vS0xcODQJUyBU2RkwlwbOw7YFqo0EHb5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hQjV8xoo/JbfpmQ2g0MOiXaGU0WUaVehUt/iKHmpzxpEtRnED3pzuH0HpIsv4aJz+x2BFRTchvqBLf6H0W8+vCS/nT2T1nnuAX16r1POrf0MWkgbipwnh8J76B/XnU1uwHcocc5eDpau5d0pZWfSA8RZ0O6BuoXSbcV+b2vXMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QDcw3Y+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JOnn+2no; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QDcw3Y+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JOnn+2no"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D3A1511401DD;
	Mon, 16 Jun 2025 18:40:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 16 Jun 2025 18:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750113604; x=1750200004; bh=IKxG8fHlXK
	Dzif4nfNd5u55pmVefE+whn8oiCOJhII4=; b=QDcw3Y+8M3s2/PjBI9oMkgE9XR
	98+N9tgbamyONgYDPBpEX6GXeMEWH5u1rrKJiYeAlnPMKpdjboYqleuClyjDvR5q
	r76X6TY/J6lshb7y1oBafjGeXQV8WTOXUU0BsIe4YU2rPk5b+wKpdH8+dssqm+xp
	C5m/noU6uluIYh3GaRdiBKZbEEsz94zuiIP5GoTu1P0J8YDCP21tkF890Yj4I2AF
	E3Z92ucXbztc5xu3FiepIOAEkeNZhUWepiCMv8u+B3UjdsMIxB2wIR8m9DhxF9RK
	ZfbxX2Uv7QWZbESM7/04zu8wjzWe/VcSX6npGUc5pg5Cx8ETmlwCb1ibjJkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750113604; x=1750200004; bh=IKxG8fHlXKDzif4nfNd5u55pmVefE+whn8o
	iCOJhII4=; b=JOnn+2nojXQTohfIfDK5H4iP+oYydZU0TdyiAXjUq3/7YZnU4CE
	Dp5FmGSZ5yzauns8GAYMeOfw73jOeJkFRmG3NWEZnclYDjPNvlTau/Ou5IbmgAAv
	dqRNfspa7i/WbY3QSYfOCe/uPhZ29N5IHHVNy2GyVzSGpVhG7VCMJPrJHdT5W+Bi
	hyK4VgzGPDQbTvH69pIlsyujlKomFWk/h4NqqOElkrbiYUp++W5TaYWl688K94Xv
	2CZ6Yt9Pq7LXZQzH0CMCsaPaCkHx0T98tjvM2iynVtLj/adz+DNylsVrePHfbGqI
	Doll8eUe+w9mpwhOkXeJ9P9gr2vVnrq7sAQ==
X-ME-Sender: <xms:RJ1QaEiMGxB74RdEd-xIB0cpN5Y4aE8tu5MGFER-jK1y8JIQZmrOvw>
    <xme:RJ1QaNCGGaYLDxfP5aFdDo7Obng5CZ2_6ao959QgO-as9j_UF_3GoSIhSkR6b7e8K
    dsPAbVSwzQT4nPoiA>
X-ME-Received: <xmr:RJ1QaMGeHUcxNZ79uji4DNW_gLpLM01AGZD5eBR0FV_CUoOgg5V5lI8yTfbM8M090IApiRShuLYKUoXSTEfCyFhXCu7GDzb7UMh_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RJ1QaFRqDeGsJPm2pGBtV0dYzAgetRmlQQKgi3rL9_tf4ovReDRkIg>
    <xmx:RJ1QaByC8fk06r_QrzjEMjmEJM9Th-s4uHagSBRn0CpTRhJBzi9VPw>
    <xmx:RJ1QaD4qcCHQKaENgM534e3N1fo18Mzmyti1DAGqUSatSEenXWlwVA>
    <xmx:RJ1QaOxBeyp9vf2mGtbiMeKjRS9RJLOVpiBDUJ-U4Yg-9ckfbtGoZw>
    <xmx:RJ1QaByIXFvr3r3zyauc2KyfMlewhDAVVBo1j6X0q4ey0ngrcCccjip8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 18:40:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving
 repository info
In-Reply-To: <C339DA52-F88A-4BC6-98DD-1586A1B4A175@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 16 Jun 2025 19:19:23 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<xmqqikl3mtx2.fsf@gitster.g>
	<2EB72983-BA77-47C3-9331-B08760B092C4@gmail.com>
	<xmqq4iwkd68p.fsf@gitster.g>
	<C339DA52-F88A-4BC6-98DD-1586A1B4A175@gmail.com>
Date: Mon, 16 Jun 2025 15:40:01 -0700
Message-ID: <xmqqfrfzz4xq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> Let's learn from our earlier mistakes and do it right in the
>> new incarnation.
>
> Ok, fair!
>
>> 1. In text mode, the values are shown one-item-per-line, even if
>>    the value has embedded LF in it.  At least we assume that the
>>    values do not contain a NUL byte.
>> 
>> 2. If a value does not have LF or double-quote in it, it is output
>>    literally.
>> 
>> 3. Otherwise, the value is shown with quote_c_style().
>
> Hmmm, ok. So, I if I understood it correctly, is your idea to keep
> the same functionality but using quote_c_style to keep one field
> per line?

I am not sure what you are comparing against with "the same" here,
but the idea is that not many items have problematic characters in
them anyway, and a simple-minded broken output parser can be written
in 5 minutes and would happen to work correctly in more than 80% of
repositories ;-)  A production quality tool needs to be aware of the
possibility that they may need to unquote when they see a double-quote
at the beginning of a line.

By the way, somebody wondered in a nearby message why we do not have
the "key" and only "value" in the textual output, and I share the
same sentiment.  Where JSON may say

  "path": {
    "git-dir": "/git/dir"
    ...

text format may want to say

  path.git-dir=/git/dir

instead of just

  /git/dir

But I dunno.  When asking a single item from the command line, it is
perfectly fine to respond with a single value, but when you are
showing multiple items (especially without any "give me this and
that item and nothing else" specified on the command line, in which
case nobody knows in what order the value is given), I think the
calling script almost always wants to get key-value pairs.

Also are you planning on later adding a long-running server mode
like "cat-file --batch-command"?
