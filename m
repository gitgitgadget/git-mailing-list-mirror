Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176818C18
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OEbpct2f"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2E4C2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698682362; x=1699287162; i=l.s.r@web.de;
	bh=jgtFJ0LZhi973VgqDoXtUS4BW834ZRPBAfe2z4rvX8M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=OEbpct2fwNx7kfvP5Zj20BBTSau3lNqK8KQVLNX/QYd7SGHCo6qZIn7JqstR8Gh3
	 OlK0g584xt74apTTsGlg6BnsYQl19yU3LANmMWOv3a6JzIhr6SrWBNLSxF1K3Obsb
	 rfKqgvbQJcG6Mqvq1l7Q18cwtYDOQxTH8GmBOObLoITd1savjGA0obVKnSgH08EI1
	 RYAzUL1YgxPtvQhHxI5AVdR68rIZ9F1v96lEzkiU0LCEWzkEb8cVe7vzk7pztT5oF
	 nN6trG/cKZkfLI6Va/z+UY5VqjE/TYzkg9xwEcdaYFpROC6VTnXyH4dfV/dk2oMD1
	 6drFuNHnh6z2+Sp2cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1rAKlP2ge9-00M1Ju; Mon, 30
 Oct 2023 17:12:42 +0100
Message-ID: <82b832cb-da0b-47cf-9b5d-e8011a222151@web.de>
Date: Mon, 30 Oct 2023 17:12:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reflog: fix expire --single-worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
References: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>
 <xmqqa5s1hxhh.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqa5s1hxhh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YXRkC0h5Db1aSvaC9zJD5RsEE87Oluwufvss0/e30lyfri+uLTB
 xLjQ/FEE4/nXStjwp+hCU6uzpS/Af3TPS3o1cPsMtyKjZ2vBWLoKwlGJsVwAfgVCM+IxLpx
 xYmIxFC706BGOioQGhhCGZwDhS/12wqBpn9xCufLjOXz+RxZRu9hKhJhL1apeW67qO0BT7d
 96obUES2xAu14Hne0hZ1w==
UI-OutboundReport: notjunk:1;M01:P0:fXvYL34VtBg=;5nVKYmykpqkVhAw7wZkEEhTPVVi
 wQGgITiCQR4sfLalDjJqEkofP7/US8WwmOtsEUPONhDN3i+2gUOljGHjPrSGHfwlFGSsS+nqs
 SoIywZk7wXsJ1MQe5fL94qJ5P/qO8clQYEXw6olb+T/Ofcb9oUVnA8s2s3t3gtPonVpIsLk8m
 3CG+pjb3rkq4GzQsyUvvkpl7G+lylYgyt2eIJahIsiVJ4ufDwy7eThOrbFQ3A3nbVoRGUZvZI
 XDAo9f7YLMiHSmgQD777ri1idMhvgo3YXu0c6Gr0ScFKEQHogHXTGeVWgK7qA93Idqg/bMXMd
 zkvfFcq8X/5x4u1UUgW0TtZnubKA2ZXIu9iE5WZ8nM9UpUuxtPkZJer88dSvKH0O9SW9QDuYZ
 lfJgZkVvlhi/wNapmSt50qw8ZRJvZf/6Uhkx00NtItCpTNop9x2EEyEzLCIdicnBN+VK6tleS
 7kzlhEg6KOzHTzuwktf36dZdgm5+jEfQdON16+BDnPeDCLus6IrjNVETPGZMYYAtM+K2xjan7
 QjU5VMpMPgtzxFvIZxYTzax23fLsNGRBN9XV1KaoKDPfRUwnJVxN7vX3ItAhPEWhsVW3wlcdG
 7tZ6hdoBC1+UMK7bRkK4rAYcXd7nxcHhN0AD9Q6SkSaIKeY1kLrExTP81jOwLKRJceS+hIsap
 viWzgI1VQmY/F3P4MxaI6NQ+Oal1Zzqlm1H3R8jJlqdNSuIsSPKVdkZvk1IImlPyruPfYwr0Y
 enTN9Sf1Vuy8u1KPup5av8zb4WssEqEJmUhGVHc+cQPJOtuGJ7VohW3I+Urb8JYnObiVBuXQe
 +ihr6f0e3PMY7UqdKiQmreZ8dTAjxExq4eUodWDqizUn8NzNaHkFltP6bqCHlK6Vq5Uhx/Yw1
 L+Rtnit1G+S1fTUfliTQnYry/qtPTd3Lg2ZVRGCDHwemsGK8YTkNmwNjQiyqFvIU3+Bmw3mnl
 nCe9fg==

Am 29.10.23 um 23:31 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> ... and added a non-printable short flag for it, presumably by
>> accident.
>
> Very well spotted.
>
> FWIW, with the following patch on top of this patch, all tests pass
> (and without your fix, of course this notices the "\001" and breaks
> numerous tests that use "git reflog").  So you seem to have found
> the only one broken instance (among those that are tested, anyway).
>
>  parse-options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git i/parse-options.c w/parse-options.c
> index 093eaf2db8..be8bedba29 100644
> --- i/parse-options.c
> +++ w/parse-options.c
> @@ -469,7 +469,8 @@ static void parse_options_check(const struct option =
*opts)
>  			optbug(opts, "uses incompatible flags "
>  			       "LASTARG_DEFAULT and OPTARG");
>  		if (opts->short_name) {
> -			if (0x7F <=3D opts->short_name)
> +			if (opts->short_name &&
> +			    (opts->short_name < 0x21 || 0x7F <=3D opts->short_name))

Good idea.  This is equivalent to !isprint(opts->short_name), which I
find to be more readable here.  Seeing why "char short_opts[128];" a
few lines up is big enough would become a bit harder, though.

>  				optbug(opts, "invalid short name");
>  			else if (short_opts[opts->short_name]++)
>  				optbug(opts, "short name already used");
