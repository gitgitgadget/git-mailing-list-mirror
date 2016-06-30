Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554991FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 18:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbcF3SBF (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 14:01:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:34896 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747AbcF3SAv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 14:00:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIgFw-0003z6-2x
	for git@vger.kernel.org; Thu, 30 Jun 2016 20:00:05 +0200
Received: from 65.222.173.206 ([65.222.173.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 20:00:04 +0200
Received: from peartben by 65.222.173.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 20:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v13 11/20] index-helper: use watchman to avoid refreshing index with lstat()
Date:	Thu, 30 Jun 2016 17:55:20 +0000 (UTC)
Message-ID: <loom.20160630T192750-125@post.gmane.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org> <1466914464-10358-11-git-send-email-novalis@novalis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.222.173.206 (Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Turner <novalis <at> novalis.org> writes:

> 
> Hiding watchman behind index-helper means you need both daemons. You
> can't run watchman alone. Not so good. But on the other hand, 'git'
> binary is not linked to watchman/json libraries, which is good for
> packaging. Core git package will run fine without watchman-related
> packages. If they need watchman, they can install git-index-helper and
> dependencies.
> 

Have you considered splitting index-helper and watchman apart?  Using 
Watchman to not lstat unchanged entries is a huge perf win with very 
large repos.

It would also be interesting to make the Watchman backend replaceable by
using an extensible API.  This has the benefit of not having to link the
'git' binary to the watchman/json libraries.  Is there any pattern 
already in git for accomplishing this?

