Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2779C1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeDMVTK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34354 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDMVTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:09 -0400
Received: by mail-io0-f196.google.com with SMTP id d6so11762077iog.1
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lL2imgibJSjiPnh1YQT/zrXWzz8WosrbZL6sJWGD0do=;
        b=tLindT95MEACRyjVIvfMzJb1dJ6NlEINHgtFX/daim7gZfUReG2saVTyo4C3MvZ/Je
         5hvrpZqj8xTIw3MaBZEKbsFEjW/O7R/KxS1N1Iq6zUT/qlieyEeIeoK8EcutTuzUrPsf
         J2nVeDNi0/yV+pmpa/Zi1ixb9ScXLYau3NqnTtFUSKHgsgfUsO4Y3AxifS308Q4o9Fdu
         IPDphnqt+L4Fxn6hdcvET0dcfutQINow2Aqc1tG6y9YolK9nSFb7NaupCApQVC1nIrzp
         EtfFzy802mbh4+zw7eK3u6L9f5geEBMtFm9SowkpEE/v3CVGneN8cYyVFZQXz2um6ym7
         B+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lL2imgibJSjiPnh1YQT/zrXWzz8WosrbZL6sJWGD0do=;
        b=g+rMWtXVF3EUVwwiZ9aL5ox3FcHmEFr93qgInU0MPghiDE5eg546nRtaKJjobD7+5d
         VAk99CStUaTVvDpC+JdybEbrC3PKSrxpQVc4Zuo/VvMZC5ipleZjCTMYutHq5wq2Eqyt
         88C0CIGsyRn1hvly4qQO8TC4we5zjy5EgLKrne8zm02mKmVYTp21vEaxYTzehHvGAeKy
         uCIeK0CeSG4KP9qxIX7vKPD9rxkeMe4muMBbL3FFbjC0EGoTbu8acTqtdaQ72D8ORn9U
         odYqmAHGX+W8emYM95CWNdmplvGfVPmSsDpTBfDS4GPx99xFiTqzU2egqPTIpFSPSRj3
         eBeA==
X-Gm-Message-State: ALQs6tDYQzWpeX6ZdVBAcy48RjUQELsSiWzBie6/J8qV48DLjI6buYg5
        4YeWSQ8MPYbe6zCSWbAYn/aVZ30kLNM=
X-Google-Smtp-Source: AIpwx4+7rfyplHU3smrWP17VIyb58YtS3ZOjHY3n5KjAaphmFEJhzEapr/fy+LzgGT/6HGumxsG9Zw==
X-Received: by 10.107.13.67 with SMTP id 64mr5861821ion.128.1523654348028;
        Fri, 13 Apr 2018 14:19:08 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:07 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 0/9] gpg-interface: Multiple signing tools
Date:   Fri, 13 Apr 2018 15:18:28 -0600
Message-Id: <20180413211837.99415-1-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated to incorporate feedback from v1. In addition to changes to the patches
from v1, I added the missing `t7004: fix mistaken tag name` patch, which had
caused some confusion (sorry about that). Thanks for everyone's feedback on v1.

### Interdiff (v1..v2):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7906123a59..691b309306 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1728,7 +1728,7 @@ grep.fallbackToNoIndex::
 	is executed outside of a git repository.  Defaults to false.

 signingtool.<name>.program::
-	The name of the program on `$PATH` to execute when making or
+	The name or path of the program to execute when making or
 	verifying a signature. This program will be used for making
 	signatures if `<name>` is configured as `signingtool.default`.
 	This program will be used for verifying signatures whose PEM
@@ -1750,7 +1750,9 @@ signingtool.<name>.pemtype::
 	SIGNATURE`. When verifying a signature with this PEM block type
 	the program specified in `signingtool.<name>.program` will be
 	used. By default `signingtool.gpg.pemtype` contains `PGP
-	SIGNATURE` and `PGP MESSAGE`.
+	SIGNATURE` and `PGP MESSAGE`. Multiple PEM types may be specified
+	for a single signing tool by including the `pemtype` directive
+	multiple times within the `signingtool` configuration.

 signingtool.default::
 	The `<name>` of the signing tool to use when creating
diff --git a/gpg-interface.c b/gpg-interface.c
index 0e2a82e8e5..5d4ae2a7ed 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -22,7 +22,8 @@ static struct signing_tool *alloc_signing_tool(void)
  * Our default tool config is too complicated to specify as a constant
  * initializer, so we lazily create it as needed.
  */
-static void init_signing_tool_defaults(void) {
+static void init_signing_tool_defaults(void)
+{
 	struct signing_tool *tool;

 	if (signing_tool_config)
@@ -38,7 +39,8 @@ static void init_signing_tool_defaults(void) {
 	signing_tool_config = tool;
 }

-static struct signing_tool *get_signing_tool(const char *name) {
+static struct signing_tool *get_signing_tool(const char *name)
+{
 	struct signing_tool *tool;

 	init_signing_tool_defaults();
@@ -216,11 +218,12 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	}

 	if (!strcmp(var, "gpg.program")) {
-		struct signing_tool *tool = get_or_create_signing_tool("gpg");
+		struct signing_tool *tool;

 		if (!value)
 			return config_error_nonbool(var);

+		tool = get_or_create_signing_tool("gpg");
 		free(tool->program);
 		tool->program = xstrdup(value);
 		return 0;
@@ -331,7 +334,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			/*
 			 * The caller didn't tell us which tool to use, and we
 			 * didn't recognize the format. Historically we've fed
-			 * these cases to blindly to gpg, so let's continue to
+			 * these cases blindly to gpg, so let's continue to
 			 * do so.
 			 */
 			tool = get_signing_tool("gpg");
diff --git a/gpg-interface.h b/gpg-interface.h
index cee0dfe401..8e22e67b6f 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -42,7 +42,7 @@ void signature_check_clear(struct signature_check *sigc);
  * pointed at the signing_tool that corresponds to the found
  * signature type.
  */
-size_t parse_signature(const char *buf, unsigned long size,
+size_t parse_signature(const char *buf, size_t size,
 		       const struct signing_tool **out_tool);

 void parse_gpg_output(struct signature_check *);
@@ -61,7 +61,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
  * gpg_output, when set, receives the diagnostic output from GPG.
  * gpg_status, when set, receives the status output from GPG.
  *
- * Typically the "tool" argument should come from a previous call to
+ * Typically, the "tool" argument should come from a previous call to
  * parse_signature(). If it's NULL, then verify_signed_buffer() will
  * try to choose the appropriate tool based on the contents of the
  * "signature" buffer.
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 08d23b0cf5..b9ba47057f 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -59,20 +59,24 @@ sanitize_pgp() {

 create_fake_signer () {
 	write_script fake-signer <<-\EOF
-	if [ "$1 $2" = "--status-fd=2 -bsau" ]; then
+	if test "$1 $2" = "--status-fd=2 -bsau"
+	then
 		echo >&2 "[GNUPG:] BEGIN_SIGNING"
 		echo >&2 "[GNUPG:] SIG_CREATED D 1 SHA256 0 1513792449 4A7FF9E2330D22B19213A4E9E9C423BE17EFEE70"
-		# avoid "-" in echo arguments
-		printf "%s\n" \
-		  "-----BEGIN FAKE SIGNER SIGNATURE-----" \
-		  "fake-signature" \
-		  "-----END FAKE SIGNER SIGNATURE-----"
+		cat <<-\END
+		-----BEGIN FAKE SIGNER SIGNATURE-----
+		fake-signature
+		-----END FAKE SIGNER SIGNATURE-----
+		END
 		exit 0

-	elif [ "$1 $2 $3" = "--status-fd=1 --keyid-format=long --verify" ]; then
-		echo "[GNUPG:] NEWSIG"
-		echo "[GNUPG:] GOODSIG 4A7FF9E2330D22B19213A4E9E9C423BE17EFEE70 /CN=Some User/EMail=some@user.email"
-		echo "[GNUPG:] TRUST_FULLY 0 shell"
+	elif test "$1 $2 $3" = "--status-fd=1 --keyid-format=long --verify"
+	then
+		cat <<-\END
+		[GNUPG:] NEWSIG
+		[GNUPG:] GOODSIG 4A7FF9E2330D22B19213A4E9E9C423BE17EFEE70 /CN=Some User/EMail=some@user.email
+		[GNUPG:] TRUST_FULLY 0 shell
+		END
 		echo >&2 "Good signature from /CN=Some User/EMail=some@user.email"
 		exit 0

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 848a823302..fb41f98ca6 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -65,13 +65,15 @@ test_expect_success GPG 'create signed commits' '
 	grep "PGP SIGNATURE" actual &&

 	git config gpg.program "$TRASH_DIRECTORY/fake-signer" &&
-	echo 12 >file && test_tick && git commit -a -m twelfth && test_unconfig gpg.program &&
+	echo 12 >file && test_tick && git commit -a -m twelfth &&
+	test_unconfig gpg.program &&
 	git tag twelfth-fake-signed &&
 	git cat-file -p twelfth-fake-signed >actual &&
 	grep "FAKE SIGNER SIGNATURE" actual &&

 	git config signingtool.default fake &&
-	echo 13 >file && test_tick && git commit -a -m thirteenth && test_unconfig signingtool.default &&
+	echo 13 >file && test_tick && git commit -a -m thirteenth &&
+	test_unconfig signingtool.default &&
 	git tag thirteenth-fake-signed &&
 	git cat-file -p thirteenth-fake-signed >actual &&
 	grep "FAKE SIGNER SIGNATURE" actual

### Patches

Ben Toews (1):
  gpg-interface: handle alternative signature types

Jeff King (8):
  t7004: fix mistaken tag name
  gpg-interface: handle bool user.signingkey
  gpg-interface: modernize function declarations
  gpg-interface: use size_t for signature buffer size
  gpg-interface: fix const-correctness of "eol" pointer
  gpg-interface: extract gpg line matching helper
  gpg-interface: find the last gpg signature line
  gpg-interface: prepare for parsing arbitrary PEM blocks

 Documentation/config.txt |  42 +++++++---
 builtin/fmt-merge-msg.c  |   6 +-
 builtin/receive-pack.c   |   7 +-
 builtin/tag.c            |   2 +-
 commit.c                 |   2 +-
 gpg-interface.c          | 201 +++++++++++++++++++++++++++++++++++++++--------
 gpg-interface.h          |  67 +++++++++++++---
 log-tree.c               |   7 +-
 ref-filter.c             |   2 +-
 t/lib-gpg.sh             |  30 +++++++
 t/t7004-tag.sh           |  13 ++-
 t/t7510-signed-commit.sh |  34 +++++++-
 tag.c                    |   2 +-
 13 files changed, 348 insertions(+), 67 deletions(-)

--
2.15.1 (Apple Git-101)
