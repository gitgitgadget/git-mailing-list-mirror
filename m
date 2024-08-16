Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC4145A1B
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849599; cv=none; b=JFgvgoGhkNgW0VCqVHFR+SSrhxqAbe+Pa/wdkTGe4nIGtf+sMzQ891aHu1K6OD4KXqj+z/hRV+Y1uSf4lyzDuB/witEgWXCzIDLVrxc1g1uW7x7w5h5w/0nKsVw3SWpvcd8tzREo+1MjJCtVE7qDCiPR7ulQc1X2csKYnCq1chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849599; c=relaxed/simple;
	bh=VRn3fcP2JnAJiLx0QLB92MrJ2qRsX+Sl4hfItY/hMUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=q+Uuaqvow3rQHnJO2hjbs72IE6thMhPSsjQ9PKGAGEhMnWS1Ie5W7/geGR19BpHKL5N4i7VKquHCxaTYbxndg7nS0/XwdRvQy5kvLaPhA97YN+Jmomc7041DW3qzCykUfDt15sESEwzxkoxw0w5YIe+JKnKNUab7x1N6jjEf1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTNSDsl+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTNSDsl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723849597; x=1755385597;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=VRn3fcP2JnAJiLx0QLB92MrJ2qRsX+Sl4hfItY/hMUI=;
  b=HTNSDsl+RaEuZoWL/P5Eol2wg1bwUalsxQGqyPtAd0UFVwyjZSAk98Vc
   pCy/KwVsRGYNujiE/LzaGQiHbEnDIBtFBWYZXPzenQnZpmuW5+76vxh49
   THlKwoYqVsD2KalzfaMTq3e5YpcxuEXLqIJU4Iz5/snCNciWHh5YNBF7C
   yoibnH/+Ta7rOrpZ4wpoLw8lFzCNHhtRcPS3pPlF+hP1tu0T9r3UzqO6v
   sT2Visjn+6ULnpYUMp54J5mLloTO22CxZ9OxKqkMJJbtEwShbe6ARLCBS
   WY8qRevLoO7QbefkDACWOD6ecfvJpYZ7+7KA5/YUQnPBxAUQutvvROWOV
   g==;
X-CSE-ConnectionGUID: 346LFP+iTuWQbw+BQaMcQg==
X-CSE-MsgGUID: 8dQva0Q1R5aXsO7/+5c4Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33571625"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="33571625"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:06:33 -0700
X-CSE-ConnectionGUID: uvWDA6ZgQxmEtCWUntANpQ==
X-CSE-MsgGUID: pMzC6sBNSTCCkZ62igGw5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="64704682"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:06:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 16 Aug 2024 16:06:24 -0700
Subject: [PATCH 2/2] send-email: add support for --mailmap
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-jk-send-email-mailmap-support-v1-2-68ca5b4a6078@gmail.com>
References: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
In-Reply-To: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

In certain cases, a user may be generating a patch for an old commit
which now has an out-of-date author or other identity. For example,
consider a team member who contributes to an internal fork of a project,
and then later leaves the company.

It may be desired to submit this change upstream, but the author
identity now points to an invalid email address which will bounce. This
is likely to annoy users who respond to the email on the public mailing
list.

This can be manually corrected, but requires a bit of effort, as it may
require --suppress-cc or otherwise formatting a patch separately and
manually removing any unintended email addresses.

Git already has support for the mailmap, which allows mapping addresses
for old commits to new canonical names and addresses.

Teach git send-email the --mailmap option. When supplied, use git
check-mailmap (with the --no-brackets mode) as a final stage when
processing address lists. This will convert all addresses to their
canonical name and email according to the mailmap file.

A mailmap file can then be configured to point the invalid addresses
either to their current canonical email (if they still participate in
the open source project), or possibly to new owner within the company.

This enables the sender to avoid accidentally listing an invalid address
when sending such a change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 git-send-email.perl   | 14 ++++++++++++++
 t/t9001-send-email.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 72044e5ef3a8..9a081e9f9b41 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -46,6 +46,8 @@ sub usage {
     --compose-encoding      <str>  * Encoding to assume for introduction.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
     --transfer-encoding     <str>  * Transfer encoding to use (quoted-printable, 8bit, base64)
+    --[no-]mailmap                 * Use mailmap file to map all email addresses to canonical
+                                     real names and email addresses.
 
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -278,6 +280,7 @@ sub do_edit {
 my $chain_reply_to = 0;
 my $use_xmailer = 1;
 my $validate = 1;
+my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
 
@@ -524,6 +527,8 @@ sub config_regexp {
 		    "thread!" => \$thread,
 		    "validate!" => \$validate,
 		    "transfer-encoding=s" => \$target_xfer_encoding,
+		    "mailmap!" => \$mailmap,
+		    "use-mailmap!" => \$mailmap,
 		    "format-patch!" => \$format_patch,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
@@ -1085,6 +1090,14 @@ sub expand_one_alias {
 our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
 
+sub mailmap_address_list {
+	my @addr_list = @_;
+	if ($mailmap and @addr_list) {
+		@addr_list = Git::command('check-mailmap', '--no-brackets', @_);
+	}
+	return @addr_list;
+}
+
 sub extract_valid_address {
 	my $address = shift;
 	my $local_part_regexp = qr/[^<>"\s@]+/;
@@ -1294,6 +1307,7 @@ sub process_address_list {
 	@addr_list = expand_aliases(@addr_list);
 	@addr_list = sanitize_address_list(@addr_list);
 	@addr_list = validate_address_list(@addr_list);
+	@addr_list = mailmap_address_list(@addr_list);
 	return @addr_list;
 }
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64a4ab3736ef..185697d22563 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2379,6 +2379,55 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'mailmap support with --to' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=someone@example.org \
+		--mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'mailmap support in To header' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	cat >mailmap.test <<-EOF &&
+	<someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 --to=someone@example.org >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'mailmap support in Cc header' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	cat >mailmap.test <<-EOF &&
+	<someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 --cc=someone@example.org >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
 test_expect_success $PREREQ 'test using command name with --sendmail-cmd' '
 	clean_fake_sendmail &&
 	PATH="$PWD:$PATH" \

-- 
2.46.0.124.g2dc1a81c8933

