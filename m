From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 27/72] gettextize: git-commit print_summary messages
Date: Sat, 19 Feb 2011 19:24:10 +0000
Message-ID: <1298143495-3681-28-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsW2-0004Tk-5u
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab1BSTa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:30:29 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab1BST1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:48 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970440ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=J96b/WAnH3pTC/em5Zuj1RO9mwUf1laz62TR6Bt2DKA=;
        b=A+LWsLZzWZgMnXQd45b30cAZepAbGvkzsHabe0A2BLpegzOF/b7Chg8UFwV32bUZUB
         k0+oG4qwUkWBbzOPmqgRLl5RSrDm3c4UhqAgYelMtRhCvcGOmlSjtg+No5tpHpgAfvYH
         /8Jw01iFC/MeSBZ9L7vKbqlVq/sMdVi3kspbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FmqUVCIE4FihIhPMXxnTT/5FEzK5vL+PVuxxff+D44gpeSAM9GZy7TpLXFbwN00YIo
         YF2elDxOl2m+8GVoa2x8EgCB4s1l0cvcyrVq6akflyXKwDC99tmi3vQiK/HBs45rpihR
         dDlOo2J8v8QTE1XnNO02HcChtJH3I7E4sODK8=
Received: by 10.213.27.203 with SMTP id j11mr2525786ebc.51.1298143667225;
        Sat, 19 Feb 2011 11:27:47 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.46
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:46 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167375>

Gettextize the "(root-commit)" and "detached HEAD" fragments that
appear when you commit either the root commit, or a commit in a
detached head translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c  |    4 ++--
 t/t7502-commit.sh |   10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c7c6c59..c90a8cf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1223,9 +1223,9 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1)
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
 			!strcmp(head, "HEAD") ?
-				"detached HEAD" :
+				_("detached HEAD") :
 				head,
-		initial_commit ? " (root-commit)" : "");
+		initial_commit ? _(" (root-commit)") : "");
=20
 	if (!log_tree_commit(&rev, commit)) {
 		rev.always_show_header =3D 1;
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 9204a4d..298f7d9 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -22,7 +22,10 @@ check_summary_oneline() {
 	SUMMARY_POSTFIX=3D"$(git log -1 --pretty=3D'format:%h')"
 	echo "[$SUMMARY_PREFIX $SUMMARY_POSTFIX] $2" >exp &&
=20
-	test_cmp exp act
+	if test_have_prereq NO_GETTEXT_POISON
+	then
+		test_cmp exp act
+	fi
 }
=20
 test_expect_success 'output summary format' '
@@ -32,7 +35,10 @@ test_expect_success 'output summary format' '
 	check_summary_oneline "root-commit" "initial" &&
=20
 	echo change >>file1 &&
-	git add file1 &&
+	git add file1
+'
+
+test_expect_success 'output summary format: root-commit' '
 	check_summary_oneline "" "a change"
 '
=20
--=20
1.7.2.3
