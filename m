Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF89C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiGMNVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiGMNU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:20:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E0E0B
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h17so15540083wrx.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B9fNCB2RoTaMPJdRqrzJPfckuHXVf+rolwUdV11kQGQ=;
        b=ldd8dHYBGrvnw3CdnnmAMujAoLm+z6tpE9qByQpuBUX8IUBbABuBytzUGVtmnOTDAv
         j9dhlPU1m9p3mbreaBkir4scvtSqISiUR6Klfxdf1VOpihBICYrvXNMmaLdhCiTsVmzp
         m/BGmSPLlMwW1I8aZM7ElzrZx9FpGNdF/jofW/+hF9h141lwbG+1aYp1YSKInCOWgJI0
         uGe6LLnVaaf/FKChYr/HHndNQMVsoyl+3mWiIXtRi+tsDl3qnf4kZLB81wQoB0Baln33
         iCxAYHbqQjTA1lK5UfTQLjaMVecHfcVwQUXV3BsO4cemxR6UAgM7m2jFJSKaCdG43aCx
         gwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B9fNCB2RoTaMPJdRqrzJPfckuHXVf+rolwUdV11kQGQ=;
        b=053DJ9wSWfTkcuax0/bcVXFXOUT5GqENyHUIWjJG5K8+c0DCnwxRYTxq5pQFwf+wmo
         /VKw0SH5lpSmnXnNifYPtrGFQOxCc+Ix14JuXG+NIxvj5tWW0lJtFaBwfPzswrDOk75E
         M1+oRa7/k1jpsdFHOCTTrxaTgv5lzBQ1JapQOawNVfkdsQiTG46gysmgRb7MNfuALIIq
         4d50kPhvvk9i2VBFWR3j7z7pB/a8afSyxKV4w9ml1AmKXSCqTsGhOHvbIzZbp2BOq17u
         4D9pJDN9mRkzieGr6rYlNDwghhStklzDf+arMCF7g0PEQVPRY+gZwmxQyoqplGcACly5
         DNew==
X-Gm-Message-State: AJIora+9NE5cNmkOAYlVKWr8uExk6GfU620fhDNsbd1tRzLQv/iyy0Wj
        xg6IBw/hH+GEymrsjUMWTlmM/7RUAVQ=
X-Google-Smtp-Source: AGRyM1uI8s66eCSNahKyyDcJS5igozoc/xJNUAmMARipa7MjQf8Fr/dErMJoHxqBMlm08EVh7enOAQ==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr3222971wri.679.1657718455854;
        Wed, 13 Jul 2022 06:20:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003a2f2bb72d5sm739201wmc.45.2022.07.13.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:20:55 -0700 (PDT)
Message-Id: <8aaceedb7a8f9d95550ef4a2d147c837ede6acec.1657718450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 13:20:50 +0000
Subject: [PATCH 3/3] *: use allowlist and denylist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Using "allowlist" and "denylist" is a more precise definition of the
functionality they provide. The previous color-based words assume
cultural interpretation to provide the meaning.

These changes to the Git codebase are mostly cosmetic. Several comments
are updated. The renamed protocol_allowlist() method is local to
transport.c so does not update any header file API definition. There are
some untranslated error messages that are reworded, so this _might_
affect error parsers. However, two of the three error messages are
around option parsing, so they are "fast failures". The one perhaps
meaningful change is the logerror() in daemon.c.

After this change, the only remaining uses of the previous words are
in release notes for older versions of Git.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 daemon.c           |  8 ++++----
 git-cvsserver.perl |  2 +-
 sha1dc/sha1.c      | 12 ++++++------
 transport.c        |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/daemon.c b/daemon.c
index 58f1077885c..ed7c53b1110 100644
--- a/daemon.c
+++ b/daemon.c
@@ -279,7 +279,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		/* The validation is done on the paths after enter_repo
 		 * appends optional {.git,.git/.git} and friends, but
 		 * it does not use getcwd().  So if your /pub is
-		 * a symlink to /mnt/pub, you can whitelist /pub and
+		 * a symlink to /mnt/pub, you can allowlist /pub and
 		 * do not have to say /mnt/pub.
 		 * Do not say /pub/.
 		 */
@@ -298,7 +298,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			return path;
 	}
 
-	logerror("'%s': not in whitelist", path);
+	logerror("'%s': not in allowlist", path);
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
@@ -403,7 +403,7 @@ static int run_service(const char *dir, struct daemon_service *service,
 	 * a "git-daemon-export-ok" flag that says that the other side
 	 * is ok with us doing this.
 	 *
-	 * path_ok() uses enter_repo() and does whitelist checking.
+	 * path_ok() uses enter_repo() and does allowlist checking.
 	 * We only need to make sure the repository is exported.
 	 */
 
@@ -1444,7 +1444,7 @@ int cmd_main(int argc, const char **argv)
 		cred = prepare_credentials(user_name, group_name);
 
 	if (strict_paths && (!ok_paths || !*ok_paths))
-		die("option --strict-paths requires a whitelist");
+		die("option --strict-paths requires a allowlist");
 
 	if (base_path && !is_directory(base_path))
 		die("base-path '%s' does not exist or is not a directory",
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4c8118010a8..7d13b0a5ac1 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -152,7 +152,7 @@ $state->{allowed_roots} = [ @ARGV ];
 
 # don't export the whole system unless the users requests it
 if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
-    die "--export-all can only be used together with an explicit whitelist\n";
+    die "--export-all can only be used together with an explicit allowlist\n";
 }
 
 # Environment handling for running under git-shell
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index dede2cbddf9..b4a5f23c1ec 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -86,30 +86,30 @@
        defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
        defined(__sparc))
 /*
- * Should define Big Endian for a whitelist of known processors. See
+ * Should define Big Endian for a allowlist of known processors. See
  * https://sourceforge.net/p/predef/wiki/Endianness/ and
  * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
  */
 #define SHA1DC_BIGENDIAN
 
-/* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
+/* Not under GCC-alike or glibc or *BSD or newlib or <processor allowlist> */
 #elif (defined(_AIX) || defined(__hpux))
 
 /*
- * Defines Big Endian on a whitelist of OSs that are known to be Big
+ * Defines Big Endian on a allowlist of OSs that are known to be Big
  * Endian-only. See
  * https://lore.kernel.org/git/93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl/
  */
 #define SHA1DC_BIGENDIAN
 
-/* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> */
+/* Not under GCC-alike or glibc or *BSD or newlib or <processor allowlist> or <os allowlist> */
 #elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
 /*
  * As a last resort before we do anything else we're not 100% sure
- * about below, we blacklist specific processors here. We could add
+ * about below, we denylist specific processors here. We could add
  * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
  */
-#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> or <processor blacklist> */
+#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor allowlist> or <os allowlist> or <processor denylist> */
 
 /* We do nothing more here for now */
 /*#error "Uncomment this to see if you fall through all the detection"*/
diff --git a/transport.c b/transport.c
index 52db7a3cb09..321bbe382cc 100644
--- a/transport.c
+++ b/transport.c
@@ -940,7 +940,7 @@ static int external_specification_len(const char *url)
 	return strchr(url, ':') - url;
 }
 
-static const struct string_list *protocol_whitelist(void)
+static const struct string_list *protocol_allowlist(void)
 {
 	static int enabled = -1;
 	static struct string_list allowed = STRING_LIST_INIT_DUP;
@@ -1020,9 +1020,9 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 
 int is_transport_allowed(const char *type, int from_user)
 {
-	const struct string_list *whitelist = protocol_whitelist();
-	if (whitelist)
-		return string_list_has_string(whitelist, type);
+	const struct string_list *allowlist = protocol_allowlist();
+	if (allowlist)
+		return string_list_has_string(allowlist, type);
 
 	switch (get_protocol_config(type)) {
 	case PROTOCOL_ALLOW_ALWAYS:
-- 
gitgitgadget
