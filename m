Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4D2F6564
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920668; cv=none; b=PQ5Z4mZzsqvKhBvwgEqHL7zl1Nu8c8Ppxkmze9vDqeXEAKAj40YCtOglJplP1RCQCDrGfGi4WyX9CS8apWrGqlOfddqTf9dBk9UrGNhoEU8Im8TbWIL71cgPjo/Dt/+gClFgosxI4LbDCCWNDhi2GbF06iQrM5UNjHOO2oKvPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920668; c=relaxed/simple;
	bh=vPWm3GzNqODQ3wt/XoVKNJU+Hr3T9d96f63W37zyGK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvB6lD4YhVF7Wnyx0drrXXWldr37jw1aIIPtL6SeEoEPDXuWfwV+7NZd4xmacdKPdk01Hi1wsgVb5/nzt5IaHJ1ySZ47tSESlnVMiOb2QbHXOP3jZyvz22R2Sh1VuyTPw7FTZLTLFvfiTrh0uVi3TST0QBCqNIxBBTJI7wA58RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU3idTet; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU3idTet"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a16441so1176264066b.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759920665; x=1760525465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOj0zjyTTPgg6N3q0RKq5qQwwlEPM27S65LiNpRcLDQ=;
        b=MU3idTet/DkvoaZ7oZXxQnYVz44kmBdN9xLg3gBW9nmgfurWvUOVk6Mc6Oohi7gx1o
         4XvT07iXPNHsLwsh8TOiwZHvFESkih34NFCjIHGGG0gJuEfXVzWK9v5OGcaVvYKVHbn0
         iuHuLgsI/I3VKt5eNSdzutvFICfYDYvGSVplLCZtmJXDmHJKX9/dHMYgEKfKoqqgkTj3
         wCX8aQlITAD7qiaPlfZz4Q1tDrKkpPX/yJRG0myneDUgqbXlbbOZ74x0rlPwaPV02iuI
         rqfurttTJIfu+oADVrmX8zHVx/mKrgycYjET7SrYdgZkomaNXUk5UAKnEaGR4M6oQlnm
         M8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920665; x=1760525465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOj0zjyTTPgg6N3q0RKq5qQwwlEPM27S65LiNpRcLDQ=;
        b=bOeKp1fXKVhwgInUXNrk25oplvtp98gyjq+QEcHPsOIisxEbliHFFiC7uq0UP8HV1W
         pL0kN7hySd5Xwg4M2b9w2DgKOBw7qJ3WQM4extypre7vb99TSIPkkENxnL3alCg2O2PN
         IdXptHyMNHINoNy8Bviw7U01t+lRDeXRZfiQCQOa1t19uApALyerZEaLAzu7En4mRXnv
         FZxjB/J42R2Q6L4KPCAnQtSini+EXHBSowiw0H0/XyWgDOvimk33oUreEtcGh5+2Tu2k
         dlw7l9YOKjwckenk0PRmj5hFzfGk8dZ1quelKjwWHojW/pV7kgKUrYb6Mrwzxx7FSCyt
         oThA==
X-Gm-Message-State: AOJu0YwZPZQ/KUVtdEXHFee9eOhWq+k6jBmiTMSeksJSmPbCewy2f/2z
	yXFCMdSvMvyFqdua7+bPwAwew8cVmVyY5dRZTB4xKB6jbhgTAuU449gTcDurxWa7PVybgaH58PF
	ttMuN5CqD/BO3erpWlrDQ7GTzvRSYLYFYv6FpUTE=
X-Gm-Gg: ASbGncukY/NcNc8Tyg89yuyDu92FdqmOYDFSXCPjqT/Kf9bRRKb5Ix7UNkXFtuUOotK
	QfL7nrD7VsKZGCHE4T4LawXX+SgQuXGYRFZH+GO4kcin650+BEzuH5PVR9OQX+d2qhIXOpcoeBE
	vlwoIuCoX0kstnHDCsLA81XExjvjmeES5sb9agd9ZKsuzrLRFA6Hay5nsbgtscV3eHx+/zlkFr/
	CZ/oDbx+Uoa+IWOF2m7MuEtNpNqhIk=
X-Google-Smtp-Source: AGHT+IG393uMc7H6AXrChWKD1ViKHYSvxh4p3JcUdr1vF/OQL9PbG2Xbzp19JyNrI+7sxBuUKm2FPDiFkDIWH6C1Yv4=
X-Received: by 2002:a17:907:3e84:b0:b45:b078:c52f with SMTP id
 a640c23a62f3a-b50acc2155emr303883366b.61.1759920665134; Wed, 08 Oct 2025
 03:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-6-christian.couder@gmail.com> <aOYPYEk5sT6b1kuS@pks.im>
In-Reply-To: <aOYPYEk5sT6b1kuS@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 12:50:53 +0200
X-Gm-Features: AS18NWCkiFqTLnj6fGjXlDIY-l28SS7R8CbAOiYlyNSgZHDPAY5KYLf9g0qdVNU
Message-ID: <CAP8UFD0E+5K1yL1rj5jXVMX9hQyoA_sH0f=fUP6aCj==TtfAbQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] fast-import: add '--signed-tags=<mode>' option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 07, 2025 at 02:29:58PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fas=
t-import.adoc
> > index 85ed7a7270..b74179a6c8 100644
> > --- a/Documentation/git-fast-import.adoc
> > +++ b/Documentation/git-fast-import.adoc
> > @@ -66,6 +66,11 @@ fast-import stream! This option is enabled automatic=
ally for
> >  remote-helpers that use the `import` capability, as they are
> >  already trusted to run their own code.
> >
> > +--signed-tags=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> > +     Specify how to handle signed tags.  Behaves in the same way
> > +     as the same option in linkgit:git-fast-export[1], except that
> > +     default is 'verbatim' (instead of 'abort').
> > +
>
> Nit: I would've ordered this after "--signed-commits", mostly so that
> these two are ordered alphabetically.

In the fast-export doc --signed-tags is before --signed-commits. Also
in the previous patch series Junio mentioned that historically signed
tags came before signed commits. And the other options are not sorted
alphabetically.

> >  --signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> >       Specify how to handle signed commits.  Behaves in the same way
> >       as the same option in linkgit:git-fast-export[1], except that
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index 2010e78475..668c926db5 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -2961,6 +2962,43 @@ static void parse_new_commit(const char *arg)
> >       b->last_commit =3D object_count_by_type[OBJ_COMMIT];
> >  }
> >
> > +static void handle_tag_signature(struct strbuf *msg, const char *name)
> > +{
> > +     size_t sig_offset =3D parse_signed_buffer(msg->buf, msg->len);
> > +
> > +     /* If there is no signature, there is nothing to do. */
> > +     if (sig_offset >=3D msg->len)
> > +             return;
> > +
> > +     switch (signed_tag_mode) {
> > +
> > +     /* First, modes that don't change anything */
> > +     case SIGN_ABORT:
> > +             die("encountered signed tag; use "
> > +                 "--signed-tags=3D<mode> to handle it");
>
> This message needs to be marked for translation.

Yeah, I will fix it in V2.

> > +     case SIGN_WARN_VERBATIM:
> > +             warning(_("importing a tag signature verbatim for tag '%s=
'"), name);
> > +                     /* fallthru */
>
> This comment is misindented.

Will fix it in V2. Same with other misindented comments.

> > +     case SIGN_STRIP:
> > +             /* Truncate the buffer to remove the signature */
> > +             strbuf_setlen(msg, sig_offset);
> > +             break;
>
> I'm not familiar with the signature format, so it's probably a dumb
> question: does the signature always extend until the end of the tag
> message? Doesn't the tag message come after it?

Users can add anything in a tag message, including signatures created
however they want and copy-pasted there, followed by whatever content
they want. I don't think we need to take care of those signatures,
except perhaps to warn in our docs that Git could mistake them with
the one Git creates.

When Git itself signs a tag, it appends the signature to the tag
message. See do_sign() in "builtin/tag.c" for more details. It looks
like 2 signatures can be created in "compat" mode, but the compat
signature is added into an object header, not appended to the tag
message.

So I think this is the right thing to do and relatively safe.
