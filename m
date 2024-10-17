Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439D1DD0E5
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167224; cv=none; b=YFVWegnLw1zMDDmSkXWo1mXZOVdW2SNA9ULJKzKUftPxXAEDJIFXXHPjs0lghpJoobtHtrv7sAXP2ExccLyx9w+98FcpGRed3JinhOWVg5okRffjzA4ZTKg62BvrqHtXB93fVM5s8BB3LysVWc4R+wkr1rPcpUMXPUpMYk7t95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167224; c=relaxed/simple;
	bh=QZYALGwxvgQVgT+uJQcUNIafFYBmw/ciabkUzem7XI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzNsZuxyeqzmfRFlEwMuDqxl+h5gvokS96iTX8h2G6XSADPeYJJlhJFZHK2+uh1DzPrL5jprPRum4E7psF2kZwhT9eWbq7+20yczVx1N8hGjBBKNZiKhRsmODjf27ofuWS9Oa09lTWgPSwC4L8fKv7s3YUuQ3SJPxDF5joRRi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/193Plw; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/193Plw"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a5ad828a0fso258312137.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729167220; x=1729772020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtENlwk/Wi0JuhU09adVb7DxQFTpVR/zBjiPvteaRA8=;
        b=J/193PlwRo5Z8jnDeA/yzRNM6Ep8SKg7mguIKatelbocVFJxm5xm6G2nJBqWLWjAzp
         j+kh/fC1LwH2TSrNyh9VA+/6LgwR4H81xTB45da90QpZJaPXzQ922GcM+1ScX6reGObn
         9yfoomqVwZtzwKP0I0xMSyT8hmk4d0ftXe+CRm+QRzu0oKbgcyZcjNd0GpNZgGpy7MZU
         JbV9yUn6gtVIhOWq2yBt5LXQJ2WaL17/sJoXUKUgnSa1FmCfmgLGlQ3+2YEiok6RK5q+
         B0yylsPIs5MK7c4vG+ULn0vyKXHBBU+VNUsvx1+lBprS9hVkadnrUeGKcozyG1Wm0opa
         lkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729167220; x=1729772020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtENlwk/Wi0JuhU09adVb7DxQFTpVR/zBjiPvteaRA8=;
        b=TnEKW23UgO3AJAvhixlQzEjv1Nj1nBbNlrHdimmanZMtI4VecsgROYgH6irE7uLd22
         /Xbz+qrQlSYmKMy8artSTMtsEafZnwWkNFilQSvPt1JRrEZXcALRwq9hgUrCj/Xt5HAl
         NhQlBS+/FEWYdBKyDZ4esYTqyLahx5Qj4QcxaSnY7jkBKO72tmqV+LFRRzMxvc4R2chH
         42zBtoHS54HczPwjddvLzlhNGSK0Wu1g26rAy5NEDKIXkx5Wou5D1vrRwVmuE6pVM1r4
         8MwGUmHeE+F4PEbPmrX5tybtPI+7Sb/h9b0d0Yw0fCLFjS+d+qgYwWmqmxqzVBz/0cHH
         JcaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/C02GtenukqkLMNuRhay8kDw4fXjteYRRgFzgH9wfbQYODiGaj9mpvml10z+HDU3WWmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZiQ5WfyL/Fpx4QM6joX7wUNTYqdiiKiEx6UFlUmrhrlhRjrc
	YGwcd7ABTvmMCsprQLH9+TdTLkzOp3FdINBjP/WYIeT5irI0FnCuTsaueMhosOCVPdv5NqVxw7P
	S6TSYy6UwOdsijPE8VvaIyM6vhJQ=
X-Google-Smtp-Source: AGHT+IGZdIfCxgQ5V4fbiql5Ks/6Lv7+zZGTz6HIg6taSw6gMvM1w8XOnTU1VD+5vL7YAO8fYaUeuHdx953zYn0PTNQ=
X-Received: by 2002:a05:6122:2916:b0:50d:4257:5bde with SMTP id
 71dfb90a1353d-50d8d2595famr5418510e0c.5.1729167219700; Thu, 17 Oct 2024
 05:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
 <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com> <CAPSxiM-Yw2H65+EHoDckU2N2hr+UrXRu5Y2JjXc+TEwEUKJT0Q@mail.gmail.com>
 <ZxD84l-tcU0TrX1K@pks.im>
In-Reply-To: <ZxD84l-tcU0TrX1K@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 17 Oct 2024 12:13:28 +0000
Message-ID: <CAPSxiM99x8vEQSnDHCfKrQKuxE0dzenj5O4jrR0+jE62KAxErw@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:02=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Oct 17, 2024 at 11:56:33AM +0000, Usman Akinyemi wrote:
> > On Mon, Oct 14, 2024 at 6:36=E2=80=AFPM <phillip.wood123@gmail.com> wro=
te:
> > >
> > > On 14/10/2024 17:26, Usman Akinyemi wrote:
> > > > On Mon, Oct 14, 2024 at 4:13=E2=80=AFPM Usman Akinyemi
> > > >> On Mon, Oct 14, 2024 at 2:55=E2=80=AFPM Phillip Wood <phillip.wood=
123@gmail.com> wrote:
> > > >> I got this from a leftoverbit which the main issue was reported as
> > > >> bug. https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZj=
s+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> > > >> For the test, I should have the test as another patch right ?
> > >
> > > In general you should add tests in the same commit as the code change=
s
> > > that they test. In this instance I think you want to split this patch
> > > into three, one patch for git-daemon, one for imap-send and one for t=
he
> > > merge marker config changes. Each patch should have a commit message
> > > explaining the changes and whether they change the behavior of the co=
de
> > > (for example rejecting non-numbers) and add some tests. Note that I
> > > don't think it is possible to test the imap-send changes but the othe=
r
> > > two should be easy enough. The tests should be added to one of the
> > > existing test files that are testing the code being changed.
> > Hello,
> > I am currently facing some issues while trying to write the test for
> > daemon.c, I need some help on it.
> > The start_git_daemon function inside lib-git-daemon.sh is made to
> > allow --init-timeout, --max-connections and
> > timeout as well as other arguments. The start_git_daemon function in
> > lib-git-daemon.sh is used at t5570-git-daemon.sh.
> > Basically this is my changes
> >                 if (skip_prefix(arg, "--timeout=3D", &v)) {
> > -                       timeout =3D atoi(v);
> > +                       if (strtoul_ui(v, 10, &timeout))
> > +                               die("invalid timeout '%s', expecting a
> > non-negative integer", v);
> >                         continue;
> >                 }
> >                 if (skip_prefix(arg, "--init-timeout=3D", &v)) {
> > -                       init_timeout =3D atoi(v);
> > +                       if (strtoul_ui(v, 10, &init_timeout))
> > +                               die("invalid init-timeout '%s',
> > expecting a non-negative integer", v);
> >                         continue;
> >                 }
> >                 if (skip_prefix(arg, "--max-connections=3D", &v)) {
> > -                       max_connections =3D atoi(v);
> > +                       if (strtol_i(v, 10, &max_connections))
> > +                               die("invalid '--max-connections' '%s',
> > expecting an integer", v);
> >                         if (max_connections < 0)
> > -                               max_connections =3D 0;            /* un=
limited */
> > +                               max_connections =3D 0;  /* unlimited */
> >                         continue;
> >                 }
> > What happened is that the start_git_daemon will already fail and will
> > prevent the
> > t5570-git-daemon.sh from starting if there is any wrong starting
> > condition such as the new
> > changes I added. I am finding it hard to come up with an approach to
> > test the new change.
>
> I'd just not use `start_git_daemon ()` in the first place. Instead, I'd
> invoke git-daemon(1) directly with invalid options and then observe that
> it fails to start up with the expected error message.
>
> Patrick
Hello Patrick, thanks for the reply. that works, I really appreciate it.
