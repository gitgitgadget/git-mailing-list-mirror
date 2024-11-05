Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D161E6DCD
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828685; cv=none; b=cNwtmbaDBRYOOTnfibX2SZHAUtnjOWBBfuhvMmgolsMEKoYxYpEylY9iBYmf4ZFlIOnDro+T3t+E12pjEFTbugRsK9dgsrd/iwgXTfLePPAsM1YBRkjwAsaHkGybeHkgUa7b9RC90cy7n7Ni0IQmu6B8Ie6EIRCZX8XW9bs3t2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828685; c=relaxed/simple;
	bh=po8c/8RPD75LTOPFC8uMXOp9UJHeempePD4/j5Rpwkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5J9bwaOlH2pN4J1XM424BemeUunRifMvtINyR0wHRZIINmuvE1f+RkfcfkSOKSg/x+H/rfSqJ50XwORo1gjCx0bk0HIbStbjxt9SXeri8+UasVRjsI1yJoDVzN1srJ8eITLWgU7CDuU9qRD18eBCwlx2V43oPNGHHbSte6HOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzcipvUU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzcipvUU"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e690479cso6048350e87.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730828681; x=1731433481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRNzVMSYp1uGCdS4xgKNhr6TCMC2aGYxKtfV3Dw/mlM=;
        b=TzcipvUUZcWowvCtWdy2X1vFtzfroKhIN58o3kLHk0Ltpak9uN9zYldzhoMoCqJRh8
         Zz9HnHIYik9JQFhOD19Zcx/oF98TJqzmeJVDmiEmPitxFwqe4a+4n7BT8Bg66UhaA9Ix
         NPV9VjN+FR0wZ+qJ9RN3xUvnQ4IBl9ouPAcAyAsA9loxTkKR2vyFXla7X//GJWIjewrg
         y4mhKvGhQZCOuX6901uWlTBspk/etaTRknl/E7/j0O9p5M3E4XWgXGmg59xgCA/zVoFx
         fLl4sniAtOHacn0Z3l7/QRsiVoO/iVK6KiE7zOr3yg1x7T18xGTttV5JALpHnSEFBFyz
         j4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828681; x=1731433481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRNzVMSYp1uGCdS4xgKNhr6TCMC2aGYxKtfV3Dw/mlM=;
        b=tBEfA3hTG4OMCOTYcsHLRxOeS9+ZmMeYc8grUfjXbk+8u3iVkd5FbDH8IY4OZAhDLX
         9sEqQz3RGhiri5kbHpe/6+JgCNIUXgYd8vbzVYCzJelVl3G/ekt19eBhPCZFx1e9Hdzz
         NjC4jWi7q0KWy/U9shD8+pZX281NTK5G0AFenvNK/+ju9Xmk63IHgzldryRx7u51AUTR
         CCbCi8IE5miqOprvKqb+H0BohgbQhp3diDhsViz2qo1vIkU88DCP2lyvB43H0ktyOpf4
         p7baYav3AsmlDy9zuCpNF1J1awOzmUuRVkkXUmrvb49roRrwiDqN529BrJ4lar4G+mNh
         zl/w==
X-Gm-Message-State: AOJu0YyXRzpZoalDV2AgOO/QgVAkxFA6NE+vOjXCvwVVZoDkdiqgvbJw
	zzoyMgF2cMgK8ei5RoycB77N0d4Fv0qvfQGdMzHtvBBf5LVLsdFVleUzu+O9WoXEPxlhVItEk4E
	BunzTwYNs0/HqqxaRRjeTfiojgZY=
X-Google-Smtp-Source: AGHT+IFswFiNG77S1CPylDDL0e7QyHavrAtP6YJ7uf00D/iOw/SmlF28Vm1Ht7vricnsi47WYPUoIdRxlt8k09O2ycI=
X-Received: by 2002:a05:6512:31cb:b0:539:e436:f1cd with SMTP id
 2adb3069b0e04-53d65de60eamr8706557e87.16.1730828681184; Tue, 05 Nov 2024
 09:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com> <20241028203457.19715-2-eric.peijian@gmail.com>
In-Reply-To: <20241028203457.19715-2-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 5 Nov 2024 18:44:29 +0100
Message-ID: <CAP8UFD0Yk1Twv9DMOYwO4R+7P0YHj1CgK8xN=2YdE8sdi4ukow@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] fetch-pack: refactor packet writing
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:35=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wr=
ote:

>  connect.c    | 34 ++++++++++++++++++++++++++++++++++
>  connect.h    |  4 ++++
>  fetch-pack.c | 36 ++----------------------------------
>  3 files changed, 40 insertions(+), 34 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 58f53d8dcb..bb4e4eec44 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -688,6 +688,40 @@ int server_supports(const char *feature)
>         return !!server_feature_value(feature, NULL);
>  }
>
> +void write_command_and_capabilities(struct strbuf *req_buf, const char *=
command,
> +                                                                       c=
onst struct string_list *server_options)

When I apply your patches this line doesn't seem well indented.

> +{
> +       const char *hash_name;
> +       int advertise_sid;
> +
> +       git_config_get_bool("transfer.advertisesid", &advertise_sid);

It looks like moving the function to connect.c required adding the
above line into it. There are a few other small changes, including
probably spurious indentation changes, in the moved function which
make it a bit more difficult than necessary to check that the moved
code is the same as the original one.

This makes me wonder if it was actually a good idea to move the
function, or if moving the function should have been done in a
separate step than the step making the small changes. Perhaps patch
5/6 "cat-file: add declaration of variable i inside its for loop"
could have been moved before this patch and could have included some
of the small changes related to the i variable that are made in this
patch.

It might have been nice to mention the changes in the commit message anyway=
.

> +       ensure_server_supports_v2(command);
> +       packet_buf_write(req_buf, "command=3D%s", command);
> +       if (server_supports_v2("agent"))
> +               packet_buf_write(req_buf, "agent=3D%s", git_user_agent_sa=
nitized());
> +       if (advertise_sid && server_supports_v2("session-id"))
> +               packet_buf_write(req_buf, "session-id=3D%s", trace2_sessi=
on_id());
> +       if (server_options && server_options->nr) {
> +               ensure_server_supports_v2("server-option");
> +               for (int i =3D 0; i < server_options->nr; i++)
> +                       packet_buf_write(req_buf, "server-option=3D%s",
> +                                        server_options->items[i].string)=
;
> +       }
> +
> +       if (server_feature_v2("object-format", &hash_name)) {
> +               const int hash_algo =3D hash_algo_by_name(hash_name);
> +               if (hash_algo_by_ptr(the_hash_algo) !=3D hash_algo)
> +                       die(_("mismatched algorithms: client %s; server %=
s"),
> +                               the_hash_algo->name, hash_name);
> +               packet_buf_write(req_buf, "object-format=3D%s", the_hash_=
algo->name);
> +       } else if (hash_algo_by_ptr(the_hash_algo) !=3D GIT_HASH_SHA1) {
> +               die(_("the server does not support algorithm '%s'"),
> +                       the_hash_algo->name);
> +       }
> +       packet_buf_delim(req_buf);
> +}
> +
>  enum protocol {
>         PROTO_LOCAL =3D 1,
>         PROTO_FILE,
> diff --git a/connect.h b/connect.h
> index 1645126c17..2ed009066e 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -1,6 +1,7 @@
>  #ifndef CONNECT_H
>  #define CONNECT_H
>
> +#include "string-list.h"
>  #include "protocol.h"
>
>  #define CONNECT_VERBOSE       (1u << 0)
> @@ -30,4 +31,7 @@ void check_stateless_delimiter(int stateless_rpc,
>                                struct packet_reader *reader,
>                                const char *error);
>
> +void write_command_and_capabilities(struct strbuf *req_buf, const char *=
command,
> +                                                                       c=
onst struct string_list *server_options);

When I apply your patches the above line doesn't seem well indented either.

You might want to make sure that your editor uses 8 spaces for each
tab, see Documentation/CodingGuidelines, or just that your editor
properly follows our .editorconfig file.

It looks like other patches in the series, like patch 4/6, have
similar issues. Otherwise the other patches in the series look good to
me.

Thanks.
