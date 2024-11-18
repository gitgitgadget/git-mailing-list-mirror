Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F02199FBF
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939521; cv=none; b=CuJQHzwmXTFoe2/SHtB4oKs8sQzPV8Gh0I5nH5ltKPqFN89QFI8RVCTWMdxCeDCFh6+UDPJlLzWrXTdUp1fhhHwHG8CfqiXyR/7NY7/jl/pmby+KiOmAKu32nBddFTBU/DE2m0g7R9AqoG0XglyxfuRU9zz3Ddj5wCNslNRoplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939521; c=relaxed/simple;
	bh=WWNwd9Ko/Xps+4DwBOWQTEKBNwW7wWjfk+DJ6OYMMFQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XokbWcAAAKMjgDophLdF2/w3mE/6VEDKbHPk1vN27I6dN5jaYAzDA+xyuerIAAIBFL3Acsv5FpPzlmjMPVJd46K28kZlqd8VJLyLcMrwVILlJesBsf3RZtMG+S6DC4dZGFK/jNYOcjONl0x2HNGAhC2XLtvHWQk20qJs/X8BjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTU6WE7n; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTU6WE7n"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e6005781c0so2261405b6e.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731939518; x=1732544318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PHWrNu+1cZ9pYXKUvsVynRWghMQZaCkzv71amDPxsI=;
        b=FTU6WE7nha/1kZG+ITkKcZttrU/481ddDyIp5d7F7ksjiYe63t+pOyPtPl/EKNwUCY
         MjVBi2idpmE+1x2rVQHWs/T1LEljFLXvtNiUChsjcdWtN1DhE8W4YyvO/MTR70pa77EI
         dAQhc40vxzxkThg+JDBKA5r1AuNFdTZ9ZpX3IktJvxmMVUqtSalRKwO+EG7HnUWOh1rb
         dHvscfQbV5sVQfUaOV/E7FciEN+5BfQoiou032/ZDH6moOBnu0jpVLVtN6vYilfBA4uC
         O8/b+lTD2JtfQFG1z+rBZFdYXpnHwkci2NLLD99WQluvtTdclBp6RZaDKzZKnRMeTP98
         uFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731939518; x=1732544318;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PHWrNu+1cZ9pYXKUvsVynRWghMQZaCkzv71amDPxsI=;
        b=e8/SjHvS0vWbjs1sA+ZU3HAWjvujR8Bz4TX/j8Ht8T1DdNdVfyO6dGdibnwOTs8fdx
         NAGR/ILwc5JRYKxvwmkmyPXrFppcoxtuacxY5tAedQYluC7HZAJ3iE0PxlcF0z7h5Thi
         TvHzvk+VexlX3v0nLVjZTq6QULyiHe4ghVaILDgINEKBdiFK3hupovC2UVwlSbkyN5ng
         1Jl0hX1C0VU0K7DDByNyqhDGavldJXZfkts8pEoizYAQfkTUK8AOB1AakhWG2A+SvgdM
         Dkd/SX89JOAc4bNK5KIs06Awfy0NQFokbeD6noCzm/sQLaV08LbHkLvd1fS+qf3VCwfq
         AORA==
X-Forwarded-Encrypted: i=1; AJvYcCVP+jW1Z+ptdi5qYgx31hhdmWrgUUdDY2z0HzShFMwFnjfMf7ZYmaBnDY2wT/+XxU8iAGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqYurkk8eE3eS4IsG8tFe2seHMmJRsYIrBR56P6B8BmbAxJf1
	Z/qpyVkSN3qYzM/xRwijHKdS4NemsaOJ4IVpdotdkB80gJkZHpdWAiQ0EQsuYAu+a1LMZh/kA8s
	kDHbUEjvzkb9OosufYxkG/aq3V4I=
X-Google-Smtp-Source: AGHT+IHtuMYyFo2nCoVy7cziBtCmnaAZ4wv19RULXbdZItJlFbHX5yVcU1yYAPTdSmne0NhBFMj2GhZ5iyfCULblkqQ=
X-Received: by 2002:a05:6808:180d:b0:3e7:a1f5:781b with SMTP id
 5614622812f47-3e7bc79e2f3mr10957221b6e.5.1731939518422; Mon, 18 Nov 2024
 06:18:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 08:18:37 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <b15daefbc83383b3ea2b6ab7d2f091d3d756952b.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im> <b15daefbc83383b3ea2b6ab7d2f091d3d756952b.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 08:18:37 -0600
Message-ID: <CAOLa=ZQXXR3RR_2zBfCmR06t101W1X5VqN3P_LYYz+AMJKu+=Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] reftable/system: provide thin wrapper for tempfile subsystem
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c56556062730970f"

--000000000000c56556062730970f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> +
> +int tmpfile_close(struct reftable_tmpfile *t)
> +{
> +	struct tempfile *tempfile = t->priv;
> +	int ret = close_tempfile_gently(tempfile);
> +	t->fd = -1;

Nit: below we do `*t = REFTABLE_TMPFILE_INIT` should we keep things
consistent and do the same here?

> +	if (ret < 0)
> +		return REFTABLE_IO_ERROR;
> +	return 0;
> +}
> +

[snip]

> +/*
> + * Close the temporary file and delete it. This is a no-op in case the file has
> + * already been deleted or renamed beforehand. Returns 0 on success, a reftable
> + * error code on error.
> + */
> +int tmpfile_delete(struct reftable_tmpfile *t);
> +
> +/*
> + * Rename the temporary file to the provided path. The temporary file must be
> + * active. Return 0 on success, a reftable error code on error.
> + */

Nit: would be nice to mention that the `t` is reset here.

> +int tmpfile_rename(struct reftable_tmpfile *t, const char *path);
>
>  #endif
> --
> 2.47.0.229.g8f8d6eee53.dirty

--000000000000c56556062730970f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d2d0b79310d2def8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1RMd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnZUQy80dStJaE5lQ2NoUXdtQUJNR1B4dy9hSVNYWQpyRTlBYmI2bXho
MlJlVmg5cmlFSVYxK1N6TjhvM2hsV1J2WE95a0JDeCtsTUJkNnNDRUhUdEpWblU2S3dpUzF6CjRi
b1V6VGtrOENaWGhJSDlDVUJiNVBJRC85d09qTEFyWnVWcXIvRG1YOU9KZ0ZBUWFwRmlhbnFMSGty
SGVvTVoKMlBjQ0FnNTdESDhIKzFzakMxY21PalEvRStnRTZhR1RHUkwwZ3RkK201dnM0aUNaYUJO
WmNBYTN2QktOOWxkZwpIdnQ5dlk3WXo2a1VSTHZaZ3d2ZFRuN0JmWFJEQXlsTUFrSFllSmJqMlJn
cEMyUEFCakV4cmoyV0N4VmQzN0lxCm9wWERXd29YTUpXOTlCNmNOSEJibzdQMzRrckVKRHpxNEdH
bTlmK01FV0JQcXRkSG9hQUYvQVcwVnllOWg5dW0KZWpZaklFbEF6L2Q4bjBsTTZCZU12UTJ1RXMr
eEdHOHJtU1orbHk4TWVmWGErdnJFcVArelhubVpwa1dsOUg4UQpiaUYyOHBudDZpTG5EQjd3WStQ
czBkWjlhV0VoTktSZ2ZzTlNDS2U3UU1KeWFRSFpyN2laK0JNd2pRSG5xNWJuCmRNaldaZlVFd3Jx
RDg5VDV0eDVsdmZTT3NUOGFNcklBVGNHVjJ5OD0KPVZkdjYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c56556062730970f--
