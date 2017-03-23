Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9B220958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965134AbdCWP34 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35639 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964866AbdCWP3p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id u108so31701566wrb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLvA2hFQPPsUXdCYfs5T4k2GFVnMz1K91l1oA2NP3Xg=;
        b=g4pweUR8uamkVLSqBOW6c73/ZRsL3ZwI9en1UhCmC7pmIl+ev5k3c3WJEOKdDIgRSU
         o5wY7izxZEUnr3YzQcmDlLl1hzAR2fg/eypIzLu7AaWpeTVKX3MLnVL1TpLIb6XHmH14
         xaZKKzSE4bMIl9kHQb6+6Ca+MjgL1CaSAalO1e8lsvsMzVP1SAm2Kqd1lH42UC14T99X
         ZIkwER06ZGnoL6s9lqxHWXvfw0FeDdspERoPseJTnzLSIMDG1iruVQDb8f5/AbAuOFbn
         5SCAZYye0gO2Vr+tHAaxcRV7cjtRciBaNNgRcVph6w4bMrviHFNc6WOb/YJGabdnfTjM
         wAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLvA2hFQPPsUXdCYfs5T4k2GFVnMz1K91l1oA2NP3Xg=;
        b=C+UviyEPSLiwa3DD6dyA9uVSLf8R5ZexXNj1sk513VfZsxDSE/Wd3rqtilDb9xCfSg
         tUYtmbfUYLXC7tTJG05pbfc5aIXy06ZYYHgwUL5LU0ZosY6FhvAf/tDI8cP68ThCOJMt
         lZtDDIU6M0uHkgTQ2rTWZqPADlTBfnucIf430fYr6EhvV4wUhzKvG3ntQ0CbzmfDN53/
         RFZTV0aDGiipEEK/ZEGOGGg/uSyJ9cC2RIGQotYtFz9rA5B75G8E1BbLjXGrFVfR5YlK
         I+/eA/iQjsgHwWOtGeYLQx23kC5hzaCuhdRZ71akLv+TiNN6Enav5XmROUo3sPZ4my7U
         mVBA==
X-Gm-Message-State: AFeK/H36uyLOoDrZG9a4XgmmkI5dSx22Ihsh6d67zB7nEQvoTWXWR+pA5VDgxXN1vctOgQ==
X-Received: by 10.223.169.45 with SMTP id u42mr3023661wrc.187.1490282983890;
        Thu, 23 Mar 2017 08:29:43 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:43 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 09/14] completion: let 'for-each-ref' strip the remote name from remote branches
Date:   Thu, 23 Mar 2017 16:29:19 +0100
Message-Id: <20170323152924.23944-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code listing unique remote branches for 'git checkout's tracking
DWIMery uses a shell parameter expansion in a loop iterating over each
listed ref to remove the remote's name from the remote branches, i.e.
the leading path component from the short ref.  When listing refs from
a configured remote repository, '| sed s///' is used for the same
purpose.

Let 'git for-each-ref' strip one more leading path component from the
refs, i.e. use the format 'refname:strip=3' instead of '=2', making
that parameter expansion and 'sed' execution unnecessary.

This speeds up refs completion for 'git checkout'.  Uniquely
completing a branch for 'git checkout maste<TAB>' in a repo with 100k
remote branches, all packed, best of five:

  On Linux, near the beginning of this series, for reference:

    $ time __git_complete_refs --cur=maste --track

    real    0m8.185s
    user    0m6.896s
    sys     0m1.616s

  Before this patch:

    real    0m2.714s
    user    0m2.344s
    sys     0m0.436s

  After:

    real    0m1.993s
    user    0m1.740s
    sys     0m0.304s

  On Windows, near the beginning:

    real    1m8.421s
    user    0m7.591s
    sys     0m3.557s

  Before this patch:

    real    0m8.191s
    user    0m4.638s
    sys     0m2.918s

  After:

    real    0m6.187s
    user    0m3.358s
    sys     0m2.121s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 976f80598..206eaf0ca 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -423,11 +423,10 @@ __git_refs ()
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
-			__git for-each-ref --shell --format="ref=%(refname:strip=2)" \
+			__git for-each-ref --shell --format="ref=%(refname:strip=3)" \
 				"refs/remotes/" | \
 			while read -r entry; do
 				eval "$entry"
-				ref="${ref#*/}"
 				if [[ "$ref" == "$match"* ]]; then
 					echo "$ref"
 				fi
@@ -450,9 +449,9 @@ __git_refs ()
 			case "HEAD" in
 			$match*)	echo "HEAD" ;;
 			esac
-			__git for-each-ref --format="%(refname:strip=2)" \
+			__git for-each-ref --format="%(refname:strip=3)" \
 				"refs/remotes/$remote/$match*" \
-				"refs/remotes/$remote/$match*/**" | sed -e "s#^$remote/##"
+				"refs/remotes/$remote/$match*/**"
 		else
 			local query_symref
 			case "HEAD" in
-- 
2.12.1.485.g1616aa492

