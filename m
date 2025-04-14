Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A791F30C0
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666946; cv=none; b=PsZu/C4F094O1mWRpAgcEQ/7oB6eYPM3chqRdZ8axJbvTNOkhGMDlWRiI9rH1mMqCLo3M50A8x4NE3uRFZsjRA2rwxAQsqtHQcas2WuL67I2/YSuIbBwZ6z73flYNj0UqFvmv0s9HUkQbmIyQWmb9NoJW7DRzjsOXEiMQn4gQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666946; c=relaxed/simple;
	bh=XV5X0wyxkGGU5nZ+Sbwymvgh0/bLJQV4KgGSbQURyuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBAI41vIgTcyA2cPCO64yJAcohWA6aaIn9cPQNhFin72cbzT+ADmocXAfMrHWLA1ow8ngi4Z1MCDhIpoBqLqi5QKpkVmKZ/pdVUvHzTaKlKSiJTSoPm9tFJwGH7Q71kcr4lapoJJn5UAAtB14RXHIHslla4Ui2Dr4IFLNLRLMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xTK0W/dU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMeqvOS8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xTK0W/dU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMeqvOS8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B8D261380459;
	Mon, 14 Apr 2025 17:42:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 17:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744666942; x=1744753342; bh=wObJeEekcp
	NRaCfAb3VCgrjNecFwe0ioO0tVYmxd1AI=; b=xTK0W/dUUO/JlvO0xhCKA7PhRT
	hrzAaCvVy7EvOB9oG1+TfyGl2qEEr39r7ymQlZm4K6SJ/TCscM+OvrZIGOkm/gYS
	Tlm8MgHZQXjHqND9SkJ6L7rjGB+kGFwndXA+o+0lVlvMsa6v6sqyPmDNljf97/H8
	P5D+zT7wRl5rPaMqKkVsZ6bBL55qA6lPcF/Jvat+a3JqCA2bXKc7SE4uAmwLcnhI
	Oq/sNj2TX6TKv0o4QQo39wVafrziM6el5PnkQclebL/Kpy3p19JiPuGWZrVcVc8I
	bJscSc2FffYboOTkiiYkYFnc+BaqEDvIYeIH30bJSaXvO5Wh0PjJoT4jcWmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744666942; x=1744753342; bh=wObJeEekcpNRaCfAb3VCgrjNecFwe0ioO0t
	VYmxd1AI=; b=MMeqvOS81oHfY/ACjQhBk+z0KHji4tO/o6Timbp/yIPWoYqAmhp
	FF83+B9giMWfgAeDebqRn4K2PdKfRGRLB2OUaer0pNQKqPNlyiiOxHFCX1s3fwYr
	N3URLZ45892R2QLZfN2pBUiKcME5bOVQ8h5geIqWXaTAwgrd2mvjX4m3bdzVXCdB
	rA4SjjbYAl0u3KjDFlZOoSHN22vaoenEQKKoigr3r/huimhE4Cbly95uzmYurYl8
	j9saEU/FD9ZVUXsrnfL/EfzNBJ3+q/ftct7ybD8uh0aBjlo29cVQrygou9TmR133
	TZl4N3SdmrpRYZ4AY7OEiZKKNNbgYpuejFg==
X-ME-Sender: <xms:PoH9Z4ljE6OkhsjHUHMNao341DsZQRoT_go912X-mGuHWz1-bA_Y4A>
    <xme:PoH9Z32T8LICW-oVlaayvDQzJQVqYOhoGZFKklCoeHHigxukTNMOnhYNfZPfqcSFx
    C-xgkqffy_Xp_6PWQ>
X-ME-Received: <xmr:PoH9Z2pyjalSyEeNGJBeEqMFnWrADmiMzYTrzthX7z623pKUy4zh8TTl86gw60Q7raRx-oF8Y341ircWjTJ_GA_Kl2-KiEJssPI9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpihhothhrshhiuhhprgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PoH9Z0lfoPD6LfkNfAxItLsRTrOsXbvGkT5-Dq6WTdK89tFJKNyIQg>
    <xmx:PoH9Z23sc-tx8DxjBU9pV5okKXW596sM7-XKWV0HijEkFaiMJ9pdlg>
    <xmx:PoH9Z7s0KGJh6FRnfATSoEduXX09rqCE-g1zb4JHcfYHYD9988VinQ>
    <xmx:PoH9ZyUHgCMYbzSkyZqTcFbsfbzplBsUirJbCAM6QqSKykSod4-p9A>
    <xmx:PoH9ZyirnPmfpRQPPWi54lDBSmzL4do3cELjX8XUfj5Svy13ekZ4R4QO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 17:42:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  piotrsiupa@gmail.com
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
In-Reply-To: <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 12 Apr 2025 23:10:51 +0530")
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
	<20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 14 Apr 2025 14:42:20 -0700
Message-ID: <xmqqfriapghv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> When 'git add <pattern>' is run, and a file exists whose literal
> name matches <pattern> (e.g., a file named "f*" when running
> 'git add f*'), Git should treat the pattern as a wildcard
> matching multiple files, rather than just adding the literal file.

This pretends to be a separate and independent patch, but it in
reality depends on the other change to dir.c, doesn't it?

Either make them into two-patch series, or better yet make them into
a single patch, perhaps?

> Add a test case that:
>  1. Creates files 'f*', 'f**', and 'foo'.
>  2. Verifies that 'git add "f\*\*"'
>     correctly adds only the literal file 'f**'.
>  3. Verifies that 'git add 'f*'' (quoted to prevent shell expansion)
>     correctly adds 'f*', 'f**', and 'foo' by treating 'f*' as a
>     wildcard.

That is something easily can be read from the script itself.  Don't
repeat what the code does, UNLESS the explanation helps readers to
understand what the code does NOT tell them (like, "why does the
code does what it does?").

> Covering these the test adds 5 cases.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  t/meson.build                   |  1 +
>  t/t3706-add-wildcard-literal.sh | 44 +++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100755 t/t3706-add-wildcard-literal.sh

I am not sure if this should be done as a new test script and covers
only "git add".  Is "git add" the only code paths that triggers
do_match_pathspec()?  If there are many, it may make sense to have a
new script (like this patch does) and cover all of these commands
that are corrected by the previous patch.  If not, and if it truly
affects only "git add", then it would make more sense to add to an
existing test script that covers "git add".

> +test_expect_success 'setup: create files and initial commit' '
> +    mkdir testdir &&
> +    >testdir/f\* &&
> +    >testdir/f\*\* &&
> +    >testdir/foo &&
> +    git add testdir &&
> +    git commit -m "Initial setup with literal wildcard files"
> +'
> +
> +test_expect_success 'clean slate before testing wildcard behavior' '
> +    git rm -rf testdir &&
> +    git commit -m "Clean state"
> +'

What's the point of the above two test pieces?  The initial commit
is not used in any way after it gets created, the wildcard pathspec,
which is the topic of this test, is not involved in its creation in
any way, and everything gets removed before the real test after this
step starts.  Not complaining, but showing puzzlement, as I truly do
not see the point of these two steps.

> +test_expect_success 'recreate files to test add behavior' '
> +    mkdir testdir &&
> +    >testdir/f\* &&
> +    >testdir/f\*\* &&
> +    >testdir/foo
> +'
> +
> +test_expect_success 'quoted literal: git add "f\\*\\*" adds only f**' '
> +    git reset &&

What is the point of this "reset"?  Since the last commit, the tree
of HEAD matches the index, and nobody touched the index after that.

> +    git add "testdir/f\\*\\*" &&

OK.  We are giving the pathspec with asterisks quoted in it, to make
sure the asterisks are not interpreted as glob.  So there is only
one path that gets added in the end, and that is what is tested.

That's a good test (except that I do not understand what the "reset"
at the beginning is trying to do).

> +    git ls-files >actual &&
> +    echo "testdir/f**" >expected &&
> +    test_cmp expected actual
> +'
> +
> +test_expect_success 'wildcard: git add f* adds f*, f** and foo' '
> +    git reset &&
> +    git add '\''testdir/f*'\'' &&

Why not just

	git add "testdir/f*" &&

to match the previous one?

> +    git ls-files | sort >actual &&

"git" command on the left hand side of a pipe means even if it
fails, its exit status is hidden.  Also, the order ls-files emits
paths is well defined (sorted in the byte-value order regardless of
locale), so piping its output through sort loses information
unnecessarily (you wouldn't notice if ls-files started emitting its
paths in an incorrect order).

Since you use these three pathnames in this order quote often in
this script, why not do this once upfront:

	cat >list-of-files <<-\EOF &&
	testdir/f*
	testdir/f**
        testdir/foo
	EOF

and then use the list of files in later steps like so:

	while read path
	do
		>"$path"
	done <list-of-files &&

	git ls-files >actual &&
	test_cmp list-of-files actual

> +    printf "%s\n" "testdir/f*" "testdir/f**" "testdir/foo" | sort >expected &&
> +    test_cmp expected actual
> +'
> +
> +test_done
> \ No newline at end of file

Please make sure your files are properly formatted.  Perhaps we
should add whitespace error class 'incomplete-lines' that catches
this, and enable it globally, or something?

