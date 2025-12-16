Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF81509AB
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844255; cv=none; b=ldYHraGrEwh3L4Qulw7axqP/xJ6bfyTcrWd3pP0lnj8I198e6jyEVBKRwBhjfzbwGuMZGiguXvFEGXzNeUhKYIFfwrIV4/8w81NK06Tmk5uVlGHWTWNFDYrhvzsjo3bCCOwIViYn695PLpQxrzCU6ysm4uKqS5uAy/8fymKlADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844255; c=relaxed/simple;
	bh=xgEMj/l30qB3ZOz30fKWlOsrz/IGHL9gtLYAyVJr5m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHZsfcZx7ayPYbbnMyI52igHp8TN7n+8yAbgNHXTsmVew977MTRyUSzAgOdc514aWRkU7xzMRtAWI5rkGXSStDgafuzIHafuoIx8ZGEMZjhFbD18XpZL0aXTdcrhwGupS7XPs+hWrSenw6frtd/I9OiQRanAVF8LCEljclStnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irjC/i6o; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irjC/i6o"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7cac9225485so3753594a34.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844253; x=1766449053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/54xprmoZkTDV8wsSxVP/rQzWpgHmJl2xqGqnT3Ejc=;
        b=irjC/i6oub/f8eYWOqi1uIk/BAUmksNJqpJM6+A4bisXSdVOeeaM9t19symat6/Bo0
         7oixPl/PiQkbigHAfzXAZwFtBH1zohZdFxfelfgOzMHrSFeNwtSqRKM0UPnRLFZxjn2p
         2veEBiND7PjbPDRPJc4ClsUdIl2FZjbykUhoeUaGZ19CHdnGBEoSFkpO0GeCwDyz7Vy7
         JSL4evBTk/baIdd7NA81WYv4pVk6kr8Ii9JOviQf9zUE0noY7XmkSHYAGU7eRXf3uldi
         9vk2lSnVVQDlYGD6NAhhYdMF+g4+o0q6Y+HSKcJDVVF9UL+5/SKYplaITPPsXd0eaFVk
         no7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844253; x=1766449053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/54xprmoZkTDV8wsSxVP/rQzWpgHmJl2xqGqnT3Ejc=;
        b=xRwwHGKJ4sd7HerQrRQdEpMQHYni7Fw0PgCdUy/yUIAyYMCefeXRVnB/f3mLgn0Qbk
         nvXqQNAxSGdofm7PRIvwtQWFqY6yPEuSAnZA7NWDSB/qUOLumyQj6ozGmw7LM3Lu45d8
         jWbGEaVBl4tqz7iLXheR1MqQBjIYEVXbd9OvW1ZNuICa0HpB4YOLOxKZmjOzpH3uXorB
         eAYgp296q05ODrqv/H5ON+2iJzzUAZCmFKLrmBPJe7ktC8aW/jMe85iBNVFBQWdazpxn
         R52+17ZvVsqbKlB188CgpkMZObD0QJ5d98l492CisakJZtUjVs78yAMdiktHrJ+LO2Zz
         rdmw==
X-Forwarded-Encrypted: i=1; AJvYcCUA5x547OAcTrOhIvqzgefxvJiLkxUgTnikynGfD4GD2gSLXEmPN8XdrykFZge00W/+O4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1BS2NYfL4R9i93IctSaXGzQKLnkaL5jXRJ4kPTT80k7Ul0Vz
	+330SKg/WMXoDkS5mirgUlEQlEAmxqbppRyGrkN4QhYUpTJLZZZlqm+ZbFux5LriWZIPTn0rUQV
	fyRECPPWHO3ahdIfzghuI8KmFG8VMUVhpeXwb
X-Gm-Gg: AY/fxX6p0zVMa3qCDN560kJpJNb25Wp52aonP9/DP7FQIAat4pkCCHlxpzPtoF4ZHx6
	RzxGrnwoaqeHI/k08mDWtFb2ddiUkGDDId4oYSyH6r5eAJdjyHnJC9SV91z1u/zRIcKC5/HMXS9
	8BhgJ1JdRmliw3S8dqokq1ODU6T69Fqs36SK4UBMNd4hd2SRpEAHFfMA6McnHOkYWJpocPGmG1N
	Opr9Vi0enFsAQxK7T3R3dOfiKjfSoTkdXhU1Q33nEHXGtkGMGNIoVFqEL+T/qN9zzyfi5nlqy2s
	xi2Lm0M4wey+gF4Z9vacfFy8Lu4xG1TT4GohbqM=
X-Google-Smtp-Source: AGHT+IEa+YOszLRhtzA33eMPpz7aDZ0U4jZCx6vDQtxrbHd0FCVEf32LPeMd0YKcuwkEYU7TZ6rsyR/JIph8ontiGyI=
X-Received: by 2002:a05:6820:1894:b0:659:9a49:8f3f with SMTP id
 006d021491bc7-65b4524bb1amr5783145eaf.80.1765844252630; Mon, 15 Dec 2025
 16:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
 <aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local> <xmqqsedc8w7k.fsf@gitster.g>
 <aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net> <xmqqldj48pyl.fsf@gitster.g>
In-Reply-To: <xmqqldj48pyl.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 15 Dec 2025 16:17:21 -0800
X-Gm-Features: AQt7F2rrImDxNJrep-EZhBN6x_FnyLdVHHW1tcnUqSenjA2Z3ZFzgGW5CHy-zws
Message-ID: <CABPp-BGCwjTBEi4wkg=065QofiO9ZL+9XVCCcTiHriXqgH1Szw@mail.gmail.com>
Subject: Re: Would it make sense to add a commit.signOff config?
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	=?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 6:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I think this would be a fine approach or we could add an entry in the
> > Git FAQ (or both).  I agree that this is something that comes up
> > frequently and writing it down in a more visible way would be kinder to
> > users and mailing list participants.
>
> Something like this, then?
>
> ---- >8 ----
> Subject: [PATCH] document that foo.signoff will not be added
>
> Every now and then we see this coming up on the list.  Let's help
> new contributors who are not aware of past discussions by clearly
> documenting our past consensus.
>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/gitfaq.adoc         | 15 +++++++++++++++
>  Documentation/signoff-option.adoc | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git c/Documentation/gitfaq.adoc w/Documentation/gitfaq.adoc
> index f2917d142c..656093047a 100644
> --- c/Documentation/gitfaq.adoc
> +++ w/Documentation/gitfaq.adoc
> @@ -83,6 +83,21 @@ Windows would be the configuration `"C:\Program Files\=
Vim\gvim.exe" --nofork`,
>  which quotes the filename with spaces and specifies the `--nofork` optio=
n to
>  avoid backgrounding the process.
>
> +[[sign-off]]
> +Why not have `commit.signoff` and other configuration variables?::
> +       As it makes it harder to argue against one who tells the court
> +       "the log message of the commit ends with a Signed-off-by
> +       trailer by person X, but it is very plausible that it was done
> +       by inertia without person X really intending to certify what
> +       DCO says, hence the Signed-off-by trailer is meaningless", if
> +       we add more publicized ways to add sign-off automatically, Git
> +       does not (and will not) have a configuration variable to
> +       enable the `--signoff` command line option it by default.

This feels kind of hard to parse for me.  Maybe it's just the lack of
sentence breaks, particularly near the end.  Let me take a stab at an
alternative:

Git intentionally does not (and will not) provide a configuration variable,
such as `commit.signoff`, to automatically add `--signoff` by default.
The reason is to protect the legal and intentional significance of a sign-o=
ff.
If there were more automated and widely publicized ways for sign-offs to be
appended, it would become easier for someone to argue later that a
"Signed-off-by" trailer was just added out of habit or by automation,
without the committer's full awareness or intent to certify their agreement
with the Developer Certificate of Origin (DCO) or a similar statement.
This would weaken the sign-off=E2=80=99s value and could undermine its cred=
ibility
in legal or contractual situations. To uphold the integrity of a sign-off,
Git only adds it when explicitly requested, rather than through automatic
configuration settings.

Maybe the last sentence or two are a bit redundant and could be
stricken.  Anyway, thoughts?

> ++
> +There exists `format.signoff`, but that is a historical mistake, and
> +it is not an excuse to pile on more mistakes of the same kind on top.
> +
> +
>  Credentials
>  -----------
>
> diff --git c/Documentation/signoff-option.adoc w/Documentation/signoff-op=
tion.adoc
> index cddfb225d1..0b869dfbe4 100644
> --- c/Documentation/signoff-option.adoc
> +++ w/Documentation/signoff-option.adoc
> @@ -16,3 +16,15 @@ endif::git-commit[]
>  +
>  The `--no-signoff` option can be used to countermand an earlier `--signo=
ff`
>  option on the command line.
> ++
> +As it makes it harder to argue against one who tells the court "the
> +log message of the commit ends with a Signed-off-by trailer by person
> +X, but it is very plausible that it was done by inertia without person
> +X really intending to certify what DCO says, hence the Signed-off-by
> +trailer is meaningless", if we add more publicized ways to add
> +sign-off automatically, Git does not (and will not) have a
> +configuration variable to enable the `--signoff` command line option
> +it by default.
> ++
> +There exists `format.signoff`, but that is a historical mistake, and
> +it is not an excuse to pile on more mistakes of the same kind on top.

This feels like it's missing context (it'll take the reader a while to
figure out why the paragraphs are there and that the two are related),
and isn't as helpful to someone just trying to understand which
command line flags exist and what they do.  Maybe combine the two new
paragraphs?  Or, perhaps just a shorter version that just refers to
the FAQ?  The latter might be something like:

Git does not (and will not) have a configuration variable to enable
the `--signoff` command line option by default; see the
`commit.signoff` entry in the gitfaq for more details.
(`format.signoff`, is an exception, but it was a historical mistake,
not an excuse to pile on more mistakes.)
