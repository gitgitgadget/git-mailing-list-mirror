Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899F1537A7
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741391909; cv=none; b=UWEk4qDz0gblC9fyznVt4KloKPOftpYYvdrZd4k5dTmCbUtH6sZsSjBfHnwz04LvDe8U2C6JNyXbYeY7229muwCH6rGX1FKvEcLeiYv+T8DgxLYiwA8oKleblU8z37DBk1pAPSu5JaZflZ8xm+8SHVlWHWUfXTDplJ5ZXMxDlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741391909; c=relaxed/simple;
	bh=spALKpt3cS6bKVikbCaqrlblh1dHq9jbrgGvQ1e8P2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikxKR//ojaqyuHd5nNEhyys408oAXtq4xHTYm4GpDuF4MFIiRcIKqrOY7p6XTsaM+LNvDNvqX3syOHzGfOc/OEVnu3mt0aD6lWBrbgMIUv8u0dhA5qWlDcHkz1HCfUdMShh55xSPbvKj16SClJ6j7bFRnc9RtyVarMGqnLXw71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uwnyvk8p; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uwnyvk8p"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d04932a36cso22661495ab.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741391907; x=1741996707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/j7uYeZdkonY15WSIP6B49iXYvNKX3JaPn/Gf1dmb4=;
        b=Uwnyvk8px26csT0l0ZDmMmPr9+Byhz1YfCHGArZm1WJCYlqamqL839QGm02AhxTpjP
         oZXA45BBjRgF4nQSYn5TQ3Lsd23wTdNUEry91VE2Qri/GZ81L1NOR5LXy91kHuuN7jP1
         Z/daZbfy33nKcbOEKi4LGv5d5+3MGCWD1P6EGIb4zlEBCuEfdOunBxKuVzCgaF1e5/7/
         HQRCs7s63OcneVDEaCQbmR0wbh9BlxlY/5pCsgIpmD1BCBIykpBSc5bpWRHsEglw8Gvp
         nHT7Au2tWgA67aEI2En1NW+ssKJw9/6ThbouifY9FM6fdVyQIv9xfkSFylHp60lCd8B0
         RRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741391907; x=1741996707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/j7uYeZdkonY15WSIP6B49iXYvNKX3JaPn/Gf1dmb4=;
        b=doZuPMK6IgWtT1A4aP+MQxXyuLAiTHzTNk1XddnlOib+0dR4h0hwxPflwdg1f7h0ry
         iQ4H6MxtBPeQ92b6TO/C2PASRMxUxuF8nzUqihUNI993KqQUjV+BlLAPCCzL73hSxTIN
         ZeDckvyHulG4AE7UoVwNnXyPu8L5JlvWTHHCHC6uyCVyQBOlMeevDNnnERZKgTMG8Nve
         GXAcFf45dKTOTEgM5pOO7/iBTfRVlDxa4cERUC2CMkA80ThKqjhka43LuVHmHbWSXyVJ
         O0MKsnV+pRKkyot4b9LX2at+yNC9fNigMy0pwybY1CVWhXET7xp+jOqeiBbXwX21BlUb
         M3Sg==
X-Gm-Message-State: AOJu0Yz4xrRNaTqd0lBWyN56r80DoDtCM+aElF7SJn12Dm1J/8crvGcA
	k/gC3LkS/Vk0ZHYgciBpo+ewJUuRFD4dgcIXg2Dl2m05xPoZSDWpK+8fr3vSHCBApD/S7bdLw0w
	9xsI57pvfvSZLEtwacTxd5tT3sRU=
X-Gm-Gg: ASbGncu5lQfWqoNazKK+mErPAOp+eLNJoYCQJKcmE72tXkhbJ4ltY2yTsIzr5AXC1Bu
	avxdVB7Qc/bK5umxz2TzdzY3BIYgSRjhfObUN/x1825vxTl1qT5a+Aqm+/5crYG6ukVR0If6FKi
	g6G74lj2Xa5VnCs9J2WOwWdi3knQeZBwcdbqckWizkMZodC0vL22UrnzQmEd8=
X-Google-Smtp-Source: AGHT+IG9yVJ4LHlPIZRnH2++lYqeIRJl0BQFxyNw0X20sU3+jj+8eug4GeS0pZct78CNMMkmv4QYDEqti30IAR4Mj8o=
X-Received: by 2002:a05:6e02:1aaa:b0:3d4:3d63:e076 with SMTP id
 e9e14a558f8ab-3d44192e5f9mr82220895ab.18.1741391907227; Fri, 07 Mar 2025
 15:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741223981.git.me@ttaylorr.com> <cover.1741275245.git.me@ttaylorr.com>
 <c3b5ca597330275391704a0653398ee28f911fc1.1741275245.git.me@ttaylorr.com>
 <CABPp-BE3u=YVCU20Bz4jZc90DkmArE=v02WjOzr-uO6kV6Zfng@mail.gmail.com> <Z8uDMHclfE+KqBMz@nand.local>
In-Reply-To: <Z8uDMHclfE+KqBMz@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Mar 2025 15:58:16 -0800
X-Gm-Features: AQ5f1JoceMc6ixyyEVbpeY58WZwaWaPYeqU_lrz0YUe8qjS7czboVTfLV8KYf7c
Message-ID: <CABPp-BG_mXT1fv0G2QXJg4WJuVZcWbPHG_9VQ8Szf8Ges4fGJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs.c: remove empty '--exclude' patterns
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, SURA <surak8806@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:37=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Mar 07, 2025 at 01:32:49PM -0800, Elijah Newren wrote:
> > Makes sense...but doesn't the second patch also fix this issue without
> > the first patch being needed?
>
> It does, but the mechanism is pretty round-about. (From a quick glance
> we'll turn the empty pattern "" into "/" which won't match anything, and
> thus won't contribute to the jump list).

How is that round-about?  The whole point of patch 2 is to stop
matching on excludes as a prefix unless that prefix is a directory
name, right?  To me, patch 1 merely looks like a special case of patch
2.

> But there are a couple of reasons to keep this patch. Most importantly,
> it hardens us against potential future regressions here with the empty
> pattern.

I'm fine with leaving the patch in place, since it doesn't hurt
anything.  And if the empty pattern is especially problematic, I can
see this logic.

> And it makes dealing with that case much more explicit by
> throwing those patterns out before they make their way to the backends
> instead of the quirk above.

I don't understand this reason, though.  It feels to me like the
design behind patch 2 rather than a "quirk"...but maybe the fact that
patch 2 doesn't exclude "refs/heads/bar" (at the low-level) even when
that exact string is given as an exclude was unintentional or
something?  If it was an intentional part of patch 2 (as I assumed
while reading it), then I don't see how patch 2 excluding the empty
string exclude is a "quirk".  Am I missing something?

(Not that it matters, since I'm fine with keeping the patch for your
first reason, I'm just curious...)
