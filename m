Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DE91F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeCWOAd (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:00:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55776 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeCWOAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:00:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id t7so3754468wmh.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TbceRcq82vDRIUE3ysrh1HNzpIDYzMSKEJ3VLJr3i60=;
        b=UrfQNBebMqYNXYx97GTyi+ufSL8GrHUH5ubiUV+mzix5o2ZnG89JWyrC9rtt8UcAfj
         bAd50tjio0/FAiUo2aXCOgpGFjXK8LBJkrei82J2hd9ku1l0Z+/ZSwW7fxoeTxMdienl
         ejBeg4wrdTBMoepZkcc29PuZr4FWgxLWsJEIUGRpWEryNs3fHuxtKU4Uz9U64NhdLy5e
         HGoGWCrG1zieyMYNrbwaE800nGLzhrO7nZmDTFa5DD1NAGRnLBxxt4OFdLSwyToTK/h6
         dUpxecPBEMzbDGKBoYEvM9iK3cwyu90NQ4MAlVXHWUzqH5gGB4471Xwp6ZvjA7nRoB8O
         5Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TbceRcq82vDRIUE3ysrh1HNzpIDYzMSKEJ3VLJr3i60=;
        b=mQmSYmWJItnQKAaHH8fqCFpHRRiIkLEK9lihhkYoiTMDdDfMmouAPNtLCmQNH451Xg
         QelabdAKDoBCB0ncWoFWqHxSb1aI5MhS35S0D33K1y8GtFHFBjbf83Bbp+C854UPhe6W
         4r4vFhQbuXOsnvk8aXS8iPHqsgevIIm6HKPHTlyd07HPrc6OfHXcvLrsiDiG2XfbYD8q
         k9Jz+bniez48DP4mmJsbtTdMOLtON4ADcDdEwhUWhkOhAzynFrAcJFxonsFUrEQGasTe
         0Q5SKn4T8mQMMZ08gOFv5c6NexSIRvPAmk4GKN23hst340v1IiJ+wpnWQO1AMcoqRcap
         Vq+g==
X-Gm-Message-State: AElRT7EXvnxK+ObfI4sh2S2pr4GwDdRiQOXYw+21BoalMM+u41AnCUiN
        U7k/wyJy0h0biTLwv4MnyaLscjos
X-Google-Smtp-Source: AG47ELvgLCVn0YuYJ/lYbCGOQPxgyyL/D5vxeCP6DGa/zxbLUSch3OrceMOVNOEPmdFMtzt5sJ5j2A==
X-Received: by 10.80.136.8 with SMTP id b8mr22064129edb.274.1521813629471;
        Fri, 23 Mar 2018 07:00:29 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id d89sm6245930edc.75.2018.03.23.07.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 07:00:28 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 1/2] perf/aggregate: add display_dir()
Date:   Fri, 23 Mar 2018 15:00:06 +0100
Message-Id: <20180323140007.12096-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180323140007.12096-1-chriscool@tuxfamily.org>
References: <20180323140007.12096-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new helper function will be reused in a subsequent
commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 821cf1498b..b9c0e3243d 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -147,6 +147,11 @@ sub have_slash {
 	return 0;
 }
 
+sub display_dir {
+    my ($d) = @_;
+    return exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d};
+}
+
 sub print_default_results {
 	my %descrs;
 	my $descrlen = 4; # "Test"
@@ -168,8 +173,7 @@ sub print_default_results {
 	my %times;
 	my @colwidth = ((0)x@dirs);
 	for my $i (0..$#dirs) {
-		my $d = $dirs[$i];
-		my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
+		my $w = length display_dir($dirs[$i]);
 		$colwidth[$i] = $w if $w > $colwidth[$i];
 	}
 	for my $t (@subtests) {
@@ -188,8 +192,7 @@ sub print_default_results {
 
 	printf "%-${descrlen}s", "Test";
 	for my $i (0..$#dirs) {
-		my $d = $dirs[$i];
-		printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
+		printf "   %-$colwidth[$i]s", display_dir($dirs[$i]);
 	}
 	print "\n";
 	print "-"x$totalwidth, "\n";
-- 
2.17.0.rc0.37.g8f476fabe9

