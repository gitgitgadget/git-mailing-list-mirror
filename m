From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/20] gettextize: git-am multi-line getttext $msg; echo
Date: Tue,  7 Sep 2010 16:48:27 +0000
Message-ID: <1283878113-19533-4-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1O9-0004K7-NJ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246Ab0IGQtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:49:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37536 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab0IGQtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:49:11 -0400
Received: by wwj40 with SMTP id 40so8415524wwj.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=imOIeNLbK7cjgNYqsb9durSYlgrw7Ff1tzLDwNtdI5g=;
        b=T6BaMmRTok2ol52BewzziEmIXjUykthz9FqVu+mrLNbZQ0vgMxOTd76IsP1UhOfvFX
         Cf7XnXZ07Wmf6sC1ZnK/xqPFH8elsXJgoEuP8vj3ES8wb93Zvk6kvVmHhP6CFzawKQx6
         oISBp734uRof+ViKyGBRSZ6fISxQToHKRxc5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rECUnv7sjB5nlpcQGNe9oPlhQ0p5/wxBJQhTW9K6L0EKxlZBE5Db7EFvdw39GD/QOD
         aYYq1Fna/qBdVuB0LMBF3BuWUAx2FiL2ReYPId2fKGhzbdXwO0hz56TGlCp9uc63YZbX
         CwjoqyjNdNRgvIn7R6pUKyZf2sxBJ1Bc9Du90=
Received: by 10.227.94.138 with SMTP id z10mr80745wbm.166.1283878130978;
        Tue, 07 Sep 2010 09:48:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.48.50
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155720>

When we have multi-line `gettext $msg; echo' messages we can't
preserve the existing indenting because gettext(1) can't accept input
on stdin.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index bd04a15..73a4046 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -741,16 +741,16 @@ do
 		# working tree.
 		resolved=3D
 		git diff-index --quiet --cached HEAD -- && {
-			echo "No changes - did you forget to use 'git add'?"
-			echo "If there is nothing left to stage, chances are that something=
 else"
-			echo "already introduced the same changes; you might want to skip t=
his patch."
+			gettext "No changes - did you forget to use 'git add'?
+If there is nothing left to stage, chances are that something else
+already introduced the same changes; you might want to skip this patch=
=2E"; echo
 			stop_here_user_resolve $this
 		}
 		unmerged=3D$(git ls-files -u)
 		if test -n "$unmerged"
 		then
-			echo "You still have unmerged paths in your index"
-			echo "did you forget to use 'git add'?"
+			gettext "You still have unmerged paths in your index
+did you forget to use 'git add'?"; echo
 			stop_here_user_resolve $this
 		fi
 		apply_status=3D0
--=20
1.7.2.3.313.gcd15
