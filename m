Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925A125B9
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734637; cv=none; b=YoI2a05Fs/ZpfXDjqlzi4LNR5FuMbsxcYWhKgBm4peGifYG+85StCsVAGyzp5FCuZ5guhyrqHq/TMcjdys6ugXbUced/pxar6gzYL6QP3L7ORW91F8eJh8495djRT6GGZbEGZ+zUULQ3DIov4FviwEIIpa100IXMeM/zOv6uRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734637; c=relaxed/simple;
	bh=Ha/tHtQBj6VYgN2D3aXkrrVyOnIedgqtUP1yqUi75+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3x0uqSYm3kJSwKv3KXfNl+6FDvFrHuvTApV1EmXL7nE6nCAxbfddUBOCA6uw/nxcbejYKQ8qOMZRiolAm2YMWua8OPKXk4TeQ5xzrSIuWp7IPKtzO+7ri2GHD8mbDC+RZrWZVOIf+E9Q+bGoyBz6RF3EHkE4J8yU/SBhGCWgjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae9KgymO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae9KgymO"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fecfae554bso36494897b3.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741734635; x=1742339435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBc9keyReq/GgdhVKZWShQpasPsX8+ShIXPAAWWnRUo=;
        b=ae9KgymOh0ccw1jyPih1RfZJ0F8P87eG3fcZSEkfcu/B+7aABxeeSswNvrrT6Y+c9P
         FZeQbXPxUy20Xuhxhv7b4XfRBSujSW5Xgb6FPw9uCyPPQHLwD2d1bx50o+iHbYPjp3+S
         ACmURe3bJOm5QUZrfwEaSQF4rywagWSpEtfVxTp0x5/6uHBSsLjnuGyEmf2GdUOOr+lv
         zSTgNFiDp4SppdB0DFhk1amwCC2PBtl/6RrUMS9OdjXCQcnzwrpFWf9xzXpzsNGvP+2W
         fIhb+J4dJe6EQU+ckbn9Eh+rC4hPQz9VTCi41dFdK8MKBo85ZErsCWd6wMafpok+/DQ+
         j4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734635; x=1742339435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBc9keyReq/GgdhVKZWShQpasPsX8+ShIXPAAWWnRUo=;
        b=IdjmfICTlWwd893AhddU0GvZOl7+oHzjUWWFBi0CXBfWir8UBlftuAbmcPPnPQV4nq
         8oEoS3v7XdcGctvfgwyucENyiPx4WLEAhklFYMo2BGczyU289KVQG23RlkUw6BmoW2gN
         uJ+OGsEovaoVxq5aqLJD/Vst3WQg1SSTIkF5ngKuE63lPBHCS2MF+ZpZi04M+CUCWJcX
         8FdSCz+1KjrTbX2f2rj6/090RJjPploQcHd12QnBnsaoLVkF9H7RC5OuihND8mB4uOkm
         7LKxb3xv52ObPHzK+fLxQClJuvQ7Ta8iYzItHQ//QFFStqVY0tbHEXYpIA/3BWSgB3oI
         +zFA==
X-Gm-Message-State: AOJu0YwqHwxLSgtkG3xuaH4jdxvgAMdHf5t+Sd7j+LIzNTUK7xFVxCuj
	pvHkjwsU9ydUhr8zEKcghMbG1TdZxH6ebL0vYR55DzuOmRLX4phdzTtimxImPyx4wdDEtYDm9Mt
	K9G/YJTXSCXQNEjrPGa5020YAEjQ=
X-Gm-Gg: ASbGncueE1fPqXMfhjxmpFUxyp2xT+FbGBPFybW8vVUx/O6zZ8Shh9Hr1GaxxESdyjI
	Ywuh5GAfxSEYpSIenandl2kIMYcVjZOl4fiCfY9c13mDIvjo1ffP2xPfc+V8m8bxAOVMruA7zVV
	oDjFFLcDqpykvz/YkC3twkEosNJAc=
X-Google-Smtp-Source: AGHT+IFUkckQTLNCsp09TZAcOsflKqZvTdWkLxqtAk+zcsbN6YzWpXNV/Z53+zciyxY1NWgf81KnWj/m3Ho+k3vV73Y=
X-Received: by 2002:a05:690c:6c90:b0:6f9:97f7:a5c4 with SMTP id
 00721157ae682-6ff0925f1c3mr71037437b3.29.1741734634958; Tue, 11 Mar 2025
 16:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com> <20250221190451.12536-9-eric.peijian@gmail.com>
 <xmqqo6yr3wc4.fsf@gitster.g>
In-Reply-To: <xmqqo6yr3wc4.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Tue, 11 Mar 2025 19:10:23 -0400
X-Gm-Features: AQ5f1JqeO9c1qLrYvCRy_YD2yLaP0NTEQQ0koelQTucpXhZlTxu2JqlLCsqPDJY
Message-ID: <CAN2LT1Cc-UaUpabqcGascicR3nk6ZdFythamKje33Orhy5WoNA@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 69ea642dc6..47fd2a777b 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -27,6 +27,18 @@
> >  #include "promisor-remote.h"
> >  #include "mailmap.h"
> >  #include "write-or-die.h"
> > +#include "alias.h"
> > +#include "remote.h"
> > +#include "transport.h"
> > +
> > +/* Maximum length for a remote URL. While no universal standard exists=
,
> > + * 8K is assumed to be a reasonable limit.
> > + */
>
> Style.  Our multi-line comment begins with slash-asterisk and ends
> with asterisk-slash both on their own line without anything else.
>

Thank you. All the style-related comments will be fixed in the next patch.

> > +#define MAX_REMOTE_URL_LEN (8*1024)
>
> Here and ...
>
> > +/* Maximum number of objects allowed in a single remote-object-info re=
quest. */
> > +#define MAX_ALLOWED_OBJ_LIMIT 10000
>
> ... here, please have a blank line.
>
> > +/* Maximum input size permitted for the remote-object-info command. */
> > +#define MAX_REMOTE_OBJ_INFO_LINE (MAX_REMOTE_URL_LEN + MAX_ALLOWED_OBJ=
_LIMIT * (GIT_MAX_HEXSZ + 1))
>
> This is an overly long line.
>
> > @@ -579,6 +593,61 @@ static void batch_one_object(const char *obj_name,
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
> > +      * the default format should change to DEFAULT_FORMAT.
> > +     */
>
> Style.  Closing asterisk-slash aligns with the asterisk on the
> previous line.
>
> > +     if (!opt->format)
> > +             opt->format =3D "%(objectname) %(objectsize)";
> > +
> > +     remote =3D remote_get(argv[0]);
> > +     if (!remote)
> > +             die(_("must supply valid remote when using remote-object-=
info"));
> > +
> > +     oid_array_clear(&object_info_oids);
> > +     for (size_t i =3D 1; i < argc; i++) {
>
> Pointless mixing of "size_t" and "int".  We have declared "int
> argc", which is perfectly a sensible type, since we know that the
> value of it would not exceed MAX_ALLOWED_OBJ_LIMIT, which is 10000.
>

Thank you. Change to "int" instead.

> > +             if (get_oid_hex(argv[i], &oid))
> > +                     die(_("Not a valid object name %s"), argv[i]);
> > +             oid_array_append(&object_info_oids, &oid);
> > +     }
> > +     if (!object_info_oids.nr)
> > +             die(_("remote-object-info requires objects"));
> > +
> > +     gtransport =3D transport_get(remote, NULL);
> > +     if (gtransport->smart_options) {
> > +             CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> > +             gtransport->smart_options->object_info =3D 1;
> > +             gtransport->smart_options->object_info_oids =3D &object_i=
nfo_oids;
> > +
> > +             /* 'objectsize' is the only option currently supported */
> > +             if (!strstr(opt->format, "%(objectsize)"))
> > +                     die(_("%s is currently not supported with remote-=
object-info"), opt->format);
> > +
> > +             string_list_append(&object_info_options, "size");
> > +
> > +             if (object_info_options.nr > 0) {
> > +                     gtransport->smart_options->object_info_options =
=3D &object_info_options;
> > +                     gtransport->smart_options->object_info_data =3D r=
emote_object_info;
> > +                     retval =3D transport_fetch_refs(gtransport, NULL)=
;
> > +             }
> > +     } else {
> > +             retval =3D -1;
> > +     }
>
> Minor style nit, but when everything else is equal, writing the side
> of smaller body first would make it easier to follow if/else, i.e.
>
>
>         gtransport =3D transport_get(remote, NULL);
>         if (!gtransport->smart_options) {
>                 /* error */
>                 retval =3D -1;
>         } else {
>                 ... a lot of real code here ...
>         }
>
> > +static void parse_cmd_remote_object_info(struct batch_options *opt,
> > +                                      const char *line, struct strbuf =
*output,
> > +                                      struct expand_data *data)
> > +{
> > +     int count;
> > +     const char **argv;
> > +     char *line_to_split;
> > +
> > +     if (strlen(line) >=3D MAX_REMOTE_OBJ_INFO_LINE)
> > +             die(_("remote-object-info command input overflow "
> > +                     "(no more than %d objects are allowed)"),
> > +                     MAX_ALLOWED_OBJ_LIMIT);
>
> Nobody guarantees this user gave a request for more than 10000
> objects; after all it may have been an overly long URL that busted
> the line length limit, no?

Yes, the error message is indeed misleading here.
In the next patch, the behavior will be updated as follows:

1. If strlen(line) >=3D MAX_REMOTE_OBJ_INFO_LINE, we will die with a clear =
error:
"remote-object-info input too long".

2. After step 1, when calling get_remote_info(opt, count, argv), we
will check object_info_oids.nr.
If `object_info_oids.nr > MAX_ALLOWED_OBJ_LIMIT`, we will die with:
"no more than %d objects are allowed", MAX_ALLOWED_OBJ_LIMIT.

>
> > +     line_to_split =3D xstrdup(line);
> > +     count =3D split_cmdline(line_to_split, &argv);
> > +     if (count < 0)
> > +             die(_("split remote-object-info command"));
>
> Here, the code could check if count busts MAX_ALLOWED_OBJ_LIMIT, but
> it doesn't.

Yes, a check is needed here. Please see the previous reply.
