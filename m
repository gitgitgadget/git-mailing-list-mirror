Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017A2135D7
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546167; cv=none; b=H7STxiuQkNuj0cLvLEyGvtTaTNVf2lVBAK/iaVKxIW+eyrnNkjkf5kagIjsI1OzAqUAINAv3VDvEoqYUQd9mQrar6JXlUbnL9RGJSQrGpyVzHyr9gKo2cID+efjRBkFDE+hV+E+ru2u5dzDx1G2HtvG7rfCC5CYiDA9Q4IUzCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546167; c=relaxed/simple;
	bh=jwwjPb2dv8hD2YZS2Ms/EpwybBZ770EyEQaYjQEUKVg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ksCklkwH99QePwSda1KbLBtTM7qMcKdenMbX1izrK6PJaRcMKz4KZ9tG25Q+2UIN1N4Dkh7Vk99g3b4uPtVkX2EuivLNhTYsRHlbrrVtd/Svk3Iy+zQ3ef8gAiNGW7wzfxMXTFYXHVm3yJklA21kwfz/eq9uGh8ZonI5j/+5tkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mz8rZrnl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZjLbUlD; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mz8rZrnl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZjLbUlD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71F207A00BC;
	Tue, 27 Jan 2026 15:36:04 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 27 Jan 2026 15:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769546164;
	 x=1769632564; bh=+QcJ3uLLjauvii6+9eHWoEEKII632pHz2WcsFPiOvxE=; b=
	mz8rZrnl9vEsdtApabghmmzZfdGC8uMLhIMhBVqu2jacGOCRdiUXepIvCBwprW+w
	HRLrGaU5xdydJ0anBu4BRZTlYYzKooE5f+2Zauh8V7S5sC9MeNn38q4LT53VtMXy
	PQ8UHWawp2WXr7Gz4orwONY1aO7Pc0iFr+ZMQGL59Sjiew43JkapiaMwGjMba5Hz
	TE4d6GzR8hn2dZbTGh5iF8LGQg9TYHStTguHdyh4AWfNIwRmLPh6Fkq9fH4vtmW7
	WCeYsR10eSEmtFpeTC5ZTb4lwyu4C34qMl/x2LpgogZ4agwwFE/RfTwLsuGSS4s1
	OFb0GfuiElYiZFyq+q28Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769546164; x=
	1769632564; bh=+QcJ3uLLjauvii6+9eHWoEEKII632pHz2WcsFPiOvxE=; b=C
	ZjLbUlDxzHjQ0FJJsgH7Q1VOxvH7T3lFxK/QSCizUy3Dx0g+xVMPWFIR1KGScQoG
	007MBM8cwRAEKLuDVUGe3/irsCi5TBegJzWvFkJw8VPJYEuAcB4ipQnZTPFSNW30
	rlnRDTPaOjblrN4o1DH2d2X9SEx2z/V2YbLkNlGgAk4BMEH8PY/ARTWb+4nTulIW
	qcvn+a65suAvlk9tZk65TnjJRArEMEkrnnk91nTZGlwSRucXSBHNBVZqDEuogxA6
	taf7uj0HLM1nsln/hmynjuE7ZATZGDAOJcx6G4oC4auWFeVdK2cRMPUG7V59X+/4
	LWq+iOEIV9xi91M6ZCMow==
X-ME-Sender: <xms:tCF5aR-uCg-MvFQ96z8ZlfHFlcON-L_8YERHDMbcekdNhzHtzq7zjb0>
    <xme:tCF5aQjRHkJTYCwWtXeruH3M2wsFsTwl_3325nYgYfAfpdk6kXTXMhRF_2I5AQGci
    OZx_bX5hjv-X1Mv_RmHoMtA5JGx9diZWMHJlHWfJDi4Tnr21ek3xZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    ihqhhsihhmohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tCF5aT6aMP0xwXr0VBxYe4qeyPTsLWDKuN1N6KX43NwBZ9A4prNzlA>
    <xmx:tCF5aQrkN1ahyHbk3WkYgsjADuJ5a9h3sWZ6-4SqI2Qshv7lHdM7UA>
    <xmx:tCF5adiPRjywsGkmp2u_SWvPWkNfEMFB93uO5uSh1Qp-56Tyl4f-oQ>
    <xmx:tCF5aSLQ-AQJo6Y04GaQVvXjRKjEJqtbWOiVJccUIh41SbHrH-j1Iw>
    <xmx:tCF5ac2KY2ceHwGG3SdBHapkTZa6jlyVUgrA0Aq-0eU_mg1sPp6VhORC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C2D01EA0076; Tue, 27 Jan 2026 15:36:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZ2ADYvVFUpw
Date: Tue, 27 Jan 2026 21:35:43 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "Simon Cheng" <cyqsimon@gmail.com>
Message-Id: <fa7f1648-3cf6-4e5f-bee9-fb5e8700d01d@app.fastmail.com>
In-Reply-To: <20260127192936.904719-3-gitster@pobox.com>
References: <20260127192936.904719-1-gitster@pobox.com>
 <20260127192936.904719-3-gitster@pobox.com>
Subject: Re: [PATCH 2/2] checkout: tell "parse_remote_branch" which command is calling
 it
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026, at 20:29, Junio C Hamano wrote:
> When "git checkout <dwim>" and "git switch <dwim>" need to error out
> due to ambiguity of the branch name <dwim>, these command give an

s/these command/these two commands/ or something.

> advise message that tells a sample command to show how to
> disambiguate from the parse_remote_branch() function.  The sample
> command hardcodes "git checkout", since this feature predates "git
> switch" by a large margin.  To a user who said "git switch <dwim>"
> and got this message, it is confusing.
>
> Pass the "enum checkout_command", which was invented in the previous
> step for this exact purpose, down the call chain leading to
> parse_remote_branch() function to change the sample command shown to
> the user in this advise message.

The commit message could also say that it adds a regression test for
this advice (for the first time).

>
> Reported-by: Simon Cheng <cyqsimon@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/checkout.c        | 29 ++++++++++++++++++++++++-----
>  t/t2027-checkout-track.sh | 21 +++++++++++++++++++++
>  2 files changed, 45 insertions(+), 5 deletions(-)
>[snip]
> diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
> index a397790df5..e9f8d8ec48 100755
> --- a/t/t2027-checkout-track.sh
> +++ b/t/t2027-checkout-track.sh
> @@ -47,4 +47,25 @@ test_expect_success 'checkout --track -b overrides
> autoSetupMerge=3Dinherit' '
>  	test_cmp_config refs/heads/main branch.b4.merge
>  '
>
> +test_expect_success 'ambiguous tracking info' '
> +	# Set up a few remote repositories
> +	git init --bare --initial-branch=3Dtrunk src1 &&
> +	git init --bare --initial-branch=3Dtrunk src2 &&
> +	git push src1 one:refs/heads/trunk &&
> +	git push src2 two:refs/heads/trunk &&
> +
> +	git remote add -f src1 "file://$PWD/src1" &&
> +	git remote add -f src2 "file://$PWD/src2" &&
> +
> +	# DWIM
> +	test_must_fail git checkout trunk 2>hint &&
> +	test_grep "hint: *git checkout --track" hint &&
> +	test_grep ! "hint: *git switch --track" hint &&
> +
> +	{ git update-ref -d refs/heads/trunk || :; } &&

I don=E2=80=99t understand what the purpose of this is after `git checko=
ut` but
before `git switch`. I can delete it and the test still passes. Is it
post-test cleanup?

> +	test_must_fail git switch trunk 2>hint &&
> +	test_grep ! "hint: *git checkout --track" hint &&
> +	test_grep "hint: *git switch --track" hint
> +'

Maybe just the positive greps are enough. I read these a few times
because I thought the order was wrong, i.e. that `hint` was overwritten
before it got tested. The regression that they test are unlikely and
these negative greps might not make immediate sense for future
readers. I dunno.

I was about to suggest parameterizing the command but that makes it
harder to grep for that part of the advice.

    checkout_with_cmd () {
            cmd=3D"$1"
            test_must_fail git $cmd trunk 2>hint &&
            test_grep --fixed-string \
                      "hint:     git $cmd --track origin/<name>" hint
    }


> +
>  test_done
> --
> 2.53.0-rc2-135-gb1217c0133
