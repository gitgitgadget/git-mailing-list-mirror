Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EF1A270
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837814; cv=none; b=H6whjQoXgznmOWK5sks5ofEQXyEXkDYsn3z5JS6dSwZZ6lKIGu1+tlWxWRSQVttPGYbaJ/prxbVhV4p4baLymjtcx9HgN9K4Xf/ExVI6v3byJU2TX8nyo4zFBdaXA4zUhj+jxySwQMoze3/+oYDkeMvCSIn6T2bfbep0HP5+oJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837814; c=relaxed/simple;
	bh=rLdSLVhEp7ZwO4SXka5JdXl1kXWh5bL6vxKB2Abq1EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEZ8apELiPsL0JgzsHx6b+ry+7lIiLzWPWQ7y5VcFSZRzPUcuhd+juEgEFY0DsGeWKPyKDGcxgl8i3uU4gDvOoui2Fyl7PijzTEzXLHbGnYRT8E7Zm5+XlvW0sJFf0TjXqQCI4WEpA2afSuLiVorrXkr6MCuVQNNmWqNlkf9CRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZHwwgRF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZHwwgRF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6325b04c275so27164517b3.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720837811; x=1721442611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6msahHIXs7uSXyDL0BJKKiM+UjgoELxVEWGF5EfUQo=;
        b=SZHwwgRFF8ClDeOpE3To2RMppweWvdEFEKQzrPKfQiCcwfpPZWYAl1ANMUVAeEctC/
         P4a6yiWSFRttD5oS4K5EmmXCubWchaofryAZz2IBKyt2qSk0sKtFK+L9kEWYDDL7F/Td
         iGRDhiVCDkpUuU4TQX3mYziyoDQ6JWPNq5xdN1juwcIsbWwhOKmBoKNVSQ0KDb4Z7p02
         DghykYmBdqC3XlgHONWprLzdlj7LIbKursnGUTPtcJ+cGTlgMMWBptOFJdMc4hKwh5xM
         xD0Vb//HDWvh0dbt5E4Z9dNVvnhuSAFRL5hNWaExMYSJFq82axMhEi/GeWvrOcQgn8iQ
         YnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720837811; x=1721442611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6msahHIXs7uSXyDL0BJKKiM+UjgoELxVEWGF5EfUQo=;
        b=GXWRIyUuulmIIlkOm9oGXMoeFsSxWcfjliUMHOmQg3zdevHpj1UKjWuWkCnki8+QLS
         EKh4IOBA+F6L1+iSIvNDvTeXEsC9o+80UFUWzptB9G1sg77sIZDv/VkWg4aBPztjIkYn
         AWgBNsnJ9UUP1sbzYSxgiPSgxkNxIBBfzWunSXjTFsOfTxlsBmwf+r3ya8Dsrpzi6b+p
         RkiPHvrVlRbSW4QtFkq/ulLH+i4DhPzzgOmFL8NxlGgFu5mV787jFd3Dv9femcIu9BKZ
         PeTNUan5QUC2Q8Ijjk7enEi77Sl/cA0V4/UCG8UggX6f2eLWNNms05FXylEPrRw/7gJz
         tOSw==
X-Forwarded-Encrypted: i=1; AJvYcCVotm5LY02wrc0KlvJiIbz3mYdRcIbRR1IQMctGH2CMsM5K/oG1EtFZrZkFzDesbTQG3i+cgpKwK9rtaAoJM1vWKCFO
X-Gm-Message-State: AOJu0YyF+gnxY2bmwwbKisatT57yFcO19RMXw6sULNoMOUhDw5tN05x/
	3IenGNZlD3/jujmISp6RloNS8K1x5NrwKCDfvjxQftjvmneCCO8IaOe4NssdLkV6hpryX+IvBLV
	yL4Q4SMX4xHa2k9zCGm6L+CXnDNI=
X-Google-Smtp-Source: AGHT+IHRDuKQ2Y0MKf5w9MLd5w/5g+U7hC6w8VLp3rFbkk85wE80v/T7yB/BNfiF9cxVVdDSwHlTAhQkhY8876XDfBs=
X-Received: by 2002:a05:690c:6213:b0:65f:a486:5a61 with SMTP id
 00721157ae682-65fa4866431mr6619787b3.10.1720837811445; Fri, 12 Jul 2024
 19:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-5-eric.peijian@gmail.com> <87ikxfqbm9.fsf@iotcl.com>
In-Reply-To: <87ikxfqbm9.fsf@iotcl.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Fri, 12 Jul 2024 22:30:00 -0400
Message-ID: <CAN2LT1D_L39EH53K=xAGx3PdK90-Wir52+mOpwwK42cc8nnHTQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] transport: add client support for object-info
To: Toon claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 3:16=E2=80=AFAM Toon claes <toon@iotcl.com> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > diff --git a/transport.c b/transport.c
> > index 83ddea8fbc..2847aa3f3c 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -436,11 +504,27 @@ static int fetch_refs_via_pack(struct transport *=
transport,
> >       args.server_options =3D transport->server_options;
> >       args.negotiation_tips =3D data->options.negotiation_tips;
> >       args.reject_shallow_remote =3D transport->smart_options->reject_s=
hallow;
> > -
> > -     if (!data->finished_handshake) {
> > -             int i;
> > +     args.object_info =3D transport->smart_options->object_info;
> > +
> > +     if (transport->smart_options && transport->smart_options->object_=
info) {
> > +             struct ref *ref =3D object_info_refs;
> > +
> > +             if (!fetch_object_info(transport, data->options.object_in=
fo_data))
> > +                     goto cleanup;
> > +             args.object_info_data =3D data->options.object_info_data;
> > +             args.quiet =3D 1;
> > +             args.no_progress =3D 1;
> > +             for (size_t i =3D 0; i < transport->smart_options->object=
_info_oids->nr; i++) {
> > +                     struct ref *temp_ref =3D xcalloc(1, sizeof (struc=
t ref));
> > +                     temp_ref->old_oid =3D *(transport->smart_options-=
>object_info_oids->oid + i);
>
> Any reason why you're not using the subscript operator (square brackets)
> like this:
>
> +                       temp_ref->old_oid =3D transport->smart_options->o=
bject_info_oids->oid[I];
>

Thank you. Fixed in V2.

> > +                     temp_ref->exact_oid =3D 1;
> > +                     ref->next =3D temp_ref;
> > +                     ref =3D ref->next;
> > +             }
> > +             transport->remote_refs =3D object_info_refs->next;
>
> I find it a bit weird you're allocating object_info_refs, only to use it
> to point to the next. Can I suggest a little refactor:
>

Thank you. I have to agree that the old implementation of iterating on
the object_info_refs linked list is a bit obscure.
Your suggestion is easier to follow. I am replacing the old logic in V2.

> ----8<-----8<----
> diff --git a/transport.c b/transport.c
> index 662faa004e..56cb3a1693 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -479,7 +479,7 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
>         struct ref *refs =3D NULL;
>         struct fetch_pack_args args;
>         struct ref *refs_tmp =3D NULL;
> -       struct ref *object_info_refs =3D xcalloc(1, sizeof (struct ref));
> +       struct ref *object_info_refs =3D NULL;
>
>         memset(&args, 0, sizeof(args));
>         args.uploadpack =3D data->options.uploadpack;
> @@ -509,7 +509,7 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
>         args.object_info =3D transport->smart_options->object_info;
>
>         if (transport->smart_options && transport->smart_options->object_=
info) {
> -               struct ref *ref =3D object_info_refs;
> +               struct ref *ref =3D object_info_refs =3D xcalloc(1, sizeo=
f (struct ref));
>
>                 if (!fetch_object_info(transport, data->options.object_in=
fo_data))
>                         goto cleanup;
> @@ -517,13 +517,12 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>                 args.quiet =3D 1;
>                 args.no_progress =3D 1;
>                 for (size_t i =3D 0; i < transport->smart_options->object=
_info_oids->nr; i++) {
> -                       struct ref *temp_ref =3D xcalloc(1, sizeof (struc=
t ref));
> -                       temp_ref->old_oid =3D *(transport->smart_options-=
>object_info_oids->oid + i);
> -                       temp_ref->exact_oid =3D 1;
> -                       ref->next =3D temp_ref;
> +                       ref->old_oid =3D transport->smart_options->object=
_info_oids->oid[i];
> +                       ref->exact_oid =3D 1;
> +                       ref->next =3D xcalloc(1, sizeof (struct ref));
>                         ref =3D ref->next;
>                 }
> -               transport->remote_refs =3D object_info_refs->next;
> +               transport->remote_refs =3D object_info_refs;
>         } else if (!data->finished_handshake) {
>                 int must_list_refs =3D 0;
>                 for (int i =3D 0; i < nr_heads; i++) {
> @@ -565,7 +564,7 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
>
>         data->finished_handshake =3D 0;
>         if (args.object_info) {
> -               struct ref *ref_cpy_reader =3D object_info_refs->next;
> +               struct ref *ref_cpy_reader =3D object_info_refs;
>                 for (int i =3D 0; ref_cpy_reader; i++) {
>                         oid_object_info_extended(the_repository, &ref_cpy=
_reader->old_oid, &(*args.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE)=
;
>                         ref_cpy_reader =3D ref_cpy_reader->next;
> ----8<-----8<----
>
> To be honest, I'm not sure it works, because fetch_object_info() always
> seem to return a non-zero value. I'm not sure this is due to missing
> code coverage, or a bug. I guess it's worth looking into.
>

Thank you. I tested your suggestion and it is working. I can confirm
it when I did the following with my debugger
    1. pause on a test case of t/t1017-cat-file-remote-object-info.sh
    2. git cat-file "--batch-command=3D%(objectname) %(objectsize)"
    3. remote-object-info http://127.0.0.1:11017/smart/http_parent
5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
I set breakpoints all along and see that fetch_object_info() returned zero

Would you mind sharing your test steps with me? I would love to dig deeper.

> --
> Toon
