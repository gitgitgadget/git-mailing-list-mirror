Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05D209F5E
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508073; cv=none; b=DBCS3JaOu4t3HwRsjpueIUq+E5L+X6raZYIXszP+f5r7qGuUZY+4iXsZ4CT366yA/fMUTHEDwT/XAuM5CCFnB1+DUABgrYyxiNtibLriT2s+uhtFV2b1ppEN3LDUvBEnDOL/KKc0pzSEr2MH+zfoBaEs9UaXam+zlhlWdgvcUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508073; c=relaxed/simple;
	bh=vQLmhOLVXFNQfPG9pJzKgAxhz8lXWBbzS3o7ql+gAV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7WuEiBb7ocqQ14LvC+6Qld1Jv1Qe6V1ddB5mMBwgprdN4CzHj212+lXYoUsoWbB1gToTD9oNDT/SCzo+tKYK892/x9jTjdJ4EtVv0pSTUzpSPJg7O/NGDOOwpfPRYcU/zaQNYMLOmvGITqVgCOs4Flj3UgioYwfa7vGEuVHY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyHmq2uR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyHmq2uR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so298918266b.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 03:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736508068; x=1737112868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYhNAMozNqoWfCVpAZRTjcJhOcBCMq743NR9omU6jR4=;
        b=XyHmq2uRG7a2khiOC2K+jNZim+r742Xw52042hPo1U+VpDUZxS686r+uXjYdrp/jrC
         V0HwjQ3HCa9uyKf5CVl5lZQzLk1xjghiEw78PshRbtW+8VuhcuuCW/f1QuIa6H5Z+qgg
         sjciTKA7RgZ5PF6u8kZVxaCSlb7YzgNWyiK+DaEizzG3s4dbEMbw5tYebiuqLpz0tcXh
         +y46ivtiuGW7pvivQoc9XKZGz/rdgqVtsmZ4sHQmrClF4iGJaa8G/FyJJ33nMDaZQDOO
         ucXQMocGf+yXagkBl/0CYuUz/MXZWjMtPecL3IndXNTya5WDlbYh/sIJsfniEDQ+eV2S
         pTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508068; x=1737112868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYhNAMozNqoWfCVpAZRTjcJhOcBCMq743NR9omU6jR4=;
        b=lJMc/RA6hjK4yL6A7mbFO/p3/83vE8ID1zEBmM/NfjUfmRabCA5wnURbfkeCuPaHDm
         E35i/kFs1zPMMufK0A3+plTrD5GW6JiLY2UDZihM+Tsp23wXtRL8BJXlgeSbujQITWB3
         KPzvfb+lSF2jTTVefEsti1I3XmuHzFVRPBoIsMBoByG4EbmHfQS/x4kvZ92sqwvEFTWv
         t4m1uV+0rJ060c7JjPHXdBoksnntKCAFT+KcROiGLWO4muhFFAdxB+TNzbulE1Z+sTuv
         WPZBGR8yZhc22F1gkVuEIlL7ehC79KHQbZbhRf3uiYFGFkVBtljnkyBstiDRgYUJl13t
         ttwQ==
X-Gm-Message-State: AOJu0YzDkHmO2mHGHoTQpzlDbyI+hAco7mEq0lUvo8dBKASIG0x+u+57
	GZYFb2CKGNGH3Fc96ffb5DBKci7mv8NApzaIoMb50ubxWkE55Z/lM9ni/2Hl1IG7gwH5QS4P/DV
	hYjiozeUXghAGa5feT7wqUvydBbqj2kyC
X-Gm-Gg: ASbGncuIv1WrSHeLwTzsMwZ5aQjcrDKJxE16vNQKVOYeWq/ZWKGBfHY4rIsOx4bH4Be
	tnH0t/9wGKJbXv9LWvFbcSFx37hx4NPyudb6aIT9Q
X-Google-Smtp-Source: AGHT+IFWS46b+0CF7fBakCMCZBx9RX7I7Sb7u56Cxyl0BzPdvD4b5JkgYGFmy/InzPNRwROKAbzoqN9EQ5/CQd9FUvA=
X-Received: by 2002:a05:6402:35ca:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5d972e0b954mr25031343a12.11.1736508068057; Fri, 10 Jan 2025
 03:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-9-eric.peijian@gmail.com>
In-Reply-To: <20250108183740.67022-9-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 10 Jan 2025 12:20:55 +0100
X-Gm-Features: AbW1kvbFgeA6TCT659TIKchccNWconyTvv1gXv-5NZK18nc6jor0qczLA7Y8gF0
Message-ID: <CAP8UFD0TBYi0CGOfNYH9FtL3odrqaxz0w1q36RK3gS-Z3pJAmw@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] cat-file: add remote-object-info to batch-command
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:39=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wro=
te:
>
> Since the `info` command in cat-file --batch-command prints object info

Nit: Everywhere in this commit message, it would be a bit clearer and
easier to read with:

s/cat-file --batch-command/`cat-file --batch-command`/

> for a given object, it is natural to add another command in cat-file
> --batch-command to print object info for a given object from a remote.
>
> Add `remote-object-info` to cat-file --batch-command.

s/`remote-object-info`/a new `remote-object-info` command/

[...]

> To summarize, `remote-object-info` gets object info from the remote and
> then loop through the object info passed in, printing the info.

s/loop/loops/

> +remote-object-info <remote> <object>...::
> +       Print object info for object references `<object>` at specified
> +       `<remote>` without downloading objects from the remote.
> +       Error when the `object-info` capability is not supported by the s=
erver.

I think it's more grammatically correct to use "Error out when..." or
"Raise an error when..." than just "Error when..."

Also maybe: s/server/remote/

> +       Error when no object references are provided.

Here also "Error out when..." or "Raise an error when..."

> +       This command may be combined with `--buffer`.

[...]

>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except for `remote-object-info` commands w=
hich use
> +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not sup=
ported yet.
> +WARNING: When "%(objecttype)" is supported, the default format WILL be u=
nified, so
> +DO NOT RELY on the current the default format to stay the same!!!

s/current the default/current default/

>  CAVEATS
>  -------
>
> +Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
> +currently not supported by the `remote-object-info` command, we will err=
or

s/error/raise an error/

or maybe:

s/error and exit/error out/

> +and exit when they are in the format string.

s/are/appear/

> @@ -45,9 +48,12 @@ struct batch_options {
>         char input_delim;
>         char output_delim;
>         const char *format;
> +       int use_remote_info;

"unsigned int" might be a bit better for bool fields like this.

Actually it seems to me that this field is set to 0 and 1 in some
places but we never read it, so I wonder if it's actually useful.

>  };

> @@ -579,6 +585,61 @@ static void batch_one_object(const char *obj_name,
>         object_context_release(&ctx);
>  }
>
> +static int get_remote_info(struct batch_options *opt, int argc, const ch=
ar **argv)
> +{
> +       int retval =3D 0;
> +       struct remote *remote =3D NULL;
> +       struct object_id oid;
> +       struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
> +       static struct transport *gtransport;
> +
> +       /*
> +        * Change the format to "%(objectname) %(objectsize)" when
> +        * remote-object-info command is used. Once we start supporting o=
bjecttype
> +        * the default format should change to DEFAULT_FORMAT

s/DEFAULT_FORMAT/DEFAULT_FORMAT./

> +       */
> +       if (!opt->format)
> +               opt->format =3D "%(objectname) %(objectsize)";
> +
> +       remote =3D remote_get(argv[0]);
> +       if (!remote)
> +               die(_("must supply valid remote when using remote-object-=
info"));
> +
> +       oid_array_clear(&object_info_oids);
> +       for (size_t i =3D 1; i < argc; i++) {
> +               if (get_oid_hex(argv[i], &oid))
> +                       die(_("Not a valid object name %s"), argv[i]);
> +               oid_array_append(&object_info_oids, &oid);
> +       }
> +       if (object_info_oids.nr =3D=3D 0) {
> +               die(_("remote-object-info requires objects"));
> +       }

We prefer to drop '{' and '}' and use "!X" instead of "X =3D=3D 0" when
possible, so:

       if (!object_info_oids.nr)
               die(_("remote-object-info requires objects"));

Thanks.
