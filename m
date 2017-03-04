Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F21EC20279
	for <e@80x24.org>; Sat,  4 Mar 2017 08:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbdCDIzt (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 03:55:49 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35441 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdCDIzs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 03:55:48 -0500
Received: by mail-yw0-f169.google.com with SMTP id v198so8893437ywc.2
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 00:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TXc5y531g206yVJzOL5zUCSoMqM/gqXnPumCVK839NA=;
        b=LxiMWqK9QR4apBQXUzpxqyz6QQHqqyaP8cfOdRKISqfVrVUuMb8P5SBUz7uc9U1wIO
         wVh56CMBpN23EDPgQ1EN5gidKKWg08AIaXf0o8xebRAEVmoF134PnAfLtAHE0xjp4scg
         qiyvPMeovGANFe0hfBEfcuS47VHGHocTI/XFgH7mmLMzOQKynzKCodBUZHs1SfF2g7m0
         RN817jUjnzQaJQQeUfN3MT19LaBfE7HCbux+WhyMrc0TVrX3eD6IiJQz6PezbiNp34l6
         Mk8Eq7g8MblJIRxIeK0AQfWJE9Ym4LrUw02anAWxsiZdElPC+C1USt4Mc1Z/bBgm7eVh
         7qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TXc5y531g206yVJzOL5zUCSoMqM/gqXnPumCVK839NA=;
        b=aP1ijWQm/XB0hVSBOhaZ1RJOELgmjhxWWfROzQCSXQhbKxl75YskikDSZWlaD5ey6a
         k5PZKkB6wztZ5emIbUeGMRb+Au/LBSI9CqFLJxSgksttV3mmOgp2ZwmWbCW98QATbJ2f
         Wr/LfiVqSWOlX0w8uL11K/20rIcucBvyPdgpGQOlWJZPuGOJ1bpG0xOViRRSeLO9NqMD
         6GNooTVr4wNEVBEGslLnxwde2kzgmivZpg6Iq4FdsFy3NTYm3aSOctVMx/Kiu8Uvb0BZ
         FrMHSy+trYAjyD8EfXmNEm3e9hOIJhGwpvJ33XRYU/hbqX9fQ2IPHng50ShBcrc78kaf
         ndBA==
X-Gm-Message-State: AMke39n/KSgIpueLPepYe2xn54dg5SbLSNvaf8Fzx/NzgNRTqv5Z3VdYRjacxFqqXn1i0w==
X-Received: by 10.129.130.1 with SMTP id s1mr4358616ywf.132.1488616019377;
        Sat, 04 Mar 2017 00:26:59 -0800 (PST)
Received: from [192.168.55.233] (c-98-197-16-64.hsd1.tx.comcast.net. [98.197.16.64])
        by smtp.gmail.com with ESMTPSA id n185sm5475305ywe.17.2017.03.04.00.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Mar 2017 00:26:58 -0800 (PST)
From:   Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: Delta compression not so effective
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
 <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com>
 <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
 <603afdf2-159c-6bed-0e85-2824391185d1@gmail.com>
 <CA+55aFxxQUixAJWXkUgVvDNCHD4LuYYuQRTE7dJ_OZTo9Gxqew@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <9961a973-0d5d-5ff9-ab78-eea07bdb5dbf@gmail.com>
Date:   Sat, 4 Mar 2017 02:27:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFxxQUixAJWXkUgVvDNCHD4LuYYuQRTE7dJ_OZTo9Gxqew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2017 18:43, Linus Torvalds wrote:
>> So, this repo must be knocking several parts of Git's insides. I was curious
>> about why it was so slow on the writing objects part, since the whole repo
>> is on a 4x RAID 5, 7k spindels. Now, they are not SSDs sure, but the thing
>> has ~400MB/s continuous throughput available.
>>
>> iostat -m 5 showed trickle read/write to the process, and 80-100% CPU single
>> thread (since the "write objects" stage is single threaded, obviously).
>
> So the writing phase isn't multi-threaded because it's not expected to
> matter. But if you can't even generate deltas, you aren't just
> *writing* much more data, you're compressing all that data with zlib
> too.
>
> So even with a fast disk subsystem, you won't even be able to saturate
> the disk, simply because the compression will be slower (and
> single-threaded).

I did a simple
     $ time zip -r repo.zip repo/
...
     total bytes=219353596620, compressed=214310715074 -> 2% savings

     real    154m6.323s
     user    133m5.209s
     sys     5m5.338s

also using a single thread + same disk, as git repack. But if you 
compare it to the numbers below, it's 2.6hrs with zip vs 14.2hrs 
(1:5.5). So it can't just be the overhead of having to compress the full 
blobs, due to lacking delta..


>> Filenames are fairly static, and the bulk of the 6000 biggest non-delta'ed
>> blobs are the same DLLs (multiple of them)
>
> I think the first thing you should test is to repack with fewer
> threads, and a bigger pack window. Do somethinig like
>
>   -c pack.threads=4 --window-memory=30g
>
> instead. Just to see if that starts finding deltas.

I reran the repack with the options above (dropping the zlib=9, as you 
suggested)

     $ time git -c pack.threads=4 repack -a -d -F \
                --window=350 --depth=250 --window-memory=30g

     Delta compression using up to 4 threads.
     Compressing objects:   100% (609413/609413)
     Writing objects: 100% (666515/666515), done.
     Total 666515 (delta 499585), reused 0 (delta 0)

     real	850m3.473s
     user	897m36.280s
     sys 	10m8.824s

and ended up with
     $ du -sh .
     205G	.

In other words, going from 6G to 30G window didn't help a lick on 
finding deltas for those binaries. (205G was what I had with the 
non-aggressive 'git gc', before zlib=9 repack.)

BUT, oddly enough, even if the new size if almost identical to the 
previous version without zlib=9,
     git verify-pack --verbose 
objects/pack/pack-29b06ae4d458ac03efd98b330702d30e851b2933.idx | sort 
-k3n | tail -n15
gives me a VERY different list than before

   17e5b2146311256dc8317d6e0ed1291363c31a76 blob   673399562 110248747 
190398904084
   04c881d9069eab3bd0d50dd48a047a60f79cc415 blob   673863358 111710559 
188818868865
   fdcabd75aeda86ce234d6e43b54d27d993acddcd blob   674523614 111956017 
185706433825
   d8815033d1b00b151ae762be8a69ffa35f55c4b4 blob   675286758 112099638 
185153570292
   997e0b9d3bcf440af10c7bbe535a597ca46c492c blob   678274978 112654668 
184041692883
   dfed141679e5c33caaa921cbe1595a24967a3c2c blob   681692132 113121410 
186753502634
   76a4000e71cd5b85f2265e02eb876acf1f33cc55 blob   682673430 112743915 
184563542298
   81e7292c4d2da2d2d236fbfaa572b6c4e8d787f4 blob   684543130 112797325 
181805773038
   991184c60e1fc6b2721bf40f181012b72b10d02d blob   684543130 112796892 
182344388066
   0e9269f4abd1440addd05d4f964c96d74d11cd89 blob   684547270 112809074 
181070719237
   6019b6d09759cf5adeac678c8b56d177803a0486 blob   684547270 112809336 
180517242193
   70a5f70bd205329472d6f9c660eb3f7d207a596e blob   686852038 112873611 
183520467528
   e86a0064d9652be9f5e3a877b11a665f64198ecd blob   686852038 112874133 
182893219377
   bae8de0555be5b1ffa0988cbc6cba698f6745c26 blob   894041802 137223252 
2355250324
   94dc773600e03ac1e6f3ab077b70b8297325ad77 blob   945197364 145219485 
16560137220

compared to the last 3 entries of the previous pack
   e9916da851962265a9d5b099e72f60659a74c144 blob   170113524 73514361 
966299538
   f7bf1313752deb1bae592cc7fc54289aea87ff19 blob   170113524 70756581 
1039814687
   8afc6f2a51f0fa1cc4b03b8d10c70599866804ad blob   248959314 237612609 
606692699


> So the first thing you might want to do is to just print out the
> objects after sorting them, and before it starts trying to finsd
> deltas.
...
> and notice that QSORT() line: that's what sorts the objects. You can
> do something like
>
>                 for (i = 0; i < n; i++)
>                         show_object_entry_details(delta_list[i]);

I did
     fprintf(stderr, "%s %u %lu\n",
             sha1_to_hex(delta_list[i]->idx.sha1),
             delta_list[i]->hash,
             delta_list[i]->size);

I assume that's correct?


> In fact, if your data is not *so* sensitive, and you're ok with making
> the one-line commit logs and the filenames public, you could make just
> those things available, and maybe I'll have time to look at it.

I've removed all commit messages, and "sanitized" some filepaths etc, so 
name hashes won't match what's reported, but that should be fine. (the 
object_entry->hash seems to be just a trivial uint32 hash for sorting 
anyways)

I really don't want the files on the mailinglist, so I'll send you a 
link directly. However, small snippets for public discussions about 
potential issues would be fine, obviously.

BUT, if I look at the last 3 entries of the sorted git verify-pack 
output, and look for them in the 'git log --oneline --raw -R 
--abbrev=40' output, I get:
  :100644 100644 991184c60e1fc6b2721bf40f181012b72b10d02d 
e86a0064d9652be9f5e3a877b11a665f64198ecd M 
extern/win/FlammableV3/x64/lib/FlameProxyLibD.lib
  :100644 000000 bae8de0555be5b1ffa0988cbc6cba698f6745c26 
0000000000000000000000000000000000000000 D 
extern/win/gdal-2.0.0/lib/x64/Debug/libgdal.lib
  :000000 100644 0000000000000000000000000000000000000000 
94dc773600e03ac1e6f3ab077b70b8297325ad77 A 
extern/win/gdal-2.0.0/lib/x64/Debug/gdal.lib

while I cannot find ANY of them in the delta_list output?? Shouldn't 
delta_list contain all objects, sorted by some heuristics? Or is the 
delta_list already here limited by some other metric, before the QSORT?

Also note that the 'git log --oneline --raw -R --abbrev=40' only gave me 
the log for trunk, so for the second last object, must have been added 
in a branch, and deleted on trunk; so I could only see the deletion of 
that object in the output.


You might get an idea for how to easily create a repo which reproduces 
the issue, and which would highlight it more easily for the ML.

I was thinking of maybe scripting up
     make install prefix=extern
for each Git release, and rewrite trunk history with extern/ binary 
commits at the time of each tag; maybe that would show the same 
behavior? But then again, most of the binaries are just copies of each 
other, and only ~10M, so probably not a big win.


Thanks!

-- 
.marius
