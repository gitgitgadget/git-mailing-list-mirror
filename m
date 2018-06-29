Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475FA1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 20:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935626AbeF2UPF (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 16:15:05 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45136 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932263AbeF2UPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 16:15:04 -0400
Received: by mail-yw0-f196.google.com with SMTP id v190-v6so4050982ywa.12
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeQfannHBq8C2fbB6ocPeLJNFgl850r6lUmsVC37PmY=;
        b=dnmiKUKwQabuKvDzDP7Nv8pi+P+D/XKp++DDW62kiaz7AE76HTQZSgbsNzrWsHXozC
         pV+1Dw29NQ1ki0ySsAafXEP5aRhWyFaqkBk9tLwbdkgc6DVHUz4nEbrhlQK+Jz9pSgl4
         pfOT4Kw5HPUQEnqpSYRM4hZCgjIRn467uZ9aJcYMeIx95rohJCUSKpOX7M9NKCVuipYc
         BMYJJwHTjjGa5ovV5TZDyJDoE/mBDZ8hc3NNhAuWT8F/o/34iF769LXvce3JvZNmiR75
         aiGW3FGeyxnwWVrZEVe/EWtdOYykocHxO3ePyBQ/0QNioKmQ2Bhkl52p1ybgEYSb09RV
         saDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeQfannHBq8C2fbB6ocPeLJNFgl850r6lUmsVC37PmY=;
        b=VdR8GuzaXClQpxhlqrLwo2jNKwIKuoHSGzCNwXj7kXCuj/lGAqZgtOgLLDNfL5Wztr
         n8EvpHNjzCPHjpMEm5Bp+J6s3yshRv83PEYfoO/FH0I3eEEEFkgwSlx3ArMsX8WueUnZ
         msdZk0xvRhpScq5CTrj0vN7zMEbVT9rsIpNZwZpaOAkunQxN0h9G8YqXJTKGpgMLYMro
         Cu3QZiB1ahWKqTmPXOaQTwoXykduQ6kqOeHWCnCwqSDXlmB/VIRsQQq3mCPURQKXU8nm
         mbaUUjRimQnCFHWCVTh2AF9dpWryWldsVLiB9q68llc3XxGuwiQnw5yK/aP8jik0Kv3C
         l/gQ==
X-Gm-Message-State: APt69E01KT0kLRAu0Y/LAykId9w0GSH79McoyXwzx4D9zDkbKxy981wa
        0lKGJdGpGsGD8UQ3k8hlZicRpUy87cHW2yECyoOE6SxCWQo=
X-Google-Smtp-Source: AAOMgpc4NHTlbpwPOoBtlw27v+OW8B5bn+1NfRYvF4a/K2hvQaD7n3TCUDdhj9yCtSIBIRQpjH8dBsilelIhD/oTLX8=
X-Received: by 2002:a0d:d304:: with SMTP id v4-v6mr7987587ywd.500.1530303303638;
 Fri, 29 Jun 2018 13:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180629094413.bgltep6ntlza6vhz@glandium.org>
In-Reply-To: <20180629094413.bgltep6ntlza6vhz@glandium.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 13:14:52 -0700
Message-ID: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
Subject: Re: fast-import slowness when importing large files with small differences
To:     Mike Hommey <mh@glandium.org>,
        Jameson Miller <jamill@microsoft.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 3:18 AM Mike Hommey <mh@glandium.org> wrote:
>
> Hi,
>
> I noticed some slowness when fast-importing data from the Firefox mercurial
> repository, where fast-import spends more than 5 minutes importing ~2000
> revisions of one particular file. I reduced a testcase while still
> using real data. One could synthesize data with kind of the same
> properties, but I figured real data could be useful.

I cc'd Jameson, who refactored memory allocation in fast-import recently.
(I am not aware of other refactorings in the area of fast-import)

> To reproduce:
[...]
> Memory total:          2282 KiB
>        pools:          2048 KiB
>      objects:           234 KiB
>
[...]
> Obviously, sha1'ing 26GB is not going to be free, but it's also not the
> dominating cost, according to perf:
>
>     63.52%  git-fast-import  git-fast-import     [.] create_delta_index

So this doesn't sound like a memory issue, but a diffing/deltaing issue.

> So maybe it would make sense to consolidate the diff code (after all,
> diff-delta.c is an old specialized fork of xdiff). With manual trimming
> of common head and tail, this gets down to 3:33.

This sounds interesting. I'd love to see that code to be unified.

> I'll also note that Facebook has imported xdiff from the git code base
> into mercurial and improved performance on it, so it might also be worth
> looking at what's worth taking from there.

So starting with
https://www.mercurial-scm.org/repo/hg/rev/34e2ff1f9cd8
("xdiff: vendor xdiff library from git")
they adapted it slightly:
$ hg log --template '{node|short} {desc|firstline}\n' --
mercurial/thirdparty/xdiff/
a2baa61bbb14 xdiff: move stdint.h to xdiff.h
d40b9e29c114 xdiff: fix a hard crash on Windows
651c80720eed xdiff: silence a 32-bit shift warning on Windows
d255744de97a xdiff: backport int64_t and uint64_t types to Windows
e5b14f5b8b94 xdiff: resolve signed unsigned comparison warning
f1ef0e53e628 xdiff: use int64 for hash table size
f0d9811dda8e xdiff: remove unused xpp and xecfg parameters
49fe6249937a xdiff: remove unused flags parameter
882657a9f768 xdiff: replace {unsigned ,}long with {u,}int64_t
0c7350656f93 xdiff: add comments for fields in xdfile_t
f33a87cf60cc xdiff: add a preprocessing step that trims files
3cf40112efb7 xdiff: remove xmerge related logic
90f8fe72446c xdiff: remove xemit related logic
b5bb0f99064d xdiff: remove unused structure, functions, and constants
09f320067591 xdiff: remove whitespace related feature
1f9bbd1d6b8a xdiff: fix builds on Windows
c420792217c8 xdiff: reduce indent heuristic overhead
b3c9c483cac9 xdiff: add a bdiff hunk mode
9e7b14caf67f xdiff: remove patience and histogram diff algorithms
34e2ff1f9cd8 xdiff: vendor xdiff library from git

Interesting pieces regarding performance:

c420792217c8 xdiff: reduce indent heuristic overhead
https://phab.mercurial-scm.org/rHGc420792217c89622482005c99e959b9071c109c5

f33a87cf60cc xdiff: add a preprocessing step that trims files
https://phab.mercurial-scm.org/rHGf33a87cf60ccb8b46e06b85e60bc5031420707d6

I'll see if I can make that into patches.

Thanks,
Stefan
