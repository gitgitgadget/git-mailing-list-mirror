Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881D1422BF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849598; cv=none; b=mbNxcv81V5Sxv7OHHeSWhlR6Qag17nH9gDNl39dRNKhWY3F1zRX7VUWjfuWvc3Pet9FqZlHlDcffUtlPKDiyPPsYliE2fmCpJKowulFEvHUDGyS3bZzBOkAFT4P/SgFasUukZ7ylXiMprvccBKe8qOrECHWw8r4bRLGUjSi6DU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849598; c=relaxed/simple;
	bh=BUU0oJI0AVfRA/1j4RQw+Ddfh8nKDl2XyzpvWu89VnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=GqFIETahBT2KQAwUIXkP6aQrEYmYhfIjnFZ9eGITNWRVyC+DfpM4ftD4Hs5I5kZynuSBMz/5rfMWcBcPuVgMmyu8ehdu0kGus+FLWejZfGX86HoHL4PL03xqKOt1OXgaIXUhn6YWSn467qkGv227sQkjynGH1uOh58ANOt8d0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEV5yBWz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEV5yBWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723849596; x=1755385596;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=BUU0oJI0AVfRA/1j4RQw+Ddfh8nKDl2XyzpvWu89VnE=;
  b=OEV5yBWzZOylqoa1v/UeEdcAaVwA1lsK3Q884swu3sYZ5Tt40nSeYKqa
   QypPgF7vE1E/nYDYK7fQXEo0eWAkqPKFjPvMYexp4pLN8C6Jp3pyIoR8I
   B4DSFooY3wQyw7stcFDi8/wh2Vim56NTH5KRfIZz90563JG/vghORQS5o
   38hBQlOri80TFX/ewQLkSUJUPgciAPd9cHyNvZWKJTq1E2nH7UvaPFYPS
   JH76kvGa4yaEvfbgBk39KKafgbq3tznKFJD73a7JI3+6qJSO4GeCQeRwe
   PcYL/hREUM0NxaBXA2qedl2gy5M3Rf7QNeS7vJT/W2OCLlp67P4NsTsuR
   Q==;
X-CSE-ConnectionGUID: FMp2lL3wQDmghA8q7AEdcQ==
X-CSE-MsgGUID: JiahqV2cRD+hueGIetUGbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33571620"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="33571620"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:06:33 -0700
X-CSE-ConnectionGUID: wuIOOGhTSzaKEaEl/5aCjA==
X-CSE-MsgGUID: q9iycPYtSZe1COFw1R3NRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="64704681"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:06:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 16 Aug 2024 16:06:23 -0700
Subject: [PATCH 1/2] check-mailmap: add --no-brackets mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-jk-send-email-mailmap-support-v1-1-68ca5b4a6078@gmail.com>
References: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
In-Reply-To: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

The git check-mailmap command can be used to convert identities to their
canonical real name and email address. Currently, if a simple email
address is provided without surrounding angle brackets, git
check-mailmap will fail:

  $ git check-mailmap test@example.com
  fatal: unable to parse contact: test@example.com

This is generally fine since identifies are expected to be of the form
"name <email@domain>". However, requiring brackets around simple email
addresses can make it difficult to support mailmap operation in other
environments where angle brackets may be missing.

Specifically, attempting to support the mailmap within git send-email is
tricky, since angle brackets are not always provided for addresses.

Teach check-mailmap a new '--no-brackets' mode. In this mode, any
contact line which cannot be interpreted by split_ident_line is treated
as a simple address without a name. In addition, when any contact does
not have a name, output the mail address without the angle brackets.
Note that angle brackets are accepted if they are present, however the
output will strip them.

This mode will be useful for git send-email in a following feature
implementation to enable mapping any email addresses to their canonical
value.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/check-mailmap.c             | 27 ++++++++++++-----
 Documentation/git-check-mailmap.txt |  8 ++++-
 t/t4203-mailmap.sh                  | 60 +++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index b8a05b8e07b5..7c8cde370b97 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -9,6 +9,7 @@
 #include "write-or-die.h"
 
 static int use_stdin;
+static int no_brackets;
 static const char * const check_mailmap_usage[] = {
 N_("git check-mailmap [<options>] <contact>..."),
 NULL
@@ -16,6 +17,7 @@ NULL
 
 static const struct option check_mailmap_options[] = {
 	OPT_BOOL(0, "stdin", &use_stdin, N_("also read contacts from stdin")),
+	OPT_BOOL(0, "no-brackets", &no_brackets, N_("do not require or output brackets for nameless email addresses")),
 	OPT_END()
 };
 
@@ -25,19 +27,28 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 	size_t namelen, maillen;
 	struct ident_split ident;
 
-	if (split_ident_line(&ident, contact, strlen(contact)))
+	if (!split_ident_line(&ident, contact, strlen(contact))) {
+		name = ident.name_begin;
+		namelen = ident.name_end - ident.name_begin;
+		mail = ident.mail_begin;
+		maillen = ident.mail_end - ident.mail_begin;
+	} else if (no_brackets) {
+		name = contact;
+		namelen = 0;
+		mail = contact;
+		maillen = strlen(contact);
+	} else {
 		die(_("unable to parse contact: %s"), contact);
-
-	name = ident.name_begin;
-	namelen = ident.name_end - ident.name_begin;
-	mail = ident.mail_begin;
-	maillen = ident.mail_end - ident.mail_begin;
+	}
 
 	map_user(mailmap, &mail, &maillen, &name, &namelen);
 
 	if (namelen)
-		printf("%.*s ", (int)namelen, name);
-	printf("<%.*s>\n", (int)maillen, mail);
+		printf("%.*s <%.*s>\n", (int)namelen, name, (int)maillen, mail);
+	else if (no_brackets)
+		printf("%.*s\n", (int)maillen, mail);
+	else
+		printf("<%.*s>\n", (int)maillen, mail);
 }
 
 int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 02f441832321..30f44391a9dd 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -27,13 +27,19 @@ OPTIONS
 	Read contacts, one per line, from the standard input after exhausting
 	contacts provided on the command-line.
 
+--no-brackets::
+	Do not require ``<`` and ``>`` angle brackets when interpreting
+	contacts without a name. Additionally, do not output brackets when
+	outputting an email without a name.
+
 
 OUTPUT
 ------
 
 For each contact, a single line is output, terminated by a newline.  If the
 name is provided or known to the 'mailmap', ``Name $$<user@host>$$'' is
-printed; otherwise only ``$$<user@host>$$'' is printed.
+printed; otherwise only ``$$<user@host>$$'' is printed. If ``--no-brackets``
+is specified, output only ``<user@host>`` for contacts without a name.
 
 
 CONFIGURATION
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 79e5f42760d9..83f012b34ab1 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -80,6 +80,66 @@ test_expect_success 'check-mailmap bogus contact --stdin' '
 	test_must_fail git check-mailmap --stdin bogus </dev/null
 '
 
+test_expect_success 'check-mailmap --no-brackets simple address: no mapping' '
+	cat >expect <<-EOF &&
+		bugs@company.xy
+	EOF
+	git check-mailmap --no-brackets bugs@company.xy >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --no-brackets address with brackets: no mapping' '
+	cat >expect <<-EOF &&
+		bugs@company.xy
+	EOF
+	git check-mailmap --no-brackets "<bugs@company.xy>" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --no-brackets simple address: mapping' '
+	cat >.mailmap <<-EOF &&
+		New Name <bugs@company.xy>
+	EOF
+	cat >expect <<-EOF &&
+		New Name <bugs@company.xy>
+	EOF
+	git check-mailmap --no-brackets bugs@company.xy >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --stdin --no-brackets simple address: mapping' '
+	cat >.mailmap <<-EOF &&
+		New Name <bugs@company.xy>
+	EOF
+	cat >stdin <<-EOF &&
+		bugs@company.xy
+	EOF
+	cat >expect <<-EOF &&
+		New Name <bugs@company.xy>
+	EOF
+	git check-mailmap --stdin --no-brackets <stdin >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --no-brackets simple address: mapping, no name' '
+	cat >.mailmap <<-EOF &&
+		<bugs@company.xz> <bugs@company.xy>
+	EOF
+	cat >expect <<-EOF &&
+		bugs@company.xz
+	EOF
+	git check-mailmap --no-brackets bugs@company.xy >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --no-brackets bogus address' '
+	cat >expect <<-EOF &&
+		bogus
+	EOF
+	git check-mailmap --no-brackets bogus >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'No mailmap' '
 	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME (1):

-- 
2.46.0.124.g2dc1a81c8933

