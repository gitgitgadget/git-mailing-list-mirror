From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 17/51] i18n: git-pull "You asked to pull" message
Date: Sun,  3 Apr 2011 16:45:41 +0000
Message-ID: <1301849175-1697-18-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUW-0005ya-MU
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab1DCQqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab1DCQqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:47 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=tpcPpmDz581AE1X6fAt8lJaC1cCFbGQGH65JkmXeEFI=;
        b=tH2zxFbt1NvPWGrRwyUbUiv9sy0br8bBGQjYVynhGQB1MxcIf364Bdq9DKV561Rv6D
         gviQteS2GBLZZZAx4cFxIlDQxnVI0RvAs0aoKUPFXbcU6EzTRzQjnMiIlbHrS3AqKYV+
         PHG2WrHfMNbsQJNQWzJxztbJgEE3z2VpSzxqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AzZdla01RtbdiVFfB1oSsZ8xqOcCRFQAaqtE/IOafZZYeIkhCYJHoHtjtHAi1L36L5
         tuOS12eFPKVcLtHh2NNgzq0Xwcx40Lc6WsMxpS+e5mDzxEK07s1l7yhByENtMrozrm98
         brvrjbv2RtQXbE2kNqOXOXQednvwLzxtdchAc=
Received: by 10.213.0.200 with SMTP id 8mr3162675ebc.62.1301849206664;
        Sun, 03 Apr 2011 09:46:46 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.45
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170750>

Gettextize the "You asked to pull" error message. This message
interpolated $1 which won't work with eval_gettext for obvious
reasons, so I needed to provide an alias for it.

This also made the message easier to translate, and I added a
TRANSLATORS comment to make it even easier.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 95b1fb2..821c48d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -164,9 +164,12 @@ Generally this means that you provided a wildcard =
refspec which had no
 matches on the remote end."; echo
 		fi
 	elif [ $# -gt 0 ] && [ "$1" !=3D "$remote" ]; then
-		echo "You asked to pull from the remote '$1', but did not specify"
-		echo "a branch. Because this is not the default configured remote"
-		echo "for your current branch, you must specify a branch on the comm=
and line."
+		requested_remote=3D$1
+		# TRANSLATORS: $requested_remote will be a remote name, like
+		# "origin" or "avar"
+		eval_gettext "You asked to pull from the remote '\$requested_remote'=
, but did not specify
+a branch. Because this is not the default configured remote
+for your current branch, you must specify a branch on the command line=
=2E"; echo
 	elif [ -z "$curr_branch" ]; then
 		echo "You are not currently on a branch, so I cannot use any"
 		echo "'branch.<branchname>.merge' in your configuration file."
--=20
1.7.4.1
