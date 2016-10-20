Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018891F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbcJTVkR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:17 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34088 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbcJTVkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:10 -0400
Received: by mail-pf0-f176.google.com with SMTP id r16so43659542pfg.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EcuJXfjIrqtsgweiGSl/2fDnAfFHYDipEJ3qWLAI3QE=;
        b=QzBkrWNckN4Ifyur/HwkCmwaeESanluqNhsvi5WJwKAn+KL+ELRwGi/hFm1Jmw/9Cc
         RND75fcc8HmISduXVcaRPsw8DJ/YOxFCGC48C1GEqV9q6IL9SudtfFyZYNAfCjY2Zzdk
         qCDdyBFC0DVlJx7x5TT3qGPXUXVOf2xJgkKfbiIObL7WnuHHG+6nk2U2gwz3JubttdOa
         aRS3fDb/0mbh6TGHAOnc3L38UdHIDR8ZlFc2C9wqcXhFCCyW9HIHqv8225resN/49xe8
         3pYOk1LxxFI5z6h1WtGKZDOwIXxt5x32H6b0Sqt/jtXjpRDKwCsW4xKM9lGfqV0WjSNf
         tTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EcuJXfjIrqtsgweiGSl/2fDnAfFHYDipEJ3qWLAI3QE=;
        b=Ofkk+k0SMKQCF1ifpGrD6TRFyRD4WYLRPbWVkadazU9OSnl2HGOBVkIWk6DDd3Ftdi
         hhD59BMTU/lR3CqB8Rh2/NcEjkQt3q4HjbuK6HzFgukmeI0Z5i1Dsd/hz5b9UlGLYDsw
         aWRs3cgUSKkMrQdwG10Hss6vNBX0pbJTWKV4yOo5u8sglWy9pbHmdolGM3BUzcfehoNF
         6R6kIQOz2dQFeg4MveW5CxDK/bcvC3E2n3voLXv1VqzoPntmGAmrAoysWtT1CwwRJobf
         KPnaLaEuupnW9qKhs7y1K+Su4+ajTRsNYqLTIXPBHgmPjLvMX4rl6s3SWsbRmt97joa0
         PA/A==
X-Gm-Message-State: AA6/9RkaAOoajAsbbkM5ecnwq+tdyhlIQmRUZq5oOIMQgDaENNnEVtkcWXGTEVRjLA7xM4H4
X-Received: by 10.99.140.12 with SMTP id m12mr4053787pgd.45.1476999610003;
        Thu, 20 Oct 2016 14:40:10 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:09 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 7/8] trailer: forbid leading whitespace in trailers
Date:   Thu, 20 Oct 2016 14:39:52 -0700
Message-Id: <37072b5f568747cdde8a54ce4a2f7d8759359c55.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476998988.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476998988.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, interpret-trailers allows leading whitespace in trailer
lines. This leads to false positives, especially for quoted lines or
bullet lists.

Forbid leading whitespace in trailers.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-interpret-trailers.txt |  2 +-
 t/t7513-interpret-trailers.sh            | 15 +++++++++++++++
 trailer.c                                |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index cf4c5ea..4966b5b 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -55,7 +55,7 @@ The group must either be at the end of the message or be the last
 non-whitespace lines before a line that starts with '---'. Such three
 minus signs start the patch part of the message.
 
-When reading trailers, there can be whitespaces before and after the
+When reading trailers, there can be whitespaces after the
 token, the separator and the value. There can also be whitespaces
 inside the token and the value.
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 003e90f..3d94b3a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -241,6 +241,21 @@ test_expect_success 'with non-trailer lines only' '
 	test_cmp expected actual
 '
 
+test_expect_success 'line with leading whitespace is not trailer' '
+	q_to_tab >patch <<-\EOF &&
+
+		Qtoken: value
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		Qtoken: value
+
+		token: value
+	EOF
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with config setup' '
 	git config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index da15b79..3ef5576 100644
--- a/trailer.c
+++ b/trailer.c
@@ -770,7 +770,7 @@ static int find_trailer_start(struct strbuf **lines, int count)
 		}
 
 		separator_pos = find_separator(lines[start]->buf);
-		if (separator_pos >= 1) {
+		if (separator_pos >= 1 && !isspace(lines[start]->buf[0])) {
 			struct list_head *pos;
 
 			trailer_lines++;
-- 
2.8.0.rc3.226.g39d4020

