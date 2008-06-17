From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 2/2 v4] Git.pm: add test suite
Date: Tue, 17 Jun 2008 08:59:51 +0200
Message-ID: <4db23d5b625de1aa026cf4630d49b57fd3a09d07.1213685306.git.LeWiemann@gmail.com>
References: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 09:01:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8VBe-0007T3-VX
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbYFQHAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 03:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYFQG77
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 02:59:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:2056 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYFQG7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 02:59:55 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3717360fkq.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :from;
        bh=XNy6atrI99o9a8iEpLuZPjx1HivfeIiSY3odpx3p2ZY=;
        b=ATVsQl8HZBsho0QqGxnWixPI1L+zQv1KK+2uWX+C68AZV8gqrtHA0QBUpqJUvRZqgA
         iFn0Wja7mWs3i5vDjjsffKuezJiHQvaKHImsVKxSodCyNO7jETKpndtwhYa1CwXhUFdP
         x4Jh5QDwdQ9Q1b/u6BEPpmxslkovFb6X7XJBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=KKZuYi24hmWq1vokR86AV6IwQO18ldzw4JdERcws4VXu1C9ZIOh19hpNqUCltLXDmd
         cq0aj6OL7jrGCAkDW95mJTEqJ6/nAZ++QdZJBLlogJSp56jqpNiEpKWTmWoXWIdCqDDc
         1VyAMkpQAs7T3FJLPQ8bxo1fjIqa6WxF0VzbA=
Received: by 10.78.133.2 with SMTP id g2mr2924373hud.70.1213685993784;
        Mon, 16 Jun 2008 23:59:53 -0700 (PDT)
Received: from fly ( [91.33.200.72])
        by mx.google.com with ESMTPS id 3sm4555795hud.45.2008.06.16.23.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 23:59:52 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8VAW-0004P8-56; Tue, 17 Jun 2008 08:59:52 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
In-Reply-To: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
In-Reply-To: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
References: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85267>

Add a shell script (t/t9700-perl-git.sh) that sets up a git repository
and a perl script (t/t9700/test.pl) that runs the actual tests.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changed since v3
<http://thread.gmane.org/gmane.comp.version-control.git/83425/focus=83480>:
Only test the vanilla Git.pm, as I'm not intending to extend it right
now.  So no Git::get_hash (or Git::rev_parse) method there.

I also simplified the test repository setup code a bit.

 t/t9700-perl-git.sh |   39 ++++++++++++++++++++
 t/t9700/test.pl     |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 0 deletions(-)
 create mode 100755 t/t9700-perl-git.sh
 create mode 100755 t/t9700/test.pl

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
new file mode 100755
index 0000000..592d79a
--- /dev/null
+++ b/t/t9700-perl-git.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Lea Wiemann
+#
+
+test_description='perl interface (Git.pm)'
+. ./test-lib.sh
+
+# set up test repository
+
+test_expect_success \
+    'set up test repository' \
+    'echo "test file 1" > file1 &&
+     echo "test file 2" > file2 &&
+     mkdir directory1 &&
+     echo "in directory1" >> directory1/file &&
+     mkdir directory2 &&
+     echo "in directory2" >> directory2/file &&
+     git add . &&
+     git commit -m "first commit" &&
+
+     echo "changed file 1" > file1 &&
+     git commit -a -m "second commit" &&
+
+     git-config --add color.test.slot1 green &&
+     git-config --add test.string value &&
+     git-config --add test.dupstring value1 &&
+     git-config --add test.dupstring value2 &
+     git-config --add test.booltrue true &&
+     git-config --add test.boolfalse no &&
+     git-config --add test.boolother other &&
+     git-config --add test.int 2k
+     '
+
+test_external_without_stderr \
+    'Perl API' \
+    perl ../t9700/test.pl
+
+test_done
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
new file mode 100755
index 0000000..8318fec
--- /dev/null
+++ b/t/t9700/test.pl
@@ -0,0 +1,99 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More qw(no_plan);
+
+use Cwd;
+use File::Basename;
+use File::Temp;
+use IO::String;
+
+BEGIN { use_ok('Git') }
+
+# set up
+our $repo_dir = "trash directory";
+our $abs_repo_dir = Cwd->cwd;
+die "this must be run by calling the t/t97* shell script(s)\n"
+    if basename(Cwd->cwd) ne $repo_dir;
+ok(our $r = Git->repository(Directory => "."), "open repository");
+
+# config
+is($r->config("test.string"), "value", "config scalar: string");
+is_deeply([$r->config("test.dupstring")], ["value1", "value2"],
+	  "config array: string");
+is($r->config("test.nonexistent"), undef, "config scalar: nonexistent");
+is_deeply([$r->config("test.nonexistent")], [], "config array: nonexistent");
+is($r->config_int("test.int"), 2048, "config_int: integer");
+is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
+ok($r->config_bool("test.booltrue"), "config_bool: true");
+ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
+our $ansi_green = "\x1b[32m";
+is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
+# Cannot test $r->get_colorbool("color.foo")) because we do not
+# control whether our STDOUT is a terminal.
+
+# Failure cases for config:
+# Save and restore STDERR; we will probably extract this into a
+# "dies_ok" method and possibly move the STDERR handling to Git.pm.
+open our $tmpstderr, ">&", STDERR or die "cannot save STDERR"; close STDERR;
+eval { $r->config("test.dupstring") };
+ok($@, "config: duplicate entry in scalar context fails");
+eval { $r->config_bool("test.boolother") };
+ok($@, "config_bool: non-boolean values fail");
+open STDERR, ">&", $tmpstderr or die "cannot restore STDERR";
+
+# ident
+like($r->ident("aUthor"), qr/^A U Thor <author\@example.com> [0-9]+ \+0000$/,
+     "ident scalar: author (type)");
+like($r->ident("cOmmitter"), qr/^C O Mitter <committer\@example.com> [0-9]+ \+0000$/,
+     "ident scalar: committer (type)");
+is($r->ident("invalid"), "invalid", "ident scalar: invalid ident string (no parsing)");
+my ($name, $email, $time_tz) = $r->ident('author');
+is_deeply([$name, $email], ["A U Thor", "author\@example.com"],
+	 "ident array: author");
+like($time_tz, qr/[0-9]+ \+0000/, "ident array: author");
+is_deeply([$r->ident("Name <email> 123 +0000")], ["Name", "email", "123 +0000"],
+	  "ident array: ident string");
+is_deeply([$r->ident("invalid")], [], "ident array: invalid ident string");
+
+# ident_person
+is($r->ident_person("aUthor"), "A U Thor <author\@example.com>",
+   "ident_person: author (type)");
+is($r->ident_person("Name <email> 123 +0000"), "Name <email>",
+   "ident_person: ident string");
+is($r->ident_person("Name", "email", "123 +0000"), "Name <email>",
+   "ident_person: array");
+
+# objects and hashes
+ok(our $file1hash = $r->command_oneline('rev-parse', "HEAD:file1"), "(get file hash)");
+our $iostring = IO::String->new;
+is($r->cat_blob($file1hash, $iostring), 15, "cat_blob: size");
+is(${$iostring->string_ref}, "changed file 1\n", "cat_blob: data");
+our $tmpfile = File::Temp->new();
+print $tmpfile ${$iostring->string_ref};
+is(Git::hash_object("blob", $tmpfile), $file1hash, "hash_object: roundtrip");
+$tmpfile = File::Temp->new();
+print $tmpfile my $test_text = "test blob, to be inserted\n";
+$tmpfile->close;
+like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
+     "hash_and_insert_object: returns hash");
+$iostring = IO::String->new;
+is($r->cat_blob($newhash, $iostring), length $test_text, "cat_blob: roundtrip size");
+is(${$iostring->string_ref}, $test_text, "cat_blob: roundtrip data");
+
+# paths
+is($r->repo_path, "./.git", "repo_path");
+is($r->wc_path, $abs_repo_dir . "/", "wc_path");
+is($r->wc_subdir, "", "wc_subdir initial");
+$r->wc_chdir("directory1");
+is($r->wc_subdir, "directory1", "wc_subdir after wc_chdir");
+TODO: {
+	local $TODO = "commands do not work after wc_chdir";
+	# Failure output is active even in non-verbose mode and thus
+	# annoying.  Hence we skip these tests as long as they fail.
+	todo_skip 'config after wc_chdir', 1;
+	is($r->config("color.string"), "value", "config after wc_chdir");
+}
-- 
1.5.6.rc3.7.ged9620
