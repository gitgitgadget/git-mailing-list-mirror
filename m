Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898DD2027B
	for <e@80x24.org>; Wed,  1 Mar 2017 23:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbdCAXLz (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:11:55 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38288 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753380AbdCAXLv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:11:51 -0500
Received: by mail-wm0-f45.google.com with SMTP id u199so48392670wmd.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 15:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0MXmA3VDiMzFJrF8zHg527iXWxmk4nbfWFYsQK4Fwo=;
        b=igqD9WojayWs+s2mZre+ZF2v8ndNNAvwDLuRzcKAOV6/5Cw72fhXLeDlh6p7QfOC9t
         2A7ATxd0I7jO3D0uQX8uLjbHSIc6D5GvCTIl1Edr+i4zSD5FbAMcNPeOgxCJlYMXoWNR
         wDMbmWGfj8X6kpPWGZgPXaE6zjP900VFQ8gkl1BUqoSdDlNdrj7imhu+nVtJbItXU8zI
         3YhuhuFYwdZGABMDEahHBRkVhOejub80vv+0JobC2413pwYXhA5kC1lOOioMJTpHC90I
         t4saEWgZ3VBxjrP2Qx6nk33hySuu7wj0V2fF7AP/s+6Nj8WbIq5DvTbHoYPiWrGtP8wv
         Hb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0MXmA3VDiMzFJrF8zHg527iXWxmk4nbfWFYsQK4Fwo=;
        b=Sft2bT/YZCbJCD9Hiz4mc/URit0Jn5dpBqHGrkq+TZEOnIji1+z83uIuOvftEwlDrr
         v0mpswc4wtlpz3eLyBsRvNeWD952g78CKu4cr2aWKRXrLQlzAfTRou8NGe+ffjdbf5I8
         KqgzrVJhn9Ie2gnCo71LyD9W+ZeCrDg3JEKRFt2B6y78cEW8qW1WZ+kAW5NhF2mFiLfT
         neSr9FqlJB84IpMDeTX9z3k63EgLAeiTXenwGfSSFNim1TltY4/aIRGpOkELVynCYswR
         7CftsdHBuYQtz9g2yq03J4IkPSYzEZpvAovo/8sH1qKP6bLS6jO9Mn9FTlVTg+G768re
         L1+w==
X-Gm-Message-State: AMke39kbRIuurOtV3UC0j6PPUkL6Fo++gM9D/7EBOx/GSfYCu5lXmDkiK8EKleTM4QUeCQ==
X-Received: by 10.28.199.206 with SMTP id x197mr4909506wmf.5.1488402951292;
        Wed, 01 Mar 2017 13:15:51 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v18sm8136233wrc.41.2017.03.01.13.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 13:15:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] Minor changes to skip gitweb tests without Time::HiRes
Date:   Wed,  1 Mar 2017 21:15:38 +0000
Message-Id: <20170301211540.4382-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
References: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was originally just one small patch, but Jakub Narębski pointed
out that calling the module "unusable" when we failed to load it was
confusing, so now the start of this series is just a rephrasing of an
existing error message I copied.

Ævar Arnfjörð Bjarmason (2):
  gitweb tests: Change confusing "skip_all" phrasing
  gitweb tests: Skip tests when we don't have Time::HiRes

 t/gitweb-lib.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.11.0

