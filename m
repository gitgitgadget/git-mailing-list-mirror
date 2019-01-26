Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5641A1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAZUvJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 15:51:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38244 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfAZUvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 15:51:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so9891506wml.3
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdSQN4ktLNcVQtX23FyHwyMCUqovRbimBqlqzriziG0=;
        b=A9zUgeZ957jh0vH5ustrhEXyzjHyUxGgUl2G9mgpFZPpsru0YZ5Yh7CCNpgP7Lhrg0
         kFJ/4k4Flla8twzF+UY1ytQf/ppApLLY83mY0zbSLgbTWOOOZBaghPsMb8/mSNMZUE86
         sG2ey1DzpSMdW9KUETMxzjT00IeyGxpVmo2mJWYrGltSZxz72NAk9RhV1oAtmlrpnngS
         dYrtb4fLeX9oodPaC8ccAk+rPVODagQw8fjFXGKT4izMImveDz+vRbNwJLcnz+JexjXj
         obpPFvLH5GMR+CmmHLMZAANl1CSev34HfFDG4XnhTAfkt2fWLqjNZn78SbxGeT1V4w1Z
         jCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdSQN4ktLNcVQtX23FyHwyMCUqovRbimBqlqzriziG0=;
        b=edv/mFKRUfHrDKVBbPGLsv1dNCFqQEsx6kxideMo0bZulwTtw6UhYDau9OH94NIapg
         9qrOKpRIc8reBre8f/OjeS8jI1Osn/fzSHOS78n3LCuIKlQzHZdFmozALHZnhxV63Y4U
         bXHVWcuaGqe/2mOmLoH1tjZtxFJOK/sCf1M1p1osBZWId1mB6QTikGSaleeEJXL9t0mi
         Kw6+gtgN4yaIchbG7gOXTuAqnfNEy7J1gI2U19FAsvnjU129qzht+NlcCVlT6ejw/txO
         UaxF/aKReEnuNyiadpEiUoewIz4ULiRMj4Te6CnR0PgyNwfMDwbiRTR27ezuKYVzgUBH
         xTkg==
X-Gm-Message-State: AJcUukfBX2IY6l3hotlGrxGYj1qDaHHn/BPg6dEQfPcKPw+LuEKfC+yD
        poFg/c8TOFp72DNj/3JumINF9/BfwHE=
X-Google-Smtp-Source: ALg8bN5bgN+A9KFaZuvcCCs7ZAg9wOM/R/Dl3dJ8kUzTRU6EaYNZB7z5mXyu5rVByci4aJug0hrtyw==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr11633418wme.73.1548535866363;
        Sat, 26 Jan 2019 12:51:06 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id m21sm48049415wmi.43.2019.01.26.12.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Jan 2019 12:51:05 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v2 3/3] Add test for describe with a bare repository
Date:   Sat, 26 Jan 2019 21:49:51 +0100
Message-Id: <20190126204951.42455-3-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190126204951.42455-1-koraktor@gmail.com>
References: <20190126204951.42455-1-koraktor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures that nothing breaks the basic functionality of describe for
bare repositories. Please note that --broken and --dirty need a working
tree.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 t/t6120-describe.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9a6bd1541f..ddd8cc307d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -409,4 +409,11 @@ test_expect_success 'describe complains about missing object' '
 	test_must_fail git describe $ZERO_OID
 '
 
+test_expect_success 'describe works from outside repo using --git-dir' "
+  BARE_CLONE=$(mktemp -d) &&
+  git clone --bare '$TRASH_DIRECTORY' \$BARE_CLONE >/Users/koraktor/open-source/others/git/t/out &&
+  echo $PWD >/Users/koraktor/open-source/others/git/t/out &&
+  git --git-dir \$BARE_CLONE describe 2>&1 >/Users/koraktor/open-source/others/git/t/out
+"
+
 test_done
-- 
2.20.1

