Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6549E1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 17:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbdAZRyy (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 12:54:54 -0500
Received: from mout.web.de ([217.72.192.78]:61740 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754058AbdAZRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 12:54:53 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQelV-1cwQ7g33td-00U0LO; Thu, 26
 Jan 2017 18:54:33 +0100
Subject: [PATCH 2/2] use absolute_pathdup()
To:     Git List <git@vger.kernel.org>
References: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d15fdbb9-2a21-eeab-1fee-4a1553bd3bcb@web.de>
Date:   Thu, 26 Jan 2017 18:54:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9FCZjOFkaI1ICIniVGxSIdxviNGGM6nLG5nwGlQDhDLi6JQSwOj
 oDJFsGzRnPtXb+0r9c7MTmmGrc4seIjHFkAoZrcrgz5X5xpjgEAGjTFLhU2POhVDGLdof+4
 qhzRAqy8Gx26dJWkTzdrvgFcTHcAautFCCE3Jhh65u1L0tHyTqlnG5cBjcJzkQ1yfXUjtE8
 LUFv1yneV34718owP71qA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:49EyCJ5k+JQ=:lDc776pfn3AFOm9JdywbE7
 jgbTP8LnKu01Kc22Y1eIjuueCHLKYLaSerKy7CRAYKWFtcCG+YubnJ54768gtFrfsyu2rTBfk
 NimHR5Ul5hlSiy4pgI861ou/afOBlWOpWlciPNabgzdJhHF5btlPLf4rvQZdEcJjwq1/ar6iS
 g+EeLwhQQJLdlNALRB2XJAHktuUnOBc/epEMBSNaUNv/4PKCa0s47ExVRrb30cwIDPJPmijwn
 RzFRBAE2W+TpBq6/LDQwDO7iGpy85j1EH0PuWNLTbtvX05lssUdN5/DAe8/gJ9HGI9FaLFNp2
 wF+4V8Bj8J5W64CVrkdjAptiXuCHg8bZhVnWl589pxjUxBNPckTfTL1UoRoYkaSobDmEXxfE+
 evvzj1405FhNI4wVpGou/Wl4Z230X+t8Y8h7Wfqz0sZEOwxPgqLw67RCjqkoOZUubXltszXMX
 J5gD6EwwhLfvmO0eEJyPsw43uPU0u4WAcIVRIG+6oPx1LRn1UQC5ruuSryBKTmJjjDHflUFDb
 jVsbrWJBhYD3UGBoqN5YmH7kLbZd3Us1fhK3nexZsV2LFCNAxDa30z/svlZjVAEUX8o360L6W
 gh+6bqwDuCPkNt5CDBV3KV/sf4xqGxdNLYkzodOrG1cb1ofNlPrr6yRRFRPzHtmBFln7C1iOX
 FG/2Me//m189WWvzGFRt00b4H36CAMGcnRdCBiemYR5Wipg1zV0m7wMFqCFzfDeX+Icb6mHms
 xKu91qUi7r7MF244eFAQZcVPUTROqntdJQryrA3f95rHXO4aeY0PKYMgXxE+cDc+ZRiUmMHCU
 DnE1AkN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the symantic patch for converting callers that duplicate the
result of absolute_path() to call absolute_pathdup() instead, which
avoids an extra string copy to a static buffer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/clone.c             | 4 ++--
 builtin/submodule--helper.c | 2 +-
 worktree.c                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5ef81927a6..3f63edbbf9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -170,7 +170,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 
 	strbuf_addstr(&path, repo);
 	raw = get_repo_path_1(&path, is_bundle);
-	canon = raw ? xstrdup(absolute_path(raw)) : NULL;
+	canon = raw ? absolute_pathdup(raw) : NULL;
 	strbuf_release(&path);
 	return canon;
 }
@@ -894,7 +894,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path)
-		repo = xstrdup(absolute_path(repo_name));
+		repo = absolute_pathdup(repo_name);
 	else if (!strchr(repo_name, ':'))
 		die(_("repository '%s' does not exist"), repo_name);
 	else
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 74614a951e..899dc334e3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -626,7 +626,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 				   module_clone_options);
 
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir = xstrdup(absolute_path(sb.buf));
+	sm_gitdir = absolute_pathdup(sb.buf);
 	strbuf_reset(&sb);
 
 	if (!is_absolute_path(path)) {
diff --git a/worktree.c b/worktree.c
index 53b4771c04..d633761575 100644
--- a/worktree.c
+++ b/worktree.c
@@ -145,7 +145,7 @@ static struct worktree *get_linked_worktree(const char *id)
 
 static void mark_current_worktree(struct worktree **worktrees)
 {
-	char *git_dir = xstrdup(absolute_path(get_git_dir()));
+	char *git_dir = absolute_pathdup(get_git_dir());
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
-- 
2.11.0

