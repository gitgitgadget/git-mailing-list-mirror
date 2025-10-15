Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955F31B803
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524415; cv=none; b=IUjQ5vLmDtpmWlipQ31NinTlXZC68ypSs5lD7+fwvMNg0mSR2QvugTO2oJZuv+BJqyet2xS8VC3ywCjC7noOtccGyKpEkLsuZD5JRgbluIY+vVNfWysvhxjoBl5HN82BnBOOOdGPRdhKaojKAhqoq8FCjPCC46JqwCJbK1Ron1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524415; c=relaxed/simple;
	bh=+p0m5QYlapVScUHLennwPAT1PKHVAevuSTIrkANNI1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acAnXq00IGpW5cQCmjk8Yfnm4xfFUzzKB+dOr0OwbKUr1FRf+DNtgtPTGUOgPm5XxtXetxWGmIe9PVuQhQFvSzkBdIjyVkIZ6sU+MRbuudxylOnv6rYMnSXvpz3t3/oGeiBKx8nKQFoCC1ysRTBe51Em2TJdU09ephVy1Fa31CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR3nhEOG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR3nhEOG"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so12543675a12.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524412; x=1761129212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+p0m5QYlapVScUHLennwPAT1PKHVAevuSTIrkANNI1o=;
        b=fR3nhEOGe4BLj5Jgd76RslCl1OK2kj/wrXtUdswKAISHoOrFnBJZe8Y+lVi9CJQfAY
         Lo9atncKetcxuibRvwYw2uH4HUX/sLMFRN2HsSGVx4agKTlmkZRxsOnzEhCG/AVSifNe
         /a3GPDH9OZpEt1t14xbYdPf/5CjPOX0i9Yv3L7H6qVm8vanBq3M8oT9MN6VCBToV6EFg
         fjKARZ1zNlASYz4Dj3nKVA/ERtPPCMByaQsAALO6DZ/rz/acWfVXDvLH4W4e8qstwvA6
         Jx2jQO9QCcCpMkoqg6mUD0Gw7pcYARISQGDQTFan0c0umBPV19qu6AoJU4giKgLD355P
         QTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524412; x=1761129212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+p0m5QYlapVScUHLennwPAT1PKHVAevuSTIrkANNI1o=;
        b=xMDM60lO3c1AWM58+1xCLWVAGxqytWiqnGT5cOUesWrt0ytfmTNMaV9utj+lRCK1DY
         2jC7iCjljHZU8L7XezQqA1WqS3LVvzqKIJKa2SevoTUhLysKVrAIyYQx3ZEUc+5Pjlui
         TRGWQ0IByLBor9VbB7JUfGAEFd6WN6e5uRPcRlXAgdsS2nFVhAsZlLHu1tIRUk79YwJp
         tJLDN61Z0RqxzGOEf+QnKkGGhQuB1g1XVRlNaqW6zKRe+L8Ffa6eBrjXGvaHc/XOXu77
         TY/GbGZdX6Lmv3C0nArwhqG7Br/TkjnvhiTBODSCw3iNu67iPwuY7DRce0GksyXA7j0a
         4N6w==
X-Forwarded-Encrypted: i=1; AJvYcCXJfYrBQ7h8McrDWpcIvX+SL3TMqDsr1r1a2aSbNJKhoK/82njfF4Rzfj0VRs3xSQA6OVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6LKO9/kXr42dXdhMq/Pcs2btXuEgIUuXW4Wie2k09K94wPy7
	zK1rd1lGPlazz9GdTHJfNGhXpXtGaivNCQhOpgGCHOyiv34qjz7nbSOFScWZuQ8WZaZMYf2aKdd
	WB+MZc8R0q9+u64lMwbJPcvVDdy07xDw=
X-Gm-Gg: ASbGnctslbGM76Bu8k6ocziuxgOxf3yqsvSdhf3gf1ZbWAHSkxvZQOKbSB3MaZt2XgK
	Zx1yiaqyUeejNgMqHG0xf3ZEt62qKxA3bEkLLFRNOSbsfyikd11VVkH9LRf8LG+wua6ND9bW8Qo
	qOzzmbXug9XzsfT9ueRtA9xq3hNhxnZ/1yX/77/+yL+T6rM4cV3GO/Dx3t/SRhhlIT3qGk3rAuj
	ATqNr2yUW9Nt0HTVBPLPBFWTib3PzCVJoqa
X-Google-Smtp-Source: AGHT+IGyDSsuz5GRAf+wuc9xZnS6etLiNWAVF16O4W4AIaYrbGMey7fxXCq+kJtAkKO9OHSSMZoPcN/NxGpP+t+7wsA=
X-Received: by 2002:a17:906:ee89:b0:b3b:679d:7f4a with SMTP id
 a640c23a62f3a-b50aa387331mr2789697866b.5.1760524411502; Wed, 15 Oct 2025
 03:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20251013183311.33329-1-siddharthasthana31@gmail.com> <xmqq7bwy1tgy.fsf@gitster.g>
 <a72a2d7e-06ec-4275-812a-cb1e20902c90@gmail.com>
In-Reply-To: <a72a2d7e-06ec-4275-812a-cb1e20902c90@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Oct 2025 12:33:19 +0200
X-Gm-Features: AS18NWAQRC8n5TEBxvcw5PcziynaxI48c1gLoJFPYRHvyOLW1w1dz9zmUUhg6pw
Message-ID: <CAP8UFD1LJkVmn4GFE2jmPGORRNVOe=vuC38fmra1TVL8cAsqRw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] replay: make atomic ref updates the default
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, newren@gmail.com, ps@pks.im, 
	karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:57=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> Given your feedback in the other thread about `--ref-action` potentially
> being
> clearer than `--update-refs`, would it make sense to align both?
>
> Option 1: `replay.refAction` =E2=86=94 `--ref-action=3D(update|print)`
> Option 2: `replay.updateRefs` =E2=86=94 `--update-refs=3D(yes|print)`
>
> I am leaning toward Option 1 because:
> - "ref-action" clearly conveys "what action to take on refs"
> - The config name `replay.refAction` directly mirrors the option
> - It's more obvious what the relationship is
>
> What do you think? I am happy to go with either approach or a different
> naming
> scheme if you have a preference.

I prefer Option 1.

Thanks.
