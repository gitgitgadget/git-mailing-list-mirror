Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D3219311
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661618; cv=none; b=JJMfhoMYMwroB7ErhtsmXRA9luBIloaReEIPta8cOwpQbrArvt0qbdnJt0oZGlgAxXOI6YZeU5tWNOj5F81S1U2kstvDW+9X8NPgSE/gFepWB5zS+Ll56RHdmgXcrWboLLHLYrC24U61j/fsjuP+B9FyQIm/yMAwSDh+4DjtvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661618; c=relaxed/simple;
	bh=ZnqH0llJnfwZpWhv2bQGfA3yvJUyO2vt/o06GSx271w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjiT6O74lQcej5krWmnvippye6j4joVcdNnpqFKtnvtDmlCw/JxfXtvJdD901UEEAS4H+pzf74sxPkzSPHScWhyBcC9lyujP54ar0jYSsaH/RTVq4fLiGazUNAufAhMeNpd6gJemaUjWpmbafmk5Hxc9hQ582ZhgawHfUAMeGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMITKX6C; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMITKX6C"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5315acf37b6so2805281e0c.2
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752661615; x=1753266415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Imn/ME+vPLlk/peLIv6z3JA2xdYEtmJQkaV4TP8EAXQ=;
        b=eMITKX6C0DHvT2L0kChrywh1mw/uDvvPJ/OFjW5ihWvkbH2uYkih1IHgmYBMYnKcrN
         B7RylMlr89S0LuMufKm8Sv+ifzGn3jRM8d7ULPSkQmFv1EPLzEJc5Nwe9n0uUusq0pNK
         bC4EeSW4u60jLZQQqO5KCvRynZFnRq37b1VKiyXvUdYNKRdGcv5hWPGjbsdPMt11h5F3
         1lEu0p7J4Fon6yvU/9lPyMFxkf2Gp2hAahyCxQf2JPT708MVkBXlQPQXVLgU0kpmK6oN
         CyvZuDsUXj2SAdjTlNt3Oqq3m0sMHXdAsa2pYU8Y0qGdP/XTnBLddCoA6H18sVRZZN7s
         GO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661615; x=1753266415;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imn/ME+vPLlk/peLIv6z3JA2xdYEtmJQkaV4TP8EAXQ=;
        b=aXMx2hYPUYJEk9EEomOiep7xuQ+tjG7aNvOiJPW0ftbtIMgpKLIJPcbS7rlfbaHtnj
         SyZIOycL5CY0s/9+ad39m7ROWdY6qQ3EDMSwPTRWoOn3F2syVW7/WO+klDpcKl6mKDPf
         bmOQSA/MZnvjcrQLXgjP71osIWfqUr0arNdcBAWu17JwMUl52YvgC7Vw5WW0ejbtomc3
         XFiuWS6bf1jOvX95Eh3BON1u0CfoYARtxDZfb//jr7+RjwWR0YP2CSpihiI/z+NjXN7y
         MaJy4v38T0llIjYJUmXP30Wdyl3GcVFRjHBOhKgturZIojmc9lmqdWhKZ8P/PY+QYv/T
         MtLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXov/O1Efxu2mTJ0BtRtpipj9f9lTdAV2CUvkg5+Oaz38QPg92vUtRyKFuvfWpxo0s8cms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9f0k3ndZlH7VHYzVmKhcpr3AGM97shm20vzZjUERi4WtiGa6a
	4aUycwy6h/ivUJQPv5IIEBJyhRY8Ejd7XJS9yhBFUwAZ5Lc7ovC44aoed2MTJuhrori9/0FIHNp
	GdkrB55Rp301Z7FkB1ZETEu0LugpQax4=
X-Gm-Gg: ASbGnctfqpjKLBBlr5TP/I1DrwXit1aFk5IHYYxxmjSw5uxzcKDG6gE0853owXD+L0w
	IoiymE/k1ZRd5SHna62xxqRe9I2B1cYO6pKNl2h5ys29eIYLIeQv/qzJxWyLuJKTkmW6xF09Fcm
	G43tnN6L2TP21ypL6xPRNp23ChkeHGLGr6CLEIuIhWJK8hQHsLFWieK7Sy0qDKNwn2MzCqFfji3
	Qo+b/iAr/t3tdpzrQk=
X-Google-Smtp-Source: AGHT+IFJJiWF9eFr7QbtJlvwP7Zi3mLo3i3fdenOFCQhfW5KcvzRb7gyPjcAQNKi84ZS38MD9yXiwFUfsvgKvkM2gcs=
X-Received: by 2002:a05:6122:1acc:b0:530:7ab8:49ab with SMTP id
 71dfb90a1353d-5373fa6909amr801311e0c.0.1752661614940; Wed, 16 Jul 2025
 03:26:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 03:26:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 03:26:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <26c3f48ac6c150b438c7b2f442f55a3d17141345.1752658700.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752658700.git.phillip.wood@dunelm.org.uk> <26c3f48ac6c150b438c7b2f442f55a3d17141345.1752658700.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Jul 2025 03:26:53 -0700
X-Gm-Features: Ac12FXynEIXdSyGC4jq6zUMQ2r02KxsNUK48LQ_eqK7maPr824LiIrvQI5LLIaU
Message-ID: <CAOLa=ZRNjt720fGVnLNy60qGHUwHX1qQoAq=Z7ZLcde_hxTsvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: convert string predicates to
 return bool
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	"Brian M . Carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f882f1063a0954e1"

--000000000000f882f1063a0954e1
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
> to bool, 2023-12-16) a number of our string predicates have been
> returning bool instead of int. Now that we've declared that experiment
> a success, let's convert the return type of the case-independent
> skip_iprefix() and skip_iprefix_mem() functions to match the return
> type of their case-dependent equivalents. Returning bool instead of
> int makes it clear that these functions are predicates.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  git-compat-util.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5bd69ec0403..9408f463e31 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -897,35 +897,35 @@ static inline size_t xsize_t(off_t len)
>   * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
>   * locale-specific conversions).
>   */
> -static inline int skip_iprefix(const char *str, const char *prefix,
> +static inline bool skip_iprefix(const char *str, const char *prefix,
>  			       const char **out)
>  {
>  	do {
>  		if (!*prefix) {
>  			*out = str;
> -			return 1;
> +			return true;
>  		}
>  	} while (tolower(*str++) == tolower(*prefix++));
> -	return 0;
> +	return false;
>  }
>
>  /*
>   * Like skip_prefix_mem, but compare case-insensitively. Note that the
>   * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
>   * characters or locale-specific conversions).
>   */
> -static inline int skip_iprefix_mem(const char *buf, size_t len,
> +static inline bool skip_iprefix_mem(const char *buf, size_t len,
>  				   const char *prefix,
>  				   const char **out, size_t *outlen)
>

Nit: clang-format complains that we should also format the arguments now
that the first line's length changes

$ ./ci/run-style-check.sh @~1
diff --git a/git-compat-util.h b/git-compat-util.h
index 9408f463e3..e01abf6eb6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -898,7 +898,7 @@ static inline size_t xsize_t(off_t len)
  * locale-specific conversions).
  */
 static inline bool skip_iprefix(const char *str, const char *prefix,
-			       const char **out)
+				const char **out)
 {
 	do {
 		if (!*prefix) {
@@ -915,8 +915,8 @@ static inline bool skip_iprefix(const char *str,
const char *prefix,
  * characters or locale-specific conversions).
  */
 static inline bool skip_iprefix_mem(const char *buf, size_t len,
-				   const char *prefix,
-				   const char **out, size_t *outlen)
+				    const char *prefix,
+				    const char **out, size_t *outlen)
 {
 	do {
 		if (!*prefix) {

[snip]

--000000000000f882f1063a0954e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ec18c4313d712476_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oM2Ztd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzhyREFDYnVUeDZtWXUzUThwckpJQWo4cmVtdzVOQwpHQ3hNYmFPSUNq
QjR2WExTL1B5bVpVbUlYWVVUSG9KdklzK3BwdGlEV01ORExXaGZZMTk1V2N3Q2gvRFBzTFU3ClhP
WENGbGdpbUFpa2pMajRaWjVJOFArUVlVZHFMZWJkOXc2UXFrbUx0dy9IeHF5Q3Iwb3I3OUY2aW10
SDBLZzkKTVZWSkFLTzlpR2FkUzhaeTZMODI3M1pyMmprTU5nQ1JHaGpEQm11SG8zSWU1Vjdya3Bo
QnNBUURWMGo5bDJuUAp3dFF1RlFjaWFyV21LR1Q1WVplQjFoZEJKRU8wV1Q5WmJkQkFFN1NQTy95
U0dDRG51OUNLVGNzZ2E5Rk02MGRBCmtkUnBnaGxpWVplTUVBUm80UE5iWFp4ZnhpeU1mc2U2aHlX
ZFoyWlZQS0dQVWpsYjZOdnZjSlBuS3pvbXN4Um8KV0Y3aDhpQmpMR3JzTk1veU5KOERTZ1Yxbjlq
ejJTNjZXZ3V6U21EbzdNZW9WQ29jd1REemtWSjcwTUtoTmVvaAp5VnJLdWpieWlBR1RVbHZuL0N4
bXlXUDZCdjV5Qm1BUncvYXVTcVlPV2lCOU5RZWFOMXp3akZNZzVsM1hhUlViCjdPeGhIMXJxOXRB
YkNxbG1zUmpzZ1A4Z09ISkUrUCtvblZ5NEdwRT0KPUhITnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f882f1063a0954e1--
