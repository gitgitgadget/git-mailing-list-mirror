Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E559520960
	for <e@80x24.org>; Thu, 13 Apr 2017 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756276AbdDMU7t (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 16:59:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35706 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756210AbdDMU7s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 16:59:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4391C20960;
        Thu, 13 Apr 2017 20:59:47 +0000 (UTC)
Date:   Thu, 13 Apr 2017 20:59:47 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] t5550: use write_script to generate post-update
 hook
Message-ID: <20170413205947.GA32659@starla>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413183252.4713-2-bmwill@google.com>
 <20170413204358.GA10084@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170413204358.GA10084@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Williams wrote:
> > The post-update hooks created in t5550-http-fetch-dumb.sh is missing the
> > "!#/bin/sh" line which can cause issues with portability.  Instead
> > create the hook using the 'write_script' function which includes the
> > proper "#!" line.

> This would allow later patches to regress a previously supported
> behavior.
> 
> I agree that it's silly to test that behavior as a side-effect of this
> unrelated test, but I don't think we want to lose the test coverage.

I was about to write something similar about this regression.
The new execve-using code should handle ENOEXEC as execvpe does
and probably a new test for it needs to be written.
