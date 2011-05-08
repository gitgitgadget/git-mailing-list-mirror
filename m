From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/48] i18n: git-am multi-line getttext $msg; echo
Date: Sun,  8 May 2011 12:20:35 +0000
Message-ID: <1304857280-14773-4-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2zb-0003bV-Sf
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab1EHMVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:40 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1EHMVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:34 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=nbnkSfukiI4l6EEsF0r+rc2J6NPK72uWp69rn3cFEP8=;
        b=K95MMnEdWuABg3CaubM9UgRuobIUOP6HX1AyYNmbqYJN9Gnt53xz5gtj8e2eqEWQDu
         TeoI7OcnFIIdi+Jz8Y+7mUVKEd/HbkTTlvKUc2ol0lL7JaILmDdiFngIVwidhwXOZ6lJ
         6Fs0yCp5n9WzmLVmR+VWrOvH5iDwA1Zzl/MKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZlGgwMUH22DVcb266Hnhz6D1bDC9+fULCykvJ1SKDtskWCs3xEcbnFjfxJ35VJzrR+
         bZ6ke32qAIqmRCOIAVhESHy8b+9+ER4uIVBj6FORxCleduULX+ZjMOxxAFwC2Qojmu4/
         /E5qoBe1l4I7MNaW5od6Id7puvN7Ay3GUtSO0=
Received: by 10.213.4.142 with SMTP id 14mr1901116ebr.18.1304857292862;
        Sun, 08 May 2011 05:21:32 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.31
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173107>

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
1.7.4.4
