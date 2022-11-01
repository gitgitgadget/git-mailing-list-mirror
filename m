Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7988DFA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 02:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiKAC2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAC2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 22:28:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA47C34
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:28:21 -0700 (PDT)
Received: (qmail 3993 invoked by uid 109); 1 Nov 2022 02:28:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 02:28:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18157 invoked by uid 111); 1 Nov 2022 02:28:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 22:28:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 22:28:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516/t5601: avoid using `localhost` for failing
 HTTPS requests
Message-ID: <Y2CEQwzz+nGR7PLf@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
 <Y2BYKxxkG57XAV/1@coredump.intra.peff.net>
 <Y2BvaXN2C325YUsz@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2BvaXN2C325YUsz@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 08:59:21PM -0400, Taylor Blau wrote:

> > >  test_expect_success LIBCURL 'fetch warns or fails when using username:password' '
> > > -	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
> > > -	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
> > > +	message="URL '\''https://username:<redacted>@224.0.0.1/'\'' uses plaintext credentials" &&
> > > +	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@224.0.0.1 2>err &&
> > >  	! grep "$message" err &&
> >
> > could be more robust. It would actually check that we succeeded in using
> > the URL.
> 
> It is magical, indeed. If it's significantly more difficult to move
> these into t5550 or t5551, then I'm OK with this in the meantime (since
> GitHub Actions really is our primary CI target that we care about this
> not hanging on).
> 
> But assuming that moving these around isn't that difficult, I would be
> slightly happier to see these tests in one of the aforementioned spots.

I don't think it was too difficult to move them. I just sent in patches
(which I just realized you were not cc'd on).

-Peff
