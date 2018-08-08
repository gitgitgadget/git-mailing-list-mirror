Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E861F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeHHVGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:06:46 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:51491 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeHHVGq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:06:46 -0400
Received: by mail-qt0-f202.google.com with SMTP id x9-v6so2457082qto.18
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P+q1BVwtBkBjzz3kAIFv7o0mJLfDekPTdA72yzQzy4U=;
        b=TNdjvp35eDjB0E9MqM5MrzkwAeDJ8UAPur51iS5SNmaiN8v/Pkx3c4hqZOvU17Ta8G
         L77fyCrgbIGJIrDDaR6BdDabga5lspXojJg7dR/IXrWUeywBCL4p1Mq+EhyRO4HYZfrh
         7aqu/Vq/NrQGm5anK44iE4RXIjVCnhXxS6RyszR8hUf7zSd7YLhtrz64VLX23Wf5ZzmQ
         vwLTk0fIF679EWLn9eEshFfVJZ0TlUs6O8uSMmq58TSU78QkkhElTMvN4oJ6SF5zxU9u
         uZHAKT2jtN3eltDnekOVzQza8WDGhnHJgD04xuRW4HUBuUuWQNRZCWtVSNLVoUU8DBls
         UVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P+q1BVwtBkBjzz3kAIFv7o0mJLfDekPTdA72yzQzy4U=;
        b=TLKiBZFLcHDFeSRSurNxg7wTpXm8Ha+7VtLpqMahpp9wnOHHOcC8MM2jrJs7P7Ow/Q
         hfV/f89b0OC8cRpR/kry3OqItrpQrevgEYOdIEnLI5JUFAAALK45wDXduNmSv/6imFym
         8gCUBonLQZYgyPr8be3G5ry+EnwgEbfb6Fcabn37E4Z5SWQdfCNHxmpk/bj4m3bsizMs
         UR5JslUXwiCiJmX0iypg5w5AoZwrro36gZk/2c+sv4mHuUOESDOnnPLR2aAB5EVBv7aw
         nSwVLhvViEBkjIRsHBTIxX2wxTnCD0PRoVHfBBFu61KNBkEU/tmo1EbsGwTEXhbh3p0q
         8M9A==
X-Gm-Message-State: AOUpUlH0xWcXWFjJYzopL9JvtiHtX4mbHY+QVPxOfNfxCaSdtmVEkpxs
        unYYJMkpjGiZC4ibKqxHkaV84Jh20m4J2FXSkc2R
X-Google-Smtp-Source: AA+uWPxJV7sYmatqLL8yzvHEkmicP/puGYVyjgsWk1e+VYhvHvN0i7ZY9LFGjT1+0kOI2xM/xtXI6ElTokRtWvqOtOzt
X-Received: by 2002:a0c:f648:: with SMTP id s8-v6mr1970082qvm.40.1533753948059;
 Wed, 08 Aug 2018 11:45:48 -0700 (PDT)
Date:   Wed,  8 Aug 2018 11:45:44 -0700
In-Reply-To: <xmqqy3dhiu08.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180808184544.120498-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy3dhiu08.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But what to delta against what else is determined by the pathname
> info, which is now lost by enumerating objects without tree/history
> walking.  By giving phoney pathnames to objects while enumerating
> them in offset order and giving similar pathnames to objects closer
> to each other, I was hoping that better bases will likely to be in
> the same window.  The order in which objects are prepared and fed to
> try_delta() is "group by type, and then sort by path-hash (major
> key) and size (descending order, used as minor key)", so that
> the largest among similarly named blobs is stored as base and other
> blobs with similar name try to become delta against that one.

Thanks for the patient explanation - I think I see it now. If we
enumerate in pack order and pass "<sha-1> <fake-name>" instead of
"<sha-1>" to pack-objects in such a way that we make pack-objects sort
by {type -> pack-order -> size} instead of {type -> size}, we can
hopefully get better deltas. I'll write a NEEDSWORK similar to this.

I'll send a reroll later today.
