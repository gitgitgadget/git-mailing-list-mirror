Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F5C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BA5611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhJUUAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhJUUAW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC18C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e12so443880wra.4
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VKapOY7ZJLaC0wZOpYvaKSoYoHqGqfejIRIZJvhodTo=;
        b=IER+w3bbVsSy3ENArAn/Nc5/P6EcUJJbggmW7KBQdmd5fuD5+1reXSiMH3pcdFe+d4
         K8Et8NPaMXOc2GurVU1JRaObWvA8HKzAbqUzZ4El4UbwoQum9W5phjoeTxkG3WR3XWr8
         LeD9TvV48B52+1T/V1xFQeLx/SCeYehxlbcZ0kW9GPiAYCnohY2N0Fkkk0+PPfyYw2aN
         6h5++jHIka+Wngx8yQ/DiUcOsETSv+Rt42QZGY701ypvh+aXLs741UgNeV7J5aYEQR0F
         8qUrzan9AjiBFMshUAtRSto3Fkxtfi5QoLfzR/6mNakFtz305KKF9wJv2sQ0gga36Tgm
         /k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VKapOY7ZJLaC0wZOpYvaKSoYoHqGqfejIRIZJvhodTo=;
        b=JiTG1MYFQLnV2sZI7eKpg1INffvpFYyElf0hucapNmN0ayY5NrRJtgzD9SHsChPa8r
         NgYSULY7fqyWKEVV43CeIiQMj6DEO1F+qpO0UicgZdOhWHZI8PPFU1NyP4Eta9gmzefC
         paVn9pzsUuBldYmp5Dvt2loqFsFrAeLmoIZdvQdar+6v7VhJXW9FQ4iJEhwbXTcXiJM9
         ree0bI4e4Pf/BFySOhC4Uay2XKpSiYf466gTDP5ANlGcFBMSfqmO17bV70bp+p25HAJx
         b7DbUDgkCdBaqN0eUGclmUYJUdfoeT4qqG5Tkx+Q447Fh8o1SHKHYJhoGkkfhEVSqQPj
         Cqyg==
X-Gm-Message-State: AOAM533CcVzUVDAxS2s0BGXoK1aJDvTNUSj0eSB0LGT7+qd3XfJhb6js
        0YMLgMdcXeyZpthq/NyKUplSiozShY/gfQ==
X-Google-Smtp-Source: ABdhPJwdcZXv99PgmRBGc+NIPnjHvUbP3h9ooxd48FUIEv2IVk/HIWuDZba0q8Au7avCz8BUSvstoA==
X-Received: by 2002:a5d:6d07:: with SMTP id e7mr10065685wrq.425.1634846283841;
        Thu, 21 Oct 2021 12:58:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40sm388765wms.10.2021.10.21.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] Makefile: remove $(GIT_VERSION) from $(SCRIPT_DEFINES)
Date:   Thu, 21 Oct 2021 21:57:56 +0200
Message-Id: <patch-2.6-7cc3a1d7205-20211021T195538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $(GIT_VERSION) from $(SCRIPT_DEFINES). Now every time HEAD
changes in a development copy we don't need to re-build the scripts
and script libraries.

This has not been needed since 2b9391bc675 (Makefile: do not replace
@@GIT_VERSION@@ in shell scripts, 2012-06-20). On my setup this
changes the re-making of 44 targets in a development copy where moved
HEAD to 27.

The $(GIT_VERSION) was seemingly left here by mistake or omission. We
didn't need it since 2b9391bc675, but in the later
e4dd89ab984 (Makefile: update scripts when build-time parameters
change, 2012-06-20) it was added to SCRIPT_DEFINES.

The two were part of the same series of patches, and given the summary
in [1] and [2] it looks like this was probably a case of some earlier
version of a later patch being combined with an updated earlier patch.

1. https://lore.kernel.org/git/20120619232231.GA6328@sigill.intra.peff.net/
2. https://lore.kernel.org/git/20120619232453.GB6496@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f52402b24d8..fdce392929b 100644
--- a/Makefile
+++ b/Makefile
@@ -2252,7 +2252,7 @@ command-list.h: $(wildcard Documentation/git*.txt)
 hook-list.h: generate-hooklist.sh Documentation/githooks.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh >$@
 
-SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
+SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
 	$(perllibdir_SQ)
-- 
2.33.1.1494.g88b39a443e1

