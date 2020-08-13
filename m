Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE9C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2BB20781
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHMO5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:57:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:57714 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMO5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:57:20 -0400
Received: (qmail 19869 invoked by uid 109); 13 Aug 2020 14:57:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 14:57:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14146 invoked by uid 111); 13 Aug 2020 14:57:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 10:57:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 10:57:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
Message-ID: <20200813145719.GA891370@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813145515.GA891139@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the years some more programs have become builtins, but nobody
updated this MSVC-specific section of the file (which specifically says
that it should not include builtins). Let's bring it up to date.

Signed-off-by: Jeff King <peff@peff.net>
---
Given that nobody has mentioned this, it makes me wonder if anybody is
even using this part of the Makefile at all these days. Or maybe having
extra lines here isn't a problem (though it's also missing some entries,
like one for git-bugreport).

 Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index 65f8cfb236..271b96348e 100644
--- a/Makefile
+++ b/Makefile
@@ -2901,7 +2901,6 @@ ifdef MSVC
 	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
 	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) git-upload-pack.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
@@ -2912,7 +2911,6 @@ ifdef MSVC
 	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-remote-testsvn.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) git-show-index.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 ifndef DEBUG
 	$(INSTALL) $(vcpkg_rel_bin)/*.dll '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) $(vcpkg_rel_bin)/*.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
-- 
2.28.0.573.gec6564704b

