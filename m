Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7191FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbcFPJsi (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:48:38 -0400
Received: from avasout06.plus.net ([212.159.14.18]:42635 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbcFPJsf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:48:35 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id 7Mnp1t0072iA9hg01MnqQl; Thu, 16 Jun 2016 10:47:51 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=Rr04V3SK c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=4UT5_vqeN27ffPB_2Q8A:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84_2)
	(envelope-from <charles@hashpling.org>)
	id 1bDTtt-0005P5-QI; Thu, 16 Jun 2016 10:47:49 +0100
Date:	Thu, 16 Jun 2016 10:47:49 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix grepping for "intent to add" files
Message-ID: <20160616094749.GA20681@hashpling.org>
References: <20160616065324.GA14967@hashpling.org>
 <20160616074709.GA24412@duynguyen-vnpc.vn.dektech.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160616074709.GA24412@duynguyen-vnpc.vn.dektech.internal>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 02:47:09PM +0700, Duy Nguyen wrote:
> I don't think revert is right. It rather needs a re-fix like below.
> Basically we want grep_file() to run as normal, but grep_sha1()
> (i.e. git grep --cached) should ignore i-t-a entries, because empty
> SHA-1 is not the right content to grep. It does not matter in positive
> matching, sure, but it may in -v cache.

You don't think the revert is correct or you don't think the revert is
sufficient? (I wasn't able to find a test case which proved that the
change to line 399 was necessary, so perhaps I don't understand.)

I would have thought that grepping the empty SHA-1 would be correct for
with or without -v. An "intent to add" file has no content in the index
so I would expect it to have zero matching and zero non-matching lines
for any grep --cached query?

Or is this an efficiency and not a correctness concern?

Charles.
