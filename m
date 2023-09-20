Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC217C04FEF
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjITTRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjITTR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 15:17:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FECFB
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:17:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c59c40b840so1091395ad.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237432; x=1695842232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85Ye6N+PmLULIR14nIvpufooZ/NaFuWvGs0+YcxcLqs=;
        b=BTYZSMHjuH5Gbdbml7ux+cQw8yZH9ertsKEmk1/+7PpLKwglGMFaYZDkOjLEwuMBzS
         Gn836+yZ+yPQHnVqDvJhaGsPioE0kyfOJavI+eVkrOOmivzTnFkKquiL8y/hGrfVQbM+
         z3xWUGIDA2TkTJcPtQvLevft9P2Tu2uXUnniSsaL5nnMwJNdkdMasPugAnvRbKR50ltR
         YnrbJbLV8OeH5bIR3KYOYr5IBePOzlxgiEkfLgpSRY6JkP7mXAYZUio152Hk5x0tpMYC
         LtPaIDpFRVpCsiEkUZoWNEojbl6zvEc7ibGM9AEbccryIkk7x/CGi0oxJLzMcBnQ69nr
         Zdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237432; x=1695842232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85Ye6N+PmLULIR14nIvpufooZ/NaFuWvGs0+YcxcLqs=;
        b=Oe77W3bk//+hCkMEWBGpOEO9boMGbQyy+MJLl8/XpcIbxuBZpdaw1mUy3le46XyDkL
         W/JM9r1H6QdkhK1fsjUJx5Gq70lJbleGoRYD7XWh7p7ogG0C8qgC8U+rpYi/5x7LxzQs
         53EUrjsG5FXrCE6WP4/ZT8ETLUv3yANXp58Uao8VOkhFkSF2Qp1TWAFGVz0Tj6WPa2fb
         yMddg5obWyktLy8vrRSSuojB18J5YOUR5eeVxlDgg5/9YseJj9E/CbCR/s9w6qV0nwIy
         VmLm8QQKEnVs1T6iYIEYP914zfRhXjwdATgU3WYfOqz/lo4/zI37sNSqelHi4vmn+UZ3
         rDRA==
X-Gm-Message-State: AOJu0YzdI6IPvyf8J3VrhiAGOFcVAlfCb4lO/K9drbSlDlQb37q4Ov4p
        0R6Y1kwdl7RLV3yB9pUVPbkxlv3gvCaVgg==
X-Google-Smtp-Source: AGHT+IEuU1/RLRSDTegj1aHCVORWpUITrq0NvDVaJENr0UqpJyF6PrykTDYG5+wB6W4SjUn85uRG9w==
X-Received: by 2002:a17:902:c10d:b0:1b6:6e3a:77fb with SMTP id 13-20020a170902c10d00b001b66e3a77fbmr3128392pli.2.1695237432324;
        Wed, 20 Sep 2023 12:17:12 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.110])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001c420afa03bsm11146847pla.109.2023.09.20.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:17:11 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 0/2] Add mailmap support to ref-filter
Date:   Thu, 21 Sep 2023 00:35:40 +0530
Message-ID: <20230920191654.6133-1-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.160.g6905eb16ce.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add mailmap support to ref-filter, making ref-filter and pretty closer, which
is a part of the effort made to unify both ref-filter and pretty.

PATCH 1/2 - Introduces the "test_bad_atom()" function which checks for if the
	    given error message (either due to "err_bad_arg()" or any other err)
	    is correct.

PATCH 2/2 - The actual mailmap support.

Kousik Sanagavarapu (2):
  t/t6300: introduce test_bad_atom()
  ref-filter: add mailmap support

 Documentation/git-for-each-ref.txt |   6 +-
 ref-filter.c                       | 152 ++++++++++++++++++++++-------
 t/t6300-for-each-ref.sh            | 103 +++++++++++++++++++
 3 files changed, 225 insertions(+), 36 deletions(-)

-- 
2.42.0.160.g6905eb16ce.dirty

