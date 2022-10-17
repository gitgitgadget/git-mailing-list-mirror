Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDFC43219
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJQRD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJQRDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:03:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8096FA1C
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:03:47 -0700 (PDT)
Received: (qmail 27012 invoked by uid 109); 17 Oct 2022 17:03:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 17:03:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8480 invoked by uid 111); 17 Oct 2022 17:03:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 13:03:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 13:03:45 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     kpcyrd <kpcyrd@archlinux.org>,
        rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de
Subject: Re: git 2.38.0: Change in `git archive` output
Message-ID: <Y02K8bI1s74tEij4@coredump.intra.peff.net>
References: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
 <Y0ybi66K40+uH+im@coredump.intra.peff.net>
 <Y0ynDbG8CxwAt4Fj@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0ynDbG8CxwAt4Fj@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 12:51:25AM +0000, brian m. carlson wrote:

> > but if I instead do "seq 10000", then the files differ. I didn't dig
> > into the actual binary to see the source of the change. It might be
> > something we can tweak (e.g., if it's how a header is represented, or if
> > we can change the zlib parameters to find the same compressions).
> 
> I will say that trying to make two compression implementations produce
> identical output is likely futile because it's almost always the case
> that there are multiple identical ways to encode the same data.  Most
> implementations are going to prefer improving size over consistency, so
> there's little incentive to copy the same algorithm across
> implementations. I believe even GNU gzip has changed its output in the
> past as better optimizations were implemented.
> 
> I mean, don't let me stop you from trying to tweak things to see if you
> can make it work, but in general I think it's likely that some
> divergence is going to occur between implementations no matter what.

Yeah, I definitely don't think it's something we ought to be promising,
or do put a lot of work into. But if there's low-hanging fruit to reduce
immediate pain in practice, it seems worth considering.

-Peff
