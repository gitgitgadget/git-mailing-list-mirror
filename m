Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41031F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfKPSHF (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 13:07:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38844 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfKPSHF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 13:07:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so8221101pfp.5
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kb+1w9ZVb8QZuQQFDz2fdsOnwghU2rNqQ23n7iaPIK8=;
        b=BPdN9G0oMQuVGOcsik2853H4PSmefjKDTTuutQFocGLqcWs57Lg/RqBT2ssm6FJVU7
         py1VJpQb5lPnwOeIv2bpSEozRrUrhwyAQFUM2/i0HhB4P8zdZWEV6kblILtK2EHSLIbQ
         l9YsG0PEKUdNDX6/0ZUFKM1y57w/XKlcBN5gyLXU/NsemZiZRsPk8MJRiW7VWW5YpWVu
         ZTwBT4NM3q+R7MO6hMne1mcO3eDs3yXleuqCef4rFnU0DRr33YDl8actgOG7ms62pBil
         gWOd3l3B0luyGKR4SpbRHxg8NVhAONKx/cfFG3nTf38GUyWKmvlPeZqvwaJtfpW1PGA7
         QRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kb+1w9ZVb8QZuQQFDz2fdsOnwghU2rNqQ23n7iaPIK8=;
        b=de3nbm0DDo8ZhfE1f7DuxTmH3EfFeRRlugsz0HDRoUufc8nQNQ9OqjEtqq8uCi0mlz
         PehJAnn7Nx2qFgsgbesd0gTMQolY0RlHt8lcn0NTdPJkIozHQyj0d3JXMVGIA7Lf/kjw
         1C7tSXcwF6Byh92uebeQ2zfz22bg11gX27NswBQgDDYuPKqCSuDA/WKB2Eqj8NM1Iu40
         p/t7gqIb/u0mHauyatrfT1GlA7uhiuxgi/LeWyOkRv0h65XXGjDtgCDKXyDLSiqxhvCq
         ZLdzuVVvf29rOIkbyUq9UbPoUTQZR8kS85mBZimoKJKpTViWAoLTWMsWzGMaHz605Aoi
         RQgA==
X-Gm-Message-State: APjAAAUnm4b8EdQo/KgvvmAmz+yHX9CS90UhKprEAJ190tJKO1hwc/ij
        mari3C9n5oEci0KUpXaWv7DHa9djR1Y=
X-Google-Smtp-Source: APXvYqwwDrbjzcBUWLvO5lF54WKoWAYtHEP2JdifE+6d/8AYf11p7UmP3/YFWZIjjxjXu9dkqD4D+Q==
X-Received: by 2002:a63:dd58:: with SMTP id g24mr23472712pgj.376.1573927622693;
        Sat, 16 Nov 2019 10:07:02 -0800 (PST)
Received: from localhost ([49.230.7.85])
        by smtp.gmail.com with ESMTPSA id l21sm12124636pjt.28.2019.11.16.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 10:07:02 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 1/1] gpg-interface: limit search for primary key fingerprint
Date:   Sat, 16 Nov 2019 18:06:55 +0000
Message-Id: <20191116180655.10988-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116180655.10988-1-hji@dyntopia.com>
References: <20191116180655.10988-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The VALIDSIG status line from GnuPG with --status-fd has a field that
specifies the fingerprint of the primary key that made the signature.
However, that field is only available for OpenPGP signatures; not for
CMS/X.509.

An unbounded search for a non-existent primary key fingerprint for X509
signatures results in the following status line being interpreted as the
fingerprint.

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
2.24.0.156.g69483321b9.dirty

