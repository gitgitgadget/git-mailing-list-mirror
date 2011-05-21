From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 45/48] i18n: git-bisect bisect_reset + $1 messages
Date: Sat, 21 May 2011 18:44:26 +0000
Message-ID: <1306003469-22939-46-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC6-0000od-Qx
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab1EUSq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47760 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757009Ab1EUSpo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:44 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451135ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=PacSPpfosCtMrSvQPyyni+CxJHs97ZQJhynCwkIE+vQ=;
        b=VeXvtYn1ou2hgC5PjJn9giLj2Dn2p0rFAjfL0LR8TtOp/LJaLpAdW2sBKqDvIVKY1N
         Qa/IQUuBzf3D+NinswD78Ux8aBRLNnsA+vIteI/zL0NMYu6U6IP6Z8be6vc91OfHG0xl
         J33SId+YUj26YwHwI+7v3l7NmKsqEWRm8Rbh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VFMNCvaIg6ZfWsKDaatBOxT8+mbGf3LH8kJam8wBiu2Y2XkfROuuozUgiCS5AL1FRJ
         x8XiDIYczICY3xtNwz7YpuCdFXdnbgNqAXWs0u8MPI8681wN5zVt6XhI0At1B6alorqW
         7otAhJSuilUYsD4rf3LG/InmJ1L3864/OleXw=
Received: by 10.14.11.227 with SMTP id 75mr278750eex.110.1306003544217;
        Sat, 21 May 2011 11:45:44 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.43
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174143>

ettextize bisect_reset messages that use the $1 variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index d69c587..24e1c15 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -319,8 +319,10 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) branch=3D$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null ||
-	       die "'$1' is not a valid commit"
+	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null || {
+	       invalid=3D"$1"
+	       die "$(eval_gettext "'\$invalid' is not a valid commit")"
+	   }
 	   branch=3D"$1" ;;
 	*)
 	    usage ;;
--=20
1.7.5.1
