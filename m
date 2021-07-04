Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87FC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 11:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7865A6127C
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 11:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGDLMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDLMx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 07:12:53 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B13C061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 04:10:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i13so14481140ilu.4
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4uKTCNGYWO71JNxSXdEO0csS4bn4VPJBE5Xsa/WZrFM=;
        b=Em4C1shf6tnduMXzVCOKFOl9gFpGiHrh55OBRRb7lbmIUU2GLviyUgkj17ExF2Xlut
         J9rBpvcF0KHcx4P4HX+MugfGnKyMPXBDKm+0wL/+7GzFYQ3npAhtjTKiVvo1kmVJDuvo
         5DuEy9SHmD0plH6Hxjw9vYnaGYQOi2G84GJnGsGKkzAv3QMqKoyyCFBDkcQbYJYNaO1K
         lZD8U70vrtHGUEGRwLi68Q7qydHj8Ba5gFG7D/ECaApzPPdSMk4rIcXsNHKXQiSRAtR7
         TNA9WRX2Ic+Bt4vWWqghOmD4WZW75emZ9oD7OYPUcMRlWxKf5WN6+Fc1HzpdOI9508i+
         BG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4uKTCNGYWO71JNxSXdEO0csS4bn4VPJBE5Xsa/WZrFM=;
        b=oeWKdC5g10d0fksswM04U6tmdCvZAPEAFYXfz8DSSAfVel3ctgsFy4Dr6BpFE3HDsm
         BG9rgnixeYz6HaY0tTQjj87dRXbDRVToxSWChiun8ZsLHxl3XrO60PVoJATa9qoIfc1O
         NqAtZ0sUI/rQe8TuKCiXFQgrvYK6ktUEvQddI+M/LEjmdopCA8HO1ZDRrNiA8avQdFXi
         hOImMHmLdEwD0H2JYL2nNPnczByjN3fyHVxu9eOTvjyx/jv3BBgJLxHLZ2krfimitU78
         aE9JYsUP0kc3TXGpEzoU5hsRMPmhIirQqMerqzovDTE48LESppEC5Ubf9BqRteft/ayD
         +e0g==
X-Gm-Message-State: AOAM533UNiIsu+voFtjujpZxvYMlaTvBmd7/eDFWvDbxHuxgU0b4CwRS
        mdNFU2OABR+tLmehhxYTf2W1A79XKC4Maq7k4DM=
X-Google-Smtp-Source: ABdhPJx1OnLgWJicPk6hkE5RB5DtqZQqSHZPL4QIgMX9nr9DJqVKcARZ86TaAkzW6fsrjFLzfLO6aCq+TRvMzcjahz4=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr6647252ilq.301.1625397017105;
 Sun, 04 Jul 2021 04:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <e04b970ccb0cad8c0b651ab11f5f52063bd84606.1625155693.git.gitgitgadget@gmail.com>
 <877di8al8n.fsf@evledraar.gmail.com> <CAOLTT8RdujpQ2uKEWPyG0HGkUz_EsONw3hEZ6YAhpmQc5rgohA@mail.gmail.com>
 <87eecf8ork.fsf@evledraar.gmail.com>
In-Reply-To: <87eecf8ork.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 4 Jul 2021 19:10:14 +0800
Message-ID: <CAOLTT8TM8b2o535S5Xvd+=__xPH+oLOTeooXSwQJjj3O1SCVSA@mail.gmail.com>
Subject: Re: [PATCH 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B47=E6=9C=883=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8810:18=E5=86=
=99=E9=81=93=EF=BC=9A

> Most of the problem, although this may not entirely fix the performance
> regression, is that you're either looking up everything twice now, or
> taking a much more expensive path.
>

Yeah, In get_object(), oid_object_info_extended() is called twice when we
want print object's contents. The original intention is to reduce the call =
of
oid_object_info_extended() once when using --textconv. Should we make
--textconv and --filters have the same logic? In this way, without using
--textconv and --filters, we can call oid_object_info_extended() only once.

> I think using gprof is probably much more handy here. See [1. I did a
> `git rev-list --all >rla` and ran that piped into 'git cat-file --batch'
> with/without your pathces. Results:
>
>     $ gprof ./git-master ./gmon-master.out | head -n 10
>     Flat profile:
>
>     Each sample counts as 0.01 seconds.
>       %   cumulative   self              self     total
>      time   seconds   seconds    calls  ms/call  ms/call  name
>      14.29      0.02     0.02   475186     0.00     0.00  nth_packed_obje=
ct_offset
>      14.29      0.04     0.02   237835     0.00     0.00  hash_to_hex_alg=
op_r
>       7.14      0.05     0.01  5220425     0.00     0.00  hashcmp_algop
>       7.14      0.06     0.01  4757120     0.00     0.00  hex2chr
>       7.14      0.07     0.01  1732023     0.00     0.00  find_entry_ptr
>
> And:
>
>     $ gprof ./git-new ./gmon-new.out |head -n 10
>     Flat profile:
>
>     Each sample counts as 0.01 seconds.
>       %   cumulative   self              self     total
>      time   seconds   seconds    calls  ms/call  ms/call  name
>       7.32      0.06     0.06   764570     0.00     0.00  lookup_object
>       7.32      0.12     0.06   237835     0.00     0.00  parse_commit_da=
te
>       4.88      0.16     0.04   712779     0.00     0.00  nth_packed_obje=
ct_offset
>       3.66      0.19     0.03   964574     0.00     0.00  bsearch_hash
>       3.66      0.22     0.03   237835     0.00     0.00  grab_sub_body_c=
ontents
>

It seems that lookup_object() took a lot of time with the patch of my versi=
on .

> If you e.g. make lookup_object() simply die when it's called you'll see
> that before we don't call it at all, after your patch it's our #1
> function.
>
> Before when we have the simplest case of writing out an object this is
> our callstack:
>
>     (gdb) bt
>     #0  batch_write (opt=3D0x7fffffffde50, data=3D0x555555ab9470, len=3D5=
2) at builtin/cat-file.c:298
>     #1  0x000055555558b160 in batch_object_write (obj_name=3D0x55555597ce=
f0 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd8c0,
>         opt=3D0x7fffffffde50, data=3D0x7fffffffd7f0) at builtin/cat-file.=
c:375
>     #2  0x000055555558b36e in batch_one_object (obj_name=3D0x55555597cef0=
 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd8c0, opt=
=3D0x7fffffffde50,
>         data=3D0x7fffffffd7f0) at builtin/cat-file.c:431
>     #3  0x000055555558b8ed in batch_objects (opt=3D0x7fffffffde50) at bui=
ltin/cat-file.c:588
>     #4  0x000055555558c0d3 in cmd_cat_file (argc=3D0, argv=3D0x7fffffffe1=
e0, prefix=3D0x0) at builtin/cat-file.c:716
>     #5  0x0000555555573adb in run_builtin (p=3D0x555555941870 <commands+2=
40>, argc=3D2, argv=3D0x7fffffffe1e0) at git.c:461
>     #6  0x0000555555573f00 in handle_builtin (argc=3D2, argv=3D0x7fffffff=
e1e0) at git.c:714
>     #7  0x0000555555574182 in run_argv (argcp=3D0x7fffffffe08c, argv=3D0x=
7fffffffe080) at git.c:781
>     #8  0x000055555557460f in cmd_main (argc=3D2, argv=3D0x7fffffffe1e0) =
at git.c:912
>     #9  0x000055555565b508 in main (argc=3D3, argv=3D0x7fffffffe1d8) at c=
ommon-main.c:52
>
> After (well, here we're not even to writing it, just looking it up), the
> BUG() is my addition:
>
>     (gdb) bt
>     #0  BUG_fl (file=3D0x5555558ade71 "object.c", line=3D91, fmt=3D0x5555=
558ade6e "yo") at usage.c:290
>     #1  0x00005555557441ca in lookup_object (r=3D0x5555559755c0 <the_repo=
>, oid=3D0x555555975160 <oi>) at object.c:91
>     #2  0x000055555569dfc8 in lookup_commit (r=3D0x5555559755c0 <the_repo=
>, oid=3D0x555555975160 <oi>) at commit.c:62
>     #3  0x00005555557445f5 in parse_object_buffer (r=3D0x5555559755c0 <th=
e_repo>, oid=3D0x555555975160 <oi>, type=3DOBJ_COMMIT, size=3D342, buffer=
=3D0x555555ab48e0,
>         eaten_p=3D0x7fffffffd36c) at object.c:215
>     #4  0x0000555555785094 in get_object (ref=3D0x7fffffffd6b0, deref=3D0=
, obj=3D0x7fffffffd520, oi=3D0x555555975160 <oi>, err=3D0x7fffffffd860) at =
ref-filter.c:1803
>     #5  0x0000555555785c99 in populate_value (ref=3D0x7fffffffd6b0, err=
=3D0x7fffffffd860) at ref-filter.c:2030
>     #6  0x0000555555785d7b in get_ref_atom_value (ref=3D0x7fffffffd6b0, a=
tom=3D0, v=3D0x7fffffffd628, err=3D0x7fffffffd860) at ref-filter.c:2064
>     #7  0x000055555578742f in format_ref_array_item (info=3D0x7fffffffd6b=
0, format=3D0x7fffffffde30, final_buf=3D0x7fffffffd880, error_buf=3D0x7ffff=
fffd860)
>         at ref-filter.c:2659
>     #8  0x000055555558ab1c in batch_object_write (obj_name=3D0x55555597e3=
f0 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd880,
>         err=3D0x7fffffffd860, opt=3D0x7fffffffde10, data=3D0x7fffffffd800=
) at builtin/cat-file.c:225
>     #9  0x000055555558ade5 in batch_one_object (obj_name=3D0x55555597e3f0=
 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd880, err=
=3D0x7fffffffd860,
>         opt=3D0x7fffffffde10, data=3D0x7fffffffd800) at builtin/cat-file.=
c:298
>     #10 0x000055555558b394 in batch_objects (batch=3D0x7fffffffde10, opti=
ons=3D0x7fffffffd900) at builtin/cat-file.c:458
>     #11 0x000055555558bbd5 in cmd_cat_file (argc=3D0, argv=3D0x7fffffffe1=
d0, prefix=3D0x0) at builtin/cat-file.c:585
>     #12 0x0000555555573adb in run_builtin (p=3D0x555555942850 <commands+2=
40>, argc=3D2, argv=3D0x7fffffffe1d0) at git.c:461
>     #13 0x0000555555573f00 in handle_builtin (argc=3D2, argv=3D0x7fffffff=
e1d0) at git.c:714
>     #14 0x0000555555574182 in run_argv (argcp=3D0x7fffffffe07c, argv=3D0x=
7fffffffe070) at git.c:781
>     #15 0x000055555557460f in cmd_main (argc=3D2, argv=3D0x7fffffffe1d0) =
at git.c:912
>     #16 0x000055555565afc1 in main (argc=3D3, argv=3D0x7fffffffe1c8) at c=
ommon-main.c:52
>

It seems that the call stack is very deep after using my version.

> I.e. before in batch_object_write() we could use a cheap path of doing
> oid_object_info_extended() and directly emitting the content. With your
> version we're all the way down to parse_object_buffer(). Meaning that
> we're going to be creating a "struct commit" or whatever if we're
> looking at a commit, just to print out the raw contents.
>

I agree that the logic in ref-filter is too complicated in order to be
able to print
the structured object data.

> I think the best next step here is to add a t/perf/t1006-cat-file.sh
> test to stress these various cases, i.e. a plain --batch without a
> format, with format, with --batch-all-objects etc. Try to then run that
> on each of your commits against the preceding one and see if/when you
> have regressions.
>

Make sence.

> Aside from any double-lookups etc, the problem is also that you're
> trying to handle a really general case (e.g. with textconv) in a

Well, "--textconv" is a common situation? Here I may not be sure which
scenarios where the upper application calls "git cat-file --batch" are the
most common.

> codepath that needs to be really fast. If anything we should be
> inserting some more more optimization shortcuts for common cases into
> it. E.g. I was able to trivially speed up 'cat-file --batch-check' on
> "master" by hardcoding a path for our default format (patch at the end
> of this mail):
>
>     # passed all 2 test(s)
>     1..2
>     Test                             origin/master     HEAD
>     ---------------------------------------------------------------------=
----
>     1006.2: cat-file --batch-check   0.60(0.37+0.23)   0.35(0.33+0.02) -4=
1.7%
>
> Anything that needs to handle general format patching is going to be
> slower. I think /some/ performance regression if we're using something
> that's not just the current light strbuf_expand() probably can't be
> avoided, but we could/should try to make up the difference at least for
> the common case of --batch or --batch-check without --textconv and
> perhaps hardcode (and document that it's faster) a path for the default
> formats).
>

Yeah, Like the hardcode in your patch may be a solution to the performance
degradation. This will indeed help those upper-level applications that use =
the
 common case.

> 1. https://sourceware.org/binutils/docs/gprof/Output.html
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5ebf13359e8..775b7dd1b01 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -360,6 +360,11 @@ static void batch_object_write(const char *obj_name,
>                                struct batch_options *opt,
>                                struct expand_data *data)
>  {
> +       int default_format =3D !strcmp(opt->format, "%(objectname) %(obje=
cttype) %(objectsize)");
> +       struct strbuf type_name =3D STRBUF_INIT;
> +       if (default_format)
> +               data->info.type_name =3D &type_name;
> +
>         if (!data->skip_object_info &&
>             oid_object_info_extended(the_repository, &data->oid, &data->i=
nfo,
>                                      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
> @@ -369,14 +374,20 @@ static void batch_object_write(const char *obj_name=
,
>                 return;
>         }
>
> -       strbuf_reset(scratch);
> -       strbuf_expand(scratch, opt->format, expand_format, data);
> -       strbuf_addch(scratch, '\n');
> -       batch_write(opt, scratch->buf, scratch->len);
> -
> -       if (opt->print_contents) {
> -               print_object_or_die(opt, data);
> -               batch_write(opt, "\n", 1);
> +       if (default_format && !opt->print_contents) {
> +               fprintf(stdout, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->o=
id),
> +                       data->info.type_name->buf,
> +                       (uintmax_t)*data->info.sizep);
> +       } else {
> +               strbuf_reset(scratch);
> +               strbuf_expand(scratch, opt->format, expand_format, data);
> +               strbuf_addch(scratch, '\n');
> +               batch_write(opt, scratch->buf, scratch->len);
> +
> +               if (opt->print_contents) {
> +                       print_object_or_die(opt, data);
> +                       batch_write(opt, "\n", 1);
> +               }
>         }
>  }
>
> diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
> new file mode 100755
> index 00000000000..a295d334715
> --- /dev/null
> +++ b/t/perf/p1006-cat-file.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +
> +test_description=3D'Basic sort performance tests'
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +
> +test_expect_success 'setup' '
> +       git rev-list --all >rla
> +'
> +
> +test_perf 'cat-file --batch-check' '
> +       git cat-file --batch-check <rla
> +'
> +
> +test_done

Thanks.
--
ZheNing Hu
