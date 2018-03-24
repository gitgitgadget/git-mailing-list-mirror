Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD4B1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 10:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeCXKWM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 06:22:12 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:55342 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCXKWK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 06:22:10 -0400
Received: by mail-wm0-f43.google.com with SMTP id t7so7577430wmh.5
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ClorHRQWK5Vo46j5utQNzy/6+3HHo2akbr2lFnOyjc4=;
        b=vG+41HoYrUd2JSHBoJ4WgRNshzzlUYYKnbQ3FN0dbGc47/o0nPeOlNtdYq7zSN6W6d
         +k4wiFHuPL1REzhUncJuT8osktJeOb8WSiiCv9KTJ/dOI9iY8DuhRddu5Wp3EpocNC4d
         gtsppeJZqGeAFg8sNKNZ7SE3cg7DIqYVy2OE7NOFlb8vOabsNy/qw5mEenIrdbCSqY6E
         qlDlj8gEDWOI4wnlLeT+mXHp9uoKbPRDrg3XBuZMEtFJY9j4lqYm/eZKLp62hkM39YnE
         964pUmHfQLJSwDDw+oo4BpFVv2sieu7je1sgL7jMGFVb+t5vvHVPEZjua/IpferhRBKL
         SReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ClorHRQWK5Vo46j5utQNzy/6+3HHo2akbr2lFnOyjc4=;
        b=gcApW3V4cZ7+2aoR+Dqt4dHq0NGz8dn5UD9IKrTVC7W8Su7zrFFAt05s1D2Btd7ERZ
         verAaqXGZr7+XzFWGV61lh1wOcwZCaEvdruEdgEBVacw3w5RNGgP+/oxsqzm0TIVGXyd
         xW7IuEc29YUo0I8+fK8kgLsiETO8IdqNgbiaP/zgZMZgJ6s4E0Ov3uB0ps2nI0Ao8L//
         4Vrd3Tx1JhqIyz1ndzUZJ8deLnOJ7VTcOj6QuzvohtRjt2n+Lh4e661tMXHDPznpgTa6
         MQE6Ou7K51+gM023y2lZPM8KWLOzGeBJoouHbDUriOZh1vCAXgoxLX+DkVun4ZH+RVcv
         N5Zg==
X-Gm-Message-State: AElRT7GuCDM+N2K2rSahSzdpMvVkcBDvo7NcEikc1u9PNV9hrQwf8ZiT
        0v8lw4e2hBQGdO2cp2G9+E//eQ==
X-Google-Smtp-Source: AG47ELuYRgxgUGUVRnvGMoOhzfrrRZxW4VkGan0LPZSZduHvQGNMZB9UUFZ6ZYIRzWC1TzRoImt/uQ==
X-Received: by 10.28.109.88 with SMTP id i85mr10330749wmc.150.1521886928468;
        Sat, 24 Mar 2018 03:22:08 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:3c52:d1a9:f75d:ebe4])
        by smtp.gmail.com with ESMTPSA id e74sm10413183wmg.27.2018.03.24.03.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Mar 2018 03:22:07 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Cc:     sunshine@sunshineco.com, Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v3] git-svn: allow empty email-address using authors-prog and authors-file
Date:   Sat, 24 Mar 2018 11:20:46 +0100
Message-Id: <20180324102046.8840-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320220743.GA17234@whir>
References: <20180320220743.GA17234@whir>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The email address in --authors-file and --authors-prog can be empty but
git-svn translated it into a fictional email address in the form

	jondoe <jondoe@6aafaa21e0fb4338a68ab372a049893d>

containing the SVN repository UUID. Now git-svn behaves like git-commit:
If the email is *explicitly* set to the empty string using '<>', the
commit does not contain an email address, only the name:

	jondoe <>

Allowing to remove the email address *intentionally* prevents automatic
systems from sending emails to those fictional addresses and avoids
cluttering the log output with unnecessary stuff.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-svn.txt       |  8 +++++---
 perl/Git/SVN.pm                 | 13 ++++++-------
 t/t9130-git-svn-authors-file.sh | 14 ++++++++++++++
 t/t9138-git-svn-authors-prog.sh | 25 ++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b858374649..d59379ee23 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -635,7 +635,8 @@ config key: svn.findcopiesharder
 
 -A<filename>::
 --authors-file=<filename>::
-	Syntax is compatible with the file used by 'git cvsimport':
+	Syntax is compatible with the file used by 'git cvsimport' but
+	an empty email address can be supplied with '<>':
 +
 ------------------------------------------------------------------------
 	loginname = Joe User <user@example.com>
@@ -654,8 +655,9 @@ config key: svn.authorsfile
 	If this option is specified, for each SVN committer name that
 	does not exist in the authors file, the given file is executed
 	with the committer name as the first argument.  The program is
-	expected to return a single line of the form "Name <email>",
-	which will be treated as if included in the authors file.
+	expected to return a single line of the form "Name <email>" or
+	"Name <>", which will be treated as if included in the authors
+	file.
 +
 Due to historical reasons a relative 'filename' is first searched
 relative to the current directory for 'init' and 'clone' and relative
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index bc4eed3d75..945ca4db2b 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1482,7 +1482,6 @@ sub call_authors_prog {
 	}
 	if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
 		my ($name, $email) = ($1, $2);
-		$email = undef if length $2 == 0;
 		return [$name, $email];
 	} else {
 		die "Author: $orig_author: $::_authors_prog returned "
@@ -2020,8 +2019,8 @@ sub make_log_entry {
 		remove_username($full_url);
 		$log_entry{metadata} = "$full_url\@$r $uuid";
 		$log_entry{svm_revision} = $r;
-		$email ||= "$author\@$uuid";
-		$commit_email ||= "$author\@$uuid";
+		$email = "$author\@$uuid" unless defined $email;
+		$commit_email = "$author\@$uuid" unless defined $commit_email;
 	} elsif ($self->use_svnsync_props) {
 		my $full_url = canonicalize_url(
 			add_path_to_url( $self->svnsync->{url}, $self->path )
@@ -2029,15 +2028,15 @@ sub make_log_entry {
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
-		$email ||= "$author\@$uuid";
-		$commit_email ||= "$author\@$uuid";
+		$email = "$author\@$uuid" unless defined $email;
+		$commit_email = "$author\@$uuid" unless defined $commit_email;
 	} else {
 		my $url = $self->metadata_url;
 		remove_username($url);
 		my $uuid = $self->rewrite_uuid || $self->ra->get_uuid;
 		$log_entry{metadata} = "$url\@$rev " . $uuid;
-		$email ||= "$author\@" . $uuid;
-		$commit_email ||= "$author\@" . $uuid;
+		$email = "$author\@$uuid" unless defined $email;
+		$commit_email = "$author\@$uuid" unless defined $commit_email;
 	}
 	$log_entry{name} = $name;
 	$log_entry{email} = $email;
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index 41264818cc..6af6daf461 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -108,6 +108,20 @@ test_expect_success !MINGW 'fresh clone with svn.authors-file in config' '
 	)
 '
 
+cat >> svn-authors <<EOF
+ff = FFFFFFF FFFFFFF <>
+EOF
+
+test_expect_success 'authors-file imported user without email' '
+	svn_cmd mkdir -m aa/branches/ff --username ff "$svnrepo/aa/branches/ff" &&
+	(
+		cd aa-work &&
+		git svn fetch --authors-file=../svn-authors &&
+		git rev-list -1 --pretty=raw refs/remotes/origin/ff | \
+		  grep "^author FFFFFFF FFFFFFF <> "
+	)
+	'
+
 test_debug 'GIT_DIR=gitconfig.clone/.git git log'
 
 test_done
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 7d7e9d46bc..0cec56128f 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -9,7 +9,9 @@ test_description='git svn authors prog tests'
 
 write_script svn-authors-prog "$PERL_PATH" <<-\EOF
 	$_ = shift;
-	if (s/-sub$//)  {
+	if (s/-hermit//) {
+		print "$_ <>\n";
+	} elsif (s/-sub$//)  {
 		print "$_ <$_\@sub.example.com>\n";
 	} else {
 		print "$_ <$_\@example.com>\n";
@@ -68,6 +70,27 @@ test_expect_success 'authors-file overrode authors-prog' '
 git --git-dir=x/.git config --unset svn.authorsfile
 git --git-dir=x/.git config --unset svn.authorsprog
 
+test_expect_success 'authors-prog imported user without email' '
+	svn mkdir -m gg --username gg-hermit "$svnrepo"/gg &&
+	(
+		cd x &&
+		git svn fetch --authors-prog=../svn-authors-prog &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep "^author gg <> "
+	)
+'
+
+test_expect_success 'imported without authors-prog and authors-file' '
+	svn mkdir -m hh --username hh "$svnrepo"/hh &&
+	(
+		uuid=$(svn info --show-item=repos-uuid "$svnrepo") &&
+		cd x &&
+		git svn fetch &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep "^author hh <hh@$uuid> "
+	)
+'
+
 test_expect_success 'authors-prog handled special characters in username' '
 	svn mkdir -m bad --username "xyz; touch evil" "$svnrepo"/bad &&
 	(
-- 
2.16.2

