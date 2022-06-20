Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFEC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 17:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiFTRJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiFTRJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 13:09:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E11C91F
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 10:09:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q11so11733294iod.8
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEma2gIopxSm43EalZRpCzzPk0A+jr2NXQuJTL7+epQ=;
        b=Ay1nLkaCsvFCwGZzVmtNQOn65e5IJmJVwNYvspF0xMJaD8NzIAK1HJzuOSnDlWAFl9
         y3p0uEoXFmpnHkGaZnsFVrffZV6Fswr17AMmbN1ablrop8FjA8hI6RwZ4a7em84Wc6KK
         /z423AdsSTps6oaAvL3AC4bf38BffIIKNBjwISE+hB1/DBIG857EI1NPfleupNHhdkiD
         p5xO8SIs1XMNJcnts0MEJPQCM5Q8r/BGmaVmOmmwxHpH0tMzZ8FI8zWWQSUmQkAe5tvW
         DpFNHRSI9bxzV52GZMXHEdgcicmTc9jH43q60OHb0ALv1mncJOx34NkLbhAvP9QWd9WD
         b1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEma2gIopxSm43EalZRpCzzPk0A+jr2NXQuJTL7+epQ=;
        b=5unBbE/c0pV43vTbaBog4NOsInKRU6CqGub9O9IJIY9aktkY8HtAPlW2pTsEbaeCHr
         dichYJfmDERTtFbLCYXtUikEsU2DqAmxbqodmtx1J+g5hyMf1ooUJO4GTjMEzCxO46J4
         uqxGwDl8bgXcrH2XjEnlaQ61+0EIeSuKZOL3LHNTPqH3SvKOOj5IHARfQs4xVtDyZ2M0
         FIJy2HPkjOPKNRrS13nrL7zGOOf2MjDzfPWzZ39qxK0mGfZTQkAAQdQ+MVlshfXVmG2r
         UtdkGlytLqQ6C/ieAemkavxJkvrkeW6JH3oZ51UaHANMkfQudI1r7+T6XQFnnSQpzkYD
         audw==
X-Gm-Message-State: AJIora+ZIriZTLb/c62pBgn4dGxToKt9Pi0Txqi0VAbbF6kzPa6ZTlx2
        DumComNHRy3TjBR/vwbo6NFEgg==
X-Google-Smtp-Source: AGRyM1v6hqSBXMxTGF/cXD1gisdPJ1XO+GtGU8Qh49n0B4ODNH++QJpk6Gk40FJm96gHl/zCYEHTAw==
X-Received: by 2002:a05:6638:2595:b0:335:caf5:41b7 with SMTP id s21-20020a056638259500b00335caf541b7mr14252784jat.191.1655744960861;
        Mon, 20 Jun 2022 10:09:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c6-20020a023b06000000b0032e71f31487sm168473jaa.31.2022.06.20.10.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:09:20 -0700 (PDT)
Date:   Mon, 20 Jun 2022 13:09:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup
 table extension
Message-ID: <YrCpv3XEoB6lOlY4@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
 <b21af0bc-3234-3aa2-e4a0-82874e9a670e@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b21af0bc-3234-3aa2-e4a0-82874e9a670e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 12:56:27PM -0400, Derrick Stolee wrote:
> On 6/20/2022 8:33 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> > From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> >
> > When reading bitmap file, git loads each and every bitmap one by one
> > even if all the bitmaps are not required. A "bitmap lookup table"
> > extension to the bitmap format can reduce the overhead of loading
> > bitmaps which stores a list of bitmapped commit oids, along with their
> > offset and xor offset. This way git can load only the neccesary bitmaps
> > without loading the previous bitmaps.
> >
> > Add some information for the new "bitmap lookup table" extension in the
> > bitmap-format documentation.
>
>
> > @@ -67,6 +67,14 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
> >  			pack/MIDX. The format and meaning of the name-hash is
> >  			described below.
> >
> > +			** {empty}
> > +			BITMAP_OPT_LOOKUP_TABLE (0xf) : :::
> > +			If present, the end of the bitmap file contains a table
> > +			containing a list of `N` object ids, a list of pairs of
> > +			offset and xor offset of respective objects, and 4-byte
> > +			integer denoting the flags (currently none). The format
> > +			and meaning of the table is described below.
> > +
>
> Here, you are adding a new flag that indicates that the end of the file
> contains this extra extension. This works because the size of the
> extension is predictable. As long as any future extensions are also of
> a predictable size, then we can continue adding them via flags in this
> way.

Right; any extensions that are added to the existing .bitmap format must
have a size that is predictable in order for readers to locate the next
extension, if any.

> This is better than updating the full file format to do something like
> like use the chunk format API, especially because this format is shared
> across other tools (JGit being mentioned frequently).

Agreed. Abhradeep and I discussed whether or not it was worth exploring
a new .bitmap format, and the consensus we reached was that it may be
required in the future (if we explored a compression scheme other than
EWAH or made some other backwards-incompatible change), but as of yet it
isn't necessary. So we avoided it to eliminate unnecessary churn,
especially of on-disk formats.

> It might be worth mentioning in your commit message what happens when an
> older version of Git (or JGit) notices this flag. Does it refuse to
> operate on the .bitmap file? Does it give a warning or die? It would be
> nice if this extension could be ignored (it seems like adding the extra
> data at the end does not stop the bitmap data from being understood).

I agree. The bitmap reader does not warn or die when it sees
unrecognized extensions, that way new extensions can be added without
rendering all previously-written bitmaps useless. But in order to
understand an extension on bit N, the reader must also understand
extensions N-1, N-2, and so on (in order to locate the end of
extension N).

> > +	- `nr_entries` pairs of 4-byte integers, each in network order.
> > +	  The first holds the offset from which that commit's bitmap can
> > +	  be read. The second number holds the position of the commit
> > +	  whose bitmap the current bitmap is xor'd with in lexicographic
> > +	  order, or 0xffffffff if the current commit is not xor'd with
> > +	  anything.
>
> Interesting to give the xor chains directions here. You say "position"
> here for the second commit: do you mean within the list of object names
> as opposed to the offset? That would make the most sense so we can trace
> the full list of XORs we need to make all at once.
>
> Are .bitmap files already constrained to 4GB, so these 32-bit offsets
> make sense? Using 64-bit offsets would be a small cost here, I think,
> without needing to do any fancy "overflow" tables that could introduce
> a variable-length extension.

Yeah, we should support >4GB bitmaps here. An overflow table could work,
but I agree with Stolee that in practice it won't matter. Most .bitmap
files that I've looked at in the wild have around ~500 entries at most,
and are usually small. So the cost of widening this section isn't a big
deal.

But note that the entry count is only one component of the bitmap size:
the individual entry lengths obviously matter too. And in repositories
whose bitmaps exceed 500 entries, the entries themselves are often
several million bits long (before compression) already. So it is
certainly possible to exceed 4GB without having an astronomical entry
count.

So doubling the width of this extension might add an extra 250 KiB or
so, which is negligible.

I would much rather see us do that in cases where it makes sense (small
number of entries, minimal cost to wider records, etc.) than adding
unnecessary complexity via an extra lookup table for >4GB offsets.

> > +	- One 4-byte network byte order integer specifying
> > +	  table-specific flags. None exist currently, so this is always
> > +	  "0".
>
> I'm guessing this is at the end of the extension because a future flag
> could modify the length of the extension, so we need the flags to be
> in a predictable location. Could we make that clear somewhere?

I can't remember what I had on my mind when I wrote this ;-).

Abhradeep -- do you have any thoughts about what this might be used for?
I'll try to remember it myself, but I imagine that we could just as
easily remove this altogether and avoid the confusion.

> How does Git react to seeing flags here that it does not recognize?
> It seems that Git should ignore the lookup table but continue using the
> rest of the .bitmap file as it did before, yes?

(See above).

Thanks,
Taylor
