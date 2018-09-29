Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3337E1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 14:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeI2VYY (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 17:24:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33832 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeI2VYX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 17:24:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id z4-v6so7877696wrb.1
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBC4yyMg09kOZ9uEjJgdytMZIGnODAjriCYco4GdeHc=;
        b=Ebe7U68mzkMpAkKMg7WdZ1aviwD2gKQ/DYANGOQHrM04/dc9i9A5sVLq1A/8HU9aHa
         FZAnceQ8DNVUjvm5+v4fal3ConjQn7syZzZ74JZQ9znu9JG9/Iy0msn2qs8JjhrVbo6b
         qfr8LncUd2unD8eV70/An2PSo17hyB1xEi3k3JXPBV6nwfwzrLzD+h/T9JrkNQNOnOaK
         D/A4K3ETtkbWBpwsNC9tNgu1uCtWUHKE9ZAiFRImFxkZJQn9L8N1JU9KCKv7ZhbPh2SD
         FDWFC0h+v6OgrFuIDfhREtL84ai+CPA4bzzxOnotd35J27O2nc/cLbVegCoYzH860ie3
         EFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBC4yyMg09kOZ9uEjJgdytMZIGnODAjriCYco4GdeHc=;
        b=Aj0uie0aMtvcu8ObLhQHuQeAbBjOISugxQLTN7m/H6Rq/+iJSp9HebHAdozf9kOqi1
         xJykcvspHRHzWBLyms8MSffMYAT85Djv7rEvnXWcg00lJZb7gTQgrbND+o47NwC8RqfR
         Vz8YEVMfFZ1WnRntX9JKT/yfO2ur1FOTk/iA08EOR8PZ6/sCfYn5yL87YreCAdMqej/W
         YkoHSqQu0f2zvn6j/k2oJEgw6wqARyu2/1YpoBPDF1XxtKnuvl4JXUTbCQpmvLEB9WVX
         7ICl9Zk6YPqBOAuym6dDgOEtDMKDNnQxjndd0nsl0jrh5Grt5zPOlJNuji8Wx/v4p4RN
         4XZg==
X-Gm-Message-State: ABuFfojDTmsY5uOprpHBp9Ee32Jja00t7MhLpQb1NCKYzgIfZ1aKCwUN
        Tcl8CxW6HMoHwP8K5Bn4Z26y255h
X-Google-Smtp-Source: ACcGV631KkOhNwHpUnjdJ/RdMR1TiYwJE3I4No59LJtXTkWaxpohJse8szswWEvTm68bXT+F3dMpcQ==
X-Received: by 2002:adf:c650:: with SMTP id u16-v6mr2331943wrg.177.1538232938524;
        Sat, 29 Sep 2018 07:55:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k25-v6sm3048165wre.18.2018.09.29.07.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 07:55:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christoph Berg <myon@debian.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] grep: provide a noop --recursive option
Date:   Sat, 29 Sep 2018 14:55:27 +0000
Message-Id: <20180929145527.23444-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741
In-Reply-To: <20180929140132.GA31238@msg.df7cb.de>
References: <20180929140132.GA31238@msg.df7cb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This --recursive (-r) option does nothing, and is purely here to
appease people who have "grep -r ..." burned into their muscle memory.

Requested-by: Christoph Berg <myon@debian.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Sep 29, 2018 at 4:10 PM Christoph Berg <myon@debian.org> wrote:
>
> I often use "grep -r $pattern" to recursively grep a source tree. If
> that takes too long, I hit ^C and tag "git" in front of the command
> line and re-run it. git then complains "error: unknown switch `r'"
> because "git grep" is naturally recursive.
>
> Could we have "git grep -r" accept the argument for compatibility?
> Other important grep switches like "-i" are compatible, adding -r
> would improve usability.

I don't have an opinion on this either way, it doesn't scratch my
itch, but hey, why not. Here's a patch to implement it.

 Documentation/git-grep.txt | 6 ++++++
 builtin/grep.c             | 3 +++
 t/t7810-grep.sh            | 8 ++++++++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a3049af1a3..a1aea8be4e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -290,6 +290,12 @@ providing this option will cause it to die.
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
+-r::
+--recursive::
+	This option does nothing. git-grep is always recursive. This
+	noop option is provided for compatibility with the muscle
+	memory of people used to grep(1).
+
 <tree>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
diff --git a/builtin/grep.c b/builtin/grep.c
index 601f801158..02d4384225 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -785,6 +785,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int use_index = 1;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
+	int unused_recursive; /* this is never used */
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -802,6 +803,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show non-matching lines")),
 		OPT_BOOL('i', "ignore-case", &opt.ignore_case,
 			N_("case insensitive matching")),
+		OPT_BOOL('r', "recursive", &unused_recursive,
+			N_("does nothing, git-grep is always recursive, for grep(1) muscle memory compatibility")),
 		OPT_BOOL('w', "word-regexp", &opt.word_regexp,
 			N_("match patterns only at word boundaries")),
 		OPT_SET_INT('a', "text", &opt.binary,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index be5c1bd553..c48d1fa34b 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -469,6 +469,14 @@ do
 		git grep --count -h -e b $H -- ab >actual &&
 		test_cmp expected actual
 	'
+
+	for flag in '' ' -r' ' --recursive'
+	do
+		test_expect_success "grep $flag . (testing that --recursive is a noop)" '
+			git grep$flag . >actual &&
+			test_line_count = 43 actual
+	'
+	done
 done
 
 cat >expected <<EOF
-- 
2.19.0.605.g01d371f741

