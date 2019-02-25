Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF54C20248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfBYVyf (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:35 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:49027 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfBYVyb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:31 -0500
Received: by mail-io1-f74.google.com with SMTP id w19so8931759ioa.15
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J5C1EnljrCL8OE94dJRxs7DjEMuSpRaDKmNnjUNlToQ=;
        b=kLnyvGN5ObqQFaC1qIZX8IQCYEqXij8PbuT8yy4yZ/u+09d+588aIeA16qUIMjbKiy
         N3hY22Zy+ro6eeEQuK6nV/xnaLa6mrWrDmGP6Z+4SSgovSp7PePvaEawMRDHH6I45xEy
         IDFLa69dqVt/fe1ssBU8SeejGUF6l8oPdGwuhxQ0VjzdLO8FgMeZ9RijStea+vvG1suH
         /cH554Tp5XtnPmjrXUutr5gpiq0duaJX5A2xRSMMbN/XF517+4Cwp9XJfam/D63JGDKr
         Mz31tBNTLFJAyOJfo7k/VIVDtJp6bfSSlooShEynv0uR8cV/9dw8313hbkzskVAWNlyO
         tsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J5C1EnljrCL8OE94dJRxs7DjEMuSpRaDKmNnjUNlToQ=;
        b=mT6X+auXfc3SbTET78txB01MJgCMwCHbzvl9KNuY2lIBEMYyqOqfZa6cbcqOtC9wJZ
         N45e39d5oCZeNsgGnFoOWJ0qS7SbTKpA145W/IV7zDBOvioV+t1o3QMPxsW6iJr2ES7n
         c+DSO618ySkYQislNKiyHSzQsnafcUt3Kh0/lUDFcslF37N6LOy2BzzEnDwzP9YgBTUk
         QtHNVw3RTNcDir5ZRQ6Mgcrom22TFXmR0ryG4hQa3MnIdQi/T+lqbXpe2lPctANiIoC+
         MCdnk+oo9ghmAuYojrQ3lMuUY6YWmE50b4mFWLBxNZ7BXqgu55UFr7HViKBJygPH2VCX
         9lqw==
X-Gm-Message-State: APjAAAWhsHuVtPyKWzQvGsrha7uaL1mATiiBriGnd5yE5RxPwcwowzZM
        3XmeyjS+TY9bPYpTRQ8CS1kzuas1vh8XpYkoElc60Qq0/T/PnMO73Zjd3mn5I1iXP1asc8fmRxp
        CbiuKjgY/oR/Pn3N4HEmzIe9JDf2GpwXp9rLRZRPYq79u02+M63XLKuQ5os2SeOSgAdQNEGxIzz
        Z4
X-Google-Smtp-Source: AHgI3IZmkKsHMM94PV1Ile0OS26v6UHEr0PFLpu91LmyOpObESV4hOaxkl+5soFiOxSmrBGAd4wqMrzaqb87EHjYObFl
X-Received: by 2002:a24:6241:: with SMTP id d62mr595815itc.18.1551131670423;
 Mon, 25 Feb 2019 13:54:30 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:10 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <9aaabdac523b22d781571516402fa63a2e81a0e9.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 5/8] t5512: compensate for v0 only sending HEAD symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protocol v2 supports sending non-HEAD symrefs, but this is not true of
protocol v0. Some tests expect protocol v0 behavior, so fix them to use
protocol v0.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5512-ls-remote.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index ced15ae122..e3c4a48c85 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -223,7 +223,9 @@ test_expect_success 'ls-remote --symref' '
 	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
 	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
 	EOF
-	git ls-remote --symref >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref >actual &&
 	test_cmp expect actual
 '
 
@@ -232,7 +234,9 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
 	ref: refs/heads/master	HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
 	EOF
-	git ls-remote --symref . HEAD >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -243,7 +247,9 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual
 '
 
@@ -252,9 +258,11 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual &&
-	git ls-remote --symref . "refs/heads/*" >actual &&
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . "refs/heads/*" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.19.0.271.gfe8321ec05.dirty

