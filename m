Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB26EC5
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817877; cv=none; b=sZtcjppWYXSFqnua8E9jXJCMahRFUZ22ySc+ZK3ZyngCB5+BOrLZzHj8Tw6L6DJwoub4diLAL53xH5z/qcjtYv93ThfQJzpfUXGSQIGHqRwxdhxzUoAV/WyvO1nD1R5R2SAkx0b1WSEqOMsBc5Wz/8Gk27lnagExhsIXHY+apI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817877; c=relaxed/simple;
	bh=eiETLssvHGwx2FuneJ87sAWJ7vvMVqmMrYj3P6K01DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chpIL9xVBT4UtH1YgIBSmi0i/qAh+J6e7EVr3+XtbYe6CPBBGVb4aSEyb3pIDcMxSJDKMyZQIl52fBnEmW+4FLwZPXQQF+HGN0ScwUXAheCipcMAqVu/Z2Bx1/eRyhvuzggvR9/zzJYs2MhuzpXWeNDOL2S1tLbkCVnymjqfask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brSyJ+UY; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brSyJ+UY"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e573136107bso5611352276.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736817874; x=1737422674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDUacSq3FgnKKoKbPdYvF1Lhre4/wlpbiko96sFFL+Y=;
        b=brSyJ+UYohNKBQe2A8h/j7evPLItDxSqkhXe9te9Fy6ocUX6SmCZs1RYvUynCgwiOU
         zjvsK/D+1+N1wqTsozUDhwOBuE6Cm+rtTHRTW7j6erkpnM0rnwlOVFsiv6Zmi8iRfsZ2
         wVe+jwmOBD1FQvhSq5Mant4F3/Bf39prcCya2j9ix2MwY4LdFR/GJnxP+F8ZxHrYox7K
         mmCyRTG2EJrtT1pz/9SweikzkneEp0ZCEjQ2tX8Rq/fndyAIQLokW7oaLlM1lOYQmT0S
         dR6Io4U9i+x70cMQDVGLSoWprTTLSVHanJfC/47mWHad6C41k8z+oXZiXEdM6lxoI3bq
         CruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736817874; x=1737422674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDUacSq3FgnKKoKbPdYvF1Lhre4/wlpbiko96sFFL+Y=;
        b=T2V2/noJeaYqYFuDOsumsvvix4XLPhqYyhrMnMhLCHzE/LTrFgspjuynffnJ4XcXsw
         4siuA9F1uv4HX0ipiFeDLFYZOr8pdSg2z5BtFApCuPySnUrHIghYQjHRI/MUMQhGNKU6
         relR+Fn0riN/RcRh6/jPhtcnJsIgCNnuqVQW6EhNFSMtl0fexwYH5tZNDNIScT5Gnl+d
         tMcE3vJgsooK9zyPdCmlWWVnRrXv6xNQH/y0eE+0phvZ6r6eWL0iwcKOqLwGqWPayLuG
         fYFPr5YZjyXcmF4hNpM1+lNzGv0GjpH/6hIknptPMrlifzczsulw7QZhy3IDFFRxgUwv
         ls0g==
X-Gm-Message-State: AOJu0YzbZWo+3OjQ8spcXOlPlbnAI2d/s8jVI8nZ/BVBhCVzmZiMirFJ
	9LDCUMxV/RVTu65A3khy3PNQieoRMRZ6SNfGO0kUQw4aAwmYlWe7dY0IIUJUEx4D9IQqh6b9cgc
	hhQ2ADe/BXTf51I8fu0n3lPQrOTY=
X-Gm-Gg: ASbGncv/V8BuCxbjDjVV8p4p74e0J9q68QtGs+lOtpNMNJsl92MsF0U/MtR502iL939
	0CzTWVbZyvnqohDnsjzZS7aToC/dHZ7PMF6KTIw==
X-Google-Smtp-Source: AGHT+IEcL8+Mix7kVPvq9eF6Ful5MuBOqhpr0sCkRvA7SgobjDsz/SM6RvlIRdydsE/F5vwYspVSxf+oXFYpa73HpFI=
X-Received: by 2002:a05:6902:124e:b0:e47:f4e3:87f8 with SMTP id
 3f1490d57ef6-e54edf0ac07mr18092644276.2.1736817874305; Mon, 13 Jan 2025
 17:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-9-eric.peijian@gmail.com>
 <CAP8UFD0TBYi0CGOfNYH9FtL3odrqaxz0w1q36RK3gS-Z3pJAmw@mail.gmail.com>
In-Reply-To: <CAP8UFD0TBYi0CGOfNYH9FtL3odrqaxz0w1q36RK3gS-Z3pJAmw@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 13 Jan 2025 20:24:23 -0500
X-Gm-Features: AbW1kvZ0mB7vwFOsf3yH6UnAwTbKL03Cw4Y1snVVo3Lzf9I1U5Syg0GRrAjlEwk
Message-ID: <CAN2LT1AXfFEaTtex5+Lp22Y7hqneXk98rJw+D9gKxDajg3LohQ@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] cat-file: add remote-object-info to batch-command
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:21=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 8, 2025 at 7:39=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> w=
rote:
> >
> > Since the `info` command in cat-file --batch-command prints object info
>
> Nit: Everywhere in this commit message, it would be a bit clearer and
> easier to read with:
>
> s/cat-file --batch-command/`cat-file --batch-command`/
>

Thank you. Fixed in v10.

> > for a given object, it is natural to add another command in cat-file
> > --batch-command to print object info for a given object from a remote.
> >
> > Add `remote-object-info` to cat-file --batch-command.
>
> s/`remote-object-info`/a new `remote-object-info` command/
>

Thank you. Fixed in v10.

> [...]
>
> > To summarize, `remote-object-info` gets object info from the remote and
> > then loop through the object info passed in, printing the info.
>
> s/loop/loops/
>

Thank you. Fixed in v10.

> > +remote-object-info <remote> <object>...::
> > +       Print object info for object references `<object>` at specified
> > +       `<remote>` without downloading objects from the remote.
> > +       Error when the `object-info` capability is not supported by the=
 server.
>
> I think it's more grammatically correct to use "Error out when..." or
> "Raise an error when..." than just "Error when..."
>
> Also maybe: s/server/remote/
>

Thank you. Fixed in v10. I will use "Raise an error when..."

> > +       Error when no object references are provided.
>
> Here also "Error out when..." or "Raise an error when..."
>

Thank you. Fixed in v10.

> > +       This command may be combined with `--buffer`.
>
> [...]
>
> >  If no format is specified, the default format is `%(objectname)
> > -%(objecttype) %(objectsize)`.
> > +%(objecttype) %(objectsize)`, except for `remote-object-info` commands=
 which use
> > +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not s=
upported yet.
> > +WARNING: When "%(objecttype)" is supported, the default format WILL be=
 unified, so
> > +DO NOT RELY on the current the default format to stay the same!!!
>
> s/current the default/current default/
>

Thank you. Fixed in v10.

> >  CAVEATS
> >  -------
> >
> > +Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
> > +currently not supported by the `remote-object-info` command, we will e=
rror
>
> s/error/raise an error/
>
> or maybe:
>
> s/error and exit/error out/
>

Thank you. Replaced with "raise an error".

> > +and exit when they are in the format string.
>
> s/are/appear/
>

Thank you. Fixed in v10.

> > @@ -45,9 +48,12 @@ struct batch_options {
> >         char input_delim;
> >         char output_delim;
> >         const char *format;
> > +       int use_remote_info;
>
> "unsigned int" might be a bit better for bool fields like this.
>
> Actually it seems to me that this field is set to 0 and 1 in some
> places but we never read it, so I wonder if it's actually useful.
>

Thank you. It is used at all and removed in v10.

> >  };
>
> > @@ -579,6 +585,61 @@ static void batch_one_object(const char *obj_name,
> >         object_context_release(&ctx);
> >  }
> >
> > +static int get_remote_info(struct batch_options *opt, int argc, const =
char **argv)
> > +{
> > +       int retval =3D 0;
> > +       struct remote *remote =3D NULL;
> > +       struct object_id oid;
> > +       struct string_list object_info_options =3D STRING_LIST_INIT_NOD=
UP;
> > +       static struct transport *gtransport;
> > +
> > +       /*
> > +        * Change the format to "%(objectname) %(objectsize)" when
> > +        * remote-object-info command is used. Once we start supporting=
 objecttype
> > +        * the default format should change to DEFAULT_FORMAT
>
> s/DEFAULT_FORMAT/DEFAULT_FORMAT./
>

Thank you. Fixed in v10.

> > +       */
> > +       if (!opt->format)
> > +               opt->format =3D "%(objectname) %(objectsize)";
> > +
> > +       remote =3D remote_get(argv[0]);
> > +       if (!remote)
> > +               die(_("must supply valid remote when using remote-objec=
t-info"));
> > +
> > +       oid_array_clear(&object_info_oids);
> > +       for (size_t i =3D 1; i < argc; i++) {
> > +               if (get_oid_hex(argv[i], &oid))
> > +                       die(_("Not a valid object name %s"), argv[i]);
> > +               oid_array_append(&object_info_oids, &oid);
> > +       }
> > +       if (object_info_oids.nr =3D=3D 0) {
> > +               die(_("remote-object-info requires objects"));
> > +       }
>
> We prefer to drop '{' and '}' and use "!X" instead of "X =3D=3D 0" when
> possible, so:
>
>        if (!object_info_oids.nr)
>                die(_("remote-object-info requires objects"));
>
> Thanks.

Thank you. Fixed in v10.
