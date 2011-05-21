From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 03/48] i18n: git-am multi-line getttext $msg; echo
Date: Sat, 21 May 2011 18:43:44 +0000
Message-ID: <1306003469-22939-4-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrDR-0001WK-Bc
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab1EUSr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab1EUSpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:06 -0400
Received: by eyx24 with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Lvtmej9bo/wiMFinUTBVE011BWEK/lkQHfLFGTk9FDc=;
        b=i1uTP+Q0sbNHgoDZn4WT3aSuSZkZXAUOkticrIE7f90woS9Ke6kQ9vsjMm7dsSn+dM
         DIPJza13UgPzx/fgWHoRw7bWx8zQOjTz6btJaomxRGVEkZ8c/PbMRmhInAFOl5I9ZbzS
         mRcdFpfSTAN8hyj6Jzgdncpeepdlx/dwhdh7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=heTvNMHSmwNYjPuqjds/9tdyjfTfYnpYOYQk3KjIjIgFLupfF2UNA/F9Du9q+uZ7h4
         oaQIWe7Iyz9jYrnys4bDXbZZ8tEelRAkqseWAu32ViT5DqYN0T47Bqp5jYNU2diU8PRW
         AJYCnXFTudxIzPTW9PkEKJluKmUDEHKKKqC/A=
Received: by 10.14.22.5 with SMTP id s5mr264789ees.94.1306003504964;
        Sat, 21 May 2011 11:45:04 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.04
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174164>

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
1.7.5.1
