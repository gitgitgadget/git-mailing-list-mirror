Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4202022A
	for <e@80x24.org>; Tue,  8 Nov 2016 13:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbcKHNnQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 08:43:16 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:51751 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbcKHNnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 08:43:14 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c46fs-0004tq-PJ; Tue, 08 Nov 2016 13:42:52 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22561.54876.646018.985175@chiark.greenend.org.uk>
Date:   Tue, 8 Nov 2016 13:42:52 +0000
To:     Markus Hitter <mah@jump-ing.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/6] Provide for config to specify tags not to abbreviate
In-Reply-To: <0d7ff8e5-230a-c6e1-6663-eaecee5d5620@jump-ing.de>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
        <22561.8757.914542.10409@chiark.greenend.org.uk>
        <0d7ff8e5-230a-c6e1-6663-eaecee5d5620@jump-ing.de>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Markus Hitter writes ("Re: [PATCH 0/6] Provide for config to specify tags not to abbreviate"):
> TBH, I see a violation of tool independence with the choice of
> preference storage. Abbreviation of tags isn't a property of the
> repository, but a pure visual thing (screen real estate, whatever),
> so it should be handled by the tool doing the visuals, only.

As I explained in my cover letter, the set of tags which are important
enough not to abbreviate, even if they would normally be abbreviated,
is indeed a property of the repository.

The alternative would be for a tool like gitk to grow an
ever-increasing set of heuristics.  Or, worse, for a tool like dgit
(which knows that archive/* are special) to edit the user's personal
gitk settings.

> Your use case looks like a nice opportunity for
> 
> - adding a Gitk user preference on how long displayed tags are
>   allowed to be (instead of distinguishing between abbreviated and
>   unabbreviated ones; set it to 999 for your use case) and/or

This would be wrong, because it's only certain tags that ought not to
be abbreviated.  The right way to identify those tags is by 1. what
repo they are in 2. what their name is.  (It might be possible to
identify them by content or something - for example, the interesting
archive/* tags all refer to commits whose trees contain debian/ - but
that is getting quite out of hand.)

What you propose are possible general improvements to the abbreviation
system in gitk.  But they do not address the fundamental point that
some tags are much more interesting than others.  It is this latter
point that I am trying to deal with.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
