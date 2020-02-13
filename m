Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806D2C3B190
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EC9217BA
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBMW1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:27:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:42886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727347AbgBMW1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 17:27:11 -0500
Received: (qmail 17568 invoked by uid 109); 13 Feb 2020 22:27:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 22:27:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17287 invoked by uid 111); 13 Feb 2020 22:36:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2020 17:36:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Feb 2020 17:27:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/13] rev-list: allow bitmaps when counting objects
Message-ID: <20200213222710.GA25317@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
 <20200213022005.GG1126038@coredump.intra.peff.net>
 <xmqqftfeqhvp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftfeqhvp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 01:47:38PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > -	count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
> > +	count_bitmap_commit_list(bitmap_git, &commit_count,
> > +				 revs->tree_objects ? &tree_count : NULL,
> > +				 revs->blob_objects ? &blob_count : NULL,
> > +				 revs->tag_objects ? &tag_count : NULL);
> 
> So count_bitmap_commit_list() has been prepared to count non-commits
> already, but we are just starting to use that feature?
> 
> Interesting.

Yeah, it goes all the way back to fff42755ef (pack-bitmap: add support
for bitmap indexes, 2013-12-21), but was never used for non-commits. I
was pleasantly surprised that it actually worked. ;)

-Peff
