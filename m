Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F197B1F406
	for <e@80x24.org>; Thu,  4 Jan 2018 01:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeADBHK (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 20:07:10 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:43278 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeADBHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 20:07:09 -0500
Received: by mail-qt0-f170.google.com with SMTP id w10so186439qtb.10
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 17:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jec3pncx0zjcqP5728KpJHA2OGFcpQ69wdlLjxxD72I=;
        b=PZHurLNo72JV174Y8uIBNmyVSCMGsLtUKc9muVeZXz5/N0+73/7gOqe6VrK5obavmn
         ww/7dKCbZNSQL+kuDxo/TvH0/e/HQgywqAO5JU0T84j+66qGhPDMnmU6s2rtgyyp7533
         +WwbaN88+qJhtUqxtAcrjSEoawiKgNTXkdx/bEml9eJlk7JHq0MnYN/nX7l4qwMUXTw8
         DFsPtLzCg1hP/iBYuBB8+5LeSDCDUSv/ctH8M/fJ+TIAL36epLnupVJ23AtwkNWCSJkP
         XizXH+KqQa5pEcomnbvc8/ITVZssFevtZEyc8oFzvxgY53R37j747xF8MYnhCEX3+eC4
         G/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jec3pncx0zjcqP5728KpJHA2OGFcpQ69wdlLjxxD72I=;
        b=qTW/yZ9QX3YAym/7VIE1kgacvso/wDqkC5ENvYrqPMLAt8nHT1GuvL94ag9SJ7GDT+
         Rg16exRugLhuurUTDGNdf687DFq0Vn5CWlcSLKMbgmxwszQvsdsXqQsBbZwWHmwjhyf/
         +Lwo7LwN9C8UTxtjaVpEFfv0F44MRd2a9OFd0fooP0qL+MrgkSVLeAiuurm76D/Y+Zd8
         f9McsZ2rACqGD2uQSy0dVFZSpM2S9zTJY8D4aiN8/N9/tU0hnGYBRcjsWOeILNPhnsfJ
         1P+i6aihrhk6dYCnkTEEdF0BnvAFVhA2pRPx844fZaz1s46k3p6hvLJRmCYZHww5RxkY
         3AgA==
X-Gm-Message-State: AKGB3mK5fgIvaK78TeZYkXVNOxznS0evGXwWwVzTdrPlCdm6rJY1QiP5
        I/BL84sRvkQD7WmYAPkZanxSmdKqqrGpmfSN7r6XvQ==
X-Google-Smtp-Source: ACJfBovj9odM1ukXf0PKOrv7Bon/jzOoavVC4zuSR3peRKM3g16SMchxKMPDe7yDTHxvKV6r9UFiytp2Q9kfIOQt8Pg=
X-Received: by 10.200.35.215 with SMTP id r23mr4037060qtr.174.1515028028581;
 Wed, 03 Jan 2018 17:07:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 3 Jan 2018 17:07:07 -0800 (PST)
In-Reply-To: <20180103001828.205012-20-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-20-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 17:07:07 -0800
Message-ID: <CAGZ79kYVeKS26qMEiu=2tP0t18no9CtEoAMeBO-rSt+66=fnGQ@mail.gmail.com>
Subject: Re: [PATCH 19/26] upload-pack: introduce fetch server command
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> Introduce the 'fetch' server command.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/technical/protocol-v2.txt |  14 ++
>  serve.c                                 |   2 +
>  upload-pack.c                           | 290 ++++++++++++++++++++++++++++++++
>  upload-pack.h                           |   9 +
>  4 files changed, 315 insertions(+)
>  create mode 100644 upload-pack.h
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 5f4d0e719..2a8e2f226 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -115,3 +115,17 @@ The output of ls-refs is as follows:
>
>      symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
>      shallow = PKT-LINE("shallow" SP obj-id LF)
> +
> + Fetch
> +-------
> +
> +Fetch will need to be a modified version of the v1 fetch protocol.  Some
> +potential areas for improvement are: Ref-in-want, CDN offloading,
> +Fetch-options.
> +
> +Since we'll have an 'ls-ref' service we can eliminate the need of fetch
> +to perform a ref-advertisement, instead a client can run the 'ls-refs'
> +service first, in order to find out what refs the server has, and then
> +request those refs directly using the fetch service.
> +
> +//TODO Flesh out the design

TODO: actually do it. ;)

a couple notes from the discussion in office:
* Could we split fetch into multiple phases
  (negotiation + getting the pack)
* negotiation could be reused in forced push to
  minimize the pack to be sent
* negotiation in a half duplex is actually better
  called 'discovery', which discovers about the set
  of objects available on the remote side.
  (the opposite would be reveal, or 'ask-for-discovery', which
  is could be used for a symmetric design of fetch and push)


> diff --git a/serve.c b/serve.c
> index 88d548410..ca3bb7190 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -6,6 +6,7 @@
>  #include "argv-array.h"
>  #include "ls-refs.h"
>  #include "serve.h"
> +#include "upload-pack.h"
>
>  static int always_advertise(struct repository *r,
>                             struct strbuf *value)
> @@ -46,6 +47,7 @@ static struct protocol_capability capabilities[] = {
>         { "agent", agent_advertise, NULL },
>         { "stateless-rpc", always_advertise, NULL },
>         { "ls-refs", always_advertise, ls_refs },
> +       { "fetch", always_advertise, upload_pack_v2 },
>  };
>
>  static void advertise_capabilities(void)
> diff --git a/upload-pack.c b/upload-pack.c
> index 2ca60d27c..c41f6f528 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -20,6 +20,7 @@
>  #include "prio-queue.h"
>  #include "protocol.h"
>  #include "serve.h"
> +#include "upload-pack.h"
>
>  static const char * const upload_pack_usage[] = {
>         N_("git upload-pack [<options>] <dir>"),
> @@ -1040,6 +1041,295 @@ static void upload_pack(void)
>         }
>  }
>
> +struct upload_pack_data {
> +       struct object_array wants;
> +       struct oid_array haves;
> +
> +       unsigned stateless_rpc : 1;
> +
> +       unsigned use_thin_pack : 1;
> +       unsigned use_ofs_delta : 1;
> +       unsigned no_progress : 1;
> +       unsigned use_include_tag : 1;
> +       unsigned done : 1;
> +};
> +
> +#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, 0, 0, 0, 0, 0, 0 }
> +
> +static void upload_pack_data_clear(struct upload_pack_data *data)
> +{
> +       object_array_clear(&data->wants);
> +       oid_array_clear(&data->haves);
> +}
> +
> +static int parse_want(const char *line)
> +{
> +       const char *arg;
> +       if (skip_prefix(line, "want ", &arg)) {
> +               struct object_id oid;
> +               struct object *o;
> +
> +               if (get_oid_hex(arg, &oid))
> +                       die("git upload-pack: protocol error, "
> +                           "expected to get oid, not '%s'", line);
> +
> +               o = parse_object(&oid);
> +               if (!o) {
> +                       packet_write_fmt(1,
> +                                        "ERR upload-pack: not our ref %s",
> +                                        oid_to_hex(&oid));
> +                       die("git upload-pack: not our ref %s",
> +                           oid_to_hex(&oid));
> +               }
> +
> +               if (!(o->flags & WANTED)) {
> +                       o->flags |= WANTED;
> +                       add_object_array(o, NULL, &want_obj);
> +               }
> +
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int parse_have(const char *line, struct oid_array *haves)
> +{
> +       const char *arg;
> +       if (skip_prefix(line, "have ", &arg)) {
> +               struct object_id oid;
> +
> +               if (get_oid_hex(arg, &oid))
> +                       die("git upload-pack: expected SHA1 object, got '%s'", arg);
> +               oid_array_append(haves, &oid);
> +               return 1;
> +       }

The same stylistic nit as in an earlier patch: Maybe
shortcircuit by inverting the condition?



> +
> +       return 0;
> +}
> +
> +static void process_args(struct argv_array *args, struct upload_pack_data *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < args->argc; i++) {
> +               const char *arg = args->argv[i];
> +
> +               /* process want */
> +               if (parse_want(arg))
> +                       continue;
> +               /* process have line */
> +               if (parse_have(arg, &data->haves))
> +                       continue;
> +
> +               /* process args like thin-pack */
> +               if (!strcmp(arg, "thin-pack")) {
> +                       use_thin_pack = 1;
> +                       continue;
> +               }
> +               if (!strcmp(arg, "ofs-delta")) {
> +                       use_ofs_delta = 1;
> +                       continue;
> +               }
> +               if (!strcmp(arg, "no-progress")) {
> +                       no_progress = 1;
> +                       continue;
> +               }
> +               if (!strcmp(arg, "include-tag")) {
> +                       use_include_tag = 1;
> +                       continue;
> +               }
> +               if (!strcmp(arg, "done")) {
> +                       data->done = 1;
> +                       continue;
> +               }
> +
> +               /* ignore unknown lines maybe? */
> +               die("unexpect line: '%s'", arg);
> +       }
> +}
> +
> +static void read_haves(struct upload_pack_data *data)
> +{
> +       struct packet_reader reader;
> +       packet_reader_init(&reader, 0, NULL, 0,
> +                          PACKET_READ_CHOMP_NEWLINE);
> +
> +       while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
> +
> +               if (parse_have(reader.line, &data->haves))
> +                       continue;
> +               if (!strcmp(reader.line, "done")) {
> +                       data->done = 1;
> +                       continue;
> +               }
> +       }
> +       if (reader.status != PACKET_READ_FLUSH)
> +               die("ERROR");
> +}
> +
> +static int process_haves(struct oid_array *haves, struct oid_array *common)
> +{
> +       int i;
> +
> +       /* Process haves */
> +       for (i = 0; i < haves->nr; i++) {
> +               const struct object_id *oid = &haves->oid[i];
> +               struct object *o;
> +               int we_knew_they_have = 0;
> +
> +               if (!has_object_file(oid))
> +                       continue;
> +
> +               oid_array_append(common, oid);
> +
> +               o = parse_object(oid);
> +               if (!o)
> +                       die("oops (%s)", oid_to_hex(oid));
> +               if (o->type == OBJ_COMMIT) {
> +                       struct commit_list *parents;
> +                       struct commit *commit = (struct commit *)o;
> +                       if (o->flags & THEY_HAVE)
> +                               we_knew_they_have = 1;
> +                       else
> +                               o->flags |= THEY_HAVE;
> +                       if (!oldest_have || (commit->date < oldest_have))
> +                               oldest_have = commit->date;
> +                       for (parents = commit->parents;
> +                            parents;
> +                            parents = parents->next)
> +                               parents->item->object.flags |= THEY_HAVE;
> +               }
> +               if (!we_knew_they_have)
> +                       add_object_array(o, NULL, &have_obj);
> +       }
> +
> +       return 0;
> +}
> +
> +static int send_acks(struct oid_array *acks, struct strbuf *response)
> +{
> +       int i;
> +       /* Send Acks */
> +       if (!acks->nr)
> +               packet_buf_write(response, "NAK\n");
> +
> +       for (i = 0; i < acks->nr; i++) {
> +               packet_buf_write(response, "ACK %s common\n",
> +                                oid_to_hex(&acks->oid[i]));
> +       }
> +
> +       if (ok_to_give_up()) {
> +               /* Send Ready */
> +               packet_buf_write(response, "ACK %s ready\n",
> +                                oid_to_hex(&acks->oid[i-1]));
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int process_haves_and_send_acks(struct upload_pack_data *data)
> +{
> +       struct oid_array common = OID_ARRAY_INIT;
> +       struct strbuf response = STRBUF_INIT;
> +       int ret = 0;
> +
> +       process_haves(&data->haves, &common);
> +       if (data->done) {
> +               ret = 1;
> +       } else if (send_acks(&common, &response)) {
> +               packet_buf_delim(&response);
> +               ret = 1;
> +       } else {
> +               /* Add Flush */
> +               packet_buf_flush(&response);
> +               ret = 0;
> +       }
> +
> +       /* Send response */
> +       write_or_die(1, response.buf, response.len);
> +       strbuf_release(&response);
> +
> +       oid_array_clear(&data->haves);
> +       oid_array_clear(&common);
> +       return ret;
> +}
> +
> +#define FETCH_PROCESS_ARGS 0
> +#define FETCH_READ_HAVES 1
> +#define FETCH_SEND_ACKS 2
> +#define FETCH_SEND_PACK 3
> +#define FETCH_DONE 4
> +
> +int upload_pack_v2(struct repository *r, struct argv_array *keys,
> +                  struct argv_array *args)
> +{
> +       int state = FETCH_PROCESS_ARGS;
> +       struct upload_pack_data data = UPLOAD_PACK_DATA_INIT;
> +       const char *out;
> +       use_sideband = LARGE_PACKET_MAX;
> +
> +       /* Check if cmd is being run as a stateless-rpc */
> +       if (has_capability(keys, "stateless-rpc", &out))
> +               if (!strcmp(out, "true"))
> +                       data.stateless_rpc = 1;
> +
> +       while (state != FETCH_DONE) {
> +               switch (state) {
> +               case FETCH_PROCESS_ARGS:
> +                       process_args(args, &data);
> +
> +                       if (!want_obj.nr) {
> +                               /*
> +                                * Request didn't contain any 'want' lines,
> +                                * guess they didn't want anything.
> +                                */
> +                               state = FETCH_DONE;
> +                       } else if (data.haves.nr) {
> +                               /*
> +                                * Request had 'have' lines, so lets ACK them.
> +                                */
> +                               state = FETCH_SEND_ACKS;
> +                       } else {
> +                               /*
> +                                * Request had 'want's but no 'have's so we can
> +                                * immedietly go to construct and send a pack.
> +                                */
> +                               state = FETCH_SEND_PACK;
> +                       }
> +                       break;
> +               case FETCH_READ_HAVES:
> +                       read_haves(&data);
> +                       state = FETCH_SEND_ACKS;
> +                       break;
> +               case FETCH_SEND_ACKS:
> +                       if (process_haves_and_send_acks(&data))
> +                               state = FETCH_SEND_PACK;
> +                       else if (data.stateless_rpc)
> +                               /*
> +                                * Request was made via stateless-rpc and a
> +                                * packfile isn't ready to be created and sent.
> +                                */
> +                               state = FETCH_DONE;
> +                       else
> +                               state = FETCH_READ_HAVES;
> +                       break;
> +               case FETCH_SEND_PACK:
> +                       create_pack_file();
> +                       state = FETCH_DONE;
> +                       break;
> +               case FETCH_DONE:
> +                       break;
> +               default:
> +                       BUG("invalid state");
> +               }
> +       }
> +
> +       upload_pack_data_clear(&data);
> +       return 0;
> +}
> +
>  static int upload_pack_config(const char *var, const char *value, void *unused)
>  {
>         if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
> diff --git a/upload-pack.h b/upload-pack.h
> new file mode 100644
> index 000000000..54c429563
> --- /dev/null
> +++ b/upload-pack.h
> @@ -0,0 +1,9 @@
> +#ifndef UPLOAD_PACK_H
> +#define UPLOAD_PACK_H
> +
> +struct repository;
> +struct argv_array;
> +extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
> +                         struct argv_array *args);
> +
> +#endif /* UPLOAD_PACK_H */
> --
> 2.15.1.620.gb9897f4670-goog
>
