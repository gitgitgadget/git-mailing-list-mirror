Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193D020401
	for <e@80x24.org>; Tue, 27 Jun 2017 15:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbdF0PnK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 11:43:10 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38345 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbdF0PnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 11:43:08 -0400
Received: by mail-it0-f53.google.com with SMTP id b205so17706386itg.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/Zwh8elczwbQtt5xhF9S3OF494rYHuKAd+1zjHA4ehw=;
        b=u0nCXt9B4nyUFJAbc+UGdHJWaELJgH3Y7LjcfiwXDT7xF9QsGsVI1IQqP8LLPLKwl3
         3mVRHp/6ScenugE1I0U3j0Z6QchaNRr1SBKkiCctoE9jaOBeqrfFWCDtGaP6YaK+amWg
         PO8A44dzyzg6wEcSXeC4BvokUJOHwkZDcsAftYCnWKuV+kkPjXtWjm6JEXQc1NfCb9Fo
         lb6xuv7kV+w7jd/QypDl70jiMJjwZoLYLC8H+kgkhvdb6EuuM4iy/y6iaLqPqARgfPX7
         xytzYPM3P5spXG7nRu1fJVyOAHzbli4Bfhp6etqVCO2AZxpKSiRPh1yZtDRY58nRaVVY
         7rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/Zwh8elczwbQtt5xhF9S3OF494rYHuKAd+1zjHA4ehw=;
        b=obnbSHP79PmeHbP2gyRrPI6WiWcirtkO+SgD0j/7Aya43hOkv20qNfIYmX5OXPOavV
         CQRNN2m/pcDhHCFwLdOFpHnIL9pVOxMiOXLMivIYKSDfV9Xo8OW2cJEVqHE5WJZt+xXB
         58+7bJVGa5AWxDRsL3HEa0Dt6d5fMoOp7yFpS5m8iISKh6KK4A0Ua1kCGvPV5+Xnei/3
         Rdq11swZSrE7L0UHM5Ly1zUAkRpSI4AZKoekJNYfJj+pPZotVU/2LGE4IsaiKcyWU+6Y
         rnY9TJ8ilsc4mg5C2P2PL27vYJBr3CRO08ey28mzt83ydeP/OSLV9dX3g/ShkMxiiVN9
         1J8Q==
X-Gm-Message-State: AKS2vOxewrSLPB/rI+0s+IZQHxk40R8YZMtQU0tv6JX+QSMAhBksej7L
        CkB86qABxShSZRQIuz0akZVhk/8VwNH4
X-Received: by 10.36.84.144 with SMTP id t138mr3669897ita.76.1498578187796;
 Tue, 27 Jun 2017 08:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Tue, 27 Jun 2017 08:43:07 -0700 (PDT)
In-Reply-To: <20170610134026.104552-4-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com> <20170610134026.104552-4-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Jun 2017 17:43:07 +0200
Message-ID: <CAP8UFD1kL9i93HnnigYcB9U8u2dUijHj5djey5k=33VrFaWUBw@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] fsmonitor: teach git to optionally utilize a file
 system monitor to speed up detecting new or changed files.
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 3:40 PM, Ben Peart <peartben@gmail.com> wrote:

> +int read_fsmonitor_extension(struct index_state *istate, const void *data,
> +       unsigned long sz)
> +{
> +       const char *index = data;
> +       uint32_t hdr_version;
> +       uint32_t ewah_size;
> +       int ret;
> +
> +       if (sz < sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t))
> +               return error("corrupt fsmonitor extension (too short)");
> +
> +       hdr_version = get_be32(index);

Here we use get_be32(), ...

> +       index += sizeof(uint32_t);
> +       if (hdr_version != INDEX_EXTENSION_VERSION)
> +               return error("bad fsmonitor version %d", hdr_version);
> +
> +       istate->fsmonitor_last_update = get_be64(index);

...get_be64(), ...

> +       index += sizeof(uint64_t);
> +
> +       ewah_size = get_be32(index);

... and get_be32 again, ...

> +       index += sizeof(uint32_t);
> +
> +       istate->fsmonitor_dirty = ewah_new();
> +       ret = ewah_read_mmap(istate->fsmonitor_dirty, index, ewah_size);
> +       if (ret != ewah_size) {
> +               ewah_free(istate->fsmonitor_dirty);
> +               istate->fsmonitor_dirty = NULL;
> +               return error("failed to parse ewah bitmap reading fsmonitor index extension");
> +       }
> +
> +       return 0;
> +}
> +
> +void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
> +{
> +       uint32_t hdr_version;
> +       uint64_t tm;
> +       struct ewah_bitmap *bitmap;
> +       int i;
> +       uint32_t ewah_start;
> +       uint32_t ewah_size = 0;
> +       int fixup = 0;
> +
> +       hdr_version = htonl(INDEX_EXTENSION_VERSION);

... but here we use htonl() instead of put_be32(), ...

> +       strbuf_add(sb, &hdr_version, sizeof(uint32_t));
> +
> +       tm = htonll((uint64_t)istate->fsmonitor_last_update);

... htonll(), ...

> +       strbuf_add(sb, &tm, sizeof(uint64_t));
> +       fixup = sb->len;
> +       strbuf_add(sb, &ewah_size, sizeof(uint32_t)); /* we'll fix this up later */
> +
> +       ewah_start = sb->len;
> +       bitmap = ewah_new();
> +       for (i = 0; i < istate->cache_nr; i++)
> +               if (istate->cache[i]->ce_flags & CE_FSMONITOR_DIRTY)
> +                       ewah_set(bitmap, i);
> +       ewah_serialize_strbuf(bitmap, sb);
> +       ewah_free(bitmap);
> +
> +       /* fix up size field */
> +       ewah_size = htonl(sb->len - ewah_start);

... and htonl() again.

It would be more consistent (and perhaps more correct) to use
put_beXX() functions, instead of the htonl() and htonll() functions.

> +       memcpy(sb->buf + fixup, &ewah_size, sizeof(uint32_t));
> +}

> +/*
> + * Call the query-fsmonitor hook passing the time of the last saved results.
> + */
> +static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *query_result)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       char ver[64];
> +       char date[64];
> +       const char *argv[4];
> +
> +       if (!(argv[0] = find_hook("query-fsmonitor")))
> +               return -1;
> +
> +       snprintf(ver, sizeof(version), "%d", version);
> +       snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
> +       argv[1] = ver;
> +       argv[2] = date;
> +       argv[3] = NULL;
> +       cp.argv = argv;

Maybe it would be nicer using the argv_array_pushX() functions.

> +       cp.out = -1;
> +
> +       return capture_command(&cp, query_result, 1024);
> +}
> +
> +static void mark_file_dirty(struct index_state *istate, const char *name)
> +{
> +       struct untracked_cache_dir *dir;
> +       int pos;
> +
> +       /* find it in the index and mark that entry as dirty */
> +       pos = index_name_pos(istate, name, strlen(name));
> +       if (pos >= 0) {
> +               if (!(istate->cache[pos]->ce_flags & CE_FSMONITOR_DIRTY)) {
> +                       istate->cache[pos]->ce_flags |= CE_FSMONITOR_DIRTY;
> +                       istate->cache_changed |= FSMONITOR_CHANGED;
> +               }
> +       }
> +
> +       /*
> +        * Find the corresponding directory in the untracked cache
> +        * and mark it as invalid
> +        */
> +       if (!istate->untracked || !istate->untracked->root)
> +               return;
> +
> +       dir = find_untracked_cache_dir(istate->untracked, istate->untracked->root, name);
> +       if (dir) {
> +               if (dir->valid) {
> +                       dir->valid = 0;
> +                       istate->cache_changed |= FSMONITOR_CHANGED;
> +               }
> +       }

The code above is quite similar as what is in mark_fsmonitor_dirty(),
so I wonder if a refactoring is possible.

> +}
> +
> +void refresh_by_fsmonitor(struct index_state *istate)
> +{
> +       static int has_run_once = 0;
> +       struct strbuf query_result = STRBUF_INIT;
> +       int query_success = 0;
> +       size_t bol = 0; /* beginning of line */
> +       uint64_t last_update;
> +       char *buf, *entry;
> +       int i;
> +
> +       if (!core_fsmonitor || has_run_once)
> +               return;
> +       has_run_once = 1;
> +
> +       /*
> +        * This could be racy so save the date/time now and the hook
> +        * should be inclusive to ensure we don't miss potential changes.
> +        */
> +       last_update = getnanotime();
> +
> +       /*
> +        * If we have a last update time, call query-monitor for the set of
> +        * changes since that time.
> +        */
> +       if (istate->fsmonitor_last_update) {
> +               query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION,
> +                       istate->fsmonitor_last_update, &query_result);
> +               trace_performance_since(last_update, "query-fsmonitor");
> +       }
> +
> +       if (query_success) {
> +               /* Mark all entries returned by the monitor as dirty */
> +               buf = entry = query_result.buf;
> +               for (i = 0; i < query_result.len; i++) {
> +                       if (buf[i] != '\0')
> +                               continue;
> +                       mark_file_dirty(istate, buf + bol);

It looks like bol is always equal to i here...

> +                       bol = i + 1;
> +               }
> +               if (bol < query_result.len)
> +                       mark_file_dirty(istate, buf + bol);

... and here too. As it is not used below, I wonder if you really need
the bol variable.

> +               /* Mark all clean entries up-to-date */
> +               for (i = 0; i < istate->cache_nr; i++) {
> +                       struct cache_entry *ce = istate->cache[i];
> +                       if (ce_stage(ce) || (ce->ce_flags & CE_FSMONITOR_DIRTY))
> +                               continue;
> +                       ce_mark_uptodate(ce);
> +               }
