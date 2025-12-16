Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E623B609
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910551; cv=none; b=COX7GMYKUhVRHX63MsWj3XMz5frQObq+w99SWD6itoiDR5rRUsdRpaI2+S49/nvscQVl1kDZaeuV40HcuKXpuP4LiIGyr+Wm71rJaFmjTpZvqxmprvjtFPVzhK0ICFwnJcUT90viDCgXnuuuDZjgKt/KXZb+ov9JL+FukNOPsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910551; c=relaxed/simple;
	bh=tiFx8q6X5LsqmITmeXWo+u7tZXTxFNPGDQ2j6E4/sqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRyStd1GRr4gkEf6hElU45dr+yjnARekTKGHeGdOIndLK+KwmFnY+RqesWI9m3uKgTt94oAqYhgeReteQ7CnwXSIiAbWF0Xgml/IgAsbDk0ouBvZCBkbl+v/sH+On0PjdHEW7o8yVHTEC/HG3LZHWcoLfT6qrZL+A4Ha1wCZLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KevI1tVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P87AK1gq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KevI1tVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P87AK1gq"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2ED0140009C;
	Tue, 16 Dec 2025 13:42:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 16 Dec 2025 13:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765910548; x=1765996948; bh=k2LN3svKLY
	sPrdHWnV6yJCW76ItOrwPzvVlggs94vYI=; b=KevI1tVt5SX60LWvpWidvth5un
	Wf8SQtYkY047gT/k9YRAIqZ4Q67xd+2LgRZx+xVlRSB1tjt+5RqPuSGwBbfwrIKw
	M5C36F4YO0niXUxzI0kFJuFMeZnZc8JDuS2oImhS0J1Zoeh8FNoi94SiYcWJ4dMF
	6yVxgogbUh14jdpu/DSNB5ALONaRtB5RuyLiebNoq+MFyx8nUpXLCpFsm8NNIZGn
	KvZPXXCXvm79gjXN+8bx9hcz4qq2HBdHAi1l6SkndRtmqhUOoxiRmjKGthC/Ju07
	uZvUT+jyKsydG0r2D7o1+po+8m8S1TWxFKfBKPXW2jlPm9NS01M95xxSnbTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765910548; x=1765996948; bh=k2LN3svKLYsPrdHWnV6yJCW76ItOrwPzvVl
	ggs94vYI=; b=P87AK1gqD9fhsJObVnPIiC9CkJTedjTYLpKg6aMOpt9UOJUsJ7p
	z3t63ZLqbAGB8hWrtvG/l1BXhSHJydtvxSnjPP0R0mLYZRw2NVBPurKMXPkyXGWu
	bev1Q1BVHfaILV3QwOT2xgo9KY3RKcagPTUXLPdfXKhqGmwFgWvPmb4IfTVMMtVD
	Kv44CbVeK+0FspS1t7ngOv8EvupXqsnH7Dw3W+jEMU7X8G3kRgSwOEElK4KuC6lL
	j2Fq0eJWfoqnklRdt1ynu5fCQjePllFh1z7iZUW81dtK6b9p9EptKC/WpzVpJHYF
	VAVFcWm1vkPgakkasgm97Bl0lVJZE0ZrAfQ==
X-ME-Sender: <xms:FKhBafB2TgjCh0bCtdjLcQXmttPO2MmYJLvpgNgmRvv6mVxAEToObQ>
    <xme:FKhBaZOF9cTinP7xdRwmPFJulf42VNeRFzVtpcVih5h0fvJyuMcDQCrMboEglENff
    h6530q1IcGW0zuN_GZ_6V61kH-XdxLLZn7Lnk5jDRxoNI-SaRaD4g>
X-ME-Received: <xmr:FKhBaUZM01hzg6iygHApHpD3eS1edLyGc49eM-iwggpGbM1hrC_BKepwUFG7hfSti95k3tEfrQI9uYXoc6WoAxlhMCYA9gUuLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieettdehleehvddujeegfeegvedujeegtdfghefflefhgedtueejvdduuefg
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhophgvnhhgrhhouhhprdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FKhBaYvN85DcRQVICHooMlVrhzk17G84-golM6n3XsRCyeRgGkpK-g>
    <xmx:FKhBaWM1Ey8FP0H8gVW02lyZ4OvTqZf2iXrNWg7xvPuuandHPty8OA>
    <xmx:FKhBaf7LmO1zLmkq7gbWR0KZkJfhnDfsGNJ1TDCOXK8cscEWXDfQHg>
    <xmx:FKhBacSFhdEkuPdu6vHZgWQvJE-6Mhkybz8WanX_juqb5ieW30yMTg>
    <xmx:FKhBaQVqsPFXDIbq42-7DH-hkq2ILb0CKEQs1dC5GAMQH4qX2TDV4kEF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 13:42:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/10] Prepare Git's test suite for symbolic link
 support on Windows
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 16 Dec 2025 11:46:07
	+0000")
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 03:42:26 +0900
Message-ID: <xmqq345a46b1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> It has been a minute or three since the time when Windows versions without
> symbolic link support were common, therefore there are plans to turn on that
> support in the MSYS2 runtime on these Windows versions by default, see
> https://github.com/msys2/msys2-runtime/pull/114 for more details about this.
>
> To prepare for this, I am working toward upstreaming Git for Windows' own
> support for symbolic links. And to prepare for that, in turn, I am hereby
> contributing preemptively the fixes required to eventually let Git's test
> suite pass when both MSYS2 runtime and Git support symbolic links.
>
> As a bonus, this patch series also contains fixes for the Perl tests (which
> were broken for a few years, unnoticed because the CI runs need to save on
> runtime and therefore skip the Perl tests because the consume a lot of
> time).

Great to hear a good news.

> Changes since v2:
>
>  * Polished commit messages.
>  * 
>
> Changes since v1:
> ...

Curious what the second bullet point was ;-)

The step [6/10] somehow did not make the list.  I can reconstruct it
by looking at the range-diff below (i.e., no content changes, just
removal of bunch of lines from the proposed log message and credit
for Patrick), but it briefly made me wonder if steps 6-10 from
posted version left your repository a bit prematurely and they
wanted to have a bit more work on them, to be described on the empty
bullet point (*) line above.

In any case, thanks for updates.  I didn't see anything wrong in
what was shown in the range diff for [01-05/10].  Will replace what
has been queued.

> Range-diff vs v2:
>
>   1:  2d329837e3 =  1:  2d329837e3 t9700: accommodate for Windows paths
>   2:  b97afa9a5c =  2:  b97afa9a5c apply: symbolic links lack a "trustable executable bit"
>   3:  96e279f50e !  3:  f42a2f14bc mingw: special-case `open(symlink, O_CREAT | O_EXCL)`
>      @@ Commit message
>           non-existent file and create it when given above-mentioned flags.
>       
>           Git expects the `open()` call to fail, though. So let's add yet another
>      -    work-around to pretend that Windows behaves like Linux.
>      +    work-around to pretend that Windows behaves according to POSIX, see:
>      +    https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html#:~:text=If%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%20is%20undefined.
>       
>           This is required to let t4115.8(--reject removes .rej symlink if it
>           exists) pass on Windows when enabling the MSYS2 runtime's symbolic link
>   4:  9639e04ac6 =  4:  70237394c6 t0001: handle `diff --no-index` gracefully
>   5:  3db0599d91 !  5:  0d371ee552 t0301: another fix for Windows compatibility
>      @@ Commit message
>       
>           Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
>           2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
>      -    suite because that would fail on Windows (because Windows has a much
>      -    more powerful permission system that cannot be mapped into the simpler
>      -    user/group/other read/write/execute model).
>      +    suite because that would fail on Windows.
>       
>           There was one forgotten instance of this which was hidden by a `SYMLINK`
>           prerequisite. Currently, this prevents this test case from being
>   6:  f2da7d4d50 !  6:  91bd72062c t0600: fix incomplete prerequisite for a test case
>      @@ Commit message
>           However, the `preferSymlinkRefs` feature is not supported on Windows,
>           therefore this test case needs the `MINGW` prerequisite, too.
>       
>      -    There's a couple more cases where we set this config key:
>      -
>      -      - In a subsequent test in t0600, but there we explicitly set it to
>      -        "false". So this would naturally be supported by Windows.
>      -
>      -      - In t7201 we set the value to `yes`, but we never verify that the
>      -        written reference is a symbolic link in the first place. I guess
>      -        that we could rather remove setting the configuration value here, as
>      -        we are about to deprecate support for symrefs via symbolic links in
>      -        the first place. But that's certainly outside of the scope of this
>      -        patch.
>      -
>      -      - In t9903 we do the same, but likewise, we don't check whether the
>      -        written file is a symbolic link.
>      -
>      -    Therefore this seems to be the only instance where the tests actually
>      -    need to be adapted.
>      -
>      -    Helped-by: Patrick Steinhardt <ps@pks.im>
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>        ## t/t0600-reffiles-backend.sh ##
>   7:  ea74e678f9 =  7:  c2d3212f11 t1006: accommodate for symlink support in MSYS2
>   8:  1619ea4a3b =  8:  03ff6d756d t1305: skip symlink tests that do not apply to Windows
>   9:  807bb679cd =  9:  4ab6aaf2cf t6423: introduce Windows-specific handling for symlinking to /dev/null
>  10:  945306b5d4 = 10:  5f056902df t7800: work around the MSYS path conversion on Windows
