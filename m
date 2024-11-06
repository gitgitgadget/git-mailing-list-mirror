Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8420969B
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922646; cv=none; b=JEVSn47jY34GrRzgP+8ERfEgCaZ0hwh5HT5+h/mdYJXICrirbq+TbSaaE+6qM4WlJBVBuqGq9jB3aqMycJ4dB05KwwB6fZlBlEjqhBAwbt+h0nIV8vqAh8pWH1ET3/SSRdav8AYpxZH2ysHVSKQlnLiw3BPTTc8BBB+qvg1Xnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922646; c=relaxed/simple;
	bh=OcAPsbm+bmveKy5GtS57WvRVkUaJHlI+h0E7VzeNOnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sz8TIOTJyIIq/ZY3ZdXpomWQrTODVqBjxUhjDMBbsyUcPE9yzK91UT8d9umBMhY44+r/EI1WyoZ/nzzb4NVdiNCXLMQ5uduGmbx6JZSpWZUdgzDjh/ula8TJztlA+NBVe6bQzaJNsoIfThg8SB6PR6XcHhwdeTxTPWhfR2rPXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7XBaJgS; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7XBaJgS"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e35bf59cf6so13129637b3.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 11:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730922644; x=1731527444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmlVu9ulaVjxiBGr8DlFJuELJLjdKrJ55AT1qNnv5TA=;
        b=m7XBaJgScguIuw2cOTT87eW73pLIXo4rbhGbrglVDJ6qZH9dv0zMCReKGKxiYdZHG2
         FlalE8UIt+/Of2O9GVO233UF1swxfBElWaF64skCoz452wjWKb/pMEQTbjNIalmNwD5z
         kttQPTryZ4jOZ6fyZ9/9OCkiJ9LvZxVEwCCR+R2q/+AS4DAHmPY05JqOQpIgh9it5xGf
         hZg8sF7I+xq/IMCaugEs9STPAhuxkHp8S1mKWEirsi0m/NB2rGmWD6og0J790p8aL+Mq
         U+gkvIqmddGXTEeufUAO+x56QpunaqdK/NeIbnbgq6j/NPC8ofPd0XGH/PfO3MIgigMf
         ja6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730922644; x=1731527444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmlVu9ulaVjxiBGr8DlFJuELJLjdKrJ55AT1qNnv5TA=;
        b=QKsXePTZ6XfyI96QHJhcy8R/ykpRGq0pEe35CXB/FCtVzjixWmuDNcNp4wHTttR9nL
         UDMHOgS5wsJ4e39cXVgKXh2BI7Q5Ed9PxaAFintCXiavgoUgxm/acYlmcC2zQZ6Ms6CC
         8VwpbFsHSoexE+jw69BkZva2zNDklsGf5FeO8QiF7rRjPCic8pKWXBj5EzGA+ZEiqz5c
         cVwlDkZn3yQUtEichSxmLAT5RvG3e/jokcNGJtDlHPtQAUi3ksblwhWEfJF6WrQ/fjpJ
         8sPg6asNsJKhOsxRC+ked1rp+Lo3lFPA5U9w5Ls+BbdOdu9NhrDvGP0ks1UM+ICzPrkF
         09Xg==
X-Gm-Message-State: AOJu0YyDw02e/mDHfdx5Oi8V5ne+3B91wNyQ53GAmo415je7vQViqWP1
	z2yZtF+jewtN+XFqes43ue97wDR3O3bEgxqmS8bIzDyDeRGOC1MnhXeuLPU2UXZcMLwAMnaTa3s
	jZN+ENdtHNr+mFwUHXC5U/qEFRqM=
X-Google-Smtp-Source: AGHT+IHzTjYtDW/azB9Kf2RscGi/hge2H6UAjr7pAYDdRHitQ9JA1y063JCvu/m8Zk4DNKC+0YwwB257/HQcna8B49g=
X-Received: by 2002:a05:690c:6309:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6eacc04ca30mr4814577b3.15.1730922643819; Wed, 06 Nov 2024
 11:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com> <20241028203457.19715-2-eric.peijian@gmail.com>
 <CAP8UFD0Yk1Twv9DMOYwO4R+7P0YHj1CgK8xN=2YdE8sdi4ukow@mail.gmail.com>
In-Reply-To: <CAP8UFD0Yk1Twv9DMOYwO4R+7P0YHj1CgK8xN=2YdE8sdi4ukow@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 6 Nov 2024 14:50:33 -0500
Message-ID: <CAN2LT1COKBNukbMZz+AHJu-Fyx+SfrW5fo3=sFVuw-LSZwnyMw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] fetch-pack: refactor packet writing
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 12:44=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Oct 28, 2024 at 9:35=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> =
wrote:
>
> >  connect.c    | 34 ++++++++++++++++++++++++++++++++++
> >  connect.h    |  4 ++++
> >  fetch-pack.c | 36 ++----------------------------------
> >  3 files changed, 40 insertions(+), 34 deletions(-)
> >
> > diff --git a/connect.c b/connect.c
> > index 58f53d8dcb..bb4e4eec44 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -688,6 +688,40 @@ int server_supports(const char *feature)
> >         return !!server_feature_value(feature, NULL);
> >  }
> >
> > +void write_command_and_capabilities(struct strbuf *req_buf, const char=
 *command,
> > +                                                                      =
 const struct string_list *server_options)
>
> When I apply your patches this line doesn't seem well indented.
>

Thank you.  I will make sure my IDE respects
the .editorconfig and revise them in v6.

> > +{
> > +       const char *hash_name;
> > +       int advertise_sid;
> > +
> > +       git_config_get_bool("transfer.advertisesid", &advertise_sid);
>
> It looks like moving the function to connect.c required adding the
> above line into it. There are a few other small changes, including
> probably spurious indentation changes, in the moved function which
> make it a bit more difficult than necessary to check that the moved
> code is the same as the original one.
>
> This makes me wonder if it was actually a good idea to move the
> function, or if moving the function should have been done in a
> separate step than the step making the small changes. Perhaps patch
> 5/6 "cat-file: add declaration of variable i inside its for loop"
> could have been moved before this patch and could have included some
> of the small changes related to the i variable that are made in this
> patch.
>
> It might have been nice to mention the changes in the commit message anyw=
ay.
>

Thank you. In v6, I will move small changes commit "cat-file: add
declaration of variable i inside its for loop" to the very first
commit, where I will include small changes related to the i variable
that are made in this patch.

About the extra charges related to `advertise_sid`. I did a bit of
analysis, please feel free to correct me.
In the original fetch-pack.c code, there are only two places that
write `advertise_sid` :
1. line 1221 (function do_fetch_pack):
        if (!server_supports("session-id"))
                advertise_sid =3D 0;
2. line 1895 (function fetch_pack_config)
        git_config_get_bool("transfer.advertisesid", &advertise_sid);

In 1, do_fetch_pack() is called when protocol is NOT v2. While
write_fetch_command_and_capabilities() or the new
write_command_and_capabilities() is only used in protocol v2, I think
it is safe so it is safe to ignore 1, and only consider 2.

In 2, git_config_get_bool is from config.h and it is an out-of-box
dependency of connect.c, so I just directly use it.


> > +       ensure_server_supports_v2(command);
> > +       packet_buf_write(req_buf, "command=3D%s", command);
> > +       if (server_supports_v2("agent"))
> > +               packet_buf_write(req_buf, "agent=3D%s", git_user_agent_=
sanitized());
> > +       if (advertise_sid && server_supports_v2("session-id"))
> > +               packet_buf_write(req_buf, "session-id=3D%s", trace2_ses=
sion_id());
> > +       if (server_options && server_options->nr) {
> > +               ensure_server_supports_v2("server-option");
> > +               for (int i =3D 0; i < server_options->nr; i++)
> > +                       packet_buf_write(req_buf, "server-option=3D%s",
> > +                                        server_options->items[i].strin=
g);
> > +       }
> > +
> > +       if (server_feature_v2("object-format", &hash_name)) {
> > +               const int hash_algo =3D hash_algo_by_name(hash_name);
> > +               if (hash_algo_by_ptr(the_hash_algo) !=3D hash_algo)
> > +                       die(_("mismatched algorithms: client %s; server=
 %s"),
> > +                               the_hash_algo->name, hash_name);
> > +               packet_buf_write(req_buf, "object-format=3D%s", the_has=
h_algo->name);
> > +       } else if (hash_algo_by_ptr(the_hash_algo) !=3D GIT_HASH_SHA1) =
{
> > +               die(_("the server does not support algorithm '%s'"),
> > +                       the_hash_algo->name);
> > +       }
> > +       packet_buf_delim(req_buf);
> > +}
> > +
> >  enum protocol {
> >         PROTO_LOCAL =3D 1,
> >         PROTO_FILE,
> > diff --git a/connect.h b/connect.h
> > index 1645126c17..2ed009066e 100644
> > --- a/connect.h
> > +++ b/connect.h
> > @@ -1,6 +1,7 @@
> >  #ifndef CONNECT_H
> >  #define CONNECT_H
> >
> > +#include "string-list.h"
> >  #include "protocol.h"
> >
> >  #define CONNECT_VERBOSE       (1u << 0)
> > @@ -30,4 +31,7 @@ void check_stateless_delimiter(int stateless_rpc,
> >                                struct packet_reader *reader,
> >                                const char *error);
> >
> > +void write_command_and_capabilities(struct strbuf *req_buf, const char=
 *command,
> > +                                                                      =
 const struct string_list *server_options);
>
> When I apply your patches the above line doesn't seem well indented eithe=
r.
>
> You might want to make sure that your editor uses 8 spaces for each
> tab, see Documentation/CodingGuidelines, or just that your editor
> properly follows our .editorconfig file.
>
> It looks like other patches in the series, like patch 4/6, have
> similar issues. Otherwise the other patches in the series look good to
> me.
>
> Thanks.

Thank you. I will make sure my IDE respects
the .editorconfig and revise them in v6.
