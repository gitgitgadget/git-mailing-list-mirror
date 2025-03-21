Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87E1F1909
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551020; cv=none; b=mxG+EwBD97WjE2NnUIrwpjAowYqBSeUTm6tn3F4vZKpwME3katdPNUFkuVTeO6HAWE0aA+G60OI6NzeyuvYDsz4aYTv4cLNe4+1icO61PtZB0Vy98AdOnwPV1jeEXwLsBaVpMf/nzYYMeth7UC4qof0+52STUYphQ2HaXYhbpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551020; c=relaxed/simple;
	bh=ncXX9OcCFq9k4r98Gv9VzOl95SnAjHlIZW0UX4SOhAg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEeaesK2ymo3T22jSziAzSEddjQ/sftsRbJ4vqfxpIYhpUvoOv9sVItlxPRWuIEixKZzpXhYR2mPTLp56Zznemfjr/k3EU5iChcCKBeBHuoejAaag1yFbXQ61TIOPLJ76WoKEBS2cEIc44Ay7vHvXnMP8HnzAhPYIIXkfi9gyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTJD5kmj; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTJD5kmj"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso761769241.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742551018; x=1743155818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Wl77YH4fBkqvqzvu+97sGE0y2tCBQKjlGbq/Vlhpcw=;
        b=nTJD5kmjm1dpVm5eLL3Lh5aN9vkHbjB30D6W9MjLlAsJwzoi+lRnO++nKsZmafq0YE
         r1ckLNXsdrkjPWnYnGGHONFlPWdRfHLriQItaQ0jjdJpAWuXt7VXq06TLNz2I475C+98
         R4GlPCk8VdgXoj+of7NXbth4sK/v7ln79sxsNkL3cPHmh2SHSHQ/Rt7y2bnZoX910C1l
         k4Y93cPRL55L0Rxshl4S2xd/6dQ4nwNnrdrtS7ADzqW5xSwdGfCSur+jt7xtv6DtYdaS
         QcfZcJX9vR/oZr269t8WHdrKRDGfxeS+xRGGml8WOqaBFjQFHej6UVJspxOf9ZHziGTO
         b6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742551018; x=1743155818;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Wl77YH4fBkqvqzvu+97sGE0y2tCBQKjlGbq/Vlhpcw=;
        b=UAAvoxConO1CF5I7/pIsolC+otR3D0EyKnMi4oxEk/EBJ2f9JPWxRWCXaCKSVLHrOU
         rl6qh68HR7OP0zo9LTWTpQeBpT/iSFFLNZXgL4fvS13JQ5eH1IG0J8CISWClUz38prkW
         3K0ip7HanJPU4GWAeD7B5wtERO2yg6WwgotCLoyXLwQvZaNnKAcvVVCyeXNbNzEsInMm
         qAY2jlGNj5e3c3A8SoYds+3bwE5/XfsGQLlxG8yEhL22tHkNjGKsCd4tQZsrdzbtvQwa
         kEIsqkZC7M4W1Gk71HGgjOTy7OHTa+bETIsGcRRMp2qr7uSowI3XOJA7cCVMYEi+xRkX
         Vi2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQVI/XsCio+aISkAEELr2ylhCaibVh5AKqEi34MnL0NFJE9h2zp8i2EIwKL8fSGPLDHzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytY5hAQ+RnGdhgde5Tf4XZN8RclELKvb8R2qnABhNWoVg9Cahl
	Sl4bgJXL1HtaYzF4JKhCaOGn0FPX2vQ9jWJBYM9Eofexp4ZTiTNK3mtw3JtdAOxxSSOVihBBapi
	zZRz+G+179ib4XHQHoB3J4aOM0j7u3KYV
X-Gm-Gg: ASbGncsUVB/OH3ifq+q56U73JnqAXkjJdehCxcMvU3LxoXU1PkscsDLnwtFcrVv8FxQ
	gmjVxlNL2xhGC1Nus0AC1kKjGRh5eRJ2BkA4G/oEcKuFUHsba3l6kZqycZ2o8XsnwzLy+SGXFm0
	wb49RuNZyDuRwLwW0BAO/8NQFuTKo=
X-Google-Smtp-Source: AGHT+IHbthbSH/xtESHcsG3IINnUkdzkwy7v5zKJ7Uw6KDhpD/hn/ZKvWJYa/+n98TaYVw7m9Z3zJpzr7Il2OrejC1Y=
X-Received: by 2002:a05:6102:cc8:b0:4c1:8c7d:44ce with SMTP id
 ada2fe7eead31-4c50d47a6c9mr1855689137.1.1742551017626; Fri, 21 Mar 2025
 02:56:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Mar 2025 04:56:56 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-4-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250320-b4-pks-t-perlless-v1-4-b1eefe27ac55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2025 04:56:56 -0500
X-Gm-Features: AQ5f1JqlAJOH2Gmn_IiCkyQ-PBIpZ_W0TVdyE6pgEj_csS7HqjEap5dVxTidDfY
Message-ID: <CAOLa=ZRMLs55mwrcQPOFcHFxxDxv-a8fw9_RUV6ut6GYLoCQGw@mail.gmail.com>
Subject: Re: [PATCH 04/20] t: adapt `test_copy_bytes()` to not use Perl
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="00000000000068b9680630d746a5"

--00000000000068b9680630d746a5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `test_copy_bytes()` helper function copies up to N bytes from stdin
> to stdout. This is implemented using Perl, but it can be trivially
> adapted to instead use dd(1).
>
> Refactor the helper accordingly, which allows a bunch of tests to pass
> when Perl is not available.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/test-lib-functions.sh | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 377f08a1428..c4b4d3a4c7f 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1640,17 +1640,7 @@ test_match_signal () {
>
>  # Read up to "$1" bytes (or to EOF) from stdin and write them to stdout.
>  test_copy_bytes () {
> -	perl -e '
> -		my $len = $ARGV[1];
> -		while ($len > 0) {
> -			my $s;
> -			my $nread = sysread(STDIN, $s, $len);
> -			die "cannot read: $!" unless defined($nread);
> -			last unless $nread;
> -			print $s;
> -			$len -= $nread;
> -		}
> -	' - "$1"
> +	dd ibs=1 count="$1" 2>/dev/null
>  }
>

Really nice!

>  # run "$@" inside a non-git directory
>
> --
> 2.49.0.472.ge94155a9ec.dirty

--00000000000068b9680630d746a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: db13f6a700d96949_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mZE4rWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlloQy8wVHNQdjBGNHdodWlUNG9seURzazVLS290aQpzUFk5WU93eGtk
Q0xaa1IyVFYwNlBTRmJjWnNpN3ptSVRMNExGWS9QTmc1MTZ6SlFiT1BEYXBBeStxMUZibEd1Cnhu
Q1ZlRHFGNThJcytPeVhDZE5nMzBCcnB1RjgxTGRWRnpFZjZZejhmdFpWTnlOVEtScnpaQVBGbWh5
QmNyWHIKWWNiNERlUGZrQjFpS2t5ZEZQNWZTRWNjaFlKM05xY1plNHRoSHFBRHZOUjQzUWFrdklS
ZXZmcnBEdThaNHg0UQpIMGF3YzVjaUZFT2NDU1BQYzNlMVN0WWNlK2JiZkJ1Y2RUUEljSjJhdER2
WGM1Y293QVZYZlRyeGNZNHVzeHV5CmZidjkxVFpRTFU4TGxzOFJ5VWZEaWltTVd0cVltLytyajk2
UHViY1NENjlWZUNGYWxDM1FOZUVzdU4vR3NqZDEKOUFyeUx6UVZyN2FWTFVNOVJoYTRNSTBRdDV1
TVZxb3NYWkd6YXF5dHB6T2xxZjU2T0prdGE1UW8zby9YajByWAphNHdoZEExd2dmYUFlUlJDMXlR
QXNHVlA2M0ZSK1ZuWEN5aFpndDNMRm9JREhXSE9Tb3hlM0VQSFQybFVPZHhZCnhoREpNc1hrVmha
ODlEZWtKb0xpZWlwNUNjS3B1b09ROE5FTkozWT0KPWc5aFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000068b9680630d746a5--
