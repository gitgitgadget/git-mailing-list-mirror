Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD5D1FA14
	for <e@80x24.org>; Fri, 26 May 2017 18:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbdEZSdg (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 14:33:36 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55222 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753889AbdEZSdf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 14:33:35 -0400
Received: from a1i15.kph.uni-mainz.de (host2092.kph.uni-mainz.de [134.93.134.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ulm)
        by smtp.gentoo.org (Postfix) with ESMTPSA id DA61133BE18;
        Fri, 26 May 2017 18:33:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
Date:   Fri, 26 May 2017 20:33:30 +0200
To:     git@vger.kernel.org
Subject: git-2.13.0: log --date=format:%z not working
X-Mailer: VM 8.2.0b under 24.3.1 (x86_64-pc-linux-gnu)
From:   Ulrich Mueller <ulm@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following commands work as expected (using commit b06d364310
in the git://git.kernel.org/pub/scm/git/git.git repo as test case):

$ export TZ=Europe/Berlin
$ git --no-pager log -1 --pretty="%ad" --date=iso b06d364310
2017-05-09 23:26:02 +0900
$ git --no-pager log -1 --pretty="%ad" --date=iso-local b06d364310
2017-05-09 16:26:02 +0200

However, if I use explicit format: then the output of the time zone is
wrong:

$ git --no-pager log -1 --pretty="%ad" --date="format:%F %T %z" b06d364310
2017-05-09 23:26:02 +0000
$ git --no-pager log -1 --pretty="%ad" --date="format-local:%F %T %z" b06d364310
2017-05-09 16:26:02 +0000

I would expect the output to be the same as in the first two examples.
