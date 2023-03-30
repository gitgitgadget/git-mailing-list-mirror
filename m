Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD058C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 11:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjC3LVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 07:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjC3LVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 07:21:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0169840CF
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:21:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bi9so24029309lfb.12
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPASoIxDEorXVc/V18X4+W98gAZjeiv6oWwVUxW0CLc=;
        b=f+fspTNgAw0ne5CvxDdIPKlQltj+CA/jwScOHIgaGPDtYsGT0bKXNcRO1sOTzLI2PE
         kmBmwh58XDM3G6Bxi6VH+yZK5So7Ez4jQw6hzmDnR+D5KE5sHjeOlUly2+FKB8Vpl0Pb
         6dYEEBtQu6lJFeQiGj5HQbNcuPs7c4nqZHpadzsxbHoRjDyBd/abFCoywRHudtQWHs5l
         e6Yxe+dQKCbUx4c4eKhcJhadiNVicOkBsUpLHDcspSeHDsLWVPHzr5AF58E4lRTGcwjr
         dxRS/8hmEOSnec6CnlXzvVGT0QeUcOuub2sDoy5gE1e0ELYquSK93hiNiwZSWHCki4E6
         VXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPASoIxDEorXVc/V18X4+W98gAZjeiv6oWwVUxW0CLc=;
        b=3wZydKolv2WMn46zu26hlGH46o+w8G6PaN0+XG2DVk6PNb9kpM8pGgdD3gh5x0S2sV
         /2QgaCrGBCZ994hyPmZkYt/JygpUNbaRC0TotQCaIOatiPepyVm5/qI/LZ0tOFtSbX3G
         srcgUYaas2/w/LexLQo5+That2WMLul6OynCcfjFl/v7xawb03mC9N80cJrFSiFn4lPm
         piB9cZ0WkLnjQhVXQs7rldcJ7qU1prcQLalAtYs/OE0BVNYrO7+N9QScEh839qwbDpEJ
         TeA5s+JYGAV5cwdL7tLIEiko1fPDEDnm9bHHyA4xyoexHFXxPX99zmyl1TRfX1zpnChd
         iLaA==
X-Gm-Message-State: AAQBX9ftkVJt0dzQzQ6DTrGQ/y8skYiKElCmMcrHKahIoB4mDeT6dc7o
        HuGICNCosFAzP/D0LKIx/Eoxt9RzxogpMg==
X-Google-Smtp-Source: AKy350b0jdqbdHPmrKfJfq99zCrleEb/ohypxQqhI1/BWcL7Y3yAo1JrAAoYKXLKBewlAZymZ2YkPQ==
X-Received: by 2002:ac2:5301:0:b0:4a4:68b8:c2e4 with SMTP id c1-20020ac25301000000b004a468b8c2e4mr5905019lfh.59.1680175304382;
        Thu, 30 Mar 2023 04:21:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9575:60ad:3b58:51c5])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004cc82b7080bsm5869024lfl.200.2023.03.30.04.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:21:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 0/2] branch, for-each-ref: add option to omit empty lines
Date:   Thu, 30 Mar 2023 13:21:31 +0200
Message-Id: <20230330112133.4437-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches are independent of eachother. One is just a very small
cleanup that I discovered while working on the other. Some thoughts
after the --- line in each patch.

Øystein Walle (2):
  ref-filter: remove unused ref_format member
  branch, for-each-ref: add option to omit empty lines

 Documentation/git-branch.txt       |  5 +++++
 Documentation/git-for-each-ref.txt |  5 +++++
 ref-filter.h                       |  1 -
 builtin/branch.c                   | 12 +++++++++++-
 builtin/for-each-ref.c             | 15 +++++++++++----
 ref-filter.c                       |  1 -
 t/t3203-branch-output.sh           | 26 ++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  8 ++++++++
 8 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.34.1

