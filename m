Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4B20B1FC
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501427; cv=none; b=TzniPQCzTY+7p3eDJQcalpkZx37VzCqberlnEJ+VPT8sc8czRUq7lXSWbAxrVO64HfKJYdWO4f1KLzVQHujQKh01J21Bz3ozGJzBDhQD9mn4H6VldUkwHyiHoD+GwqlceWWbBI3T4L6e+dZoQenowTWhm2FTRG1o0WSdAvveASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501427; c=relaxed/simple;
	bh=8XseCAl8/0upJTmqA70jdp2kjsVmOj7Peot2PPXo/cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTiUnSbtdhHEA0HFP2TtfpvOUIIiX3Ckm+In90PelUnmttei8usLk+meNgROlfNLiBQZd73wVfxXNkgYvNRnO9T3PBs45QOzxvOjM2hSpVqZyc0DbazXciEJ6rbGYDjCsI9uqDg4L8Vn603o1xB8SCgovbEFJH3+RH2CT0wqaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7NeutPX; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7NeutPX"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30039432861so17118111fa.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 01:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736501423; x=1737106223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5895NvAlAcdZtJcQlPf541nXlilG9LT10ypFAdCFNPw=;
        b=j7NeutPXDu6dGVPpCSJGcO4UkVOSVBMDDWb8hy9TQz1VGVd0bYZh0V9j3ptw1nHQHc
         pLRs1mLzip2G4ejrxSuz8YMJ81ocbkIpbk3bYEQLFqfMxdHHPQvi5Po0LL8MfXYo7TU9
         /s0ymZGvg3Zo4uA/pwDKHK199nLHFu+8ZLb1YBN90ZznZFRvoGAq+HFGNC7ZTNy9zas3
         eaKYcMPfg2zfM9nfytO4tWT5kvyH81UHr9LnLtVOVWSjZqdhX6vfg96kVgTA3sN/HSdh
         lH8dtSzKTReHRH5HK+gGKIPLQlaVy420alvFuC9pzx//JCFB3j2qnyX7Xh9TcrWg3Vwe
         kLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736501423; x=1737106223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5895NvAlAcdZtJcQlPf541nXlilG9LT10ypFAdCFNPw=;
        b=v8qor1uSR8YqrUGTFdbrworzYubnOJisHghNmzz9kagJHErslgqi0o1urFRisbPyjr
         K/wNanLBHkQGwUCFT2zDy1fV1KdUSSbQq7bjRElzS7cVGOBRkwi9TP4n2O0IvQFe95JY
         wbA2/vLq523U0Xhm4SSjQm9oJ+GNlsabt1rwrIJ17FI0WuB/GTu/gyZ+SFVlr5UHZpKB
         q89lpFpuMzNyGuHRwofLETKUHktvngKwE5MMpwAQcxCNypBKp9TnSd3IwyuF04zCG+IT
         L2jV08N+E+NEpq6lJQjSvh1LXc0Am9pgX6n4JF6huKlcBTLwloRD/wlKQNXd9/5tIkyd
         DLsA==
X-Forwarded-Encrypted: i=1; AJvYcCXZDl1gSeyoURdYTHwIQfUOy/gXH8g71ZnGVlgU51IUknkb6ews+fkT9j3czqRFPw+qk00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3c4+oWYjjsrKBVWUcY+fdWOIG2brRG10MMjmP/i7yc/M8oTni
	+i1Po3mUbeMcruXelddq8uRIvU5pT5r+pX8Sa/gwr3N5QE1tZRnDjwZaCpKiTvYebp+gYyP+FCn
	8hyJxsFhsFuQnRbxS7jPNMGMLMmvV2tdg
X-Gm-Gg: ASbGncvvh+/nxHyNpxs36ceTYB+jgwN1p+PhPdzWGqwvsaQGJWXCVpVJnjKcGq6TgTd
	4ldKWhGDFSbhAuBTwQaU12rq7YnIA3Cg2proGUY1asMgkgpvj34/78cKZ5F9Z2xDMUyg+vA==
X-Google-Smtp-Source: AGHT+IF+Wj8sIMDYhZU8tBIuS+mqcDMAr732laXeYUCPfil/+ELYBjoIrOF+fEf68zlR+rzit3SsI41Ysy+BvSIO4Tc=
X-Received: by 2002:a05:6512:128a:b0:540:2122:fae9 with SMTP id
 2adb3069b0e04-542845b95d2mr2872714e87.46.1736501423184; Fri, 10 Jan 2025
 01:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
 <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
 <xmqq5xmoj6cz.fsf@gitster.g> <CAP2yMaJzHM+AyDwjfVNJrDeJt0iip5h_ZxgNJL3V-gVSOjoBWQ@mail.gmail.com>
In-Reply-To: <CAP2yMaJzHM+AyDwjfVNJrDeJt0iip5h_ZxgNJL3V-gVSOjoBWQ@mail.gmail.com>
From: Scott Chacon <schacon@gmail.com>
Date: Fri, 10 Jan 2025 10:30:12 +0100
X-Gm-Features: AbW1kvYiSxCKRMzBwdM5GbQwAYPxfQVE9Yh6U3WhbMsLjTbi6p_1yUaob3Le3xs
Message-ID: <CAP2yMa+5ca22tNMc4qu=yBVd9t74uNnLFbKE3_=EcA5_goM6zw@mail.gmail.com>
Subject: Re: [PATCH v2] help: interpret boolean string values for help.autocorrect
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Yongmin <yewon@revi.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 8:43=E2=80=AFAM Scott Chacon <schacon@gmail.com> wr=
ote:
>
> Hey,
>
> On Thu, Jan 9, 2025 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > The flow looks nice, but the pre-context of this hunk starts like
> > this:
> >
> >                 if (!value)
> >                         return config_error_nonbool(var);
> >                 if (!strcmp(value, "never")) {
> >                         cfg->autocorrect =3D AUTOCORRECT_NEVER;
> >                 } else if (!strcmp(value, "immediate")) {
> >                         cfg->autocorrect =3D AUTOCORRECT_IMMEDIATELY;
> >                 } else if (!strcmp(value, "prompt")) {
> >
> > IOW, the new code added at the end of the if/else if/ cascade is way
> > too late.
> >
> >         "[help] autocorrect"
> >
> > that specifies "true" has already been rejected as an error, with a
> > now-stale error message saying that the variable is not a Boolean.
>
> I'm not super familiar with this codebase, honestly, but ifaict this
> is not what this does. That top block makes sure that value isn't
> null, which I can't figure out how it would ever be - I've tried a
> bunch of different config values, but I'm not sure it's possible to do
> - and if so it just prints "missing value for help.autocorrect" (the
> nonbool part of that function is something of a misnomer, it appears).
> But again, I can't see how those two lines aren't essentially a no-op.

Ah, I see. You can leave off the `=3D` and that will trigger this error.
Though it seems to simultaneously be seen as a configuration error.

  =E2=9D=AF ./git test
  error: missing value for 'help.autocorrect'
  fatal: bad config line 19 in file .git/config

But if that's the only way it seems to trigger this code path, to
essentially have a corrupted config file, does it matter?

Scott
