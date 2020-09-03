Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41039C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 06:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2552720737
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 06:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgICGTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:19:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:47988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgICGTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 02:19:34 -0400
Received: (qmail 8262 invoked by uid 109); 3 Sep 2020 06:19:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Sep 2020 06:19:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11935 invoked by uid 111); 3 Sep 2020 06:19:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Sep 2020 02:19:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Sep 2020 02:19:31 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        git@jeffhostetler.com, stolee@gmail.com,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] RFC: refs: add GIT_DEBUG_REFS debugging mechanism
Message-ID: <20200903061931.GA2055118@coredump.intra.peff.net>
References: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
 <20200902174939.3391882-1-jonathantanmy@google.com>
 <20200903054422.GG4035286@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903054422.GG4035286@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 02, 2020 at 10:44:22PM -0700, Jonathan Nieder wrote:

> Summary:
> 
> - if this is only going to be used for tests and for ad hoc debugging,
>   I'd suggest sticking to the simple trace_key based unstructured
>   tracing API

Yeah, from my look at the debug patch, this seems sensible.

As clever as the "debug" ref-backend wrapper object is, I also wonder if
it might be simpler to just add trace calls to all of the outer
functions (e.g., ref_transaction_prepare(), etc). Unlike a "real" OO
system, we're not typically passing around the polymorphic ref_store
type, but always access it through those type-agnostic wrappers. But
maybe that would end up just as long. I dunno.

-Peff
