Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B3F1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbfARJV3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:21:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46990 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbfARJV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:21:29 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so10126248ios.13
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYNDYTMwn82TNCxvhROo58/N64eSXXvFH9kaGS+Bkk0=;
        b=AgBxvjRDRnBq3u0TR5h4jpCmk80V3sq90lJjxVy5moPbOJ4+CkhGAw3tydNB9gSfBP
         8j+10vM5z74FQSnwtf3EiP2saMH1+olpjP1XHHIYwpYsQvxcrFPjYZ98iVfzVzoRC2dF
         EjCT85zgGVWBVPIDuZHmuCdeeW0+bQBGcFsS+eSyDLvVA56UdBm3py1mGkVQO7wUHLHx
         uc0JSntr5PcKRc9gVr3UNkDHozxXTcmV42PwJukKTaTvrYmvuZ4rebRjb8PMmcbA5kCp
         oQuz2ANUcLVD8Rv/1oBCcBvtAmP6Kpiav/Ez9yqKgtH0derTfC6WAyx7WD8CB9XOlXWq
         JXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYNDYTMwn82TNCxvhROo58/N64eSXXvFH9kaGS+Bkk0=;
        b=X/s944oRTUddDdzJ5ndlqmKiy/QcOSgYjU3RxA2y0FhBvZcaCpsbf9vxwm0i0YqthT
         Ty1taNh5dgF7cT8HvgoTVnr8WAYnL7TOcNB/Qek8CZWp0X6vJAnmK4pIXQqUhpuNobh2
         imP5lkOUpnCq+fqDwFilcceaxX/j5HGKee+ifRsUp0X6jo7+myeanHOZNW9Gt6ICUTdb
         sRE8eILonQoZWW4Ghaue5jzBnDv7c0MGt0+dR5d64hHLC4Sl26PZIef0ycp/t2vAvsro
         7YK3Zl2a6rkvVvnqyp2Ki2k7wCX6Oflt8qXBxlV5rSptf7oropnEg2j5vjbLdvTI6zUq
         EmHA==
X-Gm-Message-State: AJcUukc81FN/TLJvQoaQ4JcbSiEq6Ye116PvollrjNC2Wu1c6/qjibzp
        1FhI72395OzsmGUvu0fZ6WXubJ9M2m5tVqmoCcs=
X-Google-Smtp-Source: ALg8bN7n35kcfrn50pLwIhuZtd1Y4RDXy1G8Ac48DFFjYEp2FAvaZYcKuKFhBd3N7+KS69igposAiFWsNxZAFqiXgb0=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr9885244iof.118.1547803288401;
 Fri, 18 Jan 2019 01:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20190118022736.36832-1-phogg@novamoon.net>
In-Reply-To: <20190118022736.36832-1-phogg@novamoon.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 18 Jan 2019 16:21:02 +0700
Message-ID: <CACsJy8CRQdzMTZU0Khno+r+kqrzu-iG5J_fKnPfVMWe55azD2g@mail.gmail.com>
Subject: Re: [PATCH] pack-objects.c: Initialize read mutex in cmd_pack_objects
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 9:28 AM Patrick Hogg <phogg@novamoon.net> wrote:
>
> ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> introduced oe_get_size_slow for thread safety in parallel calls to
> try_delta(). Unfortunately oe_get_size_slow is also used in serial
> code, some of which is called before the first invocation of
> ll_find_deltas. As such the read mutex is not guaranteed to be
> initialized.

This must be the SIZE() macros in type_size_sort(), isn't it? I think
we hit the same problem (use of uninitialized mutex) in this same code
not long ago. I wonder if there's anyway we can reliably test and
catch this.

> Resolve this by splitting off the read mutex initialization from
> init_threaded_search. Instead initialize (and clean up) the read
> mutex in cmd_pack_objects.

Maybe move the mutex to 'struct packing_data' and initialize it in
prepare_packing_data(), so we centralize mutex at two locations:
generic ones go there, command-specific mutexes stay here in
init_threaded_search(). We could also move oe_get_size_slow() back to
pack-objects.c (the one outside builtin/).

> Signed-off-by: Patrick Hogg <phogg@novamoon.net>
> ---
>  builtin/pack-objects.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 411aefd68..9084bef02 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2381,22 +2381,30 @@ static pthread_cond_t progress_cond;
>   */
>  static void init_threaded_search(void)
>  {
> -       init_recursive_mutex(&read_mutex);
>         pthread_mutex_init(&cache_mutex, NULL);
>         pthread_mutex_init(&progress_mutex, NULL);
>         pthread_cond_init(&progress_cond, NULL);
>         old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
>  }
>
> +static void init_read_mutex(void)
> +{
> +       init_recursive_mutex(&read_mutex);
> +}
> +
>  static void cleanup_threaded_search(void)
>  {
>         set_try_to_free_routine(old_try_to_free_routine);
>         pthread_cond_destroy(&progress_cond);
> -       pthread_mutex_destroy(&read_mutex);
>         pthread_mutex_destroy(&cache_mutex);
>         pthread_mutex_destroy(&progress_mutex);
>  }
>
> +static void cleanup_read_mutex(void)
> +{
> +       pthread_mutex_destroy(&read_mutex);
> +}
> +
>  static void *threaded_find_deltas(void *arg)
>  {
>         struct thread_params *me = arg;
> @@ -3319,6 +3327,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>                 OPT_END(),
>         };
>
> +       init_read_mutex();
> +
>         if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
>                 BUG("too many dfs states, increase OE_DFS_STATE_BITS");
>
> @@ -3495,5 +3505,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>                            _("Total %"PRIu32" (delta %"PRIu32"),"
>                              " reused %"PRIu32" (delta %"PRIu32")"),
>                            written, written_delta, reused, reused_delta);
> +
> +       cleanup_read_mutex();
>         return 0;
>  }
> --
> 2.20.1.windows.1
>


-- 
Duy
