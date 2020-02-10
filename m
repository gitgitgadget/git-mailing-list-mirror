Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43878C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235BE2070A
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgBJOW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:22:58 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56956 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBJOW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:22:58 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j19xf-00Ha8X-Lp; Mon, 10 Feb 2020 15:22:55 +0100
Message-ID: <526a7a3d8d135c9b97890c1c238ca5baaa138c3c.camel@sipsolutions.net>
Subject: Re: [PATCH] pack-format: correct multi-pack-index description
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Date:   Mon, 10 Feb 2020 15:22:53 +0100
In-Reply-To: <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com> (sfid-20200210_151840_097919_C695A73E)
References: <20200207221640.46876-1-johannes@sipsolutions.net>
         <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com>
         (sfid-20200210_151840_097919_C695A73E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-02-10 at 09:18 -0500, Derrick Stolee wrote:
> 
> Thank you for finding this doc bug. This is a very subtle point,
> and you have described it very clearly.

I was going back and forth on the wording a bit, glad I found something
that you think is a good description :)

Are you familiar with the multi-pack-index and how it's used, by any
chance?

I came here from bup (https://github.com/bup/bup/) and needed a way to
store the offset to find objects in "pure bup", today it only stores
object *presence* and *pack* in its multi-index, but not the offset.

However, it seems to do a bit better in terms of not requiring a single
multi-index, but instead storing it in midx-*.midx files and multiple
can describe the repository state. Why wasn't something like that done
for git as well? It's a bit annoying to have to recreate the full midx
every time a pack file is added, and searching in two or three midx
files wouldn't really be a big deal?

Anyway, that's just an aside, but during all this investigation I
stumbled across this small inconsistency - I'm glad the docs exist at
all! :-)

Thanks,
johannes

