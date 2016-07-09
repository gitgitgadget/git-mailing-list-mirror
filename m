Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBA32018E
	for <e@80x24.org>; Sat,  9 Jul 2016 12:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754AbcGIMuE (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 08:50:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33695 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbcGIMuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 08:50:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id l188so8966605lfe.0
        for <git@vger.kernel.org>; Sat, 09 Jul 2016 05:49:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pu6sPChMg1iofmvvnKa7zt8+1PWVCjbHtFFxb6ixC/Y=;
        b=Gs+3WAC8SvQzHHgdXTac8PjJ22PkQV1nyt6MBf/oS6nNt/KRFKwS9Ly2dmzq28pWSF
         NRhHPfRKmxzDK+TxJzRjHDo5S5j6RYub9FgvGypM/WRbKI5RGrxZpKpNSmC/+oCtS71Z
         bekrlcEzHs6w2P1DLj4at36+YeBft/GLr2IAmCoo/P6nL8tYG/GcO5CjiAN1EY6emxbJ
         9t1HzUx6b+bnP9ZXxYsEzSLsXIDZBRJydtGqD2x5WhnUEfjBuj3Rg9Xt0ZO+NPfeIb1/
         DdJycVSML/FQSi+gH86F58AdjKCQtR3bcPMjkXsa3fuakrPWeXEkHUMx15K972IkFWr5
         awGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pu6sPChMg1iofmvvnKa7zt8+1PWVCjbHtFFxb6ixC/Y=;
        b=EYGFB9L2phuOA+8MSFfbxA5i9wopJOnhevM48Qj1XrZDtwftp0qzQ6NlzNMRyIkIYt
         15cAUmNGEaxc4XKwra3V6UkdO2fzEHQRpsN9Jd9KkExVv4c90XpiJrr4iIbC9tohQVWc
         yFL0idSt5tmBdkiJwhjbiSykk4iXHZ3hGE8IN7hFnu8ktkQYqBUysEQJXpZW54Pq6EPt
         msujVVYSnk7lmPBV8jjqASGSFZmuS9ElzJoFhjD+ncOYJmbguXHfoA+5ASYjzUQZf770
         21oMBD8Hl0nw9A042k+faAXBFSz7RKZ8ah4t+l61xsAQy5i4F0v0UZw/vVhmJ2EI8BB2
         U1qg==
X-Gm-Message-State: ALyK8tKh2zBGMBZzGmAe+3ob2ajCEzeVSE9Zh18pn8TuGt4MPnkHnSiWMWxza8iA5WX5Mg==
X-Received: by 10.25.133.135 with SMTP id h129mr2861913lfd.28.1468068598756;
        Sat, 09 Jul 2016 05:49:58 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id a199sm2844784lfe.35.2016.07.09.05.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Jul 2016 05:49:57 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, j.cretel@umail.ucc.ie,
	Jeff King <peff@peff.net>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] log: decorate HEAD -> branch with the same color for arrow and HEAD
Date:	Sat,  9 Jul 2016 14:49:49 +0200
Message-Id: <20160709124949.5363-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <CACsJy8Df29zR4bJynHvwOFQobVS8X-08D9K1UPs7QYXd_bkCCg@mail.gmail.com>
References: <CACsJy8Df29zR4bJynHvwOFQobVS8X-08D9K1UPs7QYXd_bkCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Commit 76c61fb (log: decorate HEAD with branch name under
--decorate=full, too - 2015-05-13) adds "HEAD -> branch" decoration to
show current branch vs detached HEAD. The sign of whether HEAD is
detached or not is "->" (vs ",") because the branch is always colored
by type. Color the arrow the same as HEAD to visually emphasize that
the following branch is HEAD, without paying too much attention to the
actual separators "->" or ","

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I'm going to take Michael's silence as no objection to the recoloring
 the arrow. So v2 changes the arrow's color instead of the branch's.

 log-tree.c                       | 2 --
 t/t4207-log-decoration-colors.sh | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 78a5381..e647b08 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -263,8 +263,6 @@ void format_decorations_extended(struct strbuf *sb,
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, color_reset);
-				strbuf_addstr(sb, color_commit);
 				strbuf_addstr(sb, " -> ");
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index f8008b6..b972296 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,7 +44,7 @@ test_expect_success setup '
 '
 
 cat >expected <<EOF
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}${c_commit} ->\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
  ${c_reset}${c_branch}master${c_reset}${c_commit},\
  ${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
  ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-- 
2.8.2.537.g0965dd9

