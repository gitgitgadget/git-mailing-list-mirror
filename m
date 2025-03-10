Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809D220687
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610056; cv=none; b=JcENyZu6Fmv+3G+dRAtxndFX/1n4g/wSYoYaZ+oEGusVFWK7Z/ysiK/yBcRoeWwNJDfI6xn2E4UrZ4twTBxpok3LYKAXgbDPRgJz8ZlLZRwU9lz0FNVxKnXM2tA2cIu8GweLKKQnidqYIrXrn5q9vYiM4xQS0zTAKBUYrRVwUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610056; c=relaxed/simple;
	bh=Mq9gHBVp2wQJh+uj2Hgu5F9cy7lpPs/BPRb8FmWl93k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=N1EgtvDQPBz1enaswFTIfiPtCfr24Nw24eqVQUZiNl9QMoVofbrsHSB369HhE8VOFpBHrqVwDjXdXC/V2DgAitewCL+QfjKD243kGOuwKF90iI4R11LvKQfrkbSrGh9pJp6jQWi2GxtsEK6F213npQGjgs2AhzkhYuNhA0Xr+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMJNTPrV; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMJNTPrV"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5240764f7c1so411606e0c.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741610054; x=1742214854; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7c2YFkvLSpcTWEGR3IOjqy+YJvpvhFxGzS2eoXVlFyE=;
        b=HMJNTPrVuRbI5s0ho6UuFawiVcBkyp1nmPo6Rb37XoKxm5reLe3ztajxeUvSAMh4zf
         r09DJ6sOgYs4DBjfFJnXp2W+2zfjxkq4BajTZVSVqKUAI6zrBX+uVwcwG+0RntHVMdfD
         /c99ir+vPbJ6wBnD7oX/8at+nRPjWjC8dPAHhQPO12rD6AJC9IS2RHEjvNQwQ3bmpDfn
         05hyDpfUQusoPVZGRGrAVjD4/xQKfoiI9wwIwqcUqj9zJQLxiePb+Kw8NUQKS2p8SYSz
         Uo+mnFKA9I7oCLdVtj/gXWdlBPYN6xPPz7OoWtjjUtq/KfVPQRAZLq6vVPfSVNVmo5bB
         GRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610054; x=1742214854;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c2YFkvLSpcTWEGR3IOjqy+YJvpvhFxGzS2eoXVlFyE=;
        b=HoAlGFJy50fuStYDpQ5grwB9lSGoHPxolS7Qgis+CXmviz6YGHilj2fCCGLnyJN3Q1
         A3B5/wsI21wOzNwxhW3ebc7c5PoNuuEo/GyIfq9Xxy3MnmrCJu/KISWYOXYhinOc7hMI
         Fz9DKIQk5tlx4RaC0M1jUo/CY+00uDHLRqaReqMGTC5btKEMHPWDKfpId4fTSaQMTfR6
         6nKpKPbLynqIwtuIgiWp6Z3unxXejygpqJFSOFIefMIF4aGFeeeAyd4gacDcG0ZQWxub
         1nbpvY4+llfS6chUSa3Jh5GiK8nC1ZgEH1IdbR+X+7XOQsMdGiHLagFLd+RMlr46brg5
         PpCA==
X-Forwarded-Encrypted: i=1; AJvYcCUQPO2vu3+unK0y951mc3nx6vTagxWdVKhLMqXo8pkCKQkViDTOrcu4blSJU6jdLf5mX28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylm9xeeigqI/TCJI44c3Xgus51yscwwYmM5gaDU5quInMNb787
	4N9Jghu9Cn28pXH1Au/uqDZvwQYB9IS0jac9Xk2hKhueouSyXFA+mYRlC6QQuTde+LJoeEjBVZJ
	rDLTr4Md57sYngqauL6+RdzA0l38=
X-Gm-Gg: ASbGncsJMejw2Ec2EX7lDcQDmFcOm0az/swA0qs2tKPd0X0l68u9jnLm4XxLRHvvAtF
	ER3avlHYB9h7oHSTtjfbcylU3HplGtS+tjjAva0LMKDOLkaeCt81md2VQGJZv9VX1SqdKE7hm1Q
	pI1Mi64533lFm6N8FLlZJaybru
X-Google-Smtp-Source: AGHT+IGvheRjL2enIwv89NOmLr0/aI9CIEjZiQXJCskFFgR2hBtPLQl2FMoBvUtVdFMklktIVUDA8tyZUJjM4oKjmgc=
X-Received: by 2002:a05:6122:3c8e:b0:520:535e:89f2 with SMTP id
 71dfb90a1353d-523e40fd448mr8040656e0c.3.1741610054151; Mon, 10 Mar 2025
 05:34:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 05:34:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ba1fbb96-ae87-40b5-814c-4fcea106f956@app.fastmail.com>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <ba1fbb96-ae87-40b5-814c-4fcea106f956@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 05:34:13 -0700
X-Gm-Features: AQ5f1JrE8kaPvArjAkyisqF4dUH9-VmsomySSdgGt24fc3vAW9PJv-Xl84jaKo8
Message-ID: <CAOLa=ZTL3mUHKRa2cxL2jJ-SKKncB3AjQ4deJkN3k7mgTAwibw@mail.gmail.com>
Subject: Re: [PATCH 0/2] EDITME: cover title for 493-add-command-to-purge-reflog-entries
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009d8dbd062ffc3010"

--0000000000009d8dbd062ffc3010
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Mar 7, 2025, at 12:17, Karthik Nayak wrote:
>> This patch series adds a new 'drop' subcommand to git-reflog that allows
>> users to delete the reflog for a specified reference. Additionally, it
>> adds an '--all' flag to enable dropping all reflogs in a repository.
>> This is a followup to the discussion we had when I sent in a patch to
>> add '--no-reflog' option to 'git refs migrate' [1].
>
> I=E2=80=99ve been wanting a command to drop reflogs.  I use `always` and =
get a
> lot of entries that I don=E2=80=99t care about.  But I don=E2=80=99t want=
 to set it to
> `true` because I care about some of them.
>
> So this is great.
>

That's good to know! I was surprised that this didn't exist till date.

> --
> Kristoffer Haugsbakk

--0000000000009d8dbd062ffc3010
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 72edf64a41476eb7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mTzNFUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHBLQy8wWkRyTW1iUDJsR0FWN3BzUFk2MDlLQjYxRAo5cGplYXZ0ZllF
dVRDZW1kS0VlU25wRU1DcnFabm1NT1NyRSsrQXJjWWl5SENOTmlpb1Y3azljSXJMTm5rQzg5ClFx
c3lCWllySS9XL0NpMnNTM0JTSm1KQTRrUlFxdWNOd04xYW9XT011SXFEV0ZiUFJzK3NobjFUVjZu
dTVmTzgKMk9HNkNLd3lwTS9tV3BpNTJFdkNUMUprVTduRkVMcXBaWCtZak81VTBGMlpsaGFvQTAy
aFNBc0hxSC9RMWxydgpNSjdTSXYyN0NBbklMd2plNCs1dXhyd0dmR3FsQzhzUXM0cDBmQ3RGcHkw
OFBhQVBVbGt3Tmc5YU54cEVLL0tpCmRwVnpHNDJ3dlZiT2VYTHd4NHhjYkJldE0vdlZHUGVuMnNx
WnRPb1RPeWZGM3lGTTFoOGVObmZ6N21CeU9JM2oKZ2dSM0VTUFE3c09UWFVEQmhEcDI2RW4wUE42
dDdJbXgrcTdiRWFReVFWN2NNQjBqOXowYi8zUzQ4Ri9kK2FGUwpJY3Rzdmg4eXMvQ2lzemJHak9s
RWgwYXBUdU5sZnpoQjhSbExqYWthYTl6aTJWK0JEVmYzTGw3ckJiaVNoeFJCCkJZc2pMUC95VHFF
MnpMU2QzV0lhakZ3ZEp6dGFIbFRYRFJ2YVlxbz0KPTVNSTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009d8dbd062ffc3010--
