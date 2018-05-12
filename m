Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0CA1F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeELJ02 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:26:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55943 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeELJ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:26:22 -0400
Received: by mail-it0-f68.google.com with SMTP id 144-v6so4784398iti.5
        for <git@vger.kernel.org>; Sat, 12 May 2018 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5gbZbAu040Cw5psD1uPHJZfrT+f++wGz3tyI3WEWUjY=;
        b=YJeUk3az34QKGAsVhXgZMMfRw1zhILAWworBe3CXJ2m+K9fYYt5g/5QW42SSFl2EGS
         YLOfjLyalW+RdhytjGYUPat8ENoFXQmXLgK6YNPooTgxD74G2gca0ilIfE6/m9MH22Fe
         o8LmVNZeI57SO8OOgmeEgMBRgt+BnkI1I6xiiJaUkBc5usmXqeKMvTSOM1f3j3ojjd9f
         i2bZJMZF90mrxCt770J9lTkT+3u6nNRRaid70hkjoGA2ycPgatbWaMlOeL9pi4jrgOiv
         ynW8epdCERGJCsjc3cPLNBKmNYXMIgW6WG/F/sALwWTOEzDuP5Z8cdh/WSrVvkgysXLK
         45JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5gbZbAu040Cw5psD1uPHJZfrT+f++wGz3tyI3WEWUjY=;
        b=Syrh+upEp2AUFp9nbZ3wclTnwdVt/2Yc7MV9s8RrM8uwQ1mYgyQQCshQFvpbBVEdDj
         tpKlP3VQNI3WyN5svEHhSE+drI9xIGNSQ+U9WaAKdP7lF7TzoBPZyVb8avYrj8+DiS2W
         YFq9UfctPySWBriQBxMISSELHiFMuEnHxgqyoJ/JfCSNr1G6QMQ9Sw5tcKsxCAd1VnJa
         wO88O7HR1+5Bpn+Gictc25MDEh8J5OqMV6qdLjyJHCianD0lmlltIvReIYGQAyZqWAV6
         l/C2X26613S7NaNcH/QeYeUHIR2HQlUegH+OAZziWwEYoTp4LBvkDwwLUybZm3m5oMVo
         7VYw==
X-Gm-Message-State: ALKqPwe59DLMrv4a8HnWRSgK00lNVnLW0QIuqWr1gwAMVZFJ+2dh+yTl
        Fzlmu674BmanJ3+5DiT5K8g=
X-Google-Smtp-Source: AB8JxZr6PZBMfSEmO2V4bZIBM2v6/OV9q8dJ2nYuvoSfisqyHaQ4I+jP0h3m9L21ZR5+8I+dN1xHmQ==
X-Received: by 2002:a24:d947:: with SMTP id p68-v6mr1409851itg.74.1526117181916;
        Sat, 12 May 2018 02:26:21 -0700 (PDT)
Received: from lmm-notebook.localdomain (cpe-74-139-249-65.kya.res.rr.com. [74.139.249.65])
        by smtp.gmail.com with ESMTPSA id y25-v6sm2303627ioa.83.2018.05.12.02.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 02:26:20 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id 8C0E9DD000000012A7E; Sat, 12 May 2018 05:17:43 -0400 (DST)
From:   Luis Marsano <luis.marsano@gmail.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH v2 1/2] git-credential-netrc: adapt to test framework for git
Date:   Sat, 12 May 2018 05:17:27 -0400
Message-Id: <20180512091728.4931-2-luis.marsano@gmail.com>
X-Mailer: git-send-email 2.17.0.584.g3d5ba9c85
In-Reply-To: <20180512091728.4931-1-luis.marsano@gmail.com>
References: <20180509213634.5198-1-luis.marsano@gmail.com>
 <20180512091728.4931-1-luis.marsano@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-credential-netrc tests did not run in a test repository.
Reuse the main test framework to stage a temporary repository.
To imitate Perl tests under t/
- switch to Test::More module
- use File::Basename & File::Spec::Functions

Signed-off-by: Luis Marsano <luis.marsano@gmail.com>
Acked-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/Makefile             |  4 +-
 .../netrc/t-git-credential-netrc.sh           | 31 ++++++++
 contrib/credential/netrc/test.pl              | 72 +++++++++++--------
 3 files changed, 77 insertions(+), 30 deletions(-)
 create mode 100755 contrib/credential/netrc/t-git-credential-netrc.sh

diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/netrc/Makefile
index 51b76138a..0ffa40719 100644
--- a/contrib/credential/netrc/Makefile
+++ b/contrib/credential/netrc/Makefile
@@ -1,5 +1,5 @@
 test:
-	./test.pl
+	./t-git-credential-netrc.sh
 
 testverbose:
-	./test.pl -d -v
+	./t-git-credential-netrc.sh -d -v
diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
new file mode 100755
index 000000000..efb81efed
--- /dev/null
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+(
+	cd ../../../t
+	test_description='git-credential-netrc'
+	. ./test-lib.sh
+
+	if ! test_have_prereq PERL; then
+		skip_all='skipping perl interface tests, perl not available'
+		test_done
+	fi
+
+	perl -MTest::More -e 0 2>/dev/null || {
+		skip_all="Perl Test::More unavailable, skipping test"
+		test_done
+	}
+
+	# set up test repository
+
+	test_expect_success \
+    'set up test repository' \
+    :
+
+	# The external test will outputs its own plan
+	test_external_has_tap=1
+
+	test_external \
+    'git-credential-netrc' \
+    perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
+
+	test_done
+)
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 169b6463c..ea95a2c8a 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -1,83 +1,99 @@
 #!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
 
 use warnings;
 use strict;
-use Test;
+use Test::More qw(no_plan);
+use File::Basename;
+use File::Spec::Functions qw(:DEFAULT rel2abs);
 use IPC::Open2;
 
-BEGIN { plan tests => 15 }
+BEGIN {
+	# t-git-credential-netrc.sh kicks off our testing, so we have to go from there.
+	Test::More->builder->current_test(1);
+	Test::More->builder->no_ending(1);
+}
 
 my @global_credential_args = @ARGV;
-my $netrc = './test.netrc';
-print "# Testing insecure file, nothing should be found\n";
+my $scriptDir = dirname rel2abs $0;
+my $netrc = catfile $scriptDir, 'test.netrc';
+my $gcNetrc = catfile $scriptDir, 'git-credential-netrc';
+local $ENV{PATH} = join ':'
+                      , $scriptDir
+                      , $ENV{PATH}
+                      ? $ENV{PATH}
+                      : ();
+
+diag "Testing insecure file, nothing should be found\n";
 chmod 0644, $netrc;
 my $cred = run_credential(['-f', $netrc, 'get'],
 			  { host => 'github.com' });
 
-ok(scalar keys %$cred, 0, "Got 0 keys from insecure file");
+ok(scalar keys %$cred == 0, "Got 0 keys from insecure file");
 
-print "# Testing missing file, nothing should be found\n";
+diag "Testing missing file, nothing should be found\n";
 chmod 0644, $netrc;
 $cred = run_credential(['-f', '///nosuchfile///', 'get'],
 		       { host => 'github.com' });
 
-ok(scalar keys %$cred, 0, "Got 0 keys from missing file");
+ok(scalar keys %$cred == 0, "Got 0 keys from missing file");
 
 chmod 0600, $netrc;
 
-print "# Testing with invalid data\n";
+diag "Testing with invalid data\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       "bad data");
-ok(scalar keys %$cred, 4, "Got first found keys with bad data");
+ok(scalar keys %$cred == 4, "Got first found keys with bad data");
 
-print "# Testing netrc file for a missing corovamilkbar entry\n";
+diag "Testing netrc file for a missing corovamilkbar entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'corovamilkbar' });
 
-ok(scalar keys %$cred, 0, "Got no corovamilkbar keys");
+ok(scalar keys %$cred == 0, "Got no corovamilkbar keys");
 
-print "# Testing netrc file for a github.com entry\n";
+diag "Testing netrc file for a github.com entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'github.com' });
 
-ok(scalar keys %$cred, 2, "Got 2 Github keys");
+ok(scalar keys %$cred == 2, "Got 2 Github keys");
 
-ok($cred->{password}, 'carolknows', "Got correct Github password");
-ok($cred->{username}, 'carol', "Got correct Github username");
+is($cred->{password}, 'carolknows', "Got correct Github password");
+is($cred->{username}, 'carol', "Got correct Github username");
 
-print "# Testing netrc file for a username-specific entry\n";
+diag "Testing netrc file for a username-specific entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'imap', username => 'bob' });
 
-ok(scalar keys %$cred, 2, "Got 2 username-specific keys");
+ok(scalar keys %$cred == 2, "Got 2 username-specific keys");
 
-ok($cred->{password}, 'bobwillknow', "Got correct user-specific password");
-ok($cred->{protocol}, 'imaps', "Got correct user-specific protocol");
+is($cred->{password}, 'bobwillknow', "Got correct user-specific password");
+is($cred->{protocol}, 'imaps', "Got correct user-specific protocol");
 
-print "# Testing netrc file for a host:port-specific entry\n";
+diag "Testing netrc file for a host:port-specific entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'imap2:1099' });
 
-ok(scalar keys %$cred, 2, "Got 2 host:port-specific keys");
+ok(scalar keys %$cred == 2, "Got 2 host:port-specific keys");
 
-ok($cred->{password}, 'tzzknow', "Got correct host:port-specific password");
-ok($cred->{username}, 'tzz', "Got correct host:port-specific username");
+is($cred->{password}, 'tzzknow', "Got correct host:port-specific password");
+is($cred->{username}, 'tzz', "Got correct host:port-specific username");
 
-print "# Testing netrc file that 'host:port kills host' entry\n";
+diag "Testing netrc file that 'host:port kills host' entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'imap2' });
 
-ok(scalar keys %$cred, 2, "Got 2 'host:port kills host' keys");
+ok(scalar keys %$cred == 2, "Got 2 'host:port kills host' keys");
+
+is($cred->{password}, 'bobwillknow', "Got correct 'host:port kills host' password");
+is($cred->{username}, 'bob', "Got correct 'host:port kills host' username");
 
-ok($cred->{password}, 'bobwillknow', "Got correct 'host:port kills host' password");
-ok($cred->{username}, 'bob', "Got correct 'host:port kills host' username");
 
 sub run_credential
 {
 	my $args = shift @_;
 	my $data = shift @_;
 	my $pid = open2(my $chld_out, my $chld_in,
-			'./git-credential-netrc', @global_credential_args,
+			$gcNetrc, @global_credential_args,
 			@$args);
 
 	die "Couldn't open pipe to netrc credential helper: $!" unless $pid;
-- 
2.17.0

