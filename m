Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B4C54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A7720788
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAcES8Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCYFl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:41:27 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38928 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCYFl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:41:27 -0400
Received: by mail-wr1-f48.google.com with SMTP id p10so1345733wrt.6
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zr7j7KDO6DqFDe33EpDYB1oLRw9+sRniw+RwvncNmuU=;
        b=MAcES8KulSutiAIVkGX6fYMIYpltaw20tvlJ4RjNzeQkf/W9gs4txHpWWcQmMOttxx
         C+Ui6h0fnZk+JiZndYlCMlkJc47B3G/2CyqzS2IyrUlPtZAOdAX3w+knf9STqbgJI5PL
         dFgh9LsUgfLTStqwb7GTNh5aj+LufMiQMX5Clw71tgR/rWXxmruzfNhTnZp3EDHWpe9d
         KAOs1BP4b/BSO34gBpVbGpVgnwb+okOSxeIw/8PWbXZ2JPaDTYakkP0Ac+Lzlq1nfN5y
         c3/kh/AsiXbeDF+dHfWbPhCcysIn4pc5o/RvyCNpsqxEaIBm5n15YnCADQt+k1pBNasp
         pLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zr7j7KDO6DqFDe33EpDYB1oLRw9+sRniw+RwvncNmuU=;
        b=hVxrdenRrvBt660SQ+XF0/ZqZKJ6nZk+9PTttfBTPlkq9hP7wZ2rUnL4MZ+B3p320X
         BcQ/k+xSgllaAD/8/s0JBJzhCkgNM4pvaiRzrRKOxCp2K155IlInWOnLsXE/dJgS4R3W
         hivtAUQoJ/xUzaGVGbNg3dpA7kygRfxBwBDt9VOjC1PB8ZB9q5Y7poUvSdiXUHFewimM
         a7FrzN9V134pApBMha9WU0Njs1muimQJNT9VSsM5QTI0qF4+ki4Gp2pXLSki+Z7zOkGj
         SjjeBP33JDzEDLI1xgBO3zn/OsYzbfo6Lfc3QSm6Qm68uxq4nXk0Fmxi3IwAmV0ASYdR
         cfAA==
X-Gm-Message-State: ANhLgQ0noVd7SmhtTBaJrJeOaPsRoCAqL3akCs/xZS1yysg263gNYDAu
        Mr+STDf0It1fwiqpYlyBDgKKn8o0
X-Google-Smtp-Source: ADFU+vvIDM74x7VdFNSgMNiaT/ljIrW0Vw+kXG60XJtKPsUttd+WHS311BPz3u1feduq/yQaKwzAdw==
X-Received: by 2002:adf:e948:: with SMTP id m8mr1393416wrn.193.1585114884690;
        Tue, 24 Mar 2020 22:41:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm7801437wml.18.2020.03.24.22.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:41:24 -0700 (PDT)
Message-Id: <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 05:41:19 +0000
Subject: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The code to set those prereqs is executed completely outside of any
`test_eval_` block. As a consequence, its output had to be suppressed so
that it does not clutter the output of a regular test script run.

Unfortunately, the output *stays* suppressed even when the `--verbose`
option is in effect.

This hid important output when debugging why the GPG prereq was not
enabled in the Windows part of our CI builds.

In preparation for fixing that, let's move all of this code into lazy
prereqs.

The only slightly tricky part is the global environment variable
`GNUPGHOME`. Originally, it was configured only when we verified that
there is a `gpg` in the `PATH` that we can use. This is now no longer
possible, as lazy prereqs are evaluated in a subshell that changes the
working directory to a temporary one. Therefore, we simply _always_ set
that environment variable: it does not hurt anything because it does not
indicate the presence of a working GPG.

Side note: it was quite tempting to use a hack that is possible because
we do not validate what is passed to `test_lazy_prereq` (and it is
therefore possible to "break out" of the lazy_prereq subshell:

	test_lazy_prereq GPG '...) && GNUPGHOME=... && (...'

However, this is rather tricksy hobbitses code, and the current patch is
_much_ easier to understand.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 102 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 4ead1268351..7a78c562e8d 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -1,12 +1,25 @@
-gpg_version=$(gpg --version 2>&1)
-if test $? != 127
-then
+# We always set GNUPGHOME, even if no usable GPG was found, as
+#
+# - It does not hurt, and
+#
+# - we cannot set global environment variables in lazy prereqs because they are
+#   executed in an eval'ed subshell that changes the working directory to a
+#   temporary one.
+
+GNUPGHOME="$PWD/gpghome"
+export GNUPGHOME
+
+test_lazy_prereq GPG '
+	gpg_version=$(gpg --version 2>&1)
+	test $? != 127 || exit 1
+
 	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
-	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
+	# the gpg version 1.0.6 did not parse trust packets correctly, so for
 	# that version, creation of signed tags using the generated key fails.
 	case "$gpg_version" in
-	'gpg (GnuPG) 1.0.6'*)
+	"gpg (GnuPG) 1.0.6"*)
 		say "Your version of gpg (1.0.6) is too buggy for testing"
+		exit 1
 		;;
 	*)
 		# Available key info:
@@ -25,55 +38,54 @@ then
 		# To export ownertrust:
 		#	gpg --homedir /tmp/gpghome --export-ownertrust \
 		#		> lib-gpg/ownertrust
-		mkdir ./gpghome &&
-		chmod 0700 ./gpghome &&
-		GNUPGHOME="$PWD/gpghome" &&
-		export GNUPGHOME &&
+		mkdir "$GNUPGHOME" &&
+		chmod 0700 "$GNUPGHOME" &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
 		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
-			--sign -u committer@example.com &&
-		test_set_prereq GPG &&
-		# Available key info:
-		# * see t/lib-gpg/gpgsm-gen-key.in
-		# To generate new certificate:
-		#  * no passphrase
-		#	gpgsm --homedir /tmp/gpghome/ \
-		#		-o /tmp/gpgsm.crt.user \
-		#		--generate-key \
-		#		--batch t/lib-gpg/gpgsm-gen-key.in
-		# To import certificate:
-		#	gpgsm --homedir /tmp/gpghome/ \
-		#		--import /tmp/gpgsm.crt.user
-		# To export into a .p12 we can later import:
-		#	gpgsm --homedir /tmp/gpghome/ \
-		#		-o t/lib-gpg/gpgsm_cert.p12 \
-		#		--export-secret-key-p12 "committer@example.com"
-		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
-			--passphrase-fd 0 --pinentry-mode loopback \
-			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
-
-		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
-		grep fingerprint: |
-		cut -d" " -f4 |
-		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
-
-		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
-		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
-			-u committer@example.com -o /dev/null --sign - 2>&1 &&
-		test_set_prereq GPGSM
+			--sign -u committer@example.com
 		;;
 	esac
-fi
+'
+
+test_lazy_prereq GPGSM '
+	test_have_prereq GPG &&
+	# Available key info:
+	# * see t/lib-gpg/gpgsm-gen-key.in
+	# To generate new certificate:
+	#  * no passphrase
+	#	gpgsm --homedir /tmp/gpghome/ \
+	#		-o /tmp/gpgsm.crt.user \
+	#		--generate-key \
+	#		--batch t/lib-gpg/gpgsm-gen-key.in
+	# To import certificate:
+	#	gpgsm --homedir /tmp/gpghome/ \
+	#		--import /tmp/gpgsm.crt.user
+	# To export into a .p12 we can later import:
+	#	gpgsm --homedir /tmp/gpghome/ \
+	#		-o t/lib-gpg/gpgsm_cert.p12 \
+	#		--export-secret-key-p12 "committer@example.com"
+       echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
+	       --passphrase-fd 0 --pinentry-mode loopback \
+	       --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
+
+       gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
+       grep fingerprint: |
+       cut -d" " -f4 |
+	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
+
+       echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
+       echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
+	       -u committer@example.com -o /dev/null --sign - 2>&1
+'
 
-if test_have_prereq GPG &&
-    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
-then
-	test_set_prereq RFC1991
-fi
+test_lazy_prereq RFC1991 '
+	test_have_prereq GPG &&
+	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
+'
 
 sanitize_pgp() {
 	perl -ne '
-- 
gitgitgadget

