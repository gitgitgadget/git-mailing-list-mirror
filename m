Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F0C54EE9
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 05:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIKFHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 01:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIKFH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 01:07:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B3357C2
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 22:07:28 -0700 (PDT)
Received: (qmail 18269 invoked by uid 109); 11 Sep 2022 05:07:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 05:07:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31616 invoked by uid 111); 11 Sep 2022 05:07:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 01:07:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 01:07:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] list-objects-filter cleanups
Message-ID: <Yx1tD7MLGZnZ/RHa@coredump.intra.peff.net>
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2022 at 12:57:39AM -0400, Jeff King wrote:

> These patches should be applied on top of jk/plug-list-object-filter-leaks,
> which is currently in next.
> 
>   [1/4]: list-objects-filter: don't memset after releasing filter struct
>   [2/4]: list-objects-filter: handle null default filter spec
>   [3/4]: list-objects-filter: add and use initializers
>   [4/4]: list-objects-filter: convert filter_spec to a strbuf

By the way, there are two small conflicts when merging the result to
next. In ab/submodule-helper-leakfix, some memset() calls got moved to
"{ 0 }" initializers in the variable declarations. The resolution is to
just replace the "{ 0 }" with LIST_OBJECTS_FILTER_INIT (both sides
remove the memset calls).

-Peff
