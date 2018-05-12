Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B671F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeELJ0Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:26:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36116 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeELJ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:26:22 -0400
Received: by mail-io0-f194.google.com with SMTP id d73-v6so9768440iog.3
        for <git@vger.kernel.org>; Sat, 12 May 2018 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mENM04/kKxAnWL8MsDcQSyZJg/lPe/qbPipHmJYr3Ug=;
        b=a/JRHamIdjnKjQpGZdzvvwGpeSPu9GLcXSDjjxVR3ayC855llV3L6DsbDhgg17pE7m
         mcufIzMvnFfS7ht+eBh8SUXUqmF0swav0zTZlMnrXw6i3NcVvjsepTmw+1RRB/VydXgh
         ob4/qgpt5F7AJZDbyrqh8d80n1kgJObdaWoaLhgSPOrS3TEOBT1CUIhP/e5TqBTX6d6f
         J3vO3xhgHgEyZBLxf2jycf7E5Y9WlZnF1PL/l0ge48wUSLVX6sbwx0rSZaR3Cx8JKJKi
         XkTz+xvEB9h/1I0NyZ6qCOS1tideGa/lSk7dTSPBttpkeDJo6hPtqGQSJcNiWWCRvlOu
         G/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mENM04/kKxAnWL8MsDcQSyZJg/lPe/qbPipHmJYr3Ug=;
        b=RB+Siwlo77e2ZIqf8x6N9pRPfsJJUDr2VZTyI5Dn4T6Tr/GTZVU0YotA3auq4Zq3o3
         f/gDLX6/L6KanRrgCrFvgwOV7pj+eSytbb1aloDagEAgpcBHrD7l1BcApsmaxFGFVy2T
         RacVqMV7+F4Qb+VTGYzOGetT2FxX8J6fTkkzfO9FjuOwXK0psfphv5idtVUE79TGl2Qm
         5J3hFjOF6NtX7UOSYWN6p7x/ThSl3o2Y+uQMeARHeljK552eRu5XAybkK/iVjd7MCTkn
         4lQdX3s0UW7VJXhfVaB3VQE3Fph76uPpzSufZYAxdDUncB9b4atnwpo0aI73w2ZFk5qG
         y35g==
X-Gm-Message-State: ALKqPwdP1+cinAtb5iDENXbjtOKKAI3Y9Q9s+glIUTNXP+CbvTfgyalH
        xQMfzBYuRrkuw/SC4nxWIqE=
X-Google-Smtp-Source: AB8JxZpdbd1lQydTdZoKpPI0jWec71E7PPDjr3OT+4y7waAqmaSUS51X6Jxue6NmNxl53B3yCguioA==
X-Received: by 2002:a6b:900b:: with SMTP id s11-v6mr2003908iod.223.1526117181262;
        Sat, 12 May 2018 02:26:21 -0700 (PDT)
Received: from lmm-notebook.localdomain ([2607:fcc8:ab60:f900:a617:31ff:fe15:270b])
        by smtp.gmail.com with ESMTPSA id j37-v6sm2479723ioo.41.2018.05.12.02.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 02:26:20 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id 3E1D418000000000C12D; Sat, 12 May 2018 05:17:44 -0400 (DST)
From:   Luis Marsano <luis.marsano@gmail.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH v2 2/2] git-credential-netrc: accept gpg option
Date:   Sat, 12 May 2018 05:17:28 -0400
Message-Id: <20180512091728.4931-3-luis.marsano@gmail.com>
X-Mailer: git-send-email 2.17.0.584.g3d5ba9c85
In-Reply-To: <20180512091728.4931-1-luis.marsano@gmail.com>
References: <20180509213634.5198-1-luis.marsano@gmail.com>
 <20180512091728.4931-1-luis.marsano@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-credential-netrc was hardcoded to decrypt with 'gpg' regardless of
the gpg.program option. This is a problem on distributions like Debian
that call modern GnuPG something else, like 'gpg2'.
Set the command according to these settings in descending precedence
1. the git-credential-netrc command -g|--gpg option
2. the git gpg.program configuration option
3. the default: 'gpg'

For conformance with Documentation/CodingGuidelines
- use Git.pm for repository and global option queries
- document -g|--gpg command option in command usage
- test repository & command options
- write documentation placeholders according to main standards

Signed-off-by: Luis Marsano <luis.marsano@gmail.com>
Acked-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/git-credential-netrc | 58 ++++++++++++-------
 .../netrc/t-git-credential-netrc.sh           |  2 +-
 .../credential/netrc/test.command-option-gpg  |  2 +
 contrib/credential/netrc/test.git-config-gpg  |  2 +
 contrib/credential/netrc/test.netrc.gpg       |  0
 contrib/credential/netrc/test.pl              | 22 ++++++-
 6 files changed, 62 insertions(+), 24 deletions(-)
 create mode 100755 contrib/credential/netrc/test.command-option-gpg
 create mode 100755 contrib/credential/netrc/test.git-config-gpg
 create mode 100644 contrib/credential/netrc/test.netrc.gpg

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 1571a7b26..0b9a94102 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -2,11 +2,13 @@
 
 use strict;
 use warnings;
+use autodie;
 
 use Getopt::Long;
 use File::Basename;
+use Git;
 
-my $VERSION = "0.1";
+my $VERSION = "0.2";
 
 my %options = (
 	       help => 0,
@@ -54,6 +56,7 @@ GetOptions(\%options,
            "insecure|k",
            "verbose|v",
            "file|f=s@",
+           'gpg|g:s',
           );
 
 if ($options{help}) {
@@ -62,27 +65,31 @@ if ($options{help}) {
 
 	print <<EOHIPPUS;
 
-$0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] [-v] [-k] get
+$0 [(-f <authfile>)...] [-g <program>] [-d] [-v] [-k] get
 
 Version $VERSION by tzz\@lifelogs.com.  License: BSD.
 
 Options:
 
-  -f|--file AUTHFILE : specify netrc-style files.  Files with the .gpg extension
-                       will be decrypted by GPG before parsing.  Multiple -f
-                       arguments are OK.  They are processed in order, and the
-                       first matching entry found is returned via the credential
-                       helper protocol (see below).
+  -f|--file <authfile>: specify netrc-style files.  Files with the .gpg
+                        extension will be decrypted by GPG before parsing.
+                        Multiple -f arguments are OK.  They are processed in
+                        order, and the first matching entry found is returned
+                        via the credential helper protocol (see below).
 
-                       When no -f option is given, .authinfo.gpg, .netrc.gpg,
-		       .authinfo, and .netrc files in your home directory are used
-		       in this order.
+                        When no -f option is given, .authinfo.gpg, .netrc.gpg,
+                        .authinfo, and .netrc files in your home directory are
+                        used in this order.
 
-  -k|--insecure      : ignore bad file ownership or permissions
+  -g|--gpg <program>  : specify the program for GPG. By default, this is the
+                        value of gpg.program in the git repository or global
+                        option or gpg.
 
-  -d|--debug         : turn on debugging (developer info)
+  -k|--insecure       : ignore bad file ownership or permissions
 
-  -v|--verbose       : be more verbose (show files and information found)
+  -d|--debug          : turn on debugging (developer info)
+
+  -v|--verbose        : be more verbose (show files and information found)
 
 To enable this credential helper:
 
@@ -99,8 +106,9 @@ in the path.)
 
   git config credential.helper '$shortname -f AUTHFILE -v'
 
-Only "get" mode is supported by this credential helper.  It opens every AUTHFILE
-and looks for the first entry that matches the requested search criteria:
+Only "get" mode is supported by this credential helper.  It opens every
+<authfile> and looks for the first entry that matches the requested search
+criteria:
 
  'port|protocol':
    The protocol that will be used (e.g., https). (protocol=X)
@@ -120,7 +128,7 @@ host=github.com
 protocol=https
 username=tzz
 
-this credential helper will look for the first entry in every AUTHFILE that
+this credential helper will look for the first entry in every <authfile> that
 matches
 
 machine github.com port https login tzz
@@ -137,8 +145,8 @@ Then, the helper will print out whatever tokens it got from the entry, including
 back to "protocol".  Any redundant entry tokens (part of the original query) are
 skipped.
 
-Again, note that only the first matching entry from all the AUTHFILEs, processed
-in the sequence given on the command line, is used.
+Again, note that only the first matching entry from all the <authfile>s,
+processed in the sequence given on the command line, is used.
 
 Netrc/authinfo tokens can be quoted as 'STRING' or "STRING".
 
@@ -152,7 +160,7 @@ EOHIPPUS
 my $mode = shift @ARGV;
 
 # Credentials must get a parameter, so die if it's missing.
-die "Syntax: $0 [-f AUTHFILE1] [-f AUTHFILEN] [-d] get" unless defined $mode;
+die "Syntax: $0 [(-f <authfile>)...] [-d] get" unless defined $mode;
 
 # Only support 'get' mode; with any other unsupported ones we just exit.
 exit 0 unless $mode eq 'get';
@@ -172,6 +180,8 @@ unless (scalar @$files) {
 	$files = $options{file} = [ map { glob $_ } @candidates ];
 }
 
+load_config(\%options);
+
 my $query = read_credential_data_from_stdin();
 
 FILE:
@@ -233,7 +243,7 @@ sub load_netrc {
 
 	my $io;
 	if ($gpgmode) {
-		my @cmd = (qw(gpg --decrypt), $file);
+		my @cmd = ($options{'gpg'}, qw(--decrypt), $file);
 		log_verbose("Using GPG to open $file: [@cmd]");
 		open $io, "-|", @cmd;
 	} else {
@@ -410,6 +420,14 @@ sub print_credential_data {
 		printf "%s=%s\n", $git_token, $entry->{$git_token};
 	}
 }
+sub load_config {
+	# load settings from git config
+	my $options = shift;
+	# set from command argument, gpg.program option, or default to gpg
+	$options->{'gpg'} //= Git->repository()->config('gpg.program')
+	                  // 'gpg';
+	log_verbose("using $options{'gpg'} for GPG operations");
+}
 sub log_verbose {
 	return unless $options{verbose};
 	printf STDERR @_;
diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index efb81efed..58191a62f 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -18,7 +18,7 @@
 
 	test_expect_success \
     'set up test repository' \
-    :
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
index ea95a2c8a..1e1001030 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -9,15 +9,18 @@ use File::Spec::Functions qw(:DEFAULT rel2abs);
 use IPC::Open2;
 
 BEGIN {
-	# t-git-credential-netrc.sh kicks off our testing, so we have to go from there.
+	# t-git-credential-netrc.sh kicks off our testing, so we have to go
+	# from there.
 	Test::More->builder->current_test(1);
 	Test::More->builder->no_ending(1);
 }
 
 my @global_credential_args = @ARGV;
 my $scriptDir = dirname rel2abs $0;
-my $netrc = catfile $scriptDir, 'test.netrc';
-my $gcNetrc = catfile $scriptDir, 'git-credential-netrc';
+my ($netrc, $netrcGpg, $gcNetrc) = map { catfile $scriptDir, $_; }
+                                       qw(test.netrc
+                                          test.netrc.gpg
+                                          git-credential-netrc);
 local $ENV{PATH} = join ':'
                       , $scriptDir
                       , $ENV{PATH}
@@ -87,6 +90,19 @@ ok(scalar keys %$cred == 2, "Got 2 'host:port kills host' keys");
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

