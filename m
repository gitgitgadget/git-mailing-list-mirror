Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2AC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiFTRV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiFTRVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 13:21:53 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C241EAE7
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 10:21:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o73so8267864qke.7
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yDJNefVvmC1R0GTEMLWrZuKdcyN9WkR+vLaP/qCrTSo=;
        b=quMQQ3txM+/+/9vdsdgs7Yg0RDmpSseaHHBfKI9bOWCyzIjnOvYI+YytduZah3kYye
         serwFxt9EllxZ5zhmAakQDOxm7DbDIml77M51mM/H9EWpZdx48mr86NJNcpzpD13BVPM
         FNfmLAci1O2F+MPWxXwq7mZtTSGvxgkpUoRqj5l9S6qMqsh8I3ilk++4mYHV3yj0ruAm
         wcOyAt31YAB8huFgEvEqSinssCpM1xfgjP6YI5HxcdqJdnLMbPmhaOCd6BmfLGSkaX8A
         FbkosAWk/gke/nkA20nyzgK0BqeS4aNi7vHertFRCpIlLWhNewDzroO1VwiMdAhkfmq/
         0g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yDJNefVvmC1R0GTEMLWrZuKdcyN9WkR+vLaP/qCrTSo=;
        b=Z4f47DdGI6Ioseg6b2xP+9YNY4FUPeEYdlHoeLAKfbmYMVMtPsrmeZ+fQegog8Bole
         LMchjDZKz7g5IsO4HCjZmYa8lZ6Ki3pmVbfHnk7RG/owc6/baq2gqzkgB98bV+gm5Ja8
         zUW21N2CeXy7gP6NdYGGRFN6q6Ibb2uZKsEcpI3ZSXX1auEkUvJ7VuhjcJcHxyOjUbpn
         f/GCS/RcANY5RJ8JrXly5q+Oa6+Oma3AHPtyflc0HL+aSUwIhfD49Y1zzpRVl+sYbCCb
         BepwpxC0FjXIf6vLyJIdyorBJr3W/uBql1DL6KsThHcnRzpP3rC68rD4tDJQurVN/Anz
         mQoQ==
X-Gm-Message-State: AJIora/iCs3UDx7tXHB6VYSH3Vd8iTJ4ISFVrtu3d4BahiyexSFQAp9T
        eKM9RFLgU57n3+l0Yqo7FEOqBg==
X-Google-Smtp-Source: AGRyM1txXXBXmrj3rVHPPr5+nb+pm39uQ+eXOUce6zUyc3DM9Idm48Of9nzqwWZuADBF/6Lv85QHGw==
X-Received: by 2002:a05:620a:4e1:b0:6a6:98c8:4f76 with SMTP id b1-20020a05620a04e100b006a698c84f76mr17375272qkh.109.1655745711543;
        Mon, 20 Jun 2022 10:21:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006a6d74f8fc9sm12897342qkp.127.2022.06.20.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:21:51 -0700 (PDT)
Date:   Mon, 20 Jun 2022 13:21:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup
 table extension
Message-ID: <YrCsricF+2rQXiBk@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 12:33:09PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> When reading bitmap file, git loads each and every bitmap one by one
> even if all the bitmaps are not required. A "bitmap lookup table"
> extension to the bitmap format can reduce the overhead of loading
> bitmaps which stores a list of bitmapped commit oids, along with their
> offset and xor offset. This way git can load only the neccesary bitmaps
> without loading the previous bitmaps.

Well put. It might help to have a concrete example of where we expect
this to help and not help. I suspect that some of this will show up in
your work updating the perf suite to use this new table, but I imagine
that we'll find something like:

    In cases where the result can be read or computed without
    significant additional traversal (e.g., all commits of interest
    already have bitmaps computed), we can save some time loading and
    parsing a majority of the bitmap file that we will never read.

    But in cases where the bitmaps are out-of-date, or there is
    significant traversal required to go from the reference tips to
    what's contained in the .bitmap file, this table provides minimal
    benefit (or something).

Of course, you should verify that that is actually true before we insert
it into the commit message as such ;-). But that sort of information may
help readers understand what the purpose of this change is towards the
beinning of the series.

> Add some information for the new "bitmap lookup table" extension in the
> bitmap-format documentation.
>
> Co-Authored-by: Taylor Blau <ttaylorr@github.com>
> Mentored-by: Taylor Blau <ttaylorr@github.com>

Here and elsewhere: I typically use my <me@ttaylorr.com> address when
contributing to Git. So any trailers that mention my email or commits
that you send on my behalf should use that address, too.

> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/technical/bitmap-format.txt | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> index 04b3ec21785..34e98787b78 100644
> --- a/Documentation/technical/bitmap-format.txt
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -67,6 +67,14 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>  			pack/MIDX. The format and meaning of the name-hash is
>  			described below.
>
> +			** {empty}
> +			BITMAP_OPT_LOOKUP_TABLE (0xf) : :::

It the space between "(0xf)" and the first ":" intentional? Similarly,
should there be two or three colons at the end (either "::" or ":::")?

> +			If present, the end of the bitmap file contains a table
> +			containing a list of `N` object ids, a list of pairs of
> +			offset and xor offset of respective objects, and 4-byte
> +			integer denoting the flags (currently none). The format
> +			and meaning of the table is described below.
> +

I remember we had a brief off-list discussion about whether we should
store the full object IDs in the offset table, or whether we could store
their pack- or index-relative ordering. Is there a reason to prefer one
or the other?

I don't think we need to explain the choice fully in the documentation
in this patch, but it may be worth thinking about separately
nonetheless. We can store either order and convert it to an object ID in
constant time.

To figure out which is best, I would recommend trying a few different
choices here and seeing how they do or don't impact your performance
testing.

>  		4-byte entry count (network byte order)
>
>  			The total count of entries (bitmapped commits) in this bitmap index.
> @@ -205,3 +213,26 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
>  If implementations want to choose a different hashing scheme, they are
>  free to do so, but MUST allocate a new header flag (because comparing
>  hashes made under two different schemes would be pointless).
> +
> +Commit lookup table
> +-------------------
> +
> +If the BITMAP_OPT_LOOKUP_TABLE flag is set, the end of the `.bitmap`
> +contains a lookup table specifying the positions of commits which have a
> +bitmap.
> +
> +For a `.bitmap` containing `nr_entries` reachability bitmaps, the format
> +is as follows:
> +
> +	- `nr_entries` object names.
> +
> +	- `nr_entries` pairs of 4-byte integers, each in network order.
> +	  The first holds the offset from which that commit's bitmap can
> +	  be read. The second number holds the position of the commit
> +	  whose bitmap the current bitmap is xor'd with in lexicographic
> +	  order, or 0xffffffff if the current commit is not xor'd with
> +	  anything.

A couple of small thoughts here. I wonder if we'd get better locality if
we made each record look something like:

    (object_id, offset, xor_pos)

Where object_id is either 20- or 4-bytes long (depending if we store the
full object ID, or some 4-byte identifier that allows us to discover
it), offset is 8 bytes long, and xor_pos is 4-bytes (since in practice
we don't support packs or MIDXs which have more than 2^32-1 objects).

In the event that this table doesn't fit into a single cache line, I
think we'll get better performance out of reading it by not forcing the
cache to evict itself whenever we need to refer back to the object_id.

> +	- One 4-byte network byte order integer specifying
> +	  table-specific flags. None exist currently, so this is always
> +	  "0".

I mentioned in my reply to Stolee earlier, but I think that we should
either (a) try to remember what this is for and document it, or (b)
remove it.

Thanks,
Taylor
