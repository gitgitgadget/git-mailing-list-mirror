Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C54CC433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAB32074D
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHOA2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 20:28:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:26954 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgHOA2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 20:28:49 -0400
IronPort-SDR: jGqZfZVnzqXMw7p+HjE4w79R2pHZnXe5JsAMUI4aJ8X+SuV2HCFwJNM0HGSwH7aAipmAYOOSPp
 Hg7+TJe9cgWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="218831762"
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="218831762"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 17:28:46 -0700
IronPort-SDR: 2C2DkZWjKs+hg19nt/wwTTUi2cAlf4isnLDNEIrGRH1Ipb4dBwqyf36bzoV8j1jSp1xAEaX41f
 pijN7uQE37fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="278542481"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2020 17:28:45 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [RFC 0/3] support negative refspecs
Date:   Fri, 14 Aug 2020 17:28:31 -0700
Message-Id: <20200815002831.2468968-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b60
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This is more or less just a port of what Peff already had published a few
years ago at https://lore.kernel.org/git/20140125013433.GA22336@sigill.intra.peff.net/

I cleaned some things up and made sure the tests pass, but haven't yet added
any new tests.

I think the overal design makes sense: applying positive first and then
negative. This appears to be how negative pathspecs work at least as far as
I could tell with a few trials.

The first two patches are cleanup/fixups that I think could go separately if
everyone agrees. The third is the meat of the idea, and where most of the
work needs to be done.

Jacob Keller (3):
  refspec: fix documentation referring to refspec_item
  refspec: make sure stack refspec_item variables are zeroed
  refspec: add support for negative refspecs

 builtin/fetch.c  |  3 +++
 builtin/remote.c |  1 +
 refspec.c        | 30 +++++++++++++++++++++++++++++
 refspec.h        | 29 +++++++++++++++-------------
 remote.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 remote.h         |  9 ++++++++-
 transport.c      |  1 +
 7 files changed, 107 insertions(+), 15 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
-- 
2.28.0.163.g6104cc2f0b60

