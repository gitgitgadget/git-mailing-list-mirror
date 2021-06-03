Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B905C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581B26124B
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFCTa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:30:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:45342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCTa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:30:29 -0400
Received: (qmail 6348 invoked by uid 109); 3 Jun 2021 19:28:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jun 2021 19:28:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28467 invoked by uid 111); 3 Jun 2021 19:28:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 15:28:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 15:28:43 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLktazqb0yY5LK/V@coredump.intra.peff.net>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
 <YLZXyBJ5YgGfmkKv@coredump.intra.peff.net>
 <CAOLTT8SCeKy74cVO3K5zJ5n=0s=o9zk2ipV5wM6CHQPzRoMi5Q@mail.gmail.com>
 <YLfjexczp1/HILWj@coredump.intra.peff.net>
 <CAOLTT8QMpMV=7A4ZP2k5YUrqjznBwh_uDv+qvC7Meq3pwvZt1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8QMpMV=7A4ZP2k5YUrqjznBwh_uDv+qvC7Meq3pwvZt1g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 03:18:43PM +0800, ZheNing Hu wrote:

> Jeff King <peff@peff.net> 于2021年6月3日周四 上午4:01写道：
> >
> >   This assumption was broken by 845de33a5b (cat-file: avoid noop calls
> >   to sha1_object_info_extended, 2016-05-18). That commit skips the call
> >   to oid_object_info_extended() entirely when --batch-all-objects is in
> >   use, and the custom format does not include any placeholders that
> >   require calling it.
> >
> 
> Or when the custom format only include placeholders like %(objectname) or
> %(rest), oid_object_info_extended() will not get the type of the object.

Yeah, that's what I was trying to get at with "placeholders that require
calling it", but I couldn't think of a less awkward way to say that. :)
Spelling it out is probably a good idea.

-Peff
