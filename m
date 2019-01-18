Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7325E1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 13:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfARNIC (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 08:08:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45452 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfARNIB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 08:08:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so11025982edb.12
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 05:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3QPOsu1aS3d7ARy3AOnJA+Bbidju1HfjQKXSfqI3KeM=;
        b=bhe3Ua2WsnsfyhdWsHyzvXz4i81AITBSQmKd9q//mwmuB5R+8M8iiHaO8tgewdV1F/
         rdv2hAif1TFtSNVrnNZtZHhj0PoGCCDKfL6JKWLWByPrMywPL9GW8A8YS3JhJ9IuRW0Z
         tE8K2y9OvbEExQzup5cHrZncJqgE0LJM4DVYqCwnXg34R020/Ra3IhJiJXAJDG4jENwd
         3J16dWe4SYkhrnkPCc85knsjRrBngRX1UcoDQXlzQaa5XNVNBfd4EE1N/uAo+j7Sf+0W
         FduHUbdyMRDcBvpQbz28WtKs4x/iwhkhGIP4enNGWmrSoImy88qPtJX5w4Klad/4qNa7
         JkQg==
X-Gm-Message-State: AJcUukdvB1tEkjCDIjxNnRdAURTmaVEPAIN6oZ3rMeoRG+LoKqN6FrNf
        hN2D1r6o4MUAtB3UTSwJYIcsy8A4FQ==
X-Google-Smtp-Source: ALg8bN4NWLhPHgLRXg/b6vTJY9/o5Z9RelSC1UAN84+cIodkoarJIOnkadu1z0shAOVIp25xj4+r9Q==
X-Received: by 2002:a17:906:154c:: with SMTP id c12-v6mr14552746ejd.69.1547816879365;
        Fri, 18 Jan 2019 05:07:59 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id x38sm7307856edx.24.2019.01.18.05.07.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:07:59 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id f23so11101177edb.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 05:07:59 -0800 (PST)
X-Received: by 2002:a17:906:4204:: with SMTP id z4-v6mr14527970ejk.13.1547816878752;
 Fri, 18 Jan 2019 05:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20190118022736.36832-1-phogg@novamoon.net> <CACsJy8CRQdzMTZU0Khno+r+kqrzu-iG5J_fKnPfVMWe55azD2g@mail.gmail.com>
 <CAFOcBzmCWBjng_HqFthSrg3eKcEHpQLaa5buKAcm8JHt7EsGdA@mail.gmail.com>
In-Reply-To: <CAFOcBzmCWBjng_HqFthSrg3eKcEHpQLaa5buKAcm8JHt7EsGdA@mail.gmail.com>
From:   Patrick Hogg <phogg@novamoon.net>
Date:   Fri, 18 Jan 2019 08:07:20 -0500
X-Gmail-Original-Message-ID: <CAFOcBz=pcLO-t0FSPHQ9eos4SN+nK3kyFr2xTTyGNu447PFnQw@mail.gmail.com>
Message-ID: <CAFOcBz=pcLO-t0FSPHQ9eos4SN+nK3kyFr2xTTyGNu447PFnQw@mail.gmail.com>
Subject: Fwd: [PATCH] pack-objects.c: Initialize read mutex in cmd_pack_objects
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 4:21 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Jan 18, 2019 at 9:28 AM Patrick Hogg <phogg@novamoon.net> wrote:
> >
> > ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> > 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> > introduced oe_get_size_slow for thread safety in parallel calls to
> > try_delta(). Unfortunately oe_get_size_slow is also used in serial
> > code, some of which is called before the first invocation of
> > ll_find_deltas. As such the read mutex is not guaranteed to be
> > initialized.
>
> This must be the SIZE() macros in type_size_sort(), isn't it? I think
> we hit the same problem (use of uninitialized mutex) in this same code
> not long ago. I wonder if there's anyway we can reliably test and
> catch this.

It was actually the SET_SIZE macro in check_object, at least for the
repo at my company that hits this issue.  I took a look at the call
tree for oe_get_size_slow and found that it's used in many places
outside of ll_find_deltas, so there are many potential call sites
where this could crop up:
oe_get_size_slow
    oe_size (SIZE macro)
        write_reuse_object
            write_object
                write_one
                    write_pack_file
                        cmd_pack_objects
        type_size_sort
            prepare_pack
                cmd_pack_objects
        try_delta
            find_deltas
                threaded_find_deltas
                    ll_find_deltas
                        prepare_pack
                            cmd_pack_objects
                ll_find_deltas
                    prepare_pack
                        cmd_pack_objects
        free_unpacked
            find_deltas
                threaded_find_deltas
                    ll_find_deltas
                        prepare_pack
                            cmd_pack_objects
                ll_find_deltas
                    prepare_pack
                        cmd_pack_objects
    oe_size_less_than
        prepare_pack
            cmd_pack_objects
    oe_size_greater_than
        write_no_reuse_object
            write_reuse_object
                write_object
                    write_one
                        write_pack_file
                            cmd_pack_objects
            write_object
                write_one
                    write_pack_file
                        cmd_pack_objects
        get_object_details
            prepare_pack
                cmd_pack_objects
    oe_set_size (SET_SIZE macro)
        check_object
            get_object_details
                prepare_pack
                    cmd_pack_objects
        drop_reused_delta
            break_delta_chains
                get_object_details
                    prepare_pack
                        cmd_pack_objects
(Sorry if this is redundant for those who know the code better)

>
>
> > Resolve this by splitting off the read mutex initialization from
> > init_threaded_search. Instead initialize (and clean up) the read
> > mutex in cmd_pack_objects.
>
> Maybe move the mutex to 'struct packing_data' and initialize it in
> prepare_packing_data(), so we centralize mutex at two locations:
> generic ones go there, command-specific mutexes stay here in
> init_threaded_search(). We could also move oe_get_size_slow() back to
> pack-objects.c (the one outside builtin/).

I was already thinking that generic mutexes should be separated from
command specific ones (that's why I introduced init_read_mutex and
cleanup_read_mutex, but that may well not be the right exposure.)
I'll try my hand at this tonight (just moving the mutex to struct
packing_data and initializing it in prepare_packing_data, I'll leave
large code moves to the experts) and see how it turns out.

>
>
> > Signed-off-by: Patrick Hogg <phogg@novamoon.net>
> > ---
> >  builtin/pack-objects.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 411aefd68..9084bef02 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -2381,22 +2381,30 @@ static pthread_cond_t progress_cond;
> >   */
> >  static void init_threaded_search(void)
> >  {
> > -       init_recursive_mutex(&read_mutex);
> >         pthread_mutex_init(&cache_mutex, NULL);
> >         pthread_mutex_init(&progress_mutex, NULL);
> >         pthread_cond_init(&progress_cond, NULL);
> >         old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
> >  }
> >
> > +static void init_read_mutex(void)
> > +{
> > +       init_recursive_mutex(&read_mutex);
> > +}
> > +
> >  static void cleanup_threaded_search(void)
> >  {
> >         set_try_to_free_routine(old_try_to_free_routine);
> >         pthread_cond_destroy(&progress_cond);
> > -       pthread_mutex_destroy(&read_mutex);
> >         pthread_mutex_destroy(&cache_mutex);
> >         pthread_mutex_destroy(&progress_mutex);
> >  }
> >
> > +static void cleanup_read_mutex(void)
> > +{
> > +       pthread_mutex_destroy(&read_mutex);
> > +}
> > +
> >  static void *threaded_find_deltas(void *arg)
> >  {
> >         struct thread_params *me = arg;
> > @@ -3319,6 +3327,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> >                 OPT_END(),
> >         };
> >
> > +       init_read_mutex();
> > +
> >         if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
> >                 BUG("too many dfs states, increase OE_DFS_STATE_BITS");
> >
> > @@ -3495,5 +3505,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> >                            _("Total %"PRIu32" (delta %"PRIu32"),"
> >                              " reused %"PRIu32" (delta %"PRIu32")"),
> >                            written, written_delta, reused, reused_delta);
> > +
> > +       cleanup_read_mutex();
> >         return 0;
> >  }
> > --
> > 2.20.1.windows.1
> >
>
>
> --
> Duy
