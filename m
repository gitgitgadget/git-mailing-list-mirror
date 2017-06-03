Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E5F209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 23:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdFCXsl (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 19:48:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35225 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCXsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 19:48:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so16541229pfd.2
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CiMDbEQ/KhB7Z3ncRk67AA7nt3tRLaFiqOF7iGQtIuU=;
        b=uMlUksPKRHsa7cdbfkG840O96P2a7cNmqWaCsy/KphmQKHj834kD9Lroenz8G7LtQ5
         jVpPQ2SewBNmfnQLgKeKbeZ08pwhsypTDEhQ1i14ctfenUJnVLp0buyBXWQ1DzCMmih5
         I2CFZiYivcvdXpP1gE/PTj5GAtWI8SvQ8XePionL55vGjt0SDEF9PUZxnOQjNgWYdZGy
         NpwKP2M+IhO79qAoAmuC8FftCtS3GylVuZOZsLxtJOXKWPaL4RBlQbbu2JJN506RSSrC
         /SamfJLUQNl6mZ6UTLCUfGTNyd1d48kPRz7gwer1/2GLC1gVsGnAmOMjvq7wGCrNZFsk
         xzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CiMDbEQ/KhB7Z3ncRk67AA7nt3tRLaFiqOF7iGQtIuU=;
        b=j6cZE2RgC6fbtKqW1l33po6Dli75kZ+NxakR6B0leRCz0296ETYcMqsJZDL4xqEt+r
         Ve4QO6HNpwA99FbsdY/YVSjajOzAXj7YTIV4jl7WjNTtqjo9Oamx8GQVfRnSLMf95Q1q
         H2VykK+ZJVZao79MW9x4Qa6/OWebsst3XGQu14QFWHjhYi3g2yGwD8VwPTxd7ie4wzoN
         joiq3rdo9BCaYfFQX7oxdFOjJoDNDHLkfxkdIw0W45uYfEDNtPdrOZJWwgicVzfCwi1I
         xAq5EZ52/kS5Gbi8RMnaKaqDQdO3lYUCOMi5Ih5x3boHyfWrclUIiiOROqFA1ZYF2BUy
         dv7g==
X-Gm-Message-State: AODbwcCWP/9QWNL4eOdYMQv+31KZVFSWJnVLSD1A8UsBTAJRVNFSO3c1
        YnK2DnNnApCqxw==
X-Received: by 10.99.106.2 with SMTP id f2mr13512776pgc.46.1496533719957;
        Sat, 03 Jun 2017 16:48:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:e94b:f1cf:5772:ec43])
        by smtp.gmail.com with ESMTPSA id s131sm6985119pgs.6.2017.06.03.16.48.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 16:48:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [WIP v2 2/2] pack-objects: support --blob-max-bytes
References: <cover.1496361873.git.jonathantanmy@google.com>
        <cover.1496432147.git.jonathantanmy@google.com>
        <6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com>
        <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net>
Date:   Sun, 04 Jun 2017 08:48:38 +0900
In-Reply-To: <20170602222640.u6vni5tdpjp3sayt@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 2 Jun 2017 18:26:40 -0400")
Message-ID: <xmqqinkcws2x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do also wonder if the two features would need to be separated for a
> GVFS-style solution. If you're not just avoiding large blobs but trying
> to get a narrow clone, you don't want the .git files from the
> uninteresting parts of the tree. You want to get no blobs at all, and
> then fault them in as they become relevant due to user action.

Thanks; I didn't think of this one while reviewing the overall design,
but I agree that this is something important to think about.
