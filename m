Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D049D1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 13:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeCKN7S (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 09:59:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44018 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKN7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 09:59:18 -0400
Received: by mail-wr0-f194.google.com with SMTP id o1so1377998wro.10
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lrgj6dxqaxkA0N18ztn8lQNH24bbCJyGQMpgASUETWw=;
        b=KgIqFiqLsBGqbDMJBkfItr/q/Y+BGGlqQvCZjqGlIDwq2HoOtF9v0wqAhF4nshEIzq
         kjPuFOrWdRfr1qMoIPkAZCUb8Fe4B3uKzRg/bJZSg2nNkSvsDfVgrwOxu8J+JQbE06OY
         fWLLN2Jx6m4SZ9R2WjEsldv0NrieTfP1eoM9BFW472kYtwsMRQSGpsd4x8CqUCN1ZOZ2
         HpiBwZSk66FFid4Lewp5oOw7SvaMRlniehQwzgx+ms++MWLg6BlcPWmVSwlmLJT1ARJH
         7swYp0njAXarjyB5/eUSFnjOm7NcYYr22P6X00K9PZ7C3ExLQ3B5593R89kjKbEClwHf
         Ecxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lrgj6dxqaxkA0N18ztn8lQNH24bbCJyGQMpgASUETWw=;
        b=DCAeCGKVLjuuKTgrOKooaleN8lQm6wRV1M+8ynPedTD+SRXnCpKvXz2QqZRyiz7QAO
         7/4dR6/qkqBor5XntOzFvBXOXHz4jlXi8Vu7ug45TfWguHGT76x9UZ4iyoVHMgd42s/2
         HPoPTYQKrOGNOf0ih5CPz1HZH0YB+yWC3X7BUXIRpbQUycng/MoT/Mu1dBWkceqw+JdK
         CmnJksad0cCEQVlIeg+1RIF1/9f2Yt0wTdhc7CIm863QVz6fuPXrvfKS5FgEK0WYU7Er
         Gnx5B41mGlTkwUrOUHKNpzDPZedYQKc6uO+HVgfLY2X7o2VCNRnoB7PMeZETGco0dUWK
         JuaA==
X-Gm-Message-State: AElRT7GmQhRXX1iGcuBRfEIeV3eWbMwq8yw95f4IQt1NQhMXNY6bqTcK
        9cFrw+miPrQ4F63FAxcJaifRkg==
X-Google-Smtp-Source: AG47ELuG+yfU11nAhv3LceG3o0F+IHuK386jwAbo++e98xgStW3PF5nRNqzonvmf+E88lFg94GIy7Q==
X-Received: by 10.223.152.80 with SMTP id v74mr213431wrb.163.1520776756642;
        Sun, 11 Mar 2018 06:59:16 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:6470:d27b:6b84:5144])
        by smtp.gmail.com with ESMTPSA id c192sm3505133wma.12.2018.03.11.06.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Mar 2018 06:59:15 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2 1/2] git-svn: search --authors-prog in PATH too
Date:   Sun, 11 Mar 2018 14:58:34 +0100
Message-Id: <20180311135835.9775-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311135835.9775-1-asheiduk@gmail.com>
References: <20180311135835.9775-1-asheiduk@gmail.com>
In-Reply-To: <20180304112237.19254-1-asheiduk@gmail.co>
References: <20180304112237.19254-1-asheiduk@gmail.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 36db1eddf9 ("git-svn: add --authors-prog option", 2009-05-14) the path
to authors-prog was made absolute because git-svn changes the current
directory in some situations. This makes sense if the program is part of
the repository but prevents searching via $PATH.

The old behaviour is still retained, but if the file does not exists, then
authors-prog is searched for in $PATH as any other command.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/git-svn.txt | 5 +++++
 git-svn.perl              | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 636e09048e..b858374649 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -657,6 +657,11 @@ config key: svn.authorsfile
 	expected to return a single line of the form "Name <email>",
 	which will be treated as if included in the authors file.
 +
+Due to historical reasons a relative 'filename' is first searched
+relative to the current directory for 'init' and 'clone' and relative
+to the root of the working tree for 'fetch'. If 'filename' is
+not found, it is searched like any other command in '$PATH'.
++
 [verse]
 config key: svn.authorsProg
 
diff --git a/git-svn.perl b/git-svn.perl
index a6b6c3e40c..050f2a36f4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -374,7 +374,8 @@ version() if $_version;
 usage(1) unless defined $cmd;
 load_authors() if $_authors;
 if (defined $_authors_prog) {
-	$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
+	my $abs_file = File::Spec->rel2abs($_authors_prog);
+	$_authors_prog = "'" . $abs_file . "'" if -x $abs_file;
 }
 
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
-- 
2.16.2

