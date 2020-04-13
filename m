Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6225AC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4862A20731
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgDMSSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:18:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59518 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387686AbgDMSSF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 14:18:05 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 66FEB1F5AD;
        Mon, 13 Apr 2020 18:18:05 +0000 (UTC)
Date:   Mon, 13 Apr 2020 18:18:05 +0000
From:   Eric Wong <e@80x24.org>
To:     Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] added: Multi line support for ignore-paths configuration
Message-ID: <20200413181805.GA1872@dcvr>
References: <e5c78a24-e17f-c1bb-4ea7-3ddaa45abcf0@lpl-mind.de>
 <20200325203823.GA21913@dcvr>
 <0515a11b-d9ae-3f22-65a8-5efee235d5c9@lpl-mind.de>
 <20200329232404.GA12701@dcvr>
 <8fbfbf1c-ea14-6739-7881-cfa3d9642de9@lpl-mind.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fbfbf1c-ea14-6739-7881-cfa3d9642de9@lpl-mind.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de> wrote:

Sorry for the long delay, had other stuff to deal with.
(and off-list replies with HTML doesn't take high priority)

> Am 30.03.2020 um 01:24 schrieb Eric Wong:
> > > Am 25.03.2020 um 21:38 schrieb Eric Wong:
> > > > > 2.25.1.windows.1
> > > > I'm not sure how git-config or chomp() behaves on Windows systems
> > > > with CRLF line endings, though.
> > > > 
> > > > A possibility would be replacing chomp(@v) with:
> > > > 
> > > > 	s/\r?\n\z//s for @v;
> > > Yes that has to be done. Its implemented in
> > > 
> > > +    $v  =~ s/[\x0A\x0D]//g if (defined $v);
> > Does that mean you'll send a v2 of the patch which uses
> > 
> > 	s/\r?\n\z//s for @v;
> > 
> > ?
> 
> Its already in the patch. Line
> 
> +    $v  =~ s/[\x0A\x0D]//g if (defined $v);

Please reread my original message about how `$v'
as a scalar is incorrect (and thus your s///g):

https://lore.kernel.org/git/20200325203823.GA21913@dcvr/

The correct operations are on `@v' as an array,
`$v' as a scalar.  Thanks.
