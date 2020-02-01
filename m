Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B68C33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A9206E3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgBALED (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:04:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:50296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbgBALED (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 06:04:03 -0500
Received: (qmail 21043 invoked by uid 109); 1 Feb 2020 11:04:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Feb 2020 11:04:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8002 invoked by uid 111); 1 Feb 2020 11:11:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Feb 2020 06:11:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 Feb 2020 06:04:01 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] fix inconsistent uses of the_repo in
 parse_object()'s call chain
Message-ID: <20200201110401.GA1864948@coredump.intra.peff.net>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
 <20200131090329.GB2857810@coredump.intra.peff.net>
 <CAHd-oW4WBc0AmcZwmOBNNMVQW=JZ-pVhXf8ebL9exgPp13VvOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW4WBc0AmcZwmOBNNMVQW=JZ-pVhXf8ebL9exgPp13VvOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 01, 2020 at 01:44:04AM -0300, Matheus Tavares Bernardino wrote:

> > I don't think we're particularly interested in supporting multiple
> > unrelated repositories within the same process. While that would be
> > convenient for some cases (e.g., you have a million repositories and
> > want to look at all of their trees without creating a million
> > processes), I don't think it's a goal anyone is really working towards
> > with this "struct repository" layer.
> 
> Thanks for these explanations. One thing that left me thinking,
> though, is about changing the_hash_algo to r->hash_algo (not only in
> oid_to_hex()). I previously thought this would eventually be required
> for the hash transition. But if I understood your comment correctly,
> it might not be necessary since the submodule should always match the
> superproject hash. And, as you mentioned, supporting multiple
> unrelated repos [in a single process] is not one of the main goals, as
> well. So wouldn't keep using the_hash_algo be OK?

Yes, by the reasoning in my message, it wouldn't be a big problem. But I
literally hadn't thought about it until writing that, so I may either be
missing something, or there may be plans from other folks working on the
hash transition that contradict that.

Even if we don't care too much about it for now, though, it still seems
like a step in the right direction.

-Peff
