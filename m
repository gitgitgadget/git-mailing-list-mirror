Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E23DAC1A
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703147; cv=none; b=ggxA6RhiHdjT5HLrikjy8jptp6kIe/BO1nNYk2q0OMnQlfPhqW6mBPEZ3pmPzBBxYkh2F6tPvii19qIZaah0aWebZGk91N2IhQ7AUZbvmwE2tE3GDYToYLnmtCA78ti6jcEh0nkSyOTYs79wS9kW8+z6gLF3h6xfHzRjBZd5Vt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703147; c=relaxed/simple;
	bh=A98RY2NKvS7QGqcnX4KhqJqy6qaINhbpIRkKJrztqj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2r7C/ZnNC/wIkV1EXKF2Km8QEiIVXXxKn3E/LfIcTFWdxSzA7GztYwKgpuvbmkvYDMxmks98Pa+eEV6Kl/NpPzaqmLHtvrHHggxsr6zRpksqzn2NIaGHu603MgctYORjOkv4nAHjFDpkejtzSFclTs/6G7fhTWSoAj6eDtZXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKWu8I3w; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKWu8I3w"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc745927098so1795526276.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711703145; x=1712307945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A98RY2NKvS7QGqcnX4KhqJqy6qaINhbpIRkKJrztqj4=;
        b=eKWu8I3w/mZI+7PqMxzkXoNYTcz08H94mnbXeJcK8DvqgCNVjuddtsh2IISXn51HH/
         ib6ot9GAaGRBt6hIKMsjM3jrjEPC0pWHLVpHl/9S/DpRJPa3n34kZSif2asHwUtGj9Sl
         VAJ8I1CsB4nHpwszyi/fHDeZssbJcwiOhsIimxlmti0QDMtGFEXiCNXQ39f5J6MgJdau
         HcM56qlkeoHi45iNQIET0UKnamZb7rvReJkrRjdsqzhqqzWroxtFLeluSlg8eBRL6uZo
         oNF+YhM2cWl8saC9Bv2wj8nlWW+j0hnQQnAtC/vDTXKfYLrxD1fvdwhGS1ecXaN15PKX
         ofuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703145; x=1712307945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A98RY2NKvS7QGqcnX4KhqJqy6qaINhbpIRkKJrztqj4=;
        b=SRLIXRHMh0XFNPpvo23weYlsmw8wsQ0B8ER7wouD4lGPksxK1+pl7d0ahXR/QjYjVM
         kiy+e5Ok0mB+QlLryXKinzISBwQ+X3TmjbNkoIL72PZu4+Jo+ixfd4e4J3SLF/HgxRB/
         vuqBhC4yhjptPKj4V21nzZ6ctklXPJ4YODfBR/VvtAE3byouFuGDpVd8hLTSFk5OPSvx
         to5wqA/sTYL3hadXrko9oYC82HVrWVW1pj8GvyehBYPmuySbOxy7PI81D9dK3AU066Zk
         B4A/d26de6/4TXbfVK/WQijaDzdG0vrraSNPYnYwQJYB/zBXbPjag4s7KC7FI3itoSrN
         xLQg==
X-Gm-Message-State: AOJu0YyXFSPzxWUsG6pIqHjLyeb01m7xoPwA4zQpRkw0Rn8FEx6WUctc
	y6cClMjxeVXTeTS5ngb4dpFWKl0uljKHFzsiRXn8ca4OKeD91YgA3pnIvCFMhBE+cmnufpZM5PG
	8/duqGh/NPaiDCia9OHnDifFvXCjYwz7fpMQ=
X-Google-Smtp-Source: AGHT+IFSu7U3yDhsVzZf80e0hog1q9ZiOMTe5Qkiir4qJGaMK8c6WGvt6+5Wpo7zv+GT6j3d1XzKDLFaL0afKT4pZQ4=
X-Received: by 2002:a25:2642:0:b0:dcf:2b44:f38d with SMTP id
 m63-20020a252642000000b00dcf2b44f38dmr1709579ybm.49.1711703145481; Fri, 29
 Mar 2024 02:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>
 <12a3b951-39b2-4e9b-9e27-cc29a65cc167@gmail.com>
In-Reply-To: <12a3b951-39b2-4e9b-9e27-cc29a65cc167@gmail.com>
From: eugenio gigante <giganteeugenio2@gmail.com>
Date: Fri, 29 Mar 2024 10:05:35 +0100
Message-ID: <CAFJh0PRP3kkXpz=PJHT65c7uKpOdkekZAKxWFgxZvHiy33-pbg@mail.gmail.com>
Subject: Re: [RFC][GSoC] Proposal: Refactor git-bisect(1)
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, ps@pks.im, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thank you for explicitly mentioning this. Apart from this, if there's
> any specific things you need to clarify regarding your availability,
> please do so. For instance, if you have any planned vacation periods
> during which you will be unavailable or some such.

Sure!!

Il giorno gio 28 mar 2024 alle ore 04:23 Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> ha scritto:
>
> Hi Eugenio,
>
> On 22/03/24 15:56, eugenio gigante wrote:>
> > Timeline
> > ------------
> >
> > May 1 - 26:
> > Community bounding Period.
> > Read Documentation.
> > Write Backlog.
> >
> >
> > May 27 - July 8:
> > Implement a new layout for state files.
> > Write tests.
> >
> > July 12 - August 19:
> > Assess and implement backward compatibility.
> >
> > August 19 - Deadline :
> > Write documentation for the project.
> >
> > I can dedicate 3 hours a day during weekdays, and 5 hours during the we=
ekends.
> > > [ ... snip ... ]
> >
> >
> > Biographical information
> > ----------------------------------
> >
> > I=E2=80=99m a former student of Logic and Philosophy who turned to codi=
ng
> > after graduating.
> > I have been working as a Developer for NTT Data Italia for a year.
> > I hold a full-time job, but I've seen that it doesn't conflict with
> > the rules of GSoC
> > since I'm an open source beginner. I am fully capable of managing my
> > workload independently,
> > including my working hours. I know it is not ideal, but I can
> > definitely work around
> > my schedule and dedicate time to the project.
> >
>
> Thank you for explicitly mentioning this. Apart from this, if there's
> any specific things you need to clarify regarding your availability,
> please do so. For instance, if you have any planned vacation periods
> during which you will be unavailable or some such.
>
> --
> Sivaraam
