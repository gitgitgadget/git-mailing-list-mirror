From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 38/51] i18n: git-stash die + eval_gettext $1 messages
Date: Sun,  3 Apr 2011 16:46:02 +0000
Message-ID: <1301849175-1697-39-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSM-00055g-Vd
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab1DCQrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab1DCQrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:10 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=gpEEvV1/d+nGBesZadU3PZdDJeSOE8tugNdEt6bLYAM=;
        b=xWmPFQ/JzN2wkseTP+dU0SZlTw5PjajtPbOlWcn1K1WoOAm1sKV+NDHvTJrH+50qYy
         vlab+fttIaH+nYzk/wQeAA/H4/ZNQpcU4lP+QWjTIbQdojQ3lcNd1RMZLp1jBw4tIekT
         p92Y3sjTRCE+VJSra+VVM33P9Y3Pk3kwl0Qo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ggvwyuTHsbqW5KAt070HI8/BgLje4GNzvm6AuBCJyDVjny8EU1oHfeNWMBNBOB5WE9
         0vGHaG3eCMWvPOOkSUSLoZafa7UENoxwUoxcl8hjJyid2z4vxmfU22U0RC6URi2lDriB
         54oBclqzhoE0hNrbEAU4x9i4DyoW/SCUr/G3A=
Received: by 10.213.103.138 with SMTP id k10mr1162176ebo.125.1301849229793;
        Sun, 03 Apr 2011 09:47:09 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.08
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170722>

Gettextize a messages that used the $1 variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index afe7043..9ab5ed9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -298,7 +298,10 @@ parse_flags_and_rev()
 		;;
 	esac
=20
-	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
die "$1 is not valid reference"
+	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
{
+		reference=3D"$1"
+		die "$(eval_gettext "\$reference is not valid reference")"
+	}
=20
 	i_commit=3D$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
 	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null)=
 &&
--=20
1.7.4.1
