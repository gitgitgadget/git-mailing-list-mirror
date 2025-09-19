Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5D31FEC2
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297618; cv=none; b=Y8JwBBK/V2IkKTnjsCCaZs8LMwRj1p3deIG5cwXXILC7e0pRPKiXGGsRYRjfara/dboXO5h+vfXklGmQhJBN9fEeqUfSSSI10vrPrngyP2fDc7TzzgOvghX8TmlCbbtIFofKlKflL7os+trEVqY1UE8UfHcAHYlH9ei16H/aByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297618; c=relaxed/simple;
	bh=E5i6NdntJ2XikxDIegUdngGF9yB4rAT5ekIRelA7qrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhYm7LKi42MaOErHJkTXu7ju9EWwXcZUTJ2mCa/MoMShwJT1wprY6Nb2hO6TkuPQYSwjYVb7nH+fvwhWvfH9d5Mh1dhIVkzYJzxacr+yPKvQpHn9HBuaJbBl57ug431MBqwPPn6CAkWmnXmi56oHppR0chiIv4XD9mW+S5IXwwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PKPMkubo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ze35VZHY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PKPMkubo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ze35VZHY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F29814000DD;
	Fri, 19 Sep 2025 12:00:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 12:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758297614; x=1758384014; bh=EErsPqViAk
	FiIAdglFHOzGEx7GUwvVpTOeWIYJ6u7hA=; b=PKPMkuboklncXXfhFYlk2FqMSY
	oPLrfDMT5WaAMs8F7GiK2YJ1Ty2E3X/6XFGo5ezW+A0xtjazD/yrGGk2vOdkboRb
	MfsyVC7g0Crq1BqZmMBzDOJszrIL3pmtRqYUhv2ttJY91N39NEjDucqZIAIogHHG
	bjz/lXuNQZql/eqUXgNUvTbfPY2BgnzsZ8oma9HwthwoYxIoyklm+tINbGaHO9o/
	W3+bHo+k91lWpGfkzZyx0u86kyhtzm4Qz5OC6LsHlMmnUgnW8fHaiurR9gbQBece
	b7Bnd6EZqScs5WrE1Ow3qcZgcP1kwL8vDjd/dENnMSS5y4Fkq2qypMspCnUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758297614; x=1758384014; bh=EErsPqViAkFiIAdglFHOzGEx7GUwvVpTOeW
	IYJ6u7hA=; b=Ze35VZHYsji6HSJlTPVCTc1fSR3OyEl02n9gx5IdeuGOVcCfr99
	kEXdCl/bKMmPG3uc13ToAZsT92S+v4aYU1hGaxXsDEyxfN3lmbImP0Rw4xD/2grK
	b5f5TEMcUl9BZbDBB/JYnLTA/4e1htr68Cv97b4MXxMAMNE/eBrK5hnSmqnNgaF/
	wbTTfvhotwt7xUCRXL8hc+a9BoUZs4NJuu7yL3WMRlNIFlC0XtT+jbHKxUjEs08d
	PVg9chzC9xHwWZP5Y/G278i8rHOiwuJZEi0sHJCZ1VSHReZdhjpI8kGFQg/KoQvq
	GNlQO8EhQxKLlldLWtOLJhytVeOMKfn6jYQ==
X-ME-Sender: <xms:DX7NaDoMrDwOC4uwbspR8aMQQ6PiGIZqgkakhITIX4U15bPuumSbvg>
    <xme:DX7NaJLjx5zhfetnvjPz1UKrnAoPNDtov-gg_8KyNlazjQud0pXSg95YyyS8Ng9LK
    BBbXqmIiaS0zyWVZQ>
X-ME-Received: <xmr:DX7NaGo7ykOkMJLvMQJ7-Ks5SgjTuhqBXv-6nKCUWkuOR8yxin4iP0vXeGmNkPsZthXTPxYRguAuxg4pkqFMP1NbSXiw-v2Cmvx4TLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetveeugfdukeeguedujedufedtudeuueeigfegudefudffveejleevfefhvdeh
    tdenucffohhmrghinhepshhtrghshhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    rghpvgesrghpvgeftddttddrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DX7NaBxFSnVaWj4G-h3WRQJdxG82JdP4t3sNe_NBNkA9t_WRePeyhw>
    <xmx:DX7NaKPugqyaK9wF5pb17d0zb6urS0GfNILwvPidEln2-viq6l1LaQ>
    <xmx:DX7NaG5Vo8S3y6AO_e4doVLtBH4gGRmgdU2oUIDINPpIVW7vPZV6bA>
    <xmx:DX7NaDl1JZW_IeV4hjFYEUQ4Z3tGJrfnXeOgWd8sjj1MZB56acwwvg>
    <xmx:Dn7NaOI-1jVNuSN_SsIa7OUlVJ5odpD9oeZbXp5SqL-tIeHkKI3eNs_O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 12:00:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Lauri Niskanen" <ape@ape3000.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [BUG] git stash show -p with invalid option aborts with
 double-free in show_stash() (strvec_clear)
In-Reply-To: <1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 19 Sep 2025 15:11:41 +0200")
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
	<1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
Date: Fri, 19 Sep 2025 09:00:12 -0700
Message-ID: <xmqq4isy77qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> What happened instead?
>>
>> free(): double free detected in tcache 2
>
> This bisects to 748bd094 (builtin/stash: fix leak in `show_stash()`,
> 2024-06-11) for me.

Good eyes, both of you.

This comes from the fact that the program calls setup_revisions() on
the "rest of the command line args" and have it parse as much as it
understands, while leaving the remainder that it did not understand
there, with this call.

	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
	if (argc > 1)
		goto usage;

If you give "git stash show -p --no-such-option", revision_args
before setup_revisions() is called would have

    .v = { "show", "-p", "--no-such-option", NULL }

and upon returning from the call, we would have

    .v = { "show", "--no-such-option", "--no-such-option", NULL }

with argc == 2.  Note that .nr is only passed by value, so across
the call to setup_revisions(), it will stay .nr == 3.

This mongering of .v[] is because the callee parses out and removes
"-p" as an argv element that it understood shifting the remainder in
the array, with the expectation that the caller would use the array
it passed (i.e. .v[]) and the return value from the call (i.e. 2 in
argc) for further processing.  It is not getting the strvec and no
access to .nr to adjust, so this is close to the best it can do.

So there are two ways to fix this.

The easier, more performant, and closer to the original design
around the revisions API is to do this:

diff --git c/builtin/stash.c w/builtin/stash.c
index f5ddee5c7f..b6312b1b70 100644
--- c/builtin/stash.c
+++ w/builtin/stash.c
@@ -1016,6 +1016,8 @@ static int show_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
+	for (i = argc; i < revision_args.nr; i++)
+		revision_args.v[i] = NULL;
 	if (argc > 1)
 		goto usage;
 	if (!rev.diffopt.output_format) {

A less performant but may in the longer term safer alternative is to
change the caller-callee contract around setup_revisions() so that
the later "unused" slots in the argv array is NULLed before
returning to the caller, i.e. instead of leaving

    .v = { "show", "--no-such-option", "--no-such-option", NULL }

in the revision_args.v[] array, teach setup_revisions() to leave

    .v = { "show", "--no-such-option", NULL, NULL }

there (again, we cannot do anything about .nr that is only available
to the caller).
