Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799411F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeHRBoy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 21:44:54 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37988 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeHRBoy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 21:44:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id r3-v6so4950688ywc.5
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wj2Bj+f8BB5DTlqtxdJIK+cSKXrO6G/GqujKeoMClx8=;
        b=EaZVUaVk/YX4wYCE4SMPHx6+ZZi+v7v08wDNuHGtxGdG4Yi7EdA3q1XjtsjgDwqbnA
         3T3fZR0pSDwlvVU69EyuWyBzMei7eBXmNmBD19hForO0mutMGHLpv52LHDkXHeyfe8vm
         1H04msda7DmLAWcaR5fvsZZkCtTs5VXKXz+JFUJ6jOYd3x4ZKcRmPB9E/1DBKHGEKcpu
         V7u0PMdIBLijn/o+dBceUUnjQvb5WmySlntx43GtlAxnCRwt0c/XVBaox+69yGszSyZh
         qkTTFclzuR4sFC4t/N0qNYjVUf+2Uie6XcPTy5rujTzuBx+o/+yS1oFV8L0RgcewgjQk
         KQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wj2Bj+f8BB5DTlqtxdJIK+cSKXrO6G/GqujKeoMClx8=;
        b=pBZ3jmFo7rLuE0QTfu3hSHSIX7Hwe0NprFw1GbjwvPFAhPf38ukKi8zF7Xa156FD4L
         OfBe8TlpokX72k7GcWLc2qXYTiwGz4utIunzJMwbtyItbfAEI0WEtTapebIJx5PnzW5R
         mzpGMsfZ40CfBecNwWuUIPhQWYr9X1VOD8CIC82vKizQG57pLFtTiRgRE0ty0T+mu8Fo
         I8hhTadCOOHMuLQTkkqRRfEPDGfQ8HIZ6HVHhAtyOf5BaBRIJ06Z1OrUpCKPyD2QSlS7
         rnhVQNnIEOqapRL5RSH37Mt36Im6efW41NpAGi9Bqoy7BtSIiwBcwFXDgT4d8KGSoegQ
         oVMg==
X-Gm-Message-State: AOUpUlEh3M3A+hTSBd6EaEKUMaXkgBtkpy/AoePG9vwzRtCD/veMzTp2
        8Ya3tImFTvjByc9l/4x/lFAZgoXFCyeT7KbrqFcYRQ==
X-Google-Smtp-Source: AA+uWPyoa3iCLbgkaJXF5ioYUWawYCKWg+cd+pGFOBEC/KNUL6vUehS1TkL3cubAw9eBDEuSvnIkOoEjM/wy5dgfsdM=
X-Received: by 2002:a81:7404:: with SMTP id p4-v6mr19949461ywc.407.1534545580880;
 Fri, 17 Aug 2018 15:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180817205427.GA19580@sigill.intra.peff.net> <20180817205920.GE20088@sigill.intra.peff.net>
In-Reply-To: <20180817205920.GE20088@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Aug 2018 15:39:29 -0700
Message-ID: <CAGZ79kaP3GPZi_5vSCspgbim5VwsTMRa-fLYbjgECqsx9BTaeg@mail.gmail.com>
Subject: Re: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index 4555907dee..02a60ce670 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -50,6 +50,13 @@ int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping
>                              khash_sha1 *reused_bitmaps, int show_progress);
>  void free_bitmap_index(struct bitmap_index *);
>
> +/*
> + * After a traversal has been performed on the bitmap_index, this can be
> + * queried to see if a particular object was reachable from any of the
> + * objects flagged as UNINTERESTING.

If the traversal has not been performed, we pretend the
object was not reachable?

Is this a good API design, as it can be used when you do not
have done all preparations? similarly to prepare_bitmap_walk
we could have

    if (!bitmap_git->result)
        BUG("failed to perform bitmap walk before querying");

> +int bitmap_has_sha1_in_uninteresting(struct bitmap_index *, const unsigned char *sha1);

You seem to have rebased it to master resolving conflicts only. ;-)
Do we want to talk about object ids here instead?

(This is what I get to think about when reviewing this series
"bottom up". I use "git log -w -p master..HEAD" after applying
the patches, probably I should also use --reverse, such that I
get to see the commit message before the code for each commit
and yet only need to scroll in one direction.)
