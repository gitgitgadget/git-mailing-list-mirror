Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202D11F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfKHJoL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfKHJoL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so3629594pgu.4
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/EPyeP704tKZka9pJBgLXi0JJ9dfgrr7Zt7ihMK4AA=;
        b=lHg3dWpu2PX3p6il6fViP3fmcz7Hhzf+INuN5kkOgBn1WcSy7Ilr3t4xGrvaH2zAML
         /y6Yhq9JR6HLAl6rJ19bMDqjauEI4cemcfsgUGfiDu6JigLytGMvuBBffV36GFLD/DyS
         xhn9MsU37AmWV/2IDAUmFg/yz4GIrmXCtOzp+T626HZjMmurHwhRzOzLeYiedNWl/XvE
         phruch1vJkjAej4cGUbl5YJPn1d051nP2aRYhNSyACx8ID+fhrAa0D5i0/C+U5ziaZiV
         ftDE8AnGKLyKEYY61VhaEyWIygbnyoNk7ZWYARWTPAY7DBvpJuXCXI3N2umKz/25D8on
         UpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/EPyeP704tKZka9pJBgLXi0JJ9dfgrr7Zt7ihMK4AA=;
        b=lpmDaSM2yS/bK/X5eo+MeIyl9o7VgxP4ppad0ZjzL9n7V0XTz1nB6XNNPURgXp1DZD
         b48RE6BHxAmAMHJy3XU2VRc2kkRgiIbOeZukolgHm5xv9cKsXW9/xmP4afwxKvFsytJ5
         rg/OF+kSFtjlSdla1+dS/iq1V7dXbhwfKHpnNLXjkdgfleq/ezk86IDb21ave56IMCS5
         DwVTp6AwUfGajhSPJ2VxSVHza8Efm8RpAXTdxybbuybxw1YHu3d8nnldXaxUFDzYC4Dl
         ShfdhqmsO4OT7jdjLyQuTlzMerhC2JoTDKyqmUMBicIBMt1IwvmvIAhGhk843nFFGNWX
         IMaA==
X-Gm-Message-State: APjAAAWlhCN5svJLEfOr0LXT808yMULgVSLjGqV3Y7G9oMOKSlT/i1nj
        BwFn0ZNKo1G3VMJKBOdJH3iP+y9o
X-Google-Smtp-Source: APXvYqwk14mhILbzRc4HGBHFcfHSHQu6SBRca+1HBOyJzY9b93qcnDLEW5a+JUtUBohmqeoqyB8MAw==
X-Received: by 2002:a62:ce4b:: with SMTP id y72mr918173pfg.9.1573206250037;
        Fri, 08 Nov 2019 01:44:10 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:09 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 6/9] sequencer: reencode squashing commit's message
Date:   Fri,  8 Nov 2019 16:43:48 +0700
Message-Id: <ed6cfab5d2d304fa248fd024b0f4ce67a59d297d.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On fixup/squash-ing rebase, git will create new commit in
i18n.commitencoding, reencode the commit message to that said encode.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c            |  8 +++++---
 t/t3900-i18n-commit.sh | 10 +++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a19954f2bf..833a928929 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1576,6 +1576,7 @@ static int update_squash_messages(struct repository *r,
 	struct strbuf buf = STRBUF_INIT;
 	int res;
 	const char *message, *body;
+	const char *encoding = get_commit_output_encoding();
 
 	if (opts->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
@@ -1602,7 +1603,7 @@ static int update_squash_messages(struct repository *r,
 			return error(_("need a HEAD to fixup"));
 		if (!(head_commit = lookup_commit_reference(r, &head)))
 			return error(_("could not read HEAD"));
-		if (!(head_message = get_commit_buffer(head_commit, NULL)))
+		if (!(head_message = logmsg_reencode(head_commit, NULL, encoding)))
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
@@ -1623,7 +1624,7 @@ static int update_squash_messages(struct repository *r,
 		unuse_commit_buffer(head_commit, head_message);
 	}
 
-	if (!(message = get_commit_buffer(commit, NULL)))
+	if (!(message = logmsg_reencode(commit, NULL, encoding)))
 		return error(_("could not read commit message of %s"),
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
@@ -4154,9 +4155,10 @@ static int commit_staged_changes(struct repository *r,
 				 */
 				struct commit *commit;
 				const char *path = rebase_path_squash_msg();
+				const char *encoding = get_commit_output_encoding();
 
 				if (parse_head(r, &commit) ||
-				    !(p = get_commit_buffer(commit, NULL)) ||
+				    !(p = logmsg_reencode(commit, NULL, encoding)) ||
 				    write_message(p, strlen(p), path, 0)) {
 					unuse_commit_buffer(commit, p);
 					return error(_("could not write file: "
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index a518281b04..d277a9f4b7 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -224,7 +224,15 @@ test_commit_autosquash_multi_encoding () {
 		git commit -a --$flag HEAD^ &&
 		git rebase --autosquash -i HEAD^^^ &&
 		git rev-list HEAD >actual &&
-		test_line_count = 3 actual
+		test_line_count = 3 actual &&
+		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
+		if test $flag = squash; then
+			subject="$(head -1 expect)" &&
+			printf "\nsquash! %s\n" "$subject" >>expect
+		fi &&
+		git cat-file commit HEAD^ >raw &&
+		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
+		test_cmp expect actual
 	'
 }
 
-- 
2.24.0.8.g2e95ca57d2.dirty

