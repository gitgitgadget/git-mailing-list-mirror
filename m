Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FBAC433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37C264E90
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355323AbhCDAXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377708AbhCCPbN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 10:31:13 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63793C0613DC
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 07:30:33 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id l132so23122409qke.7
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UdopopyuxUrc6uclkSmTSkyIpqI+4ODTrSb2zqq0Ja8=;
        b=B/wpMof1r4KuaKklcucJ8LNc0KTrYuVqS/QNq0qJQHDiIL42kOQ7WPrggunBieB2Uj
         iayE+sdLjMZkh1CIhcpb66XpVqzPwKjFJ7AsKVDR8V49nl70x9lKad/f/AkuAxIQ6zbg
         zBqMgfCZ0SzqSShR0n7NivB277whppU22a1NMSUtwkn2zOR0nzoreEloPX8rkRTYXABO
         rYjMyjExiOJTUc6nO+3LZmnkHPcUxZHfaLVFqaKKOUKP+n/Jaafv8FJrqBaU7HM+9E8k
         McAu+FwPYrJfnB3HxwA2kbmS1ZD628+IIWAfqHi1KlWR63Ixuf3zVUy9yedaybJws5tG
         9jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdopopyuxUrc6uclkSmTSkyIpqI+4ODTrSb2zqq0Ja8=;
        b=g964rX10+dZbfT5nTXFXLYUCsXBINAfQ1hN2iFc4Dp5oLhB9W9dVVWrwvR0Z8HA83D
         Hipj8B4Vknn/UzMHOd1bSr4rlh2AUM4tbwmsPmZHtbzswmh751E4UfdmQTiLOh2z9oS2
         2+G6Pc0fSdXPe6NBRIN5nHENzpHe7q1TFUnJjUahRsGrBCr9ia9Em/3NjY3YifAPDBNd
         2sqcrUeFnmgFRhRlsmQCqs9gC6PUV2ksMrUUYowwkPOXKDZIYRGAV+cJjBqgwKj6K4q5
         Ak4nuOjQc/NbyaPL/ivvna27BDAxCtuuBri7tMBzpuY6jtTAcqwmB8P6HJg9nor2+3CP
         /Stw==
X-Gm-Message-State: AOAM531xfFK7oVGkr6AzrWqrPg+qCCKLBG98bsd9Gp6eaJbGGyqtG4nn
        TpXPlOuLhw51UPCoSjh0Z+d2sQ==
X-Google-Smtp-Source: ABdhPJzRRHnoKUGisa+O9M5vr0QChSrRwFF2k53aCC/HTj9l4wPYENJMWkDzWVCAEQJELmU/XNUvOg==
X-Received: by 2002:a37:f516:: with SMTP id l22mr25016432qkk.139.1614785432656;
        Wed, 03 Mar 2021 07:30:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe2:f960:a24a:8111])
        by smtp.gmail.com with ESMTPSA id d16sm16778790qka.43.2021.03.03.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:30:32 -0800 (PST)
Date:   Wed, 3 Mar 2021 10:30:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 15/15] pack-revindex: write multi-pack reverse indexes
Message-ID: <YD+rlaYGylVSkg1D@nand.local>
References: <01bd6a35c6c441a30a22a4c2d17e9cf53de6b148.1614193703.git.me@ttaylorr.com>
 <20210302184033.12305-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210302184033.12305-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 02, 2021 at 10:40:33AM -0800, Jonathan Tan wrote:
> > @@ -1018,6 +1080,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >
> >  	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
> >  	free_chunkfile(cf);
> > +
> > +	if (flags & MIDX_WRITE_REV_INDEX)
> > +		ctx.pack_order = midx_pack_order(&ctx);
> > +
> > +	if (flags & MIDX_WRITE_REV_INDEX)
> > +		write_midx_reverse_index(midx_name, midx_hash, &ctx);
> > +	clear_midx_files_ext(the_repository, ".rev", midx_hash);
> > +
> >  	commit_lock_file(&lk);
> >
> >  cleanup:
>
> Any reason why we're using 2 separate "if" statements?

Yeah. This first if statement will turn into:

  if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))

so that the pack order is computed in either case (since both the
existing write_midx_reverse_index() and the eventual write_midx_bitmap()
will be able to use the pack order).

Arguably there is never a practical reason to write one without the
other (and writing a MIDX bitmap without a reverse index is a bug), so
perhaps these options should be consolidated.

But that's cleanup that I'd rather do after all of this has settled
(since it'd be weird to say: "here's the option to write bitmaps, except
we can't write multi-pack bitmaps yet, but setting it actually writes
this other thing").

> Other than that, this patch and patch 14 look good. Besides all my minor
> comments, I think the overall patch set is in good shape and ready to be
> merged. It's great that we could reuse some of the individual-pack reverse
> index concepts and code too.

Thanks, I am really glad that you had a chance to take a look at it. I
always find your review quite helpful.

Thanks,
Taylor
