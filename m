Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDCC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932E420835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="UPU/rBuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0RsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:48:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42424 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0RsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:48:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so10082185plt.9
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRXoM+cmFmtyuj58SXbu+NAGF1KiiKXqklwTaInl/BQ=;
        b=UPU/rBuIrbZA3sTObIezxfn5131ORaBTGJS0VLjXYPVOVe6rQWSxO9HTNX0ymyVIvv
         ksHgDB2uI4occ2mv5zNffoWd/aPP8bK2Rqe6MbvF082Az557G/njV0fHyBmictCLEsg7
         qE0vFOhiuQkENBS3BUdMbFzyGquEKLRpxLkgLswYs45xG6tW3j4rV9A/I9GgqLiDX4o/
         tyHb37z8VBbr85QSEye0rjxQnZxwVcq1/PYDi7V5jfzA3yCUrjQp/iCLli+8/O2Nb7gq
         FgjeLPcCrXo3Z/fG8XzSMH5cTtKPLZdeXMO4toXB73DvgfpSuVoGcS4xw0NAehEf5zqn
         CjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRXoM+cmFmtyuj58SXbu+NAGF1KiiKXqklwTaInl/BQ=;
        b=hjonaLe9w0gIJ+byZ9CCf0lDh5f/tLIZKD8tRsnRAxUMSdf61zCFjir1frFiaUaQR4
         2e91xE9ASlDNvp7V8/Mq3mpLvu+g9JkDX7hkh/h27Fs6GAZhQb7/eIS6r0k3K2WQYCAT
         Uy5nS2zCDweYkvUhs7Sn+7CuSPJNHf0qVrWPeXmG7Rn0tbs+iTukV5P5j1rB2/wxHQJv
         k7CvIv6voBIUxSRJV21ggn18n7Dc0tgRYAsmJUfmR8ixwCZ+JtJe3bLcUWP7IG2FAZEE
         CmTu1BFaNzP3DYJqVtoNJFgyZHmeHG01AOihC5lPJx/bp7//4HmBJcQ6nA5G8lOXahwb
         UFRQ==
X-Gm-Message-State: APjAAAX61vAjkgEaRe1A+CEN9QLhJYtXVjkOmOMeIP1Clz2ptj4t4GKI
        TXuojUzRaLKjpN1VzPCTacDaa0B5jOJmRA==
X-Google-Smtp-Source: APXvYqzzFZyMp1iBbUJTwk28dUIb+ViSZQ8HcGkxgLq0wW4D+316N5C59MWX6BuyNJzBq1R/P1M8lA==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr7638307pjb.19.1574876904692;
        Wed, 27 Nov 2019 09:48:24 -0800 (PST)
Received: from localhost ([182.232.36.174])
        by smtp.gmail.com with ESMTPSA id w5sm17842402pfd.31.2019.11.27.09.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:48:24 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 0/1] gpg-interface: prefer check_signature() for GPG verification
Date:   Wed, 27 Nov 2019 17:48:20 +0000
Message-Id: <20191127174821.5830-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch refactors the use of verify_signed_buffer() for GPG
verification to use check_signature() instead.

Previously, both check_signature() and verify_signed_buffer() were used
to verify signatures in various parts of Git.  However,
verify_signed_buffer() does not parse the GPG status message.  Instead,
it relies entirely on the exit code from GPG coupled with the existence
of a GOODSIG string in the output buffer.  Unfortunately, the mere
prescience of GOODSIG does not necessarily imply a valid signature, as
shown by Michał Górny [1].

verify_signed_buffer() should be reserved for internal use by
check_signature() since check_signature() parses and verifies the status
message.  This is accomplished in this patch.

Note that the patch is prepared for the next branch.  I'm not sure if
that's appropriate -- but it seemed sensible since I've already touched
code in gpg-interface.c that's been merged in next.

[1] https://dev.gentoo.org/~mgorny/articles/attack-on-git-signature-verification.html

Hans Jerry Illikainen (1):
  gpg-interface: prefer check_signature() for GPG verification

 builtin/fmt-merge-msg.c | 11 +++--
 gpg-interface.c         | 97 +++++++++++++++++++++--------------------
 gpg-interface.h         |  9 ----
 log-tree.c              | 30 +++++++------
 4 files changed, 72 insertions(+), 75 deletions(-)

--
2.24.GIT
