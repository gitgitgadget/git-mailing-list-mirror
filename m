Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E821200B9
	for <e@80x24.org>; Sat,  5 May 2018 13:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEEN2u (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 09:28:50 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41288 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeEEN2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 09:28:49 -0400
Received: by mail-wr0-f169.google.com with SMTP id g21-v6so23624700wrb.8
        for <git@vger.kernel.org>; Sat, 05 May 2018 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8OIJathwfKDd+wraHmdZgsuYkuD9Z3QxluVsWfwaVD4=;
        b=sxHWjA2tWimlux7syDKuDTCCGysXkB+P1xkFwB9Z8oSt5DBbPlBt7rGpB6jZRfMSzL
         tMfnFbEXs5l8duxO7JEnsI+q2k3OgUyHAvcO90VT1Nf2JBxonl1Qn7O05p9AL7peOm4A
         X7ZmstBew7L5GeZhWPH/m0V3aiOrswem6w73U/Y2EDcW7BeKXFroLGrnz37G9WId3DqE
         ilHRxPGZBWtnrVpxTrNd89X2gcw8KJOhk7ykmtkfDVLoZIXJ/Kz3ZVQ2dAVQT1hXQ3Q1
         wosVX0jaA8poud04zklEjuwhG0eM2hovK31F7G6CObzIA+YnjOa558cZSoNodwkYPzsE
         sNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8OIJathwfKDd+wraHmdZgsuYkuD9Z3QxluVsWfwaVD4=;
        b=r0dVY+4eEpn8NjbXxFelHhSII/ACNKfTgZUvKgnqThcVczjde2o6lrQkXpSmo1VxYO
         MDdoD9OnHvyAdipCmKxYgJj77Bo1ohPjl2vI6MgZ5fsTIlQBiiuOb8j642YKApA0xoUO
         DK5FtyUfPv3Vj7y/H90prrY4wQDx/7nyegNSiv9Vk5i+sxI5vsIsoM6k3V2Lhzg48CoB
         VcswCwxZ8cJsdk9esDgWOMASlekGWExQLaorNFyakkatZ5zj8biN0uGwlzaC/zJH1Gdm
         Mokhy0U/Erww50KlQQoEwWVleHG+lfWdz7bCmbTfxF6k2IqiOIiXSDJZiJRsg7UoL/eV
         0mlQ==
X-Gm-Message-State: ALQs6tCV+P5bcLB4cBIxjOj4bUuVKftqckjcVBVovU0PAZrXh1wK6Yzr
        ZJw3k6sBxEKt8HlXUqkeRw8=
X-Google-Smtp-Source: AB8JxZqKtqDOYQJ88rOkAX0cJyNSOaGag5p61PmEkw42XHsbjFHvWi9d2duLzGxNFN3dHVNdDt6mRA==
X-Received: by 2002:adf:a6f8:: with SMTP id t111-v6mr24253334wrc.161.1525526928222;
        Sat, 05 May 2018 06:28:48 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egh248.neoplus.adsl.tpnet.pl. [83.21.71.248])
        by smtp.gmail.com with ESMTPSA id y129sm3860713wmg.44.2018.05.05.06.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 May 2018 06:28:46 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo order, etc.
References: <86zi1fus3t.fsf@gmail.com> <87h8nnxio8.fsf@evledraar.gmail.com>
Date:   Sat, 05 May 2018 15:28:43 +0200
In-Reply-To: <87h8nnxio8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 04 May 2018 22:36:07 +0200")
Message-ID: <86h8nm2pv8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> On Fri, May 04 2018, Jakub Narebski wrote:
>
> (Just off-the cuff here and I'm surely about to be corrected by
> Derrick...)
>
>> * What to do about merge commits, and octopus merges in particular?
>>   Should Bloom filter be stored for each of the parents?  How to ensure
>>   fast access then (fixed-width records) - use large edge list?
>
> You could still store it fixed with, you'd just say that if you
> encounter a merge with N parents the filter wouldn't store files changed
> in that commit, but rather whether any of the N (including the merge)
> had changes to files as of the their common merge-base.

Well, that is one solution: to store union of changes (sum of changes)
from all parents of a merge commit in a Bloom filter for a merge.

But this wouldn't help us to skip merge entirely, because which parent
we would walk then?  But perhaps I am mistaken, and that does not
matter.

> Then if they did you'd need to walk all sides of the merge where each
> commit would also have the filter to figure out where the change(s)
> was/were, but if they didn't you could skip straight to the merge base
> and keep walking.

Another solution that I thought of is to use the same mechanism that
commit-graph file uses for storing merges: store Bloom filters for first
two parents, and if there are more parents (octopus merge), store Bloom
filters for the remaining parents in large edge extension for Bloom
filters.

This meant accepting some padding waste for CDAT chunk, to have faster
access.  We could do the same for Bloom filters, but it may mean quite a
bit of waste, depending on how many bits Bloom filter would use... but
there is another solution: for merge commits store Bloom filters for
first two parents that are half the size - this means of course more
false positives, but it may be acceptable solution.

> Which, on the topic of what else a commit graph could store: A mapping
> from merge commits of N parents to the merge-base of those commits.

The problem is that those N parents may have more than one merge-base,
and if so then those merge-bases may have also multiple merge-bases,
recursively (what 'recursive' merge strategy handles).  Though this
could be solved with 'large merge-base list' extension, just like
existing EDGE chunk - I think we can assume that most merge parents have
only single merge-base (but I have not checked this).

> You could also store nothing for merges (or only files the merge itself
> changed v.s. its parents). Derrick talked about how the bloom filter
> implementation has a value that's "Didn't compute (for whatever reason),
> look at it manually".

Right, another solution could be to store nothing for merges, or store
Bloom filter for changes against only first parent.  The goal of Bloom
filter is to avoid calculating diff if we don't need to.

Derrick, could you tell us what solution VSTS uses for Bloom filters on
merge commits?  Thanks in advance.

>> * Then there is problem of rename and copying detection - I think we can
>>   simply ignore it: unless someone has an idea about how to handle it?
>>
>>   Though this means that "git log --follow <file>" wouldn't get any
>>   speedup, and neither the half of "git gui blame" that runs "git blame
>>   --incremental -C -C -w" -- the one that allows code copying and
>>   movement detection.
>
> Couldn't the bloom filter also speed up --follow if you did two passes
> through the history? The first to figure out all files that ever changed
> names, and then say you did `--follow sha1-name.c` on git.git. The
> filter would have had all the bits for both sha1_name.c and sha1-name.c
> set on all commits that touched either for all of the history.
>
> Of course this would only work with a given default value of -M<n>, but
> on the assumption that most users left it at the default, and
> furthermore that renames weren't so common as to make the filter useless
> with too many false-positives as a result, it might be worth it. If you

I think it would be much simpler to just ensure that we store in Bloom
filter as changed files also pure renames, and leave doing rename
detection to the walk.  This way we do not fix old rename detecion
algorithm in stone.

The walk would simply change the name of file it would ask Bloom filters
about.

Thank you for your comments,
--=20
Jakub Nar=C4=99bski
