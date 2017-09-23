Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF18320281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdIWT4T (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:56:19 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:53198
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751552AbdIWTz5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=51wcsmGGvrSpVfgOXeZBuwBrQ7XcBMBDtGlPcBW2QPw=;
        b=kIIIbr+hsAMDgftKw5dZQE/oFIGWd1//a/UKK+B+DW7va1ifVK8EnQTf9m+WU5me
        GW6p/ozLBGhmFxlWXLWVfOxi2INpjW3/pjzSeI8IIqbizwoPo1C550aAF22KhT9OIQJ
        y2UwzlLBSkjaW3txIKVuN24tDcbLqc3UNSTteZfM=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f89e4-aee35112-c651-47b5-973d-3fae48ff6ede-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 3/9] perf/run: add GIT_PERF_DIRS_OR_REVS
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This environment variable can be set to some revisions or
directories whose Git versions should be tested, in addition
to the revisions or directories passed as arguments to the
'run' script.

This enables a "perf.dirsOrRevs" configuration variable to
be used to set revisions or directories whose Git versions
should be tested.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index 41580ac6df44a..ad442fe64a828 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -113,6 +113,9 @@ get_var_from_env_or_config () {
 get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf.repeatCount" 3
 export GIT_PERF_REPEAT_COUNT
 
+get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf.dirsOrRevs"
+set -- $GIT_PERF_DIRS_OR_REVS "$@"
+
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 

--
https://github.com/git/git/pull/408
