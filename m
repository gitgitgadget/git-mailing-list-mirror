Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805051C4C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067926; cv=none; b=HnLM/Sm97j4EHlX6LI+9drmuoPnTVRxBWAfKI3m2po8fT1Di0dm8Qc0g9tVCBApsIfTIvbwKr+fWtZp3tjMllABITuk/qTZMQIaVEzYGRgWHrEJs9LtVAvM0EF/kFK1cQJbV7oZbaa2EtmeWbbrUZHIQUk2ADX4KVyHeg7RQQ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067926; c=relaxed/simple;
	bh=sAUap6Ah413hrIh3yAnCkLTPFzMERDW1cxNxb/kVcxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFvNJBTXzSglDGr2hwxxXneMpFb2QAFZVwKIbIfcFFpqA7LosuyRMjQxuIVsBwnFC1+Gh/ak7NQgoOyjIrFBOJW4GWo00bLq408M4mr3l0srCXunx4eVxy0kGR1wTKNjv1OvLyAGkOGXFO8RPLw4brNRWqFlcn9jegxEg3tuIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3VZarxd; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3VZarxd"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3964581276.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709067924; x=1709672724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzTFTdA+fXO1hF5oqhPGIXUCLBln9OgbDRa5YdmmNig=;
        b=d3VZarxd5N+eIz5ynKtC5Ha+KAqCoGXKcplR3LhEF58aPjDudB+3ac1GQ3NCJf5bzU
         Ml3lroIJ4xW8X/X8Ff4U5y7TK3oBXHrGmEt/ZGgexvRrkFTu2Pnt+Kw3s1QL5dHVO3u2
         eXXH2HizkYJIbNBdG3FYRim/udOUSZ/3a4o7Mdo26xtTXCDAmTCgfh0VFlEFgbboXVdy
         hINA0mRcAO+4MQObFU1akIKQYoYJorScR/IzTMN53tRRZ/mBhyWhtvVhfbDuwMrRs//l
         Vxjj+CkEGho2MlbCD9unLozCPj3pCE07r2Bg5tT+64VTMfXVhdcsRiLwSmo3iLGZX/MN
         oYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067924; x=1709672724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzTFTdA+fXO1hF5oqhPGIXUCLBln9OgbDRa5YdmmNig=;
        b=juhWslhajUsSnJQDqjFBCMHcb13y7ybFbgB257hR9YFGKQ6929cN9yswARmzmPF6Q4
         d8idqM8NQ+IGyVuR97kP5meRlpLat5VpwA4bSh4c0sUpTvOcDvY31brYG6fIkLk/N2J3
         xQ3d/yhf+ZS4L629kQXRRUXkkJ0nlsqYU1k6JjmKpDqewXhOnkvnNTF0ES27bRS+KV/d
         a0piqQ+yGXJ6v7I7xmX2r3qnRhPVuwH9OOYS2ZsJ1go98bVNAREsVhLsfFNIAoXHIae2
         ixmbleXpn+YiRPMOX8XjFRdypU8gyRLamx1kiZfEdQzC82C+xZBhBQQ+7QTnTKn0MvwO
         tD1w==
X-Forwarded-Encrypted: i=1; AJvYcCWyQ9DgCc4zASZE65IC6XBWNlbenbWcaNvSEmyV9oQKa0aW5OOFSx+C3m5UhL0efAaRh0vQrqEbQWHg8dKsc7HkDMWA
X-Gm-Message-State: AOJu0YwOqM3OLQIrQ9izEhcNw2Z7Dmn96N9iCv5hl36SrF87fEsWn6tm
	ZK2j1Q1RxOnLdFQHywRoKxYH0v/rerHFM6bqe2BHZXPfk9+8u1HCg8powVwuUWktgnYP6LG55hD
	4IxCtR+DP+kNcDlQbub1wDJZWb91d7QajYKg=
X-Google-Smtp-Source: AGHT+IHPXRzRjNO0uyW+oRQP4yI+eeQ7iaThnuHpenK5V948Vi6m7w26OkbGl7sU5szO3kAgZatun8kOJ32tFRiY3j8=
X-Received: by 2002:a25:684e:0:b0:dc7:140:8c0c with SMTP id
 d75-20020a25684e000000b00dc701408c0cmr679041ybc.23.1709067924056; Tue, 27 Feb
 2024 13:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227160253.104011-1-sergiusnyah@gmail.com> <20240227160253.104011-2-sergiusnyah@gmail.com>
 <CZG3HO25QLAG.3Q9V03SCO99HL@gmail.com>
In-Reply-To: <CZG3HO25QLAG.3Q9V03SCO99HL@gmail.com>
From: Sergius Nyah <sergiusnyah@gmail.com>
Date: Tue, 27 Feb 2024 22:05:12 +0100
Message-ID: <CANAnif8w-MFcp04s1dDffmGsLGYhsKYkXGTLEQqVrt8zm=UpEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns
 for JavaScript function detection in userdiff.
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: christian.couder@gmail.com, pk@pks.im, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:06=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> On Tue Feb 27, 2024 at 9:32 PM IST, Sergius Nyah wrote:
> > [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns for Jav=
aScript function detection in userdiff.
>
> I think these prefixes somehow got added twice. In any case, this makes
> it so that "Subject: [GSOC][RFC PATCH 1/2]" is part of the commit log,
> which shoud not be. And the subject can be better written as:
>
>     userdiff: add builtin patterns for Javascript
>
Noted, thanks!

> > This patch adds the regular expression for detecting JavaScript functio=
ns and expressions in Git diffs. The pattern accurately identifies function=
 declerations, expressions, and definitions inside blocks.
>
> commit message should be wrapped at 72 characters.
> > ---
Thank you for the correction.

> >  userdiff.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/userdiff.c b/userdiff.c
> > index e399543823..12e31ff14d 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -1,7 +1,7 @@
> >  #include "git-compat-util.h"
> >  #include "config.h"
> >  #include "userdiff.h"
> > -#include "attr.h"
> > +#include "attr.h"
>
> This change adds trailing whitespace which is not desired.
>
Okay. Would avoid them in subsequent commits.
> >  #include "strbuf.h"
> >
> >  static struct userdiff_driver *drivers;
> > @@ -183,6 +183,19 @@ PATTERNS("java",
> >        "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> >        "|[-+*/<>%&^|=3D!]=3D"
> >        "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> > +PATTERNS("javascript",
> > +     /*
> > +       * Looks for lines that start with optional whitespace, followed
> > +       * by 'function'* and any characters (for function declarations)=
,
> > +      * or valid JavaScript identifiers, equals sign '=3D', 'function'=
 keyword
> > +       * and any characters (for function expressions).
> > +      * Also considers functions defined inside blocks with '{...}'.
> > +       */
> > +      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=3D[ \t]=
*function[ \t]*.*|(\\{[ \t]*)?)\n",
> > +     /* This pattern matches JavaScript identifiers */
> > +     "[a-zA-Z_$][0-9a-zA-Z_$]*"
> > +     "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
> > +     "|[-+*/<>%&^|=3D!:]=3D|--|\\+\\+|<<=3D?|>>=3D?|&&|\\|\\|"),
>
> Majority of the lines above (including comment) have trailing whitespace.
> Consider removing them. Also, tabs should be used for indentation instead
> of spaces. (cf. Documentation/CodingGuidelines)

Well received. Thanks!
>
> >  PATTERNS("kotlin",
> >        "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
> >        /* -- */
> > @@ -192,7 +205,7 @@ PATTERNS("kotlin",
> >        /* integers and floats */
> >        "|[0-9][0-9_]*([.][0-9_]*)?([Ee][-+]?[0-9]+)?[fFlLuU]*"
> >        /* floating point numbers beginning with decimal point */
> > -      "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
> > +      "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+ )?[fFlLuU]?"
>
> This adds extra whitespace in the middle. Changes not related to the patc=
h
> topic should be avoided.

Sorry about that, I just touched what I shouldn't have.
>
> Also this was attempted before, see [1]. I think you can take some
> inspiration and inputs from that also. Aside from that I think the
> separate patch which adds tests for this can be squashed into this
> one.
>
> [1]:
> https://lore.kernel.org/git/20220403132508.28196-1-a97410985new@gmail.com=
/
>
> Thanks.

Thank you for all the corrections. I'd submit a patch series with the
correct practices.
