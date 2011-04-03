From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/51] i18n: git-am multi-line getttext $msg; echo
Date: Sun,  3 Apr 2011 16:45:27 +0000
Message-ID: <1301849175-1697-4-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:46:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QRk-0004uP-Jo
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab1DCQqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1DCQqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:33 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=LvF6vVYl2e3HjbyT++qDetulgwy4Caw6tfvbZKghzC0=;
        b=Lo9fAfqE4yghMLZYHBsrYEWOgJaJWb/gVqCWmjx4nm41Z/ylZKzMRiqofzp3Eu/0qU
         QyRXibJN2ctXD3n0spuUCZFTRsILwrNDaWX0e86bJ8tk1SI5E8RiXXjYYYGqWcGUsYuF
         zEvLId6wxgRXdJ38ZaGskwfEgqZYWd9tu32Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UJH0b52dy8W08fYY2DYCCDtSYVkE5mT15/vREReXYlVF3LUYrTEhQEguamxD9dDC4N
         RbkSb2Qh3ZDnS1/i/XY/db3okJOW3uyjsHl0KDbwlld+oHd7nfDg9r4kofD7M5H7Bk1w
         J1Qng1w7HXmFLZUtQLLFVphQrmnL8CZKio7Zk=
Received: by 10.213.27.9 with SMTP id g9mr2277724ebc.33.1301849192600;
        Sun, 03 Apr 2011 09:46:32 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.31
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170707>

When we have multi-line `gettext $msg; echo' messages we can't
preserve the existing indenting because gettext(1) can't accept input
on stdin.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index f54f13d..5a152b0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -757,16 +757,16 @@ do
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
1.7.4.1
