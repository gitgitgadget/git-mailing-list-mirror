Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12053BBA0A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148393; cv=none; b=lVrwwK1dUhSgr3oxsRAyxYx01FXWVLio3fLXXUUYfY8xWwrVLqKAKczomdabS7teErEv+zCjWVKLPDi/rMQhUkpZxywHAGFinqSzTpWF16WpWdtUeMUIA5tMrxbysCHeDr67ACpDj6gRVvlIsSvWFfUM+D/5t6EoRqKi/RW8dwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148393; c=relaxed/simple;
	bh=1Pjz2Hm11u0qkdAoKzR22mX47w9RGpRoYX5kAcXfbGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTFu5qyl6cBqxqkRCH8M58Ah4m7NB8BBCAvYJeEf3cDjlaY2kUNcWsMMTQP5ag/yAF0zEZJ8PHvBw0Ts7UPBCfR/lxilCYFKAzqrDr5wdAaA5fRAj3AZVK2HwnUffmHotNvmr4rPcZLnWw56Qoefg3zZEhIPXN3UqnTy43h0eF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BeW5vz5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocErsyQb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BeW5vz5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocErsyQb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 080EA14000A4;
	Tue, 10 Mar 2026 09:13:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 10 Mar 2026 09:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773148391;
	 x=1773234791; bh=ie4JNE5OZHXC+o39rfQ2nox4KSnEWTWBvcVe3AFRTM0=; b=
	BeW5vz5ylWunS/CaKXn9tDcm4GGITJ8JIB+IfxSvYRsNBS+GOOpEjcxtNyJ1nXOM
	oOStBaEMq2pp2uuoyzyG72sacFmhmUx/WPAnhqtZ5d/GL8WF2g9pUJPoGJoK4m9r
	DwbGGd2i8XbDiBglqfXCnRl6ES9Wkx6SWN9vY2gESvkNRbc4R27/zH0OW1nDfvFd
	GAQsnc8netpvaXJGVovKAzAOSODUeXuw4m709u0xT8fYiKMgelTZK2GwBTlFA9SU
	qIDYisRLtnZJdPlBbjpFRLqJKyKNj4SW46n+xuCHYRVrdmuMFwZPnEZQCQMHm/19
	HZB/0tWYdUMZr+RxI2Xw8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773148391; x=
	1773234791; bh=ie4JNE5OZHXC+o39rfQ2nox4KSnEWTWBvcVe3AFRTM0=; b=o
	cErsyQblCTNJYKimfsVLe5oSEXMNL09vOH3wymBLxJL/I+fqr++2h8vrgFyP9nRl
	dM2nMZpsRtUz6/X3o/zvQ9P3pCbnf2TNlDYhET5CBxwku60BaUDMPGG14Z9I1+QB
	SYHiboh1hWvp75z3jK3n6zITlDnG+6fV3MOdbDzBNDBdp4Dm50WNwaDeAVdlJnV1
	FJVDiNwTWpXr3zrDMvwbg/AogwgJYBdnwPzkuRcS9lqxfQNVAaKTw1PqtLevXuPc
	pe8Dm/4ou/1uSWiqjG9nQQEjY1jQZs3r95qkNcvdq6V3saJvTkWlw/D8Ig7GQ6dH
	0ptC5MUBTVuOt2UQTRw2Q==
X-ME-Sender: <xms:5hiwafJz85Sg0tsVwrV49WnQ7yOmuYdjpnczX99ppR900EWpHg54SA>
    <xme:5hiwaanBvZbJtCZyJLN6sbq4lw6mfHOG5W3xhc3SEVhNViFcAIImBH28DD5D9ONLv
    vAgT8968fG-cs6Ry9W58g4r3H8lgUfOr1Xoz_jScQ26cg7m8gxtJwg>
X-ME-Received: <xmr:5hiwaVFTE_WdeQMQ2U_m0B4VgeaD3FD_s8010gCqQI9LOtey4Le2qMEUS46p7jzSmIpUZ5xFz2E8azPltJB5v25BAHPrgajNhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekof
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeuge
    fhtdejhffgkefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhrohhi
    khesuggvlhgrhigvugdrshhprggtvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5hiwaSHDi6tFRqVre2aQVsQA6hN29iODoMzF1tSLEpj7KuVcXyDUGA>
    <xmx:5hiwaaM2n4bNUhB0lvWJEPkPasotUqyiWPGLK7dJx1BMN2OzpOyPhg>
    <xmx:5hiwaZE2th952T1sWoCRk58HLSDIYDzhx2qGncPEM--kIjRXNrXUFA>
    <xmx:5hiwaZOLGq_H2zYkgPmlWWfPiVeRZUKwefYX0lbW7a3qC_Y7QStDMQ>
    <xmx:5xiwaZywnqPP2XAE2j3mBWObErgXyP2NEga9Cb6vySUbdQti_QrAZi5w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:13:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] apply.c: fix -p argument parsing
In-Reply-To: <20260310050621.3849719-1-mroik@delayed.space> (Mirko Faina's
	message of "Tue, 10 Mar 2026 06:06:15 +0100")
References: <20260310005408.2022216-1-mroik@delayed.space>
	<20260310050621.3849719-1-mroik@delayed.space>
Date: Tue, 10 Mar 2026 06:13:09 -0700
Message-ID: <xmqqjyvjygii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Mirko Faina <mroik@delayed.space> writes:

>  apply.c               |  3 ++-
>  t/t4120-apply-popt.sh | 21 +++++++++++++++++++++
>  t/t4120/patch         | 16 ++++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4120/patch

Yeah, 4120 is about the "-p" option, and is much better fit for the
tests for this input validation feature.  Good find.

Will queue.  Thanks.

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
> diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
> index 697e86c0ff..3fdcfecc52 100755
> --- a/t/t4120-apply-popt.sh
> +++ b/t/t4120-apply-popt.sh
> @@ -23,6 +23,27 @@ test_expect_success setup '
>  	rmdir süb
>  '
>  
> +test_expect_success 'git apply -p 1 patch' '
> +	test_when_finished "rm -rf t" &&
> +	git apply -p 1 $TEST_DIRECTORY/t4120/patch &&
> +	test_path_is_dir t
> +'
> +
> +test_expect_success 'apply fails due to non-num -p' '
> +	test_when_finished "rm -rf t test" &&
> +	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4120/patch
> +'
> +
> +test_expect_success 'apply fails due to trailing non-digit in -p' '
> +	test_when_finished "rm -rf t test" &&
> +	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4120/patch
> +'
> +
> +test_expect_success 'apply fails due to negative number in -p' '
> +	test_when_finished "rm -rf t test" &&
> +	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4120/patch
> +'
> +
>  test_expect_success 'apply git diff with -p2' '
>  	cp file1.saved file1 &&
>  	git apply -p2 patch.file
> diff --git a/t/t4120/patch b/t/t4120/patch
> new file mode 100644
> index 0000000000..c4511bb708
> --- /dev/null
> +++ b/t/t4120/patch
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
