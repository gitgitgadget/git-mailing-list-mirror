Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDDD207FF
	for <e@80x24.org>; Fri,  5 May 2017 14:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbdEEO51 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 10:57:27 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33784 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbdEEO5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 10:57:25 -0400
Received: by mail-wr0-f176.google.com with SMTP id w50so5391248wrc.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQ/5KbURtFTtAB2mNK6pP+MrO26rylEYyzC2GvUHIc4=;
        b=MhBHHS6C/UYNysrIuPyPbu3B3RQg8JauNhETv+gcR7zqYiX3X7qLBcWSaAOgpkZuG7
         h2G4sVqEHQYhbR2f6s/J+qnH+It1n1tJ6hCGBqRvy/8ZEKGXvPkhfHPk3ciRgEV981/a
         8622E4E1jVNtvt0R/UgkFOhN0wSINXax3hoptJIZnrnv4K5iI58swEUHgdzJ4pNpqn0P
         WlAlOFdeM+LzSbMXHfMXQbQa1ag/6LImKUe3BX8dQ59A2hJ73oDaCxHC1E34ww38iJ+3
         4oE1hQ+EM4If61o+egmGnIjItNXdeFOl9ei2keNqwAPFDPVeWTPTfVQqmjZQu95MP4P7
         TjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQ/5KbURtFTtAB2mNK6pP+MrO26rylEYyzC2GvUHIc4=;
        b=MaeHQicG3rM+f4SbJnTmTGEN0SxNp+sv5QCNXOU9DDc6sBxjoQCTUQOrfepGJTi2fR
         SI8/PGa3ZgFmdVzjH3Xn+kCnPtm13UOT+4pxtnNo7Dpqs03RwqutcN/JhVqT6Jk6zavi
         eWgX9WyQMFWEvD4shsamvwzKtoJi79GOEJca3HGUGSkFUkwNWNCJMGNBeDXSW7Ke2u+d
         CVXThp44MRmHtRp2z9uvBikQUY4DpC75AcXhyltyjbhIV2wVBCz9ws69Lz9e2zI5oFY/
         NrDEPlWQ5+mcFD2O8n08b9OaU2WAVTIkoI6p+VKdndgRI0jZW9HzqKy6i7BTgrLEW4xf
         PujA==
X-Gm-Message-State: AN3rC/7jBM3AXOR50oPXbcaBoGsa9uwYF9Yd9Nii8pT4OjxKnxbh7PkL
        hgKKLfc/4z9XLA==
X-Received: by 10.223.164.9 with SMTP id d9mr28567668wra.91.1493996244484;
        Fri, 05 May 2017 07:57:24 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id k4sm1994431wmf.12.2017.05.05.07.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 07:57:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/2] split index extra bits 
Date:   Fri,  5 May 2017 16:57:11 +0200
Message-Id: <20170505145713.8837-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.0.rc1.83.g83955d3ecd.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series contains 2 patches that have already been sent to
the list but have felt through the cracks. It would be nice if they
could be considered for v2.13.0.

Patch 1/2 (split-index: add and use unshare_split_index()) by Duy
fixes a memory leak when a new shared index file is created and memory
used by the old one should be freed.

Patch 2/2 (p3400: add perf tests for rebasing many changes) adds a
test in t/perf that can help see what performance improvements can be
gained by using the split index feature. For example using this patch
at one point I got the following results on a Linux machine on the Git
repository:

Test                                                            v2.10.0             v2.11.0                  v2.12.0                  origin/master         
------------------------------------------------------------------------------------------------------------------------------------------------------------
3400.2: rebase on top of a lot of unrelated changes             2.62(2.19+0.55)     2.54(2.15+0.49) -3.1%    2.59(2.19+0.49) -1.1%    2.66(2.27+0.52) +1.5% 
3400.4: rebase a lot of unrelated changes without split-index   14.08(10.12+3.92)   7.20(5.85+1.36) -48.9%   8.06(6.54+1.60) -42.8%   7.53(6.40+1.12) -46.5%
3400.6: rebase a lot of unrelated changes with split-index      14.10(10.11+3.94)   6.94(5.71+1.27) -50.8%   7.99(6.49+1.57) -43.3%   6.10(5.12+1.07) -56.7%

On bigger repositories results are likely to be better.

Christian Couder (1):
  p3400: add perf tests for rebasing many changes

Nguyễn Thái Ngọc Duy (1):
  split-index: add and use unshare_split_index()

 read-cache.c           | 10 ++-------
 split-index.c          | 57 ++++++++++++++++++++++++++++++++++++++------------
 split-index.h          |  1 +
 t/perf/p3400-rebase.sh | 22 ++++++++++++++++++-
 4 files changed, 68 insertions(+), 22 deletions(-)

-- 
2.13.0.rc1.83.g83955d3ecd.dirty

