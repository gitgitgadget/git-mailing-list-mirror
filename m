Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF218DF89
	for <git@vger.kernel.org>; Sat, 31 May 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748725260; cv=none; b=LdITGFenbiwxigiHt17qAW4mTZWzqCOQw2uX7/Mn5l37K3KgpXeaPUGQocATLhWmxUkQ682aR/5XuVsgd+jWiyRxwJw9j1mL1zyEIhL7LzQEKdotBFPD44zgRNVdc42WJQOEb2GIGT4zQk49pHhU463FV7D8qrEbesbF7q88YXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748725260; c=relaxed/simple;
	bh=wzPJtNjJaZ+MB9SCjcnZ1+I0DC1Q4D3BcKtqUkQhRVQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5SrngwSPtgxxX2FLFOfLr+rUxzq26TrEXfHGiC1QkV7KP/EuLapsCVrwvvlfj/mEYiAdoCl4PgyGi3jBKev8Gk43Qiv7lWkBxmiNYvPFQJK+DxAa8qsWkS4/VSYE6Mjtx5M3/u3uwtyrvrdZihH91nNS0YtpcyImfSurFQu0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCGL1JJ9; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCGL1JJ9"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e7004fa2c0so262271137.2
        for <git@vger.kernel.org>; Sat, 31 May 2025 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748725258; x=1749330058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RY/MRfJl2qpOCMZ51oWv7QeXTC4dPAY3oXrb8Daso9w=;
        b=LCGL1JJ9c7Zo4HjxZBT8TD7RBI7WkYtVRTSp2t12yYP/3lEnuPZGk3hSrneleKR8u+
         mhXczWPvCuulkod0byIo/91r2WlrrRnCQcBG3+O6XVOcCHdqM7O4cDNQe05jq0/1sB++
         GA5JuorH/19uuPa6j2VxWYYYHeSbJpqe9syX/gsR6p7IgUsg/j7rF7SIFMVkHkbAbnZm
         QeEp8JmdG2klpdK8K3TUs4uZmpABsTqQhyQHe4uSBK7PGNbrnJXHUNUSCCOxYH0DOOq2
         g4vhuVxjW0IIujIqY4+c/pLvzi25DHlmYYaYayNxWEq7g/7yUsgZZuaq9QlfaqVSulJK
         CQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748725258; x=1749330058;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY/MRfJl2qpOCMZ51oWv7QeXTC4dPAY3oXrb8Daso9w=;
        b=wganX+scf5uSevm54R7jmzLqd+rafjTOhOluSWnGLeqcSBtVE1nlcD07w51bQaO1xB
         MItUza1g8vvocGr8fzTGqj5V2MA7FxvibIOkuUxcAXp8J+zGIPiqoScfl2yVpHqYiNib
         r7qaOTJqpUgYUZBzS2VbKDjqfmL/o5M1Pl7OhmXUNCyPDbEUMWYLD5IEEmWdkiNBi9CT
         3zQsLbbqz2zvw9RQEAG+5lsCVT4Ltllye11RsZaob9t3a7zyWPytD+eqqMGpUhwL+WYT
         dyj54HEJ+70bAGsc8ewuMafKysBThvRJRGNhRWxao7KsctdH4jw4tEBjSKQnf690yhGI
         ORCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKhm15OygyYP27JSF8GOHs/6vlT61OLzL1jvjPQo/WwTgkUJROioXVoACpA+9B3gI5bPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQapp1wQasJFpISHBF1WiT7Y35wyzWTz7yMvlUfHPKQONFqDQ
	yGT/1iwhyyA1rQ/AgZ01ljYWP1bGfsMpsAZoCsvRvEsp1w6a/MAdJlGPl0r8fsKDU55C3jrZBoY
	LvCahcA0Mazp9Y5Bt1md4tummNRRoyhI=
X-Gm-Gg: ASbGncvafLqEuA5nfHvqkh78+SU4kqgT5yBHWQtns0WuYGxMULYGwD9NdN/DFE0n2nV
	v+gGcy3zIbz2ACQHrhCTSng6FTWDWXXVi99ND/EW8vitncmV1c28YK3wbg9sV1ClGPftKbngJXY
	iBKD7PYY76G6Oa2K7eEPW3NQC4XuunmmHE9EAhheqVfsJR4I61XaFTtvf2lb5k37ELvo9AgaSmM
	MfvM4sUZpdsHPrT
X-Google-Smtp-Source: AGHT+IHEs9ucmK/ekGUNmAIRnjGfkoSXOnyr6W+dj50RnTNyR67qQ42Ykym273J9TIRjuQQ5edIa0WzRAVIVQYpChHI=
X-Received: by 2002:a05:6102:2ad0:b0:4e5:a93b:1d76 with SMTP id
 ada2fe7eead31-4e6ece543c3mr5345849137.21.1748725257780; Sat, 31 May 2025
 14:00:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:00:56 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:00:56 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250530-pks-meson-tap-v3-1-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im> <20250530-pks-meson-tap-v3-1-676f5e41f2e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 May 2025 14:00:56 -0700
X-Gm-Features: AX0GCFvEs2x4lzLr98bz3Q9jy6hrCUvihQpNe4t0N0VuuPjOSb0sLX4r27Epe0Y
Message-ID: <CAOLa=ZQXQh6+B+gDdV=vT++dscCe6e26NWk4kA_1_aEz4=F+bQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] t: stop announcing prereqs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000ccdd3c063674d34a"

--000000000000ccdd3c063674d34a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We have a couple of cases where our tests end up announcing that a
> certain prerequisite is or isn't fulfilled. While this is supposed to
> help the developer it has the downside that it breaks the TAP format.
>
> We could convert these cases to just have a "#" prefix, but it feels
> rather unlikely that these are generally useful in the first place. We
> already do announce why a specific test is being skipped, so we should
> try to use this mechanism to the best extent possible.
>
> Stop announcing these prereqs to fix the TAP format. Where possible,
> convert the tests to rely on the prerequisites themselves to announce
> why a test ran or didn't ran.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0050-filesystem.sh                  | 30 ++++++------------------------
>  t/t3600-rm.sh                          |  5 -----
>  t/t4000-diff-format.sh                 |  2 +-
>  t/t9500-gitweb-standalone-no-errors.sh | 16 +++++++---------
>  t/t9903-bash-prompt.sh                 |  4 ----
>  5 files changed, 14 insertions(+), 43 deletions(-)
>
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 5c9dc90d0b0..ca8568067d3 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -10,53 +10,35 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  auml=$(printf '\303\244')
>  aumlcdiar=$(printf '\141\314\210')
>
> -if test_have_prereq CASE_INSENSITIVE_FS
> -then
> -	say "will test on a case insensitive filesystem"
> -	test_case=test_expect_failure
> -else
> -	test_case=test_expect_success
> -fi
> -

So `test_case` seems to be defined here, but never used in this file,
so we can remove this whole block. Okay.

>  if test_have_prereq UTF8_NFD_TO_NFC
>  then
> -	say "will test on a unicode corrupting filesystem"
>  	test_unicode=test_expect_failure
>  else
>  	test_unicode=test_expect_success
>  fi
>

Here `test_unicode` is actually used in two tests, so we cannot remove
it. We actually want to assert that the tests fails I assume, otherwise
we could just modify the tests to simply have a prereq on
`UTF8_NFD_TO_NFC`.

> -test_have_prereq SYMLINKS ||
> -	say "will test on a filesystem lacking symbolic links"
> -

This is a no-op debug message which can be removed.

> -if test_have_prereq CASE_INSENSITIVE_FS
> -then
> -test_expect_success "detection of case insensitive filesystem during repo init" '
> +test_expect_success CASE_INSENSITIVE_FS "detection of case insensitive filesystem during repo init" '
>  	test $(git config --bool core.ignorecase) = true
>  '
> -else
> -test_expect_success "detection of case insensitive filesystem during repo init" '
> +
> +test_expect_success !CASE_INSENSITIVE_FS "detection of case insensitive filesystem during repo init" '
>  	{
>  		test_must_fail git config --bool core.ignorecase >/dev/null ||
>  			test $(git config --bool core.ignorecase) = false
>  	}
>  '
> -fi
>

Okay, so here we remove the unnecessary 'if...else' statement and
directly check the prereq.

[snip]

> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index 7679780fb87..578d6c8b329 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -700,19 +700,17 @@ test_expect_success \
>  # ----------------------------------------------------------------------
>  # syntax highlighting
>
> +test_lazy_prereq HIGHLIGHT '
> +	highlight_version=$(highlight --version </dev/null 2>/dev/null) &&
> +	test -n "$highlight_version"
> +'
>

Okay this is a bit different, we set a new prereq which are used in
tests below. Previously we checked the exit status of the command, now
we check if there is an output. This shouldn't matter.

> -highlight_version=$(highlight --version </dev/null 2>/dev/null)
> -if [ $? -eq 127 ]; then
> -	say "Skipping syntax highlighting tests: 'highlight' not found"
> -elif test -z "$highlight_version"; then
> -	say "Skipping syntax highlighting tests: incorrect 'highlight' found"
> -else
> -	test_set_prereq HIGHLIGHT
> +test_expect_success HIGHLIGHT '
>  	cat >>gitweb_config.perl <<-\EOF
>  	our $highlight_bin = "highlight";
> -	$feature{'highlight'}{'override'} = 1;
> +	$feature{"highlight"}{"override"} = 1;

Nice ;)

[snip]

--000000000000ccdd3c063674d34a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8c55d60bdaee6df9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nN2JnWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFl2Qy85QjdEWERWS3BCVnNBbWFjbDhKd2dKUnU1agprYzNuT2xVQ3hV
NUhxRGNsVk5iRVZtL20raXNWQWVEV0FaSzhDb3NBancwVmVqR3ZZcEJUU2RqN3NiK0Q1U3dwCmcr
N3RoZ0RTRFBQam9ORzNKSTBqL1R6STd5VW1VcmRtdjhMVzdGSjgyYWVCaEdTYTlSSkg3R2VacHFZ
MmR3T0EKR0ZyemUzZDJ0UjZvV1J0d3VOcXNUT09oT1B1eHJkdTBIMlIzcFFQT3JPaFVkdG9oWmpE
ckFEeUx6THFkWkljZwpRQmJIYWdOMkVSNmZtTW5GQjNpWjVyN2JPdHlNYlB6R2twQlN1ZGZnNFFz
Nmo0Qk5oMmV1cVozU2RWWTEyN3NpCmVnTEI0U25tTUtOK1QrNkxkK2ozbnFZbTBEWFhDRjZGNjg1
clV2RWwzS210L2YxWjVSZ0thNjUwNDRVMnhQenkKN2F4UTBialNEMkJWcUVReUZMWWtCL2JPMW9F
YzVxL0tRZW5qcUVhY1dmVDA1QjRHa01zdTVZaGZ1TXFvUXVzZApwN2lIVHFqSXNzRXVoQ3dyNm1N
dDdCQU1iaDBwQTVzbGRCUUlpa1U1dEV4UlpTYnB2Mm1zTHVudVJsbHpDOC9UCjd0MEY1Y3BaT0Zv
MHRHbysvcUo3bXBlMUE4ZWVUQmtPanhtbTBVVT0KPWZMdm8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ccdd3c063674d34a--
