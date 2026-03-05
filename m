Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B515A85A
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708315; cv=pass; b=VD0WcZq4/hYIbIcXpetp06vhJmttT5mCWUvX/6+Cok8D1Ad22HRZnJx+fPhoz2/a98snXvK0t/eV7/irrK9406FSgtH37WcdN45N+2qGp0Fb7kyDzmhCWuX4AB5ScOHvYBmsyAAraqhXwp0KILe50HPbE+Z8PGboFCbSYZJR6RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708315; c=relaxed/simple;
	bh=Oj7nz8/fqIDE6nc2m3+uVoq8h63GVrG/vZU0unspHWU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=IE6qQapk7MqBXbR3jLHZz2UAZVlRznVQNORcZ0v8ZkC+l3JHP416WcwHAKbdDesKx8kDRJkRhuWgOJDw81vV9LF598a2Qb9mLFEZQpJ7Rfa+lA2bvTvQ/Rkgvj1wmQVGShEbWHNtqMDdfywyLtq++ygCmKfOqQ5W77sRwJelB7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUV20ALO; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUV20ALO"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5fded42aa7cso5363576137.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772708313; cv=none;
        d=google.com; s=arc-20240605;
        b=DR4YQ5dZQpKwPUjxErwoZOgSbSh93OUSJtxwAJkvtrmLQojre0KqndDXu05mKhEoqS
         U8yI5wNAL3kaTZVO4q2Sx01tcjdKvCCY1+252ADwpgAD6XlYSVS9FMW+iAesq3fO/4Pe
         3rtMstmlOHEXZzA2BOoHMLvg7qX3JPNO11FVuCIXDK62gc2SIPvySgikN27YebbS/+fR
         J+zMLiFNcdXnnX44Mt0U70vu84BttK6ujo4LqnOjFeFZ8cFz2H7xTG4pMFIJVH6T5DNz
         C/ZWMI3f4CV9rO1gxswXWVSALN7mtqH4/fndPJxsh8KIkJjeKJ4A0OhYZTILqk42sNfZ
         a+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=bqcEGhmfJ6n/rEHQ7eWnYcv5wrj6zhrtqOdS0IpdNCY=;
        fh=He30I8peZ6oO10lQnWoKCp6PzvrQX9CIGGZqnUeJH4U=;
        b=EzlWqW3XvTXeMpYv0ErngeeT0cL4cwd1kco5XmD2hwcgA/XPo9HDclq6EnDsGhDUCk
         rWUYMvmyVAQ3X9qZA7GhDgCdTHg8UR7T8SAwPHAbf3FeikVM7ZUh7p22LuIQZQuF3GXv
         Cutk2ex8wzDi3+Jk182jHEGTXVpPvG9LpUTSTU1fmTu6MqMy7BfyJ4jMo5KWj9FdJK+F
         MnrGY1+6BWMZ4MK9y4Br6TIzFmMjuD0pQh0iWgI+5ie2ZcMFqJKcT1k5DI5Hkath7bIU
         yzzZlNwLBdoSx063rFwOgjYYgpmKQWxO6jiIWTaFsj9IHeqncprmFyWAHjzCvOgwKJ7c
         NqZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772708313; x=1773313113; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqcEGhmfJ6n/rEHQ7eWnYcv5wrj6zhrtqOdS0IpdNCY=;
        b=cUV20ALOqIkGLFWh+eBFxcX8Dnp1zSFxCgmS1Dg5uUFLNnrtWafIdR6tgSZ8Ie00qF
         4WhySWp0Q5RA6eybLFeWeQeh//E9AlqItaMTYZMOv7JKyf78nZfaOjeJAJMeXTNeekSi
         nNKRs51LBItdCmWOI080NqCtuFIs0bKRxUHXvwLF1uY2QglpQgaAxXK+51v5UavkW9ci
         66vCXPhaRhlyrATNM1+w1j5g7mfyntJXUh0soOHPvoyzlfI7mnRKWubpyc+l/1JRAPQD
         enCMoqsI2jn9oN5aIC3Htaee31kTZY0D3JUVTaYmXWN8DG90kRm/MGhj4ccve9iXPdcJ
         O20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708313; x=1773313113;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqcEGhmfJ6n/rEHQ7eWnYcv5wrj6zhrtqOdS0IpdNCY=;
        b=XttN48IArBe4mfNu3VfLm2ixy0RmodKSet/eNGG+R+IzKWag784o0Bw7VqJXRge+l3
         kPW5yms6XZ6m0MgnE8keQrpD2xMLIYAhha1iEytcnq22Wit8JvYq7/bPMmybB6iBOs4Q
         VU9BN2FfYXlq41hwPoY0LBiTz4yp/6HuW+H7qKdaGcVnDmFgrFiDJpLy+og8JVt+qDfS
         pBvx3Ptiq05QnTYSUycDee9rR6UZRw7RBYF1I38T+7Ys/7UX0JKTVd1yRpm3mBQjr0Wd
         EKQCCihZyx56JueupgwmEqPt0q9vsB8gk4nh9uxSSD16EogU44+3aUHZnFfykFsUOGvJ
         Pzuw==
X-Forwarded-Encrypted: i=1; AJvYcCUtebHXxOei+4U9fLa/SB0Lb/PvaXix5EmcUnt9k4nVIscWn1IJH8Ys0TygKwiSGqgoIL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXM7z88QHO7RCtP9BCN1Lqu1Q1+KgkkkF1NdiQ6PchP2DDnzWS
	Q1RA7jqXnJGebopQfiUp+EyX78nclN/zx4kqmUMBcEmVkflebfx92kFhZ3owMR5J+m7jdeqt2VK
	5zQnp9nzd0az3c183Dtxrk+ARwqI1YfE=
X-Gm-Gg: ATEYQzyNB65vXyw9fiADj+Eov2OgNh6RAIu+illL06+ELtqDaeYRcuCiTVNvuzEJIZM
	uByKk0IeU7DdxdUYjQRjlB/pvhaDpcr7eD0nly6C1XaKhhlDy3MioSzbqQfQ2++iJluvCx8FsV1
	vmHHJUQX6xv9yTyM+eg5nyLd08eAbDmzkqC7CV8IsVaXT9oFG6iGJ8TG6DclCsifX+4ySkSeJHT
	HNkKJQfY5XZYsiJm0YhNlftdPe3KQk4Dwkm6TH3ipAxaXfi0A/MFBhoiLa3UH08oXeJ3X+kJoHs
	1Zexr9x/KdQr4TzGnCs//6rbuUTRTvJLQoufL+9h8/KoiP9ya4k=
X-Received: by 2002:a05:6102:4421:b0:5ff:d71e:c5fd with SMTP id
 ada2fe7eead31-5ffd71ed09amr93910137.2.1772708312861; Thu, 05 Mar 2026
 02:58:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 10:58:32 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 10:58:32 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 10:58:32 +0000
X-Gm-Features: AaiRm53WW_68S_z5045fpwhvRPyzNSHjibEiLUATC3pA6UBxS93cdtN7_U3uF9M
Message-ID: <CAOLa=ZRucajqkGeiHM8fvSm2WJFStoBARSC9MH2W02Qw8-7JyA@mail.gmail.com>
Subject: Re: [PATCH 08/17] odb/source: make `close()` function pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000476b95064c44d1c8"

--000000000000476b95064c44d1c8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/odb/source.h b/odb/source.h
> index 2f8132f9e1..7af4900ab4 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -59,6 +59,14 @@ struct odb_source {
>  	 */
>  	void (*free)(struct odb_source *source);
>
> +	/*
> +	 * This callback is expected to close any open resources, like for
> +	 * example file descriptors or connections. The source is expected to
> +	 * still be usable after it has been closed. Closed resources may need
> +	 * to be reopened in that case.
> +	 */

Nit: here we say 'may' need to be reopened...

> +	void (*close)(struct odb_source *source);
> +
>  	/*
>  	 * This callback is expected to clear underlying caches of the object
>  	 * database source. The function is called when the repository has for
> @@ -104,6 +112,16 @@ void odb_source_free(struct odb_source *source);
>   */
>  void odb_source_release(struct odb_source *source);
>
> +/*
> + * Close the object database source without releasing he underlying data. The
> + * source can still be used going forward, but it first needs to be reopened.
> + * This can be useful to reduce resource usage.
> + */

Here, we're more explicit that it does need to be reopened. I like the
latter better, this way, sources which don't need to be re-opened can
simply do a no-op. But this makes the expectation on the user side more clear.

> +static inline void odb_source_close(struct odb_source *source)
> +{
> +	source->close(source);
> +}
> +
>  /*
>   * Reprepare the object database source and clear any caches. Depending on the
>   * backend used this may have the effect that concurrently-written objects
>
> --
> 2.53.0.536.g309c995771.dirty

--000000000000476b95064c44d1c8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1b33e356400a8e5e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcFlkWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFhvQy85bmpjUkpVRlQ1QWwxMUd6QUs0UTVtWGtsNQpLMzNGRGFLSmFT
aTdGems4QVVteXJMdGZveWJPT0c5ZngyQytSb1FnNmRaY0VieElxVGRWMG9CYkFKVktTUDhGCmhq
eDBKdGNVMkxBY2dRV2txQ3pYR21abUNqbFBkblA2T2RQQ2lSR3JnSjBUdWlNOE9waC9RTTFUdWg4
c05nbFkKQkdSS2RhaU1uZXJEQmdScS92bjhQbkRYVzQ4SVNjUHdzR2RzS3lwemUxbmN2bjV6WWNh
NW55ckJTd2hNUWhRdAorQjRnYlJOemZFY3B0NzFFZnBEdmdVT3lVdWJvRWZSUGlnYSsyTG8waWR2
akJEREYrVGZmVWJqM0pmUWdrZW1TCnRCcEFIS25iVFdiTHJ4MG1WTjFUWmVWMkZlUmQ3dnhrWVZ3
dlVjTVJKdndoR1FsYU9kS29LdHNWSmh3QzhBZ1IKa2ZPb0o1dGUvKzR6dlZQZjdjVDErdms4WVJm
Sll0TjRUYnA3WSticmJtQlNqQ0krSlFFbkxSOStuQjlTR2Z2ZQp4M2ZLM2IwNWFES0x4cTFjQ3pO
NnBaMHBjSlJmd1lJQ1JSRGhHTXN3bmJVQTh6VWtvaUdaYmlDdkxmOWpSNlVxCkJ5cWFyQ2FVNUQ3
Z21DQ3NldzhsT1d2NGZlVlJTZGJSNzJvQkJSWT0KPUNzclUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000476b95064c44d1c8--
