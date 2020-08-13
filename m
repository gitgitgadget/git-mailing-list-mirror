Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3B8C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C54920716
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHMRZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:25:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:58050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMRZu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:25:50 -0400
Received: (qmail 21042 invoked by uid 109); 13 Aug 2020 17:25:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 17:25:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16595 invoked by uid 111); 13 Aug 2020 17:25:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 13:25:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 13:25:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: factor out print_oid()
Message-ID: <20200813172545.GB1597339@coredump.intra.peff.net>
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
 <20200813151856.GE2244@syl.lan>
 <3ddf0a14-77ac-7546-e03a-704432305bdb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ddf0a14-77ac-7546-e03a-704432305bdb@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 07:17:20PM +0200, René Scharfe wrote:

> -- >8 --
> Subject: [PATCH v2] fast-export: deduplicate anonymization handling
> 
> Move the code for converting an object_id to a hexadecimal string and
> for handling of the default (not anonymizing) case from its callers to
> anonymize_oid() and consequently rename it to anonymize_oid_if_needed().
> This reduces code duplication.

I think this is a bad direction unless you're going to do it for all of
the other anonymize_*() functions, as well, for consistency. And there
it gets tricky because the caller is able to use the anonymizing
knowledge in more places.

I actually liked your original version better.

-Peff
