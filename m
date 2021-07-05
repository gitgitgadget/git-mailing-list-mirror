Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3ABC07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E615D611ED
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhGEH2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhGEH2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 03:28:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95400C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 00:25:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hc16so27696002ejc.12
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hjZDUxsCjj3vkjPlPG1XOWm3DIXOPmWVsRTscimdFgY=;
        b=dZhYEbKOio155FH/A+cu1ssMahIcaCpvRSKMiVEiG1oQNbcq79uWtiikoBAihzdGS8
         Z/kMUGwdCmPbmZkcyH5sLQhWnTjOx6e/4x/FWkBaxu0NtMgNd8QzVyVQu+rkqFQuUNLf
         GpQEclb2i/tKz1QernS3eyP0kl+15eFYwbhrkf3fcAzDR6tkCWqz1vQPDm7ilvsNEgtc
         0+XG02eK317UD1hqaPiiZpgiJVXMNvUaDNRk+YaU6ltuopJk3lZ5/IVt8XFagjebL4OE
         9fr6LxFgeOC+Lgw0jxM0dmDL7aB/zDjFvHiJ1sL7t7DkFPQH1PLWzQHq3gGJ2PIHX/3P
         9Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hjZDUxsCjj3vkjPlPG1XOWm3DIXOPmWVsRTscimdFgY=;
        b=mLW+SVa3RbU8qgfPIAxoDJuJZbYQhoy069uQC/MO8FPfb93YIT0sgZVXvLNabNUWPq
         0Uhcr7XWq5kxR4cKAniTq1hhHGgDnZy50moqcQ1VCYYDG8t8wTEAGL+y56inNyYhtut2
         POBUXKmv3oxbqCHXb3uvFXsuT537HX/PDfG9FfpXHXNMnbIZ1GaObPTKDW+oDT95Xm5t
         1xxqdPDPWsslZAKhQLBN3nq68/dhFZs4tVPa9WgJeTfUfXUjf97nyeHAy4AQQigNVbNh
         Ua08LXg9pdP1Jq81fHic6yk7naqxdhD0XB/42ptBEf9VKMlhDRO5vTaLV+Z/0r9oMiIA
         ciEg==
X-Gm-Message-State: AOAM531gA/5gQ8xORFGysgvuAKEf2R0cqlfiBDWa+wLckfAegh7cskxj
        uLub5UbLBqEZjqe1VcHJm+0OE6BW2+A=
X-Google-Smtp-Source: ABdhPJyrafj8hHc1ZM+2XgtH3uonzYjOO/rL7pYrWLyRo4kqcqX0uqVsC23ENwQqaKEGzi8nU33taw==
X-Received: by 2002:a17:906:388b:: with SMTP id q11mr12268414ejd.43.1625469952834;
        Mon, 05 Jul 2021 00:25:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v5sm4891543edt.55.2021.07.05.00.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:25:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/15] [GSOC] cat-file: reuse ref-filter logic
Date:   Mon, 05 Jul 2021 09:18:43 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <e04b970ccb0cad8c0b651ab11f5f52063bd84606.1625155693.git.gitgitgadget@gmail.com>
 <877di8al8n.fsf@evledraar.gmail.com>
 <CAOLTT8RdujpQ2uKEWPyG0HGkUz_EsONw3hEZ6YAhpmQc5rgohA@mail.gmail.com>
 <87eecf8ork.fsf@evledraar.gmail.com>
 <CAOLTT8TM8b2o535S5Xvd+=__xPH+oLOTeooXSwQJjj3O1SCVSA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAOLTT8TM8b2o535S5Xvd+=__xPH+oLOTeooXSwQJjj3O1SCVSA@mail.gmail.com>
Message-ID: <87im1p6x34.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 04 2021, ZheNing Hu wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B47=E6=9C=883=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8810:18=E5=
=86=99=E9=81=93=EF=BC=9A
>
>> Most of the problem, although this may not entirely fix the performance
>> regression, is that you're either looking up everything twice now, or
>> taking a much more expensive path.
>>
>
> Yeah, In get_object(), oid_object_info_extended() is called twice when we
> want print object's contents. The original intention is to reduce the cal=
l of
> oid_object_info_extended() once when using --textconv. Should we make
> --textconv and --filters have the same logic? In this way, without using
> --textconv and --filters, we can call oid_object_info_extended() only onc=
e.
>
>> I think using gprof is probably much more handy here. See [1. I did a
>> `git rev-list --all >rla` and ran that piped into 'git cat-file --batch'
>> with/without your pathces. Results:
>>
>>     $ gprof ./git-master ./gmon-master.out | head -n 10
>>     Flat profile:
>>
>>     Each sample counts as 0.01 seconds.
>>       %   cumulative   self              self     total
>>      time   seconds   seconds    calls  ms/call  ms/call  name
>>      14.29      0.02     0.02   475186     0.00     0.00  nth_packed_obj=
ect_offset
>>      14.29      0.04     0.02   237835     0.00     0.00  hash_to_hex_al=
gop_r
>>       7.14      0.05     0.01  5220425     0.00     0.00  hashcmp_algop
>>       7.14      0.06     0.01  4757120     0.00     0.00  hex2chr
>>       7.14      0.07     0.01  1732023     0.00     0.00  find_entry_ptr
>>
>> And:
>>
>>     $ gprof ./git-new ./gmon-new.out |head -n 10
>>     Flat profile:
>>
>>     Each sample counts as 0.01 seconds.
>>       %   cumulative   self              self     total
>>      time   seconds   seconds    calls  ms/call  ms/call  name
>>       7.32      0.06     0.06   764570     0.00     0.00  lookup_object
>>       7.32      0.12     0.06   237835     0.00     0.00  parse_commit_d=
ate
>>       4.88      0.16     0.04   712779     0.00     0.00  nth_packed_obj=
ect_offset
>>       3.66      0.19     0.03   964574     0.00     0.00  bsearch_hash
>>       3.66      0.22     0.03   237835     0.00     0.00  grab_sub_body_=
contents
>>
>
> It seems that lookup_object() took a lot of time with the patch of my ver=
sion .
>
>> If you e.g. make lookup_object() simply die when it's called you'll see
>> that before we don't call it at all, after your patch it's our #1
>> function.
>>
>> Before when we have the simplest case of writing out an object this is
>> our callstack:
>>
>>     (gdb) bt
>>     #0  batch_write (opt=3D0x7fffffffde50, data=3D0x555555ab9470, len=3D=
52) at builtin/cat-file.c:298
>>     #1  0x000055555558b160 in batch_object_write (obj_name=3D0x55555597c=
ef0 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd8c0,
>>         opt=3D0x7fffffffde50, data=3D0x7fffffffd7f0) at builtin/cat-file=
.c:375
>>     #2  0x000055555558b36e in batch_one_object (obj_name=3D0x55555597cef=
0 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd8c0, opt=
=3D0x7fffffffde50,
>>         data=3D0x7fffffffd7f0) at builtin/cat-file.c:431
>>     #3  0x000055555558b8ed in batch_objects (opt=3D0x7fffffffde50) at bu=
iltin/cat-file.c:588
>>     #4  0x000055555558c0d3 in cmd_cat_file (argc=3D0, argv=3D0x7fffffffe=
1e0, prefix=3D0x0) at builtin/cat-file.c:716
>>     #5  0x0000555555573adb in run_builtin (p=3D0x555555941870 <commands+=
240>, argc=3D2, argv=3D0x7fffffffe1e0) at git.c:461
>>     #6  0x0000555555573f00 in handle_builtin (argc=3D2, argv=3D0x7ffffff=
fe1e0) at git.c:714
>>     #7  0x0000555555574182 in run_argv (argcp=3D0x7fffffffe08c, argv=3D0=
x7fffffffe080) at git.c:781
>>     #8  0x000055555557460f in cmd_main (argc=3D2, argv=3D0x7fffffffe1e0)=
 at git.c:912
>>     #9  0x000055555565b508 in main (argc=3D3, argv=3D0x7fffffffe1d8) at =
common-main.c:52
>>
>> After (well, here we're not even to writing it, just looking it up), the
>> BUG() is my addition:
>>
>>     (gdb) bt
>>     #0  BUG_fl (file=3D0x5555558ade71 "object.c", line=3D91, fmt=3D0x555=
5558ade6e "yo") at usage.c:290
>>     #1  0x00005555557441ca in lookup_object (r=3D0x5555559755c0 <the_rep=
o>, oid=3D0x555555975160 <oi>) at object.c:91
>>     #2  0x000055555569dfc8 in lookup_commit (r=3D0x5555559755c0 <the_rep=
o>, oid=3D0x555555975160 <oi>) at commit.c:62
>>     #3  0x00005555557445f5 in parse_object_buffer (r=3D0x5555559755c0 <t=
he_repo>, oid=3D0x555555975160 <oi>, type=3DOBJ_COMMIT, size=3D342, buffer=
=3D0x555555ab48e0,
>>         eaten_p=3D0x7fffffffd36c) at object.c:215
>>     #4  0x0000555555785094 in get_object (ref=3D0x7fffffffd6b0, deref=3D=
0, obj=3D0x7fffffffd520, oi=3D0x555555975160 <oi>, err=3D0x7fffffffd860) at=
 ref-filter.c:1803
>>     #5  0x0000555555785c99 in populate_value (ref=3D0x7fffffffd6b0, err=
=3D0x7fffffffd860) at ref-filter.c:2030
>>     #6  0x0000555555785d7b in get_ref_atom_value (ref=3D0x7fffffffd6b0, =
atom=3D0, v=3D0x7fffffffd628, err=3D0x7fffffffd860) at ref-filter.c:2064
>>     #7  0x000055555578742f in format_ref_array_item (info=3D0x7fffffffd6=
b0, format=3D0x7fffffffde30, final_buf=3D0x7fffffffd880, error_buf=3D0x7fff=
ffffd860)
>>         at ref-filter.c:2659
>>     #8  0x000055555558ab1c in batch_object_write (obj_name=3D0x55555597e=
3f0 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd880,
>>         err=3D0x7fffffffd860, opt=3D0x7fffffffde10, data=3D0x7fffffffd80=
0) at builtin/cat-file.c:225
>>     #9  0x000055555558ade5 in batch_one_object (obj_name=3D0x55555597e3f=
0 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd880, err=
=3D0x7fffffffd860,
>>         opt=3D0x7fffffffde10, data=3D0x7fffffffd800) at builtin/cat-file=
.c:298
>>     #10 0x000055555558b394 in batch_objects (batch=3D0x7fffffffde10, opt=
ions=3D0x7fffffffd900) at builtin/cat-file.c:458
>>     #11 0x000055555558bbd5 in cmd_cat_file (argc=3D0, argv=3D0x7fffffffe=
1d0, prefix=3D0x0) at builtin/cat-file.c:585
>>     #12 0x0000555555573adb in run_builtin (p=3D0x555555942850 <commands+=
240>, argc=3D2, argv=3D0x7fffffffe1d0) at git.c:461
>>     #13 0x0000555555573f00 in handle_builtin (argc=3D2, argv=3D0x7ffffff=
fe1d0) at git.c:714
>>     #14 0x0000555555574182 in run_argv (argcp=3D0x7fffffffe07c, argv=3D0=
x7fffffffe070) at git.c:781
>>     #15 0x000055555557460f in cmd_main (argc=3D2, argv=3D0x7fffffffe1d0)=
 at git.c:912
>>     #16 0x000055555565afc1 in main (argc=3D3, argv=3D0x7fffffffe1c8) at =
common-main.c:52
>>
>
> It seems that the call stack is very deep after using my version.
>
>> I.e. before in batch_object_write() we could use a cheap path of doing
>> oid_object_info_extended() and directly emitting the content. With your
>> version we're all the way down to parse_object_buffer(). Meaning that
>> we're going to be creating a "struct commit" or whatever if we're
>> looking at a commit, just to print out the raw contents.
>>
>
> I agree that the logic in ref-filter is too complicated in order to be
> able to print
> the structured object data.

Well, maybe it isn't. I think the main problem with your performance is
just looking things up again from the object store needlessly, and
possibly redundantly copying things around. E.g. if you have a buffer
with a commit object and you need to xstrdup() that, and xstrdup() the
answer etc, it adds up.

Maybe if all that's gone the formatting will still slow things down, but
I bet it's going to be to a much smaller extent.

>> I think the best next step here is to add a t/perf/t1006-cat-file.sh
>> test to stress these various cases, i.e. a plain --batch without a
>> format, with format, with --batch-all-objects etc. Try to then run that
>> on each of your commits against the preceding one and see if/when you
>> have regressions.
>>
>
> Make sence.
>
>> Aside from any double-lookups etc, the problem is also that you're
>> trying to handle a really general case (e.g. with textconv) in a
>
> Well, "--textconv" is a common situation? Here I may not be sure which
> scenarios where the upper application calls "git cat-file --batch" are the
> most common.

I think --textconv is much rarer. I think it's used for API purposes
e.g. for people who are doing \n translation, or maybe for the likes of
git-lfs (or was that --filters)? I'm not very familiar with it.

For what it's worth 'git cat-file --batch' is very performance sensitive
in backend use-cases like e.g. gitlab.com's gitaly (which executes all
git commands for you on that site). Anything that looks up .. any object
pretty much .. is prining that object line to a persistent "cat-file
--batch" process.

There was a case where some very small (unrelated to cat-file per-se)
slowdown in that codepath ended up slowing down overall API requests for
some calls by >100%, because it's executed in a tight loop. E.g. if
you're showing N commits per page that might be N cat-file --batch
calls.
