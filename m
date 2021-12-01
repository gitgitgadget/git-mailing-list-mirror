Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADCCC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353470AbhLAWTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:19:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33959 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353450AbhLAWTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:19:45 -0500
Received: from localhost (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B1MG6Cm012583
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Dec 2021 17:16:08 -0500
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason=20?= 
        <avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH v7 2/8] receive-pack: lowercase error messages
Date:   Wed,  1 Dec 2021 14:15:41 -0800
Message-Id: <20211201221547.1796213-3-andersk@mit.edu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201221547.1796213-1-andersk@mit.edu>
References: <20211201221547.1796213-1-andersk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines says “do not end error messages with a
full stop” and “do not capitalize the first word”.  Clean up existing
messages, some of which we will be touching in later steps in the
series, that deviate from these rules in this file, as a preparation for
the main part of the topic.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/receive-pack.c          | 10 +++++-----
 t/t5504-fetch-receive-strict.sh |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d960..ddda27c184 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -175,7 +175,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 			strbuf_addf(&fsck_msg_types, "%c%s=%s",
 				fsck_msg_types.len ? ',' : '=', var, value);
 		else
-			warning("Skipping unknown msg id '%s'", var);
+			warning("skipping unknown msg id '%s'", var);
 		return 0;
 	}
 
@@ -1589,9 +1589,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
@@ -2490,9 +2490,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
 
 	if (argc > 1)
-		usage_msg_opt(_("Too many arguments."), receive_pack_usage, options);
+		usage_msg_opt(_("too many arguments"), receive_pack_usage, options);
 	if (argc == 0)
-		usage_msg_opt(_("You must specify a directory."), receive_pack_usage, options);
+		usage_msg_opt(_("you must specify a directory"), receive_pack_usage, options);
 
 	service_dir = argv[0];
 
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
2.34.1

