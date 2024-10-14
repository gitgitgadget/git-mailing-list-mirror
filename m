Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6241AE863
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921404; cv=none; b=VlaNvnfMKBM1keB1i4ELwfmpmH20wmamQBTjCuoANyAznQIPihLX0PfTkRVR0yR9fjwCxxN8UThBVI75esIqEscFNtdqzai3g97dnhK28CY1QL8q1u3saZaIPNlWXyO9oO3JBksUAKNssRWjiLqNCVu08resKn/y+vy2siku+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921404; c=relaxed/simple;
	bh=LtAOT/fdTUrGjxQbvOXS9XnWRYVJ1U5fM+7RSJsh1ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEw3B9DbuDbYXoVED9Rms39v7cOP2cc8yzUtilG9UOg/tlx3ggwbMVFbTXZ/1Mz94FOA1MSZsiRjIreJSG0N/T/VLABGSef1T9nl9OgwzWYch9K101g99nH6uZNcVTXMN3pIbGFtzcPzthCQC3pQtCE1Ox5CVnqcGOHw5+qPNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE57vSiq; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE57vSiq"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47fff85d2so434600137.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921401; x=1729526201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnX5wqsQnuV0vArzPIJlUCNhdIGRGid05GGrp6gBsaU=;
        b=AE57vSiq2u2KHid/l76bnZinK7stmCtPWXh0gOyLQxq96CP3Fgz+Q/pSCTpDH2BDjr
         pFUsTuhw4474uIggtG/5N6ou6nCFIeI8IpfvEJEdyNKmi5zTKtmdVbsWZSjGHHwXVt6H
         HTSoaRmtnPUGaCWUW91VVravIOo3Z3x6U2UXTgsRV/YAudnE2+clwh0wLHPI1EgRcsL7
         M5O/lhkRvRVrPJjwpzqd2mdCLwNpFk9L3D0rRepWeFcuq05tsrMVkUZV0ATyayA0SLNI
         YYb/y1WDyEmznnOfKdT2bZA0EW9Ou9a3687blVbZ8kc/Irm4FhSWQwu/pRy6mKvWSYa2
         v9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921401; x=1729526201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnX5wqsQnuV0vArzPIJlUCNhdIGRGid05GGrp6gBsaU=;
        b=AqFSozssHDmQ7u9+NdyOG6MzapSdffCHSV8i6KLTWBZlDc6HDWMmmtyV+fR7pReLn8
         lFP0hmmQvJsHuUWHu3yI6Hwnd8JZRJvQFTMptkdH1q9dAcGetQdCBCQ3sf+KrqLs/BvI
         VAO52K2Dtgp2Y6Y/4mcrCjmHgJD4bIRsTjHERPxuz4jseoOJJ+zmEOBJGm0JcoNr8h64
         DRFJszy8qk6IAbCRG3J/oVtAPfL5+nPUeO623sqA4gy0zvcBfn43+5xRQOPeBdNEUuhh
         62zWr+K5uiRoGFU2hNudCPFQWvvZuk9s8WYwKzGdghMZZlEeOMYEsF3Dhi5KFSzMTsQe
         lGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsHCwMNy4xHnexKUAtjvVehNzf2PDcc6EcSjDwdChYq1deSloOV9EpaLTlc3zVnXlkKmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWtr10zMcjo+3ZQUsPpA7Tqz8sasSHtDVR5M9fKpSzR/ANiu4
	tpM/vbxZFPGcumUNP0qmPU7RwCvMpQDD+NCt25D8tX0voXznoZ9+8/bULLp0HPC9gmdwj+fei57
	iq2Do+YICceXEWxSR+L+QcKYxC9A=
X-Google-Smtp-Source: AGHT+IH/+gR2Lb81g9mL4Kz0alwiYzn9yHQ0l8sVOUhQcyRQUaAPGaYp5KJhSX9C2aZimar74/EYdnHibppwpbn7tXU=
X-Received: by 2002:a05:6102:90f:b0:4a4:781f:1659 with SMTP id
 ada2fe7eead31-4a4781f1ff2mr4058293137.24.1728921401631; Mon, 14 Oct 2024
 08:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com> <14db295a-0049-434b-8747-09f82e511bb9@gmail.com>
In-Reply-To: <14db295a-0049-434b-8747-09f82e511bb9@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 14 Oct 2024 15:56:30 +0000
Message-ID: <CAPSxiM-i3EmmXM6BuPb80q51Lmud0PfnZ_WQfSJfvq1nYynnLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:00=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Usman
>
> On 13/10/2024 10:42, Usman Akinyemi wrote:
> > On Sat, Oct 12, 2024 at 11:09=E2=80=AFPM Usman Akinyemi via GitGitGadge=
t
> >
> > I also want to ask if this is the right way to send another patch as I
> > noticed that it is showing my previous patch which is not related to
> > this. Thank you.
>
> When you start working on a new patch series you should create a new
> branch from origin/master with
>
>      git switch -c my-new-branch origin/master
>
> that way your new work will be based on Junio's master branch rather
> than your other patch series. You can use
>
>      git branch --set-upstream-to origin/master
>      git rebase HEAD^
>
> to drop the first two patches and set the correct upstream for your branc=
h.
>
> Best Wishes
>
> Phillip
>
Thanks Philip, I actually created another branch but I was really
confused if to base the new branch on master or the branch which has
the previous commits. Thanks for clarifying this.
