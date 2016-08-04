Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00301F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758684AbcHDXgE (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:36:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49590 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758590AbcHDXgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:36:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267661F855;
	Thu,  4 Aug 2016 23:34:35 +0000 (UTC)
Date:	Thu, 4 Aug 2016 23:34:35 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
Message-ID: <20160804233435.GA31403@dcvr>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> [Graduated to "master"]

> * ew/http-walker (2016-07-18) 4 commits
>   (merged to 'next' on 2016-07-18 at a430a97)
>  + list: avoid incompatibility with *BSD sys/queue.h
>   (merged to 'next' on 2016-07-13 at 8585c03)
>  + http-walker: reduce O(n) ops with doubly-linked list

Yay!  This finally introduces the Linux kernel linked list
into git.  I'm not sure if it's worth the effort to introduce
cleanup commits to start using it in places where we already
have doubly-linked list implementations:

(+Cc Nicolas and Lukas)
* sha1_file.c delta_base_cache_lru is open codes this
* builtin/pack-redundant.c could probably be adapted, too
 ... any more?

And there may be other places where we have performance problems
walking singly-linked lists and would be better off on a
doubly-linked one (or even just readability ones).

<snip>

>  cf. <alpine.DEB.2.20.1607061016330.6426@virtualbox>
>  cf. <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>

It might be useful for new-to-mailing-lists folks to note that
these are Message-IDs references which can be looked up at the
following locations:

	mid.mail-archive.com/%s
	marc.info/?i=%s
	public-inbox.org/git/%s/
	mid.gmane.org/%s		# currently down

ref: https://en.wikipedia.org/wiki/Message-ID
