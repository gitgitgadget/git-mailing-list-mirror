Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B61C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 14:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJEOxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJEOxx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 10:53:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACDA7C1BC
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:53:52 -0700 (PDT)
Received: (qmail 8265 invoked by uid 109); 5 Oct 2022 14:53:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Oct 2022 14:53:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14402 invoked by uid 111); 5 Oct 2022 14:53:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Oct 2022 10:53:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Oct 2022 10:53:50 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message
 in GCC 4.5+
Message-ID: <Yz2afjRezq5oGN4g@coredump.intra.peff.net>
References: <20221003212318.3092010-1-asedeno@google.com>
 <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
 <CAOO-Oz2WnodBnw86mi2GZ+jLGoGy_saX=kCpwPdm2xohDO1s_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOO-Oz2WnodBnw86mi2GZ+jLGoGy_saX=kCpwPdm2xohDO1s_Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 07:45:44PM -0400, Alejandro R. Sedeño wrote:

> I'm targeting an old SunOS 5.10 with a GCC 3.4.3, for reasons that can
> only be described as self-loathing. :-)
> The other users of GIT_GNUC_PREREQ are used for 2.8, and 3.1, so I
> figure distinguishing between 4.5+ and <4.5 should be well supported.
> 
> Regardless, there's no reason to break older compilers over something
> that's this trivial to fix.

This will cause some mild hardships, as later patches will need to
#define UNUSED in other spots, as well, in order to get full coverage of
the code base (I have written those annotation patches, but they're not
applied upstream yet).

Still, I tend to agree with you that we should handle this case. It's
not too much work, and I should be able to work around the multiple
definitions by pulling it out into an unused.h or similar.

-Peff
