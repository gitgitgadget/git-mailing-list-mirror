Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0CC10F28
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FC4206D7
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9QgQfh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCHS3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:29:51 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35274 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgCHS3v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 14:29:51 -0400
Received: by mail-ed1-f54.google.com with SMTP id a20so3373564edj.2
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ol3DQ+KSmcnUwbt0YpAil/3FYpjvsPQWJam877y+Ko=;
        b=W9QgQfh16LTJSMGADDo0iqsaXPRKkNHzNKtb6Z7LkfraA4BM5shaV2kPZo1/rBl8nG
         hevEetXlsPX4egUwEUepmDEpiS/YGQst5TH9VC3RalbDK+D0M5S4AAgbZaWX54E/v0NH
         1PCTpezMN3Ky74jD0/l0HsmT6IgN70nPQElkdgEKayXYr2bJqCCHm2aurXVs6PA+2KHO
         zBnaxqRh63ofF8KIIIKsYsCtNCWG80x8w6GhJrzhUMQfLbNDNFkx9YcsqmR372aecSUO
         l3I9p3RWbp9Rqc3YAnyQ6+/7HWy3NRHz1y168xtlCfaP6u0rti7UyFWImAwnNYzRxf9C
         AZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ol3DQ+KSmcnUwbt0YpAil/3FYpjvsPQWJam877y+Ko=;
        b=jvSJQNpB5EVp5KLm7qcHN11TKInGM5pB0lieVmdkMBHRQAzxeYxGettWZ3Igpv0+QN
         fOthFK0zL434Mp3FsfJoWsVjWwhahUSQOrcvosnKdp5s3YoVv00DdY4vW9mv7vL6D2ZG
         rzRc9Pnm0S46Pdp5jwbk1twT5YgoMGPghGnOjHORX2XPQ33twhTbEjNW6QFThHsNnD5B
         KAwljl+IKZydR8aPDGb/20I5UBYqPDzRIp4pVM9SgsqTF3zDbJARDNBdeVlEUkKjuig2
         ZEAEY+QMCZVEvLkx6e0JBudg927kM1AGPAEQx5PBP2XljZQkARr6hHLbRDJWpq4gaWgO
         aOGA==
X-Gm-Message-State: ANhLgQ0CG/t5KD474QeNx+mAJmxRqfnTVHmwglexLcre/C+DLfUuHLsJ
        wRq829JffbtUqghetDp1RHO9o3Of
X-Google-Smtp-Source: ADFU+vsx8n0z6r6FXfW8x2y4NHhtY/zz5QFI5Z+hgfrMpYaMGFsPHFGYEOkpaIGQ9GulH1a7jcoZtQ==
X-Received: by 2002:a05:6402:1b0e:: with SMTP id by14mr13803508edb.209.1583692187054;
        Sun, 08 Mar 2020 11:29:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm397188edf.36.2020.03.08.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 11:29:46 -0700 (PDT)
Message-Id: <b25211380355f7f95113b42734df0bb8b2b9e78f.1583692184.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.git.1583692184.gitgitgadget@gmail.com>
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Mar 2020 18:29:42 +0000
Subject: [PATCH 1/3] t: add lib-crlf-messages.sh for messages containing CRLF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A following commit will fix a bug in the ref-filter API that causes
commit and tag messages containing CRLF to be incorrectly parsed and
displayed.

Add a test library (t/lib-crlf-messages.sh) that creates refs with such
commit messages, so that we can easily test that this bug does not
appear in other commands in the future.

The function test_crlf_subject_body_and_contents can be used to test
that the `--format` option of `branch`, `tag`, `for-each-ref` and
`log` correctly displays the subject, body and raw body of commits and
tag messages.

The commits are created using `commit-tree` such that the current branch
in the test repository is not affected when `test_create_crlf_refs` is
called in a test. This is to done so that the CRLF tests can be inserted
anywhere in a test script where it makes sense to do so, without having
to potentially modify further test that depend on output that would be
modified if the current branch gained new commits.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/lib-crlf-messages.sh | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 t/lib-crlf-messages.sh

diff --git a/t/lib-crlf-messages.sh b/t/lib-crlf-messages.sh
new file mode 100644
index 00000000000..64d2ad12019
--- /dev/null
+++ b/t/lib-crlf-messages.sh
@@ -0,0 +1,73 @@
+# Setup refs with commit and tag messages containing CRLF
+
+create_crlf_ref () {
+	message="$1" &&
+	subject="$2" &&
+	body="$3" &&
+	branch="$4" &&
+	printf "${message}" >.crlf-message-${branch}.txt &&
+	printf "${subject}" >.crlf-subject-${branch}.txt &&
+	printf "${body}" >.crlf-body-${branch}.txt &&
+    test_tick &&
+	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
+	git branch ${branch} ${hash} &&
+	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt --cleanup=verbatim
+}
+
+create_crlf_refs () {
+	message="Subject first line\r\n\r\nBody first line\r\nBody second line\r\n" &&
+	body="Body first line\r\nBody second line\r\n" &&
+	subject="Subject first line" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "crlf" &&
+	message="Subject first line\r\n\r\n\r\nBody first line\r\nBody second line\r\n" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "crlf-empty-lines-after-subject" &&
+	message="Subject first line\r\nSubject second line\r\n\r\nBody first line\r\nBody second line\r\n" &&
+	subject="Subject first line Subject second line" &&
+	create_crlf_ref "${message}" "${subject}" "${body}" "crlf-two-line-subject"
+}
+
+test_create_crlf_refs () {
+	test_expect_success 'setup refs with CRLF commit messages' '
+		create_crlf_refs
+	'
+}
+
+cleanup_crlf_refs () {
+	for branch in crlf crlf-empty-lines-after-subject crlf-two-line-subject; do
+		git branch -D ${branch} &&
+		git tag -d tag-${branch} &&
+		rm .crlf-message-${branch}.txt &&
+		rm .crlf-subject-${branch}.txt &&
+		rm .crlf-body-${branch}.txt
+	done
+}
+
+test_cleanup_crlf_refs () {
+	test_expect_success 'clenup refs with CRLF commit messages' '
+		cleanup_crlf_refs
+	'
+}
+
+test_crlf_subject_body_and_contents() {
+	command_and_args="$@" &&
+	command=$1 &&
+	if [ ${command} = "branch" ] || [ ${command} = "for-each-ref" ] || [ ${command} = "tag" ]; then
+		atoms="(contents:subject) (contents:body) (contents)"
+	elif [ ${command} = "log" ]; then
+		atoms="s b B"
+	fi &&
+	files="subject body message" &&
+	while  [ -n "${atoms}" ]; do
+		set ${atoms} && atom=$1 && shift && atoms="$*" &&
+		set ${files} &&	file=$1 && shift && files="$*" &&
+		test_expect_success "${command}: --format='%${atom}' works with CRLF input" "
+			rm -f expect &&
+			for ref in crlf crlf-empty-lines-after-subject crlf-two-line-subject; do
+				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
+				printf \"\n\" >>expect
+			done &&
+			git $command_and_args --format=\"%${atom}\" >actual &&
+			test_cmp expect actual
+		"
+	done
+}
-- 
gitgitgadget

