Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33909C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C99B206F0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV89ovaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGXTv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 15:51:58 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFDC0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 12:51:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so7773252qto.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HQDdrHKDHR0Ey9E/38X4z8Iwdrfu4xvpyZzF3T6mCZs=;
        b=hV89ovaAAvCwNeYPE0hvZ1FddpMd4f+1YtWYcLqvjIwmzAZ9ZbMRb27zFY2JPMrj9w
         3Sduivtjn3WiybhJTqLtJtq6cbQ065OQzTNhr7/HOyTfxbD6TyD8kmNEhZf4TDM8047Z
         o94wSLu035dPxeKrhjAFbRZFXNjvXLKfq+mbHc4BAY7IU2NK15KiioMEvUjhQIKfnIK8
         Gi1ZS7MGX8XUep7233imN13TEa3B4Xw23dm1xad6DPUrJEkOKpiGdeouiECbLVpwEPmo
         f2NSPO+sZFM5ZaXLmwPuDmYQs0gZ8kArCHSsL09RDUfgtFy5MVvszsF5K2Sm3ZkAbDa4
         lICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HQDdrHKDHR0Ey9E/38X4z8Iwdrfu4xvpyZzF3T6mCZs=;
        b=q6VH+g578mQYq5cjG3kqpLqvVj0S/anQktNXNWTGti8xKMQc6Vt9Tgx8yANxx9II9I
         Yr9iCvzaJVIjkIFkWs9oZLQSKWDcsI+FUWYIbXuvySQ1yc6ktY4/im8bLbPNorixB7BU
         3RDS4xSYNoit6nk7efcX8uwNJE4vtSy8nmCtkvVKXFHK6wc8x0ySbzzTuRoRJicWzGOP
         W9F3g2Wh5uYS3qaKNxNBzPJaD9qwxE+M/ukjcmtXE8mItxt2wSlOY/WSPMDcu4K73x0o
         JnFTJ9z3EEELJV38Dp4JLr0z5HgRLF0TIWttpqtMtjKtDmSKgPpQWr/H2vSViF7P+5r2
         0tUg==
X-Gm-Message-State: AOAM533XRk/7AUgqjo+8uEHFkLUiup714VW+fqb8i22ovK3CqAzQHAKA
        C1IFnbSBN1j1hQAKTPDEW+I=
X-Google-Smtp-Source: ABdhPJxSKaq6wlO569HVtCwvlRX4lPwrKgYHf94hHj+fGVG4gUnVtVTIz7bjXgIRldZUfWWkp3Wmew==
X-Received: by 2002:ac8:2fda:: with SMTP id m26mr9424058qta.357.1595620317823;
        Fri, 24 Jul 2020 12:51:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dd66:75cb:8c22:1387? ([2600:1700:e72:80a0:dd66:75cb:8c22:1387])
        by smtp.gmail.com with ESMTPSA id n127sm7887532qke.29.2020.07.24.12.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 12:51:57 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d50fbb33-9be3-1c48-2277-8bf894df734f@gmail.com>
Date:   Fri, 24 Jul 2020 15:51:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 6:15 PM, Junio C Hamano wrote:
> It might be too late to ask this now, but how does the quality of
> the resulting combined pack ensured, wrt locality and deltification?

There are two questions here, really.

The first is: given the set of objects to pack, are we packing
them as efficiently as possible?

Since e11d86de139 (midx: teach "git multi-pack-index repack" honor
"git repack" configurations, 2020-05-10), the 'repack' subcommand
honors the configured recommendations for deltas. This includes:

 (requires updating the arguments to pack-objects)
 * repack.useDeltaBaseOffset
 * repack.useDeltaIslands

 (automatically respected by pack-objects)
 * repack.packKeptsObjects
 * pack.threads
 * pack.depth
 * pack.window
 * pack.windowMemory
 * pack.deltaCacheSize
 * pack.deltaCacheLimit

All of these config settings allow the user to specify how hard
to try for delta compression. If they know something about their
data or their tolerance for extra CPU time during pack-objects,
then they can get better deltas by changing these values.

The second question is "how well do the deltas compress when
only packing incrementally versus packing the entire repo?"

One important way to consider these things is how the pack-
files are created. If we expect most pack-files coming from
'git fetch' calls, then there are some interesting patterns
that arise.

I started measuring by creating a local clone of the Linux
kernel repo starting at v5.0 and then fetching an increment
of ten commits from the first-parent history of later tags.
Each fetch created a pack-file of ~300 MB relative to the
base pack-file of ~1.6 GB. Collecting ten of these in a row
leads to almost 2 GB of "fetched" packs.

However, keep in mind that we didn't fetch 2 GB of data
"across the wire" but instead expanded the thin pack into
a full pack by copying the base objects. After running the
incremental-repack step, that ~2 GB of data re-compresses
back down to one pack-file of size ~300 MB.

_Why_ did 10 pack-files all around 300 MB get repacked at
once? It's because there were duplicate objects across those
pack-files! Recall that the multi-pack-index repack computes
batch sizes by computing an "estimated pack size" by counting
how many objects in that pack-file are referenced by the
multi-pack-index, then computing

  expected size = actual size * num objects
                              / num referenced objects

In this case, the "base" objects that are copied between the
fetches already exist in these smaller pack-files. Thus, when
the batch-size is ~300 MB it still repacks all 10 "small"
packs into a new pack that is still ~300 MB.

Now, this is still a little wasteful. That second pack has
a significant "extra space" cost. However, it came at a bonus
of writing much less data.

Perhaps the Linux kernel repository is just too small to care
about this version of maintenance? In such a case, I can work
to introduce a 'full-repack' task that is more aggressive with
repacking all pack-files. This could use the multi-pack-index
repack with --batch-size=0 to still benefit from the
repack/expire trick for safe concurrency.

Other ideas are to try repacking in other ways, such as by
object type, to maximize easy wins. For example, perhaps we
repack all of the commits and trees every time, but leave the
blobs to be repacked when we are ready to spend time on
removing deltas?

I think the incremental-repack has value, and perhaps it is
isolated to super-huge repositories. That can be controlled
by limiting its use to those when an expert user configures
Git to use it.

I remain open to recommendations from others with more
experience with delta compression to recommend alternatives.

tl,dr: the incremental-repack isn't the most space-efficient
thing we can do, and that's by design.

Thanks,
-Stolee
