Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D162202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757928AbdKGQHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:07:41 -0500
Received: from marcos.anarc.at ([206.248.172.91]:36824 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754237AbdKGQHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:07:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id B7A901A00AD
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ingo Ruhnke <grumbel@gmail.com>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH v5 2/7] remote-mediawiki: allow fetching namespaces with spaces
Date:   Tue,  7 Nov 2017 11:06:56 -0500
Message-Id: <20171107160701.24202-3-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171107160701.24202-1-anarcat@debian.org>
References: <20171102212518.1601-1-anarcat@debian.org>
 <20171107160701.24202-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ingo Ruhnke <grumbel@gmail.com>

we still want to use spaces as separators in the config, but we should
allow the user to specify namespaces with spaces, so we use underscore
for this.

Reviewed-by: Antoine Beaupré <anarcat@debian.org>
Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 5ffb57595..a1d783789 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -65,6 +65,7 @@ chomp(@tracked_categories);
 
 # Just like @tracked_categories, but for MediaWiki namespaces.
 my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.${remotename}.namespaces"));
+for (@tracked_namespaces) { s/_/ /g; }
 chomp(@tracked_namespaces);
 
 # Import media files on pull
-- 
2.11.0

