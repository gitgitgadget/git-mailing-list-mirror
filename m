From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 16/48] i18n: git-pull eval_gettext + warning message
Date: Sat, 21 May 2011 18:43:57 +0000
Message-ID: <1306003469-22939-17-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCo-0001Bj-Tt
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab1EUSrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab1EUSpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:17 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=KP/YXr9pTrDiEIwE3IAKuUY6+Ytic9gjIt/Wv8DRGMo=;
        b=s1FGDNQUOFN6dxaX3adyUo8Y/SCaBOrme1P7BcEG8q/JFOPIvn9S/1MOe94AzY44/G
         AemTBTI797hnOPGT7XQo1uAGNnfsFHhID2AosCa/2iQvDxsBps5A9gHjoGhc8arlvaeh
         ahCsJWjlnOrZX3nt9nRDm4kxBCZ/nJKVZbmsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dxbraXCbJ0sKHjOiJ3oRD3lD3m3rgqJ5i4acMr81eyzmLWarEXd5AFGB5ueifU3OXK
         yilBEYy8C3uGL37f1r50fgc5nmZUNYuGNdGh8HVf5Ac3Bb8dn4yziShALkYW4wNx5lPD
         sExv4NDjfxJtWx5AAekkI8ESNzw3UtEyFqM9o=
Received: by 10.213.33.195 with SMTP id i3mr283322ebd.46.1306003516921;
        Sat, 21 May 2011 11:45:16 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.15
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174156>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 06dcd81..a10b129 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -217,9 +217,12 @@ then
 	# $orig_head commit, but we are merging into $curr_head.
 	# First update the working tree to match $curr_head.
=20
-	echo >&2 "Warning: fetch updated the current branch head."
-	echo >&2 "Warning: fast-forwarding your working tree from"
-	echo >&2 "Warning: commit $orig_head."
+	(
+		eval_gettext "Warning: fetch updated the current branch head.
+Warning: fast-forwarding your working tree from
+Warning: commit \$orig_head." &&
+		echo
+	) >&2
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
 		die "$(eval_gettext "Cannot fast-forward your working tree.
--=20
1.7.5.1
