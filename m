Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B26C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 22:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FED61183
	for <git@archiver.kernel.org>; Thu, 27 May 2021 22:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhE0WtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhE0WtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 18:49:15 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAF3C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 15:47:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so1735711otc.12
        for <git@vger.kernel.org>; Thu, 27 May 2021 15:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otBz3UIXcgRThf6hfXz61Tk7uXt+yAQkhfo4NrzQOdU=;
        b=IJ80Ljw0WQ5cw3t48AzMXPCt+ftNCAXPYpZpKmUmbSsThAhzrID/wKA5ForscjZzIL
         Lp01bnJofuBpqxnttD8cqAvRoDn2WHGPUAjUorgGJ0DqzQjxySDaTybPnEFKZHcT0Qzf
         vJG1tfxYXuHrS1g8ssvBPzIAQAHSoO54XnCqDih9Xea3D9WUplrvWN9PQHleF1sZHxYW
         aZJcUwZE5YWbss3YAeQ1zhWPKd8Dw2r++ddTwMRrTwYpD3+YkkQ6BFhjFkAt2UWY8NVe
         6ZDWgIWF1WrxIcpCfAZN2rOGsUoA6VbtPsdFOvnQWWZPo06LjEqg6RkKJhbXD2ym4eoa
         wwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otBz3UIXcgRThf6hfXz61Tk7uXt+yAQkhfo4NrzQOdU=;
        b=cjr8nRatzIRqgKwiY7y2Jqjxj+ducYxXA4OLf2krF+II9EVqmXtQfG9RiLXmFGAZVf
         DdxeCIgLp4x2eVvdVXPpk7MVKGvCnYsoYwejhKy833dN63QOXj20ksGSA4rvUCGmZgu5
         WXZNolBxlBoxjAasEAwQvcjKOEztCONawVqtBjAFhcDD4z6LUp1SI8QP2SMUi929poIa
         CnlO5kn3+nbRgdGKTxp/FAESpoFgebdqXNZpP+pOYO1BEjSdth6OigBXIayPIhbHSWba
         LeHSNZT013UrJSuybIBqEgrJaxs9i5j8gL4ZKK6jWeMWk1dN1XaHdN28HjiN0zc6lIy9
         XKrQ==
X-Gm-Message-State: AOAM5326CwLVMN1BQmieUFxqq1JOdafp2lIH2PGW7oUA4eGKL6GdY/7e
        vHUjujfDS1nGrKiRlM+iCQhZSJXx3M8++bXJnBM=
X-Google-Smtp-Source: ABdhPJwdn0xI+/zTjouiBQD5jazWD99ZgfvZcLbhOAXkhH43Dcs1C6y54eSfbWwz3Q7v/5K5uo9um/rDCENN7kVclPo=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr4471707otn.162.1622155658972;
 Thu, 27 May 2021 15:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
 <e0842d32-a11c-91d8-3660-cffdb5639193@web.de>
In-Reply-To: <e0842d32-a11c-91d8-3660-cffdb5639193@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 May 2021 15:47:27 -0700
Message-ID: <CABPp-BH_nFJ2N6Jf64jZPNKdbwm2Yt=zo6pw-9s6S+fzo7a=pg@mail.gmail.com>
Subject: Re: [PATCH 1/5] merge-ort: replace string_list_df_name_compare with
 faster alternative
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 2:00 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 27.05.21 um 10:37 schrieb Elijah Newren via GitGitGadget:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Gathering accumulated times from trace2 output on the mega-renames
> > testcase, I saw the following timings (where I'm only showing a few
> > lines to highlight the portions of interest):
> >
> >     10.120 : label:incore_nonrecursive
> >         4.462 : ..label:process_entries
> >            3.143 : ....label:process_entries setup
> >               2.988 : ......label:plist special sort
> >            1.305 : ....label:processing
> >         2.604 : ..label:collect_merge_info
> >         2.018 : ..label:merge_start
> >         1.018 : ..label:renames
> >
> > In the above output, note that the 4.462 seconds for process_entries wa=
s
> > split as 3.143 seconds for "process_entries setup" and 1.305 seconds fo=
r
> > "processing" (and a little time for other stuff removed from the
> > highlight).  Most of the "process_entries setup" time was spent on
> > "plist special sort" which corresponds to the following code:
> >
> >     trace2_region_enter("merge", "plist special sort", opt->repo);
> >     plist.cmp =3D string_list_df_name_compare;
> >     string_list_sort(&plist);
> >     trace2_region_leave("merge", "plist special sort", opt->repo);
> >
> > In other words, in a merge strategy that would be invoked by passing
> > "-sort" to either rebase or merge, sorting an array takes more time tha=
n
> > anything else.  Serves me right for naming my merge strategy this way.
> >
> > Rewrite the comparison function and remove as many levels of indirectio=
n
> > as possible (e.g. the old code had
> >     cmp_items() ->
> >       string_list_df_name_compare() ->
> >         df_name_compare()
> > now we just have sort_dirs_next_to_their_children()), and tweak it to b=
e
> > as optimized as possible for our specific case.  These changes reduced
> > the time spent in "plist special sort" by ~25% in the mega-renames case=
.
> >
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28),
> > this change improves the performance as follows:
> >
> >                             Before                  After
> >     no-renames:        5.622 s =C2=B1  0.059 s     5.235 s =C2=B1  0.04=
2 s
> >     mega-renames:     10.127 s =C2=B1  0.073 s     9.419 s =C2=B1  0.10=
7 s
> >     just-one-mega:   500.3  ms =C2=B1  3.8  ms   480.1  ms =C2=B1  3.9 =
 ms
>
> Interesting.
>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 64 ++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 41 insertions(+), 23 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 142d44d74d63..367aec4b7def 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -2746,31 +2746,50 @@ static int detect_and_process_renames(struct me=
rge_options *opt,
> >
> >  /*** Function Grouping: functions related to process_entries() ***/
> >
> > -static int string_list_df_name_compare(const char *one, const char *tw=
o)
> > +static int sort_dirs_next_to_their_children(const void *a, const void =
*b)
> >  {
> > -     int onelen =3D strlen(one);
> > -     int twolen =3D strlen(two);
>
> The old code scans both strings fully, while the new one stops when it
> reaches a difference and doesn't look at any further characters.  How
> much does that contribute to the speedup?  (I suspect a lot.)

Oh, indeed, good catch.  It appears to be responsible for essentially all o=
f it.

> >       /*
> > -      * Here we only care that entries for D/F conflicts are
> > -      * adjacent, in particular with the file of the D/F conflict
> > -      * appearing before files below the corresponding directory.
> > -      * The order of the rest of the list is irrelevant for us.
> > +      * Here we only care that entries for directories appear adjacent
> > +      * to and before files underneath the directory.  In other words,
> > +      * we do not want the natural sorting of
> > +      *     foo
> > +      *     foo.txt
> > +      *     foo/bar
> > +      * Instead, we want "foo" to sort as though it were "foo/", so th=
at
> > +      * we instead get
> > +      *     foo.txt
> > +      *     foo
> > +      *     foo/bar
> > +      * To achieve this, we basically implement our own strcmp, except=
 that
> > +      * if we get to the end of either string instead of comparing NUL=
 to
> > +      * another character, we compare '/' to it.
> >        *
> > -      * To achieve this, we sort with df_name_compare and provide
> > -      * the mode S_IFDIR so that D/F conflicts will sort correctly.
> > -      * We use the mode S_IFDIR for everything else for simplicity,
> > -      * since in other cases any changes in their order due to
> > -      * sorting cause no problems for us.
> > +      * The reason to not use df_name_compare directly was that it was
> > +      * just too expensive, so I had to reimplement it.
> >        */
> > -     int cmp =3D df_name_compare(one, onelen, S_IFDIR,
> > -                               two, twolen, S_IFDIR);
> > -     /*
> > -      * Now that 'foo' and 'foo/bar' compare equal, we have to make su=
re
> > -      * that 'foo' comes before 'foo/bar'.
> > -      */
> > -     if (cmp)
> > -             return cmp;
> > -     return onelen - twolen;
> > +     const char *one =3D ((struct string_list_item *)a)->string;
> > +     const char *two =3D ((struct string_list_item *)b)->string;
>
> Casting away const, hmm. :-/  Harmless because no actual write is
> attempted, but still looks needlessly scary to me.

Right, that should have been
+     const char *one =3D ((const struct string_list_item *)a)->string;
+     const char *two =3D ((const struct string_list_item *)b)->string;
but since I was just assigning to a const char * on those lines, I'm
not sure why it'd qualify as scary.  Regardless, I'm happy to put
these consts back in.

> > +     unsigned char c1, c2;
> > +
> > +     while (*one && (*one =3D=3D *two)) {
> > +             one++;
> > +             two++;
> > +     }
> > +
> > +     c1 =3D *one;
> > +     if (!c1)
> > +             c1 =3D '/';
> > +
> > +     c2 =3D *two;
> > +     if (!c2)
> > +             c2 =3D '/';
> > +
> > +     if (c1 =3D=3D c2) {
> > +             /* Getting here means one is a leading directory of the o=
ther */
> > +             return (*one) ? 1 : -1;
> > +     }
> > +     else
> > +             return c1-c2;
> >  }
> >
> >  static int read_oid_strbuf(struct merge_options *opt,
> > @@ -3481,8 +3500,7 @@ static void process_entries(struct merge_options =
*opt,
> >       trace2_region_leave("merge", "plist copy", opt->repo);
> >
> >       trace2_region_enter("merge", "plist special sort", opt->repo);
> > -     plist.cmp =3D string_list_df_name_compare;
> > -     string_list_sort(&plist);
> > +     QSORT(plist.items, plist.nr, sort_dirs_next_to_their_children);
>
> How much does the direct use of QSORT instead of string_list_sort()
> contribute to the speedup?  (I suspect only a bit.)

Yep, I'll fix up the commit message.
