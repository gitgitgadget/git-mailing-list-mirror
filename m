Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93D19755B
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794056; cv=none; b=My9Xb+xvKtEiwnRtrtV6uURljId7DaWys+wN5XyjhqKlqAQA1ccNMFOdK0JRrtSOd36KUOHsT6Yj+8pXpWH+Xbijq4mKLrfVxSGKLIJzzYiSVpaA3Iv8Tcl2xAgYDHmU/620wXL/bNbOYT8yEYRTMIJX/xcY2Eyv7z+jBzC5Hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794056; c=relaxed/simple;
	bh=lw6NiF1fm48C5S9eXHjrHshC4CLfBRLpYzW5t+PdPFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=R52/ZlkKcHW425UFlfW0WuI9+JcEctzBdoNWdV5jidRLtyGmESyyukA0BxqtKXLGXGEPMstAbJIE3RT1Q/NozsivkeFgdOsNDFcZB5m5+M3jazetgRZ+RB5ihGqqOMpGT098YcQXUTfPtmgvZNTFoWU/TPCMG6XfnadXJIyQYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEs+xcKp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEs+xcKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724794055; x=1756330055;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=lw6NiF1fm48C5S9eXHjrHshC4CLfBRLpYzW5t+PdPFc=;
  b=cEs+xcKpifmb+mV/QtiudW/y9VLg92n9DqWV/qQX+kvrz1xK1SgbEQZb
   6p+gLF6INuNdNr5HSLwUv1Slm9g5kUcrMHW9CibsxgI02QUUcrnmJYpBH
   G3brWmG5tFZnOu/oQbgAVYU5qYLs8syRXsJ0HkcTxeFXp2tOEyhsIl8Ev
   +ut4DLOhRt/pmxpjuZcyWz7TRZRSsGk9dvigxvYF3hZgZ3B4IKCB/fRoY
   hKdBxEKks7TiSoYxRnvuewjy1rSymIEp3eWUj02iqSZg9G5q5SJkHzeOh
   LerqgVfMXOI2z0gzqyYxUIJ3TNZ5p0fYN5Yr2SRRoYGcy3SLv8Lzy14Df
   Q==;
X-CSE-ConnectionGUID: oPmXMwd7Rt2jyyJ71+vbbw==
X-CSE-MsgGUID: j+G293wyStSjHHxJjPcZmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33959506"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="33959506"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
X-CSE-ConnectionGUID: 81uXMQYAQvO8pQTglBunGQ==
X-CSE-MsgGUID: hvjoFxvSRG6q13ujiS3VQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63517535"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 27 Aug 2024 14:27:16 -0700
Subject: [PATCH v3 1/3] check-mailmap: accept "user@host" contacts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-jk-send-email-mailmap-support-v3-1-bec5ba9be391@gmail.com>
References: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
In-Reply-To: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>, 
 Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

git check-mailmap splits each provided contact using split_ident_line.
This function requires that the contact either be of the form "Name
<user@host>" or of the form "<user@host>". In particular, if the mail
portion of the contact is not surrounded by angle brackets,
split_ident_line will reject it.

This results in git check-mailmap rejecting attempts to translate simple
email addresses:

  $ git check-mailmap user@host
  fatal: unable to parse contact: user@host

This limits the usability of check-mailmap as it requires placing angle
brackets around plain email addresses.

In particular, attempting to use git check-mailmap to support mapping
addresses in git send-email is not straight forward. The sanitization
and validation functions in git send-email strip angle brackets from
plain email addresses. It is not trivial to add brackets prior to
invoking git check-mailmap.

Instead, modify check_mailmap() to allow such strings as contacts. In
particular, treat any line which cannot be split by split_ident_line as
a simple email address.

No attempt is made to actually parse the address line, or validate that
it is actually an email address. Implementing such validation is not
trivial. Besides, we weren't validating the address between angle
brackets before anyways.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/check-mailmap.c             | 18 +++++++++-------
 Documentation/git-check-mailmap.txt |  8 +++----
 t/t4203-mailmap.sh                  | 42 +++++++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index b8a05b8e07b5..6b7fb53494f0 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -25,13 +25,17 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 	size_t namelen, maillen;
 	struct ident_split ident;
 
-	if (split_ident_line(&ident, contact, strlen(contact)))
-		die(_("unable to parse contact: %s"), contact);
-
-	name = ident.name_begin;
-	namelen = ident.name_end - ident.name_begin;
-	mail = ident.mail_begin;
-	maillen = ident.mail_end - ident.mail_begin;
+	if (!split_ident_line(&ident, contact, strlen(contact))) {
+		name = ident.name_begin;
+		namelen = ident.name_end - ident.name_begin;
+		mail = ident.mail_begin;
+		maillen = ident.mail_end - ident.mail_begin;
+	} else {
+		name = NULL;
+		namelen = 0;
+		mail = contact;
+		maillen = strlen(contact);
+	}
 
 	map_user(mailmap, &mail, &maillen, &name, &namelen);
 
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 02f441832321..7747e38e25e3 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -15,10 +15,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the command-line
-or standard input (when using `--stdin`), look up the person's canonical name
-and email address (see "Mapping Authors" below). If found, print them;
-otherwise print the input as-is.
+For each ``Name $$<user@host>$$'', ``$$<user@host>$$'', or ``$$user@host$$''
+from the command-line or standard input (when using `--stdin`), look up the
+person's canonical name and email address (see "Mapping Authors" below). If
+found, print them; otherwise print the input as-is.
 
 
 OPTIONS
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 79e5f42760d9..2265ff8872df 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -72,12 +72,46 @@ test_expect_success 'check-mailmap --stdin arguments: mapping' '
 	test_cmp expect actual
 '
 
-test_expect_success 'check-mailmap bogus contact' '
-	test_must_fail git check-mailmap bogus
+test_expect_success 'check-mailmap simple address: mapping' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	New Name <$GIT_AUTHOR_EMAIL>
+	EOF
+	cat .mailmap >expect &&
+	git check-mailmap "$GIT_AUTHOR_EMAIL" >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success 'check-mailmap bogus contact --stdin' '
-	test_must_fail git check-mailmap --stdin bogus </dev/null
+test_expect_success 'check-mailmap --stdin simple address: mapping' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	New Name <$GIT_AUTHOR_EMAIL>
+	EOF
+	cat >stdin <<-EOF &&
+	$GIT_AUTHOR_EMAIL
+	EOF
+	cat .mailmap >expect &&
+	git check-mailmap --stdin <stdin >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap simple address: no mapping' '
+	cat >expect <<-EOF &&
+	<bugs@company.xx>
+	EOF
+	git check-mailmap "bugs@company.xx" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --stdin simple address: no mapping' '
+	cat >expect <<-EOF &&
+	<bugs@company.xx>
+	EOF
+	cat >stdin <<-EOF &&
+	bugs@company.xx
+	EOF
+	git check-mailmap --stdin <stdin >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'No mailmap' '

-- 
2.46.0.124.g2dc1a81c8933

