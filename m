Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A371E5713
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352354; cv=none; b=l7peKqvTplCUo37RdUvGGQn+CPPBX87l4XDxB18MIoPux37nwp8zd9ubaTKV/ZMJHRNlHE61BtEe+jv9XKV511mjR5LxwNzm22uwNru/B04stGaoSyD1FT1WLF7ohZpI9Eihg+WIq1JNvJZav8RouVXrpj+x6ce+DECWjUBmAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352354; c=relaxed/simple;
	bh=US/XAlBtGyG25+cImjI2kaVN7XLJCoWfx9Soeb47HkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFkQ/d402K6G5WCohgJ74WoIVR4a7qw4EEHP9jSlLP9210pP8vaBioZwNC5wozv1S9XDU9fzmtlYzRDzizNgG+XN14RmfxT/eHM3dv1hYm0tNzJYcGROOO67B6Uooj6oaD1x7XjVYNpPuaPKDG8YIEzmZaz8VKjwLFrfXG4xTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLUG5UJl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLUG5UJl"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso388845a12.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745352350; x=1745957150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CghNa2h32kmu1cSbYrLfPBmPOEtoNcZee+1RNl3/UZ4=;
        b=XLUG5UJlFvhtxR26TkzDV8ABIQQVWvHZMOcaRIgHfhjbLtwWWBveKMjyibtS7PHHGm
         5RfksoVaF4dmlr/z2t3BNm7S+ziUAjksnBzmkC3dN6n3EEaJuW/JtYeJf6pIUXIrzlRU
         Q+7WtrlqOuvNdaotMFGVdnx4t69WvkmTq8N808oozEIT+EWtr+rECojewwXfBTBycCWZ
         nsDAJ0zWbx4imyuCx0rhNPQe4Of+1GqRpMlUs3mgoZzwsqpzm02u21aR4IHpWX00rTPa
         Yq8dp70N/NM504HuXEh6eprmy6BwlwU/l8Mm0+sAGabyE9fQBAYddZu7hHH0CwgaZBkg
         NpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352350; x=1745957150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CghNa2h32kmu1cSbYrLfPBmPOEtoNcZee+1RNl3/UZ4=;
        b=xBx/PqduGtnfL5vrAvZtD9O3pd2qfao426MKHb/7zFw0RiemkfvOFGjN2sdW6O6UGr
         p8brhrhsa/U6qDEtRSPPkXvaU+Ia6v7iZ+dKhaYJmLR5R7EisW1KLD9kc0/sfCpvgyaU
         YrL7ExXpaj06KfyIig2e8jsc0e4y7Z4SOpzqBhUTaa4elzY21WFGgGctrRILacQU9WQ+
         JsN+KzyZK+Djlufw+9GZK1l//r8EtxqVT4o3SwC919EjSISegpne9dvxaj8eFCYq4Pj4
         0xfPAKSt87AtzCXAhOJJKvFP0PZpRwRosegB94wniJh4lMJZvhrScpLAEJpTatShX115
         WnPA==
X-Gm-Message-State: AOJu0Yzjft9EqRW7htSjqII5SqNe/AXNVhT3L70ckscR3JtXJ1XvEQCJ
	cm1NPI6yJyjbNdeEuXP3DWOvBp/YYIZhlsOjV41X+ILkT1IJENOe/d6jCCia/DVNhkkgQh+jtxK
	KYFr45ptjkaWXQGwvGHLpVNsj76g=
X-Gm-Gg: ASbGncvPuwpAoL3vIe/RIniABPmoe+1GpOqp6ct4s2yKeAgk4AKhKV92/aU4vFcLNQG
	ikCQbaYRHkWxQmbaqMlV7p24UBUZj+FHuMi4GMt/FR6MURkkJTbTK+u3ZvmHUc1XZxdfNonu/c+
	nLaQZ1iiNZQZBajDYSKIsgPaEUL+4ZVB2Mndy9CGYYiDge7tzvY3JngFE=
X-Google-Smtp-Source: AGHT+IGW1jNmhcWRxdbSeY2iiKadeof+lXOXg50hCTjX8bXVPI/939OnGCNeV4ortFa4F5qfkxA/SKg4aCzP6tvDCaQ=
X-Received: by 2002:a05:6402:234f:b0:5e0:6332:9af0 with SMTP id
 4fb4d7f45d1cf-5f6cf46b0f8mr268827a12.14.1745352350398; Tue, 22 Apr 2025
 13:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g> <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
 <CALnO6CBi-c9U-UskTzjNBH+k8VQybdSshYgs+A3_DRH-iz7zHA@mail.gmail.com>
In-Reply-To: <CALnO6CBi-c9U-UskTzjNBH+k8VQybdSshYgs+A3_DRH-iz7zHA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 22 Apr 2025 16:05:38 -0400
X-Gm-Features: ATxdqUEugitUczF4gtIzYwjiwtObQMgwv0tzYnqrQSSZTA6oJUtUA_v_0VS7MxQ
Message-ID: <CALnO6CDq5BRogPCcDozTi1NEYL6nCoEDaNkFdq2+1V6vVRy=1g@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 3:58=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> On Wed, Feb 5, 2025 at 4:14=E2=80=AFPM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
> >
> > On Wed, Feb 5, 2025 at 12:42=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > >
> > > "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
> > >
> > > >> So, I dunno.
> > > >
> > > > Agreed that if pull.ff=3Donly is supposed to override all other opt=
ions
> > > > (except those on the command-line), this might be wrong. And `git p=
ull
> > > > --rebase` works in the scenario I described.
> > >
> > > Yeah, I view --ff-only as a safety measure for the user to say "my
> > > workflow is to make sure I do not have anything locally cooking on
> > > my branch when integrating with the other side, and stop me if I
> > > somehow made a mistake".  If rebase or other options override, the
> > > folks in the rebasing camp, unlike in the merging camp, cannot
> > > benefit from such safety measure, which worries me.
> >
> > Is there, then, an existing combination that means roughly to treat
> > `git pull` with no other options like this:
> > - if not rebasing, forbid merging and be equivalent to --ff-only
> > - if rebasing is requested (because of branch.name.rebase or --rebase
> > or =E2=80=A6?), allow it
> >
> > In other words, something like a pull.merge=3Dff (or ff-only) meaning t=
o
> > apply the rules I've attempted to describe, in which case I would
> > leave pull.ff unset?
> >
> > I suppose pull.rebase=3Dtrue is close, but is not quite the same for me
> > (I'd like to be warned when this would imply a non-fast-forward for a
> > main branch, though the "rebasing" logs might be sufficient)=E2=80=A6
>
> FWIW, I found some tests that indicate, to me, that I should use
> pull.rebase=3Dtrue (or merges) + branch.<name>.rebase=3Dfalse for the cas=
e
> I described: https://github.com/git/git/blob/08bdfd453584e489d5a551aecbdc=
b77584e1b958/t/t5520-pull.sh#L505-L514
>
> So it turns out my itch was already scratched.

I left out the commit reference, whose message described what I think
I originally wanted:

> my main or master branch is typically fast-forward only, while I want my
> topic branches to be rebased; preferably, all of those things happen
> for just "git pull."
