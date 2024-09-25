Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E516D520
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287981; cv=none; b=Rar3gPzxbSuaqKDLIvdMzA65W7YDHgMwk4vBOcAaV9B1XSwdk6iXGpTdk5ZgFWrEBOu5dkcGHvpoLBsa51HpoR/fXAbSXdxXaw5Trb7SEyb4C8TRPvRbjo20+NGRDWXrDme4tDWjXsFuUWzG82tF+EovyvO9NH4JNB8uYl1g2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287981; c=relaxed/simple;
	bh=Y2ybc1DhOwoMRx3QMdFq0O+D3CuvZ6RWDpUZx/fJcJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sneg4kwiqGSvHJuWxgf9pe9c1i9WxbPTttXhkHrIsk2uy3W5BADY5LbpFaUqCJAwMGa9p3HdD0jddlEJtUZwARCS4Zx8cPfgj5T/9AOqyOwSX6WWG21u+aIQUESjMj4kOYvYpvsJypfygUFEFchoeSJahLnq9GXsE2WFCnCj+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSkoUhW4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSkoUhW4"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b747f2e2b7so1673277b3.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727287979; x=1727892779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DKIdygTBSE0jfiyVWT5TbJuPjOBt+tguag3ZbKui14=;
        b=nSkoUhW47DBwoy0MNvCI1GSSsf9ytZcM78Z6Nyuo0svGeU9HEBV2um4tWKoIOqAIyC
         mKzMqIj6rqljiJsRZPkop9hIYscwmxz123KfTH8HQkQiuzKtmr5Pdb0FnRNtD9gQ2K6G
         6R6bVcbXObAGh+w1OHLwstP5YLjgSjzmH0FSsPd2/67AgbdIlVZzww0eFgHinNMwVbfO
         zkjgEYBrfnXECNR3EqB8ljd/jKbXUyjOigMfathwgJ7ytMoYCwEsCi3TirMs2nv8kZx0
         xPtOvkmatCwOmEFNjECYL79jHHmPeStyIT6V1vbsFvHHMLLKyhaV+tlJlCMDh8apm8g5
         OEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287979; x=1727892779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DKIdygTBSE0jfiyVWT5TbJuPjOBt+tguag3ZbKui14=;
        b=QuPTrzx0ziaT81JTNBpntk0IUOVhzAJqkyD/KDZFYGipC12FA72HVPz7DXbticC1cf
         yrk+GDYlhpQb0ZJ6Z8/YVVrFPArqwo6vNTX9W/1X2ayIuE0/3QbQpcXfCgypIBthdOjU
         7RnJfRWFGicMTZmG7MzFhj4kslFVBOljFhxodZBKAjpF1HisbZ4wWGzyN/HlKLi5ukmG
         Znap4JbX49ZN3xJy7eTlSE7c4tJVxVPA360f30t8CBcXYbGm0ZomEBE1e9jIZ7LkxaRe
         ha3Iwy+30ccgOjNzB3VKLIieq9wSX0pPR3iCvq38X+wDs4AU5ISmB3pwmT8KWYbc5Dt4
         SugA==
X-Gm-Message-State: AOJu0YzYr7isiAD2mKWs0HzIAqD7x2+jZBOpT0MOKZl3bJmqaYoJ7tS5
	wK6w3yntwCL5gqQk4t2w2vpEmR4RbnkjZrl5stwJrj8Llw3+lYq2qRvijiIjW/LSx5oCcZjpNrF
	sEyAIm8AoWhGZHH5msOnE5AwjgzQ=
X-Google-Smtp-Source: AGHT+IEzMwYtC5+zKEc2sLnG01AF5v5gIpc/43thMbzNszxthLchxNutSo1zxmAvp4cjgdWozQ2DSU+5QaAHsXvx5kI=
X-Received: by 2002:a05:690c:610f:b0:6dc:45ef:d933 with SMTP id
 00721157ae682-6e21da1b701mr35814867b3.43.1727287978816; Wed, 25 Sep 2024
 11:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com> <20240720034337.57125-7-eric.peijian@gmail.com>
 <CAP8UFD0DWWi19HesaBEHtWXrcqj0184xKRAehwKCUJ-bhR5saQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0DWWi19HesaBEHtWXrcqj0184xKRAehwKCUJ-bhR5saQ@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 25 Sep 2024 14:12:47 -0400
Message-ID: <CAN2LT1AtwfbfbPQH3d=DvQ=VHezNKmHhfOix2DizL9+u5D8U3w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] cat-file: add remote-object-info to batch-command
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:13=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jul 20, 2024 at 5:44=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> =
wrote:
>
> > +remote-object-info <remote> <object>...::
> > +       Print object info for object references `<object>` at specified=
 <remote> without
> > +       downloading objects from remote. If the object-info capability =
is not
> > +       supported by the server, the objects will be downloaded instead=
.
> > +       Error when no object references is provided.
>
> Maybe s/is provided/are provided/

Thank you. Fixed in V3.

>
>
> > +       This command may be combined with `--buffer`.
>
> >  `deltabase`::
> >         If the object is stored as a delta on-disk, this expands to the
> >         full hex representation of the delta base object name.
> >         Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> > -       below.
> > +       below. Not supported by `remote-object-info`.
> >
> >  `rest`::
> >         If this atom is used in the output string, input lines are spli=
t
> > @@ -314,7 +323,9 @@ newline. The available atoms are:
> >         line) are output in place of the `%(rest)` atom.
> >
> >  If no format is specified, the default format is `%(objectname)
> > -%(objecttype) %(objectsize)`.
> > +%(objecttype) %(objectsize)`, except remote-object-info command who us=
es
>
> s/except remote-object-info command who uses/except for
> `remote-object-info` commands which use/

Thank you. Fixed in V3.

>
>
> > +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not s=
upported yet.
> > +When "%(objecttype)" is supported, default format should be unified.
> >
> >  If `--batch` is specified, or if `--batch-command` is used with the `c=
ontents`
> >  command, the object information is followed by the object contents (co=
nsisting
> > @@ -396,6 +407,10 @@ scripting purposes.
> >  CAVEATS
> >  -------
> >
> > +Note that since objecttype, objectsize:disk and deltabase are currentl=
y not supported by the
>
> s/objecttype, objectsize:disk and deltabase/%(objecttype),
> %(objectsize:disk) and %(deltabase)/
>

Thank you.   Fixed in V3.
>
> > +remote-object-info, git will error and exit when they are in the forma=
t string.
>
> s//remote-object-info, git /`remote-object-info` command, we/
>

 Thank you. Fixed in V3.

>
> > +
> > +
>
> Maybe a single blank line is enough.

Thank you. Fixed in V3.

>
>
> >  Note that the sizes of objects on disk are reported accurately, but ca=
re
> >  should be taken in drawing conclusions about which refs or objects are
> >  responsible for disk usage. The size of a packed non-delta object may =
be
>
> [...]
>
> > +       gtransport =3D transport_get(remote, NULL);
> > +       if (gtransport->smart_options) {
> > +               CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> > +               gtransport->smart_options->object_info =3D 1;
> > +               gtransport->smart_options->object_info_oids =3D &object=
_info_oids;
> > +               /*
> > +                * 'size' is the only option currently supported.
> > +                * Other options that are passed in the format will exi=
t with error.
> > +                */
> > +               if (strstr(opt->format, "%(objectsize)")) {
> > +                       string_list_append(&object_info_options, "size"=
);
> > +               } else {
> > +                       die(_("%s is currently not supported with remot=
e-object-info"), opt->format);
> > +               }
>
> Something like the following might be a bit shorter and simpler:
>
>   /* 'objectsize' is the only option currently supported */
>   if (!strstr(opt->format, "%(objectsize)"))
>           die(_("%s is currently not supported with
> remote-object-info"), opt->format);
>
>   string_list_append(&object_info_options, "size");

Thank you. Revised in V3.

>
>
> > +               if (object_info_options.nr > 0) {
> > +                       gtransport->smart_options->object_info_options =
=3D &object_info_options;
> > +                       gtransport->smart_options->object_info_data =3D=
 remote_object_info;
> > +                       retval =3D transport_fetch_refs(gtransport, NUL=
L);
> > +               }
> > +       } else {
> > +               retval =3D -1;
> > +       }
>
> [...]
>
> > +       opt->use_remote_info =3D 1;
> > +       data->skip_object_info =3D 1;
> > +       for (size_t i =3D 0; i < object_info_oids.nr; i++) {
> > +
> > +               data->oid =3D object_info_oids.oid[i];
> > +
> > +               if (remote_object_info[i].sizep) {
> > +                       data->size =3D *remote_object_info[i].sizep;
> > +               } else {
> > +                       /*
> > +                        * When reaching here, it means remote-object-i=
nfo can't retrive
>
> s/retrive/retrieve/
>

Thank you. Fixed in V3.

>
> > +                        * infomation from server withoug downloading t=
hem, and the objects
>
> s/infomation from server withoug/information from server without/
>

Thank you. Fixed in V3.

> > +                        * have been fetched to client already.
> > +                        * Print the infomation using the logic for loc=
al objects.
>
> s/infomation/information/

Thank you. Fixed in V3.

>
>
> > +                        */
> > +                       data->skip_object_info =3D 0;
> > +               }
> > +
> > +               opt->batch_mode =3D BATCH_MODE_INFO;
> > +               batch_object_write(argv[i+1], output, opt, data, NULL, =
0);
> > +
> > +       }
> > +       opt->use_remote_info =3D 0;
> > +       data->skip_object_info =3D 0;
> > +
> > +cleanup:
> > +       for (size_t i =3D 0; i < object_info_oids.nr; i++)
> > +               free_object_info_contents(&remote_object_info[i]);
> > +       free(line_to_split);
> > +       free(argv);
> > +       free(remote_object_info);
> > +}
> > +
> >  static void dispatch_calls(struct batch_options *opt,
> >                 struct strbuf *output,
> >                 struct expand_data *data,
> > @@ -696,9 +803,10 @@ static const struct parse_cmd {
> >         parse_cmd_fn_t fn;
> >         unsigned takes_args;
> >  } commands[] =3D {
> > -       { "contents", parse_cmd_contents, 1},
> > -       { "info", parse_cmd_info, 1},
> > -       { "flush", NULL, 0},
> > +       { "contents", parse_cmd_contents, 1 },
> > +       { "info", parse_cmd_info, 1 },
> > +       { "remote-object-info", parse_cmd_remote_object_info, 1 },
> > +       { "flush", NULL, 0 },
>
> I am not sure it's a good thing to add a space before "}".
>

Thank you. Fixed in V3.
>
> >  };
