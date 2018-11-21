Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C971F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 22:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390288AbeKVJZ6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 04:25:58 -0500
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:53848
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729827AbeKVJZ6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Nov 2018 04:25:58 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PbJJg3pSunSAIPbJLgP09C; Wed, 21 Nov 2018 15:49:32 -0700
Date:   Thu, 22 Nov 2018 00:49:29 +0200
From:   Max Kirillov <max@max630.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     peff@peff.net, max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181121224929.GD5348@jessie.local>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net>
 <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfKHUN1Q+1Npm3IdQjVKxpVGqtzkrfMkMvkv9v5X6R0n1HY53084aqeLIWpii3XO45MWoxFE9GSa0l7ko+8zTyvpvUGZdnCTiA3JXhrMDaSCQRt5KWgeX
 7xom5vvpBYp/hiXk8HvJaKT/hqeZ0VvzeYCWEX/oqKeHG8GFf6Sxsm+OCj2dXIY8LRxkDZ+S7+rRuG6iJCRPhGv/lDTf3sGpPyXDr9zzTHNU2yslftHrSIna
 ksSjzQ9n80AZFyPKA0FFIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 04:02:04AM -0800, Carlo Arenas wrote:
> for some tracing, it would seem that it gets 0 when
> trying to read 4 bytes from what I think is a pipe that connects to a
> child that has been gone already for a while.

Could you clarify it? I'm afraid I don't understand.

Meanwhile, I've been staring at code and so far don't have any
assumption where it could fail. Except basic things like something is
wrong with forking or reading/writing pipes, but then it would have
bigger consequences.

Also, I tried to look at it with NetBSD but cannot get past
error, while running tests:

> ./test-lib.sh: 327: Syntax error: Bad substitution

There is the following code there:

-----
                if test -z "$test_untraceable" || {
                     test -n "$BASH_VERSION" && {
                       test ${BASH_VERSINFO[0]} -gt 4 || { # line 327
                         test ${BASH_VERSINFO[0]} -eq 4 &&
                         test ${BASH_VERSINFO[1]} -ge 1

-----

Should I install bash for it to work? I cannot say I understand what the message is about.
