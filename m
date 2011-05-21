From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 26/48] i18n: git-submodule "[...] path is ignored" message
Date: Sat, 21 May 2011 18:44:07 +0000
Message-ID: <1306003469-22939-27-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBQ-0000TI-SP
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949Ab1EUSph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44943 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815Ab1EUSp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:26 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451116ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=oz6t16M0yJLgLM/DQMAiLAoZm4cNTmI9OmLjEXD5AY0=;
        b=rzXKGNQy6SvxP9M5Z5ziT4OKIhsXDD+qObfT1LewrHd42lSzEht+Li+uNlN/KEZMQK
         vtEVvMXdQJnKpHaZy9mtxdAfjHpLSedNQEtO2861NxMyQNVgyzSRntYImc8psvk4pAN+
         Z0R0GQzt2i0uJbg6WfSq0fpPiQxfjzmarjLT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fJK7Alel5taKly2oEo2w7goW3+4miWqirh5+L8uG9kinjrOh5+mxImGN+R7uxkfcBo
         GbL3wNYhXqrj73pNmxhGv0x6WC6SRlje35c/2FZY2sh8zXcU0FN/UZpH9Lkx5GJVSfhn
         KT0LwY+auOdw/XnlQ+cr81Gd/uOxQcO4gKPwY=
Received: by 10.14.11.69 with SMTP id 45mr273072eew.38.1306003526083;
        Sat, 21 May 2011 11:45:26 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.25
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174130>

Gettextize the "The following path is ignored" message. This is
explicitly tested for so we need to skip a portion of a test with
test_i18ncmp.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh           |    9 ++++++---
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f7d7f51..11c4bad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -223,9 +223,12 @@ cmd_add()
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
-		echo >&2 "The following path is ignored by one of your .gitignore fi=
les:" &&
-		echo >&2 $path &&
-		echo >&2 "Use -f if you really want to add it."
+		(
+			eval_gettext "The following path is ignored by one of your .gitigno=
re files:
+\$path
+Use -f if you really want to add it." &&
+			echo
+		) >&2
 		exit 1
 	fi
=20
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 874279e..ea3b445 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -99,7 +99,7 @@ test_expect_success 'submodule add to .gitignored pat=
h fails' '
 		git add --force .gitignore &&
 		git commit -m"Ignore everything" &&
 		! git submodule add "$submodurl" submod >actual 2>&1 &&
-		test_cmp expect actual
+		test_i18ncmp expect actual
 	)
 '
=20
--=20
1.7.5.1
