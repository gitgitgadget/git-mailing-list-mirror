Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126431280D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576989; cv=none; b=VZKeWN64FFOCInLNsDXumUlICVdM+KDJSR9e4T45Tobro6eHj/6oiZrryj3Hl1yv7+pjqO7QSiPCoxuY2BdnfNda6Oj8rTPTkiUIPK9v5fAssGYROExrBasMBK82DrXLh0TDcpSsHExTIfVDRuByb1IbPWpJu/24/CsyY4Z4KaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576989; c=relaxed/simple;
	bh=G/ubSEWGI6nzRRQaN3WB6kU8+5vfDduVQV949b9OqZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KYKhESkCS6MgaSHWJQC9FaxjwfRxkDKPRaM8kjZ39aK9WOlTHlmnHQUbISYhsNpRkNV+pXrfbjXSSjgQzjynsBsRz1eulaKhah1wveaU6zkSnbQrYpJ20QB9Wmx8EXUDlFet38NzZ8akjNG1QnQgVeimwEpPxgzZb/ZcCyMbx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RhO8OSkR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BbWoiETN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RhO8OSkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbWoiETN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A6227EC0693;
	Wed, 19 Nov 2025 13:29:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 13:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763576980; x=1763663380; bh=OH+EEH1n9/
	PNUwfbupkuAY0H2l0RXb1Te8mxZB0uWYQ=; b=RhO8OSkRToECYEXTH4drpuNabd
	k/L3qcEf1uzMAPtbqTTNZTGZYjxXwvJFud4t0Uw7Gae/R/ooF6C6AxpBrb3K2KyL
	/wEH44ZSPO5RSyhdDRZSlQxgdicd12GSERS7s9BCgc2bcMMoOtDWPgVc+WrgxjVb
	AoGsf1rA7j8oEYMSZMWqmCv9NGGq3XQ35Tmaho1WIQzjOhY+qSHNk78TSBJ5vPvr
	P5cwMIhbhPjkn/7mxDw4x4btLGft8EjorEEGYZyDGe/oGpnrBfa6rzObcRlmzq1W
	kIA9Bi9VNznw2OVTslssHOS5ugmUiSGgZCh6lKtQ1P4NxfJ8EHFasfg3Su5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763576980; x=1763663380; bh=OH+EEH1n9/PNUwfbupkuAY0H2l0RXb1Te8m
	xZB0uWYQ=; b=BbWoiETNcKO/5X412yy7ooErQtU61QRHce3Rh0W+SAjAqteLhKU
	YkzV/m893SRi8LJofUYwePtvALpvk22TAYcsAUJXGfJ9EcFp/GK+uHcANeQRLyT5
	Gf7mU0yA8mbGNFnyn+8bxSJu5jDD0YJJOLXUFmsSBtp0emgJXWrd9bc2lXBp4wCY
	ePX+Ziq1y5b5V4VTkx+Pt5gIxVZIwjovm/FLISr9AxGhWbNsDcgWvjUwkyTJ+Pns
	Gpml0ieDVz7zdNg3Mw0sD+7Bj+18WOgJPT0TSreTDqFYPB61Z3S/ADLD9Zracj7M
	9FDMXl7JHlHbsPTH8Jpuax/dHdLB9Js9pHw==
X-ME-Sender: <xms:lAweaYQQrs9BCZUcGpurJF0_KojOk6vREm1_J06TGUjKJXMDcPrVAQ>
    <xme:lAweafy9jPYFUI-4iM1X2UAvRQEG56jwih24Pi4QUZHgFqzPsClIU3Ep-JYrbBeDq
    Ncda4iAjcVdYLmbUAAykL90K6OjOi-zqpvfMQAJcodciqCKlbByQhw>
X-ME-Received: <xmr:lAweacfaK0GRMKRJ5keQDXLjsBKi_vJQqBKwoWGO-0kQG0RCczRYUAN1QrZ8DrfWJEhfLf-mXgsAOxetbttqWfOBtjOSaaiocrAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peguvghlihhlrghhfihusehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopeguvghlihhlrghhfihusehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lAweaaPuZkhFpECFvo9JAmn_Hs2LPNMXY8VfDbf-U0sTbNZoxjZW5Q>
    <xmx:lAweaftdQSndxNbmRdI38xVNqYcfDVoqqITGO_ftVbhM43wRizhXoQ>
    <xmx:lAweaTBmXMsQ-8mjPQ5m-g2aa4C0_mQeIONr-qWHSQ_0CKQXASimAA>
    <xmx:lAweaWZ3hPU9wfEwwmxc68KR3XiEoX3Co5iW2UHTNZboBcOKxkDWiQ>
    <xmx:lAweaevig_BS45HnEo281L8GErSXRcvqELw9Ntd-kTt8BkDI8d1Yww-m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 13:29:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Delilah Ashley Wu <delilahwu@microsoft.com>,
  Derrick Stolee <stolee@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Delilah
 Ashley Wu <delilahwu@linux.microsoft.com>
Subject: Re: [PATCH/RFC 2/4] config: test home and xdg files in `list --global`
In-Reply-To: <d2167a81d31defddbcdda06726b004e44a192f8d.1760058849.git.gitgitgadget@gmail.com>
	(Delilah Ashley Wu via GitGitGadget's message of "Fri, 10 Oct 2025
	01:14:07 +0000")
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
	<d2167a81d31defddbcdda06726b004e44a192f8d.1760058849.git.gitgitgadget@gmail.com>
Date: Wed, 19 Nov 2025 10:29:38 -0800
Message-ID: <xmqqsee9c1v1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Delilah Ashley Wu <delilahwu@microsoft.com>
>
> The `git config list --global` output includes `$HOME/.gitconfig` (home
> config), but ignores `$XDG_CONFIG_HOME/git/config` (XDG config). It
> should include both files.

Please be gentle to future readers of "git log" and help them with a
bit more explanation on the "should" here.  E.g., 

    should include both files, to be consistent with the output from
    `git config list` (not limited to `--global`) that lists entries
    from both files (in addition to system-wide and repository-specific
    entries, of course).

or something.

> Modify tests to check the following and expect a failure:
>   - `git config list --global` should include contents from both the
>      home and XDG config locations (assuming they are readable), not
>      just the former.
>
>   - `--show-origin` should print correct paths to both config files,
>     assuming they exist.

Testing these two combinations is a good thing, but "expect a
failure"?  There doesn't seem to be any test that is marked as
"test_expect_failure" in this patch.  Confused?

    Side note: we generally do not want test_expect_failure tests in
    one patch, followed by a code fix with changes to tests that
    flip s/test_expect_failure/test_expect_success/' in another
    patch, though.  The reason is primarily that such a two-patch
    series makes it harder to review the step that has the fix, by
    hiding the body of the test whose earlier failure gets fixed by
    the code change.

> Also, add tests to ensure subsequent patches do not introduce
> regressions to `git config list`. Specifically, check that:
>   - The home config should take precedence over the XDG config.
>
>   - Without `--global`, it should not bail on unreadable/non-existent
>     global config files.
>
>   - With `--global`, it should bail when both `$HOME/.gitconfig` and
>     `$XDG_CONFIG_HOME/git/config` are unreadable. It should not bail if
>     at least one of them is readable.

Good.

> The next patch, config: read global scope via config_sequence, will
> implement a fix to include both config files when `--global` is
> specified.
>
> Reported-by: Jade Lovelace <lists@jade.fyi>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1300-config.sh    | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  t/t1306-xdg-files.sh |  5 ++--
>  2 files changed, 68 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index f856821839..5fa0111bd9 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2367,6 +2367,71 @@ test_expect_success '--show-scope with --default' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'list with nonexistent global config' '
> +	rm -rf "$HOME"/.gitconfig "$HOME"/.config/git/config &&
> +	git config ${mode_prefix}list --show-scope
> +'

Do we expect an empty output, or are we happy as long as "git
config" does not segfault, even if it spews anything?  I guess that
at this late point in the test we have per-repository or system-wide
configuration files with something in them to test, so there would
be some output but we do not care?  If that is the case, not
checking the output, like this patch does, is the right thing.

> +test_expect_success 'list --global with nonexistent global config' '
> +	rm -rf "$HOME"/.gitconfig "$HOME"/.config/git/config &&
> +	test_must_fail git config ${mode_prefix}list --global --show-scope
> +'

OK.  Do we require --show-scope to fail this, or do we fail with and
without --show-scope as long as --global is in effect?  If the latter,
test both ...

	rm -f "$HOME/.gitconfig" "$HOME/.config/git/config" &&
	test_must_fail git config ${mode_prefix}list --global &&
	test_must_fail git config ${mode_prefix}list --global --show-scope

... like this, perhaps?  Also, don't overuse '-r' with 'rm' (applies
other tests in this patch) when you know what you are removing
should not be a directory.

> +test_expect_success 'list --global with only home' '
> +	rm -rf "$HOME"/.config/git/config &&

Lose "r" from "-rf" or lose "/config".

> +	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
> +	cat >"$HOME"/.gitconfig <<-EOF &&
> +	[home]
> +		config = true
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	global	home.config=true
> +	EOF
> +	git config ${mode_prefix}list --global --show-scope >output &&
> +	test_cmp expect output
> +'

OK.

> +test_expect_success 'list --global with only xdg' '
> +	rm -f "$HOME"/.gitconfig &&
> +
> +	test_when_finished rm -rf \"\$HOME\"/.config/git &&
> +	mkdir -p "$HOME"/.config/git &&
> +	cat >"$HOME"/.config/git/config <<-EOF &&
> +	[xdg]
> +		config = true
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	global	xdg.config=true
> +	EOF
> +	git config ${mode_prefix}list --global --show-scope >output &&
> +	test_cmp expect output
> +'

OK.

> +test_expect_success 'list --global with both home and xdg' '
> +	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
> +	cat >"$HOME"/.gitconfig <<-EOF &&
> +	[home]
> +		config = true
> +	EOF
> +
> +	test_when_finished rm -rf \"\$HOME\"/.config/git &&
> +	mkdir -p "$HOME"/.config/git &&
> +	cat >"$HOME"/.config/git/config <<-EOF &&
> +	[xdg]
> +		config = true
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	global	file:$HOME/.config/git/config	xdg.config=true
> +	global	file:$HOME/.gitconfig	home.config=true
> +	EOF
> +	git config ${mode_prefix}list --global --show-scope --show-origin >output &&
> +	! test_cmp expect output
> +'

Do not write a test this way.  If you want to document an existing
and unfixed breakage, instead of saying "we do want to see what is
in this expect file, but we know output does not unfortunately match
it", which is how the above test expresses it, start the whole thing
with "test_expect_failure" (instead of "test_expect_success"), and
have the body of the test express what you really want to see.  I.e.
the last steps should say

	git config ${mode_prefix}list --global --show-scope --show-origin >actual &&
	test_cmp expect actual

But an earier side note applies.  If "git config list --global" gets
corrected, this test will see update to turn "! test_cmp" into
"test_cmp" (or "test_expect_success" to "test_expect_failure"), and
such a patch that comes with the code fix will not show what is
being tested and forcing the reviewer to go back to the previous
step to see what the change is really about.  A test that
demonstrates and protects the behaviour corrected by the code change
is best added in the same patch as the code change.

> diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
> index 40d3c42618..0318755799 100755
> --- a/t/t1306-xdg-files.sh
> +++ b/t/t1306-xdg-files.sh
> @@ -68,9 +68,10 @@ test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists'
>  	>.gitconfig &&
>  	echo "[user]" >.gitconfig &&
>  	echo "	name = read_gitconfig" >>.gitconfig &&
> -	echo user.name=read_gitconfig >expected &&
> +	echo user.name=read_config >expected &&
> +	echo user.name=read_gitconfig >>expected &&
>  	git config --global --list >actual &&
> -	test_cmp expected actual
> +	! test_cmp expected actual
>  '

I cannot quite tell from only half the test, but I suspect that this
shares exactly the same problem with the last one in the other file
I commented above?

Thanks.
