Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547AC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CD6207DA
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jaMuq3D2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgH1Uq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:46:57 -0400
Received: from avasout04.plus.net ([212.159.14.19]:33865 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1Uq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 16:46:56 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id BlGvkgZgxrXCcBlGwkwGbe; Fri, 28 Aug 2020 21:46:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1598647615; bh=cxLV8x0hwBxhyv1CrQv8CWk7alOqiLsjrfCI9myyspU=;
        h=To:Cc:From:Subject:Date;
        b=jaMuq3D2zCcpNXzbcVGzgyYTLsFGiZvHTXlofgav0pRsN7j8ciIcg0t/Sopw7uVnx
         bWYSpUL+MPBKQYs2chS1bg5QFX4nuvzForKm7HX1rQZIcKiG5FrjuKKBPSaopDIbx6
         1m3Bp4C01q/Y99XMEuUj3n/3+VhpR1PTWrIHp4chjXYa8lX1ctJSgw6a+yGIwY82Sa
         itTaeuMYYC5phl8DVohKpAFTpcefSp8rmNJOGboPN2pgbYlY3OYKjOhUCWJdeEvwn4
         ZD6DTBlR/3+ioi5k11mWe8s6KURKAf9ctRwvdfT55bneSjJpUZ1F7STnyIN5BK0bFC
         SjGzcbu9cqvIg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=-sCiuHgE3n1BY3n1CqcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/init-db.c: fix a sparse warning
Message-ID: <8d4b4011-b8a2-c0e0-a3f2-28c7bbec040b@ramsayjones.plus.com>
Date:   Fri, 28 Aug 2020 21:46:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLktFKrVEwyK6rqY7zv9DvWpavxSUD9jHezJG6c3rUxUjjLWD5PI7cfRZwT5oLTTvN82xii3ukhe17TXJlJEjFCZbZjv1bwOiPlWmUNWi794h4cifzhc
 hshgpt71rWNdz/000PVXKf0EBLBHEuB0cmj4FoArAlHFZdwYAzCST0qOZsWVLReK58maKQfuyRx3+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Eric,

If you need to re-roll your 'es/worktree-repair' branch, could you
please squash this into the relevant patch (commit 44a466ca7f (init:
make --separate-git-dir work from within linked worktree, 27-08-2020)).

Thanks!

ATB,
Ramsay Jones

 builtin/init-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6a94d20a2e..cd3e760541 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -661,7 +661,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			if (chdir(mainwt.buf) < 0)
 				die_errno(_("cannot chdir to %s"), mainwt.buf);
 			strbuf_release(&mainwt);
-			git_dir = strbuf_detach(&sb, 0);
+			git_dir = strbuf_detach(&sb, NULL);
 		}
 		strbuf_release(&sb);
 	}
-- 
2.28.0
