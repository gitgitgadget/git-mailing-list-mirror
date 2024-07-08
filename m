Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1B76035
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451879; cv=none; b=oQnIXWRPtBizApxo0tZnUh0Qemiws+rxeHmAWYcR1rbjQ7o0d1Q1TT8AvbtawhAO8vClwo1iGDIUT4EejMggIpwhD5oGxYYaMNDBecmg7Lm8iXTxWzyXCJ/kdljgk9iDYsZtPQlzYfkg9jHUkQs4eEeOs28Li2kM9wcHEA8ylAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451879; c=relaxed/simple;
	bh=kGBSrlzNsnxTiFa6P0RD17rrrL0lO2XqJymFa8j+i4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMCc2WUGuYiS5F8V3oEKyGIiLBqaAjTArKW+ImnXjagroZW+8Gu1nKv9nhgR5hcimVYNTARm3tuYwInr8eK5Yy3ChFFP0Y0pj7plaNVfiFquhst9pAOx2Y8B8as4GrKY4UqPADUW0AoC26D4LR98dWsXgMfYu3hJPV453zVDteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6v2tRBj; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6v2tRBj"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03618fc78bso3958064276.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720451877; x=1721056677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssJQ3zvzkjSGUy9wSKhR1BQy+ZWKijiISZamYcsi3FQ=;
        b=e6v2tRBjOUTKPXaC/tWCdB1gXS5Rw018cQV+B7BQyQXlvV2i77XYlnbR1rQngGlJiC
         8MUK9hz1UCP0M3aW63NcLvwVBVZzCZW9ZFLPApvLj5deFw8QzoRON9fKQH2/KqIxjtcA
         WkGWm0ngb2a1v7MwCyEtU1ISQ6mjAdc5HgWurpEfIF54ATP85YXGEQDPfUjXZv23Ny9N
         Q2nZXQc8QtyJkpM6baAw/aLjHwk1GsXx+/170Sb18mQyB1RQr2f7zwwKLFs4Ai0bNAp1
         wt9Y5gT+0qse3CFn6SC0AC6kEGyB17N7u83/yfSwVKhqnjl2IaBLDdsdgt8QZUP4jyla
         1sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451877; x=1721056677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssJQ3zvzkjSGUy9wSKhR1BQy+ZWKijiISZamYcsi3FQ=;
        b=W7oSUFMBYR0793dWao3J0PuydyxngkwWXEpG3eu3e0AyMxVsXiRcfiDqK3/DrXv65q
         rjo4aKjDAFViYQ+fu7LyCsRutYu8d2Z80RVLtjiclIXylzMkaMr4mtdXbZ94X0/edOOF
         0dzQl5PpD6d8b5YppyT8YpQ4uO11HOPx9HlEHFUGrA/6hdDaLO3q/3XZre6D/66fiBzR
         WANQkjKbU8t1pj70rvMh1lW6Jb8NYKckLuetaNnKPgeQ9ko08Aw9yA4oV3a/MJrr1rbW
         O7CdCpJp+2Ce/coLhfBWE4iIBE+7BTgyyFFXTWo5hYsN+sZQhaEYo9T5QQYeI9yruSzA
         bNtg==
X-Gm-Message-State: AOJu0Yz+GA3M0sGec6o8GMegI3UnreILIuoiIwHcgBAtHH9RFR5kkHLG
	BQi48DUX2FD2Gk4W+NWavMdWe5diuIYPQal6pWNCJAFldImxcukOu7bLLRFnymY5Y2z0N85X/Y0
	K5MNlbKc9U7ovwhIAI1DOu4wsSfk=
X-Google-Smtp-Source: AGHT+IF6BaLjjmt/ozXzcGLTe/5cUHfyjdK6+HZM+un5HlydTZUMNPFxgmiyQmkNJ4a383gk4kcWue6tleIC1zf4lxw=
X-Received: by 2002:a25:ac8d:0:b0:e02:bd5c:bfa9 with SMTP id
 3f1490d57ef6-e041b059553mr53053276.19.1720451876927; Mon, 08 Jul 2024
 08:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-2-eric.peijian@gmail.com> <CAOLa=ZSY1y4wz6M9mOLvTCPoeCmceD-HKqT5tomF+BzbL5yp4Q@mail.gmail.com>
In-Reply-To: <CAOLa=ZSY1y4wz6M9mOLvTCPoeCmceD-HKqT5tomF+BzbL5yp4Q@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 8 Jul 2024 11:17:46 -0400
Message-ID: <CAN2LT1Ctwdij9-DujKeuzPX71mzEoMVbdrTkJ8bpRnX9NAZy9Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] fetch-pack: refactor packet writing
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, 
	John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:00=E2=80=AFPM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > From: Calvin Wan <calvinwan@google.com>
> >
> > A subsequent patch need to write capabilities for another command.
>
> s/need/needs

Thank you. Fixed in v2.

> > Refactor write_fetch_command_and_capabilities() to be used by both
> > fetch and future command.
> >
>
> Nit: mostly from my lack of understanding, but until I read the code, I
> couldn't understand what 'command' meant in this para. Maybe some
> preface would be nice here.
>

Thank you. I will add this in v2 commit message.

    Here "command" means the "operations" supported by Git=E2=80=99s wire p=
rotocol
    https://git-scm.com/docs/protocol-v2. An example would be a
    git's subcommand, such as git-fetch(1); or an operation supported by
    the server side such as "object-info" implemented at "a2ba162cda
    (object-info: support for retrieving object info, 2021-04-20)".

> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  fetch-pack.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index eba9e420ea..fc9fb66cd8 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1313,13 +1313,13 @@ static int add_haves(struct fetch_negotiator *n=
egotiator,
> >       return haves_added;
> >  }
> >
> > -static void write_fetch_command_and_capabilities(struct strbuf *req_bu=
f,
> > -                                              const struct string_list=
 *server_options)
> > +static void write_command_and_capabilities(struct strbuf *req_buf,
> > +                                              const struct string_list=
 *server_options, const char* command)
> >  {
> >       const char *hash_name;
> >
> > -     ensure_server_supports_v2("fetch");
> > -     packet_buf_write(req_buf, "command=3Dfetch");
> > +     ensure_server_supports_v2(command);
> > +     packet_buf_write(req_buf, "command=3D%s", command);
> >       if (server_supports_v2("agent"))
> >               packet_buf_write(req_buf, "agent=3D%s", git_user_agent_sa=
nitized());
> >       if (advertise_sid && server_supports_v2("session-id"))
> > @@ -1355,7 +1355,7 @@ static int send_fetch_request(struct fetch_negoti=
ator *negotiator, int fd_out,
> >       int done_sent =3D 0;
> >       struct strbuf req_buf =3D STRBUF_INIT;
> >
> > -     write_fetch_command_and_capabilities(&req_buf, args->server_optio=
ns);
> > +     write_command_and_capabilities(&req_buf, args->server_options, "f=
etch");
> >
> >       if (args->use_thin_pack)
> >               packet_buf_write(&req_buf, "thin-pack");
> > @@ -2163,7 +2163,7 @@ void negotiate_using_fetch(const struct oid_array=
 *negotiation_tips,
> >                                          the_repository, "%d",
> >                                          negotiation_round);
> >               strbuf_reset(&req_buf);
> > -             write_fetch_command_and_capabilities(&req_buf, server_opt=
ions);
> > +             write_command_and_capabilities(&req_buf, server_options, =
"fetch");
> >
> >               packet_buf_write(&req_buf, "wait-for-done");
> >
> > --
> > 2.45.2
>
> Right, this commit in itself looks good. But I was curious why we need
> this, so I did a sneak peak into the following commits.
>
> To summarize, we want to call:
>    `write_command_and_capabilities(..., "object-info");`
> in the upcoming patches to get the object-info details from the server.
> But isn't this function too specific to the "fetch" command to be
> generalized to be for "object-info" too?
>
> Wouldn't it make sense to add a custom function for 'object-info' in
> 'connect.c'? Like how we currently have `get_remote_bundle_uri()` for
> 'bundle-uri' and `get_remote_refs` for 'ls-refs'?

Thank you. I am reading through the old comments left by Taylor
at https://lore.kernel.org/git/YkOPyc9tUfe2Tozx@nand.local/

  " Makes obvious sense, and this was something that jumped out to me when =
I
  looked at the first and second versions of this patch. I'm glad that
  this is getting factored out."


It seems refactoring this into a more general function is on purpose.
It is encouraged to use this general function to request capability
rather than adding a custom function.
Taylor=E2=80=99s comment was 2 years ago, but I think refactoring this into=
 a
more general function to
enforce DRY still makes sense.
