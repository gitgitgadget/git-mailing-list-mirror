Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745D21F404
	for <e@80x24.org>; Tue,  6 Feb 2018 12:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeBFM1j (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 07:27:39 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45104 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeBFM1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 07:27:38 -0500
Received: by mail-ot0-f194.google.com with SMTP id 73so1519920oti.12
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DeKepJofndGj2cYA4f6eWDxxz7HvIaShGq6M7wHjfE8=;
        b=csLXHtChz8ESaUlFfJmDWZYDHmsAIZWS/qysuiQIHmIiYSV+6DgeH9AiChI0JbaZID
         X6KjnKdbWYnTdGEA2Wt39AoOUHMca0anpGnn+esi/EoCJ2EuQaoK6DplIcdk4hT2egtN
         xiavnHEClGDvdJTM/SPkde3Gp6pX6jtRD2+E8sUcFjKd+CfWTftZTuM47hukC7o7IyQe
         RqV++WDABAqXaIGhgvoMYxHrfcREUaLU9OWcikipRMwWyYpVkL8WWHMPmjBypJOaH6yA
         Ua7pBKbV0Z5RljmqRvNTJBmeApJ55s6OwOk4ZzarkiyT0oJ2OvECQYGDNC96IKkCKhtu
         YFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DeKepJofndGj2cYA4f6eWDxxz7HvIaShGq6M7wHjfE8=;
        b=cu7lj39Xr2AKVhwyyYg+uBVbJkc72qj5SAvJjTUcq1UmDf3nmoL8PBjmyGO+danqnf
         EPzlXxwvXoWYJHDHeie2ygeVc53XO1fNHoYchz22wuyc/FBohTAl+Qdz5USQtwgGcs47
         X+8s4YIh1CeciM17RVHADp/YAxJtn2bD+lN0t1V+tWivWvUNICbDboDqNQVbF+kdsNmq
         3xeOCjHEQSbVirxtZVNCBReGOT71lLPFY6I9g4DDFVXraxHD3NYHcAza/QmEUgmU8j5V
         8xTVSFq/3xZR7PHkYF8MQBYXGDo0yrbZmmBXAiKUDz3jZmo8WvqE4gr2QF4qalk/8XUY
         uXzg==
X-Gm-Message-State: APf1xPCqbSgzB3lf23kc9idvrDu6G2PGFqu6hMZ808LoseIcmUyfvr/h
        3FTQWoD7tgpD96Om/wtQn4RbufARCWChlwv0MEQ=
X-Google-Smtp-Source: AH8x227cIYzfXlMqi+qrgDyOBjjM/OCo3qQVjH2SfkxLXsi66NRtf1PXtelj8KYHo7j1FG/Q38v3D1rUCcRxCDLe6dk=
X-Received: by 10.157.14.67 with SMTP id n3mr1531395otd.337.1517920057471;
 Tue, 06 Feb 2018 04:27:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 04:27:06 -0800 (PST)
In-Reply-To: <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com> <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 19:27:07 +0700
Message-ID: <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Ben Peart <peartben@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 8:48 AM, Ben Peart <peartben@gmail.com> wrote:
> With the new behavior, making a change in dir1/, then calling status would
> update the dir1/ untracked cache entry but not write it out. On the next
> status, git would detect the change in dir1/ again and update the untracked

Thing only missing piece here I would add is, this dir1/ detection is
done by watchman. We have to contact watchman and ask the set of
changed paths since $TIME where $TIME is the last time we updated
untracked cache and invalidate those paths in core. Then it should
work correctly. I checked the watchman query in the fsmonitor hook and
I think it's correct so far.

Except one point. What if you activate fsmonitor, write down the
fsmonitor_last_update field there but _not_ create UNTR extension for
the same timestamp? UNTR extension is created only when
read_directory() is executed and we don't do that in every command. I
haven't checked fsmonitor.c carefully, maybe I'm missing something.

One thing I'd like to point out in this patch is untracked cache will
start degrading if you just make the initial UNTR extension once and
don't ever update it again. Dirty paths hit slow path and will start
poking the disk. If somebody accidentally change a minor thing in
every single directory (worst case scenario), the untracked cache
becomes useless. We need a threshold or something to start repairing
UNTR extension if it gets damaged too much.

If you rely on random index updates (e.g. the main entries got updated
and .git/index must be updated) to write UNTR extension down together.
Please don't do that, at least not this way. cache_changed mask should
reflect all dirty parts in .git/index. If UNTR extension is not marked
updated, it's legit to just skip generating/writing it down (e.g. if I
kept the old UNTR extension from the last time I read .git/index
around in memory)

> cache.  All of the other cached entries are still valid and the cache would
> be used for them.  The updated cache entry for dir1/ would not get persisted
> to disk until something that required the index to be written out.
>
> The behavior is correct in both cases.  You just don't get the benefit of
> the updated cache for the dir1/ entry until the index is persisted again.
> What you gain in exchange is that you don't have to write out the index
> which is (typically) a lot more expensive than checking dir1/ for changes.

This is another thing that bugs me. I know you're talking about huge
index files, but at what size should we start this sort of
optimization? Writing down a few MBs on linux is cheap enough that I
won't bother optimizing (and I get my UNTR extension repaired all the
time, so reduced lstat calls and stuff). This "typically" only comes
at certain size, what size?
-- 
Duy
