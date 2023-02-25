Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33735C64ED8
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 01:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBYBdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 20:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYBdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 20:33:21 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BF8E7ED2
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 17:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=i0/XJ
        YBzKiKDx4bOmiBMok6SsXlYKseEPKlY57+b7CQ=; b=MTRYCfiGeaFQLKMR8xcTo
        VTUBoWD/bAjUouOjrqo2I/Jx0o74r+bPgx8YzBFKY9KVDHfbtBa2QXdeSYyKLgU4
        nD+MBZtu93JfH0ERAzDghH05mfZ5RGymcw8xu50cj7wBpcXm8/5tkdxCduP65guT
        DMbBwRyLzzMasg91yroe1g=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wBHlSpCZfljO5dXBA--.24343S4;
        Sat, 25 Feb 2023 09:32:52 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     v.garg.work@gmail.com, gitster@pobox.com, philipoakley@iee.email,
        Zhang Yi <18994118902@163.com>
Subject: [GSOC] [PATCH v3 1/1] t9700: modernize test scripts
Date:   Sat, 25 Feb 2023 09:30:03 +0800
Message-Id: <20230225013003.1971931-1-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
In-Reply-To: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
References: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHlSpCZfljO5dXBA--.24343S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW3Ar1rKFWrJr4rXw43ZFb_yoW5Zw1DpF
        WYkr1ayr1qqF13JwsxuFWxCrW7Jan5Cr98XrZxCw1fCrnYkryxKF13Kr17ZFyUXrnIva1a
        ya4vkr15Ww43W3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRKg4-UUUUU=
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiGAgh-lv2k8y88wAAsy
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style of t9700-perl-git.sh is old. There are 3 problems:
* A title is not on the same line with test_expect_success command.
* A test body is indented by whitespaces.
* There are whitespaces after redirect operators.

Modernize test scripts by:
* Combine the title with test_expect_success command.
* Replace whitespace indents with TAB.
* Delete whitespaces after redirect operators.

Signed-off-by: Zhang Yi <18994118902@163.com>
---
Update compare to v2:
* Add summary between versions.
* Add space after colon in patch title.
* Add space after full stops and after comma.
* Combine 3 patches into 1.

After review 'First steps contributing to Git', I find it available to
send a single update patch for new version. I think this way is eaiser to
review. 

Thanks for help from Junio C Hamano, Philip Oaklcy and again for Vivan
Garg. 

 t/t9700-perl-git.sh | 61 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)


diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b105d6d9d5..ccc8212d73 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -13,37 +13,36 @@ skip_all_if_no_Test_More
 
 # set up test repository
 
-test_expect_success \
-    'set up test repository' \
-    'echo "test file 1" > file1 &&
-     echo "test file 2" > file2 &&
-     mkdir directory1 &&
-     echo "in directory1" >> directory1/file &&
-     mkdir directory2 &&
-     echo "in directory2" >> directory2/file &&
-     git add . &&
-     git commit -m "first commit" &&
-
-     echo "new file in subdir 2" > directory2/file2 &&
-     git add . &&
-     git commit -m "commit in directory2" &&
-
-     echo "changed file 1" > file1 &&
-     git commit -a -m "second commit" &&
-
-     git config --add color.test.slot1 green &&
-     git config --add test.string value &&
-     git config --add test.dupstring value1 &&
-     git config --add test.dupstring value2 &&
-     git config --add test.booltrue true &&
-     git config --add test.boolfalse no &&
-     git config --add test.boolother other &&
-     git config --add test.int 2k &&
-     git config --add test.path "~/foo" &&
-     git config --add test.pathexpanded "$HOME/foo" &&
-     git config --add test.pathmulti foo &&
-     git config --add test.pathmulti bar
-     '
+test_expect_success 'set up test repository' '
+	echo "test file 1" >file1 &&
+	echo "test file 2" >file2 &&
+	mkdir directory1 &&
+	echo "in directory1" >>directory1/file &&
+	mkdir directory2 &&
+	echo "in directory2" >>directory2/file &&
+	git add . &&
+	git commit -m "first commit" &&
+
+	echo "new file in subdir 2" >directory2/file2 &&
+	git add . &&
+	git commit -m "commit in directory2" &&
+
+	echo "changed file 1" >file1 &&
+	git commit -a -m "second commit" &&
+
+	git config --add color.test.slot1 green &&
+	git config --add test.string value &&
+	git config --add test.dupstring value1 &&
+	git config --add test.dupstring value2 &&
+	git config --add test.booltrue true &&
+	git config --add test.boolfalse no &&
+	git config --add test.boolother other &&
+	git config --add test.int 2k &&
+	git config --add test.path "~/foo" &&
+	git config --add test.pathexpanded "$HOME/foo" &&
+	git config --add test.pathmulti foo &&
+	git config --add test.pathmulti bar
+'
 
 test_expect_success 'set up bare repository' '
 	git init --bare bare.git
-- 
2.29.0-rc0

