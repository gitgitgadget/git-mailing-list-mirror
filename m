Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118A233155
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749764; cv=none; b=tEafSVQBsx7H/4wkaQ2YMKj6TxOwZ5sCKI7BWcAjBNeCa/7VKvbcK3DbxKuXIgufkLtRU/rfs1dNK4EkcAk53y1Eo0K6fcQc7tRIhsNEYgqk/i9jyfEqHJl7S7JRpjWPd2q4nn3taGu23kawCv6E9ls80Xk/Qgkr2kvjJtpWNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749764; c=relaxed/simple;
	bh=sRM4QAKqUOGKwGnGBfTG5N56sb4SmNIqrDYk2YLa+qA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Z3ME5at1cuiXYlq5wHFJRtCT5pBQUpuxU+BkXKvs/flWKNE0gHvppOvFCvO8U+JDV1Wkm7q+QxXDma0C4czz1h2LEzKDHLUY6rABya/EEF0tfK80Dnjy/5FgYBzBMHLdEywlze4ZFfWhQQiVZ/d+/T5QhjYBHDXGIS92kwT85mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmaYJiiw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmaYJiiw"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6882c33acso267881585a.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 05:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733749761; x=1734354561; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFaXNv9zPXaamaZjiLCrfwup2moKpPlhG+4jV2kwGTE=;
        b=GmaYJiiwXDlOeaG9PI2q2z6r64Ymw9gqLDvzxn4qUg0LF92k4XZgh+P8wVnIU8tP7d
         iAlJNWeX6EvKiz5FWVDBpQFcUwPrrVM6caFBNb80MNzHEq83OE/hsadVdzkRVU2upSRx
         A/HzDpvYOSBmztybGDQj2B2DPcT5UobY3HUcRn3QKv8I2UWBIvtBVjCb8XDYszmN5cev
         II7OLdXBWIQHrlj6nMdNbfplZxoIzwoClz2myoYM28JmErUr0pO+xHVEjP8AwoClgWPd
         VNJo/d5AYX3eLrMbRAk47icGW4KZ5UoNs1g3LSde8I/KiYTdxTuRvomFc8B8gkiYQDYo
         MYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749761; x=1734354561;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFaXNv9zPXaamaZjiLCrfwup2moKpPlhG+4jV2kwGTE=;
        b=HFj1NySDBKGUTxjoQ5F5jgaOGB+W9jHtbx+rv1qm/MCfpaTHPkiSvhyfCVJzoAdmvU
         MPoczNGV7Cjp2QTmT/upmBNxud0IYVx5cQES6t0/65870WMBF+xr1b24uYa97A2tVpFA
         A0X1gPXo6IpYeJh0ZOur6CoxpHIpllFwAa3IZehJroK0EeOfHmy9i1FPFVSNn22GC3UY
         3FMx+oLWurJM4FbEp0wPheNnHjTRZuZ7vSgN3vmigPacXY+xcLZMSHkKG7fdMMJSGb+B
         uapp01gjYj7Ltthf1g8CnOMO/FvPBEu8naRMHm8MFEyKCUelJtlr8CoYK4uAlpgfydYG
         ojqg==
X-Forwarded-Encrypted: i=1; AJvYcCUk9ZUqxPqL7brfYzLMVv4S1mDSWERT6vTfLk9kvoVb5txhS40l4qaZLDs/NCEkIC18zzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/73oe3U7zlWQlWuQioc+FPO4d4arCluNN/4otdQpjK969I86
	SL4PT856nW9ke0oandk1Q0iEiZG2UdOsCI1y7laCBGCxoyclaIJYCQaglCFGG4ENNn8hYRoOiR0
	YnIXoP7IOTYQamT0+eVa78+tdKSt4TdHd
X-Gm-Gg: ASbGncspzWO39EudSEOJ2kqGs81BL0ohwncg1bLxCRkhO7pE//Xz91tkeEc1BEK6G2b
	LEylLecrlqKEb3XLl8z7h+NwmLAKX1aE55mJnTJxNaZTCM4UjWfKUY90YK2J7biXTag==
X-Google-Smtp-Source: AGHT+IHzwBVSDmR18FQyH9bSNajig5XnHzMSECeaBwdzA4uMdvrOXxCdoSG8UHCHaNK+vK7TQovIOY54SU8TYI+BXIQ=
X-Received: by 2002:a05:620a:1d09:b0:7b6:d1f6:3df with SMTP id
 af79cd13be357-7b6d1f605d0mr855353685a.21.1733749760950; Mon, 09 Dec 2024
 05:09:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Dec 2024 13:09:20 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241209-fix-bundle-create-race-v1-1-e6513bdcbf8a@iotcl.com>
References: <20241209-fix-bundle-create-race-v1-1-e6513bdcbf8a@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Dec 2024 13:09:20 +0000
Message-ID: <CAOLa=ZQpBf-ZE8BmXRUXJ247p44Enj0vrJv2KHVDXtGzY6SU8w@mail.gmail.com>
Subject: Re: [PATCH] bundle: remove unneeded code
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a1e4da0628d61297"

--000000000000a1e4da0628d61297
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> The changes in commit c06793a4ed (allow git-bundle to create bottomless
> bundle, 2007-08-08) ensure annotated tags are properly preserved when
> creating a bundle using a revision range operation.
>
> At the time the range notation would peel the ends to their
> corresponding commit, meaning ref v2.0 would point to the v2.0^0 commit.
> So the above workaround was introduced. This code looks up the ref
> before it's written to the bundle, and if the ref doesn't point to the
> object we expect (for tags this would be a tag object), we skip the ref
> from the bundle. Instead, when the ref is a tag that's the positive end
> of the range (e.g. v2.0 from the range "v1.0..v2.0"), then that ref is
> written to the bundle instead.
>
> Later, in 895c5ba3c1 (revision: do not peel tags used in range notation,
> 2013-09-19), the behavior of parsing ranges was changed and the problem
> was fixed at the cause. But the workaround in bundle.c was not reverted.
>

Interesting to read the progression in these changes. Good digging.

> Now it seems this workaround can cause a race condition. git-bundle(1)
> uses setup_revisions() to parse the input into `struct rev_info`. Later,
> in write_bundle_refs(), it uses this info to write refs to the bundle.
> As mentioned at this point each ref is looked up again and checked
> whether it points to the object we expect. If not, the ref is not
> written to the bundle. But, when creating a bundle in a heavy traffic
> repository (a repo with many references, and frequent ref updates) it's
> possible a branch ref was updated between setup_revisions() and
> write_bundle_refs() and thus the extra check causes the ref to be
> skipped.
>

This makes sense, once the input is parsed in `setup_revisions()`,
those'd be the values we want to use. Checking for values again is a
definite race condition.

> The workaround was originally added to deal with tags, but the code path
> also gets hit by non-tag refs, causing this race condition. Because it's
> no longer needed, remove it and fix the possible race condition.

Nice, simple fix.

[snip]

> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index 5d444bfe201a330527e86dde7229721fc386fc93..f398a59424dcd025ce616cadcd7eece9be5301a3 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -504,6 +504,40 @@ test_expect_success 'unfiltered bundle with --objects' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'bottomless bundle upto tag' '
> +	git bundle create v2.bdl \
> +		v2 &&
> +
> +	git bundle verify v2.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +
> +	format_and_save_expect <<-EOF &&
> +	The bundle contains this ref:
> +	<TAG-2> refs/tags/v2
> +	The bundle records a complete history.
> +	$HASH_MESSAGE
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'bundle between two tags' '
> +	git bundle create v1-v2.bdl \
> +		v1..v2 &&
> +
> +	git bundle verify v1-v2.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +
> +	format_and_save_expect <<-EOF &&
> +	The bundle contains this ref:
> +	<TAG-2> refs/tags/v2
> +	The bundle requires these 2 refs:
> +	<COMMIT-E> Z
> +	<COMMIT-B> Z
> +	$HASH_MESSAGE
> +	EOF
> +	test_cmp expect actual
> +'
> +

Shouldn't we add a test for an annotated tag and verify that the tag
object is also included in the bundle?

Thanks

Karthik

--000000000000a1e4da0628d61297
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4fbcc03df7ae15bd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kVzYvb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEc2Qy85bFdBaDdwRHhoandBMVZMeGg1VTVWQWswYQpTcW55VDZJVTI0
RkgxUWo0dHlGWUJnQ09NSUY5cmdqTzI4U0RaYWZTOVVoa2VqTEtHbzBGYXZTSk1hMDFvdEhSCk11
K3IyaC9WbE9QV2xzM0xQbFVzdW44bHZWSWdxQ05sNU1TUFlRVkU5bXZMRHZnb05lVkh4ZjhHblNq
aU5JaVUKQi9wUFlPSVExSDZUSGN5YXJIYTc3L0owQy9lRVlXQUNYWkFod1BrM3ZCdkNONFBJZnMw
b282eVJvOWE5cTY5awpNRDBaUDVSQTJnL1QyWUNuNG0xVGRlUkdyb1hoODZ1UkU0dlpYV1cxSU14
WlVCZUtoSmViVlpFVjZmdDBFc3BVCnVxTGxXNlhjSXRhMnlmUUp2Qy9NenY4V3R4WURpVzM3ZHl1
b1U2djBIYWh1V1ZZU1puUkwrVlNXOXk1Yy9LVHQKRTBLMUVzN1AzK3N3bEVXOFY5bjFqOWx2clNO
TFVhd3BENTl2VlFCOTBzL3h2NjNoZHlUZVBtTXVYRzBaV0pMWgpBdG9PenNpdjlFbEk2UHhKZ2R3
Q0hDS0txWjFmM0xsSE91Y2hHV1c2SlhYYWhJWFh2V3dhVWVqNjJZemRQajl3Ckl2MGtYSDU1Wnhx
Z3BzRHVjNUIyTE1rZE8rYnVsbTFRNERzbENCaz0KPVhCVXEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a1e4da0628d61297--
