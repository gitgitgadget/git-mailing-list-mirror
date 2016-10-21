Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D12F1F4F8
	for <e@80x24.org>; Fri, 21 Oct 2016 00:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754921AbcJUA06 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 20:26:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:60419 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754756AbcJUA05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 20:26:57 -0400
Received: (qmail 16677 invoked by uid 109); 21 Oct 2016 00:26:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 00:26:56 +0000
Received: (qmail 31797 invoked by uid 111); 21 Oct 2016 00:27:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 20:27:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 20:26:54 -0400
Date:   Thu, 20 Oct 2016 20:26:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [BUG] fetch output is ugly in 'next'
Message-ID: <20161021002654.qo6kcya4gocp73rs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently started using lt/abbrev-auto via 'next'. This is the fetch
output I saw today:

$ git fetch
remote: Counting objects: 332, done.
remote: Compressing objects: 100% (237/237), done.
remote: Total 332 (delta 182), reused 64 (delta 64), pack-reused 31
Receiving objects: 100% (332/332), 351.53 KiB | 0 bytes/s, done.
Resolving deltas: 100% (184/184), completed with 26 local objects.
From git://github.com/gitster/git
 + fb65135d9c...16ab66ec97 jch                                  -> origin/jch  (forced update)
   fd47ae6a5b..98985c6911 jk/diff-submodule-diff-inline        -> origin/jk/diff-submodule-diff-inline
 * [new branch]      jk/no-looking-at-dotgit-outside-repo -> origin/jk/no-looking-at-dotgit-outside-repo
 + 3a8f853f16...1369f9b5ba jt/trailer-with-cruft                -> origin/jt/trailer-with-cruft  (forced update)
 * [new branch]      pt/gitgui-updates                    -> origin/pt/gitgui-updates
 + 7594b34cbb...be8e40093b pu                                   -> origin/pu  (forced update)
 + 7b95cf9a4e...76e368c378 tg/add-chmod+x-fix                   -> origin/tg/add-chmod+x-fix  (forced update)
 + c4cf1f93cf...221912514c va/i18n-perl-scripts                 -> origin/va/i18n-perl-scripts  (forced update)
 * [new branch]      yk/git-tag-remove-mention-of-old-layout-in-doc -> origin/yk/git-tag-remove-mention-of-old-layout-in-doc

Yuck. I could maybe get over the wasted space due to the longer sha1s,
but we clearly need to fix the alignment computation. I haven't dug on
it at all; it's probably low-hanging fruit if somebody is interested.

-Peff
