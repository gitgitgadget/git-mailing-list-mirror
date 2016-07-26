Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FB5203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 21:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064AbcGZVNl (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:13:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:20230 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502AbcGZVNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:13:40 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id D6BC284619;
	Tue, 26 Jul 2016 17:13:38 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v3 0/8] status: V2 porcelain status
Date:	Tue, 26 Jul 2016 17:11:15 -0400
Message-Id: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch series adds porcelain V2 format to status.
This provides detailed information about file changes
and about the current branch.

The new output is accessed via:
    git status --porcelain=v2 [--branch]

Relative to the v2 patch series, in this v3 patch series
I have changed the format of the lines for ordinary changes
to make it easier to distinguish renames and copies from
normal entries.  I also split the --branch header information
onto separate lines, since we're not bound by any requirement
to have a single ## header line.  I document the argument
as --porcelain=v2, but silently also allow --porcelain=2.


Jeff Hostetler (8):
  status: rename long-format print routines
  status: cleanup API to wt_status_print
  status: support --porcelain[=<version>]
  status: per-file data collection for --porcelain=v2
  status: print per-file porcelain v2 status data
  status: print branch info with --porcelain=v2 --branch
  status: update git-status.txt for --porcelain=v2
  status: tests for --porcelain=v2

 Documentation/git-status.txt | 100 +++++++-
 builtin/commit.c             |  78 +++---
 t/t7060-wtstatus.sh          |  21 ++
 t/t7064-wtstatus-pv2.sh      | 585 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 567 ++++++++++++++++++++++++++++++++++++-----
 wt-status.h                  |  19 +-
 6 files changed, 1260 insertions(+), 110 deletions(-)
 create mode 100755 t/t7064-wtstatus-pv2.sh

-- 
2.8.0.rc4.17.gac42084.dirty

