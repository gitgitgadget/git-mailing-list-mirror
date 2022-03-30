Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C36C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351729AbiC3WtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351728AbiC3WtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:49:23 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD0546A2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:47:35 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i7so9468975oie.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qFG4cG69EQwstNOFCEwTFFZzVCkVESVXO5ydxZNNzvI=;
        b=BqFd6Gty/37OC8Dd/fGQ+xSe6hnvR0cRYeufHda4pxcPuvmtRsQBCBjY97YuEfTwgU
         CM3S2lB4ijRc7wetV1LnLJCAAC6Flp66ZH1U2MMBq9WyijN2KSZYyFXzhZvf3UsXFd34
         dK5v2RbB5+0h4ijIGe/+ewGLqup/E9vvRycvj7ztdp7f46hpSn1Dl10hLRHNDgKxs9qo
         SY6fuRYrqrJZStX8S4Mw1xPjzB1ON+djuESbEFJIMPshnCkXFrynuKPTIVAjqHS2S8oT
         /BfqO8ipkx1SwhL+1HgpTMDZ1uRB/zm/K6m3oXbthKvJdIEnxH1zXPBuime9K0mV8aIF
         uYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qFG4cG69EQwstNOFCEwTFFZzVCkVESVXO5ydxZNNzvI=;
        b=irGvjitQl5ed0GEcOwT9qgPCmObY7cGij13GSg47de4rLaVHXWY8s+cnMBaHUCCLMo
         KM0R4UEIQyjG9AdCJTJr+FVzCu3DAaj7MrTQy3UbrC5LJ1qcUr0iqpd63+t6fnVthe2O
         KH/Aiej4TApOFEdfvqw+ELoSgCNa1LT4Xkbv1c5I89XkFyR33govv7IC13rQJmlcdiFG
         FZwy86HoKHk1eSkiFhCWvCRXo8jPlf9tgIZP62lfcraAu80Ksowa2gPg2bSVEnzxqC/R
         Mk3kLeeCwhR78NRaVhFzMCyMiZdz/B0i7nM8rw1XFyCrNWnQpMzVdgSN3/MAY74iCGGR
         n6+g==
X-Gm-Message-State: AOAM532cj/Ra7xcAP1uSiCFvY54XlybPeBPmfYk+Yo1/POoWVS2C/22S
        Q9oPPaLrwMXovOe2KJp/m74FGv1PNgCQXPmU+uqoOw==
X-Google-Smtp-Source: ABdhPJxuvjPtmcO359t4qYLdnm3P+ZimKC+QS76kiAyjoAHFRzb9gq+11eweNnq+dI0u6+ghK8VLDmzba2RPqtQIM1c=
X-Received: by 2002:a05:6808:1386:b0:2d9:a01a:488a with SMTP id
 c6-20020a056808138600b002d9a01a488amr1301251oiw.213.1648680454515; Wed, 30
 Mar 2022 15:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-4-calvinwan@google.com> <YkOT/TCKPK3LT9gh@nand.local>
In-Reply-To: <YkOT/TCKPK3LT9gh@nand.local>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Mar 2022 15:47:23 -0700
Message-ID: <CAFySSZDD4VsQckvuubjZbVwisEbHbCpZK2sA_FQQj_voVF94Pw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the code hygiene tips, Taylor! All of these sounds like
good ideas and will follow through

On Tue, Mar 29, 2022 at 4:19 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Calvin,
>
> Junio took a deeper look below, but here are a few small code-hygiene
> issues that I noticed while taking a quicker look through this patch.
>
> On Mon, Mar 28, 2022 at 07:11:12PM +0000, Calvin Wan wrote:
> > Sometimes it is useful to get information about an object without
> > having to download it completely. The server logic has already been
> > implemented as =E2=80=9Ca2ba162cda (object-info: support for retrieving=
 object
> > info, 2021-04-20)=E2=80=9D. This patch implements the client option for
> > it. Currently, only 'size' is supported, however future patches can
> > implement additional options.
> >
> > Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows=
 the client to
>
> The single-quotes here look like smart quotes. I don't think we forbid
> these explicitly within commit messages, but using the standard '
> (ASCII 0x27) character is more common.
>
> > make an object-info command request to a server that supports protocol
> > v2. If the server is v2, but does not allow for the object-info
> > command request, fetch the objects as if it were a standard fetch
> > (however without changing any refs). Therefore, hook `fetch
> > object-info` into transport_fetch_refs() to easily fallback if needed.
> >
> > A previous patch added the `transfer.advertiseObjectInfo` config
> > option, of which this patch utilizes to test the fallback.
> >
> > ---
> >  Documentation/fetch-options.txt |   5 ++
> >  Documentation/git-fetch.txt     |   1 +
> >  builtin/fetch.c                 |  36 ++++++++-
> >  fetch-pack.c                    |  42 +++++++++-
> >  fetch-pack.h                    |   9 +++
> >  t/t5583-fetch-object-info.sh    | 138 ++++++++++++++++++++++++++++++++
> >  transport-helper.c              |   8 +-
> >  transport-internal.h            |   1 +
> >  transport.c                     |  75 ++++++++++++++++-
> >  transport.h                     |   9 +++
> >  10 files changed, 315 insertions(+), 9 deletions(-)
> >  create mode 100755 t/t5583-fetch-object-info.sh
> >
> > diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
> > index f903683189..f1ca95c32d 100644
> > --- a/Documentation/fetch-options.txt
> > +++ b/Documentation/fetch-options.txt
> > @@ -299,3 +299,8 @@ endif::git-pull[]
> >  -6::
> >  --ipv6::
> >       Use IPv6 addresses only, ignoring IPv4 addresses.
> > +
> > +--object-info=3D[<arguments>]::
> > +     Fetches only the relevant information passed in arguments from a
> > +     specific remote and set of object ids. Object 'size' is currently
> > +     the only supported argument.
> > diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> > index 550c16ca61..a13d2ba7ad 100644
> > --- a/Documentation/git-fetch.txt
> > +++ b/Documentation/git-fetch.txt
> > @@ -13,6 +13,7 @@ SYNOPSIS
> >  'git fetch' [<options>] <group>
> >  'git fetch' --multiple [<options>] [(<repository> | <group>)...]
> >  'git fetch' --all [<options>]
> > +'git fetch' --object-info=3D[<arguments>] <remote> [<object-ids>]
> >
> >
> >  DESCRIPTION
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 4d12c2fd4d..0b21bebfca 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -29,6 +29,9 @@
> >  #include "commit-graph.h"
> >  #include "shallow.h"
> >  #include "worktree.h"
> > +#include "protocol.h"
> > +#include "pkt-line.h"
> > +#include "connect.h"
> >
> >  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
> >
> > @@ -37,6 +40,7 @@ static const char * const builtin_fetch_usage[] =3D {
> >       N_("git fetch [<options>] <group>"),
> >       N_("git fetch --multiple [<options>] [(<repository> | <group>)...=
]"),
> >       N_("git fetch --all [<options>]"),
> > +     N_("git fetch --object-info=3D[<arguments>] <remote> [<object-ids=
>]"),
> >       NULL
> >  };
> >
> > @@ -86,6 +90,7 @@ static struct string_list negotiation_tip =3D STRING_=
LIST_INIT_NODUP;
> >  static int fetch_write_commit_graph =3D -1;
> >  static int stdin_refspecs =3D 0;
> >  static int negotiate_only;
> > +static struct string_list object_info_options =3D STRING_LIST_INIT_NOD=
UP;
> >
> >  static int git_fetch_config(const char *k, const char *v, void *cb)
> >  {
> > @@ -221,6 +226,8 @@ static struct option builtin_fetch_options[] =3D {
> >                N_("write the commit-graph after fetching")),
> >       OPT_BOOL(0, "stdin", &stdin_refspecs,
> >                N_("accept refspecs from stdin")),
> > +     OPT_STRING_LIST(0, "object-info", &object_info_options, N_("optio=
n"),
> > +              N_("command request arguments")),
> >       OPT_END()
> >  };
> >
> > @@ -2087,6 +2094,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
> >       struct remote *remote =3D NULL;
> >       int result =3D 0;
> >       int prune_tags_ok =3D 1;
> > +     struct oid_array object_info_oids =3D OID_ARRAY_INIT;
> >
> >       packet_trace_identity("fetch");
> >
> > @@ -2168,7 +2176,19 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
> >       if (dry_run)
> >               write_fetch_head =3D 0;
> >
> > -     if (all) {
> > +     if (object_info_options.nr > 0) {
>
> Small nit; since object_info_options.nr should never be negative, we
> should instead write "if (object_info_options)".
>
> > +             if (argc =3D=3D 0 || argc =3D=3D 1) {
> > +                     die(_("must supply remote and object ids when usi=
ng --object-info"));
> > +             } else {
> > +                     struct object_id oid;
> > +                     remote =3D remote_get(argv[0]);
> > +                     for (i =3D 1; i < argc; i++) {
> > +                             if (get_oid(argv[i], &oid))
> > +                                     return error(_("malformed object =
id '%s'"), argv[i]);
> > +                             oid_array_append(&object_info_oids, &oid)=
;
> > +                     }
> > +             }
> > +     } else if (all) {
> >               if (argc =3D=3D 1)
> >                       die(_("fetch --all does not take a repository arg=
ument"));
> >               else if (argc > 1)
> > @@ -2199,7 +2219,19 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
> >               }
> >       }
> >
> > -     if (negotiate_only) {
> > +     if (object_info_options.nr > 0) {
> > +             if (!remote)
> > +                     die(_("must supply remote when using --object-inf=
o"));
> > +             gtransport =3D prepare_transport(remote, 1);
> > +             if (gtransport->smart_options) {
> > +                     gtransport->smart_options->object_info =3D 1;
> > +                     gtransport->smart_options->object_info_oids =3D &=
object_info_oids;
> > +                     gtransport->smart_options->object_info_options =
=3D &object_info_options;
> > +             }
> > +             if (server_options.nr)
> > +                     gtransport->server_options =3D &server_options;
> > +             result =3D transport_fetch_refs(gtransport, NULL);
> > +     } else if (negotiate_only) {
> >               struct oidset acked_commits =3D OIDSET_INIT;
> >               struct oidset_iter iter;
> >               const struct object_id *oid;
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index b709a61baf..36e3d1c5d0 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1269,6 +1269,27 @@ static void write_command_and_capabilities(struc=
t strbuf *req_buf,
> >       packet_buf_delim(req_buf);
> >  }
> >
> > +void send_object_info_request(int fd_out, struct object_info_args *arg=
s)
> > +{
> > +     struct strbuf req_buf =3D STRBUF_INIT;
> > +     int i;
>
> I don't think this would ever be practically exploit-able, since we'd
> run past the argument limit long before we hit INT_MAX, but this should
> be a size_t instead of an int to match the type of args->oid->nr.
>
> > +
> > +     write_command_and_capabilities(&req_buf, args->server_options, "o=
bject-info");
> > +
> > +     if (string_list_has_string(args->object_info_options, "size"))
> > +             packet_buf_write(&req_buf, "size");
> > +
> > +     for (i =3D 0; i < args->oids->nr; i++) {
> > +             packet_buf_write(&req_buf, "oid %s\n", oid_to_hex(&args->=
oids->oid[i]));
> > +     }
>
> Small nit, the braces around this for-loop are not required.
>
> >  static int send_fetch_request(struct fetch_negotiator *negotiator, int=
 fd_out,
> >                             struct fetch_pack_args *args,
> >                             const struct ref *wants, struct oidset *com=
mon,
> > @@ -1604,6 +1625,10 @@ static struct ref *do_fetch_pack_v2(struct fetch=
_pack_args *args,
> >       if (args->depth > 0 || args->deepen_since || args->deepen_not)
> >               args->deepen =3D 1;
> >
> > +     if (args->object_info) {
> > +             state =3D FETCH_SEND_REQUEST;
> > +     }
> > +
>
> Ditto here.
>
> >       while (state !=3D FETCH_DONE) {
> >               switch (state) {
> >               case FETCH_CHECK_LOCAL:
> > @@ -1613,7 +1638,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_=
pack_args *args,
> >                       /* Filter 'ref' by 'sought' and those that aren't=
 local */
> >                       mark_complete_and_common_ref(negotiator, args, &r=
ef);
> >                       filter_refs(args, &ref, sought, nr_sought);
> > -                     if (everything_local(args, &ref))
> > +                     if (!args->object_info && everything_local(args, =
&ref))
> >                               state =3D FETCH_DONE;
> >                       else
> >                               state =3D FETCH_SEND_REQUEST;
> > @@ -1999,8 +2024,19 @@ struct ref *fetch_pack(struct fetch_pack_args *a=
rgs,
> >               }
> >               args->connectivity_checked =3D 1;
> >       }
> > -
> > -     update_shallow(args, sought, nr_sought, &si);
> > +
> > +     if (args->object_info) {
> > +             struct ref *ref_cpy_reader =3D ref_cpy;
> > +             unsigned long size =3D 0;
> > +             while (ref_cpy_reader) {
> > +                     oid_object_info(the_repository, &(ref_cpy_reader-=
>old_oid), &size);
> > +                     printf("%s %li\n", oid_to_hex(&(ref_cpy_reader->o=
ld_oid)), size);
>
> Both expressions like "&(x)" can be written instead as "&x" without the
> outer parenthesis.
>
> Likewise, we do not use %li, that line should instead read:
>
>     printf("%s %"PRIuMAX"\n", oid_to_hex(&ref_cpy_reader->old_oid), (uint=
max_t)size);
>
> Thanks,
> Taylor
