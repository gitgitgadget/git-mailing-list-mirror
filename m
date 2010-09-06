From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 14/15] gettextize: git-revert split up "could not revert/apply" message
Date: Mon,  6 Sep 2010 12:21:43 +0000
Message-ID: <1283775704-29440-15-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaiz-0000aR-RM
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab0IFMWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab0IFMWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:45 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2884659wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MH+RrDC24FCoF1faalxeBaikA0oXZ3DHAA2Yfa0YqDg=;
        b=M8C946/3l9E7rPLohgWcXBYz524XQc36ecCS4WLG4BsxiswK7Y8w4JHmmdePsYTVPv
         4+qEvrBazR9YopIQXqRMzIDquBeiR9ePoA7zsDWvbXEgyUyKfhUKLKKKXQiv4+x1G5ay
         10aP+mvgsDHpQanH4pzIP2kmZnfEv0KYSjlfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lr9yxVLSkV3U96DYci3lnLm89DtOa6vAhLFb12ej8Pot0HRkRvhqUZcBN5OXILce5M
         OwI5B4AsSX8zR39HOMV4KPIXNmyJT77tFYMIKDt6rmqqlaHLSEdA5nL5r6/BkoJjtxIw
         k87yQqq0DZ4S6rhgPOVPmaRWGrXIHyqp0ptnA=
Received: by 10.227.134.69 with SMTP id i5mr219096wbt.165.1283775764787;
        Mon, 06 Sep 2010 05:22:44 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155564>

Split up the "could not %s %s... %s" message into "could not revert
%s... %s" and "could not apply %s... %s". This makes it easier for
translators to understand the message.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c                |    5 +++--
 t/t3507-cherry-pick-conflict.sh |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8dff244..7157ee1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -510,8 +510,9 @@ static int do_pick_commit(void)
 	}
=20
 	if (res) {
-		error("could not %s %s... %s",
-		      action =3D=3D REVERT ? "revert" : "apply",
+		error(action =3D=3D REVERT
+		      ? _("could not revert %s... %s")
+		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
 		print_advice();
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index 607bf25..bf664ec 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -38,7 +38,7 @@ test_expect_success 'failed cherry-pick does not adva=
nce HEAD' '
 	test "$head" =3D "$newhead"
 '
=20
-test_expect_success 'advice from failed cherry-pick' "
+test_expect_success NO_GETTEXT_POISON 'advice from failed cherry-pick'=
 "
 	git checkout -f initial^0 &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x &&
--=20
1.7.2.3.313.gcd15
