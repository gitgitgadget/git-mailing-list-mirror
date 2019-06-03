Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733181F462
	for <e@80x24.org>; Mon,  3 Jun 2019 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFCWHy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 18:07:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39270 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfFCWHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 18:07:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so3465780edv.6
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkwZt+g9epGP4re/1CY42/0xEvzJTazV+8DFGSjB5Dk=;
        b=gv9tfSjztEY4QZk2vHxpOM1+Sh14/4+MwNt0X7o8+wdDN2FZoTiaNfhS2k/VxdFNFS
         uiZaqDY3GQ9fZPQ5s5Uc5v+7Wl3X126MieREBmkil9ryTwpZyfr1VJgwW7jIUjstX+0g
         xAERzLfWhkyLEW11r5G3PMmqgoIBUDTIWwRGy5h0W8m81Pc3sRIRhCHPG0lbhF+HVWNu
         gTo5BWgYPsfV1wX6/mhMBSZAyMzuU52NcgLHMISFL250Pp8/IHNwOKMX8fKVr1EQWK1b
         QnL17VH352cPjmqJeVBQBghtescvf7WmtmME4NUN/Xvj+1aQ4aRCfiieDfvwes4Ld2uL
         fJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkwZt+g9epGP4re/1CY42/0xEvzJTazV+8DFGSjB5Dk=;
        b=W24TaOTWBNUr9fIu3w/UbHck6GHf404b9qN+tAn5IyRfGk33OpkIUPrXW/VndBZcK0
         HEv2ZTU95p6xslrksQ+78Ob7XRQHEhIyuxVPNDc+nFK4ToXJVAR/YvmPLn65G8y0CitJ
         cJgEFr/gT5KHtqsoyme/KTmQz5XKvLtEBdOzMWllEcAiGpn8gsYt891YOF9iBZGmz7lp
         JPh0i41AR1yiCrUNpsAkVHlh2KeZWGG+HLCRRUmg80fgXr2IOCGr7aIlEm7FCHmQHrLC
         Crze5mwkpU5nLyw6q845cD+aurP5HQLxypvyGZS8fhX6nlLA/syMGsv5A/3UM2dY/DeZ
         5K5Q==
X-Gm-Message-State: APjAAAWGgj0KrkOq9qBL9qZHQ1KR81X1Tq9UQ5ss6J9AJ4mRZbCc5pBJ
        nfFDJ9k8Qg4wClUbkWf2fVmKiwLqTsxiURGzCx0=
X-Google-Smtp-Source: APXvYqxlFG4Q2dWGapyjl5pXwwzM8SqnFMi66K+IN7jiQBoa9riZhDr4twABgRPgQXI0CPUDWZLe3nvhkhgz65OI8SU=
X-Received: by 2002:a50:926d:: with SMTP id j42mr12855791eda.237.1559599672598;
 Mon, 03 Jun 2019 15:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <20190601003603.90794-9-matvore@google.com>
In-Reply-To: <20190601003603.90794-9-matvore@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Jun 2019 15:07:40 -0700
Message-ID: <CA+P7+xqqS8wMeNw1E8yXzStNHgrCU5ME1wpWckbPA7pBD3OBHg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] list-objects-filter-options: clean up use of ALLOC_GROW
To:     Matthew DeVore <matvore@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>, jrn@google.com,
        dstolee@microsoft.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 31, 2019 at 5:40 PM Matthew DeVore <matvore@google.com> wrote:
>
> Introduce a new macro ALLOC_GROW_BY which automatically zeros the added
> array elements and takes care of updating the nr value. Use the macro in
> code introduced earlier in this patchset.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  cache.h                       | 22 ++++++++++++++++++++++
>  list-objects-filter-options.c | 17 +++++++----------
>  2 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index fa8ede9a2d..847fbdeff0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -652,33 +652,55 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  void sanitize_stdfds(void);
>  int daemonize(void);
>
>  #define alloc_nr(x) (((x)+16)*3/2)
>
>  /*
>   * Realloc the buffer pointed at by variable 'x' so that it can hold
>   * at least 'nr' entries; the number of entries currently allocated
>   * is 'alloc', using the standard growing factor alloc_nr() macro.
>   *
> + * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
> + * added niceties.
> + *
>   * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
>   */
>  #define ALLOC_GROW(x, nr, alloc) \
>         do { \
>                 if ((nr) > alloc) { \
>                         if (alloc_nr(alloc) < (nr)) \
>                                 alloc = (nr); \
>                         else \
>                                 alloc = alloc_nr(alloc); \
>                         REALLOC_ARRAY(x, alloc); \
>                 } \
>         } while (0)
>
> +/*
> + * Similar to ALLOC_GROW but handles updating of the nr value and
> + * zeroing the bytes of the newly-grown array elements.
> + *
> + * DO NOT USE any expression with side-effect for any of the
> + * arguments.
> + */

Since ALLOC_GROW already doesn't handle this safely, there isn't
necessarily a reason to fix it, but you could read the macro values
into temporary variables inside the do { } while(0) loop in order to
avoid the multiple-expansion side effect issues...

Thanks,
Jake

> +#define ALLOC_GROW_BY(x, nr, increase, alloc) \
> +       do { \
> +               if (increase) { \
> +                       size_t new_nr = nr + (increase); \
> +                       if (new_nr < nr) \
> +                               BUG("negative growth in ALLOC_GROW_BY"); \
> +                       ALLOC_GROW(x, new_nr, alloc); \
> +                       memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
> +                       nr = new_nr; \
> +               } \
> +       } while (0)
> +
>  /* Initialize and use the cache information */
>  struct lock_file;
>  void preload_index(struct index_state *index,
>                    const struct pathspec *pathspec,
>                    unsigned int refresh_flags);
>  int do_read_index(struct index_state *istate, const char *path,
>                   int must_exist); /* for testting only! */
>  int read_index_from(struct index_state *, const char *path,
>                     const char *gitdir);
>  int is_index_unborn(struct index_state *);
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 5e98e4a309..d8abe6cfcf 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -142,26 +142,24 @@ static int has_reserved_character(
>         }
>
>         return 0;
>  }
>
>  static int parse_combine_subfilter(
>         struct list_objects_filter_options *filter_options,
>         struct strbuf *subspec,
>         struct strbuf *errbuf)
>  {
> -       size_t new_index = filter_options->sub_nr++;
> +       size_t new_index = filter_options->sub_nr;
>
> -       ALLOC_GROW(filter_options->sub, filter_options->sub_nr,
> -                  filter_options->sub_alloc);
> -       memset(&filter_options->sub[new_index], 0,
> -              sizeof(*filter_options->sub));
> +       ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
> +                     filter_options->sub_alloc);
>
>         return has_reserved_character(subspec, errbuf) ||
>                 url_decode(subspec, errbuf) ||
>                 gently_parse_list_objects_filter(
>                         &filter_options->sub[new_index], subspec->buf, errbuf);
>  }
>
>  static int parse_combine_filter(
>         struct list_objects_filter_options *filter_options,
>         const char *arg,
> @@ -273,27 +271,26 @@ int parse_list_objects_filter(
>                 /*
>                  * Make filter_options an LOFC_COMBINE spec so we can trivially
>                  * add subspecs to it.
>                  */
>                 transform_to_combine_type(filter_options);
>
>                 strbuf_addstr(&filter_options->filter_spec, "+");
>                 add_url_encoded(&filter_options->filter_spec, arg);
>                 trace_printf("Generated composite filter-spec: %s\n",
>                              filter_options->filter_spec.buf);
> -               ALLOC_GROW(filter_options->sub, filter_options->sub_nr + 1,
> -                          filter_options->sub_alloc);
> -               filter_options = &filter_options->sub[filter_options->sub_nr++];
> -               memset(filter_options, 0, sizeof(*filter_options));
> +               ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
> +                             filter_options->sub_alloc);
>
>                 parse_error = gently_parse_list_objects_filter(
> -                       filter_options, arg, &errbuf);
> +                       &filter_options->sub[filter_options->sub_nr - 1], arg,
> +                       &errbuf);
>         }
>         if (parse_error)
>                 die("%s", errbuf.buf);
>         return 0;
>  }
>
>  int opt_parse_list_objects_filter(const struct option *opt,
>                                   const char *arg, int unset)
>  {
>         struct list_objects_filter_options *filter_options = opt->value;
> --
> 2.17.1
>
