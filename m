Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F83C1408
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935527; cv=none; b=aWWJCheWefeU9j2zBerFecYuneF3Z3jCfYl9f9uCt7CDOb9i0wGil+6+xigR23zM1nINArAcUHleepk/XKmQXB8z11R93rTBal8UOCZod9COmP0Gq5YON10LIDBlg3QFu+hJ1ti8hSwvcp9wvkRUO4xaRKbdyugiMpN5O/Y0JWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935527; c=relaxed/simple;
	bh=JRGmOuzWl79ElJ8bn0DWug5tdPDFnjfAEa3NKcyNL3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+23TTb0omRoU+DbLOiMDdqrMiSnk20odiCSWCvE7F62WST+pz7a1Pa9Yb0b/1+7subPumkvE5Q9XQzjtg5y3zfUBdoQwHqHAAWTpLOkOoxwogXYR6kFySYA5xUj8EgF4rJvT3qkwKw75Mq23tqK7oZT6cDiJDfr5lF6nPC3jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVIu0hUF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVIu0hUF"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d556c1a79eso1132050a34.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773935525; x=1774540325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HL4iO08dWs+C8aSZinpn/MoY1WHh3mghfNCjZe9Ue8o=;
        b=JVIu0hUFOpEG7zd5moAuD05O0rSJg1a+3rT075cq5RP4dykSUvnrqvNQDMTy42yUZv
         29kqsInuu+cvJH1zuPnxmViRbHCdqQKe+97OgxFtkR3lkBqnQmB8KAI7IrP0bKOUDbbn
         Vej3PsQ+EMW8e5qavihYONEZKZN7Aa9P+wK/lDPMJcbLLr2iuiyiAxaVoqkd3BcD4PyR
         Zoa579bSqO4DjjknA3JlauMzzxc48P9HoLxX+ybl7Izf+veYWwUqZyDFoqK9Fj71H+1p
         1/3Y2bcEpAhUMn623cgKo9TUKINYoyzjdpt0MfxeZ2cZztv0Dqsj1myIp5AkXCqhUEQF
         WaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935525; x=1774540325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL4iO08dWs+C8aSZinpn/MoY1WHh3mghfNCjZe9Ue8o=;
        b=rvogixWOyLJzT2mRnydbq4s5Lx35zwCNbYpajM2s5WcmBParXw7LigvwQFxCqgru3Q
         Q8IGld85ym7G5hBo8lJFMrt0fwk7DgOHefZmdSECswrG6D9s8W4W4gmVweNF5k/wIGCH
         zFMv2XdwQvTEbUpVvUkRec8L/lXci8ZDcZ0j5dE5thQ98AZ+ve9TtMoF6efi3xSdoPkY
         txYozwA+L5X0w+pVoGq1pPtzdTacvZQly1H3pOh5lXx7jPC0MVSRzWy06ARwDBv3ltg9
         H3/WC/7ITFQjL9y/jt/DwQRzXbdC/ECt/0j85WwpsIa6S6IZnMYX8bh6LI0Yyo2XYE21
         8fkg==
X-Gm-Message-State: AOJu0YzGDx8M/vuVrUefaJenDabtJCEjQqt8sRQ0c+noZdFgCDuTfILD
	J5i4nGjWObvAhXl8SgMSBUbxouOduEhXbIpDzIwrwjLYlCztO58r7ejJara0yw==
X-Gm-Gg: ATEYQzyBdEHG8YFepbR1IVc6Sb+NWgFhYxpOJbi1dJ4E6Mpy4D4NBKYuoCCvEpOS4EW
	Sha7MPAEoK9qyRVkvlS06CXvCYnU0PIQPYd3qToM/jWy5QzE0bE2QLlbfBKy5lpQkIiy0mG/dxz
	bUB4AeUQeW/HTPg0LIxsPwh6/ZknRUTMadUU5msuERPNQ/l0NXzFe9Hd7cljloF4tVfECD114I8
	wDP/X9zoQ7SdUXkhFV7uiabEBpYVup0SwuUsehbpw1rWrw8UeLR4qMvrYSNiCqqO+1k9PRPNr43
	Qf5Q5Plt7ATDd6g4CYlHjVYnyzDf1bZtQgUT/IrBsGYdS7u1jz068XNoyC9p5Y4QGGTFhU1iq96
	DHIuCABMBN8xupVwwfRnMvLeJbJeYWKPVdidUWFT1EyKPFa/Fo1HXDLulgOKhQoBAkwzI2cFzI3
	vmSJtdr6akWR0cBqvCNh0yh6PX1Cv+doR3f65Q0UdIqBCgrAxCZTPh1DbOrm4=
X-Received: by 2002:a05:6830:67d6:b0:7d7:4e62:58d2 with SMTP id 46e09a7af769-7d7ca574097mr4694610a34.7.1773935524649;
        Thu, 19 Mar 2026 08:52:04 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d7c9951092sm4672364a34.1.2026.03.19.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:52:04 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Jim Cromie <jim.cromie@gmail.com>,
	Gemini CLI <gemini-cli@google.com>
Subject: [PATCH 1/1] git-send-email.perl: support executable scripts for recipient options
Date: Thu, 19 Mar 2026 09:51:48 -0600
Message-ID: <20260319155148.1145135-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance git-send-email to recognize executable scripts passed to --to,
--cc, or --bcc. When a recipient argument is an executable file, run it
in a subshell and use its output as the recipient list.

This allows users to automate recipient selection using scripts like
get_maintainer.pl in the Linux kernel. The script is called with the
corresponding flag (--to, --cc, or --bcc) and all remaining command-line
arguments (typically the patches being sent).

Modify execute_cmd() to support multiple arguments safely using
quotemeta. Add test cases to verify the new functionality and ensure
arguments are correctly passed to the scripts.

Co-developed-by: Gemini CLI <gemini-cli@google.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 git-send-email.perl   | 11 +++++++++--
 t/t9001-send-email.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bb8ddd1eef..2d54d98304 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -579,8 +579,11 @@ sub config_regexp {
 
 # Munge any "either config or getopt, not both" variables
 my @initial_to = @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
+@initial_to = map { (-x $_) ? execute_cmd("to-script", $_, "--to", @ARGV) : $_ } @initial_to;
 my @initial_cc = @getopt_cc ? @getopt_cc : ($no_cc ? () : @config_cc);
+@initial_cc = map { (-x $_) ? execute_cmd("cc-script", $_, "--cc", @ARGV) : $_ } @initial_cc;
 my @initial_bcc = @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bcc);
+@initial_bcc = map { (-x $_) ? execute_cmd("bcc-script", $_, "--bcc", @ARGV) : $_ } @initial_bcc;
 
 usage() if $help;
 my %all_options = (%options, %dump_aliases_options, %identity_options);
@@ -2222,10 +2225,14 @@ sub initialize_modified_loop_vars {
 # lines which do not appear at the end of the output are reported as
 # errors.
 sub execute_cmd {
-	my ($prefix, $cmd, $file) = @_;
+	my ($prefix, $cmd, @args) = @_;
 	my @lines = ();
 	my $seen_blank_line = 0;
-	open my $fh, "-|", "$cmd \Q$file\E"
+	my $full_cmd = $cmd;
+	for my $arg (@args) {
+		$full_cmd .= " " . quotemeta($arg);
+	}
+	open my $fh, "-|", $full_cmd
 		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
 	while (my $line = <$fh>) {
 		die sprintf(__("(%s) Malformed output from '%s'"), $prefix, $cmd)
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 24f6c76aee..fed75c7669 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2842,4 +2842,46 @@ test_expect_success $PREREQ '--compose handles to headers' '
 	test_cmp expect msgtxt2.to
 '
 
+test_expect_success $PREREQ '--cc=$script' '
+	git init repo &&
+	(
+		cd repo &&
+		test_commit commit &&
+		patches=$(git format-patch -1 HEAD) &&
+		write_script cc-script <<-\EOT &&
+		echo "cc-script@example.com"
+		EOT
+		PERL5LIB="$GIT_BUILD_DIR/perl" "$GIT_BUILD_DIR/git-send-email.perl" \
+			--from="Example <from@example.com>" \
+			--to=nobody@example.com \
+			--cc=./cc-script \
+			--smtp-server="$(pwd)/../fake.sendmail" \
+			--confirm=never \
+			--dry-run \
+			$patches >stdout 2>&1 &&
+		grep "^Cc: cc-script@example\.com" stdout
+	)
+'
+
+test_expect_success $PREREQ '--cc=$script with arguments' '
+	git init repo-args &&
+	(
+		cd repo-args &&
+		test_commit commit &&
+		patches=$(git format-patch -1 HEAD) &&
+		write_script cc-script-args <<-\EOT &&
+		echo "script-args-$2@example.com"
+		EOT
+		PERL5LIB="$GIT_BUILD_DIR/perl" "$GIT_BUILD_DIR/git-send-email.perl" \
+			--from="Example <from@example.com>" \
+			--to=nobody@example.com \
+			--cc=./cc-script-args \
+			--smtp-server="$(pwd)/../fake.sendmail" \
+			--confirm=never \
+			--dry-run \
+			$patches >stdout 2>&1 &&
+		grep "^Cc: script-args-0001-commit\.patch@example\.com" stdout
+	)
+'
+
 test_done
-- 
2.53.0

