Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 4120 invoked by uid 107); 18 Mar 2010 05:11:27 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 18 Mar 2010 01:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab0CRFKv (ORCPT <rfc822;peff@peff.net>);
	Thu, 18 Mar 2010 01:10:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54894 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab0CRFKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 01:10:50 -0400
Received: by gyg8 with SMTP id 8so828242gyg.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 22:10:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=KVSiRjN/uZD2MJRlDR8EbwGiOSskHALd5LKtEJq1BGo=;
        b=FNPWaPIRayZ34DnsAeg+bgWgOiNL6bPKCUbRrvIgBF1XgiV4VzumUie/fo0FlW3hV8
         /w5fAV3/Nc7Y7zoL0k/a81/Zv0W4r8FKtocIk/2zSmd2fc1KeGQOeqcoW20P8WW/e+/l
         J/+it0aud7I4wAfFXV9FtPMIhhA4aldYRhNVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hrm4TOyYDnO5pmps94HkxYOjHFPpRne2bzu/8hJaq04jfKHvo3H9rte0H3Gg0iQFMe
         dfudLDX6cD9M9W734xqzsoSL8cIQeqkL8PRyiQcfrKbtNgaDS5BBAkQM98te9cnjwjNZ
         hbUkBnHHfCUjAi+9bkD/c2yJbnB/j+fAJKX4A=
Received: by 10.101.29.9 with SMTP id g9mr2997276anj.234.1268889049047;
        Wed, 17 Mar 2010 22:10:49 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 16sm4953295gxk.1.2010.03.17.22.10.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 22:10:48 -0700 (PDT)
From:	Stephen Boyd <bebarino@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pull: replace unnecessary sed invocation
Date:	Wed, 17 Mar 2010 22:10:45 -0700
Message-Id: <1268889045-21751-1-git-send-email-bebarino@gmail.com>
X-Mailer: git-send-email 1.7.0.2.210.g5618b
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Getting the shortened branch name is as easy as using the shell's
parameter expansion.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Saw this while reading the code.

 git-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 38331a8..246a3a4 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -41,7 +41,7 @@ strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
-curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
+curr_branch_short="${curr_branch#refs/heads/}"
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
-- 
1.7.0.2.276.g60daf

