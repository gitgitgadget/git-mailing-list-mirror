Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950E213237
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641411; cv=none; b=PYFBLqDz4KOViO4DnMJdw/L8oRpEnC2Lz5WG0J/tboxltLKQ5tDo7PlI5xoJ99W7y0o9+vcA8oL6HNlyZkcDxXIkUaklroxtDlKpggdVR8/mCJ9sc9e+5gih0XH7OPK6CV83GKL+ZAoHHkY7vXFrFnErHLIkNJCIq3ugxJX2MbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641411; c=relaxed/simple;
	bh=Cs5ujlbAfxAXlIbWwvlsdtideOYnaTz0UDYfdSePbrU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=MMm18GYssJHlQZ1FnalcGRKpZcjzGkHHv7vVXRXL71ISTHDua5tRnNkE0q1DiwdIp3kpkb+TnQxN/6Iyt20TPLH4EBdZip7jgWFsJfeypXqnw8mX/sPT9Ii6Qu5/PY+OIkR1Lz6a4eYN3DoW+Uf1iumdrgFDi/QsRLyRwceEBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4KSnWFF; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4KSnWFF"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54bd3158f7bso400996e0c.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641409; x=1759246209; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcXQUX/1vQdFtKrtOrsS3IBYWoir20Dnlx69Oxw+8xQ=;
        b=T4KSnWFFVfwRe2oC+aI1i+FFHPiSqqGLG0mawR7K9OvI+Nv9WpWqevlDbg1oPtt8/t
         WW5C0JJZF+M5K6Fx0k7Is1YQEZkCsRyEqvcG0pL8eU8V+0mPf6fixuLeSS7AYN44erLH
         Hk8rdopheXhm5WBYdIoK06M0848e+zJk6gXjKIEG9f4DQHRtvq3VBr3EjMhWwNJqXN1c
         MAoKzL8bEypDqrN/M95ryOjUNfXxSIlDK3QSXggThyawjmOmcoVBcNqBBoNBJ0q56jhz
         qK+vemR61y7Ps2Bnc3zke0UCkgFyGivBmFFXYo+Yndw8UnmEWFl0tssnJMLqq0lX5K42
         nQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641409; x=1759246209;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcXQUX/1vQdFtKrtOrsS3IBYWoir20Dnlx69Oxw+8xQ=;
        b=qym5VzjYqyYYuJNW5AFW7oNpnmg8Aw5UhTXcvNM9slerhneYr3skqPJLx8b1mnC7f3
         3vaOS9N0CYNoL224pIqrRqUvvvRUzYCp61/SyJeebo7sLTH1IJ1qujw9TWvHAt96exLj
         gD70/fq0rHrIWzUCKd23nvWntPFjUGLvkgvqpJ3nMfwWguwCs8SAWffY8xOeHU7KWWdu
         YsrTbALlKD5U3T/4aYC5SsuvmMEV/KtW44zV2WcNKrGaT7PQCqy3gdTDqTCb3R/vLSwH
         dGeylkwJIl1mOd2E76i/3fOTNF3i6o46p6iV4F4OCOyfDa6zncX8LQEXaDUEHKb1bY80
         /c+A==
X-Forwarded-Encrypted: i=1; AJvYcCVtq3SrmQcc8F9yIcHoV1tF9vdkk8zr/O26HKnOnQSf11e+bmI1liGuZSVK7/N3moU+X8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFzYhy+gsHgFMLfbHVncziNykS4sJ0DCEAsluSvsK3AbOBsUX
	XKQ/1PMqXcyTvPdmhWiRizU7mRh10k3KeCy0ddP8czVb4vTSXhWLEdSBMh94EW03IBoz7ATg36X
	gh1jENdpppBIspQiFpX6B7cLJhSvYGDDFLhWM
X-Gm-Gg: ASbGncu5ZD5v1496Av1ufp6zwTpC97N7sJJZ+ly8paQXzWAIFskl9W6IxnV66al5Qfs
	4K9Kw8xjjN2WgoF8peML6bqkozYC6mNey3iQ9PTKWG+F3x/8a/0OH7SbneBuhAGZe+ipjuJ72BZ
	VfO11rfYnSOhBsRVOKnR1GgkYjdibPlo9DVqyOrknwLo9F0slZ6EiR0PfbqgealFwMxIW8m+wr9
	k4MGB4=
X-Google-Smtp-Source: AGHT+IE1mnZo6JAfHJWiom5UPR2dkSjF9Pc3lz44aiFmUvkjRXRhi7jp9u7i1pqBiQymrtFlshZgyGPjzZhG2jmssJQ=
X-Received: by 2002:a05:6122:1d45:b0:54a:9433:2aa9 with SMTP id
 71dfb90a1353d-54bcb0d4fc2mr1022577e0c.2.1758641407468; Tue, 23 Sep 2025
 08:30:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 10:30:06 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 10:30:06 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250923025700.3046260-3-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com> <20250923025700.3046260-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 10:30:06 -0500
X-Gm-Features: AS18NWDfI0lX8jFDp0Qt8lrzpcjWIC8VIye6WuDoe0CsgHrnqp-mOqdP2XnMY0o
Message-ID: <CAOLa=ZTihUt0d-3_LOydX4GxWPSquAOWkzw3+0XzM-zp6wFZ+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] builtin/repo: add object counts in stats output
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006144cd063f799c93"

--0000000000006144cd063f799c93
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

> @@ -159,13 +161,25 @@ static int repo_info(int argc, const char **argv, const char *prefix,
>  	return print_fields(argc, argv, repo, format);
>  }
>
> -struct stats {
> +struct ref_stats {
>  	size_t branches;
>  	size_t remotes;
>  	size_t tags;
>  	size_t others;
>  };
>
> +struct object_stats {
> +	size_t tags;
> +	size_t commits;
> +	size_t trees;
> +	size_t blobs;
> +};
> +
> +struct stats {
> +	struct ref_stats refs;
> +	struct object_stats objects;
> +};
> +

Okay so we do use nested structs, which I mentioned in the previous
commit, so we're all good.

Nit: A lot of the diff in this commit is because we don't make the
required structs in the previous commit. Perhaps we could start with the
nested structs in the previous commit? That way this patch would be much
simpler.

[snip]

--0000000000006144cd063f799c93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f097053f77a54f44_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU3ZQd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTYzQy85R1NWM1JmMzJKMlcyMFlSdzBqTDlSSnpiUgpHWTRNcXJaQ29r
cjFCYXgrdkVGZzVMTGhyZVBHeC9vNzdEOFhueEwvQVFMU3NMV1E2ajd4MkNZTldraUhJaFNXCmsz
KzlrVHp3MjVOc0NUUTdsa2pESmFoOWFldGk1VkxJbnAydm4ydkZjeUhvTnlVRzZOMWxXcm1LZFIr
Q2NxUUgKNGhDZHdtd1BZM3FwUFo3V3JhQTZiQ0dZbDdWQlV2Ky9IcGpNRWhMSFpFZEQrYVhpYmcv
SWNrMkRFM2Z2aGVOQQpDWm9ITVpXRUdqTnNmT3Z6Z013VndTd0l0cC9ueTZpYUo5N3JFV2lkY2ZX
UGEvMng3YXZyRVFXaVBEdjlIRk5zCmo0T1lBbnZHTGhKRm90SmlxSWdETndNNnIvOVJiZnE0SFpp
Z1loMU9GMzhVc1NPcGhycHRKYjRqMjRKV0NCMDgKN01sUXh0cWRhcVFueGFTU1pZSjk1dWM5Y2hi
UG4xb3A1RVVUMlVNRTY2a0VrR25tTFZ0aGJUa0ZGWjUwL2JCUQpxeWxLTW5KN0ttNjZyU0YxYTFy
bW1OZDVjOVphcGo0R04vekdCbWQ5amtHMHFweWJucWpwb2EySVExd3FUZDMxCmhRZk1VYWExQzJB
YXpmcCtBTFp4b1FhSFBXR1FLeUwrdWh4dDdPaz0KPVF5MHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006144cd063f799c93--
