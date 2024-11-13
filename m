Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900427456
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462524; cv=none; b=gilD7OohDuPj8JMuwPenG1ERCkiUHvP83eHtdhOqpdZDV8AFw2uB08h1lygdUQPnmwK7xvsfKSnjkYdx14MCY7NWSLXN0xYexwaDfeEkN8qcnupn+zKG6Lca7OAplkA3Rbv8c8evvVjFpNSF2yLwe9Xb7g2DzQmi55FFb7MiZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462524; c=relaxed/simple;
	bh=C/8Sv1dtJagfrr/xHME78nT68+UwiSKbtomeqCOkZag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FaTPHvek/S2PxSRZfK7OwLEaWZzDhGXP5QfYdZyM6DjS33337GOMuiizz5ODMqJOQThIwIj52brMSXOgkIErIzVM4JiF8cBiIW6Y0+c/tie33m0MP4mFTfczY+YXpObrxNkIiuF38hpQND2CQJBdTbI5Co2l8eYCztrgIkx4fCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1ZjH9Mn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1ZjH9Mn"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E8F79114013A;
	Tue, 12 Nov 2024 20:48:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 12 Nov 2024 20:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731462520; x=1731548920; bh=iflMxHs8tp3qe7rbmlYNJIQTp83GqOs+jyw
	I+iif45A=; b=c1ZjH9MnhgSaX4bJ8QVAlF3ed/Wablm0Inx808rHZL7/pO8N9tM
	ZHNZ19/vAB7E3DnI4jwJZfrlQSKGueVltbnWydsk8wxgAG+/lF0jNsV59NvhiDUY
	2P9Bsk/6ufIVHiUt1YFJgOwOG7IxiTffSUGJZAzHHFqwiaCDNVZjoF+uGTleo0Pg
	A0YaB8XTUmdoBaqnFoDRUL9wOjevRrslG87uQ2m6rFVZ6Cq3p6TY7UUbky/POQnz
	U2guJE/3nI8B4kGP8NeTN71y4imM0fPWKaEMtltlAyw2P5T1OykMcuafO0ONjY3u
	JNBdundBGBq06W4CmABsA9unlH9Wd2gHxqA==
X-ME-Sender: <xms:eAU0Z3aZE148PSCbb0Kutf_eNMe29eHG0K3KdZRV1zeYNO-uuAdSmw>
    <xme:eAU0Z2Z39r48V3iprQz3Rs-iQf69hfgkYzInLl3TEgRe9-YUIwvt0lGRwdGZ-MpSo
    80cK3cEvnXPnGJoKA>
X-ME-Received: <xmr:eAU0Z5_SnjtWg5ssPLSf_u7QaxmYEcfC9bh883pGWJyk6t8GdqpBgn6lkq3v2HZWIHSI9dMQik3oW_peXENY0ksDUBTYQaVfZ9g0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgvthhhsegvshgvthhhrdgtohhmpdhrtghpthhtohepug
    grvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eAU0Z9rzUWUTX9J1Lwc2FuBqFvtXdePOriBLmgv8-h9Kqt2SWhb5Iw>
    <xmx:eAU0Zyp0NtrQQ3TyPB929w85aILgnDNbkjewdFjDwxFQcTRMQnQB_A>
    <xmx:eAU0ZzTOK9kwIxdnFZd0sj5OKMHBblYPWADNb2f6BlUdD1-6dttuAg>
    <xmx:eAU0Z6oVd3W7cpzkHVZGD_hsTQy9ymyk0-1xoxl-BJJM34Iu7GAzyQ>
    <xmx:eAU0ZyKnJLb8OSkUysXbMrPIWvcDu6tFADWUyMHZq7-8PxQcV2wEDXQc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 20:48:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Seth House <seth@eseth.com>,  David Aguilar
 <davvid@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/5] git-mergetool--lib.sh: add error message in
 'setup_user_tool'
In-Reply-To: <79c3a6ffe8f2872755f76340e2d5ae1a94885456.1731459128.git.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Wed, 13 Nov 2024
	00:52:06 +0000")
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<79c3a6ffe8f2872755f76340e2d5ae1a94885456.1731459128.git.gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 10:48:38 +0900
Message-ID: <xmqqwmh729ah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  valid_tool () {
> -	setup_tool "$1" && return 0
> +	setup_tool "$1" 2>/dev/null && return 0
>  	cmd=$(get_merge_tool_cmd "$1")
>  	test -n "$cmd"
>  }

As we are checking if a tool is valid, it is normal for setup_tool
to fail when we are checking is not valid (aka "fails to get set
up").  There is no need to show an error message for such a failure,
as the callers of valid_tool would do so if they wish.  OK.

>  setup_user_tool () {
>  	merge_tool_cmd=$(get_merge_tool_cmd "$tool")
> -	test -n "$merge_tool_cmd" || return 1
> +	if test -z "$merge_tool_cmd"
> +	then
> +		echo >&2 "error: ${TOOL_MODE}tool.$tool.cmd not set for tool '$tool'"
> +		return 1
> +	fi

There are only two callers of setup_user_tool, and one of them
squelches this message by sending it to /dev/null.  The error
message composed here does not use anything that is unique to the
function (in other words, $tool and ${TOOL_MODE} are available to
its callers).

I wonder if it is a better design to leave this one as-is, and
instead show the error message from the other caller of
setup_user_tool that does not squelch the message?  Are we planning
to add more callers of this function that want to show the same
message?

>  	diff_cmd () {
>  		( eval $merge_tool_cmd )
> @@ -255,7 +259,7 @@ setup_tool () {
>  
>  	# Now let the user override the default command for the tool.  If
>  	# they have not done so then this will return 1 which we ignore.
> -	setup_user_tool
> +	setup_user_tool 2>/dev/null

If we did that, then this change can be dropped.  Instead, a few
lines above this hunk, we can give the error message ourselves from
this setup_tool function.

>  	if ! list_tool_variants | grep -q "^$tool$"
>  	then
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 22b3a85b3e9..82a88107850 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -898,4 +898,12 @@ test_expect_success 'mergetool with guiDefault' '
>  	git commit -m "branch1 resolved with mergetool"
>  '
>  
> +test_expect_success 'mergetool with non-existent tool' '
> +	test_when_finished "git reset --hard" &&
> +	git checkout -b test$test_count branch1 &&
> +	test_must_fail git merge main &&
> +	yes "" | test_must_fail git mergetool --tool=absent >out 2>&1 &&
> +	test_grep -i "not set for tool" out
> +'

Why "-i"?  I do not offhand see the reason why we want to be loose
here.

The "${TOOL_MODE}tool" part may also want to be verified, perhaps,
which was related to the topic of the fix in [2/5]?
