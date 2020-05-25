Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B71C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098842075F
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgEYV6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:58:01 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:56299 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgEYV6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:58:01 -0400
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dL6djC8oOIndsdL6djhPZk; Mon, 25 May 2020 22:57:59 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=6_8AvaT5jgJ29QPdoWMA:9 a=AjGcO6oz07-iQ99wixmX:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=jd6J4Gguk5HxikPWLKER:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: [PATCH 0/4] Selectively show only blamed limes
Date:   Mon, 25 May 2020 22:57:47 +0100
Message-Id: <20200525215751.1735-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.26.2.windows.1.13.g9dddff6983
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfL50EdvefhuzQcGrB6m7aO8LIxS2C0EzljFCCkUEDvqN3rkheF6LDcnz/+10c7/5vd742LFk3NnwDKbfUKFJjNERr3ncTaxAuxWF9X0bCgruyx21NL6D
 mZ62SC/jhekLKew6r9WpnwNzWRQI8S/GtGHNNht/AYFgSwYh6IwEPAMPMlvTkD/hO4eRcx+MEP2J9necBPpSQriodOagWbzMeRne3Z48ANjjF5I1mLKNln4Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While `git blame` is able to select interesting line regions of a
file, it's not easy to just display blame lines since a recent date,
especially for large files.

The recent discussion on CMake[1] notes the issue of ensuring any CMake
scheme kept up with changes to the fairly long Makefile. This short
series first clarifies the marking of 'boundary' commits outwith the
revision range or time range, then adds a `--blame-only` option to
supress non-blame (boundary) commit lines, with tests, and finally
adds tests for the long standing `-b` option that simply blanks out
the oid, but still displays the whole file.

Philip


cc: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
[1] https://lore.kernel.org/git/pull.614.v2.git.1589302254.gitgitgadget@gmail.com/

Philip Oakley (4):
  doc: blame: show the boundary commit '^' caret mark
  blame: add option to show only blamed commits `--blame-only`
  blame: do not show boundary commits, only those blamed
  blame: test the -b option, use blank oid for boundary commits.

 Documentation/blame-options.txt |  4 ++++
 Documentation/git-blame.txt     |  8 ++++----
 builtin/blame.c                 |  3 +++
 t/t8002-blame.sh                | 19 +++++++++++++++++++
 4 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.26.2.windows.1.13.g9dddff6983

