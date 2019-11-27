Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756B8C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531D5206E0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0RUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:20:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:34160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726537AbfK0RUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:20:36 -0500
Received: (qmail 12832 invoked by uid 109); 27 Nov 2019 17:20:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 17:20:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11725 invoked by uid 111); 27 Nov 2019 17:24:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 12:24:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 12:20:35 -0500
From:   Jeff King <peff@peff.net>
To:     Ed Maste <emaste@freefall.freebsd.org>
Cc:     git@vger.kernel.org, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH v2] t4210: skip i18n tests that don't work on FreeBSD
Message-ID: <20191127172035.GB1123@sigill.intra.peff.net>
References: <20191127151708.50531-1-emaste@freefall.freebsd.org>
 <20191127171507.56354-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127171507.56354-1-emaste@freefall.freebsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 05:15:07PM +0000, Ed Maste wrote:

> Extend test-lib.sh to add a REGEX_ILLSEQ prereq, set it on FreeBSD, and
> add !REGEX_ILLSEQ to the two affected tests.

Thanks, this is much nicer.

> +FreeBSD)
> +	test_set_prereq REGEX_ILLSEQ
> +	test_set_prereq POSIXPERM
> +	test_set_prereq BSLASHPSPEC
> +	test_set_prereq EXECKEEPSPID
> +	;;

I scratched my head at these for a minute, but I see you are just
covering the bits set in the "*" case that we now no longer trigger.

It would probably be cleaner to set them ahead of time and just unset
them selectively in MINGW, etc. But we don't have any way to unset a
prereq, so lets' go with this for now. :)

-Peff
