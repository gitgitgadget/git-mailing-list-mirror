Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275E01F454
	for <e@80x24.org>; Fri, 18 Jan 2019 08:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfARIg6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 03:36:58 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:37717 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfARIg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 03:36:57 -0500
Received: by mail-ed1-f46.google.com with SMTP id h15so10512641edb.4
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 00:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6MjUWg9CBqHEThbJ7YHBcdRogwG7aa8LYPcdWEjVBYY=;
        b=iyiOrEG41nEiIGvgXZEIbHJwRlJ0hXtnP7r7qsE+B/rIfgBECjeZuKLN0ZkA8D8pVs
         QN55FjClGB6cdk8JwCCNhw9xztEzZou24SVQYmWsNgIo78/aacjx56MyI+L6JK+pDp59
         FbUuZuInyvHy51cvItPjtG+46zWHH3w9zALhK1fEp7hlAvwYI6SFV1AsE9rOQyRwWlvy
         UaqmK60Wq9IIa2nsml1qzmbDyfLdcR2wQZtFNJO7WRBBzM8dyHvW0mUQB7JW5UmxQ5Re
         IIhooEO2NfnvlHIqOeKGkJSc/WQmDFSq3oIJ4O2ZNYmWvHaLTLzWb88EfushKu4ahRmX
         USCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6MjUWg9CBqHEThbJ7YHBcdRogwG7aa8LYPcdWEjVBYY=;
        b=gJEOt+QM3W+8ZawGpyyCeNAL+2hreg3SEKumkX/gS8WcakiTAi9f05p6kklIH4KR0c
         uHjqWW00uxtdrbI0L5ndEnqmnkgXXaSYOYKzf/wdfc4ziMPpi7QEk7X+UWjCAAeKk+UM
         zgZaJLP0r+GGlwQJpIRO/K3TK12BTh2v/3pGizoDc2r+aqFyn6cNSxd3Ig4DbSROtrJh
         z8Zvj4x2+iIEACghNkeQxxAc+7Q2jZ6VkN3z3+69Io9cjLzquHiOWmPrSPKUwA16vroi
         cmt2t//rB9mE+w504VXUVR4mHNBYOX6eOlcr0NesYs4n/dnfV+G9gm8MKRRiVihNjuzL
         Hk1A==
X-Gm-Message-State: AJcUukdXfezj4uhW7h23Mz0TDJxCS+PVkT5sbkHecNIuN5S7gMLeMGlA
        0UKPzebjXTdo1FPqi0ZWamXqMoJG2Fw=
X-Google-Smtp-Source: ALg8bN6gMLIiVUIqY5vLauSj3iINyefgGNtiJQl5T7kWZ0QfiJDvmQoS+JRV+Dc5ZkXjclR5wPWpjA==
X-Received: by 2002:a50:d643:: with SMTP id c3mr3998894edj.178.1547800615924;
        Fri, 18 Jan 2019 00:36:55 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d15-v6sm3854308ejc.31.2019.01.18.00.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 00:36:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Farhan Khan <khanzf@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Calculate packfile and idxfile checksums
References: <CAFd4kYAbrUcV2U1u6Fz3VgZDN_YcpLrSymeA5bvvLy1LY98aHA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAFd4kYAbrUcV2U1u6Fz3VgZDN_YcpLrSymeA5bvvLy1LY98aHA@mail.gmail.com>
Date:   Fri, 18 Jan 2019 09:36:54 +0100
Message-ID: <87lg3i4b15.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 18 2019, Farhan Khan wrote:

> Hi all,
>
> I am trying to understand how git's index-pack works, particularly how
> it calculates the packfile checksum and idxfile checksum.

It's unclear if this is what you're asking, but the pack checksum is
just a 20 bytes of SHA1 of the preceding contents at the end for *.idx
and *.pack. As seen with this program:

    $ perl -MFile::Slurp=slurp -MDigest::SHA=sha1 -wE 'my $f = shift; my $c = slurp($f); my $cp = $c; $cp =~ s/.{20}$//s; my $n = $cp . sha1($cp); if ($n eq $c) { say "Computed checksum trailer for $f" } else { say "Failed trailer for new content for $f is different" }' pack-79c2ccce950e6676452dc9f0473f80003e7ccdef.idx
    Computed checksum trailer for pack-79c2ccce950e6676452dc9f0473f80003e7ccdef.idx

You can also feed it *.pack files.

> I traced back the packfile checksum in the source to the value char
> *sha1 that is utilized in write_idx_file() in pack_file.c:45. However,
> I cannot

It seems you mean pack-write.c not pack_file.c

> determine where this value is set.

It's initialized in cmd_index_pack() and then passed down to that
function.

> My printf() debugging has it set at pack-write.c:171 (right before the
> hashwrite call) but it does not seem to be utilized prior to that
> point. Please assist.

I'm happy to help, but still not quite sure what the source of the
confusion is, maybe that the variable in index-pack.c has a different
name and is passed down to pack-write.c's function as a pointer?
