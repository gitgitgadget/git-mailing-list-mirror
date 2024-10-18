Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080814C5BA
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287833; cv=none; b=KLKOsp3rjGnRTAy63vzvVarlqEENtAgKFQqE1sgofSlIjfCHnkT2v0KelvDXwthMZKUZIQPawULoBxtcvYM69xVWNGk2PJKCukB6YytiZLJqTibjD+9m1p7AjZkOHGsy9I1K3O5cgwqCIw/adXxVYwFWPk1tQa3NpIXqZCpwr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287833; c=relaxed/simple;
	bh=fO/knrrHOf6SzDhX2qBhaePta9ZJLQi0gNVmE92Uk0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a25qdfJJmKvyP5rMKlmVgety+pn9NmzeGNxvPEDt2TOg45fRiBOn/QFDvLMPZGddYviehs63Qu5Y9fwbyltYAGGSBJis6HVp56FiepoiwB4eNyb8b5/ss+0EfI0/8j2+ahC5ewYzYTW3/zCVX3PNK9E9TSpMBU63XmC57hXXpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB+qRbqa; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB+qRbqa"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fd50f2117so794980241.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729287830; x=1729892630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXoZsALoZd8UnpGAzVF77DyIqzuJqxkPEuxpzEzpiB4=;
        b=fB+qRbqajk/JtO9aJ0oaX4+W0+EsFSN0agSfpV059qw++itzha86fh0x4yHh8Kfzrp
         RAj4dNRUfxzGEi5UfzV0UVBUlOlZLVjTbUpCbj80sDLJYQJYUXlBXfBHVPvknPHBJKip
         mnj7lPJu1H2WbDW5rjeYJUM6sbbOYg0hMIRUcaQfp6oTnBLdkRYaj0mwZWSHW1vQfl+P
         X9mya8eg7uFp0TDUZX/o7IZXe/W3JLJsHoKd6sUOhhW6NrvCo/zkUcDPFwT2ekSxd17M
         gd0vgPmhaXKPrb/vYwW6HOSQQ7DXo3dfQJDXu8yh3h4ylqJNeouQo12PuJGU/TAk8Wcc
         3DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287830; x=1729892630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXoZsALoZd8UnpGAzVF77DyIqzuJqxkPEuxpzEzpiB4=;
        b=aJNHnrdqvjRw33w8EtarfWVzUlFY4d2HcltICm7IeLfh0oPqYuEZQ2OQNOWjdMhjUU
         HLRiZk2r0tZHqaD2S7QoCTSIMlUHRyCOTD8clzZtmoHKqh1JwGwbfxQxK7lP1RLpmp9I
         9hWqjciV225bNmPDxL7rNrzON+Rd+zkUgJXOK4rSb6mcUzINlBg1RVLBp0okEB+KKTSx
         jutTzagli53ztgXlp3+QjU/8X8DRax3PObDM3eK/CDgMLd7dzjlOIWtNbVlMPbhduy05
         4B3/WQp0CPjOdj1QG9puXcf9/BdLyNmSsibv4dHFuSEXZ72pE/QWo2hlqNZBLFrTyBsx
         0NUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNFwLKMMvNxtA/Y8SPlBBT1A2B0daaFPIhTtFCPREwYoOmKNDuhZy4XCVgXQDIX/blfzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZGvvedBhGmvZJTcpWEEHUqG8Y74gFoBAHBcEOrH85BJnseSc
	GZGB7S0lz/QFQFkO8hW6o4BfyztABb7lFk8UKDISAgba0Ym5zJoajh4ZKYzoCw7E60RNLAYE01W
	qUkBGr6RqK5Mr8ULq/2P3isT2uiFIj3BHDAA=
X-Google-Smtp-Source: AGHT+IETg2XgGhtH6xzSp5GFGx/I2t0JhUDQS87pz2Ywpxt2zNhqFwxz06aLDdF7TPZmYkbsUWXj1W/054Rx6fQmmrE=
X-Received: by 2002:a05:6102:41a8:b0:4a4:9253:9b9d with SMTP id
 ada2fe7eead31-4a5d6bb534dmr3457021137.18.1729287830542; Fri, 18 Oct 2024
 14:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <ZxLRdu4cPDgPLpCz@nand.local>
 <CAPSxiM_dcpmpAsbo9wmXSDqGWXxU==QLfdVpowK5Xv-LW9iLCQ@mail.gmail.com> <ZxLUvlN9f7QP+kdY@nand.local>
In-Reply-To: <ZxLUvlN9f7QP+kdY@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 18 Oct 2024 21:43:39 +0000
Message-ID: <CAPSxiM_K_=My1KnUjdBpb8k8LGQRBU_8kB6wy8mLcNdawVVTiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Taylor Blau <me@ttaylorr.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 9:36=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Fri, Oct 18, 2024 at 09:29:44PM +0000, Usman Akinyemi wrote:
> > On Fri, Oct 18, 2024 at 9:22=E2=80=AFPM Taylor Blau <me@ttaylorr.com> w=
rote:
> > >
> > > On Fri, Oct 18, 2024 at 01:52:57PM +0000, Usman Akinyemi via GitGitGa=
dget wrote:
> > > > Changes from Version 1:
> > > >
> > > >  * In my initial commit, I mistakenly included changes from a diffe=
rent
> > > >    patch and commit. This issue has now been resolved.
> > >
> > > Should we treat this as a new series, then? Or is this a true reroll =
of
> > > the previous round and should be kept together?
> > Hello Taylor,
> > Yeah, this should be treated as a new series different from the two bel=
ow.
> >  - t3404: replace test with test_line_count()
> >  - t3404: avoid losing exit status with focus on `git show` and `git ca=
t-file`
>
> Gotcha. So in the original ua/t3404-cleanup series from my tree, I
> should drop the third and final patch:
>
>   parse: replace atoi() with strtoul_ui() and strtol_i()
>
> ?
Hello Taylor,
Yeah, exactly. Thank you.
Usman Akinyemi.
>
> Thanks,
> Taylor
