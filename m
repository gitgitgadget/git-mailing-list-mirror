Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0090220A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 00:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdJAAKt (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 20:10:49 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:56757 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdJAAKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 20:10:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id g65so1367367pfe.13
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUO3dGUrWpX3fL+wX6zLM4JPVfIkbgkgp9xP/uMU3D4=;
        b=F5zo6/Xt5IUQuJBNILrJ8ep0+3K97jsGpi2W8wszPOhNnudrM1LAEPTGmjBP25oJz+
         ONRM7HKZ2gdA0P1M7IyvkZ0Jz86dTN8NSmEo6DZdtaLC28Ja1wFPygDyIKOtLqh5DX99
         3DN/C08mnCPDrLl/Wn21fmj5i8hN5OrPZg64MsxUeCc9jOjT1cIzNZCtm3ZIoLHoVFkg
         h4bzivBGS309xKu2oQvdzDHLWm4UFU3/mn7PbS5l4qo3rdU+qpjoUgSuwuBBCX2NeG6p
         DTjFpESPqCMIn3xZuh990nIdR9oRuk4XjBV+w1S0vxZ22Z/n4YmhWFJuASMKPyUMnmfI
         BmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YUO3dGUrWpX3fL+wX6zLM4JPVfIkbgkgp9xP/uMU3D4=;
        b=L9N71f7lqLKMxmdsHQGZDwgTYoHT3Mj60UbD+oCG+jozH1v6FZZ+bhknrJYTUQRa+Y
         e9/3JrVBF66Oa393ksXPnoL+9da44/U2uL4GnDArPTiGfMotr2IsMIAIW7TwgWSPjd04
         n9I5u0x23+CVnpafVWy+QPSr3lq9QfLnnsKAzcRLgCpTxK63QsmVso8c/q+WtCWWPNsX
         9nXAdCtM4KTDGds2AmP7IfplLXquysqnFH7OSVNcnty+lERHMm0BIyEiwPyfwIHXe+X9
         q7GL/Od2QF0nFQeTThVFywwLqTdVVUwrCMWLkaA/6rsqot3re/K0+fKQrfrd4aYU4CrO
         ydGA==
X-Gm-Message-State: AHPjjUhtgvKDD0J56zkwhgjzU0vjQ2HY+tQ9GocG/ltNC1/rfoO8aRBd
        LKXsGhypTq9wa/8RrnftCBTHOd4ygZQ=
X-Google-Smtp-Source: AOwi7QCuIzdlmAN4HVksUgmoWzn/GE2X356M/bKXG/gbnQR7A7ZM7g/rVREaMKRazrgdDpU2ztoSow==
X-Received: by 10.98.15.209 with SMTP id 78mr11361706pfp.87.1506816646053;
        Sat, 30 Sep 2017 17:10:46 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id s187sm10395813pgb.82.2017.09.30.17.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 17:10:44 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 2/6] t6300: refactor %(trailers) tests
Date:   Sat, 30 Sep 2017 17:10:33 -0700
Message-Id: <20171001001037.23361-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001001037.23361-1-me@ttaylorr.com>
References: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001001037.23361-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have one test for %(trailers) in `git-for-each-ref(1)`,
through "%(contents:trailers)". In preparation for more, let's add a few
things:

  - Move the commit creation step to its own test so that it can be
  re-used.

  - Add a non-trailer to the commit's trailers to test that non-trailers
  aren't shown using "%(trailers:only)".

  - Add a multi-line trailer to ensure that trailers are unfolded
  correctly using "%(trailers:unfold)".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6300-for-each-ref.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 834a9ed16..2a9fcf713 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -592,18 +592,25 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 cat >trailers <<EOF
 Reviewed-by: A U Thor <author@example.com>
 Signed-off-by: A U Thor <author@example.com>
+[ v2 updated patch description ]
+Acked-by: A U Thor
+  <author@example.com>
 EOF
 
-test_expect_success 'basic atom: head contents:trailers' '
+
+test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
 	git add two &&
-	git commit -F - <<-EOF &&
+	git commit -F - <<-EOF
 	trailers: this commit message has trailers
 
 	Some message contents
 
 	$(cat trailers)
 	EOF
+'
+
+test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
 	# git for-each-ref ends with a blank line
-- 
2.14.1.145.gb3622a4ee

