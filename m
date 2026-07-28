Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A93A7F7C
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260222; cv=none; b=rXR2GqYlenbrz8Lz9OgOUx7UijoNo64BCCG2ldCpECXHF8NQGuxbvKCZj0HTRe7OhmCgNu70O9idxpDyqbZZNDYRMiPNkBo2QgEIS6Xl6BcMH9WQJD86AZYtLGtXnTjSS5RsiUMM5MUwetfR94ivSxB8OJtdvHSe+IORz8Hj7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260222; c=relaxed/simple;
	bh=RGGLeGe+HR9od3E5h3kEQ1O/UgBhm2frsQtACZTQxP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VxgU2rnpQGLNgPXBBqqyfvCdWr8lZ3+vMMiZwcxPmP/qAs+ODl11UrZ4OPqyTbYu89291N4y8+Cf6py4uZcjFN0ZlC5NFWuqc7tjXpiAzbkRrLKSg8Xfn4auwscCOhbCgP3NHiOMPHbrYkS+L6/qTliNf7JrLNKgmIDJqhR2r3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QI7zfnKK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmV/H2VY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QI7zfnKK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmV/H2VY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30BF21400011;
	Tue, 28 Jul 2026 13:36:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 13:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785260219; x=1785346619; bh=ev0JZbDgls
	FHvB658S7Smd6XjVUPfTw9lKw2VKbC3Hk=; b=QI7zfnKKOfCJBDROaWehonGOBm
	Rm4YqmKH2cI+1NNFAmIkfHbOgsCfNISseTQdxH1CmLFWdrw1hyLEbyZps7o5Uenx
	gewmIk+1m6KkgzJkttZPT7JJA6ybM8sMZkSyOohfdgFoW1rNqY2FQO4S84mskT08
	9MoLwLWJSV2EKKVPObPjXxnr/nY+Aw8tPRibdB0KM8L20ollJGiF47Fp0dfipZQC
	afr4QUQJ8qONY5UoA40OR6o/zwVN3Wi8pDX116XQ9KvhpVnxAQPzNHFWj2r/1yQj
	vfH52dn2oMfoS6H5XLuaz+KuBUAB1sc+VYS2KC6yCujxOK/ajVhon07yvypA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785260219; x=1785346619; bh=ev0JZbDglsFHvB658S7Smd6XjVUPfTw9lKw
	2VKbC3Hk=; b=gmV/H2VYG8sgfCr1ciKxiqEkbCgbRa1La+Ttp3LmSVh2cl5oyVR
	eLURE0FJAiH/NHs+Ox9mBkEOtWeZEp5l4TjSllmKy6ArzqOs/QgjwRAhihr97Mpd
	NgL8Mx9K7tHst70PFmCO/zrYictlpaGbL7afcPE+XBh8y5GPQXe9/SaudSHWyMxy
	g/xiBtF27C3YM+f9OO2pMu7ZcGliRlxbhtm79RhB3xOQG/q3umznd52Pr+T00NvZ
	B5Xk4kxAg3CpjwOXrDqcoEOmAWVU0tpf7G52BtDzvzutoGng5VZw6w01P4bQ8kfl
	NoU5/UejXHU2VBftI6vxKFf5tlk+4QY8/yA==
X-ME-Sender: <xms:uuhoaiqUPrlrr2o1tzclQCEJMcxHdy9nCrroKdgNJ5Njbc-ZIjdwdQ>
    <xme:uuhoasJkjb69dvN5hI9HwxhmRs1mQhADPNEMUnqENlNwKltxPfZF4FRkX6Ln8gywI
    L2BIw6Qd7dn2ctE8Vnh9GOiJHBcb8SsAoAq5Uz3R2KUqnjGxTLf>
X-ME-Received: <xmr:uuhoatpcM8-ZFIfePouYqDADcn2UhwMKB6J3taXJHRfKMKVWtuZ6oAaeHlCpnWdAU-vHFivts5nOvkTeR_EIWuFuOaYv6P87-g>
X-ME-Proxy-Cause: dmFkZTGrDz2395Z7zFPcGsF+ckVQseB8YseLee834Urm3oksyXl+1GJGBmUOkUH/cyjITi
    FUxfV8hAjoztjeSG6qEK3UY8BX/nQHGaya7HwJroUpJmfrRSw7GWftonMVIQL5zp6Rn1eB
    3NypX6b1aYMcpw2L+HPtHfb6RE2xmR3Vjjg7xrS9YxDawyfMw1Rn/0h4GQQZMgKWSj0p70
    magUWsyOzjhYUPPRBOpwQb5c5HDzlR1h6rzRi5gcvrkGFbzM2Ss80sKAZmGFjiA2d6HaQt
    SfXGmFo2EK6VKx871Blfi1csVdLHAwvr8FeRfWC/AK2eBpnBzcMrc+Yh7uiwfnh1cQhYcj
    64naD4PAdIoJHj8AMSxJ+kIZZtW4LK1mc06PT4hpv3Sq5alDgVXVIqFI2iKtsRcbwcwIpp
    QAnw4rUP3lqTAmF+ZVs4PE9wZlsWwEMnD5GEEP02c5E8uZ2XLTfxHuoZfyzgn1+m+6Ub39
    tyozMT1GNUTqCl4TcSzS3TUOP78ZTYpQZa6F45TJuIme/N7JfohJtrnwMZvb0SrXFeiHow
    FUidrU29mjGNgQboZwQI4NoUKv1Z/1NqHk3dRc5C2dIInXwunUrlNuxVsBF7e8s6u48pLd
    ETrCc6L8ADxH29+K2pTOEKa98CoZixPbrzcQiPY9QeGZw8NfGTpL2Hejyf4w
X-ME-Proxy: <xmx:uuhoaswhWDiLnz47_s1N6sQQ3qCFxqzYL7xM7kgtvqH2VXJ14HDI8g>
    <xmx:uuhoapMF8D-AwbfHRvwsZh5U4UwHI1WrqBYWiXqMxJR20fJ1Jm_2Dw>
    <xmx:uuhoap658dGV6soBrI1a3_cWmw1W1fY8uKeJ0tjlpw6Ommf8jhIZKg>
    <xmx:uuhoaqk9yan55et6cygBw4kRA_98mMJolvpmBnZxFqPgMHoUE7BqIQ>
    <xmx:u-hoav8726bjt5B_6P-Swu6vE3FRZ5GzLB1PNBR50h9l3b00CA8DoMDi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 13:36:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Alan Stokes <alan@source.dev>,  Pablo Sabater
 <pabloosabaterr@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] cat-file: handle content request for --batch-command
 without type
In-Reply-To: <20260728150031.GA41931@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jul 2026 11:00:31 -0400")
References: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>
	<20260727095735.GA1153453@coredump.intra.peff.net>
	<DK9MX0YJ07S0.1TOBLIA6ZNSEN@gmail.com>
	<CAFZW3h3xyeJJwHfVK2mB2k1=e-0he9_gbTetJ1RdB2uUM1rp4A@mail.gmail.com>
	<20260728150031.GA41931@coredump.intra.peff.net>
Date: Tue, 28 Jul 2026 10:36:57 -0700
Message-ID: <xmqqjyqfdnie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We can fix it by tweaking the object_info on the fly as we receive each
> command. But we should be careful to restore it afterwards; otherwise a
> sequence of commands like:
>
>   contents $one
>   info $two
>   info $three
>
> will pay the type-lookup price for $two and $three when it does not need
> to. This wouldn't be incorrect, but just slightly inefficient (and hence
> there are no tests for that part, because the externally-visible
> behavior is the same).

Woooo, tricky.  I love this kind of attention to details.

The patch text obviously is correct.

Will queue and mark the topic for 'next'.  Thanks.


> Reported-by: Alan Stokes <alan@source.dev>
> Helped-by: Pablo Sabater <pabloosabaterr@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/cat-file.c  | 3 +++
>  t/t1006-cat-file.sh | 8 ++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1458dd76d6..ac458c9737 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -689,8 +689,11 @@ static void parse_cmd_contents(struct batch_options *opt,
>  			     struct strbuf *output,
>  			     struct expand_data *data)
>  {
> +	enum object_type *saved_typep = data->info.typep;
> +	data->info.typep = &data->type;
>  	opt->batch_mode = BATCH_MODE_CONTENTS;
>  	batch_one_object(line, output, opt, data);
> +	data->info.typep = saved_typep;
>  }
>  
>  static void parse_cmd_info(struct batch_options *opt,
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 762c77c351..f085738082 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1351,6 +1351,14 @@ test_expect_success 'batch-command flush without --buffer' '
>  	test_grep "^fatal:.*flush is only for --buffer mode.*" err
>  '
>  
> +test_expect_success 'batch-command contents auto-handles type' '
> +	echo "HEAD" |
> +		git cat-file --batch="%(objectname)" >expect &&
> +	echo "contents HEAD" |
> +		git cat-file --batch-command="%(objectname)" >actual &&
> +	test_cmp expect actual
> +'
> +
>  perl_script='
>  use warnings;
>  use strict;
