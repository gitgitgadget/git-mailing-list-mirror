Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649CAC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC51235F7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgLJAvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgLJAvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:51:10 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2798C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:50:29 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 11so3317260oty.9
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k8vKlKMrl5aSxr4jhZoBQnQxOtMFDuDWOx4oRvS9rW0=;
        b=u0x/0buGE/+6fNZ+vdJmAnQE8P9jFnsAAj7xofgMU8MRxdxmRy1GA6oDjoc3kE9Gt6
         Yq6X5PWzBCmTrFJouQQQn+kXdJuScgeijRNrqWsTIopm/c44KkFIEmRTCID2MQLzku3/
         +fY3rrgNHkKZf4cQnwbSdzIp0rLN64Xs3EVZ36/O2i19cGyTuPpC6BudM7Z4SS+4LT2T
         du44R8G0UJoJNdlcd15jGWFpgY4BDpQyu994IGbsdUq3Okg7g6gdWnz5kfDXL4E9P2yF
         aMgFPBfprR/J9OKk5JMHWYNP3sne3aD9hIT1y2crLaSElCIeeswBhyBLs1GNHfG2iULG
         ArfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k8vKlKMrl5aSxr4jhZoBQnQxOtMFDuDWOx4oRvS9rW0=;
        b=o+PSKQ0+EIw3Sv9ae2qvI6F6ylxHNkJwiKsejfVEM7xL9WdnRufNPeLb4w0HtytKaY
         4MDDb/xU5R+yb8EgaqTDy6uRBa7CvYDIx21ug0WDov9Fyonp9zFO/T+kn9XIJsfuS1PI
         S6X6jB3DAwtsXtPLZ416bMPz9GPpwMNj3Mv64W8CpYbzLz9ILpHdsGbwwD9n8skGeJz4
         akyVcRpcEYJnn93azeCb5e2cXggRWuz8IFnqEQNDLI8rAa75fAlJIHSKUTWFsSoV6bj5
         TvOjdIApDm8mYE3lX1ugGFKlu+qUaSDrB/01MbGTbU9FAw7OWyXxLC+PRO7LNjJ5UFHZ
         fBUw==
X-Gm-Message-State: AOAM533dPh3xt4D2A94BQN2gEGTIZXo9Cftx4CO4EW8iME4q6xKgrUde
        hdNqnR6/2pL1LVSrCVS3Yc532A==
X-Google-Smtp-Source: ABdhPJwfQ3n3NbolRZKkuoboft7n1llX9IGjzW1QJwc9X7SrSH6MO3tc5axIEDkW4Mdr9UttKxb0Mw==
X-Received: by 2002:a05:6830:114a:: with SMTP id x10mr4091439otq.350.1607561428367;
        Wed, 09 Dec 2020 16:50:28 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 186sm677632oof.16.2020.12.09.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:50:27 -0800 (PST)
Date:   Wed, 9 Dec 2020 19:50:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/15] Refactor chunk-format into an API
Message-ID: <X9Fw0Pzn5wsy3wt0@nand.local>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de>
 <X8/K1dUgUmwp8ZOv@nand.local>
 <4696bd93-9406-0abd-25ec-a739665a24d5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4696bd93-9406-0abd-25ec-a739665a24d5@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 06:13:18PM +0100, René Scharfe wrote:
> I'm not too familiar with the chunk producers and consumers, so I can
> only offer some high-level observations.  And I don't have to use the
> API, so go wild! ;)  I was just triggered by the appearance of two
> working pieces of code being replaced by two slightly different pieces
> of code plus a third one on top.

:-).

> > With regards to the "YAGNI" comment... I do have thoughts about
> > extending the reachability bitmap format to use chunks (of course, this
> > would break compatibility with JGit, and it isn't something that I plan
> > to do in the short-term, or even necessarily in the future).
> >
> > In any event, I'm sure that this won't be these two won't be the last
> > chunk-based formats that we have in Git.
>
> OK, so perhaps we can do better before this scheme is copied.  The write
> side is complicated by the fact that the table of contents (TOC) is
> written first, followed by the actual chunks.  That requires two passes
> over the data.

"Two passes" meaning that we have to both compute the size of and then
write the data? This is relatively cheap to do, at least so I think.

For e.g., the OIDLOOKUP commit-graph chunk is just the_hash_algo->hashsz
* commits->nr bytes wide, so that can be done in constant time. A more
heavyweight case might be for e.g., the Bloom data section, where Bloom
filters have to first be computed, their lengths accounted for, and
_then_ written when we eventually get to writing that chunk.

This happens in compute_bloom_filters(); and write_chunk_bloom_indexes()
+ write_chunk_bloom_data(), respectively. Those Bloom filters are all
stored in a commit slab until they are written, so these "two passes"
are just paid for in memory.

> The ZIP format solved a similar issue by placing the TOC at the end,
> which allows for one-pass streaming.  Another way to achieve that would
> be to put the TOC in a separate file, like we do for .pack and .idx
> files.  This way you could have a single write function for chunks, and
> writers would just be a single sequence of calls for the different
> types.

Interesting. I'm not opposed to changing any of these formats (and maybe
there is some compelling argument for doing so, I am not sure) but I
think that unifying the implementation for reading / writing the chunk
format _before_ changing it is a postive step.

> But seeing that the read side just loads all of the chunks anyway
> (skipping unknown IDs) I wonder why we need a TOC at all.  That would
> only be useful if callers were trying to read just some small subset
> of the whole file.  A collection of chunks for easy dumping and loading
> could be serialized by writing just a small header for each chunk
> containing its type and size followed by its payload.

AFAIK, we do use the table of contents to locate where the chunks are so
that we can for e.g., set up the commit_graph structure's pointers to
point at each chunk appropriately.

> René

Thanks,
Taylor
