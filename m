Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A101DA5A
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093989; cv=none; b=rkhHN31QjvhZhrvj9UCIGqLU2AHXvL51mLFU+oEFuhuD2go8KO+Yx7yShL2hZVoN0QhcJTBu9y/ziPbemh/CRJcIwAqp7jN/A527AtACJbDj/KCVcxHjH++c0Hilhr5Aqpsl+pwZqj5jhrsbWB07ImMGZZZNkWqs9jy2SEzp5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093989; c=relaxed/simple;
	bh=aoJA/HG2VS41drW++JD7RBOAxOhd7jQLwsV3Jdj6TmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNNZH3vUMvtCMjHWHVg6Lv6kAh1n78UqEBR3CvxwcOrLh00qmS3LxSNpCpSHemMAjR0QIB5cpRs7QJMPngb7nyONiaUmNIKMMIoqLNKh0suASlYj+ZHqLenstYOtOcYsL4zGsuzvTuLQAjsiAfm5mfSeBbe+bw7ecCYK5lJrxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvYGDybR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvYGDybR"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso3558709276.3
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 22:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730093986; x=1730698786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAyb1vLg5cJztPxolm+zaKoZJ79TRJNvlNAu31fKa9c=;
        b=AvYGDybRz0kFUUQ+o4UihhSxaERT18KeWjM32OU19Q0JoFSAdk78oH5BU4dmWCPPTZ
         QtKfbem5WRmTgP3nx+nty+NxxiigHwIFDr9x5pkaComIrg2gCQKt8QGcat0SuKCN5otb
         W62q3SQ9y0W8uEIZ27Ggw+HpfoYZ1p8KScyy2MuFUqCYPPDujb5zCaB66leEmIk3T1zS
         0ZqCLFFvJcxf1uVPC0w2u3wAogbu3bTu3VB2YmthCyoex0TECozcaNnk/RMIzy81dLzA
         rnTCNBYFmXRLO3IAxtZix77m42+YupyZrtTTENPGKPknzeLJ5lCKaFeZ2Z2X1mgXoMkS
         R7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730093986; x=1730698786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAyb1vLg5cJztPxolm+zaKoZJ79TRJNvlNAu31fKa9c=;
        b=kZhIv07w6qP4bY9EQ5jxkfLu7YRd5NcPT5KaKiWoH4A7YQjbO6tUd/vlOFYVS9Frgp
         EbqcqdxCf1gasV4EEsnHXAvg2ymzmw3abV2td9Wu/+1l0GRyePes8ZdCtuEnTWT/rd7F
         gyUocvniMWRA4OO62XQ7140I8nVUujIXCIhPrwvQ9EOliNTQY11yxbJJTlciPGk2x2L0
         gSsjcHqlLJTCYgNerdCV19RB5WfL6ZF9m75IrODAV6drUQbdDxcs8KwsA8E9rBdCNj3m
         rc+n2MYIjt5V4u3YtMf8oNQX6ro7tOwUbs3gXGUtbyYmkZPgCDxIKbGqf/4c2P9O8Fho
         +LMw==
X-Gm-Message-State: AOJu0YzrEg2WJGJAJIVrBM9Unb/PQskZAQdboHk2N+IkcDeQ4nWX+qxP
	KqBaw7Oc2wtWuLE/Jwk3N/2E9nI49AhpqxknhCkfzTYhCyZaaxxuAhOJZN0p933XW7X4in3xolR
	V0dtAULIomPB36SvWVKjrq/sGWHo=
X-Google-Smtp-Source: AGHT+IEKrg2AMZHSdc69gMPZW0FwTPwplqO4jotgBxwgeLBmYwL3uIi27ytetN1O5/iVm2xiGFtZcwj0x+ty8lgL/BY=
X-Received: by 2002:a05:6902:1685:b0:e28:e4bd:13f3 with SMTP id
 3f1490d57ef6-e3087a6edc4mr5965849276.23.1730093985855; Sun, 27 Oct 2024
 22:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com> <20241024205359.16376-5-eric.peijian@gmail.com>
 <CAOLa=ZS4XLNBeXewQ8O7tpobQfF9C9LKP--MVYghVR52hcqgWA@mail.gmail.com>
In-Reply-To: <CAOLa=ZS4XLNBeXewQ8O7tpobQfF9C9LKP--MVYghVR52hcqgWA@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 28 Oct 2024 01:39:35 -0400
Message-ID: <CAN2LT1C1dh4oSO-3q71TX-BCy-JMoDXNXBSHA3P66_EjQ+0EKg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] transport: add client support for object-info
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 6:13=E2=80=AFAM karthik nayak <karthik.188@gmail.co=
m> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> [snip]
>
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 800505f25f..1a9facc1c0 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1347,7 +1347,6 @@ static void write_command_and_capabilities(struct=
 strbuf *req_buf,
> >       packet_buf_delim(req_buf);
> >  }
> >
> > -
>
> Seems like this was introduced in Patch 1/6, including the function
> below which is not used in that patch.
>

Thank you. As explained at
https://lore.kernel.org/git/CAN2LT1CEPdTAxCEpKtd+8-5zKYSnh0PMqEXgAZ++TTMPPK=
rD1g@mail.gmail.com/.

In Patch 1/6, I am moving `write_command_and_capabilities()` to connect.c.
And I am moving `send_object_info_request()` to a new file
fetch-object-info.c in patch 4/6 where it is used.


> >  void send_object_info_request(int fd_out, struct object_info_args *arg=
s)
> >  {
> >       struct strbuf req_buf =3D STRBUF_INIT;
> > @@ -1706,6 +1705,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_=
pack_args *args,
> >       if (args->depth > 0 || args->deepen_since || args->deepen_not)
> >               args->deepen =3D 1;
> >
> > +     if (args->object_info)
> > +             state =3D FETCH_SEND_REQUEST;
> > +
> >       while (state !=3D FETCH_DONE) {
> >               switch (state) {
> >               case FETCH_CHECK_LOCAL:
>
> [snip]
>
> >  /*
> >   * sought represents remote references that should be updated from.
> >   * On return, the names that were found on the remote will have been
> > @@ -106,4 +114,6 @@ int report_unmatched_refs(struct ref **sought, int =
nr_sought);
> >   */
> >  int fetch_pack_fsck_objects(void);
> >
> > +void send_object_info_request(int fd_out, struct object_info_args *arg=
s);
> > +
> >
>
> Nit: Would be nice to have a comment here explaining what the function do=
es.
>

Thank you. Added in v5.

> >  #endif
> > diff --git a/transport-helper.c b/transport-helper.c
> > index 013ec79dc9..2ff9675984 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -709,8 +709,8 @@ static int fetch_refs(struct transport *transport,
> >
> >       /*
> >        * If we reach here, then the server, the client, and/or the tran=
sport
> > -      * helper does not support protocol v2. --negotiate-only requires
> > -      * protocol v2.
> > +      * helper does not support protocol v2. --negotiate-only and cat-=
file remote-object-info
>
> Nit: could we wrap this comment?
>

Thank you, Fixed in v5.

> > +      * require protocol v2.
> >        */
> >       if (data->transport_options.acked_commits) {
> >               warning(_("--negotiate-only requires protocol v2"));
>
> [snip]
>
> >  static struct ref *get_refs_via_connect(struct transport *transport, i=
nt for_push,
> >                                       struct transport_ls_refs_options =
*options)
> >  {
> > @@ -418,6 +489,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
> >       struct ref *refs =3D NULL;
> >       struct fetch_pack_args args;
> >       struct ref *refs_tmp =3D NULL, **to_fetch_dup =3D NULL;
> > +     struct ref *object_info_refs =3D NULL;
> >
> >       memset(&args, 0, sizeof(args));
> >       args.uploadpack =3D data->options.uploadpack;
> > @@ -444,11 +516,36 @@ static int fetch_refs_via_pack(struct transport *=
transport,
> >       args.server_options =3D transport->server_options;
> >       args.negotiation_tips =3D data->options.negotiation_tips;
> >       args.reject_shallow_remote =3D transport->smart_options->reject_s=
hallow;
> > +     args.object_info =3D transport->smart_options->object_info;
> > +
> > +     if (transport->smart_options
> > +             && transport->smart_options->object_info
> > +             && transport->smart_options->object_info_oids->nr > 0) {
> > +             struct ref *ref_itr =3D object_info_refs =3D alloc_ref(""=
);
> > +
> > +             if (!fetch_object_info(transport, data->options.object_in=
fo_data))
> > +                     goto cleanup;
>
> So if we were successful, we skip to the cleanup. Okay.
>

Yes, that is right.

> > +             args.object_info_data =3D data->options.object_info_data;
> > +             args.quiet =3D 1;
> > +             args.no_progress =3D 1;
>
> Not sure why we set quiet and no_progress here.
>

Thank you.  If the code reaches here, it means we fall back to
downloading the pack file with fetch_pack().
Setting quiet and no_progress just wants to make fetch_pack less
verbose and do its job quietly in the background.
It is like calling `git fetch-pack -q ...`. I see setting quiet and
no_progress is necessary here because:
1. If the call git fetch-pack is from an internal command, we would
better keep the call lean and efficient.
2. If the user wants to do a verbose call, they have the choice to
call git fetch-pack directly from the client.

I add a comment in v5 to explain it, like this:
" we can't retrieve object info in packets, so we will fall back to
downland pack files. We set quiet and no_progress to be true, so that
the internal call of fetch-pack is less verbose."



> > +             for (size_t i =3D 0; i < transport->smart_options->object=
_info_oids->nr; i++) {
> > +                     ref_itr->old_oid =3D transport->smart_options->ob=
ject_info_oids->oid[i];
> > +                     ref_itr->exact_oid =3D 1;
> > +                     if (i =3D=3D transport->smart_options->object_inf=
o_oids->nr - 1)
> > +                             /* last element, no need to allocate to n=
ext */
> > +                             ref_itr->next =3D NULL;
> > +                     else
> > +                             ref_itr->next =3D alloc_ref("");
> >
> > -     if (!data->finished_handshake) {
> > -             int i;
> > +                     ref_itr =3D ref_itr->next;
> > +             }
> > +
> > +             transport->remote_refs =3D object_info_refs;
> > +
> > +     } else if (!data->finished_handshake) {
> >               int must_list_refs =3D 0;
> > -             for (i =3D 0; i < nr_heads; i++) {
> > +             for (int i =3D 0; i < nr_heads; i++) {
> >                       if (!to_fetch[i]->exact_oid) {
> >                               must_list_refs =3D 1;
> >                               break;
> > @@ -494,16 +591,26 @@ static int fetch_refs_via_pack(struct transport *=
transport,
> >                         &transport->pack_lockfiles, data->version);
> >
> >       data->finished_handshake =3D 0;
> > +     if (args.object_info) {
> > +             struct ref *ref_cpy_reader =3D object_info_refs;
> > +             for (int i =3D 0; ref_cpy_reader; i++) {
> > +                     oid_object_info_extended(the_repository, &ref_cpy=
_reader->old_oid,
> > +                             &args.object_info_data[i], OBJECT_INFO_LO=
OKUP_REPLACE);
> > +                     ref_cpy_reader =3D ref_cpy_reader->next;
> > +             }
> > +     }
> > +
> >       data->options.self_contained_and_connected =3D
> >               args.self_contained_and_connected;
> >       data->options.connectivity_checked =3D args.connectivity_checked;
> >
> > -     if (!refs)
> > +     if (!refs && !args.object_info)
> >               ret =3D -1;
>
> This is because, now we don't necessary always fetch the refs, since
> sometimes we're just happy fetching the object info. Would be nice to
> have a comment here.
>

Thank you. Acutally, if the code reaches here, it means we fall back
to downloading the pack file.
I would expect there is no difference from the old logic, so
`!args.object_info` might not be needed here.
I am removing `!args.object_info` in v5.

> >       if (report_unmatched_refs(to_fetch, nr_heads))
> >               ret =3D -1;
> >
> >  cleanup:
> > +     free_refs(object_info_refs);
> >       close(data->fd[0]);
> >       if (data->fd[1] >=3D 0)
> >               close(data->fd[1]);
>
>
> [snip]
