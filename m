Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242521C1ACE
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783826; cv=none; b=E0xQV57uJOmaxlVl1MlqcpoZY41b6Vcxtm/yRk1fAAKXF69I2UO0s2EJEaaCRt7+AyuSwHJGw3Q+mn43INuQEq8zbpiW2+9Udf23c787XVSy4kPfkHv4RsIPXb0KtYD6U4WyCDUbbYjknlWBGdHSDksxpEkN3BOpcp+LGpItB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783826; c=relaxed/simple;
	bh=4OK5hSQMHQeH2cL1Ci01xGXhr1po1wh7qSnpYMFS7yY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FA2STVGjFYOxZ6oWPHD1xUm1kU7uTcC2getqrueEVfqfR1jOlAh9gRC43Ks9diyq1dmlpAO3t9CF5ke80Ai3bKpcqgD9/Z0gg9Ir9i0mQUgsze3w2rSVX4v5JEGjyPg7JutTmtlLMVBfXmy+Vn0axsk6gkX4EBgZPXXJq/BapmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wN0xFXXc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dmO1fHna; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wN0xFXXc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dmO1fHna"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 173161381B6E;
	Tue,  1 Oct 2024 07:57:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 01 Oct 2024 07:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727783823; x=1727870223; bh=cMtBXOl65E
	gJkD2pu190lcdIpLVPI+jv0e3mDpmiN/8=; b=wN0xFXXcvxq0+4RYNox0yz8oDo
	KoTSrDmYvbqMpQXzPs0BSkDJHOZiRqQzB/kfsHXqc+QbXqQIbdWWDp4+aRw4dAFt
	hpRkdeJplhbiYHXS5RAZ1g0cqcr37V7H+CaypZJWh3tqG13BbC7mnx/c4/xuyhqc
	q7deoeXHxpwwEBVQdKVZPsS7jyNriSXPLNqW8YKg8YeB/7JNsKogVtzgWjIsOrz+
	X0ciEmr/Bt1n795l/YrAdtOjd9rUtxnnJKf7Xa5DU3XWDutYvcK9XhOm4x/MDgg7
	u4zhLNiwwufKjBmK42BwiXxtxENdNS4U6MaupHrotU60Qt1ladHMgD5DLfrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727783823; x=1727870223; bh=cMtBXOl65EgJkD2pu190lcdIpLVP
	I+jv0e3mDpmiN/8=; b=dmO1fHnaSDJmKQ1nBoD7eigbUZkPXg9KJB30bszErWFY
	yiWmLlBH75pObfU5OY+e0gE6Z4o5JbIvpsL3o4alxUC3OOgKRIoRFWJBuYypTgBp
	byYCORJzZHZW21NlelOZbo1iLa9OxUASWmknATsKGGg+TCEMsQgUGU+Y2h+v5nrZ
	Ly4Yn3OTMN8+eUWvm9ivMLvJuwELBuhfvTqAL0ATFuJXsttVPw2JvDkespmcR0GP
	uVN6M0h2YxRCjix2So8WEM8NQqiF17V/cAi86SE0PvaQ3X9Oxfn6aO6qgcX7ZGuU
	c7yy0vIKlCVKvzbIu9xV004HIC6Lt+lPBbmXeMKgQQ==
X-ME-Sender: <xms:juP7ZuFzF1bCNDzXiamMC6fw5KlUKvMxeNtrtfZHsVRQ3yuVZ0bMgg>
    <xme:juP7ZvWYevNlDPl22nJJsJqvuNbJETYiHB-Hv2As-7OMt_mIzrrBof52_yCWUqJUU
    zQmUa79Jr7cZK3dPw>
X-ME-Received: <xmr:juP7ZoKW2z8knn7Z7TH2qaqF1kdPFJlOeiroQYvygYacK2BSqSIHCLUtgQH5F0UO6qqViwEvj1dkJiLB6yIWnDAuL9tgeJL8VvSG9hI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:juP7ZoFNczqF2rJnliu0XaURq0zxc9z05faVD6LTspfBYeate5V-1Q>
    <xmx:juP7ZkWq6QcgEkBOrFdavgEdH0XNhFkh9Fwu3I7ZyZuvNenuHwlovg>
    <xmx:juP7ZrMZ-pvDK1DyNj-3HfIznJx80ZkPoHPyM2tJaCszrjYDGngRZA>
    <xmx:juP7Zr1UNXr2Gm2gAMe3w-yqd-k2YP3GiGYVWehTKllefv98PPD54Q>
    <xmx:j-P7Zizew9dPkJZI50HWsg-S9rG0UeJOJZ2012Qhx4otSamNysXOY-im>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 07:57:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
In-Reply-To: <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Tue, 01 Oct 2024 05:09:30
	+0000")
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
	<pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com>
Date: Tue, 01 Oct 2024 04:57:00 -0700
Message-ID: <xmqqwmis11f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Koji Nakamaru <koji.nakamaru@gree.net>
>
> fsmonitor_classify_path_absolute() expects state->path_gitdir_watch.buf
> has no trailing '/' or '.' For a submodule, fsmonitor_run_daemon() sets
> the value with trailing "/." (as repo_get_git_dir(the_repository) on
> Darwin returns ".") so that fsmonitor_classify_path_absolute() returns
> IS_OUTSIDE_CONE.
>
> In this case, fsevent_callback() doesn't update cookie_list so that
> fsmonitor_publish() does nothing and with_lock__mark_cookies_seen() is
> not invoked.
>
> As with_lock__wait_for_cookie() infinitely waits for state->cookies_cond
> that with_lock__mark_cookies_seen() should unlock, the whole daemon
> hangs.
>
> Remove trailing "/." from state->path_gitdir_watch.buf for submodules
> and add a corresponding test in t7527-builtin-fsmonitor.sh.
>
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Suggested-by: Junio C Hamano <gitster@pobox.com>

In none of the changes described above, I have any input to deserve
such credit, though.

> +start_git_in_background () {
> +	git "$@" &
> +	git_pid=$!
> +	git_pgid=$(ps -o pgid= -p $git_pid)
> +	nr_tries_left=10
> +	while true
> +	do
> +		if test $nr_tries_left -eq 0
> +		then
> +			kill -- -$git_pgid
> +			exit 1
> +		fi
> +		sleep 1
> +		nr_tries_left=$(($nr_tries_left - 1))
> +	done >/dev/null 2>&1 &
> +	watchdog_pid=$!
> +	wait $git_pid
> +}
> +
> +stop_git () {
> +	while kill -0 -- -$git_pgid
> +	do
> +		kill -- -$git_pgid
> +		sleep 1
> +	done
> +}

On the "git" side you use process group because you expect that
"git" would spawn subprocesses and you want to catch all of them,
...

> +stop_watchdog () {
> +	while kill -0 $watchdog_pid
> +	do
> +		kill $watchdog_pid
> +		sleep 1
> +	done
> +}

... but "watchdog" you know is a single process, so you'd only need
a single process id, is that the idea?

What is the motivation behind the change in this iteration to use
process group?  Was it observed that leftover processes hang around
if we killed only the $git_pid, or something?

> +test_expect_success "submodule implicitly starts daemon by pull" '
> +	test_atexit "stop_watchdog" &&
> +	test_when_finished "stop_git && rm -rf cloned super sub" &&

If stop_git ever returns with non-zero status, "rm -rf" will be
skipped, which I am not sure is a good idea.

The whole test_when_finished would fail in such a case, so you would
notice the problem right away, which is a plus, though.

> +	create_super super &&
> +	create_sub sub &&
> +
> +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
> +	git -C super commit -m "add sub" &&
> +	git clone --recurse-submodules super cloned &&
> +
> +	git -C cloned/dir_1/dir_2/sub config core.fsmonitor true &&
> +	set -m &&

I have to wonder how portable (and necessary) this is.

POSIX says it shall be supported if the implementation supports the
User Portability Utilities option.  It also says that it was added
to apply only to the UPE because it applies primarily to interactive
use, not shell script applications.  And our test scripts are of
course not interactive.

Thanks.
