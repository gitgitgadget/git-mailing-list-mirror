Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5EDC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiFTQ4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiFTQ4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 12:56:30 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034219F87
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 09:56:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h8so11698385iof.11
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bzTYS3sdnhKgHk0ZZDrNjx32FQjHzxnbmQaegLBW808=;
        b=X5RSQAGfPONhQRvngafkqzKKgeKf5TJsR/ezDUoWb3rtXwadB4TwHPQbXv6Zxn0XW+
         vDVY5g+z+zX8G+ra8/PbnvmWqFrU4/UJf5eKSw1Ftk09nGBmoxgrMfFKrx1uM0HjhWCl
         oMkxQMxa5f/feaUGM9H1/drhiHHbhJei2nXBQ+R0MOgKcTAAKG3b50pfNxJvpe0VES0+
         /pdrPyOmNwR0HhyizHmYa4YeeLlkW2U0lqzQrlHKSTMBuCC7zBeupoaYNwsnIyw5DVYr
         Kb9ybhSZUnBy1x3L090US/88uzobEVz4gaSmY0BdFOwyPWPjO9LTcYokuuJcRrwnrFY/
         MkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bzTYS3sdnhKgHk0ZZDrNjx32FQjHzxnbmQaegLBW808=;
        b=q2OsqIqU1D5EByWJ9Ik0fFaBFiw3MRJ7KiXWsH4ENamKWx1TmPJN1QFFbTMcEp7Sb0
         LimJRzcFo4jY33MJf/LYxsZnxIf5mrPFxnJnq9DwkCl2fiQnvV+9VsKk5ftwIcci1pCv
         l5LgIdljdbwKSQ3CR3e/j+DDsyoYijRQ7fCx+P++FW35fDoFdqe3/g60apyiOkGZoEdm
         JCynWQdNhIIstXt70jAu7V/byhaZlMgFrHE1Zsnxc1YJpGb90i9VeYrZEEbqZISbdnYW
         Wi3STENNHWJJyQXw4DFWQAmvoQnTcOM/dKGluABYinVWFzTJ/iSlSVE9wp/96KRFmfVY
         ZE7g==
X-Gm-Message-State: AJIora9wWXDVgp/MzXDZQ73a8+jTNs5OAK10SbFo0tqLYTIM2OggnuKp
        lLA95ab1uxh2o8aCyTmp+4IJYq0lfSAn
X-Google-Smtp-Source: AGRyM1vnx6QASUZUyZQnun0D7fnYrq3Efo+7uIrbpYr5aLdPlvH2naf+fVLksn20+iS9N2WCH15tSw==
X-Received: by 2002:a6b:b846:0:b0:669:b394:1943 with SMTP id i67-20020a6bb846000000b00669b3941943mr12080598iof.147.1655744188837;
        Mon, 20 Jun 2022 09:56:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ed9a:c6cc:7079:2a02? ([2600:1700:e72:80a0:ed9a:c6cc:7079:2a02])
        by smtp.gmail.com with ESMTPSA id q2-20020a927502000000b002d9208f9db6sm556526ilc.62.2022.06.20.09.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:56:28 -0700 (PDT)
Message-ID: <b21af0bc-3234-3aa2-e4a0-82874e9a670e@github.com>
Date:   Mon, 20 Jun 2022 12:56:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup table
 extension
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2022 8:33 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> When reading bitmap file, git loads each and every bitmap one by one
> even if all the bitmaps are not required. A "bitmap lookup table"
> extension to the bitmap format can reduce the overhead of loading
> bitmaps which stores a list of bitmapped commit oids, along with their
> offset and xor offset. This way git can load only the neccesary bitmaps
> without loading the previous bitmaps.
> 
> Add some information for the new "bitmap lookup table" extension in the
> bitmap-format documentation.


> @@ -67,6 +67,14 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>  			pack/MIDX. The format and meaning of the name-hash is
>  			described below.
>  
> +			** {empty}
> +			BITMAP_OPT_LOOKUP_TABLE (0xf) : :::
> +			If present, the end of the bitmap file contains a table
> +			containing a list of `N` object ids, a list of pairs of
> +			offset and xor offset of respective objects, and 4-byte
> +			integer denoting the flags (currently none). The format
> +			and meaning of the table is described below.
> +

Here, you are adding a new flag that indicates that the end of the file
contains this extra extension. This works because the size of the
extension is predictable. As long as any future extensions are also of
a predictable size, then we can continue adding them via flags in this
way.

This is better than updating the full file format to do something like
like use the chunk format API, especially because this format is shared
across other tools (JGit being mentioned frequently).

It might be worth mentioning in your commit message what happens when an
older version of Git (or JGit) notices this flag. Does it refuse to
operate on the .bitmap file? Does it give a warning or die? It would be
nice if this extension could be ignored (it seems like adding the extra
data at the end does not stop the bitmap data from being understood).

> +
> +Commit lookup table
> +-------------------
> +
> +If the BITMAP_OPT_LOOKUP_TABLE flag is set, the end of the `.bitmap`
> +contains a lookup table specifying the positions of commits which have a
> +bitmap.

Perhaps it would be better to say "the last N * (HASH_LEN + 8) + 4 bytes
preceding the trailing hash" or something? This gives us a concrete way
to compute the start of the table, while also being clear that the table
is included in the trailing hash.

> +For a `.bitmap` containing `nr_entries` reachability bitmaps, the format
> +is as follows:
> +
> +	- `nr_entries` object names.

Could you expand that these objects are commit OIDs, one for each bitmap
in the file. Are they sorted in lexicographical order for binary search,
or are we expecting to read the entire table into a hashtable in-memory?

> +	- `nr_entries` pairs of 4-byte integers, each in network order.
> +	  The first holds the offset from which that commit's bitmap can
> +	  be read. The second number holds the position of the commit
> +	  whose bitmap the current bitmap is xor'd with in lexicographic
> +	  order, or 0xffffffff if the current commit is not xor'd with
> +	  anything.

Interesting to give the xor chains directions here. You say "position"
here for the second commit: do you mean within the list of object names
as opposed to the offset? That would make the most sense so we can trace
the full list of XORs we need to make all at once.

Are .bitmap files already constrained to 4GB, so these 32-bit offsets
make sense? Using 64-bit offsets would be a small cost here, I think,
without needing to do any fancy "overflow" tables that could introduce
a variable-length extension.

> +	- One 4-byte network byte order integer specifying
> +	  table-specific flags. None exist currently, so this is always
> +	  "0".

I'm guessing this is at the end of the extension because a future flag
could modify the length of the extension, so we need the flags to be
in a predictable location. Could we make that clear somewhere?

How does Git react to seeing flags here that it does not recognize?
It seems that Git should ignore the lookup table but continue using the
rest of the .bitmap file as it did before, yes?

Thanks,
-Stolee
