Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9C23CE
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788941; cv=none; b=KaisMcVvR4t4Np5VxQO7y87S4h755DWtuc1sSrsUXErHSGRnl5/qVVo6x26rhhl4pbuwlpCaULuXPXUAEztHTYK6PHFLhVxPwmRNtgVZTdk1oxjIStNn2O/A/bdB7vWus8ID4Z1tEwlasnBr3Q9pESn6PcF6IM6rG9nncVIJg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788941; c=relaxed/simple;
	bh=VfatBf0P10d89vxNMH9dMbHbOM1zPryG5U5WlQpjYa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+SU7eGg0DX3oLTYi9PFvBMyxpjH4EjGpdA4/qGs/+NM5KmsUmRyz2YF7Ki9gHgmxnhdd7Wl7JGh7Wvt8xx672lABI5D65zRPqPJc4gJe6FU8sqVlavSwngr5/TB6vEvsfC+D9FP6cKCXZ334LA2K72ci2aI87rFalSmiZbImLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEY4rb9c; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEY4rb9c"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8671441a730so1389225241.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 02:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739788938; x=1740393738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEn9cPK24lp71v02Bsnlb6m5L5JSngSvvSHBcZUpPRY=;
        b=LEY4rb9cpl5hJ1rT48vuCNnBV2T7Z0/q8fAesWWOWW8S027R9M5QTnCuuc1jM/u25e
         4r838oaTN7VoERkRaIeCnep6rAafpzCVPMXcIH++T/yqUdLBRlZ+4ATu6C2eHp1CRm0+
         ghygHbo+INvUL7W8nML8YeA0sMd7jgByaYYdBZ5eXit+TSO4kmkxuZoK/x31TMaZtK7a
         tUIdyB7RbzBZasuTAcYd1HqZazwunn+nFzTKFWKpO6kA7a5sD4hhTdWxBh/fke7Opbhb
         ncNB3FSqtnYTj9JblPUTcA/gX++7SbwEltr1RKhOt1dErpcQN0yMN08svf2eYrLS3Cb2
         vHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788938; x=1740393738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEn9cPK24lp71v02Bsnlb6m5L5JSngSvvSHBcZUpPRY=;
        b=ex5nPtWyhkFpdxNSR0p/In5LTzOZPnSrwE3XTFYhkypPWtxSTqWMx8nYw1LtIWJPK4
         xyRV0xZ7AMWUg4XihbbU8RWKKVXNypzlTn/mxKfk/LqQ3sr+HpOXMT03hw8aK5CvW9Xb
         Po5VmD9kJ3fJD26Ckc3/vH6ICiP4HuUEMDeh07PY6wdKKCRl1VgzHZcrpGFujrOb9u+S
         BhKPnv9sGweCzRCvxd1xDKuqs3XE3CVGgktdMOcK4rb8GUESRWI8iXhOi70/kgnboC2B
         EF+6DXKYCSYfSt/g6N11m+QNsSRzpp4zjLxgD+bG1kuL+hYph2rbg0z0PVoc2W02Q4RT
         WVSA==
X-Gm-Message-State: AOJu0Ywz0UjFM36PGkojXH5l8zvg8LNu1TgkO6uLuyPUeJUKkGB8CDvL
	tAEz4zfgogBUA/uMfqSd59gO2ZDEiBj4QfFV7DIDX3ZWduZGEUTWjmM2cn1zgdwFpzfJo7VSKBp
	kQ9WuQhcWmkwokNyiNAXSVoXwj7pD2g==
X-Gm-Gg: ASbGncuq6UZrBD47ey0VwMC+SR2Y0fRbYRd7hCCSZ7QR/sksIn5RZpVK5pd2ZIkXemN
	9mG3WhJ1adSYfO5/Tzuk/gCnavq+13tnZIOR8ush5pzdIg1kAMZd51sa6Qn9LQWDeQJcZ38g4
X-Google-Smtp-Source: AGHT+IFZy5s7/nqbdUpI/4Yz2MzzqfQtXV3NR3uqyfpldxybqCIXbS8OVe7y9QX3QnZIzDbrITfqEO+8N/6y7Z5Py5U=
X-Received: by 2002:a67:e709:0:b0:4bb:d062:455 with SMTP id
 ada2fe7eead31-4bd3fa97d37mr5322124137.0.1739788937956; Mon, 17 Feb 2025
 02:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-2-usmanakinyemi202@gmail.com> <Z7LdauBUSfqvyvXv@pks.im>
 <CAPSxiM8vcH_csM21vtF11APtxfNy_QC91mfYkctaSP-8TyPmyA@mail.gmail.com> <Z7MN8-9rzf7h9zZi@pks.im>
In-Reply-To: <Z7MN8-9rzf7h9zZi@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 17 Feb 2025 16:12:06 +0530
X-Gm-Features: AWEUYZm0f_6ezZVsPcYStI7e0RWabwzU1pWkbfcXJ1u4ZY-Y6TNryU85C0gn9mQ
Message-ID: <CAPSxiM-Bm9FtvVDJ_MggPFy_hV=h-ossk4p1z=ADGbttG=w-RA@mail.gmail.com>
Subject: Re: [PATCH 1/7] builtin/verify-tag: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, christian.couder@gmail.com, 
	johncai86@gmail.com, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:52=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Feb 17, 2025 at 03:35:05PM +0530, Usman Akinyemi wrote:
> > On Mon, Feb 17, 2025 at 12:25=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >
> > > On Sat, Feb 15, 2025 at 04:27:17AM +0530, Usman Akinyemi wrote:
> > > > @@ -35,7 +34,8 @@ int cmd_verify_tag(int argc,
> > > >               OPT_END()
> > > >       };
> > > >
> > > > -     git_config(git_default_config, NULL);
> > > > +     if (repo)
> > > > +             repo_config(repo, git_default_config, NULL);
> > > >
> > >
> > > I recently noticed that we have `usage_with_options_if_asked()`. Shou=
ld
> > > we use that function rather than making the call to `git_config()`
> > > conditional? Otherwise it's not obvious why we have the conditional i=
n
> > > the first place.
> > Hi Patrick,
> >
> > I think the function is `show_usage_with_options_if_asked()`. The funct=
ion
> > is quite different from `git_config()` or the `repo_config()`.  The
> > config function consults the configuration file for setting up config
> > values and it uses the `repo` variable during this. While
> > `show_usage_with_options_if_asked()` is used when the "-h" option is
> > passed to the builtin functions to display the help string.
> >
> > In a case when "-h" is passed to the builtin functions which use the
> > RUN_SETUP macro, the `repo` config will be NULL.
> >
> > There are some builtin commands functions that which has
> > the`git_config()` function comes before
> > `show_usage_with_options_if_asked()` or it's variant and some,
> > `git_config()` comes after.
> >
> > For those that have `git_config()` comes after
> > `show_usage_with_options_if_asked()` , no need for the check, since
> > the `show_usage_with_options_if_asked()`call will exit without
> > reaching `git_config()`. For scenario where the `git_config()` comes
> > earlier, we have to check the `repo` to see if it is NULL, if it is
> > NULL, we are sure this happens when the "-h" is passed to the function
> > and we do not need to setup and configuration since
> > `show_usage_with_options_if_asked()` will exit.
>
> Exactly, this is what my suggestion is. If we introduced new calls to
> `show_usage_with_options_if_asked()` before `git_config()` we wouldn't
> have to check for a `NULL` repository in the first place because we know
> that we'd have already exited if there was a "-h" parameter.
Yeah, that is true. Maybe having this as a preparatory patch could be bette=
r.

There was a previous similar patch also which has been accepted. Maybe
this can be done after this patch series got accepted, so, I could do
it together
with the already accepted patch.

What do you think ?

Thank you.
>
> Patrick
