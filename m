Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114236B059
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041439; cv=pass; b=FuJcnSPzm2h8ovLEps4rVheJTpY7iAm+Jx/2KYMkmuc1TSHE46XqEjYC+PYmYHR1pfg8YMDpSkvjvOrCLF0uqf3ASOHNJVtzt0B+HaVwwOYTSekF6rsJRsad3DnU3yy1dumdDp6dmljCdD7K7E5AnL8oOu5kJO8wOP567bgb/yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041439; c=relaxed/simple;
	bh=01quHFG/Nj1EEXRSWfjucMjrDepVGsgHH2P3Hnufdw8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RseIowCW3w7S/aRSlq718cnD5w7B1uJDwyT9ocUP7vG21/Pwq5Kcd9XnxA6YHFf7KsjoB/KJKOLIHbjOFDyIWXqk7wJ0UwlvvdQSEu905jyORUXhZbwJdDnmDlxyZ9LrKN3f6l3HL3qUGq86lxsewt6CRmVubWsF/TOFNzYlBH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PunSZid2; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PunSZid2"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5eeaae02888so1140978137.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 06:10:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770041436; cv=none;
        d=google.com; s=arc-20240605;
        b=KjVINVty4GjUbpTPuUiuKOlmkmjVTVgPoWd3DelQqnC2QSx1zZv6OS4lHXE/qDGArv
         9Gr9r+c6A5Oj0zSimbiYB9p+G0pIF2Ar+poMxawWL81JBtI64IOGd1pM0Z1rdz1icl4q
         qoAYvWtP7fcLSV54f1nkGGbwS0u0r7Ha8BwUjdE8qOh9ZPbh7gnX0i2BRbFZjdueD/Lz
         H6mJl0dy8Tbjtbzpy1PL5NBYX0u6nm9dkZ5nYf++RvLTLbIb3NSm6rIqJgp0yHvAI2sb
         3I0ujh1w0nWwFMCJ5Tc1KyGXhOEQKdIfZwpmFwyRkZnybmBMRzUnSGRvRJuRUIdfCwbh
         TPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JA6DlkZ5hXBGCiiplGOOicOigkaq1QXaeG1AqZxZ3wQ=;
        fh=LV+UuGbpzM2HmJkYT0HDxetwdjyjp/UQG30ArqFpjNU=;
        b=OE8AIDBdfdjPKocPVptwezUDKNbyc86pIq9dC6w3kYa94yld7VgFRW9omjY9oTbRpE
         6LXRJF/GsUE5mM9K/a3udpOPj57kCM+CU1qijenw46vdeRazZjC5Q0L8TzEmr1iimgjU
         sipZu06ye0DK3n8PpIUvFqceRpau1nWeiIkyGdGAxZb3hwA3xdQI/ASYR/vfykMf34oT
         3bzrqydqSzp9x8nWbn/NbAXuu+yutyzrknaLehdwtgvNH+Td44JY6MpAXt3V2UTJ09DW
         FzmZQLMuWdCSU1OUnRjDF14cf9XST9MZFLEMRhOifa+I3utap77x2HF1z0BT6gfK3pi8
         u7nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770041436; x=1770646236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JA6DlkZ5hXBGCiiplGOOicOigkaq1QXaeG1AqZxZ3wQ=;
        b=PunSZid2k7RUTW85lYmkb9QWGLCGbsrNKdOeegq1H2ViGqy2t0AHrlEGwVzgHA9eEZ
         Lc/7b36S3RVaBf4iLWAEK0aggq9ZMWV2a9YkrgG1iDz6YFWpaeoZbP7p7TuNewSDjJmb
         rNmkgRqoAYQAa5itunOD3r27q3XOXvw9XFtqTiTNCltNgoNY7RM3ZXaiNnm0nSwaYjOF
         VbmCbQr9GbRcvrlzkXenjsqehUVWbJsDQDFp3tnLcb+wuHij3ufFnZRZOUaMnr6No6jc
         nJPy0JAEzyxkDlUNFrILRSYkASIM+dUa2fu5hXpb3/rVpE4Z6IyM/hG6r1wvY2quLXVH
         qqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770041436; x=1770646236;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JA6DlkZ5hXBGCiiplGOOicOigkaq1QXaeG1AqZxZ3wQ=;
        b=KSgO7e+5VbQvr7mrBJtT+AzFzwyl9eENyYRXD/x8W+Hxp3bNPYDZvmDZJ8Sa4Feu5I
         5YdNSNiJVqk3wvWW+gUv2gzNJRLvlI9Dyn/FkgQZ/0rsDQqv9agYo13h5K2BGvm5ldYR
         UpnsdpTHPUqWQWdBevglX8uaFs8u+w4tETVkiF79gBKNP8SuTR0eV+/kFe3ZFG1Y1Qkx
         RmTy7p7jsXAuqltMBiIabFvohK0scTgVxTOTTxv+SdzEb6HYI23LqtIMX0Kw+cDKoJVw
         8TuvIdSScsY+iLuSmBA8likmkqtoeV1WY+4KmIKiPMKBm4YxRxVRtWdRjriJ2dWjUTZ0
         c90w==
X-Forwarded-Encrypted: i=1; AJvYcCUpyJPNsDy6/uNnnM41qZ6u0WzIjHWXDkV6vSY83MkapSFI4Nq40ONI+C4/9hKpcTtrbTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMHi0bvqna3iy8TBlLP4NbHz2cOkCJcP9Y2pyKifmfXll/9MHc
	ED3nrLM6gLjamt7NfNWXN5ki+fHeMIw9ENEXVvtz8wWNrOYkClAcZKo003Xn5Fy6J7PId7NHNwk
	mq/S9rE1cRj/6TqH9NEjlteNnAoHRsjw=
X-Gm-Gg: AZuq6aKHsaYoTo4RY0eBKKo3CjPr+aQwOttNv+OCVufbhgMoP549O5p7IDyOMFHJt/2
	woLS3wOHXZ3c3NPYgz3RSbQB5oFS2lVjREnAd+0rB3LW+11a+bcuVJfAMnjDmWp3yIHPgPiDUp3
	JtJehOA2vok8UxPAK3G/uCoBX0TJZyxaT+colIO+XnCtbiUhWHekblopb/N7eH2I6KOTMqNsKXb
	qiqjk8+viGYejAHnoKWj8uBP1G3zdgD8akkAcU5+rTH2q9hoeX0AcZkc8RxtYX2zfdWOTvB3QVZ
	iWw+hkPuGdyE3MC+SVsBys7rrItKtT6nJXV8Tc60
X-Received: by 2002:a05:6102:4426:b0:5ed:675:e355 with SMTP id
 ada2fe7eead31-5f8e2603978mr3479679137.27.1770041436406; Mon, 02 Feb 2026
 06:10:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 06:10:35 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 06:10:35 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Feb 2026 06:10:35 -0800
X-Gm-Features: AZwV_QhVnRSjgGJLjy6UHhL6XQEWFKwSuL85G3NdF3FccTW5ZWe0ELoZuu7yBB4
Message-ID: <CAOLa=ZQCuka+cSuCu=KnTHm=gk1iJ_QJhDjy1Ku8WLfSgkGorw@mail.gmail.com>
Subject: Re: [PATCH] stash: honor --no-overwrite-ignore when updating index
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: multipart/mixed; boundary="0000000000000e1c280649d7e39e"

--0000000000000e1c280649d7e39e
Content-Type: text/plain; charset="UTF-8"

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> The stash code unconditionally cleared opts.preserve_ignored when
> updating the index, leaving a FIXME suggesting this should depend on
> an overwrite_ignore flag.
>
> Introduce overwrite_ignore plumbing for git stash push/save and use it
> to control preserve_ignored during reset_tree(). Add a test to verify
> that --no-overwrite-ignore preserves ignored files.
>
> This removes the long-standing FIXME and aligns stash behavior with
> checkout/reset/merge.
> ---
>  builtin/stash.c                    | 11 ++++++++++-
>  t/t3905-stash-include-untracked.sh | 13 +++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 193e3ea47a..82d10520fe 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -150,6 +150,7 @@ static int show_stat = 1;
>  static int show_patch;
>  static int show_include_untracked;
>  static int use_index;
> +static int overwrite_ignore = 1;
>
>  /*
>   * w_commit is set to the commit containing the working tree
> @@ -360,7 +361,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
>  	opts.update = update;
>  	if (update)
> -		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
> +		opts.preserve_ignored = !overwrite_ignore;
>  	opts.fn = oneway_merge;
>
>  	if (unpack_trees(nr_trees, t, &opts))
> @@ -1856,6 +1857,10 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>  			 N_("include untracked files in stash")),
>  		OPT_SET_INT('a', "all", &include_untracked,
>  			    N_("include ignore files"), 2),
> +		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
> +			N_("update ignored files (default)")),
> +		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
> +			N_("do not update ignored files")),

Adding an `OPT_BOOL` by default adds a [no] option.

from Documentation/technical/api-parse-options.adoc:

  `OPT_BOOL(short, long, &int_var, description)`::
  	Introduce a boolean option. `int_var` is set to one with
  	`--option` and set to zero with `--no-option`.

Apart from that, isn't this plain wrong?? The '--overwrite-ignore' and
'--no-overwrite-ignore' do the same thing here?

>  		OPT_STRING('m', "message", &stash_msg, N_("message"),
>  			   N_("stash message")),
>  		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
> @@ -1959,6 +1964,10 @@ static int save_stash(int argc, const char **argv, const char *prefix,
>  			 N_("include untracked files in stash")),
>  		OPT_SET_INT('a', "all", &include_untracked,
>  			    N_("include ignore files"), 2),
> +		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
> +				N_("update ignored files (default)")),
> +		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
> +				N_("do not update ignored files")),

Here too.

>  		OPT_STRING('m', "message", &stash_msg, "message",
>  			   N_("stash message")),
>  		OPT_END()
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index 7704709054..9c5421cd76 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -427,4 +427,17 @@ test_expect_success 'stash -u ignores sub-repository' '
>  	git stash -u
>  '
>
> +test_expect_success 'stash push --no-overwrite-ignore preserves ignored files' '
> +	echo ignored.txt >>.gitignore &&
> +	echo before >ignored.txt &&
> +	git add .gitignore &&
> +	git commit -m "add ignore" &&
> +
> +	echo after >ignored.txt &&
> +	git stash push --no-overwrite-ignore &&
> +
> +	test_path_is_file ignored.txt &&
> +	grep after ignored.txt
> +'
> +

To confirm, changing the test

modified   t/t3905-stash-include-untracked.sh
@@ -434,7 +434,7 @@ test_expect_success 'stash push
--no-overwrite-ignore preserves ignored files' '
 	git commit -m "add ignore" &&

 	echo after >ignored.txt &&
-	git stash push --no-overwrite-ignore &&
+	git stash push --overwrite-ignore &&

 	test_path_is_file ignored.txt &&
 	grep after ignored.txt

still passes the test. We should be testing both scenarios.

>  test_done
> --
> 2.43.0

--0000000000000e1c280649d7e39e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 25278346ac67bb5f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tQXNGZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFNaQy80bEYxdEFHazRrdjNpNlBrYnU3Nnhuenp0VQptNXF2Uk54QXdj
T3o2VDJaZ0FYdlVKU2tvUHZtTy9iOTRNMUU1MXR5UW9uMkFDN1FWeURNWTNLZVFpSWN1emFvCnZJ
RjRqcURJSFpscTc5bkdXbUdHZitCbmlRdVd0MnVPWkJMUVJsd0FNWU0vQjRkV2d0SkdoakNMWEpn
eUhXTEkKYXkzN01kbmVIMmZjSTNnMisrays4UU5rYXQ2Ulg3M0xmMDBXckpVNnJXR2NsRC82SGxF
Rysvb1RsR0xLK2RpcQpXN2JoMXZCL1h2UDZnR0ZHTWs2dFlkY2pobUZzT1FXKytxckNGK0Zrb0dQ
a3dsSFdtMWJlR2cxTUFJeDF6cDNoCi80U0lEN1JWYWh0S2JDYysyNXhhVXExM2dPRFRSVm5NKytT
Uk5PTzhNZWF0dGJZOWFUbEJ5TDlNNDRvb3hCT3YKb09IT1V2TGhEd2FoZjI2S3VQNjZjMzRqRnp0
VnVNazhKNjFWR3JhdWxURnJvN1MvU3M4SU1NMWk0aGxMNFZicQptUDN5cE5RbnV6SDNKazJBK0FV
RzRKSzViTjE2VlRDZHlCaTN1RWtYY1Y5clU1Z0w3cUhpcGlYcHpjckV0SGRFCktjd3M2VUdLQjJj
c2VOb3RJTVdPbnFER25lbmExMzdUcGNoZ0haOD0KPUxxN20KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000e1c280649d7e39e--
