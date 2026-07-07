Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE939A06D
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454135; cv=none; b=Xy2wDa/1v8UKgf+n78iDECAVlMeAPGKqB+7+EKcMVJK76WYKwY7LlqainjdI+7K/HvW/z5qtW+8BrSjkTJJlaXoXLJcIydZnt4E4CKv47MchnLgESGItRX76lJsrxbotDqOacEYlnlNi9A+F5kwo9eOIHUHkEHjDJZU+51PIv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454135; c=relaxed/simple;
	bh=q9igEN8BOt1LP2rsfYA4gb0/PMgkhgHByUrLTHfjut8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJy6pYbRTmybPXRegvtlohO4rjuz5LPsozvgt2qx61amBVpq+muAiueEHmSyzHInUz/aNJpldrtNzIqZGMQihSoRf4lBYpWtp2YhKLB0O72/sUglRH4E8xbSQxw58a9BalBX0bys232qh3IClLcWdBCjsQ3SPB8/KjM+jl9nBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FvCWJmN+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxUzWdlo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FvCWJmN+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxUzWdlo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0764E140005A;
	Tue,  7 Jul 2026 15:55:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 15:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783454133; x=1783540533; bh=+LXQxPXiGy
	O/Uh208ex5ZEyggJoqBeqJ9pJsggB3Ojs=; b=FvCWJmN+0yEuPZCRchrY4gSLh6
	jk16Pvt8J8md/qKTmd8y2i3Oqfib4piQzSMuQ0hd3rdqNy1MSMLSc+HBRw8qWzkb
	7JiYCOpAFWFoEafAJ98tZ66ihlorpJRZwLVYugaWJQKpeZ2YtcY3D6NUo3NXLcPP
	W/09duQN6ZW5JusnUAlPXZq5MJllPJ/GHoI9+Kv8ZZQLkZFwOsKNC+k/JgQCPIGy
	2aFUbTYMYxKO8fGn3JJhOKSh43E14VSWB8rvKdD6xXcHxcjTORTYFjddKE+TX2Jl
	25o0KJ5q26n1FqnRD3HeVor76WTX8aQ37Z/76NYvpF/KeFKs8CnmG3rHalqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783454133; x=1783540533; bh=+LXQxPXiGyO/Uh208ex5ZEyggJoqBeqJ9pJ
	sggB3Ojs=; b=bxUzWdlonDkj9fW+MZImnSvC28erDF9GZ0MywbXnvfID1ov/p8H
	d6GVsP0RN4zb2f2eZvmDnf3aYZlhVLSf74Pfha8931NzhoCFmMuvid7GtMITW89h
	BG/Fdex8R20622xptx7MVU39rSHMUWXH2/bOH2NCpYWuTtl9d7TWP5peIcTm1GXZ
	If9xChvTzDDQ5GXfa+PvEubB8o0+j9hBluBpvUR8Cdc5PdHeKd8PFA5v44iG7hjf
	Yt4p2hzbTfp3a6FCzmjCO2ET+qLiFEaIJNhDa6/bHba6/A+L6Esh5ngj3Hd50P0K
	/9MP9UaHXfOHenqBiyylWRaG2evSCXYcMjw==
X-ME-Sender: <xms:tFlNaolktzXxGijkCSI0RS-CM7wIIWA6W3p-5m-6pINbfOePMerk_Q>
    <xme:tFlNavTbhtET004qDa9D8tEczHuU2-fFfWpk5rRd3Yna1aZl5d_zde4hotGid5_i-
    1zRHCWI4jNWoZUHeiwdr5NS2caGNWlrbAlIUfIt9eL-_fgpLC6E>
X-ME-Received: <xmr:tFlNakDndvHIKOUxyGaRZ0nh8FRqovMLbnIt8swWvJAHMqmF8p6msck7aOq8ZljyxCQ8MMTRxp6GCghQcg5WucxI_YEgwTR2_kVLR_w>
X-ME-Proxy-Cause: dmFkZTGEpX+qb0tc3eza1XFug6Jled+o93xXq5tqxdVmjZt/eM2JqJEjbfqDAWK+U92qmF
    OZzxp5VDcs+OFGondwo/aZqZoMzWjIQyBv1iMZGOsESFvJc99QVxslhXAf/72j/hebdvWy
    JtsNjIHxWOZbCMvXkRLMmBeVm3ffZ3NwWSkIb/J8Px4A6LI7tOkczsniNydd+8zsVTxTwf
    Zh+ts8eXnhKYhxOe46Olf7O4v5MhNxEL85DKH8JXbLmnGNDVWdug8sFvX548rGxK/uufpI
    AxQzAw5lxoxT4yFrgRGVAaSxJmhcBGWoPB/56j3Qt2fExx2cJx0+o96HTD8bVLyaSwCBJf
    gUJ51FAyIWc8j+llWYwMeMg444Tmu/z5P3WEUJzskPEZ8ydTUDZpbTs3C/ALsEuyMoLIc0
    HpWuMY4CruaEcUAcsnCL5SMJYHms/c7mWdYWYM75xBzk9WV/XfCK8ID2yIZ1Mbo0WcX74A
    Ly80rxAsEWhun24M7SKZE2Vvc4TvD39eCgALuc82lbhFoRoAkpXrDbKYz0iLmBBecOUpGd
    AjTc6CJ+AiWUA/uX6scf46PBJqPnRAnAqmijiPt58bfO8z2SGSCGcd0ZMkKJtvVC7vnom3
    7VIYmgHHGXcMJhaTI02HwCTS/7jiu/J+EU2uvbMXF9ccKd/IU5SU+vR8+P5w
X-ME-Proxy: <xmx:tFlNauR5LjsKoYj6Ri9qogk5Fer7XCZ1J7IVb4l_mRF3rBHpmQCyIA>
    <xmx:tFlNaqo53nSsXrEjtintRyQHyZFgj33I2dCD6rL3AD2C3mMq3JL5uQ>
    <xmx:tFlNaozKtgkztmttipOyBbGO1K8pf5WeLdMawQzShnDccIc1zVj9Ig>
    <xmx:tFlNanIPsevf-B87NnD_oOCnL3FQklNQUh7IEZWzom4x8QKkckJCAw>
    <xmx:tVlNavZTQ-vxiOfNRLcUxnPf1yWIsmYWqYtmyVdkDo5NEM2d0AcEBWI0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 15:55:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] odb: run "pre-auto-gc" hook for all maintenance
 tasks
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-1-aae607667be4@pks.im> (Patrick
	Steinhardt's message of "Tue, 07 Jul 2026 17:32:33 +0200")
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
	<20260707-b4-pks-odb-optimize-v1-1-aae607667be4@pks.im>
Date: Tue, 07 Jul 2026 12:55:31 -0700
Message-ID: <xmqqo6gi1sng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While the former makes sense, the latter is somewhat off. While the hook
> is indeed strongly tied to gc'ing a repository, the original intent of
> the hook is rather to inhibit any kind of automated garbage collection.
> That noticeably also includes all the other maintenance tasks that our
> new infrastructure may run, but those aren't getting intercepted at all.

If we want to halt object collection right now for some reason, it
is likely that for the same reason we may want automated pruning of
old reflog entries, for example.  So I can buy the above reasoning.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d7f82e1bec..1212b306b6 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -740,6 +740,127 @@ test_expect_success 'geometric repacking honors configured split factor' '
>  	)
>  '
>  
> +test_expect_success 'pre-auto-gc hook runs exactly once' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		write_script .git/hooks/pre-auto-gc <<-\EOF &&
> +		echo hook >>hook.log
> +		EOF
> +
> +		# Satisfy the auto condition for multiple tasks, both in the
> +		# foreground and in the background phase.
> +		git config set maintenance.reflog-expire.auto -1 &&
> +		git config set maintenance.geometric-repack.auto -1 &&
> +		git config set maintenance.rerere-gc.auto -1 &&
> +
> +		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> +			git maintenance run --auto 2>/dev/null &&
> +
> +		# The successful hook does not inhibit any of the tasks...
> +		test_subcommand git reflog expire --all <trace2.txt &&
> +		test_subcommand_flex git repack <trace2.txt &&
> +		test_subcommand git rerere gc <trace2.txt &&
> +		# ... but it must only have been executed a single time.
> +		test_line_count = 1 hook.log
> +	)
> +'

Somehow I'd feel better if the hook used a full path to the append
only log file, but it is reasonably clear that these three commands
are unlikely to chdir around, so it may be OK.

Obviously not in scope of this topic, but I wonder if we have a
better way to test these three "housekeeping tasks" have run, than
casting in stone the current implementation that spawns these three
external command as subprocesses.

