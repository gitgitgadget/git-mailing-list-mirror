Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D41DF755
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113506; cv=none; b=b5ud9/xaiiXU6xhYdbpGHZ/rfB7nHN/lIRk4e1lH8sKfP1wl2TSSSqFBB/CCEqXTYEbxvR5IMjTWsxjiAHx0fujl3Zr5W118qvNs3AKc/Yswe/Ih2R2M6hzM91S7AvFxjshQDythLdmxnFP+shQ+AdZ3XYbaZrr9wQ5svJxgxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113506; c=relaxed/simple;
	bh=lnYhYr+YLejpV+oJabV+1T/DpHnI9eUzMOt7HyxF3jA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eko1QPpulXAMRc6AhHsvETgm88+luQlYeuaalQZSeGLllPmZGR3DYuyKecm5TcUOYWNDdS08I1dqpbspA4AlDJ74Q2F3pwT/29hl9bRZWpa9lU5Ip4P7XoB2yM2UK2/grQ/vP488PXBuzd35fQOeUlV0ErpQEyQVIaurwVR3KD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IbhosHNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BL7pfMJ9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IbhosHNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BL7pfMJ9"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 282021D00192;
	Mon,  9 Mar 2026 23:31:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 09 Mar 2026 23:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773113503; x=1773199903; bh=5C0cS+dWmd
	SuxkPA7q/sktpn41V2qeXKeFAQlxBOQ/c=; b=IbhosHNPBkR8OkeL1c0uGWch8V
	wzzLshjisHInmKfTgIqXX0/FX7+iWZe19XvIldbyc1e9B0cVCrAzlFfAYn4hA1E9
	ppnnDhUu9nhuNdEYkK1PH1Y8UpXo+/jXx1ubUjH0AeyQ+4pwh0zuVPBMztxdeecO
	VU6ZLFsKGKSGUtLNcpf9NaCiIjYmbiAlnR8qZnTifIX5kdGj21HK3J5p87rTyFm6
	i/iYhBQPLDrb1GE1sRa2XtD11OJfCtNKu+VdmUX/C8Q+BmL/fQkSbe/FujnKkurR
	rKiR5JPBjRSVTTepPVjkGthJiCo37o6SZUiivCcmCWJZDLy8YARZo22CG4wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773113503; x=1773199903; bh=5C0cS+dWmdSuxkPA7q/sktpn41V2qeXKeFA
	QlxBOQ/c=; b=BL7pfMJ9MPA7krxPa/u4ia8hFb2rfBzBQY3ztwPmrzZe+QJiOLv
	OIwwii3xp2TlN/BBDisJ5g+NAMdqdVAoS+Hnc83Vk0VqaTPmuHw5I/VKjrIilJsl
	o50EI1o2RICN5KQGKL7RD3OMClIr6aB70JsCUf7uTz3VJmTLdqTrmo3fUiOh1XSk
	mPjXJBHWMbDP1JYliKVfv/j8FEf7PhTCb2zlAKb5ZcsStC8m3ijYg1FOYlEb3RZ6
	vAVDc06A6+siuY4zcEYoNVFNpjzjolSrSUx2IjzPi37KesgukiwBfbK0vmz1e/yj
	mCk1w8raC50U2JIyRQN6gSQt3w4+sTxMCPQ==
X-ME-Sender: <xms:n5CvaV9kIVTDgSoShzjslh7NjieYCTp2oY_CqIu5wQ9qcITK6RPtOw>
    <xme:n5CvaRIOy22Zbi2qh78OrR-pIfb-E4g0nTP_V9QY907vbO0QWGkYpLcvfKH_AZaX2
    FP7jIhcbO0rQHRYYaP0n0auM4o9ys69SaUL3ufIFqQI9YoHmdV75A>
X-ME-Received: <xmr:n5CvaQYyL_cHUDXa5fMATgzD-K3KafOI5gp3wm8cG3sayk3qhflDMKqw9dRrTN7YPTuLDg4Q0Ob5o3yDs7N770QHHwKJATXN9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:n5CvaTI0XODcldOKmyStHN_zDI5c9J2oxHcUdnAvEkghSvGR9wc8lQ>
    <xmx:n5CvaeCgoEIY0xhMepCq62-iYk_l8V6tLVtP_UqnuDuNdm9_jmA5ow>
    <xmx:n5CvaYpA_0cIUIt1H8iYBTk3HAIha28XCsNc_e_a_Ac90Qri63cS7A>
    <xmx:n5CvaZiAtZStWhQNC2r3N2U1YapId8Wp8W5_L9oLFtyrxRoQvlXubQ>
    <xmx:n5CvaT2mo8ccY6ueC-036COvR8qUFDEIT0SHdFN_k4A33DNLCNIv7DFR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 23:31:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] apply.c: fix -p argument parsing
In-Reply-To: <20260310005408.2022216-1-mroik@delayed.space> (Mirko Faina's
	message of "Tue, 10 Mar 2026 01:54:07 +0100")
References: <20260309232700.553168-1-mroik@delayed.space>
	<20260310005408.2022216-1-mroik@delayed.space>
Date: Mon, 09 Mar 2026 20:31:42 -0700
Message-ID: <xmqqwlzkxsv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> "git apply" has an option -p that takes an integer as its argument.
> Unfortunately the function apply_option_parse_p() in charge of parsing
> this argument uses atoi() to convert from string to integer, which
> allows a non-digit after the number (e.g. "1q") to be silently ignored.
> As a consequence, an argument that does not begin with a digit silently
> becomes a zero. Despite this command working fine when a non-positive
> argument is passed, it might be useful for the end user to know that
> their input contains non-digits that might've been unintended.
>
> Replace atoi() with strtol_i() to catch malformed inputs.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---

>  apply.c                 |  3 ++-
>  t/t4103-apply-binary.sh | 19 +++++++++++++++++++
>  t/t4103/patch           | 16 ++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4103/patch

Curious.  It is true that we need to parse the p_value correctly
even when we are applying a binary patch, but the problem is not
limited to binary patches, is it?

> diff --git a/apply.c b/apply.c
> index b6dd1066a0..61df3bdcd0 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4981,7 +4981,8 @@ static int apply_option_parse_p(const struct option *opt,
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	state->p_value = atoi(arg);
> +	if (strtol_i(arg, 10, &state->p_value) < 0 || state->p_value < 0)
> +		die("<num> has to be a non-negative integer");
>  	state->p_value_known = 1;
>  	return 0;
>  }

Sounds sensible.

I briefly wondered if it would have negative fallouts to change the
type of .p_value member to "unsigned int" and use strtol_ui() to
parse it, but the amount of work this part of the code needs to do
does not change that much, so such a change is of dubious value.
It looks like the above draws the line at the right place to stop.

Great execution.

> diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
> index 8e302a5a57..d9dc884946 100755
> --- a/t/t4103-apply-binary.sh
> +++ b/t/t4103-apply-binary.sh
> @@ -53,6 +53,25 @@ test_expect_success 'setup' '
>  	)
>  '
>  
> +test_expect_success 'git apply -p 1 patch' '
> +	test_when_finished "rm -rf result t" &&
> +	git apply -p 1 $TEST_DIRECTORY/t4103/patch &&
> +	ls -l | sed -e "/[[:space:]]t$/!d" >result &&
> +	test_line_count = 1 result
> +'

Is this saying "in the directory there must be only a single file
whose name is t?"  Wouldn't it be more readable and direct to do
something like

	test_path_is_dir t

or is there something more subtle going on here?

> +test_expect_success 'git apply -p malformed patch' '
> +	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4103/patch
> +'
>
> +test_expect_success 'git apply -p 2q patch' '
> +	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4103/patch
> +'

If this did not fail and patch gets applied with some p_value that
happens to be used when we fail to parse the number, then ...

> +test_expect_success 'git apply -p -1 patch' '
> +	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4103/patch
> +'

... it would not be clear why this step fails.  Perhaps with that
same "unable to parse" p_value was used and this tried to create the
same file as the previous step already created, or we detected parse
failure.  We cannot tell.

It probably is a good idea to prepare for the worst by doing
something silly like

	test_when_finished "rm -f t/test/test test/test test" &&

at the beginning of each of these tests so that we would clean up
whatever we could leave behind?  I dunno.

>  test_expect_success 'stat binary diff -- should not fail.' \
>  	'git checkout main &&
>  	 git apply --stat --summary B.diff'
> diff --git a/t/t4103/patch b/t/t4103/patch
> new file mode 100644
> index 0000000000..c4511bb708
> --- /dev/null
> +++ b/t/t4103/patch
> @@ -0,0 +1,16 @@
> +From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001
> +From: Mroik <mroik@delayed.space>
> +Date: Mon, 9 Mar 2026 23:25:00 +0100
> +Subject: [PATCH] Test
> +
> +---
> + t/test/test | 0
> + 1 file changed, 0 insertions(+), 0 deletions(-)
> + create mode 100644 t/test/test
> +
> +diff --git a/t/test/test b/t/test/test
> +new file mode 100644
> +index 0000000000..e69de29bb2
> +-- 
> +2.53.0.851.ga537e3e6e9
> +
