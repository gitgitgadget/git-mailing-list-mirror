Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAF42982C
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033816; cv=none; b=e6pUMvZphvCCW2act86PXF5o24iq2i3y61u7FSy2+is/bwvVhttDtdR+9zuwAB3Ji5VZzcODyoNY4+A3B4cG3cPIWDqo+3dLvsYAXbHYYoz72kMv34LHez8fWhKw34kZ6bZJWqikqeW5WYUs6TQjKDY5SbsQtuOzwVzLwy/EWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033816; c=relaxed/simple;
	bh=xiXQcPQ2S3xw7PNSQ/J08pR4/+67TDcePyKShjxdwG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2cv9KsesRJ3hjhiHixhUebPTJmwD3NlqvlODAEfqdMIjaLyI6Dr5hx3Fex50MNkCeDpCkbJeRhe3BST3WgTjARTsXEFwDwjHusiwfeuw998Qgi43osh5GGOuxuVyXZ/JKFRcipl46dD0QJO89GlLU+nia/N5xNWy4H19v1qK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q2UId/I5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfednrOr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q2UId/I5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfednrOr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F36861D00094;
	Wed, 21 Jan 2026 17:16:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 17:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769033813; x=1769120213; bh=OlBF/SHD0A
	1HKo6XwJS0sqMWh5TpdSreCkQ7TarhzXM=; b=q2UId/I5O6nH5UDB67R0JbIAdL
	SuhurRYEjLL700Oi+mD5rN38hJZ5dEvNunwIbCZsSO8EULDXmEjGez88WVrrdoMY
	3V0gPOvHepjZcpWBrri3z7m0bczoZS16/4/aehPILeO/oE+LDlqZTrW5i51tVWAe
	Z53aT9T38u8pfzCSg7pnvnpev0EYAPjIonDJdrlgn4hj2cgAt3QyOTgVr+GlVjaf
	8TXR4REwLUKfWpgXUSARp9VFkWcOPP9wdktqiz2QvuasebPvpMnOfPG5DMpydp3e
	IYhwp4jS7PcUsbnMPpdN+ctYkelLXqh0Y0lHPZxp1ILbJzimUaMfJpEdSDig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769033813; x=1769120213; bh=OlBF/SHD0A1HKo6XwJS0sqMWh5TpdSreCkQ
	7TarhzXM=; b=NfednrOr5WuQrHRjg74WBiwMLApYZuNmV8N8ODj2O3dk4wABjVL
	NPfi1jrryUyurP39ZmIwZvKFLmCZZXseoKMK8Yknhq6jKdXiTggiRF6yf069M8G0
	rq/tm2W9eRowTIb4E1jyvDbYQZci5G0lkrsgDpNqGZqLdfnqQCHraI/o9O4jG6Ze
	hqH6K90dbUx10i3quZ7/Baq5f8jL36RGnQei4FUHE3xSo4Rk3HhswC06vU4R96r5
	M34FJfmslAKthoymkZ3/4J1FDb/Xsqj8OjQTn9kGt+gJMYxnwO+vHUFNtRk8tWxP
	l1y2hpnebHNbs28xcoTzgNu0TfsHMVZk2og==
X-ME-Sender: <xms:VVBxafP5-apDNmQUZhjIk8sF0SH9Q7wOKlZJqTJv0qpD2kk3cu70Ag>
    <xme:VVBxaZC5bBe0TefPHeL7zIIt46RNvRF5H3q52a0kEqn8lIftaxMj0hDLyI_uaSkNK
    Yilxg_rKdBcCqDYAGtDDNSRpvMbiyqH3qT72eEIRJtXAtBJBcZV9A>
X-ME-Received: <xmr:VVBxaUcgTyyw996HLt6tCodDgDHKcEt0FkilZu4D2unxsII3-Jy7rJwqitRQZYSEEFKhaijTcNK9S46NwyUivpavKRrpHGKzZeAbJYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeggeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VVBxaQOmDb09c5t0gJvNKoglozyKQgCNRqjdEVdDyTHzywabW_ESxQ>
    <xmx:VVBxacLv-I6FsfOaJDqPJVR6cD_n9uxLAQgnQvQtdwRHMhPfFDSy9Q>
    <xmx:VVBxaYJf9qrxnT-FEOaRLfSBcrX7LWd3kKNiKAgNrHmErS6b43Pc0A>
    <xmx:VVBxae7GUG9qWT0TsK-S1BREHwuwaUz8BgyKA0Nbpr7adcEWBiC5LA>
    <xmx:VVBxaQz9J--HDH-KDQ4Cvy8B2cVM-Rssaw_d8NchCZR9WS01LdEUUEfC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:16:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 01/12] t1800: add hook output stream tests
In-Reply-To: <20260121215436.1473800-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 21 Jan 2026 23:54:25 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-2-adrian.ratiu@collabora.com>
Date: Wed, 21 Jan 2026 14:16:51 -0800
Message-ID: <xmqqjyxar4q4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Lack of test coverage in this area led to some regressions while
> converting the remaining hooks to the newer hook.[ch] API.
>
> Add some tests to verify hooks write to the expected output streams.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  t/t1800-hook.sh | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 4feaf0d7be..0e4f93fb31 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -184,4 +184,131 @@ test_expect_success 'stdin to hooks' '
>  	test_cmp expect actual
>  '
>  
> +check_stdout_separate_from_stderr () {
> +	for hook in "$@"
> +	do
> +		test_grep ! "Hook $hook stdout" stderr.actual &&
> +		test_grep ! "Hook $hook stderr" stdout.actual &&
> +		test_grep "Hook $hook stderr" stderr.actual &&
> +		test_grep "Hook $hook stdout" stdout.actual || return 1
> +	done
> +}
> +
> +check_stdout_merged_to_stderr () {
> +	test_grep ! "Hook .* stdout" stdout.actual &&
> +	test_grep ! "Hook .* stderr" stdout.actual &&
> +	for hook in "$@"
> +	do
> +		test_grep "Hook $hook stdout" stderr.actual &&
> +		test_grep "Hook $hook stderr" stderr.actual || return 1
> +	done
> +}

Asymmetry between the above two was a bit surprising, but the string
"the word 'hook' followed by something ending with 'stdout' or
'stderr'" is specific enough that the way the check makes sure
everything goes to stderr is probably fine.

> +test_expect_success 'client pre-push hook expects separate stdout and stderr' '
> +	test_when_finished "rm -f stdout.actual stderr.actual" &&
> +	git init --bare remote &&
> +	git remote add origin remote &&
> +	test_commit A &&
> +
> +	hook=pre-push &&
> +	test_hook $hook <<-EOF &&
> +	echo >&1 Hook $hook stdout
> +	echo >&2 Hook $hook stderr
> +	EOF
> +
> +	git push origin HEAD:main >stdout.actual 2>stderr.actual &&
> +	check_stdout_separate_from_stderr pre-push
> +'
> +
> +test_expect_success 'client hooks expect stdout redirected to stderr' '
> +	test_when_finished "rm -f stdout.actual stderr.actual" &&
> +	for hook in pre-commit post-commit post-checkout pre-merge-commit \
> +		prepare-commit-msg commit-msg post-merge post-rewrite reference-transaction \
> +		applypatch-msg pre-applypatch post-applypatch pre-rebase post-index-change

Slightly overlong lines above...

> +	do
> +		test_hook $hook <<-EOF || return 1
> +		echo >&1 Hook $hook stdout
> +		echo >&2 Hook $hook stderr
> +		EOF
> +	done &&
> +
> +	git checkout -B main &&
> +	git checkout -b branch-a &&
> +	test_commit commit-on-branch-a &&
> +
> +	# Trigger pre-commit, prepare-commit-msg, commit-msg, post-commit, reference-transaction

... and this one ...


> +	git commit --allow-empty -m "Test" >stdout.actual 2>stderr.actual &&
> +	check_stdout_merged_to_stderr pre-commit prepare-commit-msg commit-msg post-commit reference-transaction &&

... and this one.  I'll stop counting.

You commit, and then checkout, and then merge, and then
amend/rewrite, etc., all of which look quite sensible.  

These separate steps not being in individual test_expect_success and
instead in a single one chained together with &&- makes me suspect
that it would be inconvenient to tell which step is failing and to
debug when things start to break, though.

> +test_expect_success 'server hooks expect stdout redirected to stderr' '
> +	test_when_finished "rm -f stdout.actual stderr.actual" &&
> +	git init --bare remote-server &&
> +	git remote add origin-server remote-server &&
> +
> +	for hook in pre-receive update post-receive post-update
> +	do
> +		write_script remote-server/hooks/$hook <<-EOF || return 1
> +		echo >&1 Hook $hook stdout
> +		echo >&2 Hook $hook stderr
> +		EOF
> +	done &&
> +
> +	# Trigger pre-receive update post-receive post-update
> +	git push origin-server HEAD:new-branch >stdout.actual 2>stderr.actual &&
> +	check_stdout_merged_to_stderr pre-receive update post-receive post-update
> +'
> +
> +test_expect_success 'server push-to-checkout hook expects stdout redirected to stderr' '
> +	test_when_finished "rm -f stdout.actual stderr.actual" &&
> +	git init server &&
> +	git -C server checkout -b main &&
> +	test_config -C server receive.denyCurrentBranch updateInstead &&
> +	git remote add origin-server-2 server &&
> +
> +	write_script server/.git/hooks/push-to-checkout <<-EOF &&
> +	echo >&1 Hook push-to-checkout stdout
> +	echo >&2 Hook push-to-checkout stderr
> +	EOF
> +
> +	# Trigger push-to-checkout
> +	git push origin-server-2 HEAD:main >stdout.actual 2>stderr.actual &&
> +	check_stdout_merged_to_stderr push-to-checkout
> +'
> +
>  test_done

Looking good otherwise.  Thanks.
