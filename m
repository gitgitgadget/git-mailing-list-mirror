Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99F1A7248
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179996; cv=none; b=rtrzwyPjsm6Rjfx6OZjAOonIe9312u2l8dQKnw7/a0NSO7G0UCVj9dv48Dag3g4i9il6RKVSnXOqJPxySdfkstqftIASFCFSR03Z/ErvFCqebPJJIqLZXUZKc9HFwjC1UR5lTD9mzvnJpuE8nXitBvuh7k2qkZ9/3B43C4cXYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179996; c=relaxed/simple;
	bh=7Dm5NDFghZIuWBmv3xTPGR8eFKcLf6Z7cvA+hrTiPMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e88JeyNHMhxRRIgkybzbPFqQijhuHVdxcGVyluw2+L9IGVwBS17yYIHsxqpzQzX8GrImJGzbebyQfCZ8C8Sju94Wn5BZ6zXrTVuaX0mftER04KJFFHscgJ8fGSYmqmxIDJ+8+Nvy0js8PxHe2x7Ay/8RH6ufSVj2vxgdIrBFxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxDJyeu1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxDJyeu1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3770320574aso3622025f8f.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179993; x=1727784793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY0NDAuFEkif7z5DIKprhrNXtWDjJ99IVnt9V5PdT6Q=;
        b=HxDJyeu1G1v8UQY7EFsyT0jMpm3wrGoHSL89yIjdv3+WFvxKG2MnwZZC71Hp3GOFmr
         beHY0nirKfM1L8t1sq8MMdmEVQKEFzuJGmUNFUgi9//YqyT3Z8b+j7Q8zOTBzJodJMam
         2blz6NoUj4tDENjE6xg2A7shNiJsI6s8auVU7YUINytVHZ9pIJYbodT9O1RMH5QIksRd
         GJ1v006gv0YOiiNAvfFguXvQGKZSA3KnE4MoGfvFrluA1ELf47djsFfk0oNDemx8rcav
         1dWFQi2Sj2unuF9uAYO/dla1kVd5YbWwMZL7EuJ7CiO9fy2YSRfbSwpKaLNEMmLyjMzR
         L4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179993; x=1727784793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY0NDAuFEkif7z5DIKprhrNXtWDjJ99IVnt9V5PdT6Q=;
        b=oMARXxhKFYRw2tXNZuarECGx9dDh2IYDH601GvxwzSA1tUwXkc93i4xKUf3JtXdMlH
         p2zHFIhHrKygtK+gPnFtl53MmaW0U4pyKZTzIKT4aoswRMgXaOdu0silK6vMexf7EY2H
         Y30AN9YOLaiXEbqc4LY1hGROF0RLzCLM+VjaGe9lrH8Wonl9BZh+fq3Mrc8gJld1wePk
         C50YEo9Q5DQB2MvzNMvLkRmgZALqnQGUyJqPpPh1BOUBHwhWP8iJu5UTEnjrW14pHhYA
         5aEQKK7J0VqvkAHHnWT4+066gQ4KxCwcBhCloCV9ZgQrT5di/NRqGt1nCK/ENB7Dg8kj
         PKSw==
X-Gm-Message-State: AOJu0YxAtb/FJ2X6HD2avQ0Az+aLAzwC1nre/rG11Z80Ns1eOiIzrYc8
	hTlbtD50E9P2GDKwcDntRDAjX6NM/JK/ucL5RpYvMercnGXAUg7LPTOefNpxdg5e9X0nLptNYCT
	Kg7SABy6u3qL+s4Efsyy4wgPudjw=
X-Google-Smtp-Source: AGHT+IFUzDWApZKa8DPHHYOL5hU0EeX/3PW+iAo85vJetEy4951HhfVowQZTDYtdq1dDbEpPgd46ODz937bCHpGYRd8=
X-Received: by 2002:adf:f951:0:b0:374:d157:c019 with SMTP id
 ffacd0b85a97d-37a43147a81mr9436864f8f.12.1727179992807; Tue, 24 Sep 2024
 05:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com> <20240720034337.57125-7-eric.peijian@gmail.com>
In-Reply-To: <20240720034337.57125-7-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Sep 2024 14:13:00 +0200
Message-ID: <CAP8UFD0DWWi19HesaBEHtWXrcqj0184xKRAehwKCUJ-bhR5saQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] cat-file: add remote-object-info to batch-command
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 5:44=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> wr=
ote:

> +remote-object-info <remote> <object>...::
> +       Print object info for object references `<object>` at specified <=
remote> without
> +       downloading objects from remote. If the object-info capability is=
 not
> +       supported by the server, the objects will be downloaded instead.
> +       Error when no object references is provided.

Maybe s/is provided/are provided/

> +       This command may be combined with `--buffer`.

>  `deltabase`::
>         If the object is stored as a delta on-disk, this expands to the
>         full hex representation of the delta base object name.
>         Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> -       below.
> +       below. Not supported by `remote-object-info`.
>
>  `rest`::
>         If this atom is used in the output string, input lines are split
> @@ -314,7 +323,9 @@ newline. The available atoms are:
>         line) are output in place of the `%(rest)` atom.
>
>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except remote-object-info command who uses

s/except remote-object-info command who uses/except for
`remote-object-info` commands which use/

> +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not sup=
ported yet.
> +When "%(objecttype)" is supported, default format should be unified.
>
>  If `--batch` is specified, or if `--batch-command` is used with the `con=
tents`
>  command, the object information is followed by the object contents (cons=
isting
> @@ -396,6 +407,10 @@ scripting purposes.
>  CAVEATS
>  -------
>
> +Note that since objecttype, objectsize:disk and deltabase are currently =
not supported by the

s/objecttype, objectsize:disk and deltabase/%(objecttype),
%(objectsize:disk) and %(deltabase)/

> +remote-object-info, git will error and exit when they are in the format =
string.

s//remote-object-info, git /`remote-object-info` command, we/

> +
> +

Maybe a single blank line is enough.

>  Note that the sizes of objects on disk are reported accurately, but care
>  should be taken in drawing conclusions about which refs or objects are
>  responsible for disk usage. The size of a packed non-delta object may be

[...]

> +       gtransport =3D transport_get(remote, NULL);
> +       if (gtransport->smart_options) {
> +               CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> +               gtransport->smart_options->object_info =3D 1;
> +               gtransport->smart_options->object_info_oids =3D &object_i=
nfo_oids;
> +               /*
> +                * 'size' is the only option currently supported.
> +                * Other options that are passed in the format will exit =
with error.
> +                */
> +               if (strstr(opt->format, "%(objectsize)")) {
> +                       string_list_append(&object_info_options, "size");
> +               } else {
> +                       die(_("%s is currently not supported with remote-=
object-info"), opt->format);
> +               }

Something like the following might be a bit shorter and simpler:

  /* 'objectsize' is the only option currently supported */
  if (!strstr(opt->format, "%(objectsize)"))
          die(_("%s is currently not supported with
remote-object-info"), opt->format);

  string_list_append(&object_info_options, "size");

> +               if (object_info_options.nr > 0) {
> +                       gtransport->smart_options->object_info_options =
=3D &object_info_options;
> +                       gtransport->smart_options->object_info_data =3D r=
emote_object_info;
> +                       retval =3D transport_fetch_refs(gtransport, NULL)=
;
> +               }
> +       } else {
> +               retval =3D -1;
> +       }

[...]

> +       opt->use_remote_info =3D 1;
> +       data->skip_object_info =3D 1;
> +       for (size_t i =3D 0; i < object_info_oids.nr; i++) {
> +
> +               data->oid =3D object_info_oids.oid[i];
> +
> +               if (remote_object_info[i].sizep) {
> +                       data->size =3D *remote_object_info[i].sizep;
> +               } else {
> +                       /*
> +                        * When reaching here, it means remote-object-inf=
o can't retrive

s/retrive/retrieve/

> +                        * infomation from server withoug downloading the=
m, and the objects

s/infomation from server withoug/information from server without/

> +                        * have been fetched to client already.
> +                        * Print the infomation using the logic for local=
 objects.

s/infomation/information/

> +                        */
> +                       data->skip_object_info =3D 0;
> +               }
> +
> +               opt->batch_mode =3D BATCH_MODE_INFO;
> +               batch_object_write(argv[i+1], output, opt, data, NULL, 0)=
;
> +
> +       }
> +       opt->use_remote_info =3D 0;
> +       data->skip_object_info =3D 0;
> +
> +cleanup:
> +       for (size_t i =3D 0; i < object_info_oids.nr; i++)
> +               free_object_info_contents(&remote_object_info[i]);
> +       free(line_to_split);
> +       free(argv);
> +       free(remote_object_info);
> +}
> +
>  static void dispatch_calls(struct batch_options *opt,
>                 struct strbuf *output,
>                 struct expand_data *data,
> @@ -696,9 +803,10 @@ static const struct parse_cmd {
>         parse_cmd_fn_t fn;
>         unsigned takes_args;
>  } commands[] =3D {
> -       { "contents", parse_cmd_contents, 1},
> -       { "info", parse_cmd_info, 1},
> -       { "flush", NULL, 0},
> +       { "contents", parse_cmd_contents, 1 },
> +       { "info", parse_cmd_info, 1 },
> +       { "remote-object-info", parse_cmd_remote_object_info, 1 },
> +       { "flush", NULL, 0 },

I am not sure it's a good thing to add a space before "}".

>  };
