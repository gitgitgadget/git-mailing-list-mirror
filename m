Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5D6202A7
	for <e@80x24.org>; Sun,  2 Jul 2017 12:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdGBMDL (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jul 2017 08:03:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34112 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdGBMDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2017 08:03:10 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so20215144pge.1
        for <git@vger.kernel.org>; Sun, 02 Jul 2017 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=ap1qqUIctW1li5OnB6nBsV5hkyns03Dql8k4tbKRlN8=;
        b=aI2lK6NYdDlsWCwM5wqTr/elgLlW3uohLoNXtH2tBkZBtgq38xiqHUQ8W7WWQ0sDnv
         IhpA+uYbP9kf/zEQTpKkg8nG0Dx0nGYfL6+F3WKZFy1ladyVxdjo/mYkezXXpybyioy5
         rHM6vIK+UMrBhP9qsmPxJgu9vA2y8NPXNFmlKK+TXKKHKOh+qW0QzoskR7Uvg7JH4BQk
         wHc/oVpagNEyhHW8I0dy38b+1pkJYlmkpYs1GYtDnnJbXsDdrwpsi5hivuEN3Wx74QV0
         mNKLLpK2pDHskqkpzyAGcfh4V9TYD0uwSnfzc0GjNp+60l43wI1lx3LcldRsQNidSwtj
         iXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=ap1qqUIctW1li5OnB6nBsV5hkyns03Dql8k4tbKRlN8=;
        b=RRd9PJ8JynukOFAvsSOk2gcdBrucxCRpQOnwszm5d+/IwO7jKFHTsavDp/sBHq2024
         Lw2VhxZNvP7oV3VA8AqJn0s6ljT5YO2hLkjOxNu1HqB6XZsGgoDYs0jSYytybhJShbh5
         oMl8K/w1rDkeZkBapuOhkT7wa4/fMP8XeqRqFCS68mfFODn1gMBLObsRpUKCCP6Ht4n6
         YFaJRHl6h70s0bzycUPvIcthi5ZrRyLzyfZrJR+8GEZtOKZUxhy0e1dJbzKSOPPaiDEJ
         xSqNH5gNtN1N51lIjntnI+kxYmZkZRnlCgjsZ0dTkChP/DIOlRZx9xwsmLwfofZTZBUo
         MQPA==
X-Gm-Message-State: AIVw113fdFTANjzHrCHWvsAsfJ4aWPCD81Jo1rU/2OlhVMfI0P/7BK3h
        9Z/CvI2Wt2Qx4n/70RE=
X-Received: by 10.99.101.132 with SMTP id z126mr747346pgb.64.1498996989296;
        Sun, 02 Jul 2017 05:03:09 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id w85sm37332321pfj.115.2017.07.02.05.03.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Jul 2017 05:03:08 -0700 (PDT)
Message-ID: <1498996988.26970.1.camel@gmail.com>
Subject: Why doesn't merge fail if message has only sign-off?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Sun, 02 Jul 2017 17:33:08 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to merge a branch using "git merge" if a merge
message consists only of a "Sign-off" line it doesn't fail.
To be consistent with the behaviour of "git commit" shouldn't the merge
fail?

-- 
Kaartic
