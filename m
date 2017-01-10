Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5B1205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760545AbdAJItT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:19 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36060 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760480AbdAJItR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:17 -0500
Received: by mail-pf0-f196.google.com with SMTP id b22so11590184pfd.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05zTfZX0grb+2jhgf1e+fl7a66G/jOvXiy8Vy7i2vCw=;
        b=aFzgn0+NJp0BIqlESisQXSNEveLDEF2eV9/N3xIMsHAwjOM2+HMkkl+0nTUOFgzyNP
         jc06USgQO0X9Dr1Jw9jtZij90EjwQFLvWQHPHhDCu4/Q7luRQKnTUp1ej8CcLScYyhiy
         vOT4WhK4Qls0sDLXZv5piZP+f9BgP9ZL26J0iw6OxA8jPx3D5YctiBvvCW+I6AOt1wtR
         h43FIcfvaL+jxzbXkkYqS3PU+vVCspZbCp0y6F5aI5D4SJ8LR/z1oxc2zHZx4bTnb3ch
         0OhwnhbvbFfiyw/IqVUksrhaeJPwFAOp0kX3Ifi+7ty8D/F9WURzSYSdFNKadnGITHPY
         IlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05zTfZX0grb+2jhgf1e+fl7a66G/jOvXiy8Vy7i2vCw=;
        b=s6iZZdLnKuS9xZyK4NfNpVCZG/NdjFsFDQUz7AdlyTBdjiyF6Jvd48+BVme/fB0Qjn
         WmR8OyTJj8PiRSTx0JYQb+nGNcrZ78GDHjcZi/j7jK0vPCVnr25thFKDvKTbIyW4aqSd
         XbOra6AwuLfWbh0JTJeeffNNbZN3E81WMr0JKslt/KXL9iHKdI3smNDgDiFuEdJH6UZh
         6y56k/ZO4ZxHDNBdwaVUyeo8m0tOnwYgecP2DEEvdepQ4vThkxjyS8IgJ83xAHiK8AYN
         Dv7yW4VuSUzJEnrEDKfqFKEszf9p8QPkTKzQx6Mw3iPMZGVcBaS4e+CytbTyr+SP3ZYN
         6pNA==
X-Gm-Message-State: AIkVDXLUuTbE+Yk4OrlPM1Xov5Ypjsg+bl5VSsrGV0Ryvp83vj27aIFrcdeHkQbc699iiA==
X-Received: by 10.98.10.198 with SMTP id 67mr2524157pfk.157.1484038151865;
        Tue, 10 Jan 2017 00:49:11 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:11 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v10 09/20] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date:   Tue, 10 Jan 2017 14:19:42 +0530
Message-Id: <20170110084953.15890-10-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by comparing with the valid_atom rather than the
used_atom.

Add tests for %(symref) and %(symref:short) while we're here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6de0927d1..e98ef4bb6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -352,7 +352,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index af76dc530..7663a3661 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -566,6 +567,7 @@ test_expect_success 'Verify sort with multiple keys' '
 	test_cmp expected actual
 '
 
+
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout master" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
@@ -600,4 +602,26 @@ test_expect_success 'basic atom: head contents:trailers' '
 	test_cmp expect actual.clean
 '
 
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0

