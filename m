Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69A920285
	for <e@80x24.org>; Wed, 24 May 2017 12:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939286AbdEXMak (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 08:30:40 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35633 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764104AbdEXMaC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 08:30:02 -0400
Received: by mail-qt0-f181.google.com with SMTP id v27so153295205qtg.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 05:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ejegD21MPPcKvmrp64xuJYndXnacFUnv4c6U1lYt8BI=;
        b=AT/kblQjTKSakDJfvLoaz1whpB61lpFNWgOkufhQsytDUZKBzAeqIudn3iNF9qTA7k
         8e6O/7XlZzn8r7pSN49Fpy5F+TvEFe4nzH4fFTTQrr01FBr4DNySGjCUQLe+GFv8JN6Y
         +s9Ly2nIrQWiEFJJxzB360/Ty8Eo1FxzEmN1u86lMT5SiI0iF2NpBZ9rFfVueXSzYTjJ
         XttLRTgXLOeKzsoV8jeAAZbr58QUl+u02Q4m8A5dgXMtK+1SN2QDIiA4lqObIo0FiVbr
         ccj8tG79vj5jgYb6ocL+88oo8zoxj8WccdTibdNE57cvYLkIoSp5AD1fQ6N5dN2S6aQ/
         vYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ejegD21MPPcKvmrp64xuJYndXnacFUnv4c6U1lYt8BI=;
        b=Ziwd3zrMFX3zR2yJkxKdGchOagQA8+SmtpdNQ3kjyuoCZ68hAQh+sm8VTznXLNSym4
         JNx5JEaroBmru1PL72V2Cn3/GoP4x3UZ5p+e8SIb2ywwahs2uJ+nD8CilwlebL8p88Cw
         h2MNv/EwVN0ndQZoNm5U9ABFYQ4cD//e9ex3q22XwGgwomq2hiTvLc2cEv5QMSg7yWH+
         ZOx3To92ZFD97fyvU2aKgke47n6TaS/6bSeXoGEFODsBenc6zQSh22Uon/c0bvtBIs5D
         a3COEzYHpoJpYRGzuq2JV/yyle7wN05tAMHa7jzwdS2/jpuYWphCHaLX1i3MkS21uml7
         AW9A==
X-Gm-Message-State: AODbwcDCs4lKzkY80Jr1Qv8NPShw3eiE/XsL66RP0k/bCRUCTq1c43xt
        WqurfmoIy9eEFxCFEElmXWOlucEH3A==
X-Received: by 10.200.35.177 with SMTP id q46mr36739799qtq.158.1495629001243;
 Wed, 24 May 2017 05:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Wed, 24 May 2017 05:30:00 -0700 (PDT)
In-Reply-To: <20170518201333.13088-4-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com> <20170518201333.13088-4-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 24 May 2017 14:30:00 +0200
Message-ID: <CAP8UFD0Q6kpsOBWWtt=2OV0MZvKayBQxVk9H1EfTCOuUaB-onw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] fsmonitor: teach git to optionally utilize a file
 system monitor to speed up detecting new or changed files.
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 10:13 PM, Ben Peart <peartben@gmail.com> wrote:
> When the index is read from disk, the query-fsmonitor index extension is
> used to flag the last known potentially dirty index and untracked cach

s/cach/cache/

> entries.

[...]

> diff --git a/cache.h b/cache.h
> index 188811920c..36423c77cc 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -201,6 +201,7 @@ struct cache_entry {
>  #define CE_ADDED             (1 << 19)
>
>  #define CE_HASHED            (1 << 20)
> +#define CE_FSMONITOR_DIRTY   (1 << 21)

It looks like the (1 << 21) value was used before (as CE_UNHASHED) and
was removed in:

419a597f64 (name-hash.c: remove cache entries instead of marking them
CE_UNHASHED, 2013-11-14)

I wondered if using this value again could make old and new versions
of git interact badly, but it looks like these are in memory only
flags, so it should be ok.

>  #define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
>  #define CE_CONFLICTED        (1 << 23)
>
>  struct split_index;
>  struct untracked_cache;
> @@ -342,6 +344,8 @@ struct index_state {
>         struct hashmap dir_hash;
>         unsigned char sha1[20];
>         struct untracked_cache *untracked;
> +       time_t fsmonitor_last_update;
> +       struct ewah_bitmap *fsmonitor_dirty_bitmap;

Maybe you could remove "_bitmap" at the end of the name.

>  };


> diff --git a/dir.c b/dir.c
> index 1b5558fdf9..da428489e2 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1652,6 +1652,18 @@ static int valid_cached_dir(struct dir_struct *dir,
>         if (!untracked)
>                 return 0;
>
> +       refresh_by_fsmonitor(&the_index);
> +       if (dir->untracked->use_fsmonitor) {
> +               /*
> +                * With fsmonitor, we can trust the untracked cache's
> +                * valid field.
> +                */
> +               if (untracked->valid)
> +                       goto skip_stat;

Maybe you could avoid this goto using a valid_cached_dir_after_stat()
function that would do what is after the "skip_stat:" label below?

> +               else
> +                       invalidate_directory(dir->untracked, untracked);
> +       }
> +
>         if (stat(path->len ? path->buf : ".", &st)) {
>                 invalidate_directory(dir->untracked, untracked);
>                 memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
> @@ -1665,6 +1677,7 @@ static int valid_cached_dir(struct dir_struct *dir,
>                 return 0;
>         }
>
> +skip_stat:
>         if (untracked->check_only != !!check_only) {
>                 invalidate_directory(dir->untracked, untracked);
>                 return 0;

[...]

> +void refresh_by_fsmonitor(struct index_state *istate)
> +{
> +       static has_run_once = FALSE;
> +       struct strbuf query_result = STRBUF_INIT;
> +       int query_success = 0;
> +       size_t bol = 0; /* beginning of line */
> +       time_t last_update;
> +       char *buf, *entry;
> +       int i;
> +
> +       if (!core_fsmonitor || has_run_once)
> +               return;
> +       has_run_once = TRUE;
> +
> +       /*
> +        * This could be racy so save the date/time now and the hook
> +        * should be inclusive to ensure we don't miss potential changes.
> +        */
> +       last_update = time(NULL);
> +
> +       /* If we have a last update time, call query-monitor for the set of changes since that time */
> +       if (istate->fsmonitor_last_update) {
> +               query_success = !query_fsmonitor(istate->fsmonitor_last_update, &query_result);
> +       }

Braces can be removed.

> +       if (query_success) {
> +               /* Mark all entries returned by the monitor as dirty */
> +               buf = entry = query_result.buf;
> +               for (i = 0; i < query_result.len; i++) {
> +                       if (buf[i] != '\0')
> +                               continue;
> +                       mark_file_dirty(istate, buf + bol);
> +                       bol = i + 1;
> +               }
> +               if (bol < query_result.len)
> +                       mark_file_dirty(istate, buf + bol);
> +
> +               /* Mark all clean entries up-to-date */
> +               for (i = 0; i < istate->cache_nr; i++) {
> +                       struct cache_entry *ce = istate->cache[i];
> +                       if (ce_stage(ce) || (ce->ce_flags & CE_FSMONITOR_DIRTY))
> +                               continue;
> +                       ce_mark_uptodate(ce);
> +               }
> +
> +               /*
> +                * Now that we've marked the invalid entries in the
> +                * untracked-cache itself, we can mark the untracked cache for
> +                * fsmonitor usage.
> +                */
> +               if (istate->untracked) {
> +                       istate->untracked->use_fsmonitor = 1;
> +               }

Braces can be removed.

> +       }
> +       else {
> +               /* if we can't update the cache, fall back to checking them all */
> +               for (i = 0; i < istate->cache_nr; i++)
> +                       istate->cache[i]->ce_flags |= CE_FSMONITOR_DIRTY;
> +
> +               /* mark the untracked cache as unusable for fsmonitor */
> +               if (istate->untracked)
> +                       istate->untracked->use_fsmonitor = 0;
> +       }
> +       strbuf_release(&query_result);
> +
> +       /* Now that we've updated istate, save the last_update time */
> +       istate->fsmonitor_last_update = last_update;
> +       istate->cache_changed |= FSMONITOR_CHANGED;
> +}
