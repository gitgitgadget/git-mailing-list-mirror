Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C73590A9
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657236; cv=none; b=bk9Tqx4ub7PZabdXCDlNFGA6vaBDWOSWeaQAom3/OcQTrkPG3FeJ/9TBY4zBsQ0/cPpdbNm4ZTEojyXin0dwMyflFT2xOVwLsuqebbKv70DbYZBMzg7uz75ZzSxDjQvZtc7O00H0fBLREYvLL6sEwROB2FE7l+3B9zr24BnrLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657236; c=relaxed/simple;
	bh=SNFjGOMk6KzTwCWU8dm6PTpA8BGYBnfrVi9U3gAxDXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZqfQFppWbxAOIe9pivWyb5PcvgOxbrm5IB/Buf3bQgn6RVyUB/i/17q90Xqk4CQ+9hSaPqKSuqSvgKdcTjm6v0tQwe5EVSwSDlkrzDlWGLVS8V9Pw69Q7zQK9mVZZeiZvS/cIR1L9AX12HfNWKQlxHuKxe2wWC5j2814Kr/pms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnjAgfAY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnjAgfAY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297ef378069so10731385ad.3
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 08:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763657234; x=1764262034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADwKpGqTjySeHWj0Lx16zbTI6/mPjouzlECE1iR8ocU=;
        b=BnjAgfAYfU7WQPhCuPKdU33LrCmskMT8F6C0/5nrwqr8QzbE4mF+xw0yRypmMimdVl
         LxKNMgsA9fZf0ZOwTC7LX1w7WAoRWKczIrl0fW1PVw8FMuHAsoOc03dyCXwgebFORQH1
         /wgbti4G7lIJ+JNz9hSTqBF07XG2myqUNcGSG4cuYZ9rNiVj5aPy1xFnuoLEG5oj41SD
         KWd/rEblMlWJXW09ejJtVmbfKw++KSCGi94tyaP3i6bEVlBommAhoG56asPiix3oDtpO
         NdKx3PWFc5vrd47UodMn5VxjqM7mu6glSLuX85Hm6VP3WO87q/0+wXF9V3EMTD04Hlej
         HxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763657234; x=1764262034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADwKpGqTjySeHWj0Lx16zbTI6/mPjouzlECE1iR8ocU=;
        b=SQ3O8JJrphs6HiL2BN8Qszh5KSNlA+8zyHdiWKj/I+tjzsG0C7HSW+BS1HhLxtAWbl
         Oyjh7Qu/uBbiPQXXcNgj1lbIAkEo2ML03ATncvJkwIZK8hk/yuOgc/EMCcA6+F16ensG
         luHB6sSy40ZvIMoucuHNfz6QjcPRvkS+ogZQNydVmuWgoIqd+fn6c2prnePU/rMdGkEx
         bZkxmYAZjBqQ16JuenZbum1K55GpbzHjws0isGKaQOLzjPcluLdS3mP55ezPT8bDcj0V
         8DHw/5L7605+vSzRiHQvwutm9BxMb3y5BZr1qfVWw5wxtH4Z6PBRroMZPgQRbyWp4bSs
         7GKw==
X-Forwarded-Encrypted: i=1; AJvYcCVNR0kuyKEqqfx9TC6zBrCth3DrtPfyORNR43/hY9ROUHeONVL/aN/PGJ9MkEtKoGiAQkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTBUahw6H9tVggLPQ/GerUpsFyJDMVFJVYydyXjSJknoBpSIY
	WWjM1uQqx0y4wy2OBQJMYHzs8R5n0sQzl+/2BUEuiVKPy8MxkY90FoCDlOTx3+eJID9mq5IRerX
	FM8nq7JfAz8Ir42qsrIAxtw0yBycV/9LvmmtEDzE=
X-Gm-Gg: ASbGncspDa8BGHX5OkCtO8zqHZcmdtx4Hdp1OIBVEUbYBYhq35xrgZIwM+XHpXY9hZJ
	BtNYGUiPZ10c7lKKIbx0aPn++j3sBSmqOLvj0/zv5PShP/r+gQtD0ryv24G90L+EBOcpAZNC20Z
	4yiRtIoMeS72u/8tiZIScw97v++EvhAJHJpQ44LpXUfDP//fXeYghfUoupy/4+2JLinkOa6I3mM
	tFJ8pkDjCq8rTdW2TLAUPRKiP8kxR0d3C3r6qpoUziQL8iSjvYbShQZrq5aLEqjpshBSaRWCWS7
	B1WFQIM=
X-Google-Smtp-Source: AGHT+IHcLPj1RyGQg2bxYVLaHNmgP1B4W207rsXM7Yz0wN1+t4jHK4WgXY4jDmYZWOtbb6PKPBdjBlofyMpye+gOxJU=
X-Received: by 2002:a17:903:2d2:b0:298:321b:2694 with SMTP id
 d9443c01a7336-29b5b06fe37mr48807035ad.19.1763657234511; Thu, 20 Nov 2025
 08:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org> <CAF5LJ4D4q2S2VFhvEgVOe1Ar0e6cu=H3e_o_98VwHN7wYHh+DQ@mail.gmail.com>
In-Reply-To: <CAF5LJ4D4q2S2VFhvEgVOe1Ar0e6cu=H3e_o_98VwHN7wYHh+DQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 11:47:02 -0500
X-Gm-Features: AWmQ_bkW1-wUFjv6gUq0IZLmOhDv769xgN4MFYzlOC_cqRnuvXOSMJBwJdkgCXU
Message-ID: <CALnO6CBFKjewrkPeEUh7Q-A2dZ7Fknjy4DszG8xCKu-NvGETfQ@mail.gmail.com>
Subject: Re: [PATCH] diff: "lisp" userdiff_driver
To: "Scott L. Burson" <Scott@sympoiesis.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jaydeep P Das <jaydeepjd.8914@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org, 
	"Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 6:33=E2=80=AFPM Scott L. Burson <Scott@sympoiesis.c=
om> wrote:
> > >
> > > Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
> > > ---
> > >     diff: "lisp" userdiff_driver
> > >
> > > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-200=
0%2Fslburson%2Flisp-userdiff_driver-v1
> > > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2000/s=
lburson/lisp-userdiff_driver-v1
> > > Pull-Request: https://github.com/gitgitgadget/git/pull/2000
> > >
> > >  userdiff.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/userdiff.c b/userdiff.c
> > > index fe710a68bf..e127b4a1f1 100644
> > > --- a/userdiff.c
> > > +++ b/userdiff.c
> > > @@ -249,6 +249,14 @@ PATTERNS("kotlin",
> > >        "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
> > >        /* unary and binary operators */
> > >        "|[-+*/<>%&^|=3D!]=3D=3D?|--|\\+\\+|<<=3D|>>=3D|&&|\\|\\||->|\=
\.\\*|!!|[?:.][.:]"),
> > > +PATTERNS("lisp",
> > > +      /* Either an unindented left paren, or a slightly indented lin=
e
> > > +       * starting with "(def" */
> > > +      "^((\\(|:space:{1,2}\\(def).*)$",
> >
> > Compared to the Scheme driver, this regular expression is
> >
> > - more restrictive because it does not permit arbitrary indentation;
> >
> > - less restrictive because it permits everything that begins with "(def=
".
> >
> > What would happen if this regular expression were added to the Scheme
> > driver? Would it pick up additional and unwanted hunk headers is typica=
l
> > Scheme code?
>
> That is a good question.  I don't think so, but I don't work in Scheme.
> I see that you have CC'ed Atharva Raykar; let's see whether he would
> have any objection.
>
> I would point out that Scheme is a dialect of Lisp, not the other way
> around.  (Lisp is unusual in being a family of languages, rather than a
> single language.)  And having a separate "lisp" driver might aid
> discoverability.

Without "going there," I think there are enough differences to warrant
a different driver. (OTOH, I have sometimes wanted to teach the Scheme
driver that most "def" things are probably definitions.) Our
indentation is less rigid in that indented forms may be more deeply
nested than only one or two spaces (and we of course have more
definition forms than "only things starting with def"), and I don't
understand the downthread desire to not permit tabs.

As for Scheme community, I'll suggest asking on the Racket channels
(Discourse is probably best if you want a mailing-list-like
discussion?)


--=20
D. Ben Knoble
