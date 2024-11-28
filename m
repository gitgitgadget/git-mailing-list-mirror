Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A096F06A
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807879; cv=none; b=gVyjIcmWEs+3xky/qoSKFTEQWesFITl+8e+0YJojj33D6TQh0leAr/FIsLXDoFLe5JQ6vQ1ICkWjzMkTy0tUmInFZJdHP/Mf8RZ8kHR4f+y5QT/AR6/1lZhI6cXoUYzeBC1OVKv/rI73Ox4h9oUofpqzmaw0qBVrBw+MlvuBV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807879; c=relaxed/simple;
	bh=vU+J95YsY1mxyZcihpOhJOf/KWdiyhOSMa/ubbIBqko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MffuWKwcJsHQAlVyf+BVZSRriTyRSaF170Phy0wR0h4l+2iP5gT5PSSPnTtCdYWkYqBd9TqsMVHLQv83TusOCA9+qkN5PhXVs/b8jx+IG6gBwI0qrhEleUcdSLiKctNhJed07CmQvVofKAg9qB22l8rvqp/GLhgABh1AlH7Exug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZaseW36; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZaseW36"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa545dc7105so126094966b.3
        for <git@vger.kernel.org>; Thu, 28 Nov 2024 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732807876; x=1733412676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFjoCLxFttBQYsu1koC6+gLPt3a+WtUqHPZMnovjD3Y=;
        b=dZaseW36Nbh1GZCLRJh4odZKr966efRDLF+uYxPpJ/M6OtQib1BuH/o9/Av7ul3Aab
         /kmB7vaIeDbMPrlSkGCqUcPFczldPld+Z/ee26qy4JM5Yjzc7CpggF5MrjSpEBlDeyyG
         ndP9ILllPdotAdc3GLuwBJkHsRDRA0+rFC9tJHw43AUZew37bUwxNTAUGfrzgk0Cjspd
         pW48Tubzrf/RPN8C/Vovl/6gNHVfZTY6VInn04OyFtD2grzrqLiztRTzqAX7Oqxbha/r
         1yzpOHPHgTjMA0ElMm/hZUaopscAfTgL00u8HWepTsPbeYQC09kBR2O0qdrVDAPW/zNT
         4J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807876; x=1733412676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFjoCLxFttBQYsu1koC6+gLPt3a+WtUqHPZMnovjD3Y=;
        b=kOYCrZR7SiHTDLKMmE7zKdN3+ERf4TTp/ZlRW1NAdkp2VFPE+RBlIt1tRfJD+9eSEW
         FqP57I5OnuQvOkBYw+SRXV1QFoZ7pT1V9IbiABpB5+6X6s/bj8+2tloL5vxr5hYco0D3
         gLtOW/VTPA87vbfQhckatzEnqOwsioNTi7BWGwxtuoo5OFtxiMU/6+m+BpCAwJRf132K
         H2vLiaN0c5p/+QTI2HKL6UFTWQCaHnJbxPGVbq58H6fzvUon53Lmc0HDMfG4pg7gme9h
         83p0Baa6/KT9b3V6/CFjShVn8MV+I8WyI5r9ZvzwMk1ASM9y7VphEtfmpXow3ze1xS84
         J1Jw==
X-Gm-Message-State: AOJu0YxJkfORluNvUW9ZJKcsgiorAi+FHB9GDZiUTUt9edK+tRQPgfed
	jI4Ui2t6RgV55xTB+ZucCOyncrVCubLBo2xk3J2ZLWWOGav3jlhsbvpLVSJ2LfgiXfOS60/Z0S2
	xz7ATjg7VdIAypzTrXrZ1A7rQbCraHXJ8
X-Gm-Gg: ASbGncuuAGabRBcOl1Epa3HS64gqCun9P3BR4UZd+oHeACwrMJaxlA3NS7f2XRUg7bh
	IvVU4fALc/ElENXo0xHMRSV1Z612EhpTLkQ==
X-Google-Smtp-Source: AGHT+IHOdTOGRF2FgF8/Nz8t2snRv80/pMSMbIM/7pFwRzmkxLNqFYKF9VgW8uru/E5WmuMwuUaJz2zd+b5WdnIRYDQ=
X-Received: by 2002:a17:906:1daa:b0:aa5:4d96:ec7 with SMTP id
 a640c23a62f3a-aa581033592mr512453366b.44.1732807875866; Thu, 28 Nov 2024
 07:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com> <20240910163000.1985723-4-christian.couder@gmail.com>
 <xmqqserboqot.fsf@gitster.g>
In-Reply-To: <xmqqserboqot.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 28 Nov 2024 16:31:03 +0100
Message-ID: <CAP8UFD2pAtX6UPD6FATuepwVk+0wGkmU5rt=nWpWHejeCe_6rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 6:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> I was looking at test breakages caused by this topic (in 'seen',
> t5710 fails leak checking).
>
> Then I noticed something strange.  Next to the "$(TRASH_DIRECTORY)",
> running this script leaves a few garbage files under the "t/"
> directory.
>
> I think the culprit is this helper function.
>
> > +initialize_server () {
> > +     # Repack everything first
> > +     git -C server -c repack.writebitmaps=3Dfalse repack -a -d &&
> > +
> > +     # Remove promisor file in case they exist, useful when reinitiali=
zing
> > +     rm -rf server/objects/pack/*.promisor &&
> > +
> > +     # Repack without the largest object and create a promisor pack on=
 server
> > +     git -C server -c repack.writebitmaps=3Dfalse repack -a -d \
> > +         --filter=3Dblob:limit=3D5k --filter-to=3D"$(pwd)" &&
>
> This --filter-to=3D"$(pwd)" expands to $(TRASH_DIRECTORY), which is
> "..../t/trash-directory.t5710-promisor-remote-capability".  I think
> that is the cause for two extra trash files that are _OUTSIDE_ the
> trash directory, which is an absolute no-no for tests to be safely
> runnable.  Next to the trash directory, this ends up creating three
> files
>
> trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.idx
> trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.pack
> trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.rev

Yeah, right. It should be --filter-to=3D"$(pwd)/pack"

> > +     promisor_file=3D$(ls server/objects/pack/*.pack | sed "s/\.pack/.=
promisor/") &&
> > +     touch "$promisor_file" &&
>
> Style: don't "touch" a single file to create it.  Instead >redirect_into_=
it.

I have fixed this in the current version.

> The first failure in leak check seems to be
>
> not ok 5 - fetch with promisor.advertise set to 'false'
> #
> #               git -C server config promisor.advertise false &&
> #
> #               # Clone from server to create a client
> #               GIT_NO_LAZY_FETCH=3D0 git clone -c remote.server2.promiso=
r=3Dtrue \
> #                       -c remote.server2.fetch=3D"+refs/heads/*:refs/rem=
otes/server2/*" \
> #                       -c remote.server2.url=3D"file://$(pwd)/server2" \
> #                       -c promisor.acceptfromserver=3DAll \
> #                       --no-local --filter=3D"blob:limit=3D5k" server cl=
ient &&
> #               test_when_finished "rm -rf client" &&
> #
> #               # Check that the largest object is not missing on the ser=
ver
> #               check_missing_objects server 0 "" &&
> #
> #               # Reinitialize server so that the largest object is missi=
ng again
> #               initialize_server
>
> but I didn't dig further.  Can you take a look?  I'll eject the
> topic from 'seen' in the meantime to unblock the CI.

No problem with ejecting the topic from 'seen'. I hope to send a new
version with a design doc hopefully next week.

Thanks.
