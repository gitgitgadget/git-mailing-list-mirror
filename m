Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED8C41513
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjHIRPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjHIRPe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:34 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B701FEF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 7427B2425C;
        Wed,  9 Aug 2023 13:15:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lD9-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9001: remove excessive GIT_SEND_EMAIL_NOTTY=1
Date:   Wed,  9 Aug 2023 19:15:31 +0200
Message-Id: <20230809171531.2564754-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was added by 3ece9bf0f9 (send-email: clear the $message_id after
validation, 2023-05-17) for no apparent reason, as this is required only
in cases when git's stdin is (must be) redirected, which isn't the case
here.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
Cc: Junio C Hamano <gitster@pobox.com>
---
 t/t9001-send-email.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 48bf0af2ee..c445859f73 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -659,7 +659,6 @@ test_expect_success $PREREQ 'clear message-id before parsing a new message' '
 	clean_fake_sendmail &&
 	echo true | write_script my-hooks/sendemail-validate &&
 	test_config core.hooksPath my-hooks &&
-	GIT_SEND_EMAIL_NOTTY=1 \
 	git send-email --validate --to=recipient@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches $threaded_patches &&
-- 
2.40.0.152.g15d061e6df

