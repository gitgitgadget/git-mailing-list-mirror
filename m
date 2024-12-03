Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418D17588
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195720; cv=none; b=DLJFUWHtjQHCOpHsJf74sU8eKUfIFCiTXaeQsqY3cijYAQh+PzrO/Kn106D0F4vtdbRt2XUtW4Apdm3Ax0CRnzuY9S5TEwtmWdFv1pBwJd9iTsP0zYc0vJZ+cw376ofDuBZ7L0CUC1S7zPGx9DgtCp+8cD/U1BEi69RsmFUmLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195720; c=relaxed/simple;
	bh=Go+C0EodYirWF89SFfcm3LaH0HR7bDzoR+K3x6FZYD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY3VKc1hg0vJqASmeGmEt/qmdt6sZga11VTPQGb385PXDv/guB/g0EWnzsmWuTav48McsUF/+t22AW5txxEF3wf8j5q0cr/Qq3YQpBjzkg+LQMSnGpH2H+mxy316o9SVSorwA/H+3uGlg8EOaVjGo7W8VvLRGSoSSaIg/pyu8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1ZkOc3B; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ZkOc3B"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e398dc7864dso3196890276.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733195718; x=1733800518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LriY3G5g2+SwkTdsu5vJfOuyKCjsKV9N4jIytQhXU0A=;
        b=Y1ZkOc3BdY5UHv13N4Q0bVjoh+ihNqZyRcarDqOpPMv2ejwF/e3RmECE7QnZHLnc4c
         nOeaq2/x6SVuyDkU0adHeAl9AGpMcUola+qC6w02PXemKgT3I0zZWqEL4Go0PTHHTmuJ
         rcovcTmhplNRql/45ucfUNv49l2q2Ot4UV5wkkOUF9nhEQ9UPVF5aghhA6V5KafL5N0T
         NQQUvHCah4QMobFq29o6wPMY6af/xxMssasjpH4LC5Xn2JGlPH+L4kz5URUyNYAqw9i7
         UOmvOeEkN1wcA0jkz6LT8oRXWWHTxMpZASMyC9QoSVhrln4krAZjlUNbvdHLpD+8gFxr
         //gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733195718; x=1733800518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LriY3G5g2+SwkTdsu5vJfOuyKCjsKV9N4jIytQhXU0A=;
        b=IVlmZkaY+1/WFVTWdM9SDTz38YjMgO+YzsnwCvtDkel2bNdEhzLKdPII9ZToQOqg/n
         WgR4okcqT39YU6YSc+0YaAz0SS1EJM6zYXM+mCqPKwoWpZQJh/nB5+h2FBQ1/jbRnDqq
         n25pZ6eehlc9PNz4KTH0CblBT+LilyK6NEigldWh1mq7P7eb6Q5zBQSkaibCvZsK0PMZ
         mQ14hMy7yptDOYKvFVyCg77WEOJwIQrRO3lNDGYDzSqZKMfBtrzzXHSVgYt7Q3UdeNir
         y37GuRFMHqgRJtNclpBRMh9cuODxUaNhd6gvcgo0oGqZlCKaLuqsazJ5yCMsFu9VfAXT
         fUpA==
X-Gm-Message-State: AOJu0Ywinh/CJJcjJEyQgQMTM4bh4nzzoyk1tUXdvkk6xhbe30nHXfmr
	n9rpKxFNedWNawehdFHHqB8ZM5HyRheHtQStLqh7Q5HcHNC9Dcm8mCM+Sz+ExDxAKr4d6Ys850M
	8caUGqCA3LorSF98AArVoSOBequY=
X-Gm-Gg: ASbGnctFiKZw+wOrTXL4Hxc02b4uUvBTjdbAZi60FGl+0KfsjYIqWvGMb0rCSgWa0pk
	EuxEsjnDgEYrFMHoqukE6hAUQWUZF0aZx
X-Google-Smtp-Source: AGHT+IFST8TmKa1Mllyw6N5GfzAUfsiCUZigN2zfgXOmoSkuTpl6B1WKXG2vW7KwH/I0nxxTVfa8ot+XKppz+OKQ+WQ=
X-Received: by 2002:a05:6902:70a:b0:e29:380:4f18 with SMTP id
 3f1490d57ef6-e39d4387912mr1143541276.43.1733195717667; Mon, 02 Dec 2024
 19:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com> <20241125053616.25170-6-eric.peijian@gmail.com>
 <Z0RIrKwUnaWWm_gJ@pks.im>
In-Reply-To: <Z0RIrKwUnaWWm_gJ@pks.im>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 2 Dec 2024 22:15:06 -0500
Message-ID: <CAN2LT1ASdzLdm4Mt0aKe8kAo05uJFY4o+wJkvVt82o7i56WAzw@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] transport: add client support for object-info
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

Thank you for your feedback. I have a few questions. I agree with the
comments I didn=E2=80=99t specifically respond to and will address them in =
v8.

Eric.

On Mon, Nov 25, 2024 at 4:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Nov 25, 2024 at 12:36:15AM -0500, Eric Ju wrote:
> > diff --git a/fetch-object-info.c b/fetch-object-info.c
> > new file mode 100644
> > index 0000000000..2aa9f2b70d
> > --- /dev/null
> > +++ b/fetch-object-info.c
> > @@ -0,0 +1,92 @@
> > +#include "git-compat-util.h"
> > +#include "gettext.h"
> > +#include "hex.h"
> > +#include "pkt-line.h"
> > +#include "connect.h"
> > +#include "oid-array.h"
> > +#include "object-store-ll.h"
> > +#include "fetch-object-info.h"
> > +#include "string-list.h"
> > +
> > +/**
> > + * send_object_info_request sends git-cat-file object-info command and=
 its
> > + * arguments into the request buffer.
> > + */
> > +static void send_object_info_request(const int fd_out, struct object_i=
nfo_args *args)
> > +{
> > +     struct strbuf req_buf =3D STRBUF_INIT;
> > +
> > +     write_command_and_capabilities(&req_buf, "object-info", args->ser=
ver_options);
> > +
> > +     if (unsorted_string_list_has_string(args->object_info_options, "s=
ize"))
> > +             packet_buf_write(&req_buf, "size");
>
> Do we have a document somewhere that spells out the wire format that
> client- and server-side talk with each other? If so it would be nice to
> point it out in the commit message so that I know where to look, and
> otherwise we should document it. Without such a doc it's hard to figure
> out whether this is correct.
>

Thank you. Is this what you are looking for?
https://git-scm.com/docs/protocol-v2#_object_info
If so, I will put it in the commit message in v8.

> > +     if (args->oids) {
> > +             for (size_t i =3D 0; i < args->oids->nr; i++)
> > +                     packet_buf_write(&req_buf, "oid %s", oid_to_hex(&=
args->oids->oid[i]));
> > +     }
>
> Nit: needless curly braces.
>
> > +     packet_buf_flush(&req_buf);
> > +     if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> > +             die_errno(_("unable to write request to remote"));
>
> So we write the whole request into `req_buf` first before sending it to
> the remote. Isn't that quite inefficient memory wise? In other words,
> couldn't we instead stream the request line by line or at least in
> batches to the file descriptor?
>

Thank you.

I followed the `send_fetch_request()` logic in `fetch-pack.c`.  I=E2=80=99m
not entirely clear on how to =E2=80=9Cstream the request line by line or in
batches.=E2=80=9D Could you point me to an example or reference that
demonstrates this approach?

> > +     strbuf_release(&req_buf);
> > +}
> > +
> > +/**
>
> Nit: s|/**|/*|
>
> > + * fetch_object_info sends git-cat-file object-info command into the r=
equest buf
> > + * and read the results from packets.
> > + */
> > +int fetch_object_info(const enum protocol_version version, struct obje=
ct_info_args *args,
> > +                   struct packet_reader *reader, struct object_info *o=
bject_info_data,
> > +                   const int stateless_rpc, const int fd_out)
> > +{
> > +     int size_index =3D -1;
> > +
> > +     switch (version) {
> > +     case protocol_v2:
> > +             if (!server_supports_v2("object-info"))
> > +                     die(_("object-info capability is not enabled on t=
he server"));
> > +             send_object_info_request(fd_out, args);
> > +             break;
> > +     case protocol_v1:
> > +     case protocol_v0:
> > +             die(_("wrong protocol version. expected v2"));
> > +     case protocol_unknown_version:
> > +             BUG("unknown protocol version");
> > +     }
> > +
> > +     for (size_t i =3D 0; i < args->object_info_options->nr; i++) {
> > +             if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL) {
> > +                     check_stateless_delimiter(stateless_rpc, reader, =
"stateless delimiter expected");
> > +                     return -1;
> > +             }
> > +             if (unsorted_string_list_has_string(args->object_info_opt=
ions, reader->line)) {
>
> Hum. Does this result in quadratic runtime behaviour?
>
> > +                     if (!strcmp(reader->line, "size")) {
> > +                             size_index =3D i;
> > +                             for (size_t j =3D 0; j < args->oids->nr; =
j++)
> > +                                     object_info_data[j].sizep =3D xca=
lloc(1, sizeof(long));
>
> This might be a bit more future proof in case the `sizep` type were ever
> to change:
>
>         object_info_data[j].sizep =3D xcalloc(1, sizeof(*object_info_data=
[j].sizep));
>
> It also allows you to skip double-checking whether you picked the
> correct type. In fact, the type is actually an `unsigned long`, which
> is confusing but ultimately does not make much of a difference because
> it should have the same size.
>
> > +                     }
> > +                     continue;
> > +             }
> > +             return -1;
> > +     }
> > +
> > +     for (size_t i =3D 0; packet_reader_read(reader) =3D=3D PACKET_REA=
D_NORMAL && i < args->oids->nr; i++){
> > +             struct string_list object_info_values =3D STRING_LIST_INI=
T_DUP;
> > +
> > +             string_list_split(&object_info_values, reader->line, ' ',=
 -1);
> > +             if (0 <=3D size_index) {
> > +                     if (!strcmp(object_info_values.items[1 + size_ind=
ex].string, ""))
> > +                             die("object-info: not our ref %s",
> > +                                     object_info_values.items[0].strin=
g);
> > +
> > +                     *object_info_data[i].sizep =3D strtoul(object_inf=
o_values.items[1 + size_index].string, NULL, 10);
>
> We're completely missing error handling for strtoul(3p) here. That
> function is also discouraged nowadays because error handling is hard to
> do correct. We have `strtoul_ui()` and friends, but don't have a variant
> yet that know to return an `unsigned long`. We might backfill that
> omission and then use it instead.
>
> > diff --git a/transport-helper.c b/transport-helper.c
> > index bc27653cde..bf0a1877c7 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -728,6 +728,13 @@ static int fetch_refs(struct transport *transport,
> >               free_refs(dummy);
> >       }
> >
> > +     /* fail the command explicitly to avoid further commands input. *=
/
> > +     if (transport->smart_options->object_info)
> > +             die(_("remote-object-info requires protocol v2"));
>
> The code path that checks for for protocol v2 with "--negotiate-only"
> knows to warn and return an error. Should we do the same here?
>

Thank you.

If we follow "warn and return an error" as "--negotiate-only", we will
end up with "warn and wait". This was the question I was asking in the
previous patches:

     In the current implementation, if a user puts
`remote-object-info` in protocol v1,
     `cat-file --batch-command` will die. Which way do we prefer?
"error and exit (i.e. die)"
     or "warn and wait for new command".

And we decided to take the path of "error and exit (i.e. die)", the
reason was explained at
https://lore.kernel.org/git/CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdK=
aO4g@mail.gmail.com/:

    Our primary use case is to use git cat-file remote-object-info in
a promisor remote setup to retrieve metadata
    about an object stored in the promisor remote, without fetching it
back to the local repository.
    This approach helps conserve disk space. I don=E2=80=99t believe other
commands can achieve this functionality,
    particularly without requiring the object to be downloaded.


> > diff --git a/transport.c b/transport.c
> > index 47fda6a773..746ec19ddc 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -9,6 +9,7 @@
> >  #include "hook.h"
> >  #include "pkt-line.h"
> >  #include "fetch-pack.h"
> > +#include "fetch-object-info.h"
> >  #include "remote.h"
> >  #include "connect.h"
> >  #include "send-pack.h"
> > @@ -444,8 +445,33 @@ static int fetch_refs_via_pack(struct transport *t=
ransport,
> >       args.server_options =3D transport->server_options;
> >       args.negotiation_tips =3D data->options.negotiation_tips;
> >       args.reject_shallow_remote =3D transport->smart_options->reject_s=
hallow;
> > +     args.object_info =3D transport->smart_options->object_info;
> > +
> > +     if (transport->smart_options
> > +             && transport->smart_options->object_info
> > +             && transport->smart_options->object_info_oids->nr > 0) {
>
> Formatting is wrong here:
>
>         if (transport->smart_options &&
>             transport->smart_options->object_info &&
>             transport->smart_options->object_info_oids->nr > 0) {
>
> Patrick
