Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D11367
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112482; cv=none; b=PybkWQo7Q27AWj9ZAPMIX4gJG0b3bxkZ7PttQulYsFC4vuOOLr1B2wT95jsrfis4Gug1USXYODRjG5I1J0kdlKbCoImhW/Pf3w97IgFx/u/TbwUoIxrSnIU34qdF9QhHfJaojP2MnM3DkZTV7u7BQf6micwcVsQu6l3a9KuPLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112482; c=relaxed/simple;
	bh=50jwgXRfAAgBkMdp8J4DtSDva/02mNtPontO33OOLv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=okq9As0UKMfqEowbqoSh2aa2LFJstYpCqFUYa0Lvg4isQ1Lj07arrBxgg78ardplVJ4IsLd0bPoVM3ivQvKA+Z2orI8J3U/D/p1qdRaTsMqaXO5/ENcANWnMLom5pkGVi1jOcXUGgVYTpBo1hiX7kT63oBkwn4pNt49XGq+DDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jL2In7p7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jL2In7p7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724112481; x=1755648481;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=50jwgXRfAAgBkMdp8J4DtSDva/02mNtPontO33OOLv4=;
  b=jL2In7p7BprJf6S+sHRheY7yR6mfib3cJK8IXhX75rBaHDDbKlBkirHZ
   4yX81jl8Bc2qkYLZmWHxwCsEUU93JU9jYqVZsMXQtKW7yXfwYsi2biT4B
   +AZytgcxPLYWACFXngaHZhQKL9bzlVWFnnCO73ajVvW7wbCj5aa2w3Fml
   /laRVABW1dY2cnSk4tSKWjmip+7O2crfqW2VxjphAMNYGI6esmnSGHVI4
   /RvSTgukzIjR0Q1/q2HubLD7s+7J5T498tCFobLRautE+4uHRLSGNRlaY
   EtElSFXtomIt1BHj3wIjIwAhpxMB3hASSgDx9AlNm4+W8INlUxg0+bESC
   Q==;
X-CSE-ConnectionGUID: R2nWWp7rSKGx+PEwfA5nkQ==
X-CSE-MsgGUID: lgfNrAQKRfqu2xuo1cXONQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33542529"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33542529"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:07:58 -0700
X-CSE-ConnectionGUID: zXWzhyadRhGy8/2dbju2Iw==
X-CSE-MsgGUID: EoPrhYsMQIu3khLdBxIG/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="91277718"
Received: from unknown (HELO localhost.localdomain) ([10.166.241.20])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:07:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 19 Aug 2024 17:07:49 -0700
Subject: [PATCH v2 1/3] check-mailmap: accept "user@host" contacts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-jk-send-email-mailmap-support-v2-1-d212c3f9e505@gmail.com>
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
In-Reply-To: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
To: Josh Steadmon <steadmon@google.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
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

No attempt is made to actually parse the address line to validate that
it is actually an address. Doing so is non-trivial, and provides little
value. Either the provided input will correctly map via the map_user
call, or it will fail and be printed out, surrounded by angle brackets:

  $ git check-mailmap user@host
  <user@host>

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/check-mailmap.c             | 18 +++++++++++-------
 Documentation/git-check-mailmap.txt |  8 ++++----
 t/t4203-mailmap.sh                  | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 13 deletions(-)

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
index 79e5f42760d9..0c1efe0b2e17 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -73,11 +73,40 @@ test_expect_success 'check-mailmap --stdin arguments: mapping' '
 '
 
 test_expect_success 'check-mailmap bogus contact' '
-	test_must_fail git check-mailmap bogus
+	cat >expect <<-EOF &&
+	<bogus>
+	EOF
+	git check-mailmap bogus >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'check-mailmap bogus contact --stdin' '
-	test_must_fail git check-mailmap --stdin bogus </dev/null
+	cat >expect <<-EOF &&
+	<bogus>
+	EOF
+	cat >stdin <<-EOF &&
+	bogus
+	EOF
+	git check-mailmap --stdin <stdin >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap simple address: mapping' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	New Name <$GIT_AUTHOR_EMAIL>
+	EOF
+	cat .mailmap >expect &&
+	git check-mailmap "$GIT_AUTHOR_EMAIL" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap simple address: no mapping' '
+	cat >expect <<-EOF &&
+	<bugs@company.xx>
+	EOF
+	git check-mailmap "bugs@company.xx" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'No mailmap' '

-- 
2.46.0.124.g2dc1a81c8933

