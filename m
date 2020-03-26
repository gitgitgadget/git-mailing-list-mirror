Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4AC2D0E8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A0120714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gee173Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgCZPfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:35:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39664 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgCZPfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:35:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id a43so7314121edf.6
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zr7j7KDO6DqFDe33EpDYB1oLRw9+sRniw+RwvncNmuU=;
        b=Gee173Gg0WCsgMdc8hgkKHMw6IzIfoAbtEdjXfNIZ1ZN/4rx5f9OfaCz2zxCtNj37a
         yYnzupdmqAzIszniUOOpPvFkmPR0tjC48a8HcrRMUlLFuKenLITA0P1hUV0jLD8ZZ5Jc
         leInSteB4eJafKz22/4icxCVZi5RCbPd25gxC2o9ry0/dk73Eql1pLnTrbb28DxYQH9f
         mGIZg+7cm6ubQ30N3QFiYYGtkmGJgncfQkdZ78SdBerse/2molopGK3lEyhXDjzsJfVI
         nrwubg/HTryhI/W4a8Gj1uZewdp4/jhcG1xvkVyliOQwrol99tjGtJ7qSexnBaXewrvQ
         bBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zr7j7KDO6DqFDe33EpDYB1oLRw9+sRniw+RwvncNmuU=;
        b=NT5joBxMNg93D+LWdOVX3uC54f3OdQa9fJiQC21G83OYb9RlkR1BpldpqABjMiClwz
         PbCxsIFlecKwzumrT7wXZVMq8WKPCpckZjdgLdrvc0RUuK5yfDAruM5eubtJgLk32ItJ
         wRKIJA6JI07BoZU3nwANKX1Q5Go4kFmGLxNKBZQOxQVZD3LbxqnUGvfZ6IBa7cPkogYz
         L3V6EmEY1/urvrrghZtrMu0xXjMREUpx/D3eH/OksCGMFaedHFUMKI+dNbcHaWSqorzs
         TPpJSZ3PjRekTWf5Oyt8ANSbCiuFHPLSjgd14SgxlTt5UvaRvfBhYyG9Xwa2jHDqpuQ2
         vexw==
X-Gm-Message-State: ANhLgQ34jYF/gz1gosPJ9AfOdBTucg0AuCeERuhoVFezoO6GOxVTBE1Y
        4GQIFNy1l/028S+O+BNMIKfhEQCr
X-Google-Smtp-Source: ADFU+vvnd5v9hu06sn5lCZhe1PMuxEvzyipDsHO99tiZXLvF80iC2EnVIw7Nw41O3ynGBW1xgsk6Ww==
X-Received: by 2002:a05:6402:1345:: with SMTP id y5mr8263737edw.196.1585236933284;
        Thu, 26 Mar 2020 08:35:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs8sm325172ejb.92.2020.03.26.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:35:32 -0700 (PDT)
Message-Id: <f69f97e24ba8fc931e7c86931756e1a176348f3c.1585236929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 15:35:27 +0000
Subject: [PATCH v3 4/5] tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
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

