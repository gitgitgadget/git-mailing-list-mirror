Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1193225A3D
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133691; cv=none; b=eY+QA/wEPHpksaQ6ICX/xwlmMZRBZMd4zhcaWi4tRx22S4X+v5RZK5Dhfe8UcihUKeo/s89d0nYDsyHWTvYNfv47eY441TEcAHKU3aDxOeXKQzRC+52FNADIFJvMMLUYXngtteZPoHgnRY1JPun+swpiJ6NrqzlR4F5bfMZP6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133691; c=relaxed/simple;
	bh=ENyZxkkSATA0D2EEeOBpb9m1qcFIt+fWgdLhVp0cOx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5CTG0m0cLvVqtC8ES4Jo+5LLzN1UfH8Now/tbQZUWwDSXLls16O6kddnn/taNnfSBf1wLrW9fAqkgPpxWOx2nr/sTrGIvgXcvFveHRlaotnDuXcz9jkwwRZCYlsMV+0uOQ92I89M1jGTNw8F85sjZWZ2GTBc+NO0cSUf6t9YoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKlfGmJ1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKlfGmJ1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f799a5b72so108944a12.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758133688; x=1758738488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENyZxkkSATA0D2EEeOBpb9m1qcFIt+fWgdLhVp0cOx0=;
        b=IKlfGmJ1ZvoGvMH2b3vLAe/Tob6O+frk6C8Uuc90scareFc2/eq4ZTgnMaIBZT29Ze
         FQyP7cDSA6DbwjwRSJ2OY/xfx/IFSNuzsxpN2wJCIEw+Z24YSCf0lkr9/x9Fi+56TmfB
         5TuQ7vXD8g0F/u+yMpIypEm5Upd0Eldt4NeWHnZY9o6xnu57YLb38c1FPv1XnIvOc02I
         XhVE+WWj49R0pI0T9XVEMVNHi7nVUcK5BEyyqwMMlSlOCbY6n2n8/Bo0sh4RWkMRuhdq
         JMW+EsvUtJ2WrBnoPsnGbN8zjs32focYLMxN7y/9AU8rv4m2Z5WjbnjNucBrvDZWJLb0
         Ed1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758133688; x=1758738488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENyZxkkSATA0D2EEeOBpb9m1qcFIt+fWgdLhVp0cOx0=;
        b=E8FewFF0CjpHP1oYP294lR1tnuuDdI7YavvPOjslIdjNMlIuwwpoGSmI5jbTpgL05B
         gUzIhtqANn/ChOh7ONMPGlIqzXpaqQBtkXi5E2mJrQPlBKN7VLrJy+QAPLXgOTyO3WPa
         0XnQMU8Q83oudAzNXwRZ2jmQOVuUr1hIkwncpIe0LJOOhR6M7U+duT9lZLfW9m8WGR0X
         bV2P0O9Z4oN8LrnfV9ZeL3sTOvAubVkwRLuEiu033gR/NwOHhvlUpA9j89QhJYdTGY1o
         8lHNV2eN/AY5j5KDILbPo7t9au87ZM0Rt/cNRDaVsz8zFtNlfpzJa+5py9tL5v9zp+0Z
         eIEg==
X-Gm-Message-State: AOJu0YyJJWa6lVyuE3qZbJHov/1bc1UqUESc7drA3sMQkZlZe2ADWuep
	phgpn9nXWvWwJWH9QH59pOILpAYSnBJCTWdLfa43dv5Soch+Lqg08/md1GoAJ6XA0hVvSw3QbLf
	Jw4aa1/jXc/S1feP/bqMS+PlZQIFB1l4=
X-Gm-Gg: ASbGnct4ehgcRRGGw7vz/r12pfgL+wtw9dVCS87VjNu/EGKDK2ZH69lf8LnFXf0ZZaF
	IQH/DFvwGOOY7fpF2YqS2ElPDniLkTUNEiOPVMSBNcUymV8BS313+tdEKH1oJQhOkqMOC8O5HjE
	FZ/tJX5w+tl6PZ4ZOY9lgKT0ERP0SlfFZkSWo+NJ619SgCiEbYDohlp/CkzAGg4j+VZqxi/qoFM
	JddLhtPqw==
X-Google-Smtp-Source: AGHT+IEoRGtL4Kgxu37vJMobeb0nA69do2jLLjEtcJipzDhwy2kG7tPQEJ4WeecfjObEiRRFP+n6lBQyjoIhZ1K+BoQ=
X-Received: by 2002:a05:6402:35c4:b0:61c:7a45:583a with SMTP id
 4fb4d7f45d1cf-62f83a2a4damr3108067a12.10.1758133688142; Wed, 17 Sep 2025
 11:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-3-christian.couder@gmail.com> <xmqqtt1as08f.fsf@gitster.g>
 <CAP8UFD0EAuGdMWY2ff_kjaQnZ3w7VP2ftM6Y4Hr3T4HQTsFB3w@mail.gmail.com>
 <xmqqa52zoizs.fsf@gitster.g> <CAP8UFD2RVZHqb4EwULmmR3hJJKuxajeOOLe5_p3DYcz2dmdzYg@mail.gmail.com>
 <xmqqecs7iu0a.fsf@gitster.g>
In-Reply-To: <xmqqecs7iu0a.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 17 Sep 2025 20:27:56 +0200
X-Gm-Features: AS18NWAmxjveVpuoNqS2Apo6wYH2zC5stSC4HI4O_fHBHaxeVx8zG4v84s8H3wk
Message-ID: <CAP8UFD1yW4SW1Nj=UfBq89UHVGJi6zPuhUEd5XbPBfSBh+x4xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > So it seems to me that I should change the code back so that its
> > behavior is the same as in v1, while trying to avoid what you called
> > code ergonomics regression when you reviewed v1. Ok, let's see if I
> > find a way to do that.
>
> Sorry, the above reads like (but it is a bit fuzzy and oblique to me
> to be certain) I suggested a wrong approach on v1 which we are
> seeing in the version under review and I am suggesting to reverse
> course?

I just hoped to get hints in case you had an idea I didn't understand
about how the code should look like.

> It is a bit too far apart between versions so I am not sure
> if that is what is happening, but if so, sorry for making you polish
> itrepeatedly.

No worries. I hope the V3 I just sent is better than both the v1 and
v2, or at least that it moves us closer to something better than both
of them.

Thanks.
