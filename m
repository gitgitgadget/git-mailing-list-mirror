Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B35C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjD1M4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjD1M4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 08:56:51 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2EC2717
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 05:56:50 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 839CE2406A;
        Fri, 28 Apr 2023 08:56:49 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1psNeb-DOv-00; Fri, 28 Apr 2023 14:56:49 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] sequencer: actually translate report in do_exec()
Date:   Fri, 28 Apr 2023 14:56:48 +0200
Message-Id: <20230428125649.1719796-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
 <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

N_() is meant to be used on strings that are subsequently _()'d, which
isn't the case here.

The affected construct is a bit questionable from an i18n perspective,
as it pieces together a sentence from separate strings. However, it
doesn't appear to be that bad, as the "assembly instructions" are in a
translatable message as well. Lacking specific complaints from
translators, it doesn't seem worth changing this.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>

---
v2:
- mention the word puzzle in the commit message
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..0677c9ab09 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3628,7 +3628,7 @@ static int do_exec(struct repository *r, const char *command_line)
 			  "  git rebase --continue\n"
 			  "\n"),
 			command_line,
-			dirty ? N_("and made changes to the index and/or the "
+			dirty ? _("and made changes to the index and/or the "
 				"working tree\n") : "");
 		if (status == 127)
 			/* command not found */
-- 
2.40.0.152.g15d061e6df

