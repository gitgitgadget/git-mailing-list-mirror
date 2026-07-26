Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BD63B9
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077957; cv=none; b=oDJGBknnpihnwVtNKz9Bflp8JHhkR4fs8Sry5ISp7jdC3efNit3nS+/UZgc/SccT3ydSc9Z09SvHSvDDUpT64wAQ3yOTLEtedJksl5r2+NOAGiG9moZ594OACHj2HtIt1Um9ANvNOPWQKbPRLdsIGXZl60nBSfxfvxck9UPdh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077957; c=relaxed/simple;
	bh=cocLUoQiqy6fs7rGD9gD7okvLhErdLtZ09sWPHdfAyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdcFvVgv/NUVkpKv/kpS9nTQz0RL5zER6ZvYkpUyPmR1+KC4tMvLItY28g7AOPm2cd3ad45lv2hH8CPQXBcNehkSG8EOYkBveGJOyYYgKZs/qZe2c2NcUqYvHSmojNaSvN7cFHCK/iSh/llaSyHELN995oatJ1BYg+bXsTMevCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=we/kLn9M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVE0LRZ0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="we/kLn9M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVE0LRZ0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 57851EC03DA;
	Sun, 26 Jul 2026 10:59:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 26 Jul 2026 10:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785077954; x=1785164354; bh=kxoGXHeNrd
	zE5ElPltzbr1EK1LZ9q9NHzAF+y1xNnFc=; b=we/kLn9Mkj9MPexKLjJJZcWQxS
	lFohUjaXr15jHt83u/NFyEdu9ly2wHX7Pu+HbTx/e6uFVV2iT/mj6EDIGZihukNe
	Sw5h9t79i/jZ934+T1UgFqgzegaB7H6sG9SIpIXtH8HgCAnfIRT7ZbI/mbV2mf3Z
	5xItqNjIFGRS4/I8H0dxdVi3MqqCvTcAxy//TSuuEGNTAd2H0QkRLTfdEl0k0SI6
	blZiIx1+tA1Opr0CRW83B3dOXRxUeSAjWIcxIYgfYhQsasV+IUyVDID4gewe+zRC
	4C2sjePpKtpbpQi0Oy6Oa/sLM3Ao7dN30omOY1aw3Vz51jRlUu2SDvcsJYyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785077954; x=1785164354; bh=kxoGXHeNrdzE5ElPltzbr1EK1LZ9q9NHzAF
	+y1xNnFc=; b=LVE0LRZ01qpjagFXOwuXWKoFcGEagP8Ddr/auF5a5OnkNhudElH
	02LYM9OHOUKTJ2KCOwdS/bntK7RUHVzt8Y+NpVUiASN3ncw3xIeELG0UeeZ+6CW8
	WfWRFkoDUyFgDOGffBU48sG2YS7ZA6OcjWjVkLywN85w+mOItaSBvzRrQDvTxKc3
	ad8y8XHJs3oBviDqbFevTr06Ns3ZSUScy/vswBef9rHZFNUPw+gDaweRLMczsaa8
	3qyYxCec/WFuklM8gMiRW2UD205MMB8CTP0QMXveTRk6F+SkBKzNb/7NuVK1QHeB
	MtONlUAUamY1/AZ2Nquhf+haZyG6O9Q+5nw==
X-ME-Sender: <xms:wiBmagykHufAv1hS8c7I1McR31lHLsCbh7YYqiA9nFvsfdsKxHh2FQ>
    <xme:wiBmarKHq614KgUCEI07IiHTel8YTJuUGl7Y0XswET9FxgeRKjbkbiy2Q4f5IX_bp
    tutknXv6e4-sYIsVXsEIiaDzweNUfU7-jt_uJzc-Ib9Pbj--hYr5g>
X-ME-Received: <xmr:wiBmaqpFHSVZmM4SClj7R410f-RWjfHq4JShhn0W5I0XbJbvmH7VXBzDXXvJvn0BHNsA6LtHYummK9tbu4OyBk5vBjgrguum8Q>
X-ME-Proxy-Cause: dmFkZTG2gOqOJrRFRklZyIWoLk0Q+a0+rw9ROFHfN6dLJfDjZP+Rz0KCwwDwoOgm+Qd0sx
    RyliPTzsMgzIbPLJFrJQWhLowj1BRM5hIYAeB9Nw7wDgWnZkguKIM/sdiCck1mqbcfxM5y
    Coh+o8Ni9Ckv5pHzGKpYfecjEG1YmwukfHlbyZMe3e+jf6MabbPFliNq8aad4WDf4vHLVp
    X6iXc/q8L9QzgIAK6CM6i77tWXqve7aJxDmd9kHC+OXQewT56viGkvwYiU07Nco8b1dFaM
    9tmeLUdbVDFOiVI2wKKXutiJ9hEnJ63qtel2dEkg9fGbbeicScwEqkzqmsAH5YXX7jduaQ
    x4bLuA1qSbd6HGdBd9wDs9ItZIV3Bnds3XHLTKKVQG4dfv5awtRYLZRBQR5fGCrg1Enw3u
    NNoF7V9CF0cGjhhZ7UQzLmJJ5JNuhSs7i178diEwwyho/cX0SV/vZt52IANkfEu5xvKy2b
    7VL5x6WO0cODJNnXtfhTWWdd1o1oRTN2tTIepDnyR/VwKJ6grVeow3SDmB2TzRWXPAs3aG
    0A87AfxJunPqIpSLxvfifugPh8QcxUxYiBuQwFx2tyeao0bjwY2TaQ4R70l+6f1jz6ZIGG
    Jg/P9qZezipo64jCJIEqleEEOFlUVgz4pum8iZGQc8pqF7CL2nKWsE2pqMog
X-ME-Proxy: <xmx:wiBmaqKPZkQ2kjN5E0JPMLrI2aILQUd22ZUxh1wnusAkE-EAcYTvuA>
    <xmx:wiBmavRwJF_I_e6rJPBcEniCIiG77BWlg8khvD8l1wE2E_s--7czIA>
    <xmx:wiBmapup6_yXMrVYwhueFQh0qjKL9z_t3YuuGP62l3pdQMPOoiaUdw>
    <xmx:wiBmagbB1YXA3ramb5nlN71iBleCZGtKdIgt0-lZDliD6GkflXzP5g>
    <xmx:wiBmalYQlrIg20MhTXXY40MJR4646cbUiVHcOLHY3PtP4Z4du3q4_ddl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 10:59:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Zamboni Orioli <lucaszam0@gmail.com>
Cc: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 2/2] mv: check for missing destination directory
 before renaming
In-Reply-To: <xmqqcxwdcmln.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 Jul 2026 16:28:20 -0700")
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
	<xmqqo6fximn2.fsf@gitster.g>
	<CAH01Q-_2APONq2fXmjF=Wo08rTzScMEjyXL-G=_GH6TbjJmTBw@mail.gmail.com>
	<xmqqcxwdcmln.fsf@gitster.g>
Date: Sun, 26 Jul 2026 07:59:12 -0700
Message-ID: <xmqqik61yeyn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Lucas Zamboni Orioli <lucaszam0@gmail.com> writes:
>
>>> lstat() can succeed and 'dir_st' may indicate something other than a
>>> directory (for example, a symbolic link or a regular file).
>>> Alternatively, it can fail with ENOTDIR when, for example, 'dst_dir'
>>> is 'a/b/c' and 'a/b' is a file rather than a directory.
>>>
>>> Both cases will cause 'git mv' into a path assumed to be a directory
>>> to fail.  Shouldn't we handle these conditions as well?
>>
>> Yes, agreed, both should be handled. For v3 I switched from lstat()
>> to stat() so that the check follows symlinks the same way rename()
>> does, and I handle the non-directory cases:
>
> Generally, a symbolic link in a Git-managed working tree should not
> be followed.  Following a symbolic link would mean that 'git mv x y'
> could move 'x' outside the working tree if 'y' is a tracked symbolic
> link pointing to a directory outside the working tree.  'git apply',
> for example, avoids being fooled by a symbolic link for the same
> reason.
>
> I doubt that using stat() instead of lstat() is the right approach.
> Doing so essentially amounts to ignoring the presence of symbolic
> links.

I actually think "outside the working tree" is an irrelevant red
herring.  What is relevant is the fact that Git tracks symbolic
links.

If you have x (file) and y (another file), you would want to
complain when the user says:

    $ git mv x y  

because the location y is "taken" and the command line tells us only
about what it wants to do to x, without saying anything about what
you want to do to that existing y.  If y were a symbolic link
instead, you should behave exactly the same way.

It actually takes even more care, and I do not know if the
implementation of git-mv is done carefully enough, but think about
what should happen to:

    $ git mv x a/b/c  

when 'a' is a tracked symbolic link, and it points at, say, '.'.
Should it behave exactly the same as:

    $ git mv x b/c  

or should it simply error out?  I think the latter, "I see a symlink
in the middle, so I refuse to follow," is the right behavior.

Think carefully about cases where 'a' is a directory and 'a/b' is a
symlink, or where 'a' and 'a/b' are directories and 'a/b/c' is a
symlink, and so on.  We do not want to craft an arbitrary rule that
says we allow or refuse to operate depending on the link target.
