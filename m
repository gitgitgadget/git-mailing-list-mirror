Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3970C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiDWPs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDWPr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 11:47:29 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEBD2E6A8
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 08:44:28 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e5c42b6e31so11690965fac.12
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPvofDeZ+h7kHimLH0EFp8D8HvNV2VlMYox2K8y+/hs=;
        b=oOjfsFu66QcsnioDWkvi2qhh/5bRj0ng+qV9T1akv3j4o1xqenEPk9sPsZqVjOioi6
         wtHL2JyYyBFdbh667B/M+nkPEP51OXtVFcJEEStMzkEjDzpTjb5s6SM1xyuo81C7quL5
         u3yILiz5Q/ZtY+2q/d/oO7F/TskXte+alL+nHEg/PgI4EpdG7IC+m1AtmoaN8uQg7d38
         a9VBpw7x0JY+DQjbWZZ0x5n+/YarrRjPr3enWUjev8WrjJQIOxuFPXNu+xTkNcgPUQog
         OPaAGGA9enJqIQGQBk2RJeTroVld4KJTq3egsMYwCSoip5a9XLBhBGRBRxrG82dQ/SYq
         rRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPvofDeZ+h7kHimLH0EFp8D8HvNV2VlMYox2K8y+/hs=;
        b=E8H4t89/AEp5ZnhnEsM3/J6cOHyij37n45QjNyV+VX8+oO1I/dRjKDop9k3W9ozYmh
         m7psPxm1C87q3uI/9rKnZD4TXRROWYTjW/FT6pIV/yEyVOSBoVBd170SR04ewAawqKmL
         T2fMS3P920lGV7kxZuxxfDrA7fn/ll2SHlbweIe1jhDMCI0DEO5LHL68yIcO6sVbxr8Z
         hjM5r2pJaCMILWnfz0iZFiJ9zYdTFuhJttwBPtZf5Q8WfcTBD1MIQBmOo2nio2ms0rID
         3OXMfhtWQlYvRvP4SpYPoiDxhF8XvRuJME6UCmi1QAsxu3bCHvJckAVzIIg/KEhC0M2P
         LTPg==
X-Gm-Message-State: AOAM530odThpc0L+2qeKEAQGW7B2Jf/8CYQHIoaf4xsqdJ+rHTrNVHrt
        sdT4HHhv7qqWhTEPPklxtKCJ9TdOsik=
X-Google-Smtp-Source: ABdhPJy5Hk2yP0Aa0cEzoxtrBZIbY/pbCyGxt/H7WTUT5jtcLbLQ7H2ccjM1+Q6x6u5EewsipUGtwQ==
X-Received: by 2002:a05:6871:282:b0:e9:113a:fc6a with SMTP id i2-20020a056871028200b000e9113afc6amr2085045oae.200.1650728668037;
        Sat, 23 Apr 2022 08:44:28 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id i19-20020a056808055300b0032291046d05sm1914653oig.20.2022.04.23.08.44.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Apr 2022 08:44:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! CI: use https, not http to download binaries from perforce.com
Date:   Sat, 23 Apr 2022 08:44:20 -0700
Message-Id: <20220423154420.32885-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <0220423142559.32507-5-carenas@gmail.com>
References: <0220423142559.32507-5-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure why this is suddently faiing, but this proposed fixup also
makes both server names consistent and would be easier to clean up
later.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 98444821729..b8ace0355e2 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,7 +5,7 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=https://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
-- 
2.36.0.266.g59f845bde02

