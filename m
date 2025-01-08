Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE51F9439
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351752; cv=none; b=SMpWvMt34ug+5XUkH0AIyKXUw0BA7Ho4O5vqITJujAAEEb32VbUFblikg1hVM4zuMdN/EtAjpr2Wngl5jRMy/CnsieiW/wmOnQnB/TygS1a7f4YFLbEUhiqnrDhlr/1klyO/xqtuQjN69/7tP9qXGa4P74Rb+AiHTVShqoOe1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351752; c=relaxed/simple;
	bh=0tCeKM+vzXxs6UQIseVZXRWAKs5x3KI0+eBifySzzwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVdZXbz5GzzmWKZy1wmdhoI+H7mF+ky1p2iKp+06bP7u26ldYIOpbXEDiMnUMKcs67uXIKiHuGEvOSy9kDBylc7LPJnGEoMaCXPTeoWr6sMzbptXy9kQAGCy2ZdskxTkDqUJD5Ly5bRxfTUnLGtGlV2cC8FECTYIYc2AiQB6Bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esrKlEze; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esrKlEze"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53a91756e5so24128453276.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736351749; x=1736956549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD4ag8eNjnQeSlIDTzz5Zqcrt2M56/8eSQz6YIsIe/I=;
        b=esrKlEzeGEJ1EkrJeRn7Ek644IFGILALvfXRfw//tAlqpm057Y41QsHcV4Kv/ZSHeZ
         ncaqIuV1+mJK+qoofmyuciSNyyRuxik2ejIAtWh25EszQ3vDFEnerArglZQfila9gcGM
         hu0QbzGz3gMJAYxVoKap2vUEvi2AfoQHyAPler2QhgNQPM89+q6ZL1QRCC7jygVkzemw
         70bz4r9P+XF9/F9ou8DajYuGKsGdh9kXGAlSuTs8JDhcUG7sxMGlI2i1CeKDneKT8Bm+
         8iWKisGneE5UWEp2UdVXNlhkiA5yj0gcDoFEIO5uoB8ahF7H6QXdbTLR0WXZUAsKDCta
         w38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736351749; x=1736956549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD4ag8eNjnQeSlIDTzz5Zqcrt2M56/8eSQz6YIsIe/I=;
        b=bDOYpt0NYLV1/83rfQ6ahHbQF6EtbE75u8KEINL7TuNOuR2KG9QjcYqrHq2fNh6sgD
         KzdZ/DJjDNT+Kwrni6oBR9AlxWlSqDvHlLaaG+AUeFUqdkRFrUjtTsIh53X7u0lBc/sE
         JIHLSqJYtlbK1gxgVv0jL5DEKKJtvQVV0ef/NOfS9ZuGRntitrOtdFAICx+3Rv9WrNvc
         wgXqBSm4faEDQu30akUCeYNOhI8EQqPXDMNq60x71vUgEbPG/wqQxMGLS0MQFK/YK0U3
         nbnuf3dyjIN/Zk3EByVsgUYWc4L8Plg8PaAOcIFOJnXqfGeGc4CiziwbljoaXB1xRsMH
         H7IA==
X-Gm-Message-State: AOJu0YyegxSjMwOzUJdLlRwX8hiTqVvSMcr25DH48VHVqssTPSBydMSG
	hz5Bhx5XU/xB+5jUWI22jWoKhTT2+SXOr7i6XcnDCVJR/WWyMQ63vmIj/Gz9JkFcPGZWZCtqXET
	j6rp2no0NdTzNT/wJjPCyKAO4L/cIncw2
X-Gm-Gg: ASbGncv2bptFA48e+irUaiH1X02OGke3hYzKonG/899vRaMsTGfN7Yc47/1RUP/8BTa
	VMKin57WgJ29P5wPRszphBeQv7rY6Jbc0/Q81n+hV
X-Google-Smtp-Source: AGHT+IHJtHnzrUetkw+Nj6ypXY6vsimvloo3pYek0TrbTFBtfCdwdC9WI7LvR0rUevHLlcJkeDA7C10uXh4kevI+Seg=
X-Received: by 2002:a05:690c:c8c:b0:6ef:e390:95ee with SMTP id
 00721157ae682-6f5311f82f7mr27789027b3.3.1736351749318; Wed, 08 Jan 2025
 07:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com> <20241223232523.76236-6-eric.peijian@gmail.com>
 <CAFySSZAqh6J14+r9JLM3LmRmV02ZvPRf5dB3rWVnUZS_5XaHcQ@mail.gmail.com>
In-Reply-To: <CAFySSZAqh6J14+r9JLM3LmRmV02ZvPRf5dB3rWVnUZS_5XaHcQ@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 8 Jan 2025 10:55:38 -0500
X-Gm-Features: AbW1kva5sbtHwxCYVDGo_2fv_7Q5oTrSlekVa4yEZrbkcqHQo08UuxE0RdqkLMw
Message-ID: <CAN2LT1Af_uzcsJBdFFNoTrLOyQiY9Cbts2=RnPWMS41vQi3m4Q@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] transport: add client support for object-info
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	karthik.188@gmail.com, toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 1:31=E2=80=AFPM Calvin Wan <calvinwan@google.com> wr=
ote:
>
> Thanks for picking up this series btw!
>
> On Mon, Dec 23, 2024 at 3:25=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> =
wrote:
> >
> > From: Calvin Wan <calvinwan@google.com>
> >
> > Sometimes, it is beneficial to retrieve information about an object
> > without downloading it entirely. The server-side logic for this
> > functionality was implemented in commit "a2ba162cda (object-info:
> > support for retrieving object info, 2021-04-20)."
> >
> > This commit introduces client functions to interact with the server.
> >
> > Currently, the client supports requesting a list of object IDs with
> > the =E2=80=98size=E2=80=99 feature from a v2 server. If the server does=
 not advertise
> > this feature (i.e., transfer.advertiseobjectinfo is set to false),
> > the client will return an error and exit.
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> > ---
> >  Makefile            |  1 +
> >  fetch-object-info.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
> >  fetch-object-info.h | 18 +++++++++
> >  fetch-pack.c        |  3 ++
> >  fetch-pack.h        |  2 +
> >  transport-helper.c  | 11 +++++-
> >  transport.c         | 28 +++++++++++++-
> >  transport.h         | 11 ++++++
> >  8 files changed, 163 insertions(+), 3 deletions(-)
> >  create mode 100644 fetch-object-info.c
> >  create mode 100644 fetch-object-info.h
> >
> > diff --git a/Makefile b/Makefile
> > index 3fa4bf0d06..70e9ec0464 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1020,6 +1020,7 @@ LIB_OBJS +=3D ewah/ewah_rlw.o
> >  LIB_OBJS +=3D exec-cmd.o
> >  LIB_OBJS +=3D fetch-negotiator.o
> >  LIB_OBJS +=3D fetch-pack.o
> > +LIB_OBJS +=3D fetch-object-info.o
> >  LIB_OBJS +=3D fmt-merge-msg.o
> >  LIB_OBJS +=3D fsck.o
> >  LIB_OBJS +=3D fsmonitor.o
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
> > +       struct strbuf req_buf =3D STRBUF_INIT;
> > +
> > +       write_command_and_capabilities(&req_buf, "object-info", args->s=
erver_options);
> > +
> > +       if (unsorted_string_list_has_string(args->object_info_options, =
"size"))
> > +               packet_buf_write(&req_buf, "size");
> > +
> > +       if (args->oids) {
> > +               for (size_t i =3D 0; i < args->oids->nr; i++)
> > +                       packet_buf_write(&req_buf, "oid %s", oid_to_hex=
(&args->oids->oid[i]));
> > +       }
> > +
> > +       packet_buf_flush(&req_buf);
> > +       if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> > +               die_errno(_("unable to write request to remote"));
> > +
> > +       strbuf_release(&req_buf);
> > +}
> > +
> > +/**
> > + * fetch_object_info sends git-cat-file object-info command into the r=
equest buf
> > + * and read the results from packets.
> > + */
> > +int fetch_object_info(const enum protocol_version version, struct obje=
ct_info_args *args,
> > +                     struct packet_reader *reader, struct object_info =
*object_info_data,
> > +                     const int stateless_rpc, const int fd_out)
> > +{
> > +       int size_index =3D -1;
> > +
> > +       switch (version) {
> > +       case protocol_v2:
> > +               if (!server_supports_v2("object-info"))
> > +                       die(_("object-info capability is not enabled on=
 the server"));
> > +               send_object_info_request(fd_out, args);
> > +               break;
> > +       case protocol_v1:
> > +       case protocol_v0:
> > +               die(_("wrong protocol version. expected v2"));
>
> s/wrong/unsupported
>

Thank you. Fixing it in v9.

> > +       case protocol_unknown_version:
> > +               BUG("unknown protocol version");
> > +       }
> > +
> > +       for (size_t i =3D 0; i < args->object_info_options->nr; i++) {
> > +               if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL)=
 {
> > +                       check_stateless_delimiter(stateless_rpc, reader=
, "stateless delimiter expected");
> > +                       return -1;
> > +               }
> > +               if (unsorted_string_list_has_string(args->object_info_o=
ptions, reader->line)) {
> > +                       if (!strcmp(reader->line, "size")) {
> > +                               size_index =3D i;
> > +                               for (size_t j =3D 0; j < args->oids->nr=
; j++)
> > +                                       object_info_data[j].sizep =3D x=
calloc(1, sizeof(long));
> > +                       }
> > +                       continue;
> > +               }
> > +               return -1;
> > +       }
>
> I think we can flatten this logic a bit more here to make it more intuiti=
ve.
>
> if (!unsorted_string_list_has_string(args->object_info_options, reader->l=
ine))
>         return -1;
> if (!strcmp(reader->line, "size")) {
>         size_index =3D i;
>         for (size_t j =3D 0; j < args->oids->nr; j++)
>                 object_info_data[j].sizep =3D xcalloc(1, sizeof(long));
> }

Thank you. Revising it in v9.
