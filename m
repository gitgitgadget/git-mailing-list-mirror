Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1E71FC46
	for <e@80x24.org>; Sun,  5 Feb 2017 02:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbdBECS6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 21:18:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50250 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbdBECS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 21:18:58 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3D8FA1FC46;
        Sun,  5 Feb 2017 02:18:57 +0000 (UTC)
Date:   Sun, 5 Feb 2017 02:18:57 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] completion: fix git svn authorship switches
Message-ID: <20170205021857.GA1922@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--add-author-from and --use-log-author are for "git svn dcommit",
not "git svn (init|clone)"

Signed-off-by: Eric Wong <e@80x24.org>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

 Though, I now wonder if allowing those switches to write changes
 in $GIT_CONFIG at init/clone time makes sense...

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 97d73ad88f..6990e98c44 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2587,14 +2587,14 @@ _git_svn ()
 			--no-metadata --use-svm-props --use-svnsync-props
 			--log-window-size= --no-checkout --quiet
 			--repack-flags --use-log-author --localtime
+			--add-author-from
 			--ignore-paths= --include-paths= $remote_opts
 			"
 		local init_opts="
 			--template= --shared= --trunk= --tags=
 			--branches= --stdlayout --minimize-url
 			--no-metadata --use-svm-props --use-svnsync-props
-			--rewrite-root= --prefix= --use-log-author
-			--add-author-from $remote_opts
+			--rewrite-root= --prefix= $remote_opts
 			"
 		local cmt_opts="
 			--edit --rmdir --find-copies-harder --copy-similarity=
-- 
EW
