Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C0C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1372A60F8F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhG0A4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhG0A4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:56:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C72C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 18:37:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb11so19522075ejc.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AXt7AjI7+K9K5xOSoW9pWQyQSFlFE0CquUIJlc88R/Y=;
        b=o4g2qK99JY4NYwnmlJac7ofPSFnIL/K4ALcg81TRNS8UrDglCni8ziUyiTGQ3mQq/A
         ff0sk8LiVdZLWsyJB42KN8fBYrf5jLk1s1sb1idr+eXGGj8U/burh4tSF+2uIrtNOp0S
         qCS0xx6oofPHGRuYsvPM4Oa6k6MBydMBCTqaUuOibq4XSx+VKxpuH3OlIRvRwg0lxjc3
         0wznfXA0qsZ5aNX7XsXw7GrM4WAwB1lmaPAZtUHbOZnVE1L7Crnvu5NYjkYwgRxy18VB
         jBWwiYV0jBST2egi7rMPBm4LFUjk3jVPPlak5y4LKSSAscur77s+6mOw3yeuF5rYkI6O
         VAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AXt7AjI7+K9K5xOSoW9pWQyQSFlFE0CquUIJlc88R/Y=;
        b=ZtOTtcuhvqNr29XoJ8GBwfMSwKjkfVfdJJ+/PYUBb6gfMmdrcnupWzAEUfuTSOpN5y
         /iJ+zQeZJL29CHlg6kDF0F4OwgQDLZtOw22sc0UZpD8uIXjkddD02OnAWMrKavsilLsk
         Y4gsV7W16OvSS1Ie2grFCWx6/5eoLbdKaAeV0DCi3nAYNEJxMtqrdNlHyMIG6HcRyBNR
         IGMZWIHHu7ux0bfbT1DbNzNpdqELS0jYytRDRTSviJJZsSDMduAE1NxiHqVQWFKxyv4d
         MzyR2yLkp+3Shpt4HyuRTaNv7uVODkXwmOSSAmn8dChm1YvdUu3XjA+IFV5IS1jeCqV4
         ojpg==
X-Gm-Message-State: AOAM530CgfBEkjrJiHqyLU5ucyZInLteAhLGHab5bs5KWRWOlbVGsP4g
        galaqPFwfYlCpcOUpa6QjIbzWn0LSKxS6WtqRKo=
X-Google-Smtp-Source: ABdhPJyqsJYW5SEU+End5o4s1HjZRAwSM0i9G8ut25nIYiey/xL44DIswO511ngQc5STko/dGtHMObMvObnNxsIF25U=
X-Received: by 2002:a17:906:c256:: with SMTP id bl22mr20104216ejb.115.1627349832065;
 Mon, 26 Jul 2021 18:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
 <87im0zs8wn.fsf@evledraar.gmail.com> <CAOLTT8Sbusr8=iJbG1qXcSerivZqP5xm-GS8R7TqDMh7QXSZaA@mail.gmail.com>
 <CAP8UFD1szPO-qmusSqiLRWxynV0gcy8UsnZORNn0USYAmRUGVw@mail.gmail.com>
In-Reply-To: <CAP8UFD1szPO-qmusSqiLRWxynV0gcy8UsnZORNn0USYAmRUGVw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 27 Jul 2021 09:37:44 +0800
Message-ID: <CAOLTT8TdL7UhfVSOzbpmo-WFNrcKwmy=E720tNt4KM9o_p=keg@mail.gmail.com>
Subject: Re: [GSOC] How to improve the performance of git cat-file --batch
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8826=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:38=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sun, Jul 25, 2021 at 2:04 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=885:23=E5=
=86=99=E9=81=93=EF=BC=9A
>
> > > Having skimmed it I'm a bit confused about this in reference to
> > > performance generally. I haven't looked into the case you're discussi=
ng,
> > > but as I noted in
> > > https://lore.kernel.org/git/87im1p6x34.fsf@evledraar.gmail.com/ the
> > > profiling clearly shows that the main problem is that you've added
> > > object lookups we skipped before.
> >
> > Yeah, you showed me last time that lookup_object() took up a lot of tim=
e.
>
> Could the document explain with some details why there are more calls
> to lookup_object()? For example it could take an example `git cat-file
> --batch ...` command (if possible a simple one), and say which
> functions like lookup_object() it was using (and how many times) to
> get the data it needs before using the ref-filter logic, and then the
> same information after using the ref-filter logic.
>

Sorry but this time I use gprof but can=E2=80=99t observe the same effect a=
s before.
lookup_object() is indeed a part of the time overhead, but its proportion i=
s
not very large this time.

> It could be nice if there were also some data about how much time used
> to be spent in lookup_object() and how much time is now spent there,
> and how this compares with the whole slowdown we are seeing. If =C3=86var
> already showed that, you can of course reuse what he already did.
>

This is my test for git cat-file --batch --batch-all-objects >/dev/null:

daab8a564: The fifth batch (upstream/master)

Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls   s/call   s/call  name
 38.13      0.61     0.61  1968866     0.00     0.00  patch_delta
 13.75      0.83     0.22  6568488     0.00     0.00
unpack_object_header_buffer
 11.25      1.01     0.18   344036     0.00     0.00  unpack_entry
  7.50      1.13     0.12  1964667     0.00     0.00  hashmap_remove
  6.88      1.24     0.11  6153182     0.00     0.00  hashmap_get
  1.88      1.27     0.03  7746299     0.00     0.00  zlib_post_call
  1.88      1.30     0.03   842731     0.00     0.00  bsearch_hash
  1.88      1.33     0.03   827663     0.00     0.00  nth_packed_object_off=
set
  1.25      1.35     0.02 15385422     0.00     0.00  use_pack
  1.25      1.37     0.02  6236120     0.00     0.00  get_delta_base
  1.25      1.39     0.02  2581859     0.00     0.00  git_inflate_end
  1.25      1.41     0.02   826650     0.00     0.00
do_oid_object_info_extended
  1.25      1.43     0.02   826650     0.00     0.00  find_pack_entry
  1.25      1.45     0.02   825692     0.00     0.00  packed_to_object_type
  1.25      1.47     0.02   378521     0.00     0.00  get_size_from_delta


d3b5272a94: [GSOC] cat-file: reuse ref-filter logic

Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls   s/call   s/call  name
 27.06      0.59     0.59  1968866     0.00     0.00  patch_delta
 16.51      0.95     0.36  2202293     0.00     0.00
unpack_object_header_buffer
 13.76      1.25     0.30  5327015     0.00     0.00  hashmap_get
 11.47      1.50     0.25   344036     0.00     0.00  unpack_entry
  8.72      1.69     0.19   521278     0.00     0.00  lookup_object
  4.13      1.78     0.09  1964667     0.00     0.00  hashmap_remove
  2.75      1.84     0.06   348709     0.00     0.00  get_object
  2.29      1.89     0.05        1     0.05     2.17  oid_array_for_each_un=
ique
  1.38      1.92     0.03  6373452     0.00     0.00  use_pack
  0.92      1.94     0.02  2202293     0.00     0.00  unpack_compressed_ent=
ry
  0.92      1.96     0.02  1394836     0.00     0.00  grab_sub_body_content=
s
  0.92      1.98     0.02   348709     0.00     0.00  create_object
  0.92      2.00     0.02   348709     0.00     0.00  format_ref_array_item
  0.92      2.02     0.02    74557     0.00     0.00  fill_commit_graph_inf=
o

Because we called parse_object_buffer() in get_object(), lookup_object()
is called indirectly...

We can see that some functions are called the same times: patch_delta(),
unpack_entry(), hashmap_remove()... But after using my patch,
format_ref_array_item(), grab_sub_body_contents(), get_object(), lookup_obj=
ect()
begin to occupy a certain proportion.

This is my test for git cat-file --batch-check --batch-all-objects >/dev/nu=
ll:

daab8a564: The fifth batch (upstream/master)

Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 47.83      0.11     0.11  3385670     0.00     0.00
unpack_object_header_buffer
 13.04      0.14     0.03  6941590     0.00     0.00  use_pack
  8.70      0.16     0.02  1046130     0.00     0.00  expand_format
  4.35      0.17     0.01   349013     0.00     0.00  oid_array_append
  4.35      0.18     0.01   348710     0.00     0.00  strbuf_expand
  4.35      0.19     0.01   348709     0.00     0.00  find_pack_entry
  4.35      0.20     0.01   348230     0.00     0.00  packed_to_object_type
  4.35      0.21     0.01   259719     0.00     0.00  git_inflate
  4.35      0.22     0.01        1    10.00   210.00  oid_array_for_each_un=
ique
  4.35      0.23     0.01                             pack_basename

d3b5272a94: [GSOC] cat-file: reuse ref-filter logic

Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 52.00      0.13     0.13  3385670     0.00     0.00
unpack_object_header_buffer
 16.00      0.17     0.04  6941590     0.00     0.00  use_pack
  8.00      0.19     0.02  3296680     0.00     0.00  get_delta_base
  4.00      0.20     0.01   348709     0.00     0.00  find_pack_entry
  4.00      0.21     0.01   348709     0.00     0.00  oid_to_hex
  4.00      0.22     0.01   348709     0.00     0.00  populate_value
  4.00      0.23     0.01   348230     0.00     0.00  packed_object_info
  4.00      0.24     0.01   348230     0.00     0.00  packed_to_object_type
  4.00      0.25     0.01                             void_hashcmp

Similarly, unpack_object_header_buffer(), use_pack(),
find_pack_entry(), packed_to_object_type(), they are still called same
times as before; populate_value(),
packed_object_info(), oid_to_hex() are new.

> The GIT_TRACE_PERFORMANCE, GIT_TRACE2_PERF env variables and the
> associated trace_*() and trace2_*() functions might help you with
> measuring how much time is spent in different functions.

Thanks.
--
ZheNing Hu
