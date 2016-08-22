Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5921F859
	for <e@80x24.org>; Mon, 22 Aug 2016 12:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbcHVMfv (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 08:35:51 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35274 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753673AbcHVMft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 08:35:49 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so8013469pad.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYBQxO50pdJKpoCKyCA05aXb3kVkF2g94Dz2TD6dAFg=;
        b=YGKE4dXb5ubGgHfz0+dJZ86DZ4yA5TqZhkfE5JXL3hpniycpTEsylAdtljXYCIr4wy
         frB7Fz7K2JMXZ8BrgR9ZJuVGkDfYtVvAbhzyFUvuLX2yMPI6WEYX9tyMKd+mju85uebW
         xN4IGjRxfXIaezIXgcr8dEWInIDyh30pUrLBWh3Ba23VhgPHDLvT/kIkFHrmQNcsy9Tj
         7Y4YeS85lIjSBErlTW5sme0u8vmPyzeIbT9KlegKD+hDvcLzFmJMzhGHbNGcHBNNXpU1
         hCN0UoGg2Jf2ChMdzOL1SpAezQRREbI0wYFhWUdNCR5pAte+w3DN6mZyGJJWjT4foGjm
         UEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYBQxO50pdJKpoCKyCA05aXb3kVkF2g94Dz2TD6dAFg=;
        b=e/EGpBv7yBork82LV57yS0zm7QtFsO0UHeRaBKCiUJzPXVAqeR09Hf1yAexwO5TSr1
         yZHe2ZBeiHzl8Vm9zSNqBUmP6qMR9PfYYu3bIqbMi2nR/dhFfYdvZfOc62Tl1bbzomt0
         DSu4ApYSfX1K7IzBWcVwNnei9lxPYG4YF1SWcLPeIqVX1OWzSbvbbcYvXKc8ft4rDuUC
         vEO7RCXB02FrGe9FtAXgLquWOWFTYn+d/TMiMd9Qn4+VlrQmolHz+gkW4X7rt+PD4Rqx
         +X2vSrZRzfVjRZM5GxmqC96cqwWreFNAmMYLri9n0/xdJUKJpiLYYs5iIINNeW0/VBFv
         X7GQ==
X-Gm-Message-State: AEkoout+Ksdw+tXXxCc9evQQnFptT/UYjyJfCR6sLQdseZQUKpdDhxnhNSjS93CloGFmUQ==
X-Received: by 10.66.86.170 with SMTP id q10mr41527833paz.105.1471869348763;
        Mon, 22 Aug 2016 05:35:48 -0700 (PDT)
Received: from ash ([115.72.190.143])
        by smtp.gmail.com with ESMTPSA id ah5sm32094357pad.30.2016.08.22.05.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 05:35:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Aug 2016 19:35:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] checkout: swap the order of ambiguity check for :/ syntax
Date:   Mon, 22 Aug 2016 19:35:02 +0700
Message-Id: <20160822123502.3521-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should speed up "git checkout :/long/path/taken/from/diffstat"
because we don't have to walk through the commit graph to see if
"long/path/taken/from/diffstat" exists in any commit message.

This is in the the same spirit as 4db86e8 (Update :/abc ambiguity check
- 2013-01-21), but instead of considering this case ("abc" in ":/abc"
exists on worktree) ambiguous and shouting, we just assume the user
means "pathspec" not "ref".

It's not wonderful, but it's in line with how git-checkout stops caring
about ambiguity after the first argument can be resolved as a ref
(there's even a test for it, t2010.6). In other words, we assume the
user means "ref" not "pathspec" when that happens. Here we simply swap
the order of checking specifically for :/ on practical ground.

Last note, to be pedantic, we should check if "abc" from ":/abc" exists
as an _index_ entry, not on disk. But chances are they exist in both
places anyway...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d07..6f016db 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -973,6 +973,22 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
 
+	if (dash_dash_pos < 0 && starts_with(arg, ":/") &&
+	    check_filename(opts->prefix, arg)) {
+		/*
+		 * Normally if the first argument is ambiguous, we
+		 * choose to believe the user specifies an extended
+		 * SHA-1 syntax unless it turns out not true, then we
+		 * see if it's a pathspec.
+		 *
+		 * :/ here is an exception because resolving :/abc may
+		 * involve walking through the entire commit
+		 * graph. Expensive and slow. If :/abc points to an
+		 * existing file, ignore ambiguity and go with
+		 * pathspec (i.e. skip get_sha1_mb()).
+		 */
+		return 0;	/* case (2) */
+	}
 	if (get_sha1_mb(arg, rev)) {
 		/*
 		 * Either case (3) or (4), with <something> not being
-- 
2.8.2.524.g6ff3d78

