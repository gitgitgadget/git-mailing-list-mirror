From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 2/2 v5] Git.pm: add test suite
Date: Thu, 19 Jun 2008 22:32:49 +0200
Message-ID: <1213907569-6393-1-git-send-email-LeWiemann@gmail.com>
References: <1244a3347b6f15120e57f6b9223a4e2db06479df.1213899000.git.LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 22:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Qp4-0006de-DJ
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 22:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbYFSUcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 16:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYFSUcV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 16:32:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:35758 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYFSUcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 16:32:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so482719fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=JJE/kkumrJnBoG1uD33R7IDz3gTnMjxwuUoMKMGu8Ik=;
        b=PErnvAUYo6vESB6Qh7+Jqygwb/nohWIjCY6np6Fo2sCH3u24BI8nsSgt9LP8SXti3L
         QiMYHydl33StpQL/TOzV7rev4ZT8kc+6VjfrIda+3XjGe1os4F0kQaIksN08efvQb5Th
         q6Xz+ap4f4nx3OONPFMhVSy7Lg70nsbSr27Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=CTh9ZguNHH6mL8nRsDW0rNJ3Fm5sLdGVZVqDyXN+TQB2GNTVMOkyX0YSInWIyrn9QG
         KWe/0/xLseWVfRDYeML+obqg1E2AUt/FgmJemPk0+Wlr1sBOKXsZgYoWtjLdVeOiQ+WA
         Bnk0xRfD6/xWvk6oAPOyvYS/ftmUAqRO3j5yg=
Received: by 10.86.98.14 with SMTP id v14mr2661533fgb.74.1213907538314;
        Thu, 19 Jun 2008 13:32:18 -0700 (PDT)
Received: from fly ( [91.33.204.94])
        by mx.google.com with ESMTPS id 4sm1714186fge.5.2008.06.19.13.32.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 13:32:17 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K9QoL-0001fU-Tu; Thu, 19 Jun 2008 22:32:49 +0200
X-Mailer: git-send-email 1.5.6.149.g06c04.dirty
In-Reply-To: <1244a3347b6f15120e57f6b9223a4e2db06479df.1213899000.git.LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85524>

Add a shell script (t/t9700-perl-git.sh) that sets up a git repository
and a perl script (t/t9700/test.pl) that runs the actual tests.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
[Resent with fixed diff to v4 so git-am doesn't get confused. ;-)]

Changes since v4:

- Added missing ampersand (thanks Olivier!).
- Use 5.006002 (lowest possible version for Test::More).
- Use File::Temp instead of the external IO::String.

Tested with Perl 5.6, 5.8, 5.10.  Diff against v4 of this patch:

    index 592d79a..b2fb9ec 100755
    --- a/t/t9700-perl-git.sh
    +++ b/t/t9700-perl-git.sh
    @@ -25,7 +25,7 @@ test_expect_success \
          git-config --add color.test.slot1 green &&
          git-config --add test.string value &&
          git-config --add test.dupstring value1 &&
    -     git-config --add test.dupstring value2 &
    +     git-config --add test.dupstring value2 &&
          git-config --add test.booltrue true &&
          git-config --add test.boolfalse no &&
          git-config --add test.boolother other &&
    diff --git a/t/t9700/test.pl b/t/t9700/test.pl
    index 8318fec..4d23125 100755
    --- a/t/t9700/test.pl
    +++ b/t/t9700/test.pl
    @@ -1,6 +1,7 @@
     #!/usr/bin/perl
     use lib (split(/:/, $ENV{GITPERLLIB}));

    +use 5.006002;  # Test::More was introduced in 5.6.2
     use warnings;
     use strict;

    @@ -9,7 +10,6 @@ use Test::More qw(no_plan);
     use Cwd;
     use File::Basename;
     use File::Temp;
    -use IO::String;

     BEGIN { use_ok('Git') }

    @@ -69,20 +69,21 @@ is($r->ident_person("Name", "email", "123 +0000"), "Name <email>",

     # objects and hashes
     ok(our $file1hash = $r->command_oneline('rev-parse', "HEAD:file1"), "(get file hash)");
    -our $iostring = IO::String->new;
    -is($r->cat_blob($file1hash, $iostring), 15, "cat_blob: size");
    -is(${$iostring->string_ref}, "changed file 1\n", "cat_blob: data");
    -our $tmpfile = File::Temp->new();
    -print $tmpfile ${$iostring->string_ref};
    +our $tmpfile = File::Temp->new;
    +is($r->cat_blob($file1hash, $tmpfile), 15, "cat_blob: size");
    +our $blobcontents;
    +{ local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
    +is($blobcontents, "changed file 1\n", "cat_blob: data");
    +seek $tmpfile, 0, 0;
     is(Git::hash_object("blob", $tmpfile), $file1hash, "hash_object: roundtrip");
     $tmpfile = File::Temp->new();
     print $tmpfile my $test_text = "test blob, to be inserted\n";
    -$tmpfile->close;
     like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
          "hash_and_insert_object: returns hash");
    -$iostring = IO::String->new;
    -is($r->cat_blob($newhash, $iostring), length $test_text, "cat_blob: roundtrip size");
    -is(${$iostring->string_ref}, $test_text, "cat_blob: roundtrip data");
    +$tmpfile = File::Temp->new;
    +is($r->cat_blob($newhash, $tmpfile), length $test_text, "cat_blob: roundtrip size");
    +{ local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
    +is($blobcontents, $test_text, "cat_blob: roundtrip data");

     # paths
     is($r->repo_path, "./.git", "repo_path");



 t/t9700-perl-git.sh |   39 ++++++++++++++++++++
 t/t9700/test.pl     |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100755 t/t9700-perl-git.sh
 create mode 100755 t/t9700/test.pl

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
new file mode 100755
index 0000000..b2fb9ec
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
+     git-config --add test.dupstring value2 &&
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
index 0000000..4d23125
--- /dev/null
+++ b/t/t9700/test.pl
@@ -0,0 +1,100 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use 5.006002;
+use warnings;
+use strict;
+
+use Test::More qw(no_plan);
+
+use Cwd;
+use File::Basename;
+use File::Temp;
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
+our $tmpfile = File::Temp->new;
+is($r->cat_blob($file1hash, $tmpfile), 15, "cat_blob: size");
+our $blobcontents;
+{ local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
+is($blobcontents, "changed file 1\n", "cat_blob: data");
+seek $tmpfile, 0, 0;
+is(Git::hash_object("blob", $tmpfile), $file1hash, "hash_object: roundtrip");
+$tmpfile = File::Temp->new();
+print $tmpfile my $test_text = "test blob, to be inserted\n";
+like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
+     "hash_and_insert_object: returns hash");
+$tmpfile = File::Temp->new;
+is($r->cat_blob($newhash, $tmpfile), length $test_text, "cat_blob: roundtrip size");
+{ local $/; seek $tmpfile, 0, 0; $blobcontents = <$tmpfile>; }
+is($blobcontents, $test_text, "cat_blob: roundtrip data");
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
1.5.6.149.g06c04.dirty
