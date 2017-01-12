Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C651D20798
	for <e@80x24.org>; Thu, 12 Jan 2017 00:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762327AbdALAR1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 19:17:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:59579 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753059AbdALAR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 19:17:26 -0500
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP; 11 Jan 2017 16:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,347,1477983600"; 
   d="scan'208";a="51987750"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2017 16:17:24 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 0/5] extend git-describe pattern matching
Date:   Wed, 11 Jan 2017 16:17:16 -0800
Message-Id: <20170112001721.2534-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.403.g196674b8396b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git describe and git name-rev the ability to match multiple
patterns inclusively. Additionally, teach these commands to also accept
negative patterns to discard any refs which match.

The pattern lists for positive and negative patterns are inclusive. This
means that for the positive patterns, a reference will be considered as
long as it matches at least one of the match patterns. It need not match
all given patterns. Additionally for negative patterns, we will not
consider any ref which matches any negative pattern, even if it matches
one of the positive patterns.

Together this allows the ability to express far more sets of tags than a
single match pattern alone. It does not provide quite the same depth as
would teaching full regexp but it is simpler and easy enough to
understand.

This is a re-send of a series from a month or so ago, I've since
re-based this on next since it appears that it was not picked up before.

Jacob Keller (5):
  doc: add documentation for OPT_STRING_LIST
  name-rev: extend --refs to accept multiple patterns
  name-rev: add support to discard refs by pattern match
  describe: teach --match to accept multiple patterns
  describe: teach describe negative pattern matches

 Documentation/git-describe.txt                | 13 ++++++-
 Documentation/git-name-rev.txt                | 11 +++++-
 Documentation/technical/api-parse-options.txt |  5 +++
 builtin/describe.c                            | 51 ++++++++++++++++++++++----
 builtin/name-rev.c                            | 53 +++++++++++++++++++++------
 t/t6007-rev-list-cherry-pick-file.sh          | 37 +++++++++++++++++++
 t/t6120-describe.sh                           | 27 ++++++++++++++
 7 files changed, 176 insertions(+), 21 deletions(-)

-- 
2.11.0.403.g196674b8396b

