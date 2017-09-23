Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6214620281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdIWTz7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:55:59 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59940
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751554AbdIWTz5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=0uTIhV7ri1G/iEGRYzwQQJVGiE96Nl+2LMCuGMpGhKM=;
        b=NqGtigU3IVXYaSctRmjSBx/lnieJ9LuWhZi4MIqM2kFQm8rseLE71BHYh0PE6yNZ
        YKwhTyFiRFAI/MqgzfTTs0yRHYAAGfyq4iEe9GZDrHmVLunMajWrrIKB/uRClYKM+v3
        u+2ofktw0Khe9jNhSxjSPAtR5x5tYhirprnOpsEM=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f89f3-1bd3aadc-9e0d-42a3-8a6c-386850872e6a-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 4/9] perf/run: add calls to get_var_from_env_or_config()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These calls make it possible to have the make command or the
make options in a config file, instead of in environment
variables.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index ad442fe64a828..6bd15e701756b 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -116,6 +116,9 @@ export GIT_PERF_REPEAT_COUNT
 get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf.dirsOrRevs"
 set -- $GIT_PERF_DIRS_OR_REVS "$@"
 
+get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf.makeCommand"
+get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf.makeOpts"
+
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 

--
https://github.com/git/git/pull/408
