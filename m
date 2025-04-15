Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368228DF0F
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711042; cv=none; b=fceBRNHUwskOZBQtVauhHLQ5W5RQuVnldFYM1CJD5uCm6TK98/dQgbipK6hGw5Ggh3AfGinbnO9Yi1vbBDilidLyHB+jgOCv3/kEIhhWtcaVV9ARUnKeXgHAGlL9fpA7AQ7SkYbklehd19ekcF6qWq20khmKZpJ1UyWHJLoP9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711042; c=relaxed/simple;
	bh=89MriEdT0X3Wo1XXNUywHxWoPwueXhm9YaIe3g+j27w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=av+9CbctdmQHpnYiVhGnIeWCTbLpt5NzRKAkMvpsK7WDplQfXqFrdGOAwHZIR9ehSUVv7Kktqkig/WaXiAIeo3oGFU0mTTns93F31Vx+9arZScsJ8mHyj251ijQ0oxnfJp6utHlA3dy0r8x0qBzXEnyxN9klCdgxy37sbSOUC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QtomX2ql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cq4zkM1X; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QtomX2ql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cq4zkM1X"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7180D11402D5;
	Tue, 15 Apr 2025 05:57:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 15 Apr 2025 05:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744711039;
	 x=1744797439; bh=fMH9D9rGQyec0PwX4FopMbYFrXZjiR1hhIc47VL4ghs=; b=
	QtomX2qlso+beSbe79bMLJjR1AW6MbuW8llPOkUygJvgdGcg6D4TqY/AWfR233IS
	8+m1+mkdrleT3LTJC6KeemLvOANdBxoCCsK1QMr3N+B3pb2T5Bvl5qgANGFM4tV6
	eS07XD/YXC6crATxtHZVC8tlII5/Y4ZfMoJtaIW8lQYFlfo6XH3EO/Nj5neLfyDg
	qCUexj3ZcCzhbOW5MBBDrLR8E/CK97HPnloslxrICSKF05b2eSEkztG3kMgoi7Vv
	YqLK8IA+few6Ry0j+ALwlHAA/GR46KlzRI5cMMx8eBfMwa1qiVRduqK3eWUYoPgi
	fxPkZBCDAsSF61UU8ang9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744711039; x=
	1744797439; bh=fMH9D9rGQyec0PwX4FopMbYFrXZjiR1hhIc47VL4ghs=; b=C
	q4zkM1XOxn21LXh5EBX0uU4Blf9HSx8XlXRT9JPyhFaC9F7avwU6Nm7G63oXbj2d
	4Y/dbtKwAARgnu/uAP8Jw5iHW8kFIMtuAjSDEJbA5BZpILHTOZk4Ca2toZ9YTDf0
	HcSzspSEg9b/jB+CjjUGoiW1VvOSnfba/VLlMt4vCXIC/2mPsVNuIXd1vEeJd+Vq
	FnYPLoLg4v1qhM6Zi7igt6lKQbVifvvzq7usVkgxRtvEsEyj3HL60IpR0ebGliZW
	kHR73i6AnAA29lepTKjqEMcSwqvxcqo+M1/6QmHbovr1/Ilm8+72vYyiCiKLinGT
	e/uI0wOU18cKCtPMzf8VA==
X-ME-Sender: <xms:fy3-Z-9itOJUtNqK25ZPAq_mnlwgVp6dt_PbPnggo9ZMDNyb7bVQ6Q>
    <xme:fy3-Z-v1-lWLes8AR2w57AbFXW6LWdEVrGRrRsECz578jG_mNzQ6p1Q8aQtDBl-x1
    N_rd-CDzqmW04mpLA>
X-ME-Received: <xmr:fy3-Z0Av0IoPFEpvmF2C3kR25Ss8iWaldAfnxUmlr5lUVgS8MwzVvitt_62pwKtWZvufcCX8kHiUsyJhsgPYQUWA6BOMVP5hvzfimwuPK3F6tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fy3-Z2cK-3hFR-OebcvrS9J9xXfjSGvJTQwnxJ7oyeGO1ydSQvvgkg>
    <xmx:fy3-ZzO8czP_0lix_88YoMF_HItumdfu9CubbXif2oZyiZ2iu9ivFw>
    <xmx:fy3-ZwmQRx2BpB_aPTz2-XcFxV1iqgHG0cjafUU-Ld5oQmjivq_xWw>
    <xmx:fy3-Z1v7yctizECa3v-ch0_q918INW0-0OF-ClPlOufISZEtyygzOg>
    <xmx:fy3-Z2g1rAJlD8qVFnjhZugbnXsaM6Sn39itZIT5_fQou0k_RqGgLuwc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:57:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28bfca15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:57:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:57:11 +0200
Subject: [PATCH 4/4] Documentation: stop depending on Perl to generate
 command list
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-b4-pks-drop-perl-v1-4-c6addf175858@pks.im>
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
In-Reply-To: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The "cmd-list.perl" script is used to extract the list of commands part
of a specific category and extracts the description of each command from
its respective manpage. The generated output is then included in git(1)
to list all Git commands.

The script is written in Perl. Refactor it to use shell scripting
exclusively so that we can get rid of the mandatory dependency on Perl
to build our documentation.

The converted script is slower compared to its Perl implementation. But
by being careful and not spawning external commands in `format_one ()`
we can mitigate the performance hit to a reasonable level:

    Benchmark 1: Perl
      Time (mean ± σ):      10.3 ms ±   0.2 ms    [User: 7.0 ms, System: 3.3 ms]
      Range (min … max):    10.0 ms …  11.1 ms    200 runs

    Benchmark 2: Shell
      Time (mean ± σ):      74.4 ms ±   0.4 ms    [User: 48.6 ms, System: 24.7 ms]
      Range (min … max):    73.1 ms …  75.5 ms    200 runs

    Summary
      Perl ran
        7.23 ± 0.13 times faster than Shell

While a sevenfold slowdown is significant, the benefit of not requiring
Perl for a fully-functioning Git installation outweighs waiting a couple
of milliseconds longer during the build process.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile      |   4 +-
 Documentation/cmd-list.perl |  80 ----------------------------------
 Documentation/cmd-list.sh   | 104 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build   |   4 +-
 meson.build                 |   2 +-
 5 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6485d40f620..b109d25e9c8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -317,8 +317,8 @@ cmds_txt = cmds-ancillaryinterrogators.adoc \
 
 $(cmds_txt): cmd-list.made
 
-cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
-	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl .. . $(cmds_txt) && \
+cmd-list.made: cmd-list.sh ../command-list.txt $(MAN1_TXT)
+	$(QUIET_GEN)$(SHELL_PATH) ./cmd-list.sh .. . $(cmds_txt) && \
 	date >$@
 
 mergetools-%.adoc: generate-mergetool-list.sh ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
deleted file mode 100755
index 0a0c1b3f611..00000000000
--- a/Documentation/cmd-list.perl
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/usr/bin/perl -w
-
-use File::Compare qw(compare);
-
-sub format_one {
-	my ($source_dir, $out, $nameattr) = @_;
-	my ($name, $attr) = @$nameattr;
-	my ($path) = "$source_dir/Documentation/$name.adoc";
-	my ($state, $description);
-	my $mansection;
-	$state = 0;
-	open I, '<', "$path" or die "No such file $path.adoc";
-	while (<I>) {
-		if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
-			$mansection = $1;
-			next;
-		}
-		if (/^NAME$/) {
-			$state = 1;
-			next;
-		}
-		if ($state == 1 && /^----$/) {
-			$state = 2;
-			next;
-		}
-		next if ($state != 2);
-		chomp;
-		$description = $_;
-		last;
-	}
-	close I;
-	if (!defined $description) {
-		die "No description found in $path.adoc";
-	}
-	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
-		print $out "linkgit:$name\[$mansection\]::\n\t";
-		if ($attr =~ / deprecated /) {
-			print $out "(deprecated) ";
-		}
-		print $out "$text.\n\n";
-	}
-	else {
-		die "Description does not match $name: $description";
-	}
-}
-
-my ($source_dir, $build_dir, @categories) = @ARGV;
-
-open IN, "<$source_dir/command-list.txt";
-while (<IN>) {
-	last if /^### command list/;
-}
-
-my %cmds = ();
-for (sort <IN>) {
-	next if /^#/;
-
-	chomp;
-	my ($name, $cat, $attr) = /^(\S+)\s+(.*?)(?:\s+(.*))?$/;
-	$attr = '' unless defined $attr;
-	push @{$cmds{$cat}}, [$name, " $attr "];
-}
-close IN;
-
-for my $out (@categories) {
-	my ($cat) = $out =~ /^cmds-(.*)\.adoc$/;
-	my ($path) = "$build_dir/$out";
-	open O, '>', "$path+" or die "Cannot open output file $out+";
-	for (@{$cmds{$cat}}) {
-		format_one($source_dir, \*O, $_);
-	}
-	close O;
-
-	if (-f "$path" && compare("$path", "$path+") == 0) {
-		unlink "$path+";
-	}
-	else {
-		rename "$path+", "$path";
-	}
-}
diff --git a/Documentation/cmd-list.sh b/Documentation/cmd-list.sh
new file mode 100755
index 00000000000..fa90781f3c7
--- /dev/null
+++ b/Documentation/cmd-list.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+set -e
+
+format_one () {
+	source_dir="$1"
+	command="$2"
+	attributes="$3"
+
+	path="$source_dir/Documentation/$command.adoc"
+	if ! test -f "$path"
+	then
+		echo >&2 "No such file $path"
+		exit 1
+	fi
+
+	state=0
+	while read line
+	do
+		case "$state" in
+			0)
+				case "$line" in
+				git*\(*\)|scalar*\(*\))
+					mansection="${line##*\(}"
+					mansection="${mansection%\)}"
+					;;
+				NAME)
+					state=1;;
+				esac
+				;;
+			1)
+				if test "$line" = "----"
+				then
+					state=2
+				fi
+				;;
+			2)
+				description="$line"
+				break
+				;;
+		esac
+	done <"$path"
+
+	if test -z "$mansection"
+	then
+		echo "No man section found in $path" >&2
+		exit 1
+	fi
+
+	if test -z "$description"
+	then
+		echo >&2 "No description found in $path"
+		exit 1
+	fi
+
+	case "$description" in
+		"$command - "*)
+			text="${description#$command - }"
+
+			printf "linkgit:%s[%s]::\n\t" "$command" "$mansection"
+			case "$attributes" in
+				*" deprecated "*)
+					printf "(deprecated) "
+					;;
+			esac
+			printf "$text.\n\n"
+			;;
+		*)
+			echo >&2 "Description does not match $command: $description"
+			exit 1
+			;;
+	esac
+}
+
+source_dir="$1"
+build_dir="$2"
+shift 2
+
+for out in "$@"
+do
+	category="${out#cmds-}"
+	category="${category%.adoc}"
+	path="$build_dir/$out"
+
+	while read command command_category attributes
+	do
+		case "$command" in
+		"#"*)
+			continue;;
+		esac
+
+		case "$command_category" in
+		"$category")
+			format_one "$source_dir" "$command" " $attributes ";;
+		esac
+	done <"$source_dir/command-list.txt" >"$build_dir/$out+"
+
+	if cmp "$build_dir/$out+" "$build_dir/$out" >/dev/null 2>&1
+	then
+		rm "$build_dir/$out+"
+	else
+		mv "$build_dir/$out+" "$build_dir/$out"
+	fi
+done
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 8b9e692c599..b731c76e9e7 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -315,12 +315,12 @@ cmd_lists = [
 
 documentation_deps += custom_target(
   command: [
-    perl,
+    shell,
     '@INPUT@',
     meson.project_source_root(),
     meson.current_build_dir(),
   ] + cmd_lists,
-  input: 'cmd-list.perl',
+  input: 'cmd-list.sh',
   output: cmd_lists
 )
 
diff --git a/meson.build b/meson.build
index 8bab8f3481f..97753d2cfa7 100644
--- a/meson.build
+++ b/meson.build
@@ -779,7 +779,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
+if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
   perl_required = true
 endif
 

-- 
2.49.0.805.g082f7c87e0.dirty

