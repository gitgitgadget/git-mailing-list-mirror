Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF98320CD6
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981680; cv=none; b=IleKPn52XOrGrKyd6C2bath7dCWbd8tWsUo+kCY/KcWvDPYrNrIxBO8w4v2zwmOwQQ5imWxhJkMjl/9sGuaSEPZnXWP+Gff1i533nlJe/Pt1kOtlZv8kq1TS4Tjj306l4IMUAzGl1D8t5AcIH7QpBYMRWZt5Oxvl3prIRFwdzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981680; c=relaxed/simple;
	bh=S1cCaebnXEDl851XEXynfp4iVOnqhlPZFJ95zVGFtFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XOjhtmOGCU6xwF5ukRpkkOl6aj/QZghfznIhqMkWeWyFdLyaa33WFmYRvlx+rHwJWzXHgGqFuaR90RyYiODM9CgpgEXMniF8e7q0qHkgkECyz/h7Ct03jSkmOy7GFFkjwvC1IulnfJMT1w6DdmTVSORGwa2wjw2QqbfEp/rKu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=p/QO5TFm; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="p/QO5TFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767981670; x=1768586470; i=l.s.r@web.de;
	bh=ZUKDLm7+FlsdwMj3OEH0XZ+YBDcDjseYrZPdmAi+J7s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p/QO5TFmawL/Dj8cWELweR+DBpxCDXFUkMU08JUyrxD+ZBEew1fh6vnhxW2UmO0M
	 4GeH86YbMzpis6NWWz32CeuKB7vkb6begfw6pDXgYwBENNEBGYOf5jODmGH8V5g8O
	 k70ejATA+8Qm+tGbKkyuZllrNEohCJqZqlQC49yCCUZpMbsrZHJd3sKXQcJgWB/fB
	 6vylcqcozRoTRn/gcc6Q88txP11+04wezR9L89Q2YD+I5ObXSNxtvYCFaQzdggXdb
	 YNeMctyIxXJ7iw/FE9lFiTQn6H8mSEdlzsn4yP+ZwWizxH/fnoYHYzrdjHmrJc2Cl
	 QbOAn46emOlqcnp6ug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoecP-1wBBy32eoD-00phlE; Fri, 09
 Jan 2026 19:01:10 +0100
Message-ID: <0a5c058c-e5cb-41c9-8788-6dc6354f9119@web.de>
Date: Fri, 9 Jan 2026 19:01:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] utf8.c: Enable workaround for iconv under macOS
 14/15
To: tboegi@web.de, git@vger.kernel.org
References: <20260108174012.471706-1-tboegi@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260108174012.471706-1-tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tth8BmzKWkBDfzg3P4hDnCe+zGlaQfLuReXIQ22pI3c40HM1JBU
 hWKMMAEOdkg6MTQN1Xib0/dahbbhlXolhsYsi+zUW7BCtcnkWzD/afATwDl0DfjJdxbfmMo
 eShSS/KTu4Qe+Pv0hxCjwyvdPAjOYPRpox5TCscVcio8YDiwNMMMiTzzmEHnvQysh9lY3i4
 XrCCRN35kXlYnkn2KXSRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dgvutf3+lOU=;FSRuHMgq0Bbpw4TYJruOhqmK7DY
 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
 QnHq7d/M=

On 1/8/26 6:40 PM, tboegi@web.de wrote:
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> The previous commit introduced a workaround in utf8.c to deal
> with broken iconv implementations.
>=20
> It is enabled when
>   A MacOS version is used that has a buggy iconv library and
>   there is no external library provided (and linked against)
>   from neither MacPorts nor Homebrew.

Odd style.  Make "A" lowercase, remove the line break after "when" and
unindent?

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Makefile         | 7 +++++++
>  config.mak.uname | 1 +
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index b7eba509c6..5a3823bb67 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1692,6 +1692,7 @@ ifeq ($(uname_S),Darwin)
>                  ifeq ($(shell test -d /opt/local/lib && echo y),y)
>  			BASIC_CFLAGS +=3D -I/opt/local/include
>  			BASIC_LDFLAGS +=3D -L/opt/local/lib
> +			HAS_GOOD_LIBICONV =3D Yes

This doesn't check whether libiconv was actually installed via MacPorts,
so technically that's more of a "Maybe?", no?

>                  endif
>          endif
>          ifndef NO_APPLE_COMMON_CRYPTO
> @@ -1714,6 +1715,7 @@ endif
>  ifdef USE_HOMEBREW_LIBICONV
>  ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/libiconv && echo y),y)
>  	ICONVDIR ?=3D $(HOMEBREW_PREFIX)/opt/libiconv
> +	HAS_GOOD_LIBICONV =3D Yes

Looks good.

>  endif
>  endif
>  endif
> @@ -1859,6 +1861,11 @@ ifndef NO_ICONV
>                  endif
>  		EXTLIBS +=3D $(ICONV_LINK) -liconv
>          endif
> +        ifdef NEEDS_GOOD_LIBICONV
> +        ifndef HAS_GOOD_LIBICONV

"GOOD" is quite vague.  There's already ICONV_OMITS_BOM, and I wouldn't
be surprised if we discover the need for some other workarounds soon.
How about naming the make variables after the C macro to be more clear
and specific?

Can we get away with a single make variable?  Set it in config.mak.uname
on affected systems and set it to empty if we detect that a 3rd party
libiconv is used?

> +                BASIC_CFLAGS +=3D -DICONV_RESTART_RESET
> +        endif
> +        endif
>  endif
>  ifdef ICONV_OMITS_BOM
>  	BASIC_CFLAGS +=3D -DICONV_OMITS_BOM
> diff --git a/config.mak.uname b/config.mak.uname
> index 38b35af366..3c35ae33a3 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -157,6 +157,7 @@ ifeq ($(uname_S),Darwin)
>          endif
>          ifeq ($(shell test "$(DARWIN_MAJOR_VERSION)" -ge 24 && echo 1),=
1)
>  		USE_HOMEBREW_LIBICONV =3D UnfortunatelyYes
> +		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
>          endif
> =20
>  	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require

