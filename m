Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BEA1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdBMSAn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 13:00:43 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:37418 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbdBMSAn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 13:00:43 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vMYHr4y7Rz5tlX;
        Mon, 13 Feb 2017 19:00:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 158AC2AA8;
        Mon, 13 Feb 2017 19:00:37 +0100 (CET)
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Small regression on Windows
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <6bc02b0a-a463-1f0c-3fee-ba27dd2482e4@kdbg.org>
Date:   Mon, 13 Feb 2017 19:00:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please type this, preferably outside of any repo to avoid that it is 
changed; note the command typo:

    git -c help.autocorrect=40 ceckout

Git waits for 4 seconds, but does not write anything until just before 
it exits. It bisects to

a9b8a09c3c30886c79133da9f48ef9f98c21c3b2 is the first bad commit
commit a9b8a09c3c30886c79133da9f48ef9f98c21c3b2
Author: Jeff Hostetler <jeffhost@microsoft.com>
Date:   Thu Dec 22 18:09:23 2016 +0100

     mingw: replace isatty() hack

     Git for Windows has carried a patch that depended on internals
     of MSVC runtime, but it does not work correctly with recent MSVC
     runtime. A replacement was written originally for compiling
     with VC++. The patch in this message is a backport of that
     replacement, and it also fixes the previous attempt to make
     isatty() tell that /dev/null is *not* an interactive terminal.

     Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     Tested-by: Beat Bolli <dev+git@drbeat.li>
     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 bc3c75bdfc766fe478e160a9452c31bfef50b505 
f7183c3a0726fef7161d5f9ff8c997260025f1bb M      compat

Any ideas? I haven't had time to dig any further.

-- Hannes

