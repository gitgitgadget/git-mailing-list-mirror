Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FF01F403
	for <e@80x24.org>; Mon, 11 Jun 2018 19:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933305AbeFKTEQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 15:04:16 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35939 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeFKTEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 15:04:15 -0400
Received: by mail-yb0-f194.google.com with SMTP id x128-v6so6829309ybg.3
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trirf9I3HqZnof5Qv+ht0g07aBr1H+SxcQEm9rcCY8M=;
        b=k03EhFZ2OQ2FN3Q8gNVVfl6KycqtyDytiibf/lM75mXEvVK5GPXoWvmLgANZHxWw6q
         qqzHCQZf11MfR83MBDmL490TPxeGtGkBKK3KAZKyW+EJ7UQSqdIPchdVahvjHk5P+nFK
         pwqMR5fTYX8h1m1me/yDsgACbyrYQjtowmNQQfEC64ob44yXnopFHb3lveHA505txvz6
         Gk6wbm3Y69kcylFRQx2UBmK4bt6gYiCvflBprPDiRsE++XwLo5dQaZeE3hiUgv4kJOD8
         adj/wHwTJ0JTsCm1bTSDirRsrObrzMkbqm15j4n0VDokVZLSZWksd4zybZlC2dSSBSK1
         W2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trirf9I3HqZnof5Qv+ht0g07aBr1H+SxcQEm9rcCY8M=;
        b=JfkzZNvtjEvlEgDtGigHCiDVj7NCZPtzMOoO8adf42ImCZ20OBQc6zPu2Vbfzvw2aP
         F5nbFBnc4pr9+VFjaPdTcI/qf5FnZcJofqKmcLz6+8S9exvgdK3wnphRgyFeAGCS0F8W
         LfGUeAi3dODjD+Sea9piFi64pU5Dhenh4/cRhLkD/nOHc+VwmpHtu083o+jj0/j1Aehn
         rQf2cPqPx9kRrwgh9Z1JNgbKWt2f+6MhxeH+xdFfDzhxpVyWlMSovzC4TybAaSbjVmBU
         s0OHp0X6Ap+5ksFTE9frMRkAMt6hDBWPaV+MGSR0hYrcxjQQBE1q+/wO5IWUJ2ha8DWK
         LCGg==
X-Gm-Message-State: APt69E2QwMTsWXTwP8GnG++33mgzKbgPC7H8LWnGf7gxsVaQ008rdwRW
        0H1qX4Zajxpj4/iRDYknajZ7QbHzCERNhBGKjTLToA==
X-Google-Smtp-Source: ADUXVKLMBDyDJZrE2joGxn50V+AzdSwlffXTx/GxT+5rMxXwSBCiJAkd9rJuOLlJOxW1kCFtzeTzf9tf5OrKlePK+uY=
X-Received: by 2002:a25:e802:: with SMTP id k2-v6mr242932ybd.292.1528743853959;
 Mon, 11 Jun 2018 12:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-2-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-2-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 12:04:02 -0700
Message-ID: <CAGZ79ka4RD_E5NpEf8-7BUCcoqEc+hDrHNR+YAqT=6m5TYg7mg@mail.gmail.com>
Subject: Re: [PATCH 01/23] midx: add design document
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 7:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/midx.txt | 109 +++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/technical/midx.txt
>
> diff --git a/Documentation/technical/midx.txt b/Documentation/technical/midx.txt
> new file mode 100644
> index 0000000000..789f410d71
> --- /dev/null
> +++ b/Documentation/technical/midx.txt
> @@ -0,0 +1,109 @@
> +Multi-Pack-Index (MIDX) Design Notes
> +====================================
> +
> +The Git object directory contains a 'pack' directory containing
> +packfiles (with suffix ".pack") and pack-indexes (with suffix
> +".idx"). The pack-indexes provide a way to lookup objects and
> +navigate to their offset within the pack, but these must come
> +in pairs with the packfiles. This pairing depends on the file
> +names, as the pack-index differs only in suffix with its pack-
> +file. While the pack-indexes provide fast lookup per packfile,
> +this performance degrades as the number of packfiles increases,
> +because abbreviations need to inspect every packfile and we are
> +more likely to have a miss on our most-recently-used packfile.
> +For some large repositories, repacking into a single packfile
> +is not feasible due to storage space or excessive repack times.

This leads to the question how MIDX will cope with large repos or
a large number of packs. As it is just an index and not a pack itself,
I guess it is smaller by some orders of magnitude, such that it
is ok for now.

> +The multi-pack-index (MIDX for short) stores a list of objects
> +and their offsets into multiple packfiles. It contains:
> +
> +- A list of packfile names.
> +- A sorted list of object IDs.
> +- A list of metadata for the ith object ID including:
> +  - A value j referring to the jth packfile.
> +  - An offset within the jth packfile for the object.
> +- If large offsets are required, we use another list of large
> +  offsets similar to version 2 pack-indexes.
> +
> +Thus, we can provide O(log N) lookup time for any number
> +of packfiles.

This sounds great for the lookup case!
Though that is for the repo-read case.
Let's read on how the dynamics of a repository are dealt with,
e.g. integrating new packs into the MIDX, or how we deal with
objects in multiple packs.

> +
> +Design Details
> +--------------
> +
> +- The MIDX is stored in a file named 'multi-pack-index' in the
> +  .git/objects/pack directory. This could be stored in the pack
> +  directory of an alternate. It refers only to packfiles in that
> +  same directory.

So there is one and only one multi pack index?
That makes the case of preparing the next MIDX that contains more
pack references more interesting, as then we have to atomically update
that file.

> +- The core.midx config setting must be on to consume MIDX files.

Looking through current config options, I would rename this to a more
suggestive name. I searched for the core.idx counterpart that enables
idx files -- it turns out that is named pack.indexVersion.

So maybe pack.MultiIndex ? That could start out as a boolean as in this
series and then evolve into a version number or such later.

> +- The file format includes parameters for the object ID hash
> +  function, so a future change of hash algorithm does not require
> +  a change in format.
> +
> +- The MIDX keeps only one record per object ID. If an object appears
> +  in multiple packfiles, then the MIDX selects the copy in the most-
> +  recently modified packfile.

Okay. That answers the question from above. Though this is just the tie
breaking decision and not a hard limitation? (i.e. we could change this
this later to that pack that has e.g. shortest delta chain for that object or
such)

> +- If there exist packfiles in the pack directory not registered in
> +  the MIDX, then those packfiles are loaded into the `packed_git`
> +  list and `packed_git_mru` cache.

Not sure I understand the implications of this?
Does that mean we first look at the multi index and if an object is not
found, we'll search linearly through all packs that are not part of the
MIDX? That would require the MIDX to be kepot up to date reasonably
to be useful.

> +- The pack-indexes (.idx files) remain in the pack directory so we
> +  can delete the MIDX file, set core.midx to false, or downgrade
> +  without any loss of information.

In the future will it be possible to have no .idx files and just have the .midx?
(I guess that depends on the strategy of how to integrate new packs into
the MIDX?)

> +- The MIDX file format uses a chunk-based approach (similar to the
> +  commit-graph file) that allows optional data to be added.

... or the index files v2 (or reftable files)? Sure, you are most familiar with
commit-graph files, but others may find it easier to have some older
file formats to relate to.

> +Future Work
> +-----------
> +
> +- Add a 'verify' subcommand to the 'git midx' builtin to verify the
> +  contents of the multi-pack-index file match the offsets listed in
> +  the corresponding pack-indexes.
> +
> +- The multi-pack-index allows many packfiles, especially in a context
> +  where repacking is expensive (such as a very large repo), or
> +  unexpected maintenance time is unacceptable (such as a high-demand
> +  build machine).

Supposedly maintenance (git gc) can be run in the background without
interfering with day-to-day life, how is the regeneration of commit graph
or MIDX files impacting the work here?

>     However, the multi-pack-index needs to be rewritten
> +  in full every time. We can extend the format to be incremental, so
> +  writes are fast. By storing a small "tip" multi-pack-index that
> +  points to large "base" MIDX files, we can keep writes fast while
> +  still reducing the number of binary searches required for object
> +  lookups.

So we can have multiple MIDX files? How would that work? Would there
be a chunk that refers to other MIDX files?

> +- The reachability bitmap is currently paired directly with a single
> +  packfile, using the pack-order as the object order to hopefully
> +  compress the bitmaps well using run-length encoding. This could be
> +  extended to pair a reachability bitmap with a multi-pack-index. If
> +  the multi-pack-index is extended to store a "stable object order"
> +  (a function Order(hash) = integer that is constant for a given hash,

This stable object order doesn't fly well with integrating new packs?

> +  even as the multi-pack-index is updated) then a reachability bitmap
> +  could point to a multi-pack-index and be updated independently.
> +
> +- Packfiles can be marked as "special" using empty files that share
> +  the initial name but replace ".pack" with ".keep" or ".promisor".
> +  We can add an optional chunk of data to the multi-pack-index that
> +  records flags of information about the packfiles. This allows new
> +  states, such as 'repacked' or 'redeltified', that can help with
> +  pack maintenance in a multi-pack environment. It may also be
> +  helpful to organize packfiles by object type (commit, tree, blob,
> +  etc.) and use this metadata to help that maintenance.
> +
> +- The partial clone feature records special "promisor" packs that
> +  may point to objects that are not stored locally, but available
> +  on request to a server. The multi-pack-index does not currently
> +  track these promisor packs.
