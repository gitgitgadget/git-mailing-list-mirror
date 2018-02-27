Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322DE1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 19:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeB0T1m (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 14:27:42 -0500
Received: from mail-yb0-f172.google.com ([209.85.213.172]:43040 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeB0T11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 14:27:27 -0500
Received: by mail-yb0-f172.google.com with SMTP id u8-v6so5211652ybo.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 11:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=snVPJKcjy2J7sjFJqGfjF7+x489itfXe4OZnBdam9BI=;
        b=CLAIHuayhk4j+bBvKFfmJijXyo0yezi2j+NFdgnEex2w2amNMX1AV5mcK0r1gusJUr
         ZbPcgOQWXgqEaYxjce8qese8cjYPAbZFOk183LwLoufMNlA0i6gmghMv+kV8kTLUoBoa
         ApeTF/n+KKmHIR+SNyVmrTZDV/10i6XH7woF7vaHq3MsVTs6RIyCOlSYh2GSeGWmLiA1
         UxbiFqgdjEwMESGnH1wqUJNAWY6mR/eqrzjvyyL7UaMtUQNBKgYzTzFAv8t6nLXrqOc5
         Diuohi6Y1c5LKBA77mgJxDCrFS3pGHQfE2VgxQHpbzrxtqL/ru5cRKOPKBd44LCUCRzL
         HVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=snVPJKcjy2J7sjFJqGfjF7+x489itfXe4OZnBdam9BI=;
        b=D4Auwb6jhZeNjxA5QVDQ6JaV4ptQnv2o4asn5H/VvWLsv4AfgKFuUCq4BkeFtBRb6F
         VGyuydEuwIjWa42cpUdKAZ4y9/tjL7dUedrZPjdpR9oEUAtJ1HygQbIDHsazyGoq3JxX
         ox6T9EUwYTwsfjWwxgCiNVu3WtHRr4pgNp4LCVN9wTA70UPZNEoe6h1Kfc+lUMkAj540
         tNPVDnvM/XLjL/IX1uVLnN6wcCYdthRa22CLXIwCZHPtriszurPscN2gkAvptpdyI0R+
         TKa3eeiEdEjEJDi9k/YqUpXfbVF8Bfzm2jczyIBJyoOgC/5H3CDvHhjLBLGHQWZ+rBdJ
         OqNQ==
X-Gm-Message-State: APf1xPDeRune58YMHjhhsDpf/o1GewKdSYaNQ4dIbRvjae3ibh/d0tCU
        usDDUYaDi3QOQI6VH8aOuxg7jgE6elWbyar762V8PQ==
X-Google-Smtp-Source: AG47ELt76nBrgQI+VJDR9GbS8sKDa+gp88+7YQqUKX4YwERuv28YkQVUHlmksHHK0IdBQ8qiyxiiGVI2A0KWDBof/4c=
X-Received: by 2002:a25:f40e:: with SMTP id q14-v6mr10144514ybd.334.1519759646405;
 Tue, 27 Feb 2018 11:27:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 27 Feb 2018 11:27:25
 -0800 (PST)
In-Reply-To: <20180207011312.189834-22-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-22-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Feb 2018 11:27:25 -0800
Message-ID: <CAGZ79kZLkHwfiqSf8htKPRKyVBCvurQwTAwW4n87ESbBfaL3sA@mail.gmail.com>
Subject: Re: [PATCH v3 21/35] fetch-pack: perform a fetch using v2
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> When communicating with a v2 server, perform a fetch by requesting the
> 'fetch' command.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/fetch-pack.c   |   2 +-
>  fetch-pack.c           | 252 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  fetch-pack.h           |   4 +-
>  t/t5702-protocol-v2.sh |  84 +++++++++++++++++
>  transport.c            |   7 +-
>  5 files changed, 342 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index f492e8abd..867dd3cc7 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -213,7 +213,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>         }
>
>         ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
> -                        &shallow, pack_lockfile_ptr);
> +                        &shallow, pack_lockfile_ptr, protocol_v0);
>         if (pack_lockfile) {
>                 printf("lock %s\n", pack_lockfile);
>                 fflush(stdout);
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 9f6b07ad9..4fb5805dd 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1008,6 +1008,247 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>         return ref;
>  }
>
> +static void add_wants(const struct ref *wants, struct strbuf *req_buf)
> +{
> +       for ( ; wants ; wants = wants->next) {
> +               const struct object_id *remote = &wants->old_oid;
> +               const char *remote_hex;
> +               struct object *o;
> +
> +               /*
> +                * If that object is complete (i.e. it is an ancestor of a
> +                * local ref), we tell them we have it but do not have to
> +                * tell them about its ancestors, which they already know
> +                * about.
> +                *
> +                * We use lookup_object here because we are only
> +                * interested in the case we *know* the object is
> +                * reachable and we have already scanned it.
> +                */
> +               if (((o = lookup_object(remote->hash)) != NULL) &&
> +                   (o->flags & COMPLETE)) {
> +                       continue;
> +               }
> +
> +               remote_hex = oid_to_hex(remote);
> +               packet_buf_write(req_buf, "want %s\n", remote_hex);
> +       }
> +}
> +
> +static void add_common(struct strbuf *req_buf, struct oidset *common)
> +{
> +       struct oidset_iter iter;
> +       const struct object_id *oid;
> +       oidset_iter_init(common, &iter);
> +
> +       while ((oid = oidset_iter_next(&iter))) {
> +               packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
> +       }
> +}
> +
> +static int add_haves(struct strbuf *req_buf, int *in_vain)
> +{
> +       int ret = 0;
> +       int haves_added = 0;
> +       const struct object_id *oid;
> +
> +       while ((oid = get_rev())) {
> +               packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
> +               if (++haves_added >= INITIAL_FLUSH)
> +                       break;
> +       };
> +
> +       *in_vain += haves_added;
> +       if (!haves_added || *in_vain >= MAX_IN_VAIN) {
> +               /* Send Done */
> +               packet_buf_write(req_buf, "done\n");
> +               ret = 1;
> +       }
> +
> +       return ret;
> +}
> +
> +static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
> +                             const struct ref *wants, struct oidset *common,
> +                             int *in_vain)
> +{
> +       int ret = 0;
> +       struct strbuf req_buf = STRBUF_INIT;
> +
> +       if (server_supports_v2("fetch", 1))
> +               packet_buf_write(&req_buf, "command=fetch");
> +       if (server_supports_v2("agent", 0))
> +               packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
> +
> +       packet_buf_delim(&req_buf);
> +       if (args->use_thin_pack)
> +               packet_buf_write(&req_buf, "thin-pack");
> +       if (args->no_progress)
> +               packet_buf_write(&req_buf, "no-progress");
> +       if (args->include_tag)
> +               packet_buf_write(&req_buf, "include-tag");
> +       if (prefer_ofs_delta)
> +               packet_buf_write(&req_buf, "ofs-delta");
> +
> +       /* add wants */
> +       add_wants(wants, &req_buf);

The comment might convey too much redundant information
instead of helping the reader gain more understanding. ;)

> +
> +       /* Add all of the common commits we've found in previous rounds */
> +       add_common(&req_buf, common);

nit:
Maybe s/add_common/add_common_haves/ or
add_previous_haves ?

> +
> +       /* Add initial haves */
> +       ret = add_haves(&req_buf, in_vain);

I like the shortness and conciseness of this send_fetch_request
function as it makes clear what is happening over the wire, however
I wonder if we can improve on that, still.

The functions 'add_common' and 'add_haves' seem like they do the
same (sending haves), except for different sets of oids.

So I would imagine that a structure like

  {
    struct set haves = compute_haves_from(in_vain, common, ...);
    struct set wants = compute_wants&wants);

    request_capabilities(args)
    send_haves(&haves);
    send_wants(&wants);
    flush();
  }

That way we would have an even more concise way of writing
one request, and factoring out the business logic. (Coming up
with the "right" haves is a heuristic that we plan on changing in
the future, so we'd want to have that encapsulated into one function
that computes all the haves?

> +
> +/*
> + * Processes a section header in a server's response and checks if it matches
> + * `section`.  If the value of `peek` is 1, the header line will be peeked (and
> + * not consumed); if 0, the line will be consumed and the function will die if
> + * the section header doesn't match what was expected.
> + */
> +static int process_section_header(struct packet_reader *reader,
> +                                 const char *section, int peek)
> +{
> +       int ret;
> +
> +       if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
> +               die("error reading packet");
> +
> +       ret = !strcmp(reader->line, section);
> +
> +       if (!peek) {
> +               if (!ret)
> +                       die("expected '%s', received '%s'",
> +                           section, reader->line);
> +               packet_reader_read(reader);
> +       }
> +
> +       return ret;
> +}
> +
> +static int process_acks(struct packet_reader *reader, struct oidset *common)
> +{
> +       /* received */
> +       int received_ready = 0;
> +       int received_ack = 0;
> +
> +       process_section_header(reader, "acknowledgments", 0);
> +       while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +               const char *arg;
> +
> +               if (!strcmp(reader->line, "NAK"))
> +                       continue;
> +
> +               if (skip_prefix(reader->line, "ACK ", &arg)) {
> +                       struct object_id oid;
> +                       if (!get_oid_hex(arg, &oid)) {
> +                               struct commit *commit;
> +                               oidset_insert(common, &oid);
> +                               commit = lookup_commit(&oid);
> +                               mark_common(commit, 0, 1);
> +                       }
> +                       continue;
> +               }
> +
> +               if (!strcmp(reader->line, "ready")) {
> +                       clear_prio_queue(&rev_list);
> +                       received_ready = 1;
> +                       continue;
> +               }
> +
> +               die(_("git fetch-pack: expected ACK/NAK, got '%s'"), reader->line);

This is slightly misleading, it could also expect "ready" ?


> +       }
> +
> +       if (reader->status != PACKET_READ_FLUSH &&
> +           reader->status != PACKET_READ_DELIM)
> +               die("Error during processing acks: %d", reader->status);

Why is this not translated unlike the one 5 lines prior to this?
Do we expect these conditions to come up due to different
root causes?

> +static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> +                                   int fd[2],
> +                                   const struct ref *orig_ref,
> +                                   struct ref **sought, int nr_sought,
> +                                   char **pack_lockfile)
> +{
> +       struct ref *ref = copy_ref_list(orig_ref);
> +       enum fetch_state state = FETCH_CHECK_LOCAL;
> +       struct oidset common = OIDSET_INIT;
> +       struct packet_reader reader;
> +       int in_vain = 0;
> +       packet_reader_init(&reader, fd[0], NULL, 0,
> +                          PACKET_READ_CHOMP_NEWLINE);
> +
> +       while (state != FETCH_DONE) {
> +               switch (state) {
> +               case FETCH_CHECK_LOCAL:
> +                       sort_ref_list(&ref, ref_compare_name);
> +                       QSORT(sought, nr_sought, cmp_ref_by_name);
> +
> +                       /* v2 supports these by default */

Is there a doc that says what is all on by default?

Thanks,
Stefan
