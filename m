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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4A71F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfKGC4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33679 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbfKGC4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay6so449778plb.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pc+VWmOwxXV83DwcNugZXUJjoybQ4Kg/0s03vHpZPz0=;
        b=d6WI8BTDg+1d+aXbhwTTLgu8E8N5KnBNNXsZeQ4Z+zXdXuYtZSws53fcji+OfzKc9W
         VEpFkOH17zygwM2v0Pn4fyn+f3uGe9mmSq4LTirejWzEtltXK6TSuWbKzS0y1mwzQZqg
         vgmJSD79CdkfEvg449CYX9NIPHRtLGjfV4hBT8dFp2SSCRh3WGNh+c8j38JyKqurHY9r
         1/qfLs7IuBDy45vIF9oYeiEsKeurXsyiSpe+aRaTVApWMIZ80npGRw9HZVZSxEenXy6K
         E6WIJHURND4X3pbc6GcY5ixGD1YvV3PWXfVNlNsDqLFMxS9Bvh0XMCOcGX/6IenljPFl
         DaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pc+VWmOwxXV83DwcNugZXUJjoybQ4Kg/0s03vHpZPz0=;
        b=WK4b8UEyh15hhVGjzJiAptcyGrmOCGW+O9fKwlZeKqGLGvw5WzaW5j//cPhZ3ECuHx
         A0/F1CrwUIxpr+knf6lb/kL9VT41z1zCySpcPPpsi/1Qb8+UEUlqbTctkat8dKnzK6C9
         NfVJ5AIHqP9NJnwIAzzjAgvgDVmbdpxhUNBY79f32V5t2Fnz4afB8+l9YegY+6Jm2QBZ
         l01/UX+yb9AHy9LJc4i8oFK5O6j1Q75T0UDvysh8o/X88fJBCksB5XDOHiadlKmFLsXF
         s7YGW8KIncAk+sLjKmPWWGV70xaO15gfWsbZbGmUSEjbZJg0WMvEKpzS8pAOE9JlkpXu
         uyHA==
X-Gm-Message-State: APjAAAX3WQzEleN/5NkdkT+aubLtDQYeglCZGHihiEGZWDe/IiYbmLJR
        pFa56EpbEyTGe9G/J/aPfpeMg83S
X-Google-Smtp-Source: APXvYqw0EI88t5QYH7rqtIafKYE0Iz5L3m5c5bQlUHcmaHLbj3K/LOlrOuUJo/iWMQmC0jMg74G9Wg==
X-Received: by 2002:a17:902:6ac8:: with SMTP id i8mr1225116plt.30.1573095398698;
        Wed, 06 Nov 2019 18:56:38 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:38 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v4 6/8] sequencer: reencode squashing commit's message
Date:   Thu,  7 Nov 2019 09:56:17 +0700
Message-Id: <97ab88e5d886b376b396b2fbe563e1a21be03e44.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <cover.1573094789.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573094789.git.congdanhqx@gmail.com>
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
 t/t3900-i18n-commit.sh | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

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
index e8ce5323ee..521d7bb927 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -209,6 +209,13 @@ test_commit_autosquash_multi_encoding () {
 	old=$2
 	new=$3
 	msg=$4
+	squash_msg=
+	if test $flag = squash; then
+		squash_msg='
+		subject="squash! $(head -1 expect)" &&
+		printf "\n%s\n" "$subject" >> expect &&
+		'
+	fi
 	test_expect_success "commit --$flag into $old from $new" '
 		git checkout -b '$flag-$old-$new' C0 &&
 		git config i18n.commitencoding '$old' &&
@@ -224,7 +231,12 @@ test_commit_autosquash_multi_encoding () {
 		git commit -a --'$flag' HEAD^ &&
 		git rebase --autosquash -i HEAD^^^ &&
 		git rev-list HEAD >actual &&
-		test_line_count = 3 actual
+		test_line_count = 3 actual &&
+		iconv -f '$old' -t utf-8 "$TEST_DIRECTORY/t3900/'$msg'" >expect &&
+		'"$squash_msg"'
+		git cat-file commit HEAD^ >raw &&
+		(sed "1,/^$/d" raw | iconv -f '$new' -t utf-8) >actual &&
+		test_cmp expect actual
 	'
 }
 
-- 
2.24.0.8.g36796e2b67

