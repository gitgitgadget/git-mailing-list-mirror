Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987F13C8E8
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288960; cv=none; b=gxPXlxksrI205Pq1/rCp+o/rXNmHAk30FEF/442/srZLupYyUnE8QZ88ayxb6Tw1QFmnwvKz5IW45hQWtMU5ZqN8eh/jxUp1AB8Ms0tbwuvOzhvNHJzRBGls+P1XhTJPCid5Mzq+V2kFHfwKumRvR5ubylghHJONJRRmoR3vbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288960; c=relaxed/simple;
	bh=sKwEtG9ygi9wvgEQjjp888BliOEbya8il+X3TJ+Lnys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lT4l0nIch9dtHd4Ca/9D/BWgHRMrOWasOeQ2vMVQvJSE5EhhEJ/4GKMxBZsfL+IMnDiPWizK6+v2vdxvEPxtLjZ0MN8FmBOuM6oSyEBuV1J1hkkys4jNn5Zms0RjMG769rVPYYlTzfoznKCTnPRNRFvPD9PsSYWah7mPKr9ZVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0hdbZe0; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0hdbZe0"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e201f146cc8so139223276.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727288957; x=1727893757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHikw952mI8vZtu1pZlE9aCFm03VwQ6RhHNMZVqE6ls=;
        b=b0hdbZe00GsIRqsGkmszFVnUsvwF0hX4yn/MEVifsc3ObSfEt2y6Evk/wTjWvy5YKs
         9JL6vNz9pPU4d2yykzrBCWZK94OK9yYL7iVmx7oz3KEEIFqHTcY/psdBgSSkv96Ll205
         CMVlEk6OhMrzn7G9BoNeR7XEiHg/YDA2pC3EfJIlr76Sq3fN3Ehy7LXxzx1RW6HxC4Bw
         uNRSBIjKPYNiKVz/3ZSBhsRRbez4NXmTjQ2SNKt/GjBK6pm/BqWaHnyzorgSRss5hX+z
         UqPiqij6HRbkBSqnx+2lN69Oncxo/EVhRKFS5jgqoPPNG7TYZ3ElUln6yCVLwF+IoPz/
         I/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288957; x=1727893757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHikw952mI8vZtu1pZlE9aCFm03VwQ6RhHNMZVqE6ls=;
        b=Z1yuOj0cIkj4oEuLmyeJrWwxa2Vuu5CwAJ7MAmxfLrhPhr5nkDQKpaOKHu4jYyWkX2
         6v/cBa1K7mVLPWTXWPrvAW0B7y7P+s3dZJyf1ZLye/cduTWohQW8PFZB3mgW63FYJEdp
         YNjxd1hmSxS6xfpnNUI9+SX9UW5hrYScuDtUMbfDmP8vT2y2PYlKidC0+g7DwE36oNLA
         oNdng+EJ2xs9eGtN5i6A0XsQxOHDqjWJ+kRZtYS/TERXPcattzajlt255ZVRIwqefMw4
         FIwoYXHh6gwtAvH/dJ2cM/NKsEzPVTQ9qk0gbke/AkvEhxvNtVT8plcLRApTpwKTwgGr
         H1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ue6i/UygIx8jyauo3VlFHdMxJJC8rmIKAyjq8dsh99vBraGadXlXq/mBh+i1vYv1YqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qJ0bP0PUAcXtUfPu7lPWD4dYjhnBdSzBn5u4DC7U9YLLz/K5
	2+ru8+gfHqG5Nigccog0mJSkSQyTHr+wcqeNPuvmq03QriLl6uBRRRmnCgw09FVhble/Nr5zxxB
	pG7Uv8oyx5o5Ti2ulksnSc5fUAvI=
X-Google-Smtp-Source: AGHT+IHMBEqz0Ez7mh/RQHG3rmVRaUGHZl5v9xAXbQdsq2XpzGymO3AdMWxh8YLNLQT7Jl/5tjzqGuMIg2xGPxJ8Vbw=
X-Received: by 2002:a05:6902:178b:b0:e1d:2917:b1f0 with SMTP id
 3f1490d57ef6-e24d7fdd6f3mr3274818276.21.1727288957186; Wed, 25 Sep 2024
 11:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com> <20240720034337.57125-5-eric.peijian@gmail.com>
 <CAP8UFD0WVgTfgY5aBr8wUxFWi8ggTxL66jnRLLnVkTOniL0Wvg@mail.gmail.com>
In-Reply-To: <CAP8UFD0WVgTfgY5aBr8wUxFWi8ggTxL66jnRLLnVkTOniL0Wvg@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 25 Sep 2024 14:29:06 -0400
Message-ID: <CAN2LT1BaeLHYJRdGiuuTKeaBFJU9WRHxGiWY=fQVOCMufwiwrA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] transport: add client support for object-info
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	karthik.188@gmail.com, toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 7:45=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jul 20, 2024 at 5:43=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> =
wrote:
>
> [...]
>
> >  fetch-pack.c       |  24 +++++++++
> >  fetch-pack.h       |  10 ++++
> >  transport-helper.c |   8 ++-
> >  transport.c        | 118 +++++++++++++++++++++++++++++++++++++++++++--
> >  transport.h        |  11 +++++
> >  5 files changed, 164 insertions(+), 7 deletions(-)
>
> Karthik suggested adding tests at this stage, but I see no tests here.
> Maybe the tests are added later, but I agree with Karthik that it
> would be nice to add them early if possible.
>

Thank you. I=E2=80=99m not sure if there=E2=80=99s an easy way to directly =
add unit
tests for the changes in fetch-pack.c, transport-helper.c, and
transport.c, as the relevant functions are deeply nested within the
client=E2=80=99s call stack. Therefore, I=E2=80=99m attempting to test them=
 indirectly
through git cat-file in t/t1017-cat-file-remote-object-info.sh in the
next commit.

Specifically, in t/t1017-cat-file-remote-object-info.sh:

- The code in transport-helper.c is tested in the cases
=E2=80=9Cremote-object-info fails on server with legacy protocol=E2=80=9D a=
nd
=E2=80=9Cremote-object-info fails on server with legacy protocol fallback=
=E2=80=9D.

- The code in transport.c and fetch-pack.c is tested in the cases
where transfer.advertiseobjectinfo is set to true, such as in
=E2=80=9Cbatch-command remote-object-info http://=E2=80=9D, =E2=80=9Cbatch-=
command
remote-object-info file://=E2=80=9D, and =E2=80=9Cbatch-command remote-obje=
ct-info
git://=E2=80=9D. In these tests, we verify that remote-object-info
successfully retrieves the size from the remote without downloading
the objects locally.


> > diff --git a/transport-helper.c b/transport-helper.c
> > index 09b3560ffd..841a32e80a 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -699,13 +699,17 @@ static int fetch_refs(struct transport *transport=
,
> >
> >         /*
> >          * If we reach here, then the server, the client, and/or the tr=
ansport
> > -        * helper does not support protocol v2. --negotiate-only requir=
es
> > -        * protocol v2.
> > +        * helper does not support protocol v2. --negotiate-only and ca=
t-file remote-object-info
> > +        * require protocol v2.
> >          */
> >         if (data->transport_options.acked_commits) {
> >                 warning(_("--negotiate-only requires protocol v2"));
> >                 return -1;
> >         }
> > +       if (transport->smart_options->object_info) {
> > +               // fail the command explicitly to avoid further command=
s input
>
> We use "/* stuff */" for one line comments instead of "// stuff". Also
> the comment could go before the if (...) above and the "{" and "}"
> could be dropped.
>

Thank you. Revised in V3.

> > +               die(_("remote-object-info requires protocol v2"));
> > +       }
>
> [...]
>
> > +static int fetch_object_info(struct transport *transport, struct objec=
t_info *object_info_data)
> > +{
> > +       int size_index =3D -1;
> > +       struct git_transport_data *data =3D transport->data;
> > +       struct object_info_args args =3D { 0 };
> > +       struct packet_reader reader;
> > +
> > +       args.server_options =3D transport->server_options;
> > +       args.object_info_options =3D transport->smart_options->object_i=
nfo_options;
> > +       args.oids =3D transport->smart_options->object_info_oids;
> > +
> > +       connect_setup(transport, 0);
> > +       packet_reader_init(&reader, data->fd[0], NULL, 0,
> > +                       PACKET_READ_CHOMP_NEWLINE |
> > +                       PACKET_READ_GENTLE_ON_EOF |
> > +                       PACKET_READ_DIE_ON_ERR_PACKET);
> > +       data->version =3D discover_version(&reader);
> > +
> > +       transport->hash_algo =3D reader.hash_algo;
> > +
> > +       switch (data->version) {
> > +       case protocol_v2:
> > +               if (!server_supports_v2("object-info"))
> > +                       return -1;
> > +               if (unsorted_string_list_has_string(args.object_info_op=
tions, "size")
> > +                               && !server_supports_feature("object-inf=
o", "size", 0)) {
> > +                       return -1;
> > +               }
>
> The "{" and "}" can be dropped here too.
>

Thank you. Fixed in V3.

> > +               send_object_info_request(data->fd[1], &args);
> > +               break;
> > +       case protocol_v1:
> > +       case protocol_v0:
> > +               die(_("wrong protocol version. expected v2"));
> > +       case protocol_unknown_version:
> > +               BUG("unknown protocol version");
> > +       }
> > +
> > +       for (size_t i =3D 0; i < args.object_info_options->nr; i++) {
> > +               if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL=
) {
> > +                       check_stateless_delimiter(transport->stateless_=
rpc, &reader, "stateless delimiter expected");
> > +                       return -1;
> > +               }
> > +               if (unsorted_string_list_has_string(args.object_info_op=
tions, reader.line)) {
> > +                       if (!strcmp(reader.line, "size")) {
> > +                               size_index =3D i;
> > +                               for (size_t j =3D 0; j < args.oids->nr;=
 j++) {
> > +                                       object_info_data[j].sizep =3D x=
calloc(1, sizeof(long));
> > +                               }
>
> The "{" and "}" can be dropped here too.
>

Thank you. Fixed in V3.

> > +                       }
> > +                       continue;
> > +               }
> > +               return -1;
> > +       }
> > +
> > +       for (size_t i =3D 0; packet_reader_read(&reader) =3D=3D PACKET_=
READ_NORMAL && i < args.oids->nr; i++){
> > +               struct string_list object_info_values =3D STRING_LIST_I=
NIT_DUP;
> > +
> > +               string_list_split(&object_info_values, reader.line, ' '=
, -1);
> > +               if (0 <=3D size_index) {
> > +                       if (!strcmp(object_info_values.items[1 + size_i=
ndex].string, ""))
> > +                               die("object-info: not our ref %s",
> > +                                       object_info_values.items[0].str=
ing);
> > +
> > +                       *object_info_data[i].sizep =3D strtoul(object_i=
nfo_values.items[1 + size_index].string, NULL, 10);
> > +
>
> This blank line can be removed.
>

Thank you. Fixed in V3.

> > +               }
> > +
> > +               string_list_clear(&object_info_values, 0);
> > +       }
> > +       check_stateless_delimiter(transport->stateless_rpc, &reader, "s=
tateless delimiter expected");
> > +
> > +       return 0;
> > +}
> > +
> >  static struct ref *get_refs_via_connect(struct transport *transport, i=
nt for_push,
> >                                         struct transport_ls_refs_option=
s *options)
> >  {
> > @@ -413,6 +487,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
> >         struct ref *refs =3D NULL;
> >         struct fetch_pack_args args;
> >         struct ref *refs_tmp =3D NULL;
> > +       struct ref *object_info_refs =3D NULL;
> >
> >         memset(&args, 0, sizeof(args));
> >         args.uploadpack =3D data->options.uploadpack;
> > @@ -439,11 +514,36 @@ static int fetch_refs_via_pack(struct transport *=
transport,
> >         args.server_options =3D transport->server_options;
> >         args.negotiation_tips =3D data->options.negotiation_tips;
> >         args.reject_shallow_remote =3D transport->smart_options->reject=
_shallow;
> > +       args.object_info =3D transport->smart_options->object_info;
> > +
> > +       if (transport->smart_options
> > +               && transport->smart_options->object_info
> > +               && transport->smart_options->object_info_oids->nr > 0) =
{
> > +               struct ref *ref_itr =3D object_info_refs =3D alloc_ref(=
"");
> > +
> > +               if (!fetch_object_info(transport, data->options.object_=
info_data))
> > +                       goto cleanup;
> > +
> > +               args.object_info_data =3D data->options.object_info_dat=
a;
> > +               args.quiet =3D 1;
> > +               args.no_progress =3D 1;
> > +               for (size_t i =3D 0; i < transport->smart_options->obje=
ct_info_oids->nr; i++) {
> > +                       ref_itr->old_oid =3D transport->smart_options->=
object_info_oids->oid[i];
> > +                       ref_itr->exact_oid =3D 1;
> > +                       if (i =3D=3D transport->smart_options->object_i=
nfo_oids->nr - 1)
> > +                               /* last element, no need to allocat to =
next */
>
> s/allocat/allocate/
>

Thank you. Fixed in V3.

> > +                               ref_itr -> next =3D NULL;
> > +                       else
> > +                               ref_itr->next =3D alloc_ref("");
> >
> > -       if (!data->finished_handshake) {
> > -               int i;
> > +                       ref_itr =3D ref_itr->next;
> > +               }
> > +
> > +               transport->remote_refs =3D object_info_refs;
> > +
> > +       } else if (!data->finished_handshake) {
> >                 int must_list_refs =3D 0;
> > -               for (i =3D 0; i < nr_heads; i++) {
> > +               for (int i =3D 0; i < nr_heads; i++) {
> >                         if (!to_fetch[i]->exact_oid) {
> >                                 must_list_refs =3D 1;
> >                                 break;
> > @@ -481,23 +581,31 @@ static int fetch_refs_via_pack(struct transport *=
transport,
> >                           &transport->pack_lockfiles, data->version);
> >
> >         data->finished_handshake =3D 0;
> > +       if (args.object_info) {
> > +               struct ref *ref_cpy_reader =3D object_info_refs;
> > +               for (int i =3D 0; ref_cpy_reader; i++) {
> > +                       oid_object_info_extended(the_repository, &ref_c=
py_reader->old_oid, &args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
>
> This line might want to be folded.
>

Thank you. Fixed in V3.



>
> > +                       ref_cpy_reader =3D ref_cpy_reader->next;
> > +               }
> > +       }
> > +
