Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500FAC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 17:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08413207DF
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 17:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1Nbc7v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgH1RVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgH1RUy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 13:20:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E72C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 10:20:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so1506285otp.12
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFSVVLWkP9vk8o4Ls61rYZ4KfgHv8AWRLlkmMzG3koc=;
        b=G1Nbc7v0mums6nDxAU2vEc5Ck376fnZR/RDJNmF9RUCGSSkmhLDF0137rmZJG3ATlP
         BGn0LST8/LTg95dCy7TuQCG6GAnksWDkZrIB3hhemo9xoN9N2fghJ2C3K6dbwSdPd+0V
         DdT9Y+ppd+jNmDrh7O5aY/W/1k49aBd7l7dMB+P9cYYJwsF7g5RnHchB6BchVXCdSYS4
         CcyjvuGKS6nWpCpikXGk7KjXNC+yPdzfwvSQUv0QUcZERxkF/ARmv8ySo3/rpJT6ykv6
         p9KMkJKKjH14TUtGZTKez1Qbt6cH6m4KkZJTw665pNCejx9Nt2r4LLH4So1hgCKpfe6r
         y+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFSVVLWkP9vk8o4Ls61rYZ4KfgHv8AWRLlkmMzG3koc=;
        b=AOS3WCuDyjl7HrAVrK+L32z28prN6/4IVqi7I9KvKYHpgDNqimhVGGGRI32koVX59r
         ZTt4jBL1Aszy0Rt+3REBuAcnpJmquQtsNSqv4GfN5s0z4xk3P/ylJdNDUdg/lh6W1Sww
         NlEZqeO8Zy1QFywR7Q+SAEFFxmwA/arR+XlEGzYkt2a3+wHjJ26WHSEUm7AvfkGYwcLD
         GFLvz0vAxPqaePVN1SVVlNl6jORxdUwGR3MZ/JdW80n7XXAH0N1KCwxxJRJ5Q8NpSD/o
         z8ZIgZMfbOgLmCWpaqgdwG1PxX1p5KnQXXlb/BkYWW4av8DomQK2Nbtn4fdvbB9P0JrX
         BCdg==
X-Gm-Message-State: AOAM5330V1TVVysxeqXPVTONDrgKDSbBevwWNdtA9n4rvOWCVN3+HagZ
        7Pu9vvATqRZcFwr/WNm6cn79w84Hc02VzYwSXis=
X-Google-Smtp-Source: ABdhPJzEDapSaEYumsl2LcWT8re/IM1byaERAzNjyCtx59hDrv8jQr48fsbIpExaSGfEW8B+hkULzTNk0I8o1PbI+p4=
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr1959036otp.162.1598635251885;
 Fri, 28 Aug 2020 10:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
 <20200821200121.GF1165@coredump.intra.peff.net> <CABPp-BGJK4C7U+-MB-+TUgFAuuFJKE-E7y17FFJDRTyFydVX2A@mail.gmail.com>
 <20200821210301.GA11806@coredump.intra.peff.net> <CABPp-BE8tdpjx2RBGyZOYV4hsfjm5HF_dmehvX792x7TtWkLcA@mail.gmail.com>
 <20200828070802.GC2105050@coredump.intra.peff.net>
In-Reply-To: <20200828070802.GC2105050@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Aug 2020 10:20:40 -0700
Message-ID: <CABPp-BFL_f4ee=NrfKwVEcLzuCZy7pfXOTLimp5Qn3P89RYfpA@mail.gmail.com>
Subject: Re: [PATCH 4/5] strmap: add strdup_strings option
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 12:08 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 21, 2020 at 03:25:44PM -0700, Elijah Newren wrote:
>
> > >   - That sounds like a lot of maps. :) I guess you've looked at
> > >     compacting some of them into a single map-to-struct?
> >
> > Oh, map-to-struct is the primary use.  But compacting them won't work,
> > because the reason for the additional maps is that they have different
> > sets of keys (this set of paths meet a certain condition...).  Only
> > one map contains all the paths involved in the merge.
>
> OK, I guess I'm not surprised that you would not have missed such an
> obvious optimization. :)
>
> > Also, several of those maps don't even store a value; and are really
> > just a set implemented via strmap (thus meaning the only bit of data I
> > need for some conditions is whether any given path meets it).  It
> > seems slightly ugly to have to call strmap_put(map, string, NULL) for
> > those.  I wonder if I should have another strset type much like your
> > suggesting for strintmap.  Hmm...
>
> FWIW, khash does have a "set" mode where it avoids allocating the value
> array at all.

Cool.

> What's the easiest way to benchmark merge-ort?

Note that I discovered another optimization that I'm working on
implementing; when finished, it should cut down a little more on the
time spent on inexact rename detection.  That should have the side
effect of having the time spent on strmaps stick out some more in the
overall timings (as a percentage of overall time anyway).  So, I'm
focused on that before I do other benchmarking work (which is part of
the reason I mentioned my strmap/hashmap benchmarking last week might
take a while).

Anyway, on to your question:

=== If you just want to be able to run the ort merge algorithm ===

Clone git@github.com:newren/git and checkout the 'ort' branch and
build it.  It currently changes the default merge algorithm to 'ort'
and even ignores '-s recursive' by remapping it to '-s ort' (because I
wanted to see how regression tests fared with ort as a replacement for
recrusive).  It should pass the regression tests if you want to run
those first.  But note that if you want to compare 'ort' to
'recursive', then currently you need to have two different git builds,
one of my branch and one with a different checkout of something else
(e.g. 2.28.0 or 'master' or whatever).

=== Decide the granularity of your timing ===

I suspect you know more than me here, but maybe my pointers are useful anyway...

Decide if you want to measure overall program runtime, or dive into
details.  I used both a simple 'time' and the better 'hyperfine' for
the former, and used both 'perf' and GIT_TRACE2_PERF for the latter.
One nice thing about GIT_TRACE2_PERF was I wrote a simple program to
aggregate the times per region and provide percentages, in a script at
the toplevel named 'summarize-perf' that I can use to prefix commands.
Thus, I could for example run from my linux clone:
    $ ../git/summarize-perf git fast-rebase --onto HEAD base hwmon-updates
and I'd get output that looks something like (note that this is a
subset of the real output):
    1.400 : 35 : label:inmemory_nonrecursive
       0.827 : 41 : ..label:renames
          0.019 : <unmeasured> ( 2.2%)
          0.803 : 37 : ....label:regular renames
          0.004 : 31 : ....label:directory renames
          0.001 : 31 : ....label:process renames
       0.513 : 41 : ..label:collect_merge_info
       0.048 : 35 : ..label:process_entries
    0.117 : 1 : label:checkout
    0.000 : 1 : label:record_unmerged
and where those fields are <time> : <count> : <region label>.

=== If you want to time the testcases I used heavily while developing ===

The rebase-testcase/redo-timings script (in the ort branch) has
details on what I actually ran, though it has some paranoia around
attempting to make my laptop run semi-quietly and try to avoid all the
variance that I wished I could control a bit better.  And it assumes
you are running in a linux clone with a few branches set up a certain
way.  Let me explain those tests without using that script, as simply
as I can:

The setup for the particular cases I was testing is as follows:
  * Clone the linux kernel, and run the following:
  $ git branch hwmon-updates fd8bdb23b91876ac1e624337bb88dc1dcc21d67e
  $ git branch hwmon-just-one fd8bdb23b91876ac1e624337bb88dc1dcc21d67e~34
  $ git branch base 4703d9119972bf586d2cca76ec6438f819ffa30e
  $ git switch -c 5.4-renames v5.4
  $ git mv drivers pilots
  $ git commit -m "Rename drivers/ to pilots/"

And from there, there were three primary tests I was comparing:

  * Rename testcase, 35 patches:
  $ git checkout 5.4-renames^0
  $ git fast-rebase --onto HEAD base hwmon-updates

  * Rename testcase, just 1 patch:
  $ git switch 5.4-renames^0
  $ git fast-rebase --onto HEAD base hwmon-just-one

  * No renames (or at least very few renames) testcase, 35 patches:
  $ git checkout v5.4^0
  $ git branch -f hwmon-updates
fd8bdb23b91876ac1e624337bb88dc1dcc21d67e # Need to reset
hwmon-updates, due to fast-rebase done above
  $ git fast-rebase --onto HEAD base hwmon-updates

(If you want to compare with 'recursive' from a different build of
git, just replace 'fast-rebase' with 'rebase'.  You can also use
'rebase' instead of 'fast-rebase' on the ort branch and it'll use the
ort merge algorithm, but you get all the annoying
working-tree-updates-while-rebasing rather than just having the
working tree updated at the end of the rebase.  You also get all the
annoying forks of 'git checkout' and 'git commit' that sequencer is
guilty of spawning.  But it certainly supports a lot more options and
can save state to allow resuming after conflicts, unlike
'fast-rebase'.)

> I suspect I could swap out hashmap for khash (messily) in an hour or less.

Well, you might be assuming I used sane strmaps, with each strmap
having a fixed type for the stored value.  That's mostly true, but
there were two counterexamples I can think of: "paths" (the biggest
strmap) is a map of string -> {merged_info OR conflict_info}, because
merged_info is a smaller subset of conflict_info and saves space for
each path that can be trivially merged.  Also, in diffcore-rename,
"dir_rename" starts life as a map of string -> strmap, but later
transitions to string -> string, because I'm evil and didn't set up a
temporary strmap like I probably should have.

Also, the code is littered with FIXME comments, unnecessary #ifdefs,
and is generally in need of lots of cleanup.  Sorry.
