Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF33C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822A2207A2
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgLOClY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:41:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:60800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgLOClG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:41:06 -0500
Received: (qmail 11631 invoked by uid 109); 15 Dec 2020 02:40:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 02:40:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7048 invoked by uid 111); 15 Dec 2020 02:40:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Dec 2020 21:40:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Dec 2020 21:40:19 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Hashed mailmap support
Message-ID: <X9giE7ZVtuE7dvTr@coredump.intra.peff.net>
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <X9gV3mKwGrHL7PzV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9gV3mKwGrHL7PzV@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 08:48:14PM -0500, Jeff King wrote:

> On Sun, Dec 13, 2020 at 01:05:38AM +0000, brian m. carlson wrote:
> 
> > Note that this is not perfect, because a user can simply look up all the
> > hashed values and find out the old values.  However, for projects which
> > wish to adopt the feature, it can be somewhat effective to hash all
> > existing mailmap entries and include some no-op entries from other
> > contributors as well, so as to make this process less convenient.
> 
> I remain unconvinced of the value of any noop entries. Ultimately it's
> easy to invert a one-way hash that comes from a small known set of
> inputs. And that's true whether there are extra noops or not.
> 
> The interesting argument IMHO is that somebody has to _bother_ to invert
> the hash. So it means that the old and new identities do not show up
> next to each other in a file indexed by search engines, etc. That drops
> the low-hanging fruit.
> 
> And from that argument, I think the obvious question becomes: is it
> worth using a real one-way function, as opposed to just obscuring the
> raw bytes (which Ævar went into in more detail). I don't have a strong
> opinion either way (the obvious one in favor is that it's less expensive
> to do so; and something like "git log" will have to either compute a lot
> of these hashes, or cache the hash computations internally).
> 
> I think somebody also mentioned that there's value in the social
> signaling here, and I agree with that. But that is true even for a
> reversible encoding, I think.

After re-reading what I wrote, I just wanted to make clear: overall the
feature makes sense to me. I am questioning only the argument for it,
and whether a one-way hash is the right tradeoff there.

-Peff
