Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEA220954
	for <e@80x24.org>; Tue, 28 Nov 2017 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbdK1U0b (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 15:26:31 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:45277 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdK1U0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 15:26:31 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Nov 2017 15:26:30 EST
Received: from desky.robertabel.eu (x4d076d7f.dyn.telefonica.de [77.7.109.127])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 2A527140CB7
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 21:18:25 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.109.127) smtp.mailfrom=rabel@robertabel.eu smtp.helo=desky.robertabel.eu
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Subject: git-prompt: fix reading files with windows line endings
Date:   Tue, 28 Nov 2017 21:18:17 +0100
Message-Id: <20171128201818.4132-1-rabel@robertabel.eu>
X-Mailer: git-send-email 2.13.0.windows.1
X-PPP-Message-ID: <20171128201825.17700.36268@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed today that my git prompt using msys-git on Windows got a bit broken.
After investigating I found that the git-prompt doesn't handle the case when
__git_eread reads Windows line endings \r\n. It will only strip \n, leaving
the \r.

I noticed this when I created a repository with msys-git, did some tasks and
later wanted to check the bare. Apparently, another tool on my PC went wild
and replaced all line endings in all text files it could find, breaking my git
prompt.

