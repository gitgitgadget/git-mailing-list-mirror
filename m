Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E216C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0026101E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhILWod (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:44:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236565AbhILWoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:44:32 -0400
Received: (qmail 17099 invoked by uid 109); 12 Sep 2021 22:43:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Sep 2021 22:43:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3002 invoked by uid 111); 12 Sep 2021 22:43:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Sep 2021 18:43:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 12 Sep 2021 18:43:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] parse-options API: remove OPTION_ARGUMENT feature
Message-ID: <YT6ChAivw2Vk7Jkd@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
 <patch-2.2-28b43789b11-20210911T182009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-28b43789b11-20210911T182009Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 08:21:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As was noted in 1a85b49b87a (parse-options: make OPT_ARGUMENT() more
> useful, 2019-03-14) there's only ever been one user of the
> OPT_ARGUMENT(), that user was added in 20de316e334 (difftool: allow
> running outside Git worktrees with --no-index, 2019-03-14).
> 
> The OPT_ARGUMENT() feature itself was added way back in
> 580d5bffdea (parse-options: new option type to treat an option-like
> parameter as an argument., 2008-03-02), but as discussed in
> 1a85b49b87a wasn't used until 20de316e334 in 2019.
> 
> Now that the preceding commit has migrated this code over to using
> "struct strvec" to manage the "args" member of a "struct
> child_process", we can just use that directly instead of relying on
> OPT_ARGUMENT.

Yeah, the change in difftool here looks fine (regardless of how the
cleanup in the first patch gets there). And I'm happy to see this
somewhat weird OPT_ macro go away if nobody is using it.

-Peff
