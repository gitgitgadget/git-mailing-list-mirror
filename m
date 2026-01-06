Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D431AA96
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767697165; cv=none; b=rZMMduOcdZJutbu+AbvrndjwsnyWPUwpBXgcR7N7ufIHbTRtJNKmJgWy09dSJAAq8VqyBMA03OBtxOTbO4F8YEphsmi3AM1gkSwE3vJrC0T/xGL79DE+D0F0ZrAo70brLrw2BgLIVdifFhoskBbQaWeClT+JZ/otuzhmnl3Rx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767697165; c=relaxed/simple;
	bh=f2OATSJ7YRhYHPknPRGKVTTPzpTB3HZ4qcXujZGPqL4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cp67L9Xjv/r9hs71N1PvCvMN6jWkkz4anlvo4fLrHxyiPbLss+nW/1mx1mFb5iO5BZgH4qjQeVTD1LikG/+TEK6rINBrclIuEhLG2OoJKWX2RfKQXXvrVi44lcnyYgXG6VVdKUNmec+HWn+WN8S4QWPW2oEkE77RLd8jREXEQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjRv+0kG; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjRv+0kG"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbde7f4341so2029294137.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767697162; x=1768301962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6+k/q01NV5sw81Wnkuu6JJTkiod7rL7CbuL7/rfFRo=;
        b=gjRv+0kGebFvSwHA51HyWCBZjuquPD8yGzT4DK3mWFjC8tbc3posH3gPmsqeN0xc67
         1dT2LL0rDT07Pme5OuqVF6d4hucGbO/P53U8steTXtf8t1hAUjZRA4OswK8laE928u3C
         ZeUmAp3ROrwdVil1L/BhGItRjPVmHTc/5aHmIQIci2TI0nIYDzqHQkegO5lMeErCqMV7
         1n02nYGD1djMkc7mF+iqXSuCfBXGBh8G9fWP5KhqG2GYU3ltl1YC3iUX6NHbF2tF7/dp
         PZBuApYhu6SVpwqZ9EjMNxZq199yb3MzfiN8qbH+OK8sr1YDXPoYb41dk0hy53Lb8Ms+
         dfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767697162; x=1768301962;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6+k/q01NV5sw81Wnkuu6JJTkiod7rL7CbuL7/rfFRo=;
        b=eFWQBGYotN+6tshYT3vtfcj5fo6ON2zSTkWMG9kP8OdMcWWxbtGAxVaWH5Ptyoclnk
         Tv59bD73MaO+m1Way6ebwZoGsUqOrKCLiJreHHQ4WPXmdNXSVyeOSzN22VZxwjehNLUd
         gwbOwD2vEPPVbcOwxCIuAlhphZiN60GHN3fNI1dU2tV3cAQhudwAo19co2NmZnaS6SYs
         cET1GkTqopfCX9uPV3tEDZdyQykSclSaLK802xoftBC6YUl97h4YojYFOiYJPsDVwyci
         His0UZaw9IpgZ1YK5daGSNVv7G11EQpZ9JaQV6GAvMmDKo+MGshgahS3V9mDjV8MmquL
         RV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUm+FNAwNIELuGgPu84ODw462Sekx5Ktc+o06hO4FdWG/1hUj5Dntg12VgKbnlbh5Wq4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwadNXJVQ5Hv452qzBpHBClZRIz6FC9gBqxp7bT1YDyLb/nQAKE
	bLZO3MQ9wOX2DVAtsC2JAESlg4lgXvk9mAouAe7+2ReF9jTpxbM4z4oiP9QXDl57fZWm4K5APum
	v00xbT5vVIm5dXwy2N212mjdvfnpudH4=
X-Gm-Gg: AY/fxX5qG9zKhbh7FOg1S/dwi5ipwH7iRMDEqpM5EGiPByBCMVniAmUbvyvgBztzyWA
	KQLXdoKB2isVCnInLBRJi/WznU6dxqWZgAZ7cKN4whFfeiB+tgBqjamXPC7JetuUPMLw7caXIun
	UL9rKqZPBw9LaaSLhRVs9/CD7XB+glVeYSlFtB8rqFqO2aishFqqZAXOENKG2A1txAnAf4f0rQ4
	ZRyAcrTYVLE7xT6L1/+/nUEtdk2MKAr6R6OtD6kpAg6ESjo3EDCGdVNXmyvqzB3ym3mwjPn92Hb
	YQkUcQVrg4X2xj71m46/qQzeNgF8Yw==
X-Google-Smtp-Source: AGHT+IHNjTHzNCG4oPOjWfOMRTnUnJ85vcEiRwossFmpwEVIRuZWlCLh9zaMpY8Oip0iVeu1h+NEwESFPxPW8wnfyM0=
X-Received: by 2002:a05:6102:442b:b0:5e1:866c:4f8f with SMTP id
 ada2fe7eead31-5ec75685fd1mr694447137.15.1767697162299; Tue, 06 Jan 2026
 02:59:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 02:59:21 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 02:59:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251206-b4-pks-clar-update-v2-1-9a14b10c1a36@pks.im>
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im> <20251206-b4-pks-clar-update-v2-1-9a14b10c1a36@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Jan 2026 02:59:21 -0800
X-Gm-Features: AQt7F2qLwxAaH4BMhoWUhzNJb4cvZxsXr65y7pR2ecV-LWmyI4tobstXWdU7gog
Message-ID: <CAOLa=ZQZnYVuK8mDi6Yb8_+hqw_TMugn6i7BJCj1gbNHOruNWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t/unit-tests: update clar to 39f11fe
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000006e112e0647b611ee"

--0000000000006e112e0647b611ee
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Update clar to commit 39f11fe (Merge pull request #131 from
> pks-gitlab/pks-integer-double-evaluation, 2025-12-05). This commit
> includes the following changes relevant to Git:
>

Nit: There is a newer commit merged into the clar repository, but I
don't think it is so important to include.

>   - There are now typesafe integer comparison functions. Furthermore,
>     the range of comparison functions has been included to also have
>     relative comparisons, like "greater than".
>
>   - There is a new `cl_failf()` macro that allows the caller to specify
>     an error message with formatting directives.
>
>   - The TAP format has been fixed to correctly terminate YAML blocks
>     with "...\n" instead of "---\n".
>
> Note that we already had a `cl_failf()` function declared in our own
> sources. This function is equivalent to the upstreamed function, so we
> can simply drop it now.
>

[snip]

> @@ -149,6 +150,7 @@ const char *cl_fixture_basename(const char *fixture_name);
>   * Forced failure/warning
>   */
>  #define cl_fail(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Test failed.", desc, 1)
> +#define cl_failf(desc,...) clar__failf(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, "Test failed.", desc, __VA_ARGS__)

Nit: While most of the function accept description with variable
arguments, this is the only one which has the '...f()' format explicitly
separated out. It would be nicer if we simply make this part of
'cl_fail()', no?

>  #define cl_warning(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Warning during test execution:", desc, 0)
>
>  #define cl_skip() clar__skip()
> @@ -168,9 +170,42 @@ const char *cl_fixture_basename(const char *fixture_name);
>  #define cl_assert_equal_wcsn(wcs1,wcs2,len) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2, 1, "%.*ls", (wcs1), (wcs2), (int)(len))
>  #define cl_assert_equal_wcsn_(wcs1,wcs2,len,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%.*ls", (wcs1), (wcs2), (int)(len))
>
> -#define cl_assert_equal_i(i1,i2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, "%d", (int)(i1), (int)(i2))
> -#define cl_assert_equal_i_(i1,i2,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2 " (" #note ")", 1, "%d", (i1), (i2))
> -#define cl_assert_equal_i_fmt(i1,i2,fmt) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, (fmt), (int)(i1), (int)(i2))
> +#define cl_assert_compare_i_(i1, i2, cmp, error, ...) clar__assert_compare_i(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
> +									     (i1), (i2), "Expected comparison to hold: " error, __VA_ARGS__)
> +#define cl_assert_compare_i(i1, i2, cmp, error, fmt) do { \
> +	intmax_t v1 = (i1), v2 = (i2); \
> +	clar__assert_compare_i(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
> +			       v1, v2, "Expected comparison to hold: " error, fmt, v1, v2); \
> +} while (0)

So we use local variables here to avoid double evaluation of the
arguments passed. We also use 'intmax_t' since this would avoid any size
truncation. Looks good.

> +#define cl_assert_equal_i_(i1, i2, ...)    cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2, __VA_ARGS__)
> +#define cl_assert_equal_i(i1, i2)          cl_assert_compare_i (i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2, "%"PRIdMAX " != %"PRIdMAX)
> +#define cl_assert_equal_i_fmt(i1, i2, fmt) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2,  fmt " != " fmt, (int)(i1), (int)(i2))
> +#define cl_assert_lt_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_LT, #i1 " < " #i2, __VA_ARGS__)
> +#define cl_assert_lt_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_LT, #i1 " < " #i2, "%"PRIdMAX " >= %"PRIdMAX)
> +#define cl_assert_le_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_LE, #i1 " <= " #i2, __VA_ARGS__)
> +#define cl_assert_le_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_LE, #i1 " <= " #i2, "%"PRIdMAX " > %"PRIdMAX)
> +#define cl_assert_gt_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_GT, #i1 " > " #i2, __VA_ARGS__)
> +#define cl_assert_gt_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_GT, #i1 " > " #i2, "%"PRIdMAX " <= %"PRIdMAX)
> +#define cl_assert_ge_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_GE, #i1 " >= " #i2, __VA_ARGS__)
> +#define cl_assert_ge_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_GE, #i1 " >= " #i2, "%"PRIdMAX " < %"PRIdMAX)
> +
> +#define cl_assert_compare_u_(u1, u2, cmp, error, ...) clar__assert_compare_u(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
> +									     (u1), (u2), "Expected comparison to hold: " error, __VA_ARGS__)
> +#define cl_assert_compare_u(u1, u2, cmp, error, fmt) do { \
> +	uintmax_t v1 = (u1), v2 = (u2); \
> +	clar__assert_compare_u(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
> +			       v1, v2, "Expected comparison to hold: " error, fmt, v1, v2); \
> +} while (0)
> +#define cl_assert_equal_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_EQ, #u1 " == " #u2, __VA_ARGS__)
> +#define cl_assert_equal_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_EQ, #u1 " == " #u2, "%"PRIuMAX " != %"PRIuMAX)
> +#define cl_assert_lt_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_LT, #u1 " < " #u2, __VA_ARGS__)
> +#define cl_assert_lt_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_LT, #u1 " < " #u2, "%"PRIuMAX " >= %"PRIuMAX)
> +#define cl_assert_le_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_LE, #u1 " <= " #u2, __VA_ARGS__)
> +#define cl_assert_le_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_LE, #u1 " <= " #u2, "%"PRIuMAX " > %"PRIuMAX)
> +#define cl_assert_gt_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_GT, #u1 " > " #u2, __VA_ARGS__)
> +#define cl_assert_gt_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_GT, #u1 " > " #u2, "%"PRIuMAX " <= %"PRIuMAX)
> +#define cl_assert_ge_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_GE, #u1 " >= " #u2, __VA_ARGS__)
> +#define cl_assert_ge_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_GE, #u1 " >= " #u2, "%"PRIuMAX " < %"PRIuMAX)
>
>  #define cl_assert_equal_b(b1,b2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#b1 " != " #b2, 1, "%d", (int)((b1) != 0),(int)((b2) != 0))

[snip]

[1]: https://github.com/clar-test/clar/commits/main/

--0000000000006e112e0647b611ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c1fd8f7981011918_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sYzZ3TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0Q2Qy85dVN2QXVUN0d4OFhKdnBaU1RWU3dISEhjdwpVcm9IU2p2a2kz
MWN2aGRuRlB5UE5jNGRjSytVOTBnNUxUalJ5MU40NGR5d0RWa3grVlRpRFMwaHdiT1plR2pZCjl2
VENlQ21oMzlSd1lNZGpUL3MrZUZZRlBZTkRLTW9ZYURRRmlBVDhNeTNqemg2TURrMHFmSWdvVTkx
NHJXZS8KWllEcDVIemVERExnM0NPdjlUQzd5eHRpMW43VThaWHMwRDFqV2M5WVBGc0c1OVNzVWJL
T1JvcG12bkNNWlRGdgpuV0JLTXNVNW5FUDZQdk0rb2lzZEVFSlRoTWdwRWdOb3Y4VkphT3RyRTcx
cVVFblJQU2RLRVRDV3NCNEZ2b1ViCmttdjBwRDZreHNyL1ZHRDlDT05CUDVXQU9sMVFpUlNaNGhj
STAxOFNYV1lrT1h3Z1B0dFlNdUJTRlJpZk9uTHkKQUhmWUR2dHhhZGdiTjRWS0NTbHFDcHFEY05u
STZFUHhqUnZsNHp1c3VPa3ltbWxBSTFXSm9kMWVtaFJ0bFBvYwp5QUJSNDZzS2Y1Z3RQTjh3c29Y
dVV5bkFtMU1jTnpzZ1FSOVVwUmltUlIrT00rV2g3Mk5ZRXhWSDVackJXYjNCClZmaFNoTHFMYmxM
WFlTdHR6aVYwL0FaeXo2RHRsMnFibVp0SEt6Zz0KPXk1Y00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006e112e0647b611ee--
