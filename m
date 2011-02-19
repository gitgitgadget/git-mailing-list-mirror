From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 25/72] gettextize: git-commit "middle of a merge" message
Date: Sat, 19 Feb 2011 19:24:08 +0000
Message-ID: <1298143495-3681-26-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsW3-0004Tk-9q
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419Ab1BSTae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:30:34 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966Ab1BST1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:46 -0500
Received: by eye27 with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=AbFXVJwuO0hXgQT1ytunqb8KIMhK1eIKTBVNoZ/qUPw=;
        b=g9FNWqyeUJpasZpOj90PeZz7sCfBQap2nM61ZNYXiAxdF2TcRz9IUWTRO4GTvmZoC7
         F7fp8IvJLyq58kfPmirHrVsFESHOwHgEm7+3E5L48gtWWM3XZhJ6+Rypk5H/sJJ70TMv
         iQH7aJbO4w2qhMcTRRQ3mG+9BPgSmqu2Gu238=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ciH78NH4RrOLevreAw8LFirtrGMc0VYYIXg3Zsrf09xntnJgYXkHA7mD53BYOW30i0
         PVioTscaTJY6KtewHEN8CG2w6v+S6dS2maYi35+p2Z3zMlPVbJ1DX3pTIiqWqbyPCkaB
         FpMohSkPxWpingQ7/CSfoNN/Y/qFzkIrowW28=
Received: by 10.14.48.2 with SMTP id u2mr2420824eeb.20.1298143665391;
        Sat, 19 Feb 2011 11:27:45 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.44
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:44 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167372>

Gettextize the "You are in the middle of a merge -- cannot amend."
message. Several tests in t7110-reset-merge.sh explicitly checked for
this message. Change them to skip under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c       |    4 ++--
 t/t7110-reset-merge.sh |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c57f603..0198e90 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -928,9 +928,9 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
 	if (amend && initial_commit)
 		die(_("You have nothing to amend."));
 	if (amend && in_merge)
-		die("You are in the middle of a merge -- cannot amend.");
+		die(_("You are in the middle of a merge -- cannot amend."));
 	if (fixup_message && squash_message)
-		die("Options --squash and --fixup cannot be used together");
+		die(_("Options --squash and --fixup cannot be used together"));
 	if (use_message)
 		f++;
 	if (edit_message)
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 70cdd8e..8e54f0c 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -233,7 +233,7 @@ test_expect_success '"reset --merge HEAD^" is ok wi=
th pending merge' '
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
 # file1:     X       U     B    C     --keep   (disallowed)
-test_expect_success '"reset --keep HEAD^" fails with pending merge' '
+test_expect_success NO_GETTEXT_POISON '"reset --keep HEAD^" fails with=
 pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
     test_must_fail git reset --keep HEAD^ 2>err.log &&
@@ -259,7 +259,7 @@ test_expect_success '"reset --merge HEAD" is ok wit=
h pending merge' '
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
 # file1:     X       U     B    B     --keep   (disallowed)
-test_expect_success '"reset --keep HEAD" fails with pending merge' '
+test_expect_success NO_GETTEXT_POISON '"reset --keep HEAD" fails with =
pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
     test_must_fail git reset --keep HEAD 2>err.log &&
@@ -280,7 +280,7 @@ test_expect_success '--merge is ok with added/delet=
ed merge' '
     git diff --exit-code --cached
 '
=20
-test_expect_success '--keep fails with added/deleted merge' '
+test_expect_success NO_GETTEXT_POISON '--keep fails with added/deleted=
 merge' '
     git reset --hard third &&
     rm -f file2 &&
     test_must_fail git merge branch3 &&
--=20
1.7.2.3
