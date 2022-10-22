Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A2C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 22:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJVWLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJVWLa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 18:11:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA0480EBC
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 15:11:29 -0700 (PDT)
Received: (qmail 21760 invoked by uid 109); 22 Oct 2022 22:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 22:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4801 invoked by uid 111); 22 Oct 2022 22:11:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Oct 2022 18:11:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Oct 2022 18:11:28 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Michael McClimon <michael@mcclimon.org>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
Message-ID: <Y1RqkMk4A8N6A38K@coredump.intra.peff.net>
References: <xmqqa65rnuvv.fsf@gitster.g>
 <Y1Hy9n7E1/yWKkYv@newk>
 <Y1ImS1Muvk1MAQeC@coredump.intra.peff.net>
 <kl6lczalx8ox.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lczalx8ox.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 12:45:02PM -0700, Glen Choo wrote:

> However, if GIT_DIR is set by searching for the repo (e.g. by "git
> rev-parse --git-dir"), this just disables every safe.* protection. IIRC,
> you mentioned that this is exactly what Git.pm does, so as it is, yes
> this does leave us in a vulnerable state.

Thanks, that matches my understanding. I think Git.pm is vulnerable (but
again, not in a released version because of the syntax error).

> If we are using `git rev-parse --git-dir`, maybe a reasonable solution
> would be to teach `rev-parse` to respect safe.* protections? e.g. `git
> rev-parse --git-dir --safe` could error out just like `git` in an unsafe
> repository.

rev-parse does work that way. It's just that Git.pm has some oddities.
More discussion (with my analysis and a patch) in this other thread:

  https://lore.kernel.org/git/Y1Rp+7R7e+LFa5k6@coredump.intra.peff.net/

-Peff
