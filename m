Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4318859A
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794058; cv=none; b=NChGamHj70a2Rpq5e/Xkjw10Zm2G0BhYryJH16GrLx0vs4v6ZkB+8pXy1l+aGNtvMxyOAu8RC5uYqg9re9oGTN3b6eIsAKv0GVqqSry+7y6yosfv32KvcAwOu6a6TEd83pbIPHDTvSmYmDHuPBIkBgxP8Z3AWogAEJVtiolpaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794058; c=relaxed/simple;
	bh=R9iWmJ0X1ApjTVgxpL2yib0dM5JnDS/DDko2IU6DZgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=dOkicO9NwA8jeyQIumiWFjRw+ANe3fE9J8INmPMt7VGFplQ6kZzoAXB8fjCHxDdtnPCwVttcMw41VZOF3x6+SbrR+QEdTSWv5EhDN5h+t2BS5ChC6wUTNve8Xa7emAdiKWmm3I9SF9k0BZ1lxV0dP0iwEbnD24ZORR0//NVdU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KihM1WwK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KihM1WwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724794057; x=1756330057;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=R9iWmJ0X1ApjTVgxpL2yib0dM5JnDS/DDko2IU6DZgM=;
  b=KihM1WwKWrH/0h5V8TZegs37bYW4GlUSx6CgXXQE6Saacz+3YhGK4sSo
   xNzVHEnN5F+mrhQCMGUGwKg7ZOuvwlfaDjGE38huYXhZm4sfsD5houVUU
   eTrnC0d05EeUa6SHuB0JuzTayRrXKYvwg+eow/EqMTIjbh37j78Xi9oG9
   69IcR3XLGHZR+xGnRpp01IhuRoUKL6Lt2/rFbjTkpMLJL5G6nYocryTDX
   8qSYHe/5spFUJ9fXGjB8E/gUj+mqrrO/zr6uVvZv335mvUwEEbnEyoarC
   9IIvX53FPE+9KqzIjweDP2FtvtBEtRm6P7D6MSlDZZ1cN5Iz2erOtpoiz
   w==;
X-CSE-ConnectionGUID: CLA+aHn+TjC/1xlqJebQZA==
X-CSE-MsgGUID: LuUcJHv7TMWTPpSsS3noqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33959516"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="33959516"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
X-CSE-ConnectionGUID: jji5NXQfQDyue3oICleQvg==
X-CSE-MsgGUID: BWMkTVoQRnuHwu3IQ/s+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63517537"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 27 Aug 2024 14:27:18 -0700
Subject: [PATCH v3 3/3] send-email: add mailmap support via
 sendemail.mailmap and --mailmap
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-jk-send-email-mailmap-support-v3-3-bec5ba9be391@gmail.com>
References: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
In-Reply-To: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>, 
 Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

In some cases, a user may be generating a patch for an old commit which
now has an out-of-date author or other identity. For example, consider a
team member who contributes to an internal fork of an upstream project,
but leaves before this change is submitted upstream.

In this case, the team members company address may no longer be valid,
and will thus bounce when sending email.

This can be manually avoided by editing the generated patch files, or by
carefully using --suppress-<cc|to> options. This requires a lot of
manual intervention and is easy to forget.

Git has support for mapping old email addresses and names to a canonical
name and address via the .mailmap file (and its associated mailmap.file,
mailmap.blob, and log.mailmap options).

Teach git send-email to enable mailmap support for all addresses. This
ensures that addresses point to the canonical real name and email
address.

Add the sendemail.mailmap configuration option and its associated
--mailmap (and --use-mailmap for compatibility with git log) options.
For now, the default behavior is to disable the mailmap in order to
avoid any surprises or breaking any existing setups.

These options support per-identity configuration via the
sendemail.identity configuration blocks. This enables identity-specific
configuration in cases where users may not want to enable support.

In addition, support send-email specific mailmap data via
sendemail.mailmap.file, sendemail.mailmap.blob and their
identity-specific variants.

The intention of these options is to enable mapping addresses which are
no longer valid to a current project or team maintainer. Such mappings
may change the actual person being referred to, and may not make sense
in a traditional mailmap file which is intended for updating canonical
name and address for the same individual.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 git-send-email.perl   |  20 +++++++++
 t/t9001-send-email.sh | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 72044e5ef3a8..8995d5f12d9e 100755
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
@@ -272,12 +274,14 @@ sub do_edit {
 my ($auto_8bit_encoding);
 my ($compose_encoding);
 my ($sendmail_cmd);
+my ($mailmap_file, $mailmap_blob);
 # Variables with corresponding config settings & hardcoded defaults
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 my $thread = 1;
 my $chain_reply_to = 0;
 my $use_xmailer = 1;
 my $validate = 1;
+my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
 
@@ -294,6 +298,7 @@ sub do_edit {
     "annotate" => \$annotate,
     "xmailer" => \$use_xmailer,
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
+    "mailmap" => \$mailmap,
 );
 
 my %config_settings = (
@@ -327,6 +332,8 @@ sub do_edit {
 my %config_path_settings = (
     "aliasesfile" => \@alias_files,
     "smtpsslcertpath" => \$smtp_ssl_cert_path,
+    "mailmap.file" => \$mailmap_file,
+    "mailmap.blob" => \$mailmap_blob,
 );
 
 # Handle Uncouth Termination
@@ -524,6 +531,8 @@ sub config_regexp {
 		    "thread!" => \$thread,
 		    "validate!" => \$validate,
 		    "transfer-encoding=s" => \$target_xfer_encoding,
+		    "mailmap!" => \$mailmap,
+		    "use-mailmap!" => \$mailmap,
 		    "format-patch!" => \$format_patch,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
@@ -1085,6 +1094,16 @@ sub expand_one_alias {
 our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
 
+sub mailmap_address_list {
+	return @_ unless @_ and $mailmap;
+	my @options = ();
+	push(@options, "--mailmap-file=$mailmap_file") if $mailmap_file;
+	push(@options, "--mailmap-blob=$mailmap_blob") if $mailmap_blob;
+	my @addr_list = Git::command('check-mailmap', @options, @_);
+	s/^<(.*)>$/$1/ for @addr_list;
+	return @addr_list;
+}
+
 sub extract_valid_address {
 	my $address = shift;
 	my $local_part_regexp = qr/[^<>"\s@]+/;
@@ -1294,6 +1313,7 @@ sub process_address_list {
 	@addr_list = expand_aliases(@addr_list);
 	@addr_list = sanitize_address_list(@addr_list);
 	@addr_list = validate_address_list(@addr_list);
+	@addr_list = mailmap_address_list(@addr_list);
 	return @addr_list;
 }
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64a4ab3736ef..4bdc793a53a2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2379,6 +2379,128 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
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
+test_expect_success $PREREQ 'sendemail.mailmap configuration' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=someone@example.org \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'sendemail.mailmap.file configuration' '
+	clean_fake_sendmail &&
+	test_config sendemail.mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=someone@example.org \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'sendemail.mailmap identity overrides configuration' '
+	clean_fake_sendmail &&
+	test_config sendemail.cloud.mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "false" &&
+	test_config sendemail.cloud.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--identity=cloud \
+		--to=someone@example.org \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ '--no-mailmap overrides configuration' '
+	clean_fake_sendmail &&
+	test_config sendemail.cloud.mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "false" &&
+	test_config sendemail.cloud.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--identity=cloud \
+		--to=someone@example.org \
+		--no-mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.org!$" commandline1
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

