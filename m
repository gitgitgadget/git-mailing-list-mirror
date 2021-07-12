Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB3C11F66
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B27C61186
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhGLQrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhGLQrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31154C0613EF
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso310810wme.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9hqVrq6jJuYqXnGExueXT057F3C92bAgIuP3TZ1r+Q=;
        b=Vudjj1KdiQsb49DfUG7JeYCsBii+QTQKloWrSL5UwcUlVRk5H4MQF+drRD1HQniAEy
         I0aF6HYxHnsHTedCcwXPZqKFqafH88LUojK0MwW+OEoDOiNmAjA1FZvC20B+LrR9MhDg
         YQjBQT8TWsxAHRB0Urw1uhaSQVABXTFphfICwKE1gLbV8lCGK+ZIeCoeWnEpoadebDq6
         bY9sfffYayV6eVFtGMLUzB0X/OIiOW6fuKJLFE+a51v/O/3rFfibWvIRTHr8kLB5BAOv
         iDb+DYXNiAGo+dWYYkhI+JD9B69UaaXvZKSF9OqKRMpC6pxUr2zuPDhWj1G6GepDDnds
         1wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9hqVrq6jJuYqXnGExueXT057F3C92bAgIuP3TZ1r+Q=;
        b=IGBfUZFzb6FFV+gKCP3B38omP+V+O2l5vkXz1xg6se5kXoLTtyLzGkDECWa2YEMpQl
         TEGeu/HOqPLVEKhb0DiPAFErHaHdM071+++WZg4MZjDE/VITWG1R5iWMAEKBF1WiEBUR
         If8PzRarulJF5kMpRIuBkUg/gJ4wuEyshcxvKGxhAQ4Jz/NsoG9bvVvzVq5kIm+Tymzj
         ersvYWM5qM5gCAz9CyEVt4+Aaq9sbL8d/qWt5KbuZMF1a9W10JcG8hwTWxcLc4KUxOi3
         5c8+KPSsqyE0ipdMAEgmBBBhvmx36NQsO2tUCHwWxaf/bNS2t3swY2Ko17Y6rsqxJnmp
         Q3hw==
X-Gm-Message-State: AOAM530xs4n8xok4gN7YrUe8TGaO4UN3AnHpF6ILgTrTl95QRYcTkfvq
        ipaxx0J2WTNPzT2pkOxfNY9WdohCqyUu6DkH
X-Google-Smtp-Source: ABdhPJy3Kc/wvQHtQ5U0gJb2hvu0aWAcDMIMkb9eQm+CEvJpMcWk0PH1zoRFd9RlHtWr28FTSanmYA==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr15325174wma.178.1626108267198;
        Mon, 12 Jul 2021 09:44:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm12988347wmb.40.2021.07.12.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] test-lib-functions.sh: remove unused [de]packetize() functions
Date:   Mon, 12 Jul 2021 18:44:20 +0200
Message-Id: <patch-5.5-cc91d15ef70-20210712T164208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com> <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the now-unused "packetize()" and "depacketize()" functions
added in 4414a150025 (t/lib-git-daemon: add network-protocol helpers,
2018-01-24). As discussed in the preceding commits we've now moved all
their users over to "test-tool pkt-line".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 42 -----------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b2810478a21..77e4434dcda 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1453,48 +1453,6 @@ nongit () {
 	)
 } 7>&2 2>&4
 
-# convert function arguments or stdin (if not arguments given) to pktline
-# representation. If multiple arguments are given, they are separated by
-# whitespace and put in a single packet. Note that data containing NULs must be
-# given on stdin, and that empty input becomes an empty packet, not a flush
-# packet (for that you can just print 0000 yourself).
-packetize () {
-	if test $# -gt 0
-	then
-		packet="$*"
-		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
-	else
-		perl -e '
-			my $packet = do { local $/; <STDIN> };
-			printf "%04x%s", 4 + length($packet), $packet;
-		'
-	fi
-}
-
-# Parse the input as a series of pktlines, writing the result to stdout.
-# Sideband markers are removed automatically, and the output is routed to
-# stderr if appropriate.
-#
-# NUL bytes are converted to "\\0" for ease of parsing with text tools.
-depacketize () {
-	perl -e '
-		while (read(STDIN, $len, 4) == 4) {
-			if ($len eq "0000") {
-				print "FLUSH\n";
-			} else {
-				read(STDIN, $buf, hex($len) - 4);
-				$buf =~ s/\0/\\0/g;
-				if ($buf =~ s/^[\x2\x3]//) {
-					print STDERR $buf;
-				} else {
-					$buf =~ s/^\x1//;
-					print $buf;
-				}
-			}
-		}
-	'
-}
-
 # Converts base-16 data into base-8. The output is given as a sequence of
 # escaped octals, suitable for consumption by 'printf'.
 hex2oct () {
-- 
2.32.0-dev

