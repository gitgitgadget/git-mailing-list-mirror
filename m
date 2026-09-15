Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A603CA49D
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447585; cv=pass; b=K4DVa5m9HZ7C+60SpD99jMtrEVtzRxkNJPA7gaSgflWZKY4Cxwjc+YyRkVBheOhXQnplG1BMy8OHVaKZHokds72Ya8o70hhILEehW72VkrHmPpg3nNUjYdBq9N4zF4/3xhOcDcYw/0Si9elH961tNGkhP2SE6xXskgkF/FVrlfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447585; c=relaxed/simple;
	bh=AotMXGXw6jnkm2DoEoCH9bK77a531/vdJ6zlGVM3QGo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlK2IAA182XGyqQWhH+Q6iNCs0IhfnaQaUpTWxPSBbwZBPSr/jsGDFplITmRmkcal8Uusnz3544MAcwNNys8nrBf0rsGual3Zi0kD7hWMwP3oCdA9T4HJxjTaG9zRaBoJ0K/UOTz7wuiUkdgDjNsiqU2hgj1XhIYZ5ftEuqECgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3GH03kY; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3GH03kY"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e1942dfso154044e0c.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 21:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789447579; cv=none;
        d=google.com; s=arc-20260327;
        b=OXu1r8U+fq4+LVjhdEZm6lZsMEtwHJltkaLvSUvvmCv08s6wpSs6pWSHcB0+U0gHzf
         W1X2AXDgioa3msWI2Lg+aXLu+bnYvPy3BrcdA/bHeD0BEFLfOpCvYbWyZCaWYfu3yFBz
         BiCwaLrTr0RXSI99rgnXSlfiWNYwcrZiVcdXADEj1RMmbTyiFU3Lu/flglzKhVicyt1n
         J/gYhPYNjHJpk25NoEqP2RgpZ+3G6bXQy3a4EWmD1Wh64lyWYfo5jqNQak0AanKgz2IY
         uDj4SmX/B1QHgJHpKh/pMr968Fx0WXCLydeZmfJQiaiMjbyt06XldChJsv0q9b5Bzobg
         6Gwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xj1EYfuhImsvs+d89t6xggisYD4o/u6aFtqvOFTvBEE=;
        fh=2X5/M6A+tC+01TfXX0MKPS9YwMX7RhAvQ8P4oZHTMSg=;
        b=fXC/o+1iPatv1w5ky+LEj+bWDjECGAN4PkBFtQdMC64xVd47hWrdTGEzegmgfCOGwh
         JDcjpXXrdrqCudc+RtBWwE4sBiyPoCcEo5RAXsO08Pce3pxI8E37fBbGszDOA6zCmgta
         +R2KbNPrA7dJAg3R6bM46hw0pdWyxeIaEpRUj9gKJqSmXnOTDtYu+10ewdzfHzM7ocsA
         b+hhxgAsnyy0o8uriVXpywCEFviO8tWKT7n01MEn6dl7/v70b2wuzfselMTNHr1LS3xS
         BqLQalWUva2/WIZw4AQVfxerzKD7yEIa20vrsNLcor8fxsu87cFswKK+orPawQaVdXdf
         xkoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789447579; x=1790052379; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xj1EYfuhImsvs+d89t6xggisYD4o/u6aFtqvOFTvBEE=;
        b=f3GH03kYjbnKrR/2E0mPXXIN5W5Ofe1aSJzdFB7UNg88FcOWYePBJ4H+SjIllSoDT2
         Snvg7fG8Dgmv4XfKECOv/k4WHNHAfBmieRRjzyKc34MiYwT/W9ehzqxFStIIJNILxQox
         MbFDCX2SL7ndcaOluVpXX+Rpi/b/17XV4Ei4f/mLbot+vtdeVFhhVrEgifTB77tOXOqd
         b5TZdITcrpX95pXvveR9a1+lQYbQxc1AvQwYqT4IJXTPqtj1AY7beBlJI7abGZZr1/e9
         V4F4zXuK7jwWanPdYiPLPR3gPpnJVsb48JC06UF4XRqiMi2RGevrNdIOi58WWMK1K/o/
         cxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447579; x=1790052379;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xj1EYfuhImsvs+d89t6xggisYD4o/u6aFtqvOFTvBEE=;
        b=X0XhFxKmzuFPzAif20LeFQcRm4pDBdO5sGPkpqDjD1qlxffi2LLCIo8DDE91/0ipTx
         iJkDTICiE97fusD0rOJMvE5Ih0VTgPZXQL790GbXWtpMhEtkzSkaYYNToB9s22wJwK8Y
         OTJa2TrNjRuLaNzKEInFWsF9AyuVaKwybv2BqdTy9TyrGC6WR2BnYqoI9MohjkcNBOAF
         wb6E/3xh3s41HrNdvdmE2zDThV2Y8tJIT+KHxYGeoiM3Je8pdgyGqisCNPaFYfbeKgCh
         u8CbJvQUIJG4xlge+EqBg/rAydcYnnht4pCDoJ3Ww/ccmWQOuSBxdcyU0URINrFsitb1
         jzrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFq0yZ8W7Hf3aRA+yEq58zxoTUEBfz46adXI80XwgdPYOauXmnmHk3x9TtgWp2w444wEw=@vger.kernel.org
X-Gm-Message-State: AFuF++ngxanejn8qmy/pjGx8zW/3tyhnNm1xkAaz8Qo97HvMNdJxQhu+
	xLve8AsEZZS6VuZwGgx22CqXsxnkrRQH3MHfWetFxDWrjvo291YCtSh12X5kuH9LRrL57J+36/A
	XbnKftN9CI1lgM99p22gGlBrZmB6uqQyPxg==
X-Gm-Gg: AYBFou3mt0at+0PMuwhYvIBrrAiWT2f1hhCUQ/Z9iTaCSe731/CFFktPUqdv6N3899c
	IYUmthjMMr1WpJMWS4lr6nSz/9VZWmvr4+ZEg6qvMjIRkJc+jh6e01e2GewZPDakpVRjo1JLQWV
	KajYB8fLenAA5B1uLAISAptdagKy4MO21oNNKKAF3/1HJQ1SL1aqI6xtOWDsMomKNbdLs0ww0SE
	4kzepFwPZ19lierEu+P6yGg+NGLwFt+8v+UInM8LOTVbeFNBbXdtT6CWR33adUOL/H7EUNX5jZi
	BSY/zp16MngYJDlFOUHv8ZbdcptllLg52h3E2qjfctWV3xwfugnmspBIZH30/stc7PZriQWIKRC
	dN2Ej/U8NW/fW
X-Received: by 2002:a05:6122:469f:b0:5c8:2a47:b111 with SMTP id
 71dfb90a1353d-5c981d5aa78mr6831755e0c.3.1789447579456; Mon, 14 Sep 2026
 21:46:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 00:46:18 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 00:46:18 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <18a1798d958d7f089614ec588346096c10b0666a.1789328612.git.jltobler@gmail.com>
References: <cover.1789328612.git.jltobler@gmail.com> <18a1798d958d7f089614ec588346096c10b0666a.1789328612.git.jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 00:46:18 -0400
X-Gm-Features: AcwNN1VPmKLJAago4qnDYsCFzaBAnHkBbrmk2QG7x0f_u7BzWSHn6bxbL4w_3GM
Message-ID: <CAOLa=ZRCyowPgMABwsQBYTbW1cEf8PBBSszOEYQ4TKwLVKQfFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] object-file: flush transaction packfile before
 migrating objects
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000516ef6065b7e3b62"

--000000000000516ef6065b7e3b62
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> A "files" ODB transaction creates a temporary directory to stage newly
> written objects in when configured to batch fsync loose objects. Once
> the temporary directory is created, it is configured as the primary ODB
> and all object are written to it accordingly. This also includes
> packfiles containing blobs that exceed `core.bigFileThreshold` written
> via `odb_transaction_files_write_object_stream()`.
>
> If a "large" blob packfile is written to the ODB transaction temporary
> directory after other loose objects, the ODB transaction fails to commit
> as a result of the temporary directory being migrated prior to the
> packfile being flushed. Fix this bug by always flushing the packfile
> transaction before objects are migrated to the main ODB.

Okay this makes sense.

>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c    |  4 ++--
>  t/t1050-large.sh | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 0f123b79fad1..210984f82532 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1262,6 +1262,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  		container_of(base, struct odb_transaction_files, base);
>  	int have_packfile = !!transaction->packfile.f;
>
> +	flush_packfile_transaction(transaction);
> +
>  	if (transaction->objdir) {
>  		struct strbuf temp_path = STRBUF_INIT;
>  		struct tempfile *temp;
> @@ -1292,8 +1294,6 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  		transaction->objdir = NULL;
>  	}
>
> -	flush_packfile_transaction(transaction);
> -
>  	if (have_packfile)
>  		odb_reprepare(transaction->base.source->odb);
>
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index d295c265c75c..fb83c8fba619 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -87,6 +87,22 @@ test_expect_success 'add a large file or two' '
>  	test $count = 1
>  '
>
> +test_expect_success 'add large file with loose object in batch fsync' '
> +	test_when_finished "rm -rf batch" &&
> +	git init batch &&
> +
> +	git -C batch config core.bigFileThreshold 5 &&

Nit: we have `test_config` which automatically unsets after the test.
Perhaps not really needed here, as we drop 'batch' anyways.

> +	echo foo >batch/1-small &&
> +	echo foobar >batch/2-large &&
> +
> +	git -C batch -c core.fsync=loose-object -c core.fsyncMethod=batch \
> +		add 1-small 2-large &&
> +
> +	# Neither object may be left behind in a temporary location.
> +	git -C batch cat-file -e :1-small &&
> +	git -C batch cat-file -e :2-large
> +'
>

Looks good.

> +
>  test_expect_success 'checkout a large file' '
>  	large1=$(git rev-parse :large1) &&
>  	git update-index --add --cacheinfo 100644 $large1 another &&
> --
> 2.55.0

--000000000000516ef6065b7e3b62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c951eedb43a2aaac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xb3pZZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1NQQy85ajk1VU56K2hqcWFiSW9oaXluclpQQzhpawprRFZ2SDJuUGl3
L0VKWmwwMjJhRlpxdGxrWkxSWDNuKzgybFVobE11ZVZEQXVCT0l3M2t0RXJobjZyUDVoeFV2CnJP
YURoRHByUEtxeXR0TjBDMlIyY0RMYzJSNmJNaitmcnlaMk9BeGJsdTVYRTBRQzRiRkpDalc4ZjJa
VWxOY1EKV3Fhb1FFeE00VENhL3dzcDVFL1J2SjNtM0Zvc0xuNCt2S1dRTi9BeGUrTi80b2s1ckRO
L0ZiM3N4SDZrMjVFOApyckUyeXcveEIyMC9qTEhzZ25ERnY5ejNqN2pCV1NqWmNTRkpPNkFOc2Rx
cXF2dUlQWkhmOC9RRnBhMUlzdSszCnN4VHlDVWk2RU8zamN3YWVvMXBuT1hjcGFHK2MzMFF6TS9Y
QzN3SUlRM1U5KzdLS0ptMEZzTk9YWWROcnM4UzgKR1FrY1YrM3FNK25ONzlzZkhGekQyZmhIZHNQ
VHlLcnprOXIwZGp2Q1prUzduaEd5QXhzUHlHeWZ2UnlMSFFLLwpOc2NDZVdCSkNJQXF2MUJMbkNU
aVBRQTFpTEkzWmZFdFpSWERFQTU0bWcxcWNRaFdWKy9KTE5WMldFdFdVQzF1Cm1MajJVSGZuU3pD
elZDMUExOW5neGJvd1YzVElCTVlDd0FWU3V3VT0KPU5vRGwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000516ef6065b7e3b62--
