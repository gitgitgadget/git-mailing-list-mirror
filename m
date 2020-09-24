Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D93FC4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6F12311A
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgIXGib (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:38:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:38998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgIXGib (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 02:38:31 -0400
Received: (qmail 1490 invoked by uid 109); 24 Sep 2020 06:38:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 06:38:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18300 invoked by uid 111); 24 Sep 2020 06:38:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 02:38:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 02:38:29 -0400
From:   Jeff King <peff@peff.net>
To:     Ilan Biala <ilanbiala@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff --name-only --submodule=diff combination does not work
Message-ID: <20200924063829.GA1851751@coredump.intra.peff.net>
References: <20200922193407.23931C0613CF@lindbergh.monkeyblade.net>
 <CAD2jYq_-yOgVDd8280+T1E1hT1r0DfN1xFN6V0Hz_v7wnsENpQ@mail.gmail.com>
 <20200922212404.GA547416@coredump.intra.peff.net>
 <CAD2jYq8OtHUpfUZyXC_+FHew45XEtgty3H-XF_2e30mb6kCCmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2jYq8OtHUpfUZyXC_+FHew45XEtgty3H-XF_2e30mb6kCCmw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 05:32:12PM -0400, Ilan Biala wrote:

> I expected adding --submodule=diff to add all the filenames in
> submodules that were modified, but the output just shows the submodule
> folder name, not all the files within the submodule that were
> modified.

OK. That does sound like a useful thing to show, but AFAIK there is not
currently a way to do so. Formats like --name-only and --raw are capable
of showing a diff for the submodule entry itself, so they do. And we'd
want to continue to be able to do that even when the diff.submodule
config option is set. So I suspect it would need to be something like
--submodule=name-only. I.e., allowing any diff format to be passed
there.

-Peff
