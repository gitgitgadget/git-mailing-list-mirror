Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD442C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32AF60F38
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 03:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhKMDhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:37:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54537 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233557AbhKMDhO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 22:37:14 -0500
Received: from localhost ([38.30.8.235])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AD3Y6Zg004975
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 22:34:07 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v6 2/8] receive-pack: lowercase error messages
Date:   Fri, 12 Nov 2021 19:33:52 -0800
Message-Id: <20211113033358.2179376-3-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211113033358.2179376-1-andersk@mit.edu>
References: <20211113033358.2179376-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines says “do not end error messages with a
full stop” and “do not capitalize the first word”.  Reviewers requested
updating the existing messages to comply with these guidelines prior to
the following patches.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/receive-pack.c          | 6 +++---
 t/t5504-fetch-receive-strict.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d1f97e1ca..a82b60f387 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -170,7 +170,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 			strbuf_addf(&fsck_msg_types, "%c%s=%s",
 				fsck_msg_types.len ? ',' : '=', var, value);
 		else
-			warning("Skipping unknown msg id '%s'", var);
+			warning("skipping unknown msg id '%s'", var);
 		return 0;
 	}
 
@@ -1584,9 +1584,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (!parse_object(the_repository, old_oid)) {
 			old_oid = NULL;
 			if (ref_exists(name)) {
-				rp_warning("Allowing deletion of corrupt ref.");
+				rp_warning("allowing deletion of corrupt ref");
 			} else {
-				rp_warning("Deleting a non-existent ref.");
+				rp_warning("deleting a non-existent ref");
 				cmd->did_not_exist = 1;
 			}
 		}
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 6e5a9c20e7..b0b795aca9 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -292,7 +292,7 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 		receive.fsck.missingEmail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	grep "missingEmail" act &&
-	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
+	test_i18ngrep "skipping unknown msg id.*whatever" act &&
 	git --git-dir=dst/.git branch -D bogus &&
 	git --git-dir=dst/.git config --add \
 		receive.fsck.missingEmail ignore &&
-- 
2.33.1

