Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3199C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 04:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCWEkG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 00:40:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38347 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCWEkE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 00:40:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id m22-v6so6781905pls.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 21:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1hQUVQtYpj25cTi/rPFxncCmBdP1CuIxieLffjiMj+M=;
        b=NjhEIqzh0zS7PBkMa+Vp/r821szDkAZzlFH0ij3syqmpYjwK5az1CNIOnP1alDbM0F
         Mn+JjW9DhPp8H1JwpBtYQ22ol0nA6bAG8v/ugj9gXgd0Aca7p1agLm0QjHp9IIq41Ztv
         OfXB9Atckm2sfd4xFbqgA9ClWkwHW/v8NKDLWmpjlYPQzUrpIef5j/VKyY1fdIpZA5Tp
         rdFWn0cBvob0fW2UqzkGOe8yHkSKo36HkJnJN41L06WoOpiRuKhSgYVrVFnlKedV/bwy
         0inaaZWZVjGr9OPcrzYSVuwPl5R0ymgxzNn8VtcYUbp1WmhCBn5H+pXiSOXohSwUD75r
         EVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1hQUVQtYpj25cTi/rPFxncCmBdP1CuIxieLffjiMj+M=;
        b=hLmLgBEuZNWLvlrYB2zqICzgZDRNf9aoWcVu5nAyxNbOMd7d2uEAi33BBTlt3Axy2e
         LOQnmndHOetObFl/ua/5FA+gWM0fCj2UF1PWbJeCW8QGL4KwRfiS3Q98VsGv+P6t66+f
         scfsffPGlcEjsYsS6KC9Lg9xC/oNyGt9RoIPXjcObHaD1qgNeCCoxTAdn8qYVChJkIQI
         nCdjoWV9IFtYVR0RkUWlI6NyCAl1FlCZfybjYZAk4km8IkC25sTGpe91c+7OLcubCUlk
         o3lL1tIINZLCtc0HU0dKMTSkGF2hGAixGj/+D0GerzfmtYD8v9nNtESWRii7lZkG+dLM
         GWig==
X-Gm-Message-State: AElRT7HzvW7O9QX9Z1DHoCbuo3gc+CDCUvcfl/gxyuc2NmrqDovQzVkH
        UQD0KTaBNZ2RLIwEVOTdkl5btasCMt0=
X-Google-Smtp-Source: AG47ELu+P3K19DfGKQLden0vFKhRpo5zZufUITcwGIpqzGB7+BPSFJjBoEujO1RFATnmmu9EfS9qTw==
X-Received: by 2002:a17:902:2cc1:: with SMTP id n59-v6mr19333032plb.198.1521780002907;
        Thu, 22 Mar 2018 21:40:02 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id l22sm16069901pfj.98.2018.03.22.21.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 21:40:01 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced scripts
Date:   Thu, 22 Mar 2018 21:39:53 -0700
Message-Id: <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521779249.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com>
In-Reply-To: <cover.1521779249.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The backend scriptlets for "git rebase" were structured in a
bit unusual way for historical reasons.  Originally, it was
designed in such a way that dot-sourcing them from "git
rebase" would be sufficient to invoke the specific backend.

When it was discovered that some shell implementations
(e.g. FreeBSD 9.x) misbehaved when exiting with a "return"
is executed at the top level of a dot-sourced script (the
original was expecting that the control returns to the next
command in "git rebase" after dot-sourcing the scriptlet).

To fix this issue the whole body of git-rebase--$backend.sh
was made into a shell function git_rebase__$backend and then
the last statement of the scriptlet would invoke the function.

Here the call is moved to "git rebase" side, instead of at the
end of each scriptlet.  This give us a more normal arrangement
where the scriptlet function library and allows multiple functions
to be implemented in a scriptlet.

Signed-off-by: Wink Saville <wink@saville.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Eric Sunsine <sunsine@sunshineco.com>
---
 git-rebase--am.sh          | 11 -----------
 git-rebase--interactive.sh | 11 -----------
 git-rebase--merge.sh       | 11 -----------
 git-rebase.sh              |  2 ++
 4 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index be3f06892..e5fd6101d 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,15 +4,6 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
 git_rebase__am () {
 
 case "$action" in
@@ -105,5 +96,3 @@ fi
 move_to_original_branch
 
 }
-# ... and then we call the whole thing.
-git_rebase__am
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 561e2660e..213d75f43 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,15 +740,6 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
 git_rebase__interactive () {
 
 case "$action" in
@@ -1029,5 +1020,3 @@ fi
 do_rest
 
 }
-# ... and then we call the whole thing.
-git_rebase__interactive
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index ceb715453..685f48ca4 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -104,15 +104,6 @@ finish_rb_merge () {
 	say All done.
 }
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
 git_rebase__merge () {
 
 case "$action" in
@@ -171,5 +162,3 @@ done
 finish_rb_merge
 
 }
-# ... and then we call the whole thing.
-git_rebase__merge
diff --git a/git-rebase.sh b/git-rebase.sh
index a1f6e5de6..4595a316a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -196,7 +196,9 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=
 	fi
+	# Source the code and invoke it
 	. git-rebase--$type
+	git_rebase__$type
 	ret=$?
 	if test $ret -eq 0
 	then
-- 
2.16.2

