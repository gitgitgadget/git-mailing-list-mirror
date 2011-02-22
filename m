From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 70/73] gettextize: git-revert "Your local changes" message
Date: Tue, 22 Feb 2011 23:42:29 +0000
Message-ID: <1298418152-27789-71-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vH-0000K1-PP
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab1BVXow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:52 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab1BVXos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:48 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yPgojYiaFCGUBCg1JQ/DyIeATYI5idnV7R9zbXramnQ=;
        b=UA0VtU44iuodIX1nE86MdFSi9c7X25h75oPs4UzykKZGr4qeP2L0uvjnHzrOISX7JX
         9efoAL8X2BUtq7DGBvpDWSIe5dCW79KRPio/7cLSxu//57D3rISlg5a36ZEqZWn8OYHX
         Js0Jktz5fiKkKRHsPSDWx63CjuSCTpLTVsvP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SzCYK7wsbfKa64M4I4bZP4E5Gud1Elz3Dstngkxv7yuVeeL5lAwsevcEc4HCNadSTF
         ZLdVA4dBo9bmhwovcydPFYLqkRNfwS7KB0BPEDyPj3GMc2YUW4BpFUdqdM0I/MXtYYyy
         UsQL+cdd1IbBI2VyEG+yp8vmAOEjgKpZtNZOw=
Received: by 10.204.57.197 with SMTP id d5mr3042282bkh.63.1298418287819;
        Tue, 22 Feb 2011 15:44:47 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.46
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:47 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167621>

Translate the "Your local changes [...]" message without using the
`me' variable, instead split up the two messages so translators can
translate the whole messages as-is.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c              |   18 +++++++++++++-----
 t/t3501-revert-cherry-pick.sh |    2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1ca08da..02c23c9 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -302,11 +302,19 @@ static NORETURN void die_dirty_index(const char *=
me)
 	if (read_cache_unmerged()) {
 		die_resolve_conflict(me);
 	} else {
-		if (advice_commit_before_merge)
-			die("Your local changes would be overwritten by %s.\n"
-			    "Please, commit your changes or stash them to proceed.", me);
-		else
-			die("Your local changes would be overwritten by %s.\n", me);
+		if (advice_commit_before_merge) {
+			if (action =3D=3D REVERT)
+				die(_("Your local changes would be overwritten by revert.\n"
+					  "Please, commit your changes or stash them to proceed."));
+			else
+				die(_("Your local changes would be overwritten by cherry-pick.\n"
+					  "Please, commit your changes or stash them to proceed."));
+		} else {
+			if (action =3D=3D REVERT)
+				die(_("Your local changes would be overwritten by revert.\n"));
+			else
+				die(_("Your local changes would be overwritten by cherry-pick.\n")=
);
+		}
 	}
 }
=20
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index 0439544..753a6c9 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -91,7 +91,7 @@ test_expect_success 'cherry-pick on stat-dirty workin=
g tree' '
 	)
 '
=20
-test_expect_success 'revert forbidden on dirty working tree' '
+test_expect_success C_LOCALE_OUTPUT 'revert forbidden on dirty working=
 tree' '
=20
 	echo content >extra_file &&
 	git add extra_file &&
--=20
1.7.2.3
