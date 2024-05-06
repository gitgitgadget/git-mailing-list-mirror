Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA291142913
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995025; cv=none; b=H3KtGLYAyLMD83znaFN7vdrWEOakrdU5DiE+j70SL6ExBQQPFZSTXQOmN2A8/ae+GjV21j4qnIqeg7eSgR1V9+0oAyRkahEdqhZktQouTqmgciaNLPePhaD7Pr9ck7UtL7+vimCjvRgnfY3n1f24O02cRCftnAnTwQ4PILBnZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995025; c=relaxed/simple;
	bh=Z7Qi7a4lTQzrREWsnLLUd8Wwj8x3fNHW9k7oUhAjArc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuXKPoXzzEvSdwe7WXbX5pmOvvZ0xil+KLhkuhQz9jDjvOoj1lcZmiwexnPy3EYE0FWDWaURdf/lbBrcIE1ykPpl3uTBC7wpP6VXjvP3DI3kiLZmha/3hazmFulTktaM16tUE3nChDzc0exXDN6RSMe3gkQAOY4LPYh5+nD7SLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9DMAC8/; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9DMAC8/"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22e6b61d652so940571fac.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714995023; x=1715599823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIWEeWvGbfqFKLJYscwrdvjhq6eDsn+SdMkLa5qhwac=;
        b=U9DMAC8/bNIYPuhhXu+QwQS1Qv3CHUpWEp0PHXHxs/B5LWsnSv4gFMHdUJzzVG6Nl2
         UixODZYoiAvZKL6Tp+3kgVrm1kCi7SvgZbr3/reb41RQv19zxrMSKabXNvki+5WwwIb8
         YC7CQ90BTQQM6E82eFdV2qmGnj/aSm1OV6jz2nTUkXaiDbHKVi1wk6nCNx0jpRcfR8fU
         2D6y3GcrfwhhAa+Mc1nnnmFu5MoDoXhlteBGa4GUkhepfsO0n/9nIS5F19+8A2Z68T5D
         mr1M4O2D20DGz3LEsNTFrpaV9t4xr1n9eUQRlcBE+DL1+Kgw6tG9lnenw6ljkCDt1Pby
         bZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714995023; x=1715599823;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIWEeWvGbfqFKLJYscwrdvjhq6eDsn+SdMkLa5qhwac=;
        b=pbCkKorD402suEeM+9oYSpyBAUsICbtOboBozELIrXl+Nr4Gl68I8E6vMBwLcEFjiw
         FUFtMG3jJVgpeJCQ2l9IQ0/YaZuNGOWRmdqUoRNWxA7Qs0mt8/NaCsj+zL58m5pT6PJM
         K2+pMkL/aj3zM0mwlqQR1sRUlH8gFYRCeZsoZ3FNkZlrknsMYUSzywL/e6R7CCmcrCWi
         J70Ws+LV3NRwJ8yC8OEATOekY0xm1GXTejwLfOBqOyc1IvbKyOzdoNcYpFLZmZlmbn9j
         WmiAJcXCjQWo57ory2w411brhMmUcJIp7fSg0E15gUgzADmFLhJojNkHYNU6KnXP/umy
         hGfA==
X-Forwarded-Encrypted: i=1; AJvYcCVjlvsBtAezQO/v/NH5hAkd15rfmIQf5Y/jxuFDJjl0cMPsZcMOasI2Z2KjLolwIrrC6nSdCxXU4izyNmabntwK/xdm
X-Gm-Message-State: AOJu0YyWGkTY+5Im91Cv9oR6XYyr8HSrbNCYE5QWhw0wdxwwBrfO78yQ
	yEbxWB3hT3LM1O3wx9jgg1MoDpGEGWKegfRQHcDcimbeDzd/bk9bz/jrZNsVU54Gd4r6zMQVvEC
	O8qdcKhApUXfk3MAEG4gFm6178eQ=
X-Google-Smtp-Source: AGHT+IG2jAtrtXIe4DsUi+N1X6eRuVuDc14cfcGTA+OTtwZ9VW4/sqE7pHAYA3finXAiXx9vaERuxJkfX1+9RbODdJE=
X-Received: by 2002:a05:6870:2198:b0:23e:65ab:a3da with SMTP id
 l24-20020a056870219800b0023e65aba3damr9969748oae.6.1714995022713; Mon, 06 May
 2024 04:30:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 04:30:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im> <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 04:30:21 -0700
Message-ID: <CAOLa=ZSK-DxT1J3ZwvaS1kSQS3f-B11yftb5-F5Wu718VQYUxw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] builtin/config: introduce subcommands
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Content-Type: multipart/mixed; boundary="0000000000001ef6750617c76551"

--0000000000001ef6750617c76551
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the fifth and hopefully last version of my patch sthat
> introduces subcommands into git-config(1).
>
> The only changes compared to v4 are some fixes to commit messages.
> Otherwise I'm not aware of any other feedback that would need to be
> addressed.
>
> Patrick
>
> Patrick Steinhardt (14):
>   config: clarify memory ownership when preparing comment strings
>   builtin/config: move option array around
>   builtin/config: move "fixed-value" option to correct group
>   builtin/config: use `OPT_CMDMODE()` to specify modes
>   builtin/config: pull out function to handle config location
>   builtin/config: pull out function to handle `--null`
>   builtin/config: introduce "list" subcommand
>   builtin/config: introduce "get" subcommand
>   builtin/config: introduce "set" subcommand
>   builtin/config: introduce "unset" subcommand
>   builtin/config: introduce "rename-section" subcommand
>   builtin/config: introduce "remove-section" subcommand
>   builtin/config: introduce "edit" subcommand
>   builtin/config: display subcommand help
>
>  Documentation/git-config.txt | 219 ++++++++-------
>  builtin/config.c             | 512 ++++++++++++++++++++++++++++-------
>  config.c                     |  16 +-
>  config.h                     |   2 +-
>  t/t0450/txt-help-mismatches  |   1 -
>  t/t1300-config.sh            | 432 +++++++++++++++++------------
>  6 files changed, 812 insertions(+), 370 deletions(-)
>
> Range-diff against v4:
>  1:  3aa26d5bff !  1:  881d2b5426 config: clarify memory ownership when preparing comment strings
>     @@ Commit message
>          not like this micro-optimization really matters. Thus, callers are now
>          always responsible for freeing the value.
>
>     +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
>     +
>       ## builtin/config.c ##
>      @@ builtin/config.c: static struct config_options config_options;
>       static int show_origin;
>  2:  8f0804ab48 =  2:  66dffaa8f2 builtin/config: move option array around
>  3:  ddcd8031d7 !  3:  36abda0e02 builtin/config: move "fixed-value" option to correct group
>     @@ Commit message
>          builtin/config: move "fixed-value" option to correct group
>
>          The `--fixed-value` option can be used to alter how the value-pattern
>     -    parameter is interpreted for the various submodes of git-config(1). But
>     -    while it is an option, it is currently listed as part of the submodes
>     -    group the command, which is wrong.
>     +    parameter is interpreted for the various actions of git-config(1). But
>     +    while it is an option, it is currently listed as part of the actions
>     +    group, which is wrong.
>
>          Move the option to the "Other" group, which hosts the various options
>          known to git-config(1).
>  4:  1bc3918840 =  4:  34b66f9c87 builtin/config: use `OPT_CMDMODE()` to specify modes
>  5:  3754812309 =  5:  4f90f206e7 builtin/config: pull out function to handle config location
>  6:  cb1714c493 =  6:  df1a6f14e6 builtin/config: pull out function to handle `--null`
>  7:  b3f3c3ba6a !  7:  1df76a9970 builtin/config: introduce "list" subcommand
>     @@ Commit message
>          builtin/config: introduce "list" subcommand
>
>          While git-config(1) has several modes, those modes are not exposed with
>     -    subcommands but instead by specifying e.g. `--unset` or `--list`. This
>     -    user interface is not really in line with how our more modern commands
>     -    work, where it is a lot more customary to say e.g. `git remote list`.
>     -    Furthermore, to add to the confusion, git-config(1) also allows the user
>     -    to request modes implicitly by just specifying the correct number of
>     -    arguments. Thus, `git config foo.bar` will retrieve the value of
>     -    "foo.bar" while `git config foo.bar baz` will set it to "baz".
>     +    subcommands but instead by specifying action flags like `--unset` or
>     +    `--list`. This user interface is not really in line with how our more
>     +    modern commands work, where it is a lot more customary to say e.g. `git
>     +    remote list`. Furthermore, to add to the confusion, git-config(1) also
>     +    allows the user to request modes implicitly by just specifying the
>     +    correct number of arguments. Thus, `git config foo.bar` will retrieve
>     +    the value of "foo.bar" while `git config foo.bar baz` will set it to
>     +    "baz".
>
>          Overall, this makes for a confusing interface that could really use a
>          makeover. It hurts discoverability of what you can do with git-config(1)
>  8:  0e6da909ac =  8:  29676b81e0 builtin/config: introduce "get" subcommand
>  9:  8a623a31b9 =  9:  94afb5a5b7 builtin/config: introduce "set" subcommand
> 10:  e25e5b69cd = 10:  e525c2326a builtin/config: introduce "unset" subcommand
> 11:  f24008d356 = 11:  a797889890 builtin/config: introduce "rename-section" subcommand
> 12:  fc2ddd3201 = 12:  8ec214755e builtin/config: introduce "remove-section" subcommand
> 13:  4c2d817eff = 13:  1893c23afc builtin/config: introduce "edit" subcommand
> 14:  4c351b12b8 = 14:  97a48ab81d builtin/config: display subcommand help
>
> base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
> --
> 2.45.0

The range diff looks good. Overall I have nothing more to add to this
series.

Thanks
Karthik

--0000000000001ef6750617c76551
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 21c10c8cf1e60669_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNHYwd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNC9NQy85bTNaMExLUHlhZDRYZHQrNjVCYXU4eVJNbQo2RjdSbnpPOTh1
SnFQWHdvQ1ZOc3JzaHIxVEgrY2hldHNQM1FDcWtadCtwVlg0cWovV2lCQ0tScXVTd0ZtR29HCjY1
RUZuNHRvakxxQUU3S3ZXemdEYWk4cm51WVhoc0xJQ29uN0Mwa2l0bUlDRGIrckppMG90OVlZTTdO
aHZqMksKUCtmWFR3djJrMTZta24xbEN4SkVyd2dMY1VoOE9GSTlNbEljL3AzRi9lVGRuQWMwS1ZC
ZnVyQ3dhZzJWaGd2UgowZ1VFbmJoRXFPazN5OTRwZ1JZNkJXbGhlcGIwbHVBOVJNNFl3TkIxWHRW
SS85azhINlF6YTV2bUZjd3FyRUFQCm5Zb3VmZHdlSGs3TXljeWlsNGE2eEIxYmxCZzBBTEZkcU82
emZyVm42YjVoMjNOb2tKNTdkS1oySTYrY082UkEKeDMxeXl6eGlIVzJKMEhyMno4YzhPTkxoclZZ
b0FkZ3ZWdGZ2eVNVOGo2Nnl4Q0VnaGxqVWRJcDJyU2F5RlBVawpEM0dRT0Y4d042U0x3eGYwQ25G
K2RXa083Znpkb2tYNS9LanovcUhMWXJPZVlOajBhejFJOUVwNEdLaTJKWlJ3CjlmczJacW04TVJs
c0VERitSNERRNUZDNWovSWhIVGUwa3lQTm1sST0KPWJWdG0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001ef6750617c76551--
