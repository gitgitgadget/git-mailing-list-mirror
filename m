Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A9B1F424
	for <e@80x24.org>; Wed,  9 May 2018 21:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965560AbeEIVmS (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 17:42:18 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:34007 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965505AbeEIVmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 17:42:16 -0400
Received: by mail-it0-f43.google.com with SMTP id c5-v6so17981796itj.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J64zd2wjOfLMnK6kfbRUZOWvQcL/sSEI8zKDOt1nJ98=;
        b=ANqj6zGr29qY7iBjc4vGCVmrquf/8lu1RxWox0fdEDuPocDdzq11RR+a6ucGVbogK3
         kxW0nlE7EuigW8FOYTtB7mrfrErfbLEq1zOibAUefUfF9Yvt3mvZ05UxfZ2mVkKWQpvE
         UN3rbOldiOihQkFOgSHLGQz3DUDrJrDuClCAiIYrKU6z1+kgDbooMiB66zuIPe7+9Q1s
         S1K6uaiiU6OZayNyb8iwEKu0rMYzdNA2F7QEkchqRHQtFbG0t4/EJi9ywm9opEXFECBp
         9ts93zH2jyEMjauL2YeUrkmOU3zNwTyk7GRBaDuRKCu1qeUgItxP8SYaG3OAVcgLneB2
         W0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J64zd2wjOfLMnK6kfbRUZOWvQcL/sSEI8zKDOt1nJ98=;
        b=uKwRsE56R4M5cqYQwlu7E1GMi43P5huzFP6eNDTyvThIKsAnMuQQddaoM9d83nII3f
         L6MXsOYpC6G+sdLNTk77dq1x3zaHWcMnALN1F07OLJTO7lV71B0KSWrOfGbUmITfpdax
         obQtFXLVqiXcBQbhznp9JVEXh7xOsLiWml4bhrG2OZGTN6yfuoLCTwXZlE5VFwkvTG8D
         Rr2/urtlBoE7UIziv/69a7gd6AFQUyHT+n/WU3UlbaMZtd1Znkq69eZqrn0X4aydWziB
         nQdEZIY1GptjX/q9OJrnREVYtIEAgLOGfdNjI14P4neq33w0giEtH6+zuYFHURHw2Wc3
         g1/A==
X-Gm-Message-State: ALKqPwfbydFbUVEpHzT0Aud7EHFIHVQg4Q2FvzWVo4L1AANkfe9O/+XZ
        ntK5+aKQLYIpeLK1w9WVox4=
X-Google-Smtp-Source: AB8JxZoXmJOUONqyxPDUY0Qg4gSgF6aQ40R9j4RHArjvGGuzvI/w4PSb4mr27qtcazdAGCsiFrfLFA==
X-Received: by 2002:a24:fe46:: with SMTP id w67-v6mr12655206ith.46.1525902135359;
        Wed, 09 May 2018 14:42:15 -0700 (PDT)
Received: from lmm-notebook.localdomain ([2607:fcc8:ab60:f900:a617:31ff:fe15:270b])
        by smtp.gmail.com with ESMTPSA id g62-v6sm4494733ioj.18.2018.05.09.14.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 14:42:14 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id 88F8F1600000001DAE4; Wed,  9 May 2018 17:39:09 -0400 (DST)
From:   Luis Marsano <luis.marsano@gmail.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 2/2] git-credential-netrc: accept gpg option
Date:   Wed,  9 May 2018 17:36:34 -0400
Message-Id: <20180509213634.5198-3-luis.marsano@gmail.com>
X-Mailer: git-send-email 2.17.0.584.g3d5ba9c85
In-Reply-To: <20180509213634.5198-1-luis.marsano@gmail.com>
References: <20180509213634.5198-1-luis.marsano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-credential-netrc was hardcoded to decrypt with 'gpg' regardless of the gpg.program option
this now uses the gpg command option if set, else, the gpg.program option set in the git repository or global configuration, else defaults to 'gpg'
for git-credential-netrc
- use Git.pm for repository and global option queries
- add -g|--gpg command option & document it in command usage
- test repository & command options
- support unicode

Signed-off-by: Luis Marsano <luis.marsano@gmail.com>
Acked-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/git-credential-netrc | 69 +++++++++++++------
 .../netrc/t-git-credential-netrc.sh           |  2 +-
 .../credential/netrc/test.command-option-gpg  |  2 +
 contrib/credential/netrc/test.git-config-gpg  |  2 +
 contrib/credential/netrc/test.netrc.gpg       |  0
 contrib/credential/netrc/test.pl              | 13 ++++
 6 files changed, 65 insertions(+), 23 deletions(-)
 create mode 100755 contrib/credential/netrc/test.command-option-gpg
 create mode 100755 contrib/credential/netrc/test.git-config-gpg
 create mode 100644 contrib/credential/netrc/test.netrc.gpg

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 1571a7b26..67cd689e8 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -2,11 +2,16 @@
 
 use strict;
 use warnings;
+use autodie;
+use utf8;
+use open ':encoding(UTF-8)';
+use feature qw(unicode_strings unicode_eval);
 
 use Getopt::Long;
 use File::Basename;
+use Git;
 
-my $VERSION = "0.1";
+my $VERSION = "0.2";
 
 my %options = (
 	       help => 0,
@@ -14,6 +19,7 @@ my %options = (
 	       verbose => 0,
 	       insecure => 0,
 	       file => [],
+	       gpg => '',
 
 	       # identical token maps, e.g. host -> host, will be inserted later
 	       tmap => {
@@ -54,6 +60,7 @@ GetOptions(\%options,
            "insecure|k",
            "verbose|v",
            "file|f=s@",
+           'gpg|g:s',
           );
 
 if ($options{help}) {
@@ -62,27 +69,31 @@ if ($options{help}) {
 
 	print <<EOHIPPUS;
 
-$0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] [-v] [-k] get
+$0 [(-f <authfile>)…] [-g <program>] [-d] [-v] [-k] get
 
 Version $VERSION by tzz\@lifelogs.com.  License: BSD.
 
 Options:
 
-  -f|--file AUTHFILE : specify netrc-style files.  Files with the .gpg extension
-                       will be decrypted by GPG before parsing.  Multiple -f
-                       arguments are OK.  They are processed in order, and the
-                       first matching entry found is returned via the credential
-                       helper protocol (see below).
+  -f|--file <authfile>: specify netrc-style files.  Files with the .gpg extension
+                        will be decrypted by GPG before parsing.  Multiple -f
+                        arguments are OK.  They are processed in order, and the
+                        first matching entry found is returned via the credential
+                        helper protocol (see below).
 
-                       When no -f option is given, .authinfo.gpg, .netrc.gpg,
-		       .authinfo, and .netrc files in your home directory are used
-		       in this order.
+                        When no -f option is given, .authinfo.gpg, .netrc.gpg,
+                        .authinfo, and .netrc files in your home directory are used
+                        in this order.
 
-  -k|--insecure      : ignore bad file ownership or permissions
+  -g|--gpg <program>  : specify the program for GPG. By default, this is the value
+                        of gpg.program in the git repository or global option or
+                        gpg.
 
-  -d|--debug         : turn on debugging (developer info)
+  -k|--insecure       : ignore bad file ownership or permissions
 
-  -v|--verbose       : be more verbose (show files and information found)
+  -d|--debug          : turn on debugging (developer info)
+
+  -v|--verbose        : be more verbose (show files and information found)
 
 To enable this credential helper:
 
@@ -91,15 +102,15 @@ To enable this credential helper:
 (Note that Git will prepend "git-credential-" to the helper name and look for it
 in the path.)
 
-...and if you want lots of debugging info:
+…and if you want lots of debugging info:
 
   git config credential.helper '$shortname -f AUTHFILE -d'
 
-...or to see the files opened and data found:
+…or to see the files opened and data found:
 
   git config credential.helper '$shortname -f AUTHFILE -v'
 
-Only "get" mode is supported by this credential helper.  It opens every AUTHFILE
+Only "get" mode is supported by this credential helper.  It opens every <authfile>
 and looks for the first entry that matches the requested search criteria:
 
  'port|protocol':
@@ -120,7 +131,7 @@ host=github.com
 protocol=https
 username=tzz
 
-this credential helper will look for the first entry in every AUTHFILE that
+this credential helper will look for the first entry in every <authfile> that
 matches
 
 machine github.com port https login tzz
@@ -129,7 +140,7 @@ OR
 
 machine github.com protocol https login tzz
 
-OR... etc. acceptable tokens as listed above.  Any unknown tokens are
+OR… etc. acceptable tokens as listed above.  Any unknown tokens are
 simply ignored.
 
 Then, the helper will print out whatever tokens it got from the entry, including
@@ -137,7 +148,7 @@ Then, the helper will print out whatever tokens it got from the entry, including
 back to "protocol".  Any redundant entry tokens (part of the original query) are
 skipped.
 
-Again, note that only the first matching entry from all the AUTHFILEs, processed
+Again, note that only the first matching entry from all the <authfile>s, processed
 in the sequence given on the command line, is used.
 
 Netrc/authinfo tokens can be quoted as 'STRING' or "STRING".
@@ -152,7 +163,7 @@ EOHIPPUS
 my $mode = shift @ARGV;
 
 # Credentials must get a parameter, so die if it's missing.
-die "Syntax: $0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] get" unless defined $mode;
+die "Syntax: $0 [(-f <authfile>)…] [-d] get" unless defined $mode;
 
 # Only support 'get' mode; with any other unsupported ones we just exit.
 exit 0 unless $mode eq 'get';
@@ -172,6 +183,8 @@ unless (scalar @$files) {
 	$files = $options{file} = [ map { glob $_ } @candidates ];
 }
 
+load_config(\%options);
+
 my $query = read_credential_data_from_stdin();
 
 FILE:
@@ -233,11 +246,11 @@ sub load_netrc {
 
 	my $io;
 	if ($gpgmode) {
-		my @cmd = (qw(gpg --decrypt), $file);
+		my @cmd = ($options{'gpg'}, qw(--decrypt), $file);
 		log_verbose("Using GPG to open $file: [@cmd]");
 		open $io, "-|", @cmd;
 	} else {
-		log_verbose("Opening $file...");
+		log_verbose("Opening ${file}…");
 		open $io, '<', $file;
 	}
 
@@ -410,6 +423,18 @@ sub print_credential_data {
 		printf "%s=%s\n", $git_token, $entry->{$git_token};
 	}
 }
+sub load_config {
+	# load settings from git config
+	my $options = shift;
+	if ($options->{'gpg'} eq '') {
+		local $_ = Git->repository()->config('gpg.program');
+		# default to gpg for non-0 exit code
+		$options->{'gpg'} = defined
+		                 ? $_
+		                 : 'gpg';
+	}
+	log_verbose("using $options{'gpg'} for GPG operations");
+}
 sub log_verbose {
 	return unless $options{verbose};
 	printf STDERR @_;
diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index fa21ca240..58191a62f 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -18,7 +18,7 @@
 
 	test_expect_success \
     'set up test repository' \
-    ':'
+    'git config --add gpg.program test.git-config-gpg'
 
 	# The external test will outputs its own plan
 	test_external_has_tap=1
diff --git a/contrib/credential/netrc/test.command-option-gpg b/contrib/credential/netrc/test.command-option-gpg
new file mode 100755
index 000000000..d8f1285d4
--- /dev/null
+++ b/contrib/credential/netrc/test.command-option-gpg
@@ -0,0 +1,2 @@
+#!/bin/sh
+echo machine command-option-gpg login username password password
diff --git a/contrib/credential/netrc/test.git-config-gpg b/contrib/credential/netrc/test.git-config-gpg
new file mode 100755
index 000000000..65cf594c2
--- /dev/null
+++ b/contrib/credential/netrc/test.git-config-gpg
@@ -0,0 +1,2 @@
+#!/bin/sh
+echo machine git-config-gpg login username password password
diff --git a/contrib/credential/netrc/test.netrc.gpg b/contrib/credential/netrc/test.netrc.gpg
new file mode 100644
index 000000000..e69de29bb
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 7211b4857..3ec8934ac 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -88,6 +88,19 @@ ok(scalar keys %$cred == 2, "Got 2 'host:port kills host' keys");
 is($cred->{password}, 'bobwillknow', "Got correct 'host:port kills host' password");
 is($cred->{username}, 'bob', "Got correct 'host:port kills host' username");
 
+diag 'Testing netrc file decryption by git config gpg.program setting\n';
+$cred = run_credential( ['-f', $netrcGpg, 'get']
+                      , { host => 'git-config-gpg' }
+                      );
+
+ok(scalar keys %$cred == 2, 'Got keys decrypted by git config option');
+
+diag 'Testing netrc file decryption by gpg option\n';
+$cred = run_credential( ['-f', $netrcGpg, '-g', 'test.command-option-gpg', 'get']
+                      , { host => 'command-option-gpg' }
+                      );
+
+ok(scalar keys %$cred == 2, 'Got keys decrypted by command option');
 
 sub run_credential
 {
-- 
2.17.0

