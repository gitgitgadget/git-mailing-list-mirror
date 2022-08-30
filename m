Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE8ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 10:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiH3KwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiH3Kvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 06:51:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA36F077B
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 03:51:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n17so13668562wrm.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QVmqLabwClWirtsJiFl87kzuGn+HZoZmE9vScaUcyAc=;
        b=ieSuQQiaXwAvaL96VV45m6bKBeBNnKOz6nxydGT56ewJJgGawAsM0II1GxZL/ZA5pu
         AwLHIJdyT/M+1emWqikselpnRQMs6VMTTeWHZ7aqKO2cQW8Nyzi/kydUAjcgCLjvMI/0
         VskATz5KHitCBt09Bt1svn1SsHmJK1AQB/82lNnF8++yt3n5PRzp9PZl+qSguojcTrvU
         AZWLbYOFE8M8M4M8A9qrVlNILtCCrtQxpCXAMXnMoNn0Va6qisgGoIYqrdoU7M2no05d
         TS1sErVhcioQHMx6Jry8yOBXGIwFJu7OUVEdwLDgG5jps5uSvaTSNZC9kH1prlb+CSon
         v1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QVmqLabwClWirtsJiFl87kzuGn+HZoZmE9vScaUcyAc=;
        b=HtPsG0w0jtZ8QWu/DoKVHB+wz0aqhuNMOJtr39dLBHC4K1b9tSyNJumxdy+j1OLjt+
         dd6c1/ShPgyF5KhZeUsz8/SIq2utnFROcs/U+YqssJ476LVryz1/RNKcYF7qTOLwCOET
         ZMNvSlZA36hIPp8zSWrx8vwSXgm3aOdkr+zKeVPnbwMKx9ko3mOQzyX+uzBBebf53Cex
         pG6XE6x9Ur0lb4R84kNp/lYYfD+mF1lCktJRXdgNMS/gPTbgmGm7pXUupwtj8hS2dD1D
         AEDGpHzzEvzeVGvRYBhITTWn51AtKPYNkOWGvqiCA6inCo/i6heflc0KqYmr1ItCPD/W
         WNxA==
X-Gm-Message-State: ACgBeo1dVk4iKYk18HZoU/qZ4wN5QdPqRBllYRv+AMa7zfCJr6mBc7Eo
        aWETtIYCesMy7oQbaBlQ2hPYTTorBtbL+w==
X-Google-Smtp-Source: AA6agR6CFj1DYVMVJiMj9ixqPjoV6XBq70S87TcXu9yO3R7NqZKZBfJT7AfsIPMFkZimp/dzmYXZpA==
X-Received: by 2002:a5d:640c:0:b0:226:d32d:c4a9 with SMTP id z12-20020a5d640c000000b00226d32dc4a9mr7731603wru.651.1661856676772;
        Tue, 30 Aug 2022 03:51:16 -0700 (PDT)
Received: from Precision-5550.. ([2a01:e0a:595:6400::ae22:851d])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b003a5c244fc13sm12034766wmb.2.2022.08.30.03.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:51:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] Documentation: clarify whitespace rules for trailers
Date:   Tue, 30 Aug 2022 12:50:46 +0200
Message-Id: <20220830105046.324041-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.37.2.383.g1c78c54f66
In-Reply-To: <CAP8UFD0EfhDo9ZMNSYp8YVHXJs6mYtSBs=hwoFZWWF3xZ0wjpg@mail.gmail.com>
References: <CAP8UFD0EfhDo9ZMNSYp8YVHXJs6mYtSBs=hwoFZWWF3xZ0wjpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e4319562bc (trailer: be stricter in parsing separators, 2016-11-02)
restricted whitespaces allowed by `git interpret-trailers` in the "token"
part of the trailers it reads. This commit didn't update the related
documentation in Documentation/git-interpret-trailers.txt though.

Also commit 60ef86a162 (trailer: support values folded to multiple lines,
2016-10-21) updated the documentation, but didn't make it clear how many
whitespace characters are allowed at the beginning of new lines in folded
values.

Let's fix both of these issues by rewriting the paragraph describing
what whitespaces are allowed by `git interpret-trailers` in the trailers
it reads.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Changes since v1:

  - rebased on top of 6c8e4ee870 (The sixteenth batch, 2022-08-29),
  - added my "Signed-off-by: ...",
  - clarified that there can be no whitespace before the token,
  - clarified that "any number of regular space and tab characters are
    allowed between the token and the separator".

 Documentation/git-interpret-trailers.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 956a01d184..6d6197cd0a 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -60,10 +60,12 @@ non-whitespace lines before a line that starts with '---' (followed by a
 space or the end of the line). Such three minus signs start the patch
 part of the message. See also `--no-divider` below.
 
-When reading trailers, there can be whitespaces after the
-token, the separator and the value. There can also be whitespaces
-inside the token and the value. The value may be split over multiple lines with
-each subsequent line starting with whitespace, like the "folding" in RFC 822.
+When reading trailers, there can be no whitespace before or inside the
+token, but any number of regular space and tab characters are allowed
+between the token and the separator. There can be whitespaces before,
+inside or after the value. The value may be split over multiple lines
+with each subsequent line starting with at least one whitespace, like
+the "folding" in RFC 822.
 
 Note that 'trailers' do not follow and are not intended to follow many
 rules for RFC 822 headers. For example they do not follow
-- 
2.37.2.383.g1c78c54f66

