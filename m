Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D81CFEA6
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448374; cv=none; b=t6Qcox+1W0T6pDkHsnoLC9MpYvRNcxAb8AHgqVj+jewDHvCN+7lhiziR3rjZ78ifGHm3OM56eba1e4AUqZ9uN1X6Npqz0NSusBtRfo8v1Y0GysX3X+PxQYQrVoNgKyLHWRYNEhn032qIqitOZrlcIBN900nMGNw04+sHWM3IPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448374; c=relaxed/simple;
	bh=GGcC4jEYKye1BA+UU32A29VwZB9whBFlAy3kyOLUtj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2pp2kkk/60FkiT9ZB1BhvFKYITHeOjhpMTJp0qrvWOgOtwi5Ra6Lt/tOg9cCrQJNBMjwdfTg7MSHbSbUiSfZZdp1qCN/cy6K6woeLRgw1HBZDe3ADJAjMQbsnjvX6JcWN+X4f87EXqDbXX8Rx6qS9ztPJ++33B/bt0RMbHxMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxpXVTUQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxpXVTUQ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86e9db75b9so713803566b.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725448371; x=1726053171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGcC4jEYKye1BA+UU32A29VwZB9whBFlAy3kyOLUtj0=;
        b=ZxpXVTUQq4fCUCuko4BGRJ7E6hwTTq4WXxhA7I0N8Y1wgAtlSuOMp2EJFnJ8uz90GU
         n4STkomZRbMwQNCjMQzPCt9E/VRk1swCGJXYn46Y/mJnyuUyy6KBj+eOie12MR5sm3WX
         /9A1NjPgujmcQCZ8VcS+WVFdIHai6vzrJGAYx3pCywjDMH/7Uo74REzmIUBQW+Esoeux
         wPReue3o2UlBb0K4OzlhzTafhU2c1H4nrmWQ/IFPN0KXi7XeWKYeS8QSmSrcSgxtF4ar
         c5IheQPF6SJbOl7O0Xo+wsmHScabDvYEDDx7sQXp9WGVz6HCQulmriutqQp3KR4kUTvq
         LT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725448371; x=1726053171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGcC4jEYKye1BA+UU32A29VwZB9whBFlAy3kyOLUtj0=;
        b=JbxjnBxvD5ku7d4ArzxH+qwJPw9gNIAGJOBqoAtW0agj11NEiV6fh1IQZ3zrCIkOtP
         utQUOflN7d2eqSTaldWiDszGnuKsumQLMq5QWyvOFX5WHWMyD8OVi41CB3WMRYW0p+eA
         2EefNQKMSVuVKzn4Y5R5Zq3JyJea4+RyYJktW4FSEq+Ci/8QR8KcHZQbdLzBYY5qtqEF
         I/qJIZg7RuAyhJXtoQUBI9ADgaGqLJJaRzdUbYQ/VGsPkZy+2qqHC07+0bhCuI/m2Fyp
         QyYkWNSZZmo1wPJM80i6jvut55EA0V66DNcyw3CdmuthHIOH3qF0IK8oNnpAKC5BoewV
         l4kw==
X-Gm-Message-State: AOJu0Yz/jnHTMgxilDooZGMwhFjWtrKQaGtgSriAE6L5lrJ9wbJIwgs/
	WGA1IWWmnzTLKzOPwYeh5ILh8HTc0s2sDYw5qHthh4tH9cN3PyxbKR8dMPm67Jz9RbZXWLPGQ35
	rU96G4hpUPDPpmtjtGonNZKoJ5avmheky
X-Google-Smtp-Source: AGHT+IHGkov26Vgw3RNUrcm7dOsYSD+OBO7SUiLHBXTy7hecNgug2kGUZIgbIMaCLz/ltAWcuzwbQJiEy/9qKbq+28Y=
X-Received: by 2002:a17:906:f5a7:b0:a86:9776:ef40 with SMTP id
 a640c23a62f3a-a8a1d32776emr536452666b.36.1725448370792; Wed, 04 Sep 2024
 04:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
 <a33a73f7-e6dd-4f97-a635-c6c5dfcadeb1@kdbg.org>
In-Reply-To: <a33a73f7-e6dd-4f97-a635-c6c5dfcadeb1@kdbg.org>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 4 Sep 2024 23:12:39 +1200
Message-ID: <CANrWfmRdz1Xxud=f0GWrc=nURV2xZU8Wm=8u2X+W4tL4d-yeTg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=60git_fetch_=2D=2Drefmap=3D=3Crefspec=3E=E2=80=A6_=3Crepository=3E_=3Cr?=
	=?UTF-8?Q?efspec=3E=E2=80=A6_=60_providing_NON=2Dempty_=3Crefspec=3E_to_the_=2D=2Drefmap_A?=
	=?UTF-8?Q?LSO_causes_Git_to_ignore_the_configured_refspecs?=
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1. If the doc says "providing an empty <refspec> to the --refmap
option causes Git to ignore the configured refspecs and rely entirely
on the refspecs supplied as command-line arguments" then it's
reasonable to guess that "providing a non-empty <refspec> will not do
those". (Otherwise the doc could just say "providing a <refspec> will
do those" without the word "empty".) This is both logical fallacy and
common sense.
2. Searching "empty string" "empty value" in
https://git-scm.com/docs/git-config shows that using empty value to
clear lower priority configurations (and non-empty values just stack
up) is common behavior of multi-valued configuration variables.

On Wed, Sep 4, 2024 at 6:15=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 04.09.24 um 06:09 schrieb Han Jiang:
> > What did you expect to happen? (Expected behavior)
> >
> > In `git fetch --refmap=3D'+refs/heads/branch1:refs/remotes/server/branc=
h1'
> > server branch1 branch2`,
> > `remote.server.fetch=3D+refs/heads/*:refs/remotes/server/*` merges with
> > `--refmap=3D'+refs/heads/branch1:refs/remotes/server/branch1'`,
>
> The way I read the documentation of --refmap, I cannot infer any sort of
> merging of refspec, only that a replacement occurs.
>
> > so these should be what would be done:
> > branch1 -> server/branch1
> > branch2 -> server/branch2
> >
> > What happened instead? (Actual behavior)
> >
> > In `git fetch --refmap=3D'+refs/heads/branch1:refs/remotes/server/branc=
h1'
> > server branch1 branch2`,
> > `remote.server.fetch=3D+refs/heads/*:refs/remotes/server/*` is replaced
> > by `--refmap=3D'+refs/heads/branch1:refs/remotes/server/branch1'`,
> > so these are what would be done:
> > branch1 -> server/branch1
>
> So, this seems the correct output, because it is no longer specified how
> branch2 should be stored locally.
>
> -- Hannes
>
