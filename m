Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DB31F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbdBCCyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbdBCCya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so1192473wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XS7l0dmeBZJV3X36ZmrFNzMgyij6uAVNYSpDiHZo4Oc=;
        b=Gzn+lM18q7Hm8TabSz193ewVB2TCW/5WmZ+c96NYwld9mT3aYe2VJJC/N2rSeNLEHP
         B21F6mRTQBXg8STFhNbhcyjH8azstpk2UKyJYmVT8H2TmvrLkcR3rxxrFmz/7Yvnailg
         IJt5H3tQA6UzyuKm8JFQA2o8k8sotmckCX6AAKKvP3xr4QwM55D0EMj/JrSe8D7kvBWA
         OAE+2+9/tS9z178LdcoK7JkRTd10jkm9cjpTZfpKn/98+LUM10SdBevUEzmvhAoA4oVT
         re7suEVF/yqlLA78dV+z3LprAN81FrwCC1/4D06LJ4TaZ0wH+gXfUTqwy+TUPJsBaXja
         kaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XS7l0dmeBZJV3X36ZmrFNzMgyij6uAVNYSpDiHZo4Oc=;
        b=lk8sKJ/19/GsjgIR41c7eP3PpKnmX0b4XQEMvIZeHYIIXubhfqhEjw2V3XZ/PEj7nl
         SBWCelA6vKghstGUEthSIiEClIO8L0DsPucDmIMumZHWsSNJgeALzAibevVx09kEzAIn
         yA4G0akLSRvQJtTiFDXPCCVuiz4Y5XdZqVAR8vB4Je5K4BsajdMlAnVgwFY1NU1i+ELQ
         DZra5cOmFXCfCSYoWyyVEk4HcUBLLIVkjoq+Jy+VSrqvDNal7hzuGWZv7/FYsBqp5mq3
         yOx6rA7QmlDZer4CZaQBFtgz/0zMWEsiGXcTIbfYdJG8Y5QNN/6eEhJQ4IzOqfcMC2y3
         Cm6Q==
X-Gm-Message-State: AIkVDXJySGwR4pulXpWdWzavYIAxcpQCeRxDY1ChRmyTW9Z5NQzMG+r37yglwH9Iep3Vuw==
X-Received: by 10.223.166.181 with SMTP id t50mr10092076wrc.80.1486090469081;
        Thu, 02 Feb 2017 18:54:29 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:28 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/12] completion: don't disambiguate tags and branches
Date:   Fri,  3 Feb 2017 03:53:58 +0100
Message-Id: <20170203025405.8242-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the completion script has to list only tags or only branches, it
uses the 'git for-each-ref' format 'refname:short', which makes sure
that all listed tags and branches are unambiguous.  However,
disambiguating tags and branches in these cases is wrong, because:

  - __git_tags(), the helper function listing possible tagname
    arguments for 'git tag', lists an ambiguous tag
    'refs/tags/ambiguous' as 'tags/ambiguous'.  Its only consumer,
    'git tag' expects its tagname argument to be under 'refs/tags/',
    thus it interprets that abgiguous tag as
    'refs/tags/tags/ambiguous'.  Clearly wrong.

  - __git_heads() lists possible branchname arguments for 'git branch'
    and possible 'branch.<branchname>' configuration subsections.
    Both of these expect branchnames to be under 'refs/heads/' and
    misinterpret a disambiguated branchname like 'heads/ambiguous'.

Furthermore, disambiguation involves several stat() syscalls for each
tag or branch, thus comes at a steep cost especially on Windows and/or
when there are a lot of tags or branches to be listed.

Use the 'git for-each-ref' format 'refname:strip=2' instead of
'refname:short' to avoid harmful disambiguation of tags and branches
in __git_tags() and __git_heads().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 63e803154..19799e3ba 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -340,12 +340,12 @@ __git_index_files ()
 
 __git_heads ()
 {
-	__git for-each-ref --format='%(refname:short)' refs/heads
+	__git for-each-ref --format='%(refname:strip=2)' refs/heads
 }
 
 __git_tags ()
 {
-	__git for-each-ref --format='%(refname:short)' refs/tags
+	__git for-each-ref --format='%(refname:strip=2)' refs/tags
 }
 
 # Lists refs from the local (by default) or from a remote repository.
-- 
2.11.0.555.g967c1bcb3

