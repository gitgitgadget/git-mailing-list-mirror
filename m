Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C88CC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKAW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKAW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:22:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF07FFA0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:22:54 -0700 (PDT)
Received: (qmail 29700 invoked by uid 109); 11 Oct 2022 00:22:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:22:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15141 invoked by uid 111); 11 Oct 2022 00:22:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:22:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:22:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message
 in GCC 4.5+
Message-ID: <Y0S3XDToBqnMr4/m@coredump.intra.peff.net>
References: <20221003212318.3092010-1-asedeno@google.com>
 <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
 <CAOO-Oz2WnodBnw86mi2GZ+jLGoGy_saX=kCpwPdm2xohDO1s_Q@mail.gmail.com>
 <Yz2afjRezq5oGN4g@coredump.intra.peff.net>
 <221006.86lepts927.gmgdl@evledraar.gmail.com>
 <Yz7HGAThrOcPdmjm@coredump.intra.peff.net>
 <221006.86edvkr6cc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221006.86edvkr6cc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2022 at 11:15:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > But if the definition gets much more complicated, then it's probably
> > worth pulling it out rather than repeating it.
> 
> Yeah, I've dealt with that pain before in other contexts. It would be
> great to have a git-compiler-compat.h with just the various
> __attribute__ stuff split off from git-compat-util.h.

I was going to just have unused.h, since I'd worry that piling too much
stuff into it will eventually hit a place where some compat/ code is
unhappy. But I'd also be OK to _start_ with the UNUSED definition, but
call it git-compiler-compat or something, and then people can migrate
things as they choose to test them.

> 	+TEST_BUILTINS_OBJS_NO_UNUSED += test-ctype.o

I'd rather not go that route. I already have an UNUSED-clean code base,
and once that is all merged we shouldn't need any of that complexity. In
the meantime, yes, people introduce new cases, but I am fixing those as
they do (and have been for a few years now).

-Peff
