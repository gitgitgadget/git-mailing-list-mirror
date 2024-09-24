Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F3824AD
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178360; cv=none; b=jS157KrzxlrbL4qmPCrpN4ro5YsLiFZhCmHqYVHic5OW3HbfDUcjQEejkCiVRCy7YGSi9DMejj1gdeQZcYSbvUrK2nPCxLa4kKqlO112xKjf5iCjBtVtu2Ha33sFjoR2I2Nk1pfHmWUfqQk5wFPDjtkK457ASmlDc2mtEVatHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178360; c=relaxed/simple;
	bh=/uEsNiQyvbEpN4QIDI2bec9U8/zaDH/OoGRy8HL7ZOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beZQbyJJ3IfrqqvDAKjgnOVp3l/wHsu7/sXgebPV8ZAI9PX6GhZ7WYxHKzmM3FdwEMcrKOCYMNr3P+lpaAbVkIMDwaUH2+T2UyssXlUVkuVVSOXRapbK/PgYsGha3rGmpoUIiaM5BLHvtQqNjUcC3uXip5uvJQ7R6edqqqHRBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3IYsYf4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3IYsYf4"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d60e23b33so738477566b.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727178357; x=1727783157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thR6pluv2gCAgh/QkiPJWhVrKFEmoYJzVWDaQnGsM9g=;
        b=T3IYsYf4emClazMXxTAsR6NCL6ACqV1oqcE737UJqsTC1xwYDmI6vjoI/JOuEHb3v6
         aCnidDR4unabiBRWCyLPvAAFxZB2igrUCz0ioaQyHM7uvDkCQVIme383Gcoq52aY7QQ7
         E3zbnfaM8UTiHF2w9creUUSvyHJAqCALgQoNeH3pLh5A1GY3LspdALIeSG4HRR5hafrJ
         9Hyx0ez3v3Aba+QMOLtza/1OM//BbFQmQG92ad7QUKpBPzAXYOSQykxP8DKuTdItN95Q
         KnTZWHvIClJYQ+z2MWgD5W0jpcI8WdjeshMxyDvuv8NuMeN8zvQ9cs4vdiDkC+JVDxje
         /66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727178357; x=1727783157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thR6pluv2gCAgh/QkiPJWhVrKFEmoYJzVWDaQnGsM9g=;
        b=wIo4PYNMxsR00AoQGNaKscKx3K+nsOLacq5OLZe2t/UHS3w9CjA4qNMx6LH+DKCfs8
         8aPZtk1vQQwh9PnnuHeqkJl/JH60nqNzzKYKPc4VjLdxWcWK0+iDsCJ6XvkQUH8xQMlK
         qUbKeROmFFGGmUhr/NTnesSprKWhdAgDQvbwb6P8diJIqOEqIAwOtEaK5V/YyOVzrjFk
         hoPqOg6I4jqdEBvtt63sHqo6o/hNvL1RdXUgAKEJaU8eGD+dSRFWExtmSrXfozF343cx
         mIguRIlREpvHAadFsZpe74SKjTtKQ2hNmgkGpdMCm+26j4nwlbNIcaeABYqOk3erogk9
         sYMg==
X-Gm-Message-State: AOJu0Yyt15yB2ATw7ibbY+4L3qfpgxyhzpjlYLKKsD0aVsJMW6WFpwUa
	XjlwtYHHivniNkbXAgUpr8tngYehiia3FgJm2BpVbv9I/fOX2USmMmMAWX0u6Cmy2JpITfEevYi
	Hj0cdzNyXt+E8FN4sBCBouZ637eP6aA==
X-Google-Smtp-Source: AGHT+IH9j70OJwItlhGv8jODRdU5vqD90jYcEva9WX0Odi2wgPBKFp9hu3JuGmX276pfIfW/GaHdMvp+Wn9hYq7ft14=
X-Received: by 2002:a17:907:970c:b0:a86:a1cd:5a8c with SMTP id
 a640c23a62f3a-a90d5610b79mr1368804066b.22.1727178356869; Tue, 24 Sep 2024
 04:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com> <20240720034337.57125-5-eric.peijian@gmail.com>
In-Reply-To: <20240720034337.57125-5-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Sep 2024 13:45:44 +0200
Message-ID: <CAP8UFD0WVgTfgY5aBr8wUxFWi8ggTxL66jnRLLnVkTOniL0Wvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] transport: add client support for object-info
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 5:43=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> wr=
ote:

[...]

>  fetch-pack.c       |  24 +++++++++
>  fetch-pack.h       |  10 ++++
>  transport-helper.c |   8 ++-
>  transport.c        | 118 +++++++++++++++++++++++++++++++++++++++++++--
>  transport.h        |  11 +++++
>  5 files changed, 164 insertions(+), 7 deletions(-)

Karthik suggested adding tests at this stage, but I see no tests here.
Maybe the tests are added later, but I agree with Karthik that it
would be nice to add them early if possible.

> diff --git a/transport-helper.c b/transport-helper.c
> index 09b3560ffd..841a32e80a 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -699,13 +699,17 @@ static int fetch_refs(struct transport *transport,
>
>         /*
>          * If we reach here, then the server, the client, and/or the tran=
sport
> -        * helper does not support protocol v2. --negotiate-only requires
> -        * protocol v2.
> +        * helper does not support protocol v2. --negotiate-only and cat-=
file remote-object-info
> +        * require protocol v2.
>          */
>         if (data->transport_options.acked_commits) {
>                 warning(_("--negotiate-only requires protocol v2"));
>                 return -1;
>         }
> +       if (transport->smart_options->object_info) {
> +               // fail the command explicitly to avoid further commands =
input

We use "/* stuff */" for one line comments instead of "// stuff". Also
the comment could go before the if (...) above and the "{" and "}"
could be dropped.

> +               die(_("remote-object-info requires protocol v2"));
> +       }

[...]

> +static int fetch_object_info(struct transport *transport, struct object_=
info *object_info_data)
> +{
> +       int size_index =3D -1;
> +       struct git_transport_data *data =3D transport->data;
> +       struct object_info_args args =3D { 0 };
> +       struct packet_reader reader;
> +
> +       args.server_options =3D transport->server_options;
> +       args.object_info_options =3D transport->smart_options->object_inf=
o_options;
> +       args.oids =3D transport->smart_options->object_info_oids;
> +
> +       connect_setup(transport, 0);
> +       packet_reader_init(&reader, data->fd[0], NULL, 0,
> +                       PACKET_READ_CHOMP_NEWLINE |
> +                       PACKET_READ_GENTLE_ON_EOF |
> +                       PACKET_READ_DIE_ON_ERR_PACKET);
> +       data->version =3D discover_version(&reader);
> +
> +       transport->hash_algo =3D reader.hash_algo;
> +
> +       switch (data->version) {
> +       case protocol_v2:
> +               if (!server_supports_v2("object-info"))
> +                       return -1;
> +               if (unsorted_string_list_has_string(args.object_info_opti=
ons, "size")
> +                               && !server_supports_feature("object-info"=
, "size", 0)) {
> +                       return -1;
> +               }

The "{" and "}" can be dropped here too.

> +               send_object_info_request(data->fd[1], &args);
> +               break;
> +       case protocol_v1:
> +       case protocol_v0:
> +               die(_("wrong protocol version. expected v2"));
> +       case protocol_unknown_version:
> +               BUG("unknown protocol version");
> +       }
> +
> +       for (size_t i =3D 0; i < args.object_info_options->nr; i++) {
> +               if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) =
{
> +                       check_stateless_delimiter(transport->stateless_rp=
c, &reader, "stateless delimiter expected");
> +                       return -1;
> +               }
> +               if (unsorted_string_list_has_string(args.object_info_opti=
ons, reader.line)) {
> +                       if (!strcmp(reader.line, "size")) {
> +                               size_index =3D i;
> +                               for (size_t j =3D 0; j < args.oids->nr; j=
++) {
> +                                       object_info_data[j].sizep =3D xca=
lloc(1, sizeof(long));
> +                               }

The "{" and "}" can be dropped here too.

> +                       }
> +                       continue;
> +               }
> +               return -1;
> +       }
> +
> +       for (size_t i =3D 0; packet_reader_read(&reader) =3D=3D PACKET_RE=
AD_NORMAL && i < args.oids->nr; i++){
> +               struct string_list object_info_values =3D STRING_LIST_INI=
T_DUP;
> +
> +               string_list_split(&object_info_values, reader.line, ' ', =
-1);
> +               if (0 <=3D size_index) {
> +                       if (!strcmp(object_info_values.items[1 + size_ind=
ex].string, ""))
> +                               die("object-info: not our ref %s",
> +                                       object_info_values.items[0].strin=
g);
> +
> +                       *object_info_data[i].sizep =3D strtoul(object_inf=
o_values.items[1 + size_index].string, NULL, 10);
> +

This blank line can be removed.

> +               }
> +
> +               string_list_clear(&object_info_values, 0);
> +       }
> +       check_stateless_delimiter(transport->stateless_rpc, &reader, "sta=
teless delimiter expected");
> +
> +       return 0;
> +}
> +
>  static struct ref *get_refs_via_connect(struct transport *transport, int=
 for_push,
>                                         struct transport_ls_refs_options =
*options)
>  {
> @@ -413,6 +487,7 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
>         struct ref *refs =3D NULL;
>         struct fetch_pack_args args;
>         struct ref *refs_tmp =3D NULL;
> +       struct ref *object_info_refs =3D NULL;
>
>         memset(&args, 0, sizeof(args));
>         args.uploadpack =3D data->options.uploadpack;
> @@ -439,11 +514,36 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>         args.server_options =3D transport->server_options;
>         args.negotiation_tips =3D data->options.negotiation_tips;
>         args.reject_shallow_remote =3D transport->smart_options->reject_s=
hallow;
> +       args.object_info =3D transport->smart_options->object_info;
> +
> +       if (transport->smart_options
> +               && transport->smart_options->object_info
> +               && transport->smart_options->object_info_oids->nr > 0) {
> +               struct ref *ref_itr =3D object_info_refs =3D alloc_ref(""=
);
> +
> +               if (!fetch_object_info(transport, data->options.object_in=
fo_data))
> +                       goto cleanup;
> +
> +               args.object_info_data =3D data->options.object_info_data;
> +               args.quiet =3D 1;
> +               args.no_progress =3D 1;
> +               for (size_t i =3D 0; i < transport->smart_options->object=
_info_oids->nr; i++) {
> +                       ref_itr->old_oid =3D transport->smart_options->ob=
ject_info_oids->oid[i];
> +                       ref_itr->exact_oid =3D 1;
> +                       if (i =3D=3D transport->smart_options->object_inf=
o_oids->nr - 1)
> +                               /* last element, no need to allocat to ne=
xt */

s/allocat/allocate/

> +                               ref_itr -> next =3D NULL;
> +                       else
> +                               ref_itr->next =3D alloc_ref("");
>
> -       if (!data->finished_handshake) {
> -               int i;
> +                       ref_itr =3D ref_itr->next;
> +               }
> +
> +               transport->remote_refs =3D object_info_refs;
> +
> +       } else if (!data->finished_handshake) {
>                 int must_list_refs =3D 0;
> -               for (i =3D 0; i < nr_heads; i++) {
> +               for (int i =3D 0; i < nr_heads; i++) {
>                         if (!to_fetch[i]->exact_oid) {
>                                 must_list_refs =3D 1;
>                                 break;
> @@ -481,23 +581,31 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>                           &transport->pack_lockfiles, data->version);
>
>         data->finished_handshake =3D 0;
> +       if (args.object_info) {
> +               struct ref *ref_cpy_reader =3D object_info_refs;
> +               for (int i =3D 0; ref_cpy_reader; i++) {
> +                       oid_object_info_extended(the_repository, &ref_cpy=
_reader->old_oid, &args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);

This line might want to be folded.


> +                       ref_cpy_reader =3D ref_cpy_reader->next;
> +               }
> +       }
> +
