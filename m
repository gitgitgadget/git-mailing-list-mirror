Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E961FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbcFPLpX (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 07:45:23 -0400
Received: from avasout06.plus.net ([212.159.14.18]:47261 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcFPLpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 07:45:23 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id 7Pks1t00J2iA9hg01PktzU; Thu, 16 Jun 2016 12:44:58 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=Rr04V3SK c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=keU-hx_NUpR3jGNRBvoA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84_2)
	(envelope-from <charles@hashpling.org>)
	id 1bDVjA-0005in-LI; Thu, 16 Jun 2016 12:44:52 +0100
Date:	Thu, 16 Jun 2016 12:44:52 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix grepping for "intent to add" files
Message-ID: <20160616114452.GA21930@hashpling.org>
References: <20160616065324.GA14967@hashpling.org>
 <20160616074709.GA24412@duynguyen-vnpc.vn.dektech.internal>
 <20160616094749.GA20681@hashpling.org>
 <CACsJy8Bp6Mv2D1QCsR6MWhW2XMedo2svQKHBrx8AgA1Le56Grw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Bp6Mv2D1QCsR6MWhW2XMedo2svQKHBrx8AgA1Le56Grw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 05:57:18PM +0700, Duy Nguyen wrote:
> 
> "git grep --cached" searches file content that will be committed by
> "git commit" (no -a). An i-t-a entry will not be committed (you would
> need "git add" first, or do "git commit -a"). So if I say "search
> among the to-be-committed file content, list files that do not match
> abc" (git grep -l -v --cached abc), the i-t-a entry will show up
> because its fake content is empty (i.e. not contain "abc"), even
> though it's not in the "to-be-committed" list. So yeah, correctness
> issue.

OK, I think there is an issue there but it's not with "-l -v --cached"
but rather with "-L --cached". If my understanding is correct, "-l -v"
means "has a line that doesn't match" whereas "-L" means "has no line
that matches".

Does this sound correct? I'll try adding a new test.
