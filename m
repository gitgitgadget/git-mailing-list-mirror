Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6251FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 16:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbcF3Qkp (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 12:40:45 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34677 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbcF3Qkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 12:40:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so8940367lfl.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 09:39:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIVJNZt61BhabjN1NH8AcYIi1mLLqVwLjaU1iNMVqFw=;
        b=h0tVSGFs+ZAHID1t7MjhLQOCkD6DUXZSUjq64ht5wClBJ1FsryE9kME8xlhxnTrxgU
         fDUX0Vj0xwSG/Y6SpM9HCCxiwWLvayme0vJ0tT9XotnakDCdrAVuGmOyVsKdagFg6TGr
         NmFpb3blIcQTbA0fpm0tWcvRSuRu0VdWzxObah6OzddDxuq33zZjBfd/LJkrJ8Iju1RE
         hWAJg/0L/UnajeuVS+RzDusjXL1vgQeS38sRB878QhDGn+Zo94lZmvjmQZyxC/veT0mZ
         InJENenz3BD2eGGCO+i03R+wrv0Hu4utNzo+aLFOpvbwu2FJHtalzJucFHq9gkX6IQLp
         nkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIVJNZt61BhabjN1NH8AcYIi1mLLqVwLjaU1iNMVqFw=;
        b=Is6q3ZXcqYzV1Y+E1ElFlGrgaLg837MfvPpJt7jh1SujQZ+VhdbwGVPJRO7C2iDsRP
         848PiiFO14Topw5fn/lOEAyYF7yioZW1rI6/2+3uCMD7QRRGYAYBDV0Ra2G2Q92Ygog3
         Pk/YzrLJqbIUNfkQ29Bbk1KA9+uV3VKOHgAvoRBAjjgYUHAormX0JEpBuMGDnktcJl7T
         vD1V6DqKM3R0hV+hore9fIBZhqO53OmhHAoLppvMCyeLPcb3snW8IoJF1uVFBpXZqxuZ
         5E6s+toTS79Qki0RVIoqWNaHJGgebP27/uNy1Uq8qxwpRKgHCyzFmKdbcvFiFzb1G5M3
         Epxw==
X-Gm-Message-State: ALyK8tLv+AtkxxYPUxm8q6eCpBWHezeOfhXJYTR1PR2QdNqMs96+rwP0LlTYSP01qxTk2w==
X-Received: by 10.25.25.137 with SMTP id 131mr6023767lfz.149.1467304794256;
        Thu, 30 Jun 2016 09:39:54 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id e17sm1660987lji.32.2016.06.30.09.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jun 2016 09:39:52 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	j.cretel@umail.ucc.ie,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] log: decorate HEAD -> branch with the same color for branch and HEAD
Date:	Thu, 30 Jun 2016 18:39:42 +0200
Message-Id: <20160630163942.8353-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
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
detached or not is "->" (vs ", "). It's too subtle for my poor
eyes. If color is used, we can make the branch name's color the same
as HEAD to visually emphasize that it's the current branch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 For the original discussion of 76c61fb see
 http://thread.gmane.org/gmane.comp.version-control.git/263922

 log-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 78a5381..440e7cc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -267,7 +267,7 @@ void format_decorations_extended(struct strbuf *sb,
 				strbuf_addstr(sb, color_commit);
 				strbuf_addstr(sb, " -> ");
 				strbuf_addstr(sb, color_reset);
-				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
+				strbuf_addstr(sb, decorate_get_color(use_color, DECORATION_REF_HEAD));
 				show_name(sb, current_and_HEAD);
 			}
 			strbuf_addstr(sb, color_reset);
-- 
2.8.2.531.gd073806

