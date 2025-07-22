Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32D2BEFE3
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176415; cv=none; b=gaoyCLvlDoRPTv+7geCrdUI4nX5KsIhWuRfte6yli4dfZPriBXroqcrjHfsSH7n4ipxKVDwHN+UuWPtj7vbXAE1aoPtGm6bojL8MGxEKAhZhH3Fbh7GnSyIjnlG/mZdrQY0rBPTMoOlxQzwUqtmAnAcyvwx9kbKtc97chB1h104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176415; c=relaxed/simple;
	bh=lMBugWP9Gd3B3k4s/6onQHNUXsGPO+iBg1OjmtG5XlQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+HcSjOVizNub8Bb+kQOuB9HypHStkNGh9xGNzaoDY9BAENqyelMWCuBzSfv27Z/M1IwxIz+2tFl5mNbjEDPsMLM641pR91rq5NrwUHWjBuGHmZzH9uKvfKmeEIS+b+ZV3QBTFdEmiriR52X3P/OLl3cc4Z+KwN8P+9oqMYilbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK4lzAtL; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK4lzAtL"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4f2efa7524dso429555137.3
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753176412; x=1753781212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytma/9T1gf3P7e1fMAz0dBR6TUM7kBtcY3eJnf5oGqk=;
        b=fK4lzAtLBvuuuQETjdyMntC7zMkAnw5dlHzYW1RJpkVEGQIF9MUabB0zwV/d9Cmr7+
         MFqmqNIjD+5mas5OQokbICNvE2cf6SPZghUimTPwt4OPK52koWUkKgo6/FmktqSI4ifz
         ZOo0GFyVQHky+70YFIejz2JI3nAvUOW5/NO2gi2v3miFoXvo1R1uzX2rXpFslZZeyjo3
         VpwM2bJaXR9PEbQpMv1/1wa/y/8I49mcWar1Z/7Ae6ZEqIQ+E6SwEbedLRzQi77PiCHZ
         4SHlzWEX8/mMiGr06ZiXiNCcGKUkhaJXixNLaiVsmEFyzwxlzIJgCbBVvqK8ZJd3IIds
         3COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176412; x=1753781212;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytma/9T1gf3P7e1fMAz0dBR6TUM7kBtcY3eJnf5oGqk=;
        b=rjr4J/GO+omivkzVPJZrDfDW4eE3h3k4a6b6SME1xXIYUTvZ8cCr2TlgsANdi432ie
         WoWz8zVT9+4F2KUKPsfJOp+sny2fMURDthd85wZDfKwP6o3PftzVJD1+z8lltPYBs4ma
         qjCvpgvJadwqFCg2ZfZp5HG4OeBIC3y8Vq0M1f+7IJLAj11kje+wtBJTzpF/x2K3qZat
         XiTFPR6sxlZ6QnjGNG2P63VeaRSwZqDVURazM3J0bsuKhlGTR9sXKaJb/8PmPBS8pr7V
         Z2SjPQ8xajwrD/HPb1AtgJEqTH3GGcvdRmLu3tDaSFQa+nNQmAd0TJ7opsJu6jU6oA9C
         Ny0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTpAucsF3EB8JotyLlcL0Z+7hsVfAAN0zOnE+lBlwPRq6RUl6oDKmAYzW+GB/FU5NPHUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhTlodAo7e/WwS0YZ2QdKqACntqziwVhIE6H/wC8oVL8wElDo
	K8G0o7wM8Fx2d3tL6sL5e/amzgKmE4sPS5t6dDrlpKA7QN5mpb6OKbVDiH/Gn0UkDBcIbhYlDqb
	OAYjS1gbflJNfxVTAXnAXZADfWK8BSoo=
X-Gm-Gg: ASbGnctbwbmRtXG/TopbzRuOyqrteHFyIdQLfrs3miApwCXkjYDe/VvSB4JXPBmuEmj
	fca0ejS2Uev98YXkwo1fqKNJq3H9tKNWHYr1fj/rCiXqlwzkPphXMesihBzmUtvmxU0o3IqYH/r
	zDu2uvW50z8qPDyeKDur3LIzAQC4N8lgit2i16m9vVbnoMIq+YifQINgLPkls3bqtgxzvxbL0Bt
	7hI0O62q0nFbn6E
X-Google-Smtp-Source: AGHT+IF9aKjdSLd7Bn0yjDDiHNt97h62nEaVCRnYXl3hCSwYsi235C+XT1eG4R2tFRv2mz5zgJhHGx1MZBIFKRG3ShM=
X-Received: by 2002:a05:6102:3310:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-4f9980fb4fdmr9575498137.16.1753176412295; Tue, 22 Jul 2025
 02:26:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 04:26:51 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 04:26:51 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250722002835.33428-6-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com> <20250722002835.33428-6-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Jul 2025 04:26:51 -0500
X-Gm-Features: Ac12FXy6UyTh1CWMOD3nFOi6o5gY-Yb7kxX2vf3BsjKjFOVok4K_i_YMoj9UMWk
Message-ID: <CAOLa=ZThUFbTyqNXYm=vRtwaoqu4y+Mc24VvQ-QA4-HzhcSo3g@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, ben.knoble@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="00000000000048d1b3063a8131bc"

--00000000000048d1b3063a8131bc
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the --format flag to git-repo-info. By using this flag, the users
> can choose the format for obtaining the data they requested.
>
> Given that this command can be used for generating input for another

Nit: s/another/other

> applications and for being read by end users, it requires at least two
> formats: one for being read by humans and other for being read by
> machines. Some other Git commands also have two output formats, notably
> git-config which was the inspiration for the two formats that were
> chosen here:
>
> - keyvalue, where the retrieved data is printed one per line, using =
>   for delimiting the key and the value. This is the default format,
>   targeted for end users.
> - null, where the retrieved data is separated by null characters, using
>   the newline character for delimiting the key and the value. This
>   format is targeted for being read by machines.
>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc | 13 +++++++++-
>  builtin/repo.c              | 49 ++++++++++++++++++++++++++++++++++---
>  t/t1900-repo.sh             | 13 ++++++++--
>  3 files changed, 68 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 375b956d3f..5bdc3831a7 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -18,10 +18,21 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>
>  COMMANDS
>  --------
> -info [<key>...]::
> +info [--format=<format>] [<key>...]::
>  	Retrieve metadata-related information about the current repository. Only
>  	the requested data will be returned based on their keys (see "INFO KEYS"
>  	section below).
> ++
> +The output format can be chosen through the flag `--format`. Two formats are
> +supported:
> ++

It's hard to know where the documentation for '--format' starts from,
perhaps we can take a note from how 'Documentation/git-refs.adoc' does
this?

[snip]

>  int cmd_repo(int argc, const char **argv, const char *prefix,
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index c46ace1fd3..fdd3491429 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -20,11 +20,20 @@ test_repo_info () {
>  	key=$3
>  	expected_value=$4
>
> -	test_expect_success "$label" '
> +	test_expect_success "null-terminated: $label" '
> +		test_when_finished "rm -rf repo" &&
> +		eval "$init_command" &&
> +		echo "$expected_value" | lf_to_nul >expected &&
> +		git -C repo repo info --format=null "$key" >output &&
> +		tail -n 1 output >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "key-value: $label" '
>  		test_when_finished "rm -rf repo" &&
>  		eval "$init_command" &&
>  		echo "$expected_value" >expected &&
> -		git -C repo repo info "$key" >output &&
> +		git -C repo repo info --format=keyvalue "$key" >output &&
>  		cut -d "=" -f 2 <output >actual &&
>  		test_cmp expected actual
>  	'

Shouldn't we also test for invalid format? Also perhaps invalid key in
the first commit too.

--00000000000048d1b3063a8131bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a9c024f0b53e9e28_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oL1dWa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2F5Qy85b0hwM1dlT1ZSVnVYcjBRdTg3a1Z5aUVFQgpsbGhaTGR0YU4v
eVdZRTVqTkViYWdDZ2NseGNraW5ybUtpYjVzNWRaLzdMUUlXWEt3enVGSDBic3AwdE1MaHBPCmsv
bCtmMW1ScGNhTU1lRlpNM3JQVEl1S2Z2VUppUHFDWXJmWEpNSlJVbHpTZ2w5WHViK2k2R1RqbTM3
Z0taRWMKSlU4djFUeEN5aVNuSW5HVGdSa25MMGdYNVo2NnFRZjVUWWRYZ2FyUFJKUXE3Zlc1ZWNt
dkJ2OUpGUDV3RmJsVgpISE1FcUpkL1Fzd3JLL0ZOQ1RhNi90bTlOYXc2V2JvTkUxUGtwWm0vWTE0
ODdZbDBOd25tM2pPSERtRFo4b0Q1CnpiM2FIcWR6bmlkZ0VPdHA1K1VhNk0yMXRHekRmVXNVVmRq
YXVjN0pmekQ1dVlMWFZrU1lwN2MrWGpHLy8rQlMKS09oT3IvQ1pySFRrSWlJVDcrQTBoMFNUNlJO
eTBSdDNBQUZhOEFQbDZBL0xpVnYyVkdXQ0ExcVljbFVIZTQrKwpOdWh3dXB0L2lVWW5keXhnckpU
YkNLU1NCd29EeVYzYU4wRGg4OXNvWVZkYVhuOE5WeU16eEFvYW5LMDN3OGk1Ci9lMXI0NG5Qd3U4
bjA2STBlc2ZyM25pVE1yVU1NMWV3dmJPZ0NaND0KPTdiekQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000048d1b3063a8131bc--
