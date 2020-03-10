Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD4C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3106120637
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdsXyrBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCJCY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:24:59 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37875 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgCJCY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 22:24:58 -0400
Received: by mail-wm1-f51.google.com with SMTP id a141so317844wme.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 19:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ol3DQ+KSmcnUwbt0YpAil/3FYpjvsPQWJam877y+Ko=;
        b=KdsXyrBneLFrc2K2ro3mmwBwsRj2O7SR/yHiUayhB2KQuy39wkJPNn9cSO4f65JLE5
         btaeH4/mx5foMhPqAkVtTG3nLLETdRLv+DZPyvpF1TSPiF/9bMkJZv4K6P7RNbF0Brqe
         7EbWx2Evtnln4ZFRMbUVY+7r1wp9RUyctKtoL/v86IqxkA6MSl2c9zEfPRomtXXj3ypA
         Lk9aWzH33Y+D1I9sWw9r6lNw3F2SqvN04AAaIdF2oAzsjoK3SVDlxb+tkXtM5ER0Q6ZA
         AEIMZg2lL+841v+Y5eu8OAmmiPKv5YexiAwXUfS45Vj4oajJAIdpTeLaVqHnu7FKVcHm
         o+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ol3DQ+KSmcnUwbt0YpAil/3FYpjvsPQWJam877y+Ko=;
        b=qKrfsT+xZYSFxOqTnkugZWY936KtkLToT/+MunSDlQETcj4EI17iaRqviN+4T5+cqH
         vvdza+/0zSHm9pL7uOhboKljpTV33gbsu95evchdAnaN9O/JlazQSxDUhL+FBoi6oNut
         jrELIROV+q9odiHElzWghl/TXyGcwIkWsXbODzwGgzY0YbiAlnvaAzuJVnDWDrU1Bfak
         9vLGQmNUW5gspVvQJCHFozS+E3PZ3ng9+Nc3kXavtc0nz18shUZizuVplCigS5+WK7O6
         bgHsrSUqe6GxzZsH4OVn32EJASrHKW9vL8dUR5/wDbu37NX0g7pu+XiQ/CLM8wWUFeSP
         Prrw==
X-Gm-Message-State: ANhLgQ3i/rFPsbaxOApY/ahogdzUY0ebkwyrw6U16iQVpRfArWXgkj+8
        8MjHnHI2kRQteAb/DzLxaJZfLryF
X-Google-Smtp-Source: ADFU+vsAXLKVNHvORJfnUydoH2lQjtmgk8ZI3WPcRWcRh8ddCVpXmWr0rett2gCWpmt0eiLwlvFKOg==
X-Received: by 2002:a05:600c:2947:: with SMTP id n7mr2234416wmd.139.1583807095271;
        Mon, 09 Mar 2020 19:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm5382070wrx.80.2020.03.09.19.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 19:24:54 -0700 (PDT)
Message-Id: <b25211380355f7f95113b42734df0bb8b2b9e78f.1583807093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
        <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 02:24:51 +0000
Subject: [PATCH v2 1/3] t: add lib-crlf-messages.sh for messages containing
 CRLF
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

