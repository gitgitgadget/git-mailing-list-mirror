Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03BC1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeFZHa6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:30:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46910 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeFZHav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:51 -0400
Received: by mail-io0-f194.google.com with SMTP id u23-v6so11297531ioc.13
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8eWBW655dbo+k+BYFbGPLv1IrJCS+7VtZ57LOXmPEpo=;
        b=W2+Bjy3sOTf6vJvoA6HL+suNm/2SlKBcvn6DfOw/us1XT1DVI1xbxey5t8WpHM+1+8
         OHdka7bNE8cKnt37p79uA8QZzEulUBAr4xAAEHpWV6KM6tQYS1I75ukWfp9cBxBEVAN3
         LXNfUzpaTQpQl2C18wArGzR/V+02o5R6vpimUYghKn9TWnCwfMhr5/CDnnWr/vUxbZur
         J9oOtnS4cb6bFD1Te00cBimI/2iMHPGuNo93Nl0HyGLl6fo6KXVY9c9lQhud1833kTJa
         LSCyoIMmoTGhSOvdfrFUy3OeI7G/v2whruqaCdQ9NlyyzdCHRbvdZ1PfqahjPn3SEokb
         ot7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8eWBW655dbo+k+BYFbGPLv1IrJCS+7VtZ57LOXmPEpo=;
        b=VOn7j+6Jr2w6wIZQOF1jJJUr7vM8cj22w//DccjsY3L5vTYb7kDPKfbAL3z+nIVKFO
         lGvSZO+uoGFpoHuk8FhpFFmKPB9YTJQeq6MBj+b8Sk6r9EOeH78/mDTRvB9+nVVZLMsP
         36mkT50apONt87zw1xHtaYk61qZaD3Weh/sZ1nFV6Se66eXOBfRckJksmZ2Nshf9GnPf
         5ft02DtVxB8wU3r7rx3XxDQA0G43FIvmVi5lifA0fByaVlJAZpO6xCavURBFrWZnB+tt
         2EMWj6+CDLNggeHFPjo2T8sneO5V6G4/4SycfxouNK6ipCmmD7RA8HpvSo1CT9hg9w4D
         oBxw==
X-Gm-Message-State: APt69E24+FMniMe8oejtSl/jjGSe6d6PpiwRQT22UqFiPVfObYgxBIWF
        Xl9Cp7SC7nX4mi6Z1cJ/53Yf0Q==
X-Google-Smtp-Source: AAOMgpcyspDVPEJm1vK7s3NgGiWeiYdtTKe+FUNn8Ox20OVibJKzuoWDhEv98ljd6blpBWlf8WzzdA==
X-Received: by 2002:a6b:4917:: with SMTP id u23-v6mr285492iob.3.1529998250746;
        Tue, 26 Jun 2018 00:30:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:50 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/29] t0001: use "{...}" block around "||" expression rather than subshell
Date:   Tue, 26 Jun 2018 03:29:34 -0400
Message-Id: <20180626073001.6555-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses (... || true) as a shorthand for an if-then-else
statement. The subshell prevents it from breaking the top-level
&&-chain.

However, an upcoming change will teach --chain-lint to check the
&&-chain inside subshells. Although it specially recognizes and allows
(... || git ...) and (... || test*), it intentionally avoids treating
(... || true) specially since such a construct typically can be
expressed more naturally with test_might_fail() and a normal &&-chain.

This case is special, though, since the invoked command, 'setfacl',
might not even exist (indeed, MacOS has no such command) which is not a
valid use-case for test_might_fail(). Sidestep the issue by wrapping the
"||" expression in a "{...}" block instead of a subshell since "{...}"
blocks are not checked for &&-chain breakage.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0001-init.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c413bff9cf..fa44a55a5b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -260,7 +260,7 @@ test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shar
 		# the repository itself should follow "shared"
 		mkdir newdir &&
 		# Remove a default ACL if possible.
-		(setfacl -k newdir 2>/dev/null || true) &&
+		{ setfacl -k newdir 2>/dev/null || true; } &&
 		umask 002 &&
 		git init --bare --shared=0660 newdir/a/b/c &&
 		test_path_is_dir newdir/a/b/c/refs &&
-- 
2.18.0.419.gfe4b301394

