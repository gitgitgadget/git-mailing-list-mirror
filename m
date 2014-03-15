From: Justin Lebar <jlebar@google.com>
Subject: [PATCH 5/6] Fix misuses of "nor" outside comments
Date: Sat, 15 Mar 2014 01:42:01 -0700
Message-ID: <1394872922-2000-6-git-send-email-jlebar@google.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Justin Lebar <jlebar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 09:43:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOkBY-0006GX-NU
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 09:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbaCOInK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 04:43:10 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:63045 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbaCOImz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 04:42:55 -0400
Received: by mail-ie0-f201.google.com with SMTP id rd18so702542iec.4
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JEv+PYGJfIatNAAdwwt+tr51OUuqyrdZwQpBPuNT+w0=;
        b=ST8ShCMFNrJMCgT/SGZ938MjZNgv7Cr8FAZVTVKDzjimFbckcOSmBEveoCbBmYvJkS
         AEGZxZVbaMVW3bmEdgKY/SegbGT7XVb4+hoUkskmJ+vqmYn16ZTTW6JPy49FhqwSt21Z
         PNkYjqx2t3DPHfe1/KAfnC1bN4ViHQDDAU3ZqcN+L6WBF457k1eVQLLwsvOvQ9GZj7w6
         vJ1uOgGteB2nha5we/YRH/WZReDKMVOUHBfj2UzOCQK24syB06ZrqqlOEe9u3IuvHsgT
         oFmbHJPSDOor8a5qRzAG73Yfh/C6OclA4gy7rwHI38MmcEjBSZGMxL6RyqgY19UR8gMt
         XEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JEv+PYGJfIatNAAdwwt+tr51OUuqyrdZwQpBPuNT+w0=;
        b=TYV4dtVyfYmGHiJegTE/Lk3ijEVu6OfU8KnQVjuYwvfC+KvJaR7kYjGb4G31ikEias
         ElO8pfC87dtRiR+91uoiyfahhoO3dSRO+ZiqkupW6AyyHCR+X6EqLfkPGdpvLaEwc/Ih
         izn+Nx+9nqacFVMbrYUmyiP1e8ZqpJq7UhoiUuNe7NXuTmhxkrEk/pNR5QCYl2fBy9wI
         d7Y8FSUm78SrY+Q8SWEw2AdbMr/Tl794QUqLvcqDae+weo7MeN8tINHRrPiwj+ABxNmV
         wapQzJiDMWqsKnXKbCJZKUr3OrN3KJ7ZbUtZemsujjGoXMeNuOnnJgpYOENpStjyxPPI
         zR2Q==
X-Gm-Message-State: ALoCoQmdWc9Y0yA+aGus2Zq5lT6SXG/hwY6XyhHaqIPnz43Bj9ViEd5BTsyESjoDCLGHjhwoZy6X+1RyhQbCeH960oxTJiaR8vskwTzNZ9ZFcGYml5Pf5Up/hwMOoJDTLVvo5ahOp2hzgBNFtM/fYBbzyfJWGg+1NQ7ktPfHfuGcMI5wMrTs/kxdtYk0qc/U35Ke4UP3SBcy
X-Received: by 10.182.129.129 with SMTP id nw1mr5139996obb.34.1394872975273;
        Sat, 15 Mar 2014 01:42:55 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id f21si1298037yhn.2.2014.03.15.01.42.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Mar 2014 01:42:55 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 08CE75A4241;
	Sat, 15 Mar 2014 01:42:55 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id BD8F61A0889; Sat, 15 Mar 2014 01:42:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.279.gdc9e3eb
In-Reply-To: <1394872922-2000-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244143>

Signed-off-by: Justin Lebar <jlebar@gmail.com>
---
 builtin/clean.c           | 6 +++---
 builtin/commit.c          | 2 +-
 git-add--interactive.perl | 4 ++--
 perl/Git/SVN.pm           | 4 ++--
 sha1_file.c               | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 2f26297..fb1b357 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -903,11 +903,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	if (!interactive && !dry_run && !force) {
 		if (config_set)
-			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
+			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
 				  "refusing to clean"));
 		else
-			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
-				  "refusing to clean"));
+			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
+				  " refusing to clean"));
 	}
 
 	if (force > 1)
diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..6c6be8a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1123,7 +1123,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (argc == 0 && only && amend)
 		only_include_assumed = _("Clever... amending the last one with dirty index.");
 	if (argc > 0 && !also && !only)
-		only_include_assumed = _("Explicit paths specified without -i nor -o; assuming --only paths...");
+		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 24bb1ab..32c2f9c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1156,9 +1156,9 @@ sub help_patch_cmd {
 	print colored $help_color, <<EOF ;
 y - $verb this hunk$target
 n - do not $verb this hunk$target
-q - quit; do not $verb this hunk nor any of the remaining ones
+q - quit; do not $verb this hunk or any of the remaining ones
 a - $verb this hunk and all later hunks in the file
-d - do not $verb this hunk nor any of the later hunks in the file
+d - do not $verb this hunk or any of the later hunks in the file
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 62f3293..a59564f 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -480,8 +480,8 @@ sub refname {
 	# It cannot end with a slash /, we'll throw up on this because
 	# SVN can't have directories with a slash in their name, either:
 	if ($refname =~ m{/$}) {
-		die "ref: '$refname' ends with a trailing slash, this is ",
-		    "not permitted by git nor Subversion\n";
+		die "ref: '$refname' ends with a trailing slash; this is ",
+		    "not permitted by git or Subversion\n";
 	}
 
 	# It cannot have ASCII control character space, tilde ~, caret ^,
diff --git a/sha1_file.c b/sha1_file.c
index b79efe4..77dbb56 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1123,7 +1123,7 @@ static void report_helper(const struct string_list *list,
 	const char *msg;
 	switch (seen_bits) {
 	case 0:
-		msg = "no corresponding .idx nor .pack";
+		msg = "no corresponding .idx or .pack";
 		break;
 	case 1:
 		msg = "no corresponding .idx";
-- 
1.9.0.279.gdc9e3eb
