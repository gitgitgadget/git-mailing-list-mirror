From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 0/7] t5520: tests for --[no-]autostash option
Date: Sat,  2 Apr 2016 23:28:25 +0530
Message-ID: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 19:59:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPpd-00083u-6D
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 19:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbcDBR73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 13:59:29 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33873 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcDBR72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 13:59:28 -0400
Received: by mail-pa0-f66.google.com with SMTP id hb4so973475pac.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=U5gZo+JdG7OsEqdcfqHLS3bIt6eQLnXIeYGEoeAd6fs=;
        b=ZtTdl9qa3/Gan8Pnn+22hR3cv6mNgYPCckvPYHbi/vnT3TLspT2loBjgYjdpWrvtnQ
         EbTOv0jK0JEaA+AQ93+DfBoFi/FYktk9+I0//B+Dg4XSG9IgYktdIiBJ/lrCBNjE0IMo
         jLJzGU9w9iB5nFJeYS8mIc6l+7ntmuFk4gasl9waDUJAOJmPOVxkFrzu//ek0fYR4KEy
         qTLVUFur605jODTXjHnkiwlnmgJnGJszOn8hPwPIc5HjxOek6fkxwy8ADdez5aYaRAhJ
         RKC8di749JvByAUwgjg5ooeRJgaUQ+PDImSKzrfXvU9aQm/KEeySCP5PBsSZ5wq7sihC
         wQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U5gZo+JdG7OsEqdcfqHLS3bIt6eQLnXIeYGEoeAd6fs=;
        b=CczmjYgWrfTsk+hp2VYAlRUWiZM0wPPrOvYY8OMYCn4yYidPFG8g/+aTKVNpWsEblL
         xvjyY2RO1huwwjYRpNl3kmuDeITYSOvg6BC4Kuz49h0CgvPfJHwQ1sH4eD06BgETSpWV
         Bt4bAcebTkB0HL/oXZfxBJ01BynL1jaREdLAqr+SD66zI/UH04IvVL+6CoDXSgB78r+U
         GLTI+Un6OMk79ppGq11YQDK+x1ao+2hnX0f8OwEbnbC3A9MIYIq3HXwYrwnHWtP+XwzR
         gWqwt7zL2edwtWRNw4jSISPRWD/UypwzvSW3702Rm1jvwDdFR28u8R93YXGIc9nqfSfn
         +d/Q==
X-Gm-Message-State: AD7BkJKrvNKsxcWPFojCpg6FFXEpkshxU1DrRVsaGPBnPH5ne3IOOEQeUNAgoNbMAozu4g==
X-Received: by 10.66.228.167 with SMTP id sj7mr11416113pac.101.1459619968047;
        Sat, 02 Apr 2016 10:59:28 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.10.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 10:59:27 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290596>

The following series is applicable on mj/pull-rebase-autostash.

Thanks Eric and Junio for there comments on previous version[1]

Changes made vs v1:
        * [Patch v1 4/5] is broken into three patches to increase
		  readability of the patches.

		* [Patch 4/5] Factor out code in two functions 
		  test_pull_autostash() and test_pull_autostash_fail()
		  instead of test_rebase_autostash() and 
		  test_rebase_no_autostash(). This leads to further 
		  simplification of code.
		  
		  Also removed two for-loops as they didn't provided
		  the simplicity intended for.
		  
		  For-loop was over-intended. Corrected it.

		* Commit message for patches 1/5, 2/5, 3/5 are improved
		  as suggested by Eric in the previous round.

Here's interdiff with v1:

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 4da9e52..bed75f5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -9,22 +9,22 @@ modify () {
 	mv "$2.x" "$2"
 }
 
-test_rebase_autostash () {
+test_pull_autostash () {
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
-	git pull --rebase --autostash . copy &&
+	git pull $@ . copy &&
 	test_cmp_rev HEAD^ copy &&
 	test "$(cat new_file)" = dirty &&
 	test "$(cat file)" = "modified again"
 }
 
-test_rebase_no_autostash () {
+test_pull_autostash_fail () {
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
-	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+	test_must_fail git pull $@ . copy 2>err &&
+	test_i18ngrep "uncommitted changes." err
 }
 
 test_expect_success setup '
@@ -265,48 +265,46 @@ test_expect_success '--rebase fails with multiple branches' '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --rebase . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	test_pull_autostash --rebase
+'
+
+test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
+	test_config rebase.autostash true &&
+	test_pull_autostash --rebase --autostash
 '
 
-for i in true false
-	do
-		test_expect_success "pull --rebase --autostash & rebase.autostash=$i" '
-			test_config rebase.autostash $i &&
-			test_rebase_autostash
-		'
-	done
+test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
+	test_config rebase.autostash false &&
+	test_pull_autostash --rebase --autostash
+'
 
-test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
+test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	test_rebase_autostash
+	test_pull_autostash --rebase --autostash
+'
+
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
+	test_config rebase.autostash true &&
+	test_pull_autostash_fail --rebase --no-autostash
 '
 
-for i in true false
-	do
-		test_expect_success "pull --rebase --no-autostash & rebase.autostash=$i" '
-			test_config rebase.autostash $i &&
-			test_rebase_no_autostash
-		'
-	done
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
+	test_config rebase.autostash false &&
+	test_pull_autostash_fail --rebase --no-autostash
+'
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	test_rebase_no_autostash
+	test_pull_autostash_fail --rebase --no-autostash
 '
 
 for i in --autostash --no-autostash
-	do
-		test_expect_success "pull $i (without --rebase) is illegal" '
-			test_must_fail git pull $i . copy 2>actual &&
-			test_i18ngrep "only valid with --rebase" actual
-		'
-	done
+do
+	test_expect_success "pull $i (without --rebase) is illegal" '
+		test_must_fail git pull $i . copy 2>err &&
+		test_i18ngrep "only valid with --rebase" err
+	'
+done
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
@@ -318,22 +316,12 @@ test_expect_success 'pull.rebase' '
 
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	git pull --autostash . copy &&
-	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	test_pull_autostash --autostash
 '
 
 test_expect_success 'pull --no-autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	test_must_fail git pull --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+	test_pull_autostash_fail --no-autostash
 '
 
 test_expect_success 'branch.to-rebase.rebase' '


Mehul Jain (7):
  t5520: use consistent capitalization in test titles
  t5520: ensure consistent test conditions
  t5520: use better test to check stderr output
  t5520: factor out common code
  t5520: factor out common code
  t5520: reduce commom lines of code
  t5520: test --[no-]autostash with pull.rebase=true

 t/t5520-pull.sh | 102 +++++++++++++++++++++++++-------------------------------
 1 file changed, 46 insertions(+), 56 deletions(-)

-- 
2.7.1.340.g69eb491.dirty

[1]:http://thread.gmane.org/gmane.comp.version-control.git/290134

Thanks,
Mehul
