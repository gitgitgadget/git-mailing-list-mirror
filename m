Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736452594A9
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274716; cv=none; b=IWajsSmsBFQAxTdKuRreab+7iwPuzNpHHir26zn2PXl13O3fyRxhatJjXzjZ3OOh8zmK1B4NIrsihJvflo9zXjAxEBojhilh0D6wexYj8Stjfe21zMzQaf+UWzqK/hmS2IuFy9B/UqXuGEsq5I2SvGCGDULMx9YZGQfHdu6SgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274716; c=relaxed/simple;
	bh=82qji59sENFfABvGghQdVX3s4dzGviUeB9w1CtKhD5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJBo8Tn8ghOrZ6RrzHy/jhPnnMn2zLtCDVH2HWLBiMGvnLUbqW14rVs3E1Zm5q1C2G/SUzrrEuXx27+l1hBWtaFNWiMKf/x8/iLW04bBoM+orgNBhBLevsLe2+TRdrKHWKstA7DHPl3tlWvWoC1VHiCjK/AaZDUwuIpGEsNyXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+42wVVt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+42wVVt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d442f9d285so661a12.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736274712; x=1736879512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3J/o8kGviUGU1tpI+xShKt80TYn1lgtsFYA2E4BlxM=;
        b=f+42wVVt7CkR2ziFGt9qgaY/bi3Zy6ywi8291eMUVtJXl6ttGhu8TEsY0UPppxHpub
         ev7B3YJThVGXykeKaMQjp8rFaku4IbeTRSuYq3ObcPxH1NGax8LWprUkEZJDfmMRjfvG
         c8RT7Ukrsr6ziNjLUqE1ejN1afklK8yigXpBWbXBbYYyFmjWj5GBA5B8x+7jqDWXaCz2
         YdbyKTcW15xiC1/u04z9ykXIPTcWV06EhZliEbafixMLz4OS5UdoNsUDgHcoBCykG6d0
         mphj3uJv5uvVRuHB6G5cgmJfs756RQAnGby6+4WPUdZbIP/GJjq+05OAthPCGdS873xo
         dMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736274712; x=1736879512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3J/o8kGviUGU1tpI+xShKt80TYn1lgtsFYA2E4BlxM=;
        b=lWYfn2qc2+T/xdSSXMXJrI/yRN3Q6Kur/jBrdxs5efTGo46U8ExpY3n7fBlCSD9NPw
         C54qWVZ9Nj9YDjOFHVUF4w+iD+a8yKLdSxRQoSehNcbOC1Lz8wGi4c/ZIeIYbTBaoRtn
         vUWhUQjav547B8+WWqZoUAoTNsXQTj7ff0NSFPdUePjmwlzDg8p66+L/qf8mKuyssHM9
         P2R++tMWJ3pg5Gul660S8VwdIoTg6fZfIhcjeiB3qYpi1fjJ5ZosJNr1sZmjo4oMLvq1
         I0kaxfVIkLhS/HT0xeQMr+8Qz9+foNqFcRlWfXivik3KZTHXTPF1nsa0xoyhETakxyjD
         smvQ==
X-Gm-Message-State: AOJu0YypHpJ5u9k5GqKMsbIJr+qef7oE9sXDlvKKoF9o/L3C00AIrSes
	w0jXHTHBXR7ChGN4H7tgbEI8j3zrcHKp+MjXDwm25BjzoeL/nbN8wXzLkdZ93qfObbvbyHCnral
	SyGFa67cLVtGDUxxZsdpYXwDmWvWhuZKwTV/O
X-Gm-Gg: ASbGncv23wZ2FiQITKjg2ilf78ciFy14v0HrrvKlt61QMA9FuwRpLcG1nHZk70P7Nxm
	p06owkMcw9pNVmObACkM3ncpo4sVyr7jt7y7UGlv0vCGPB6X30JktMMJITmfl3UkUbg==
X-Google-Smtp-Source: AGHT+IFf229vE0wj5DMZytshIkxqy5YNCabBQNYFvAtfcl8+eQyxI4hVq3KwvnjIzec/CjZX445d2y9bNsj2P6D3o9E=
X-Received: by 2002:a05:6402:278a:b0:5d9:693e:346 with SMTP id
 4fb4d7f45d1cf-5d9693e096fmr133031a12.4.1736274711503; Tue, 07 Jan 2025
 10:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com> <20241223232523.76236-6-eric.peijian@gmail.com>
In-Reply-To: <20241223232523.76236-6-eric.peijian@gmail.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 7 Jan 2025 10:31:40 -0800
Message-ID: <CAFySSZAqh6J14+r9JLM3LmRmV02ZvPRf5dB3rWVnUZS_5XaHcQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] transport: add client support for object-info
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	karthik.188@gmail.com, toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for picking up this series btw!

On Mon, Dec 23, 2024 at 3:25=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wr=
ote:
>
> From: Calvin Wan <calvinwan@google.com>
>
> Sometimes, it is beneficial to retrieve information about an object
> without downloading it entirely. The server-side logic for this
> functionality was implemented in commit "a2ba162cda (object-info:
> support for retrieving object info, 2021-04-20)."
>
> This commit introduces client functions to interact with the server.
>
> Currently, the client supports requesting a list of object IDs with
> the =E2=80=98size=E2=80=99 feature from a v2 server. If the server does n=
ot advertise
> this feature (i.e., transfer.advertiseobjectinfo is set to false),
> the client will return an error and exit.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> ---
>  Makefile            |  1 +
>  fetch-object-info.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  fetch-object-info.h | 18 +++++++++
>  fetch-pack.c        |  3 ++
>  fetch-pack.h        |  2 +
>  transport-helper.c  | 11 +++++-
>  transport.c         | 28 +++++++++++++-
>  transport.h         | 11 ++++++
>  8 files changed, 163 insertions(+), 3 deletions(-)
>  create mode 100644 fetch-object-info.c
>  create mode 100644 fetch-object-info.h
>
> diff --git a/Makefile b/Makefile
> index 3fa4bf0d06..70e9ec0464 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1020,6 +1020,7 @@ LIB_OBJS +=3D ewah/ewah_rlw.o
>  LIB_OBJS +=3D exec-cmd.o
>  LIB_OBJS +=3D fetch-negotiator.o
>  LIB_OBJS +=3D fetch-pack.o
> +LIB_OBJS +=3D fetch-object-info.o
>  LIB_OBJS +=3D fmt-merge-msg.o
>  LIB_OBJS +=3D fsck.o
>  LIB_OBJS +=3D fsmonitor.o
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> new file mode 100644
> index 0000000000..2aa9f2b70d
> --- /dev/null
> +++ b/fetch-object-info.c
> @@ -0,0 +1,92 @@
> +#include "git-compat-util.h"
> +#include "gettext.h"
> +#include "hex.h"
> +#include "pkt-line.h"
> +#include "connect.h"
> +#include "oid-array.h"
> +#include "object-store-ll.h"
> +#include "fetch-object-info.h"
> +#include "string-list.h"
> +
> +/**
> + * send_object_info_request sends git-cat-file object-info command and i=
ts
> + * arguments into the request buffer.
> + */
> +static void send_object_info_request(const int fd_out, struct object_inf=
o_args *args)
> +{
> +       struct strbuf req_buf =3D STRBUF_INIT;
> +
> +       write_command_and_capabilities(&req_buf, "object-info", args->ser=
ver_options);
> +
> +       if (unsorted_string_list_has_string(args->object_info_options, "s=
ize"))
> +               packet_buf_write(&req_buf, "size");
> +
> +       if (args->oids) {
> +               for (size_t i =3D 0; i < args->oids->nr; i++)
> +                       packet_buf_write(&req_buf, "oid %s", oid_to_hex(&=
args->oids->oid[i]));
> +       }
> +
> +       packet_buf_flush(&req_buf);
> +       if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +               die_errno(_("unable to write request to remote"));
> +
> +       strbuf_release(&req_buf);
> +}
> +
> +/**
> + * fetch_object_info sends git-cat-file object-info command into the req=
uest buf
> + * and read the results from packets.
> + */
> +int fetch_object_info(const enum protocol_version version, struct object=
_info_args *args,
> +                     struct packet_reader *reader, struct object_info *o=
bject_info_data,
> +                     const int stateless_rpc, const int fd_out)
> +{
> +       int size_index =3D -1;
> +
> +       switch (version) {
> +       case protocol_v2:
> +               if (!server_supports_v2("object-info"))
> +                       die(_("object-info capability is not enabled on t=
he server"));
> +               send_object_info_request(fd_out, args);
> +               break;
> +       case protocol_v1:
> +       case protocol_v0:
> +               die(_("wrong protocol version. expected v2"));

s/wrong/unsupported

> +       case protocol_unknown_version:
> +               BUG("unknown protocol version");
> +       }
> +
> +       for (size_t i =3D 0; i < args->object_info_options->nr; i++) {
> +               if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL) {
> +                       check_stateless_delimiter(stateless_rpc, reader, =
"stateless delimiter expected");
> +                       return -1;
> +               }
> +               if (unsorted_string_list_has_string(args->object_info_opt=
ions, reader->line)) {
> +                       if (!strcmp(reader->line, "size")) {
> +                               size_index =3D i;
> +                               for (size_t j =3D 0; j < args->oids->nr; =
j++)
> +                                       object_info_data[j].sizep =3D xca=
lloc(1, sizeof(long));
> +                       }
> +                       continue;
> +               }
> +               return -1;
> +       }

I think we can flatten this logic a bit more here to make it more intuitive=
.

if (!unsorted_string_list_has_string(args->object_info_options, reader->lin=
e))
        return -1;
if (!strcmp(reader->line, "size")) {
        size_index =3D i;
        for (size_t j =3D 0; j < args->oids->nr; j++)
                object_info_data[j].sizep =3D xcalloc(1, sizeof(long));
}
