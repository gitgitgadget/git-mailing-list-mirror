Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E98381F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 21:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbdAZVxM (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 16:53:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:45588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753824AbdAZVxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 16:53:12 -0500
Received: (qmail 32686 invoked by uid 109); 26 Jan 2017 21:53:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 21:53:11 +0000
Received: (qmail 28076 invoked by uid 111); 26 Jan 2017 21:53:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 16:53:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 16:53:09 -0500
Date:   Thu, 26 Jan 2017 16:53:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: HEAD's reflog entry for a renamed branch
Message-ID: <20170126215309.n2lr6q5doidhzcf5@sigill.intra.peff.net>
References: <87pojmwq5y.fsf@kyleam.com>
 <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <xmqqk29h33w1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk29h33w1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 01:30:54PM -0800, Junio C Hamano wrote:

> >   - "git branch -m" does seem to realize when we are renaming HEAD,
> >     because it updates HEAD to point to the new branch name. But it
> >     should probably insert another reflog entry mentioning the rename
> >     (we do for "git checkout foo", even when "foo" has the same sha1 as
> >     the current HEAD).
> 
> This one I care less (not in the sense that I prefer it not done,
> but in the sense that I do not mind it is left unfixed than the
> other one you pointed out).

I wondered if it might affect how "git checkout -" works. But that
feature looks for reflogs like "checkout: moving from X to Y" to know to
move back to X.  So we are fine here. Even though the HEAD reflog does
not show us going _to_ new-master, we would see it in a later entry as
"from new-master to Y". What we are missing is "rename from master to
new-master", but that entry does not matter. There is no "master" to
go back to anymore. :)

-Peff
