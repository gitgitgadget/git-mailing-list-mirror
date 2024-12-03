Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659713B2B8
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253794; cv=none; b=necpJuAC0JVDNfWbkZXXqaWt2D3OsVJxVN57HAcELaeto+ZIJekYo78VG4UIJbKYNzo82aZlCdU8RTi7yfuVSWCQVBA7KkcZkVDEvVew4CHdvEbMApIGF1KK1HXKcye544RGE3qqaDV6CjSqE77Hut4OYysR1WaWnPHCg9q1Nhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253794; c=relaxed/simple;
	bh=iSoSSyLaVcsAyPS2zjS4R2BjmDwmeBT/g+jW4pxhnKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inKNEXgwzwz1+phiemQNp28nqgv/MDJfAjFLjVYNfATi5KE42wtU1WogHZlyt+hWbzDBDEIaJmZGI0zqKvTYyN34a2aP4IKpfSvvKaDxPREnw2dNzz/nhX3pljhrSmdd4wljWvUatrtv/KRfaPr3hdg44cQDeakxEBdyui9vS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m29NZdBL; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m29NZdBL"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e38938a55e7so4963844276.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733253792; x=1733858592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQvnhiPhDDlLR8jeawT9KULlOAcbri88ZwA4NrUkrTM=;
        b=m29NZdBL3uFuOtui1SrrZca2k3pECcsqxb/fKo26MsAq+vSxqiKdhWW/MWL1/gfJwG
         l+Z/kz2o9UCVSzCH+MR8ornqqn3aWgGn/RPVhMsD392VUnBmbENNujRWuC++BdJiB4Sl
         64wEYu3a4yEKLcQksq4KoKoKLu1WymgD7frO6WXNV8pcmoQSssh3N6K+XPlgPXURd2iJ
         GaqfuU94Qj+6nvObjUJxS5WWWCBWv6OL0MY07ehOMif1A2HWGRT4P2U7frXHK+LbkYvr
         Dd3CshsGM6o/lmG9dIMQaQgn7VbNEV+nit+80y/CtEXySW8Fb19WBOmFvh+TjMyTtFCs
         bbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733253792; x=1733858592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQvnhiPhDDlLR8jeawT9KULlOAcbri88ZwA4NrUkrTM=;
        b=jTtdPMK+2h5FufDNyHh10UzuN9OLhIecb6pdWnmwPqnz+dJ0G2tWIUOtiaGiC5u69I
         kdY7ROieAQ47ORxi1NxsyEKhbHuxcedCdzOkFHqujS60SRmGrNxmhiI8wJkXHQnuF+r6
         kYxTMJXc7dVHfArnmsIFwkbc0fkUzenLHIMPTwTbFpc0I8IUtl2b6R9zNGM9IiHkRw5E
         Wo8io6lVJ1X6ALUGj7kzNmdE1+juvsWhD2XOL96WBIaDGVcavBmO0tqbX636tEIt/4uX
         FfrqmSHkmW84UMl6R1fRLFLKXP+7SdXV1LUIBz8mLxAyNmLR3sxQeRXjCUaAfoEwYsYk
         ONjQ==
X-Gm-Message-State: AOJu0YxbPd1fYzmIcDKa2lt4dmYfihX/3le//ZSJj9VYuH+Rz9c2BsD0
	pg+1cp2wHtR2+us969OzC3ESD8PSw/3vLqHXID+IIPYDmu920jlhJkpStmdD/cbw97FKZUEZu7u
	AwNDOoNtwYRKUToFUd1PCiKU9XGE=
X-Gm-Gg: ASbGnctXoh58R0KCVOCzY9tx8i7s1rVRyqKeLP5d0DKTZnDhNm2kJUmhryb2J6ckUbD
	STK4uMAatQMre0gUMUDQTtT4ZewhR/W83
X-Google-Smtp-Source: AGHT+IEUUmqtjxkLnP1DzETatkgGBlV5GZj8O+4XK1nUQdokUgzQWIZAa9geUksc0fVbf4UTsEBurFl4l2RLYFwKz0w=
X-Received: by 2002:a05:6902:f84:b0:e38:c03f:7883 with SMTP id
 3f1490d57ef6-e39d39f01d4mr4243626276.1.1733253791883; Tue, 03 Dec 2024
 11:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com> <20241125053616.25170-7-eric.peijian@gmail.com>
 <Z0RIrw2PszaY2Way@pks.im>
In-Reply-To: <Z0RIrw2PszaY2Way@pks.im>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Tue, 3 Dec 2024 14:23:01 -0500
Message-ID: <CAN2LT1C6mZrhWiK8x27yOPjRt=v8f_jnYwc6g_LtxhVGy3bQaQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] cat-file: add remote-object-info to batch-command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 4:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Nov 25, 2024 at 12:36:16AM -0500, Eric Ju wrote:
> > diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fil=
e.txt
> > index d5890ae368..6a2f9fd752 100644
> > --- a/Documentation/git-cat-file.txt
> > +++ b/Documentation/git-cat-file.txt
> > @@ -314,7 +323,10 @@ newline. The available atoms are:
> >       line) are output in place of the `%(rest)` atom.
> >
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
> Is this stale or do we still not support `%(objecttype)`? I thought we
> wanted to support that, as well, so that we don't have to change the
> default format.
>

Please see my next reply.

> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 5db55fabc4..ad17be69b0 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -576,6 +582,59 @@ static void batch_one_object(const char *obj_name,
> >       object_context_release(&ctx);
> >  }
> >
> > +static int get_remote_info(struct batch_options *opt, int argc, const =
char **argv)
> > +{
> > +     int retval =3D 0;
> > +     struct remote *remote =3D NULL;
> > +     struct object_id oid;
> > +     struct string_list object_info_options =3D STRING_LIST_INIT_NODUP=
;
> > +     static struct transport *gtransport;
> > +
> > +     /*
> > +      * Change the format to "%(objectname) %(objectsize)" when
> > +      * remote-object-info command is used. Once we start supporting o=
bjecttype
> > +      * the default format should change to DEFAULT_FORMAT
> > +     */
> > +     if (!opt->format)
> > +             opt->format =3D "%(objectname) %(objectsize)";
>
> Seems like it isn't stale. Hum.
>

No, this isn=E2=80=99t stale. As I mentioned in my response to Junio in
https://lore.kernel.org/git/CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdK=
aO4g@mail.gmail.com/,
adding type support is planned for the next patch series. Based on the
documentation at https://git-scm.com/docs/protocol-v2#_object_info, it
seems type isn=E2=80=99t yet supported on the server side either. My plan i=
s
to implement the logic for both server and client in the next series.

Unless the reviewers feel strongly that this must be included now, I=E2=80=
=99d
prefer to stick to the original plan.

> > +     remote =3D remote_get(argv[0]);
> > +     if (!remote)
> > +             die(_("must supply valid remote when using remote-object-=
info"));
> > +
> > +     oid_array_clear(&object_info_oids);
> > +     for (size_t i =3D 1; i < argc; i++) {
> > +             if (get_oid_hex(argv[i], &oid))
> > +                     die(_("Not a valid object name %s"), argv[i]);
> > +             oid_array_append(&object_info_oids, &oid);
> > +     }
>
> Should we return an error when the user didn't pass any object IDs?
>

Thank you. Revising in v8 and also adding a new test case to cover it.

> > @@ -667,6 +726,45 @@ static void parse_cmd_info(struct batch_options *o=
pt,
> >       batch_one_object(line, output, opt, data);
> >  }
> >
> > +static void parse_cmd_remote_object_info(struct batch_options *opt,
> > +                                      const char *line, struct strbuf =
*output,
> > +                                      struct expand_data *data)
> > +{
> > +     int count;
> > +     const char **argv;
> > +
> > +     char *line_to_split =3D xstrdup_or_null(line);
> > +     count =3D split_cmdline(line_to_split, &argv);
> > +     if (get_remote_info(opt, count, argv))
> > +             goto cleanup;
> > +
> > +     opt->use_remote_info =3D 1;
> > +     data->skip_object_info =3D 1;
> > +     for (size_t i =3D 0; i < object_info_oids.nr; i++) {
> > +
>
> Nit: empty newline at the start of a block.
>

Thank you. Fixing in v8.

> > diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
> > new file mode 100644
> > index 0000000000..9fb20be308
> > --- /dev/null
> > +++ b/t/lib-cat-file.sh
>
> I think it would make sense to split the introduction of
> "lib-cat-file.sh" into a separate commit.
>

Thank you. Will split it into a separate commit in v8.

> Patrick
