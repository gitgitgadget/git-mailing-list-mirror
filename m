Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBEA1F770
	for <e@80x24.org>; Tue,  1 Jan 2019 14:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfAAOGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 09:06:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34030 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfAAOGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 09:06:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so14140677pfg.1
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F5JDI78X2qf36ZQ9ireAqEU6JVwz17fAS60XT5JBQnw=;
        b=cqi1wa3unLerLtlsUoqlwNGvGvJNeWI/dzzfcb25dKOJsbumyg3EV8yoieOdRGhgy9
         OWlFEKrUvX705YIbmkb9oXeqaQcXwYWvdyW+piWBqaxipgsO1YgN7C7bw3Q3YPzKMmwp
         YPi/H6f5+ze3/CbgYY9qTQqd6BXtDtE1LH5Ahhzk16ybMrZJXE58pSx9b5GGENTuFIIL
         se7DvrPtFS2YbMwAsdkfT5hJ878SM5aI+qeHb8Hh+l4+kJdu4DbTaBEEkteWLD4rBd/R
         jR2Qp7wIjVqWUrj79FP66qW0gMPeMgMbtGq6vGfWky9HwpF+p1Q9yK26kFHCCYwAtnkJ
         6R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F5JDI78X2qf36ZQ9ireAqEU6JVwz17fAS60XT5JBQnw=;
        b=ghmN0KDsJQSRuGCd0jr7vHFCX9BSkWuV9a4x9AQXdCPBUKPk1eihH+elVPNkYNF2mN
         3Jh6BzvIyycyjNEZXe5xxL3rUZ7TWIz/1kjTBAkCJ/jb5MpuW+58m9epyh4meykicsjg
         hlqW5Gv7V8MKpnC7zyq3M3/sr54ZK5JetxH7ewzVkVfI2jhQcvUOMJwmejxSTXnYYEy4
         ZCKITVK0f2LLNS/46mrkAB8qDZ2ggsf4DqN92uCSlgF7vKXPi/dbbMDmrTOMalFAlRw4
         4RvpmVG3ZqNLxVdcSYmrrqO3mNLkmshnhESsnf6LPuYrTNCEiSFlYXm9aUKdH6t7e2yt
         s7mQ==
X-Gm-Message-State: AJcUukfvXD2MmlWwkUAJXICZTqPwtuykxoF9T6Z5abf898TC3cXYVt+u
        XpqfcJfOn1d6E1H0cv6JoOQJE9BK
X-Google-Smtp-Source: ALg8bN5WD033fqh0Jtc7hc0ZjkUG2TkIbhWnCvslfBPwt2qwLN4F2PnSZ7Fv1XqEy5yggxc4on9iVA==
X-Received: by 2002:a63:f1f:: with SMTP id e31mr10541449pgl.274.1546351557951;
        Tue, 01 Jan 2019 06:05:57 -0800 (PST)
Received: from localhost.localdomain ([39.119.71.29])
        by smtp.gmail.com with ESMTPSA id o13sm75551257pfk.57.2019.01.01.06.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 06:05:57 -0800 (PST)
From:   Chayoung You <yousbe@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/2] zsh: complete unquoted paths with spaces correctly
Date:   Tue,  1 Jan 2019 23:05:08 +0900
Message-Id: <20190101140509.1857-2-yousbe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101140509.1857-1-yousbe@gmail.com>
References: <20181230053125.55896-1-yousbe@gmail.com>
 <20190101140509.1857-1-yousbe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following is the description of -Q flag of zsh compadd [1]:

    This flag instructs the completion code not to quote any
    metacharacters in the words when inserting them into the command
    line.

Let's say there is a file named 'foo bar.txt' in repository, but it's
not yet added to the repository. Then the following command triggers a
completion:

    git add fo<Tab>
    git add 'fo<Tab>
    git add "fo<Tab>

The completion results in bash:

    git add foo\ bar.txt
    git add 'foo bar.txt'
    git add "foo bar.txt"

While them in zsh:

    git add foo bar.txt
    git add 'foo bar.txt'
    git add "foo bar.txt"

The first one, where the pathname is not enclosed in quotes, should
escape the space with a backslash, just like bash completion does.
Otherwise, this leads git to think there are two files; foo, and
bar.txt.

The main cause of this behavior is __gitcomp_file_direct(). The both
implementions of bash and zsh are called with an argument 'foo bar.txt',
but only bash adds a backslash before a space on command line.

[1]: http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html

Signed-off-by: Chayoung You <yousbe@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e8ec95c3..816ee3280 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2993,7 +2993,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -f -- ${=1} && _ret=0
+		compadd -f -- ${=1} && _ret=0
 	}
 
 	__gitcomp_file ()
@@ -3002,7 +3002,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+		compadd -p "${2-}" -f -- ${=1} && _ret=0
 	}
 
 	_git ()
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 049d6b80f..886bf95d1 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -99,7 +99,7 @@ __gitcomp_file_direct ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -f -- ${=1} && _ret=0
+	compadd -f -- ${=1} && _ret=0
 }
 
 __gitcomp_file ()
@@ -108,7 +108,7 @@ __gitcomp_file ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+	compadd -p "${2-}" -f -- ${=1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.17.1

