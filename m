Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6385A79B
	for <git@vger.kernel.org>; Wed,  7 May 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650723; cv=none; b=ikPWwcGd0c2XrPNVNk7GAIzxoVn/J4VJ8zLwSNxx7F85UUEZzMgarHapTr576TeespJWik9eBddiOpnBEpSlaR+1AjWxpVwyJlVR0nkQW+fBFrXBVbvyMnrUluJjMzL1JIIGbyw1GjjJj9mvYK1IzUn+Y0A/OEbitBTD5U5UaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650723; c=relaxed/simple;
	bh=Ny2SV85WntwE1jsnCt4MGhm1ViQM92tiCvZtwTcv/bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uF96uGTU8sCj7AqCd4cESLt4H7lAPhumpYA9Ao5LZt59RCSMiAsja/xEa2CiwCOkxbG7F9zODK1vVgnNTSPV76YrSMbeExCtrWOKMWm+/vpzghNnzq0BGX6zCt8O+kPWcAbQ7H8B+W/p2op31rnfg06DlXpNiA/j6lvyPzdyhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VSp/Q/bH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=av+3FAn+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VSp/Q/bH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="av+3FAn+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id ACDC71380163;
	Wed,  7 May 2025 16:45:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 07 May 2025 16:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746650719; x=1746737119; bh=SdkJPZmXb/
	HnyXVmMl0bGVbbOJ0BmTsQyVEbod3HAmo=; b=VSp/Q/bHXM51aCalUg085I0oKx
	TV8IRO2u+C+B90HKc89T6bp+mqxqA8/oiugg5Z680LQKBvFbhQ7+6PYKXxnSNQxD
	8DA9E9PIxkYZB881Ah0w+yzHvWnqyTUAFVfW21u0V9/gMBCBRoKw9/9hLYzCEbnt
	gasS3S10OTuKeMAzOhRi8+tD1G74JoxYqFh7zkGUUZt1PBjr0lHSgV4a41s9XlSp
	qR2ILh3KJUFw7fgY3zIB7jdGvW7/wij0ZDXtx5j4ihkVzzkRhKUpWuHEGS/XKoqz
	jxZDFYLmUT24jju+Y5q6PziZFC8pmPl9GzzoPSgP12TmcYNsoCI4Jxe/5eEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746650719; x=1746737119; bh=SdkJPZmXb/HnyXVmMl0bGVbbOJ0BmTsQyVE
	bod3HAmo=; b=av+3FAn+/zVXhqzzT3h90ym0lROQaPLcWX7YbRkVPxW6WmSyD2N
	d9Ab4MApkBPBVmXK22mNQA9f7l5e7UQ11hvyd8xzRmUlU49pgNI7BjojAHonbHbG
	tlyoSJLJF5yC7R/sPiT/IZWbT6kdO8OH8d5Ah7qfU3USByHiRQo64ax1u54O9jeM
	aaUFH8/by2ZvmQo6iAhAAQAqA5XCpYjL9ztRHo9vrxjTvg1gyGGMI4MpPvASaFnq
	o4LGSBkV/rGMZcX5oLqmuwsQY3S4mZieSYJhx3/0fTWbpJ31oJfIXLsK1wI1VvHd
	h7uBXqVmw7E3eViiQFkimm8oPncJaL1nUNg==
X-ME-Sender: <xms:X8YbaCALK8Oa-P8JSSwixaQoaXvQiP2-i9nRWgXosDez9fXvdX__eQ>
    <xme:X8YbaMiYyA6tF72E1hd1Fcftb-v51mVGxdaL1OmVtieoPQyQ0Cif6dPsvBUACqotw
    JlojDHr8Z7A7ThhwQ>
X-ME-Received: <xmr:X8YbaFkVbcR5bQU1K_XPoA67fkS1ZcKvAiVRVgZ4aS3Hj06l3jf5XKdSAdDWTLRFkexxwResyFzlo_W9IEQsasGME7DbKt5glXlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtnhgrrh
    gtseigihhplhhinhhkrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegrvh
    grrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:X8YbaAx5j8SBkcVYny6hS0OPGrm0zh_43BRa6HsvLvdSipKG4uAlBw>
    <xmx:X8YbaHQWK9PrLhJyM-LqeDnwQqZVKPYdfEoexc9b2qOTo4nb5feKow>
    <xmx:X8YbaLZjW2vpRdi_nC69-3AdX6LeWynLCdoia9gBfBIWtC5gzo1CTA>
    <xmx:X8YbaASK5AO6nL7m5dRXTmMbEE0a567IOv--pJoCgPyu2AOjqc1kVg>
    <xmx:X8YbaOT0UM6RnH_snOXcsY7KLJQuMX8ONzAyJ_IgMFf9_lmsAStdks3J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 16:45:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
In-Reply-To: <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com> (Marc
	Branchaud's message of "Wed, 7 May 2025 16:23:37 -0400")
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
	<69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
	<87ecx0ijqt.fsf@iotcl.com>
	<323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
Date: Wed, 07 May 2025 13:45:17 -0700
Message-ID: <xmqqjz6sb15u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Branchaud <marcnarc@xiplink.com> writes:

> My concern is about having two commands to do blaming (or "crediting"
> or whatever anyone wants to call it), instead of just one.

Existing "git blame" (or "git annotate") is about tracing the origin
of individual lines, so perhaps we can say "git blame" has two
modes, blame lines or blame files, and run the code for this new
mode with "git blame --mode=file" (and add "git blame --mode=line"
that is on by default that runs the original "git blame" code
paths)?

> I mean, from a usability point of view, it makes much more sense if
> "git blame" simply understood how to handle blaming a directory
> differently from blaming a file/blob:

I think this needs rephrasing: blaming a whole file (or a whole
tree) differently from blaming individual lines.

As lines can move across files, and we do find such moves while
tracing the origin of each line, "blaming a file" is not quite the
right way to think about it.  "blaming lines in a file", perhaps.

> Git should be smart enough to figure out what to do from just whether
> or not the last argument is a file or directory.

Ah, that is interesting.  We do not have to introduce "--mode=line/file"
option.  Just see if the given pathspec names a tree object in the starting
commit and trigger the blame-tree logic, otherwise we just line the
"blame lines in a file" mode.  So dispatching between the two modes
is almost trivial.  I like that.

After command line option parsing, however, there may need some
sanity checking logic like "You said you want to blame the t/
directory and its contents, but at the same time you have -L1,10
to say you only want to blame the first 10 lines, which is an option
that does not make sense in blame-tree mode, so I abort".  As long
as that is cleanly done, I think it is a good direction forward.

