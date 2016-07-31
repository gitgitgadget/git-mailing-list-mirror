Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5AB1F71B
	for <e@80x24.org>; Sun, 31 Jul 2016 01:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcGaBHe (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 21:07:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43554 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbcGaBHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 21:07:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFDD1F71B;
	Sun, 31 Jul 2016 01:07:32 +0000 (UTC)
Date:	Sun, 31 Jul 2016 01:07:32 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
Message-ID: <20160731010732.GA31840@whir>
References: <20160718223038.GA66056@plume>
 <20160730182005.14426-1-pclouds@gmail.com>
 <20160731001532.GA23146@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160731001532.GA23146@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > +test_expect_success FREEBSD 'Work around lazy mtime update' '
> > +	ls -ld . >/dev/null
> > +'
> 
> 	stat . >/dev/null

If there's some older FreeBSD w/o stat(1); "test -x ."
ought to work, too, and it's faster being a shell builtin.

I suspect some shell might be clever about optimizing away
a more-obvious "test -d .", so I choose "test -x ."

> would be more to the point of what is going on, here.   But I
> also wonder if untracked cache itself could/should be doing this
> internally.

Still wondering :>

> (I'm not familiar with that code, of course)
> 
> Thanks again for looking into this.
