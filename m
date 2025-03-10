Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ADA22A4D3
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622348; cv=none; b=TQusLcj5phdSKDWNkUJcEG2g40+5vcB7LhjlUMSeO6DCGuOXsNIiNnvi+rn4Wpq5KE6XMG4bnfuInpwO29tPPblC5UO8VJIr9eNl6YEcMSxVWLwpW55R/r+CpZENhyNZAFR7ss4du+AN+uEDJ6NGVOgEsGjV0B15+9tUrIRaXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622348; c=relaxed/simple;
	bh=G9v/wZow3m4b+vucvnAgyIj62PHW8QL0/NX9CKqRF3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wnw8/3D9sR/EcdvMMt8nv62obG8kTgMQAuhyvK8BEwwKtm5ALlsjkWlP+4Q0AjllbvEmRfao/2n88XsRpwe2nw8UsLpyPPqUnnXOPgmrarmM5UKobnaevQlGMdMV+EETOJmVZu1/WktptKIbIHu82j6Q+j/BgYrlIi2w9Eb68wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD+hLsi2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD+hLsi2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso4227500a12.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622345; x=1742227145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGxo55HjVrw87jRsp89zCBoSRfLlnmgx/XLtJ8S3sEw=;
        b=HD+hLsi2WnVMenfclLY3uqpnIEIvTOx9gW2Nw2aI6YRFKsjxOrXRg9RexS0ytiQxDf
         ojy8cvYW2CgJU+Znko1YxEaZGXFkNocPZdWgNelODTT+T10tpfjBpHBlGtbMWUMkMWDi
         P7WyMGm/YEFz+qxJfLOesMVJRRCqhKwtHJA+/NCpAPF65lhpDJv24DlHx3RutUhe4l8p
         CdKX20fict0Ceuhu+tQzqn6FH/knObgzj/CiA8HZUJYWLW2wun/x9TA+45EIbE27L2FB
         Hryx8JoMwbpqeziHu2npo9DIQrl7S/6Axk6SM4mghcm0S7AZKPWOiUcAuPZVUAhvDW/8
         bDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622345; x=1742227145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGxo55HjVrw87jRsp89zCBoSRfLlnmgx/XLtJ8S3sEw=;
        b=urPOaNNLGZ0Pd6TU7TNOFH3fIc2TfEaB7P0XUGPTNgImbA+KwQ4OxFqmSZfr3C0/hW
         bLXhiqKJiNvOBSIJQMnEAo0e++64lL/togKvuKbxcWJno71LU1F8iJKgJZUb/ud9Ofaj
         P8L+c1SKESDQumtDoAlaeUHTmKVNa9CqkFOn3SzNJQ12cAOob223yZhKZuzclMLF01ic
         u1MhOxwXuTyEzWIe3JwOEpY7e6B5o/0zb51lmNcb8hX/y8rPeM2H4oAPH7IClnBCLa5l
         fvkvtxjoW6HmqgJhRyV86mh3FPXf+4KP0gp/zxKaDTLzRdxmlCj1Xv52b4LrkLB8yjCr
         bHGQ==
X-Gm-Message-State: AOJu0YzB7uVuCTWIWnrSdkfyN0C3qM1t5omDG3xsRxTE1S3+rd6Fa24p
	SeRCSLKXwuK9HDvdaP46PAC0R+T6c12c0HZmzVORnPkReq5vP0dklh6ZzsII1t8FVs/aCIYP8GN
	tr6+rSrIaGj1O0V4EleAcdTh1EeI=
X-Gm-Gg: ASbGncuqGRlqliWtz1TqQeyGkTYQCE6700QfGuomeYKY/Ndt0kRw5O483VY4eXVr92n
	MFHcp0LEJddA1uEIlqo18vCHssrnYHBJwn7f81xzACW0B7e9JVo+s1BGSFwS0FalPC6b92UZTM+
	/F76sWwrQb3VQUyiGsawqTL88awZNp
X-Google-Smtp-Source: AGHT+IEFep/K2zHZj0/OApY72m8GQkRmISdCq3LuDtfrw4YCixTUX418irVjwVM6WnozDJtAyiBwiJnK0XXtj1cY5Q0=
X-Received: by 2002:a17:907:94d4:b0:ac1:df33:25b9 with SMTP id
 a640c23a62f3a-ac252ba291fmr1666561666b.40.1741622344655; Mon, 10 Mar 2025
 08:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <20250224142744.279643-7-christian.couder@gmail.com> <CABPp-BErRqke5DH7c3+u19iw1U5JgWYB=xcUwrE3NObf=EYz1Q@mail.gmail.com>
In-Reply-To: <CABPp-BErRqke5DH7c3+u19iw1U5JgWYB=xcUwrE3NObf=EYz1Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 10 Mar 2025 16:58:52 +0100
X-Gm-Features: AQ5f1Joj3TmpZ6ncxnnc9AFY8YxMCPyb51Y-6KbbyjXkfZA8fsEjBhGHs984CyQ
Message-ID: <CAP8UFD0MxxqxgZHe5_7do_d1ub=OLRZyAuqRX5QHFzrDZNvt=Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] fast-export, fast-import: add support for signed-commits
To: Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	Luke Shumaker <lukeshu@datawire.io>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:36=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Mon, Feb 24, 2025 at 6:28=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> [...snip...]
> > diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fas=
t-export.adoc
> > index 1b19f17b78..8750dd150b 100644
> > --- a/Documentation/git-fast-export.adoc
> > +++ b/Documentation/git-fast-export.adoc
> > @@ -43,6 +43,17 @@ they will be exported, but you will see a warning.  =
'verbatim' and
> >  transformation affecting tags will be performed, or if you do not
> >  care that the resulting tag will have an invalid signature.
> >
> > +--signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> > +       Specify how to handle signed commits.  Behaves exactly as
> > +       '--signed-tags', but for commits.
>
> Should this also explicitly call out that the default is abort?

Yeah, that might help, so "Default is 'abort'." has been added in the
next version.

>  Yes,
> I know that...
>
> > ++
> > +Earlier versions this command that did not have '--signed-commits'
> > +behaved as if '--signed-commits=3Dstrip'.  As an escape hatch for user=
s
> > +of tools that call 'git fast-export' but do not yet support
> > +'--signed-commits', you may set the environment variable
> > +'FAST_EXPORT_SIGNED_COMMITS_NOABORT=3D1' in order to change the defaul=
t
> > +from 'abort' to 'warn-strip'.
>
> ...this paragraph implies abort is the default, but I imagine we
> eventually drop this paragraph, but
> it'd still be useful to have the default called out.

We could still rely on the fact that the doc above says "Behaves
exactly as '--signed-tags', but for commits." and the default for
'--signed-tags' is 'abort', but I agree that it can still help to
spell it out.

> [...snip...]
>
> > @@ -611,6 +615,44 @@ static void anonymize_ident_line(const char **beg,=
 const char **end)
> >         *end =3D out->buf + out->len;
> >  }
> >
> > +/*
> > + * find_commit_multiline_header is similar to find_commit_header,
> > + * except that it handles multi-line headers, rathar than simply
>
> s/rathar/rather/

Fixed in the next version. Thanks.
