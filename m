Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F0A2096C
	for <e@80x24.org>; Mon,  3 Apr 2017 22:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbdDCWj5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 18:39:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51940 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751694AbdDCWj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 18:39:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 54F801FAFB;
        Mon,  3 Apr 2017 22:39:56 +0000 (UTC)
Date:   Mon, 3 Apr 2017 22:39:56 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
Message-ID: <20170403223956.GA3537@whir>
References: <20170403211644.26814-1-avarab@gmail.com>
 <20170403213440.GA1409@whir>
 <CACBZZX7R5svNJ+Ak3LFh8+kY48i6V7Yo6JDS+PSDJCkZ5vHb6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7R5svNJ+Ak3LFh8+kY48i6V7Yo6JDS+PSDJCkZ5vHb6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, Apr 3, 2017 at 11:34 PM, Eric Wong <e@80x24.org> wrote:
> > Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >>  - Should we be covering good practices for your repo going forward to
> >>    maintain good performance? E.g. don't have some huge tree all in
> >>    one directory (use subdirs), don't add binary (rather
> >>    un-delta-able) content if you can help it etc.
> >
> > Yes, I think so.
> 
> I'll try to write something up.
> 
> > I think avoiding ever growing ChangeLog-type files should also
> > be added to things to avoid.
> 
> How were those bad specifically? They should delta quite well, it's
> expensive to commit large files but no more because they're
> ever-growing.

It might be blame/annotate specifically, I was remembering this
thread from a decade ago:

  https://public-inbox.org/git/4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com/T/

> One issue with e.g. storing logs (I keep my IRC logs in git) is that
> if you're constantly committing large (text) files without repack your
> .git grows by a *lot* in a very short amount of time until a very
> expensive repack, so now I split my IRC logs by month.

Yep, that too; as auto GC is triggered by the number of loose
objects, not the size/packability of them.
