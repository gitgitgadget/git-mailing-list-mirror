Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD8C2D0CE
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5288A215A4
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 21:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZTRpFJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgACVmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 16:42:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgACVmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 16:42:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so43675145wrr.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 13:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WygS3Q7rxaLa/ASN44/pomA5Gy4w552ZYJ76Isw1pKk=;
        b=ZZTRpFJPfNLOzAVe2v5HXz96SpKnFIlb+mTMLm3ZfwEB6lQihMyDnoN5rWFVF3huua
         quX7BnU8Qp82MlLPMALm52K2Lxq5jFgWsl/W5MUca851XoImHsF0QWkOnfHYfUkNo0ZK
         hGNpAjhlA78w2dPenhOkBRhcjCWnXxeVMi/Hv02yN/uZmehFQv+MEeLQQRuB9/oAVpRQ
         DgzzVwOMrtbeEtvQxs5m2YCWMnOcCYE7P0tHlfV4v6oUxOmewsoIKhhIjHJ00VJCWeAW
         uBtKZl6Mb7qxn8aFBl0IoUEMKQrq5K5ZL1Tz9f5X+huQaeYBs4hrc1zdeejcDZ40GZVk
         F3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WygS3Q7rxaLa/ASN44/pomA5Gy4w552ZYJ76Isw1pKk=;
        b=JkUJbtaootrSXTq/55h11HbSPFZJbLMv9Ie73aEVxUOS+Ul5s0lpuFzDaL4uFP9gh+
         vuHKbq5IxIlZ8KwCTVJ5+HGw347QKHqJi+gA51SKX+wvC3AsTfjLp5W/lL/SDE/G/A3m
         /ihnbU4VRL9QNcvcCKMCR4Roo6r3q6pyTTNS2RNqGF8Lhcnv1B4RC0Xi/KXGXV5XAuIh
         3LXDQlDgQ61wjEAw/pWP20+klBwF049Qe4QB8llGgdAhGlu5VfqI6Vj51rFHlPoA8Y4N
         FktuliiPfCxAPnrDTXq6SPzkRN/yixywzwhrVvCWDEnZ0ljc3x+hzRSrqlY5PKizs+Ef
         WAMQ==
X-Gm-Message-State: APjAAAWvdfbQigF436h6LxYFlBfzirIByHiTciVRp6asJJGR4yQpu0oh
        mFk+jCZ9OwXBBo0YIzbKB9QJEGXH
X-Google-Smtp-Source: APXvYqzJf2xcdHceCRevLaWViUGfscczoWYAgENf4yJLuqHfpODK4LNg2aZT+2k4Yf4Sr6exEjY4dA==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr87323196wrn.214.1578087730968;
        Fri, 03 Jan 2020 13:42:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b137sm14007758wme.26.2020.01.03.13.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 13:42:10 -0800 (PST)
Message-Id: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jan 2020 21:42:08 +0000
Subject: [PATCH 0/1] unpack-trees: exit check_updates() early if updates are not wanted
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In trying to understand check_updates(), I found I was able to simplify the
function by making it exit early when updates are not wanted.

Elijah Newren (1):
  unpack-trees: exit check_updates() early if updates are not wanted

 unpack-trees.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-686%2Fnewren%2Fsimplify-check-updates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-686/newren/simplify-check-updates-v1
Pull-Request: https://github.com/git/git/pull/686
-- 
gitgitgadget
