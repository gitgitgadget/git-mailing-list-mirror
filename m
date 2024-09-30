Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58A198E61
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718062; cv=none; b=dENGFMYTbsKhq9NLHpO+fFv7mqD2mbiJ+7TuLC0XWZky0C3NeIFqHaSMMTreUhYD+uD2UG2u6BWybnruYkiF4+S73ZdqO29qIAtrExmqCacDvddJferb+eCtNcoWxzO4D5PYvZ5kQGOCTnXnknVoAWG4Jkn8KfdY/NA8PFkdYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718062; c=relaxed/simple;
	bh=5O8nfJYqVqNGF/gmg+0oMW8OgDQERENkgVR+qRlkMfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWupYVZESPthjN37A1HHH0J4jOwEeryNC7rwpc502u22N+UfoVZV9Mt8mNxr7HOIxNtrFrpw0rk8XxbywX1x4fkRN3j83GGfrcTPPs19OIRbbE9w/rnqPTNTUhm/DjwN4S7T0VaYHUy8wlWAaSq57TYUffapr9CmA05Q3/a9ni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m+d7Vt08; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nVswksiZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m+d7Vt08";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nVswksiZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B4C01140592;
	Mon, 30 Sep 2024 13:40:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 13:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727718059; x=1727804459; bh=fvH5CnkiTV
	1kJ1lbaQF4UZoXgllspnJkdtwD8Rf+8Ls=; b=m+d7Vt08TmugKMnr6L6Lqlea87
	W5uI/3ib4rUfWF+EMCCGHXdX+9Zai3bFZPvKtAR9zlJ5/gdx2F2aGdkkANTy+Red
	02bK8XRNtCMNaCQzYGitOQpU9DAIL4Wc2s50aBmLx79dnC6lkI8AUVNtXhcvoS5I
	mKwzE0gpkwktlvSfq/a21hAEq5i2P8nGrDYVAMFCLsM8e1K/VFjHyR/9Bt8CDdcV
	q6qduN/3tyH9LvIHsAe6MrVcchc68zbX/8VS5Lw1UI2Z+UHBQeXCvkdshDe9LvUs
	eRY/vMal6oVT7TnHYabgyTSZD5blcId7nxm8WJWd4h6lncZHRuP9B1/0MK0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727718059; x=1727804459; bh=fvH5CnkiTV1kJ1lbaQF4UZoXglls
	pnJkdtwD8Rf+8Ls=; b=nVswksiZZ378X8+JjhAsNPVVVbq1R4lv1q5ziFQEJG0h
	pJ8ckWMe/AjKf3Q248iMdph3/D2g9rVnZaojHrItMtBnOohIO3NxeIQfBaam95QF
	skvIsaLdqqdV3LxP+gvK6bxiG8vVmwVJGrSEO4rRuMZk5gopGfKhNldTp3lrxAf2
	0Gj5DAzGhfBKOjMKkupPpT/s9S3xxlFNLstl5uDKZIzB9fkA+Iort2nTLkKYpG3k
	WXPU8ta2YYeUhRdyaOo/NH0/oiwv9xJVq/mac2SwwUQtX3qIy3waaOi8uYoDk2D7
	PxXeMECdIOr7749TMrwS4MFDslG8S1wSu7Y4uB97YQ==
X-ME-Sender: <xms:quL6ZgZANVAwFe4rVpSrUX-iFfYhZn3M7TDfRC7zNDSR8azk43t5fA>
    <xme:quL6ZrbCr393FgKQwT0A5cz1TDDvWpvDssofBdBSWD4eXFSkQJEol-KPf0sOYZPIL
    g4Dk6Qs4MvDCwCz0g>
X-ME-Received: <xmr:quL6Zq_D7ZHhcYGgUffM2-Kb1GlyNO6zSfqKr9ltWRF_lviupfF3XlNVhEyeeNuN_gleOH3DZpu1rWZ0RhxAQ0ATdIPD45e6oZLivnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:quL6Zqr3Qix0x7jOxYgLuaMoVPlvx8kQnrdRLCfdYVxoMVN9nBw-wA>
    <xmx:quL6ZrrzAfzu9cRiwIPJ6NV8fT7k8H909hRFu4jKQKOOE-b6RS6muA>
    <xmx:quL6ZoR-LIqQ-vA5r21K8UmvLrgBzFNXVEOZ54GZbfA-I3iQsM48RQ>
    <xmx:quL6ZroH6lpYMXreLlTQnQN21PBIbQsg4HjHj5lrW0UsiVaHANjX1Q>
    <xmx:q-L6ZskTywvFSnuELWUhUZfyDHWUVt_v2FAVP57i8kbOQIoTLPX_GOpO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 13:40:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] fsmonitor OSX: fix hangs for submodules
In-Reply-To: <pull.1802.git.1727577690390.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Sun, 29 Sep 2024 02:41:30
	+0000")
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 10:40:56 -0700
Message-ID: <xmqqcykl82fr.fsf@gitster.g>
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

The above very nicely describes the cause, the mechansim that leads
to the end-user observable effect, and the (bad) effect the bug has.

I wish everybody wrote their proposed commit messages like this ;-)

> Remove trailing "/." from state->path_gitdir_watch.buf for submodules
> and add a corresponding test in t7527-builtin-fsmonitor.sh.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
> ---
>     fsmonitor/darwin: fix hangs for submodules

> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 730f3c7f810..7acd074a97f 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -82,6 +82,28 @@ have_t2_data_event () {
>  	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
>  }
>  
> +start_git_in_background () {
> +	git "$@" &
> +	git_pid=$!
> +	nr_tries_left=10
> +	while true
> +	do
> +		if test $nr_tries_left -eq 0
> +		then
> +			kill $git_pid
> +			exit 1
> +		fi
> +		sleep 1
> +		nr_tries_left=$(($nr_tries_left - 1))
> +	done > /dev/null 2>&1 &

So, the command is allowed to run for 10 seconds and then a signal
is sent to the process (by the way, we do not write the SP between
">" and "/dev/null").

> +	watchdog_pid=$!
> +	wait $git_pid

And the process to ensure the command gets killed in 10 seconds is
called the "watchdog".  We let the command run for completion (and
we'd be happy if it did without watchdog needing to forcibly kill
it).

Which means that even after the test finishes normally (e.g., the
command completes without getting killed by the watchdog, because it
is on a fast box and finishes in 0.5 second), we have leftover
watchdog process hanging around for 10 seconds, which might interfere
with the removal of the $TRASH_DIRECTORY at the end of the test.

There is a helper function to kill both (below), which probably is
used to avoid it.  Let's keep reading.

> +}
> +
> +stop_git_and_watchdog () {
> +	kill $git_pid $watchdog_pid
> +}

This sends a signal and let the process die.  Without waiting to
make sure they indeed died, at which point we can safely remove the
$TRASH_DIRECTORY on filesystems that refuse to remove a directory
when a process still has it as its current working directory.

Shouldn't it loop, like

	for pid in $git_pid $watchdog_pid
	do
                until kill -0 $pid
                do
                        kill $pid
                done
	done

or something?  Or is there a mechanism already to ensure that we
return after they get killed that I am failing to find?

>  test_expect_success 'explicit daemon start and stop' '
>  	test_when_finished "stop_daemon_delete_repo test_explicit" &&
>  
> @@ -907,6 +929,23 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
>  	test_subcommand git fsmonitor--daemon start <super-sub.trace
>  '
>  
> +test_expect_success "submodule implicitly starts daemon by pull" '
> +	test_atexit "stop_git_and_watchdog" &&

Hmph, this is _atexit and not _when_finished because...?

> +	test_when_finished "rm -rf cloned; \
> +			    rm -rf super; \
> +			    rm -rf sub" &&

Makes me wonder why it is not written like so:

	test_when_finished "rm -rf cloned super sub" &&

which is short enough to still fit on a line.  Is there something I
am missing that these directories must be removed separately and in
this order?

> +	create_super super &&
> +	create_sub sub &&
> +
> +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
> +	git -C super commit -m "add sub" &&
> +	git clone --recurse-submodules super cloned &&
> +
> +	git -C cloned/dir_1/dir_2/sub config core.fsmonitor true &&
> +	start_git_in_background -C cloned pull --recurse-submodules
> +'

Other than that, very nicely done.

Thanks.

>  # On a case-insensitive file system, confirm that the daemon
>  # notices when the .git directory is moved/renamed/deleted
>  # regardless of how it is spelled in the FS event.
>
> base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
