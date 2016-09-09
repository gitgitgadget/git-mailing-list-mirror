Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F3720705
	for <e@80x24.org>; Fri,  9 Sep 2016 20:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbcIIURw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:17:52 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35555 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbcIIURr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:17:47 -0400
Received: by mail-pa0-f51.google.com with SMTP id b2so31460085pat.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1d7tOZpkjmxniWVdz4JgpyboSolQKNKZwg312l6p19Q=;
        b=CP21NdiI4Yw/U8TaPfLXGeGHlYp4RlTvuV9ZNDCDTVdLeEZUK6HTNPEUNE5f1KvDZA
         rpRObLMMdADB88bRp/BZJBxeSbd9S2+z1kId7o5DZI/XFMx6HZ0+Qlb/unnnWMFgTLtD
         S08R86a2WudaBRkSIftfQztCYzQUF3gUCv/Vnf5vL+HqgzP0qSsSGkvxb9Rk+Xt5ij4E
         5qbbB8hn01eavOIK0L4LCw1AZY1iNVaXfQurfswX8b2lMXFSxEqPKgD4msupk5RY2T8r
         94I3QNeDNpnEvHNYs536z0UU+bGk496RRxiwu6LORNlWRreHYB/cBViey5IchuhRIbWj
         4z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1d7tOZpkjmxniWVdz4JgpyboSolQKNKZwg312l6p19Q=;
        b=JA1+JoiQRFArMfwkepiDajyrn+swY6yauBjpuIAFlg/3B56yZXLZEuPgspJsTZXkaa
         QXYZR01aqx96lnzShsvEhzansNuDW9dm/llt8Boz8wS0JpQKyG0nIYCP690IkOQPQl6F
         XTJqmPicbdYq6c/sk5i7NN3HsayKF5jR2bN7DOWvS+e7ZM8ZQJKkAww7UiJ7BaqHAVqB
         1jYRMjq6N9JjxUWX7ld2wkeAvAFN/TxT68K47PjoH/9HlQgoUn6YIWUljyn1K5NnxzVF
         qTsnNMhBXxxg0X2hugnsR0pNggqUALFNevGYIeHUJUtPzqNvHuJTCkum24wa+qj0zxyq
         j67w==
X-Gm-Message-State: AE9vXwMmuYU86tI7bNkcLIiqOrWA7ekN81kAf7drkGlYBL2tvpURFLipeO4iiaTbIGUcRKTY
X-Received: by 10.66.27.44 with SMTP id q12mr2110302pag.58.1473452261569;
        Fri, 09 Sep 2016 13:17:41 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id s1sm7203690paz.47.2016.09.09.13.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 13:17:40 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com
Subject: [PATCH v5 0/3] handle empty spec-compliant remote repos correctly
Date:   Fri,  9 Sep 2016 13:17:34 -0700
Message-Id: <cover.1473452153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updates from PATCH v4:
o use fatal errors ("die") instead of warnings for protocol errors
o reworded commit message - removed last sentence and wrote "(following the
  specification in pack-protocol.txt)" in one of the earlier paragraphs

Jonathan Nieder (1):
  connect: tighten check for unexpected early hang up

Jonathan Tan (2):
  tests: move test_lazy_prereq JGIT to test-lib.sh
  connect: advertized capability is not a ref

 connect.c               | 32 ++++++++++++++++++++++++++------
 t/t5310-pack-bitmaps.sh |  4 ----
 t/t5512-ls-remote.sh    | 40 ++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |  4 ++++
 4 files changed, 70 insertions(+), 10 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

