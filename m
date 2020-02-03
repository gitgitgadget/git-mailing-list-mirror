Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75656C3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5319320658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgBCIgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:36:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:51060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726244AbgBCIgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 03:36:18 -0500
Received: (qmail 1404 invoked by uid 109); 3 Feb 2020 08:36:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 08:36:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22996 invoked by uid 111); 3 Feb 2020 08:44:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 03:44:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 03:36:16 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] commit-graph.h: store object directory in 'struct
 commit_graph'
Message-ID: <20200203083616.GA2164@coredump.intra.peff.net>
References: <cover.1580424766.git.me@ttaylorr.com>
 <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
 <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
 <20200131102049.GC2916051@coredump.intra.peff.net>
 <20200203043646.GB23625@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200203043646.GB23625@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 02, 2020 at 08:36:46PM -0800, Taylor Blau wrote:

> That all said, I am not sure that I follow the explanation that we need
> to have 'write_commit_graph_ctx' store the normalized object_dir, since
> we can use 'odb->path' for this instead. I double checked, and we
> already do the same loose normalization in
> 'sha1-file.c:link_alt_odb_entry()', where we remove trailing slashes.

I was assuming that the normalization in write_commit_graph_ctx was
necessary (and I think there are some tests around this), but I admit I
didn't actually try it. If it's not failing tests, I'm OK with comparing
the non-normalized paths as an intermediate step, since we end up
comparing pointers after the final patches.

-Peff
