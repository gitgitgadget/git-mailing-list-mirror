Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AB19004A
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401333; cv=none; b=GFqiMwu6EZpI2Urk6ctTxPRjpYmKtVc1iFAExQ0yWxBO76YldmaI1447nJ6iC4Ae5JopdunmBWA8XkDhElqk2ZKJcxEU22ktsOhGbANrhgGzc7vDl5B9QWw0D4Exxnv9MoLVvNMwPwDbGp0wnd4niuO7sqYuliJ1LEPWw+94+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401333; c=relaxed/simple;
	bh=LzMXFJFe/XYsr2zz2Xa8h/36lSOLzN9/pQzeT8Jln+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjGSW+edLrtgeKqh5DiSZUMPFkH2uVFAw6NZIoMizwvn3unNl3bdVfVh1iBFVZsMQadkuZPaGd+4EiACgx3ydM2yFys2dldhfR9aZ2YXqRik89k6frfIDICyNV51F0PVQz9QbDhszpoAn7VIRnudVfcjXdwQKwBcd5J/qlmogUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQXV5Fhx; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQXV5Fhx"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so74524945ab.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742401331; x=1743006131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yrfpiv7E6+ty40dbWnLyfvnD0wXRR2NFxQRah950PdA=;
        b=QQXV5FhxdqDI0BwqY6hIKLZVxzCYzbl61kc+59MMfXSTkL2Q2qTFgsGepEu6o2PLHY
         6TY2jMUIdp0JCKbDJx7PchGCeB+Mrya9X3XN+m8QO0yU6BLSM/hLMjspv++y748knGad
         TbwH9M16F9dZ94eM9+YAl0jrakW6zlNDSFIkCtWLQ6zsB3QMfz/i1SH+PkR8mevPWwDX
         p1OqmM1kwrmIvuyDLNy9xD9q2ZGh8qmYglbsfl7Oov4EFfH+2w1MuaD8dZnI1ITyphpu
         EMsZX6/u9b/kwszglxL5mFJy7IcAWxOFTzhCkinMTCueM9IO+g/06ww+mKEqus0lUiLe
         1FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401331; x=1743006131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yrfpiv7E6+ty40dbWnLyfvnD0wXRR2NFxQRah950PdA=;
        b=LcC8zZWU2caGiwQPv2zOo0RvWmqsPIdR0PFbIvJLWCgGQPw9MW5wa9su9xaiDNATOv
         Ho/YXcaxlNvMf+vDA1+zVY6EmSCk7pH17/0nmivfH4CHRrNq1HvqPh7tJOAN3z07CAEb
         JxDgNtfmcYbP125NW3CjLNJdxfX+HXGHTb3q8bcMFuRijbOP6v3UpgnTPMDLzuicRCjl
         bj10ap5pKM4YJDlxUesmceDe2PFlMku3gNw5enUrTgBE1IIOLrI9oGT0rRdjutucdl7R
         3LRoAnOREubVv7HNgS0Jwa6Iwfnns56WvxF14uWe+JHd0Kk8uOb+kQohK24XRgshEho0
         YBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbI84dvum95MpPDG53Rk0KJUoUjqawJ0RFT8gOd/c+34CbwUttgexCW4tZIQGzCjrbD4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIGWzh8JobPHedfnXUixqTlGqZz8aelAIF7/jSg2dt5ce9nEZ
	SG/z3uEzZc3SgC/gfBEN5QDeJnhjkkL0zXiqhQOfj7V4fn+prGRSfiFRj+yuwDc7zwlGqBw4dvc
	lhWMJ0m+5eHY/5Cwq65GLbxkTUP8=
X-Gm-Gg: ASbGncsWmW/BFz5wMs7gEhwXFfSg0rNrCyLYzHgQHtwFyK+BevhRCdnz8AoJjYGi16w
	Bg6MJl0fPH5wiXx+AxhbMuBCJxV+y0i/SK4uuHSnRcuKasQr6FxZwlU3WiRwfeOuMstYyj7fxWX
	rRFdyBoPzjy4+T7rcrj36wA9MebJALtX2S1XSzer8MJSeam3A+671iHw0XXHY=
X-Google-Smtp-Source: AGHT+IFErSDCTVmBKRyQFlTatZvSXDVmsORdixEB5Z7L9kSaO1gxolqTS5zQeeHo19eQ+TfR+hDVFdKM8TC9JTIEWHg=
X-Received: by 2002:a05:6e02:1f11:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d586bbcf34mr39118545ab.18.1742401331375; Wed, 19 Mar 2025
 09:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com> <58cb8f6a1609b10d761e86bdad541d1c018cb582.1742107322.git.gitgitgadget@gmail.com>
 <Z9iinbyrn4PeFmCl@nand.local>
In-Reply-To: <Z9iinbyrn4PeFmCl@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 09:21:59 -0700
X-Gm-Features: AQ5f1Jr9URzZXgkYCrKSm_uB7lMTGi19v3kmeE8H40P2exJso-c2FcnzI482a3U
Message-ID: <CABPp-BHxYec4LBTrhg+Bq9NrpyGXkt8fBgofuy=D3X2ArM6wiQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ci: add build checking for side-effects in
 assert() calls
To: Taylor Blau <me@ttaylorr.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 3:30=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Sun, Mar 16, 2025 at 06:42:01AM +0000, Elijah Newren via GitGitGadget =
wrote:
> > We have roughly 566 assert() calls in our codebase (my grep might have
> > picked up things that aren't actually assert() calls, but most appeared
> > to be).  All but 9 of them can be determined by gcc to be free of side
> > effects with a clever redefine of assert() provided by Bruno De Fraine
> > (from
> > https://stackoverflow.com/questions/10593492/catching-assert-with-side-=
effects),
> > who upon request has graciously placed his two-liner into the public
> > domain without warranty of any kind.  The current 9 assert() calls
> > flagged by this clever redefinition of assert() appear to me to be free
> > of side effects as well, but are too complicated for a compiler/linker
> > to figure that since each assertion involves some kind of function call=
.
> > Add a CI job which will find and report these possibly problematic
> > assertions, and have the job suggest to the user that they replace thes=
e
> > with BUG_IF_NOT() calls.
>
> Very nice, and thank you Bruno for placing your very clever assert() in
> the public domain :-).
>
> I wonder if it might be useful to explain this in
> Documentation/CodingGuidelines as a follow-up to this series. I was
> thinking of a scenario where someone either writes a side-effecting
> assert(), or a non-side-effecting one that is too complicated to prove
> otherwise.
>
> If that person runs 'make test' locally, they might not see any
> failures, but then be surprised when CI fails on the new step. It may be
> worth mentioning that we have such a check, and that we expect all
> assert() statements to be side effect-free, and that developers can
> verify this by ci/check-unsafe-assertions.sh.

The same could be said for coccinelle patches, hdr-check, check-pot,
fuzz tests, asan/ubsan, GIT_TEST_SPLIT_INDEX, pedantic build, osx, vs.
windows vs. linux, and perhaps others, which users won't catch on
'make test' locally but can result in failed CI builds and aren't
mentioned in CodingGuidelines.  I usually think of CodingGuidelines as
being the place for documenting things that can't be tested in an
automated fashion, and a brief mention that both cross platform and
additional more thorough but non-default tests can go in
SubmittingPatches.

> But that may bring us into an assert() versus BUG_IF_NOT() debate, which
> may be somewhat counterproductive, so I'm just as happy if you did
> nothing here :-).

:-)
