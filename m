Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D371F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 21:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKPV65 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 16:58:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35100 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPV65 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 16:58:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id q13so8378160pff.2
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 13:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxBLkUPF37w88sOVhnuNFI9mKJCZYJbgXmR4RiXcyOs=;
        b=XgwAdFhyk2fSA+G2tJBRvGW789EZ+zWaXksJebZOJ3WsfwdudAaRX07bz8/W7EFMmW
         a3ifHT+v4yvYCpdc9aMiX8c/5aYOWG+KUKY4ZP42Byf5eG1Mrha0e7rSaanDqt4ISS+g
         RNaF/hIamkDhLWBA0jPPUIzfGTB0kGqNfjjSCeybA0GkgM60f7vM4WSW+LL+hOxQYfvd
         frsGly2IpbzeJf2+gi0q6yt+LcblhiFvHBkijok5jL+H9Z8kH+PQRK4V2ZnbxwAmufGG
         /lQzusd163Mi/hW3hiJz10OrScRjky5gTQ+9Fd39k3VYBWU2hzG1XeRLq5Iiqp9iCLJs
         K+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxBLkUPF37w88sOVhnuNFI9mKJCZYJbgXmR4RiXcyOs=;
        b=NUHFyTr8NTslaOu9tJ0EXVKRSRhRrIIJPSNcN6I4GvnfJ0T/d4KxPaLVUyU0arth9Q
         t+dAwNHQ0kVEtg8yKmrb0azp1JHwxrB5tkF0KP1EArOzlw9ZbQZ7yZT7HaJ15tCpEnTL
         8Ok74YfUaK/Y7OIiKgKMdE9g5OLJYhqVjexWuorZ0Bja/t4T8C+Cnt8XTVEuT9I/eEov
         28loSwKBXUGHdgCrllY4IiUpUfFu7jkS9fOR78zYZkzzCDZDvIa/C2/Qjhcey+b/LLlb
         JScVIK4dD52PfGLJM/ooIEC9PEgCO2Mh4OPVXMrgIu9XRX3oz9HDaaMCzNT0xMgK1cbB
         0YAQ==
X-Gm-Message-State: APjAAAU/ZGn9ak2UX6kQxbobf1uEKVgjrMJA13CbDd7Z5cyTuopjUaJP
        9ig3mb0KwHXdrCMhpFqxRX0IWNK9YdY=
X-Google-Smtp-Source: APXvYqxI4IPx0GiDNOOvFnZ6CuoSHHZHPkSB4ByGjmL8ActIFEvcl5LFbZV+DKFQSdB5oWauUmNcpA==
X-Received: by 2002:a62:1953:: with SMTP id 80mr25952841pfz.72.1573941536711;
        Sat, 16 Nov 2019 13:58:56 -0800 (PST)
Received: from localhost ([49.230.7.85])
        by smtp.gmail.com with ESMTPSA id m67sm13826940pje.32.2019.11.16.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 13:58:56 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v2 1/1] gpg-interface: limit search for primary key fingerprint
Date:   Sat, 16 Nov 2019 21:58:50 +0000
Message-Id: <20191116215850.3919-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116215850.3919-1-hji@dyntopia.com>
References: <20191116194945.GA244853@google.com>
 <20191116215850.3919-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of implementing signature verification for git clone, I decided
to refactor/unify the code for commit and merge verification to make it
reusable during clones.

This lead me to discover that git requires merge signatures to be
trusted (as opposed to TRUST_UNKNOWN or TRUST_NEVER).  This is unlike
the behavior of verify-tag and verify-commit.

So, I figured that I'd make the minimum trust level configurable to make
the behavior of merge/commit/tag consistent.  And while doing so, I
noticed that parse_gpg_output() in gpg-interface.c assumes that the
VALIDSIG status line has a field with a fingerprint for the primary key;
but that is only the case for OpenPGP signatures.

The consequence of that assumption is that the subsequent status line is
interpreted as the primary fingerprint for X509 signatures.  I'm not
sure if the order is hardcoded in GnuPG, but in my testing the TRUST_
status line always came after VALIDSIG -- and that breaks the
possibility of a configuration option to set a minimum trust level since
the TRUST_ line is consumed by VALIDSIG.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 gpg-interface.c | 20 +++++++++++++++-----
 t/t4202-log.sh  |  6 ++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index d60115ca40..01c7ef42d4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -148,21 +148,31 @@ static void parse_gpg_output(struct signature_check *sigc)
 				}
 				/* Do we have fingerprint? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
+					const char *limit;
+
 					next = strchrnul(line, ' ');
 					free(sigc->fingerprint);
 					sigc->fingerprint = xmemdupz(line, next - line);
 
-					/* Skip interim fields */
+					/* Skip interim fields.  The search is
+					 * limited to the same line since only
+					 * OpenPGP signatures has a field with
+					 * the primary fingerprint. */
+					limit = strchrnul(line, '\n');
 					for (j = 9; j > 0; j--) {
-						if (!*next)
+						if (!*next || next >= limit)
 							break;
 						line = next + 1;
 						next = strchrnul(line, ' ');
 					}
 
-					next = strchrnul(line, '\n');
-					free(sigc->primary_key_fingerprint);
-					sigc->primary_key_fingerprint = xmemdupz(line, next - line);
+					if (j == 0) {
+						next = strchrnul(line, '\n');
+						free(sigc->primary_key_fingerprint);
+						sigc->primary_key_fingerprint =
+							xmemdupz(line,
+								 next - line);
+					}
 				}
 
 				break;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e803ba402e..5d893b3137 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1580,6 +1580,12 @@ test_expect_success GPGSM 'setup signed branch x509' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSM 'log x509 fingerprint' '
+	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
+	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
 	grep "^| gpg: Signature made" actual &&
-- 
2.24.GIT

