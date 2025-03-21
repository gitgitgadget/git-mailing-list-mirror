Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3F2C181
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 02:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523111; cv=none; b=PzqYOu9QYpbhTSLN+n4b3mPkCoj1kImTC+lCX8Xkb051gCwIp5ij9HwZz0BQBqNB6PMWohubEkIth0ylkOqt5d+IncILCdddl3Ugtjxo8KqTg15qZ9wFqh8GrGyxroGyH8snAs92CBJvPPxRzUAahmUceThRM6BvIwf8+AFuCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523111; c=relaxed/simple;
	bh=BXqY5tyuzisXBA7mAQiPhdiT9ZdnEL/QeD32OWN4lDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6bB0sWvP1xf/adUXq3KhrdEk+ZLB+5L+DwKZm/6dlY28/q0CQ0RuTo6/1y5oQZj+HU6GTDx+LzVv+6c+VpB3/rcsohXoAVesm+9bMkDDFamjPrFnxsPRJp6n1gUGzKEF+BNEJjPuWaer9h/2QT6+HyD6b6BAMcGTWvvKOfdi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEiPeTE9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEiPeTE9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so2216795a12.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742523107; x=1743127907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXqY5tyuzisXBA7mAQiPhdiT9ZdnEL/QeD32OWN4lDI=;
        b=IEiPeTE9Umy5Mc6zyJMCSMz/D/iwotrC/89rTIj3kK7XHJi32EloBc0XLwkcwu/TA8
         TR82rViF/4bIniVHiU01F4pm7e5j/DYO05IM2GIZIUc7PzCGQJctlIISXqf4lhnLANlU
         hJG79He7aJzULj+ipo0Meh1sJr7/Yi38U0fi8u1OT+C4WXq5pSlW1RlWhwotVy71G2cg
         jURT170LklQ3mM5yg54v3BnZP+1geQ2jeOkVoNtVibr33gASs6Tt7lUHGi9bdbaV4l0z
         +BMr3b6KAS8Kq4p51hbvA9eQht4ZLLhpakOoCbMPDeKNO11OSueKbPfvY0VjQi6AGu/K
         q7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523107; x=1743127907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXqY5tyuzisXBA7mAQiPhdiT9ZdnEL/QeD32OWN4lDI=;
        b=SeY5axeps7BohoKbeW/ougJVd1Iu8UfxkG1PwP33jak53PZeF5TZPYsJkQChXseuQF
         uDvt8+wSHK/7QA18vguzE94If6fp36k/2LzCHCS8cfIbdl/Fy8sFxUoGdpieHeTccU/a
         ims3GjG9Q40nw0WMhiLq+dt0KO6narOwgxhOGHymJ5E25VUOaPIbuuovhAAkTmrH3DZi
         qSXFYg7IARYlJgN6JsxyR1hftDHpdyEejbGvMbpyCXdiC4Whxo2l5Cd6lKQmipe+kpCz
         zTIhpTZtusPzwpDTTYf0U+NPRq3fbF+7gknSKLbQENtcTNQE2GPdlk2h/ZagMnsqh7Dh
         nFAg==
X-Forwarded-Encrypted: i=1; AJvYcCW7h+iEDwJFDpjlbzuTrXMgmnPycMB46AoOF1p8CUSFib/tyvsqyjlHPf7Zv9xAaWpgIzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw486B5xg/huPKeulfAWC8Lke6oEve49qrBn8qHSMT4sEcrVWKo
	kiKEFra/aLPeHGLml8XdoWphrZ9cLeJCt5mEgQzjmnFDwqG8ayG0AaM50mm2q2fdWRoWEVrZU1/
	oi67HxpWcmSotrh14U2I6r/wSouU2tA==
X-Gm-Gg: ASbGncsGMinRFqT8NJQ4GhmxHkp+LpuHz7dGCG7hv9QXNOnc8sZynO51lNXkSnBOKt6
	TgX8H3MhxICmYES+wjPRMOL+O254Ll1/JO/V0ASg2S13ZyJ/bYEVUInhy2UI2C8pZCmSTMc2wyg
	JqPrs7y7WJx4aG8bw7zk8o0EKO7xE=
X-Google-Smtp-Source: AGHT+IEAsU++sdpZISPoArm//8IEk20zn7yyfaQc1vjBjEYMGt/hbEmuHQC3lzCACHpUx5WBpXCR8i6hdAdwrgSS7nE=
X-Received: by 2002:a05:6402:13d5:b0:5e8:bdb4:2891 with SMTP id
 4fb4d7f45d1cf-5ebcd51ace4mr1234717a12.30.1742523106670; Thu, 20 Mar 2025
 19:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
 <20250319172016.2115-2-lucasseikioshiro@gmail.com> <Z9vT-dqBzXxzXnlU@pks.im>
In-Reply-To: <Z9vT-dqBzXxzXnlU@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Mar 2025 22:11:33 -0400
X-Gm-Features: AQ5f1JpfeIU4ePFKHab-lLAPnctyT1HyG9v-iQy_1eUwpJzF8aamlN4BKDc_g0I
Message-ID: <CALnO6CACKrP=GZ-zB=4EWMjPv1RcvqgQuE5rzQM+V8C3PU3VZg@mail.gmail.com>
Subject: Re: [GSoC PATCH 1/2] userdiff: add builtin driver for gitconfig syntax
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:41=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Mar 19, 2025 at 02:20:15PM -0300, Lucas Seiki Oshiro wrote:
> > From Documentation/config.adoc:
> >
> > """
> > The file consists of sections and variables. A section begins with
> > the name of the section in square brackets and continues until the next
> > section begins. Section names are case-insensitive. Only alphanumeric
> > characters, `-` and `.` are allowed in section names. Each variable
> > must belong to some section, which means that there must be a section
> > header before the first setting of a variable.
> >
> > [...]
> >
> > Subsection names are case sensitive and can contain any characters exce=
pt
> > newline and the null byte.
> >
> > The variable names are case-insensitive, allow only alphanumeric charac=
ters
> > and `-`, and must start with an alphabetic character.
> > """
>
> I don't think it's necessary to quote this whole paragraph here, as most
> of us should be quite familiar with its format. I'd rather summarize the
> info a bit and explain how we can use the userdiff patterns for the
> general structure of the config. And in case there are any subtleties in
> the format it may make sense to specifically point out those instead of
> quoting the whole manual.

And, if we really felt it important to direct readers to the full
text, we could instruct them to do something like `git show
<sensible-hash>:Documentation/config.adoc`=E2=80=94in other words, the text=
 is
a part of this commit (and its parent) even if we don't (fully) quote
it here.

Cheers,
Ben
