Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B01E5702
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161280; cv=none; b=I6Nzo2LZ78+8s0AUfC4+V8oZo4v1lP7up2PoAGTyhxg4pJHb82RFvwTZNFMdREaDXF7U8VhOpTHe2eXAHgjVEWVqmoE5Va6ZHuTb+U2O3vknKDYJJNP1XHzcPBOdJhjfLdrhcxC+I5BJ8dU2pa0l8uIPiokZABRVUKPbo5I8E88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161280; c=relaxed/simple;
	bh=TVikJ5Ctn8y+vv42wYsV+Wp2InezFId9RAS6oe1caWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j5m8HEqcat4qeZePJKbHIKl1I4cQ5N84+x7mfpAPW4hxu9lPSdN7/rtA44NjoaanZNQsU0G1fvrD+i9PqAUQmi7f5dP1ZvKe3sPbvMvIeYx9equVhG2PYkfXiuDjHJ6AelxHeTM/q2OWIsv4kzV4FvZRWnre4X81scMaRQHhJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KBE49Nlc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2Fbsv54; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBE49Nlc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2Fbsv54"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BFC81140061;
	Fri, 21 Feb 2025 13:07:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 21 Feb 2025 13:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740161277;
	 x=1740247677; bh=9CBBGBQZMCET+ZP90NZ12dAUCfwTfFkYLQpr2m47rfg=; b=
	KBE49NlciAnTeJvxt+MJrzVqXTP2jB8hPkUqbd1LRD/fTV+tTJZ/DB8nxIg3Uy9v
	Jxb2VPT4JKFrMR9vC14NI3VF/qqxQvj/PkucIHGeSFGixCfSFh3ByKn3LiyOU7jk
	nTahUCphrIJeWUPZhVz+LRRsU2FAw2TyOOZpJbgsJEp4Tnu1GKTFMLaTZtppCzw5
	2bxtzu0AQ4PWB4B4pyXOR1PxIk3/p7O/26HxoKS44xuAUasPs8dmKy+qhpF3cOab
	RLqh/rNMQeGpg/VXcYTpmJZZuM+TmridW/z/R9b+IzKHk64aMS7yUIq4ie7RvabH
	/FaxaAJio2PkVz5Px5oNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740161277; x=
	1740247677; bh=9CBBGBQZMCET+ZP90NZ12dAUCfwTfFkYLQpr2m47rfg=; b=P
	2Fbsv54Pn41MNQfUxFwcYY6X3Gvx6u8FSSgCdF27I5rLbiXh18pmHY3S58DduSsM
	mMnBIBJyf/5iieEtLPJyZEXwu3uv4u1/9z4FKMfw68DwJkfIvodSW9O+F0yxxQES
	ydnVG+k+6xqBxOKfnh800Dj012+wBY1Vt+aPI/1b3Htp7YWdXP+YlxBTCuBaTHVX
	cM3UPqo7u9FguxBt/0G5NbQNhsZJ648kSLJPDn7toChf2wTo5OY1PoKXU1fqu6bX
	cEjeGfyft44+1lhg03xreBD4d+i4SCoJMpExz1nnDBvrnepUSbWsaXDxZm1XOHPu
	SaizxBfojAgI1Pi1EKUrg==
X-ME-Sender: <xms:_MC4Z290B3j42nzm9H5hfLo_xH-lPD0cr39gjdJwWPHmbOYFYT1yRg>
    <xme:_MC4Z2tpEq5ec1iRy8hx4kRVwkIvtvpedOG6APPf-bUCnlW4fNA5AthmCUDaHOGhk
    6eFkYhNGTLmHeb5ow>
X-ME-Received: <xmr:_MC4Z8BckZigddUwgwE9LgggjLQoaA6YUhodrwRaFWyZxcA39H8GyJ3w9T2Ej2x6rR4bioYMCwR-QGUZrfg87mNX_NNHXpLD_n1Ls1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepjeeltddvvdehtdejieekleeufedutdef
    gfehtedujedvjefghefhvddvvefgueeunecuffhomhgrihhnpegrshgtihhiughotghtoh
    hrrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhl
    rgesfhhrvggvrdhfrhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_MC4Z-dpHNU8uEzeoQOXiiEzeJORS4y1pNWsGZ-fpcD6kjWjHTJKJA>
    <xmx:_MC4Z7NldnNzUaopX3iCxGHxdVPjOSGZcyg4oNUUbXFHy5MUlATmAA>
    <xmx:_MC4Z4m7sgTldJu4-z8T26mbmElzgWd2V6dgyZsU06-gK6-alNiP1g>
    <xmx:_MC4Z9uAgLfmJeo4YsO5s8H3FDsSPR6NOG8-4b0C3fa1EUXwogw8nQ>
    <xmx:_cC4Z21mm4xjmDo5Ze3cposA-E32LEYKXTW9DREt_alPRSonGOwmfDV5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 13:07:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
In-Reply-To: <70b76a89-00a4-4ba6-92f2-4fb46981317d@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Fri, 21 Feb 2025 11:17:41 +0100")
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
	<70b76a89-00a4-4ba6-92f2-4fb46981317d@free.fr>
Date: Fri, 21 Feb 2025 10:07:55 -0800
Message-ID: <xmqqy0xz9nno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

>> @@ -95,6 +102,13 @@ recursive::
>>  	renames.  It does not make use of detected copies.  This was
>>  	the default strategy for resolving two heads from Git v0.99.9k
>>  	until v2.33.0.
>> +
>> +        In the case where the path is a submodule, if the submodule commit
>> +        used on one side of the merge is a descendant of the submodule
>> +        commit used on the other side of the merge, Git attempts to
>> +        fast-forward to the descendant. Otherwise, Git will treat this case
>> +        as a conflict, suggesting as a resolution a submodule commit that
>> +        is descendant of the conflicting ones, if one exists.
>>  +
>>  The 'recursive' strategy takes the same options as 'ort'.  However,
>>  there are three additional options that 'ort' ignores (not documented
>
>
> If both chunks are meant to be kept identical, I would recommend to
> define an attribute (see
> https://docs.asciidoctor.org/asciidoc/latest/attributes/custom-attributes/)
> and use it at both sites.

Wouldn't it be a bit awkward to maintain a six-line paragraph as a
custom attribute, though [*1*]?  Would the resulting text become
like (without indentation) this?

  :submodule-merge: \
  In the case where the path is a submodule, if the submodule commit \
  used on one side of the merge is a descendant of the submodule \
  commit used on the other side of the merge, Git attempts to \
  fast-forward to the descendant. Otherwise, Git will treat this case \
  as a conflict, suggesting as a resolution a submodule commit that \
  is descendant of the conflicting ones, if one exists.

  recursive::
          ...
          the default strategy for resolving two heads from Git v0.99.9k
          until v2.33.0.
  +
  {submodule-merge}
  +
  The 'recursive strategy takes the same options as ...


Just as in C preprocessor macros in *.h files, I am reluctant to
force our people to edit long multi-line text while not forgetting
to lose the backslash for line continuation (or misplace existing
ones when wrapping lines).

And of course a 6-line paragraph is not large enough to put in a
separate file to be included.

Hmph...

Thanks.



[Reference]

*1* 
https://github.com/asciidoctor/asciidoctor/issues/1341#issuecomment-101841014
