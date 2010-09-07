From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/20] gettextize: git-revert "Your local changes" message
Date: Tue,  7 Sep 2010 16:47:43 +0000
Message-ID: <1283878065-19349-4-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 07 18:48:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1LB-0002l0-Co
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036Ab0IGQsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:48:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55698 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172Ab0IGQsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:48:04 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so4441328wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FqsY3hG9D09O/U5fvgaDi78tgJDo/59SgagGsn2QyTI=;
        b=Dpr/ILW0MfhHwRhMs2yHV8MY8wkSc1h7F3WSfqZqlcTCx6ohFtVPdzWUOGLT9DnRKp
         Zz6MaDX3E9p3eQn/bRHj0faF4SsPEGyG8eOJk/HzsJHhguDyfS+MX5Q4JfgVDIQkxiQj
         YL8xAz9wT/2cY049OMsWvDs8uNquhhMIcalzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oXqstRC8qP8XqjjbD45nEYIdc/ylA27TDY+QfOpR84NBrntN146mO5U+OLzkkbanew
         ooQq2AJpdAk0715bMobo2YoaXVTZVqP/TLSjgU1sjg0aS04YNuCfSvB3cFuPQmKk9CuN
         QYQbChhksQc9/I19aF+56phpMIVJpdMZ4UlIo=
Received: by 10.227.147.145 with SMTP id l17mr49283wbv.183.1283878083211;
        Tue, 07 Sep 2010 09:48:03 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5895402wbe.23.2010.09.07.09.48.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155713>

Translate the "Your local changes [...]" message without using the
`me' variable, instead split up the two messages so translators can
translate the whole messages as-is.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a93a5ba..ad2c76a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -285,11 +285,19 @@ static NORETURN void die_dirty_index(const char *=
me)
 	if (read_cache_unmerged()) {
 		die_resolve_conflict(me);
 	} else {
-		if (advice_commit_before_merge)
-			die(_("Your local changes would be overwritten by %s.\n"
-			    "Please, commit your changes or stash them to proceed."), _(me)=
);
-		else
-			die(_("Your local changes would be overwritten by %s.\n"), _(me));
+		if (advice_commit_before_merge) {
+			if (action =3D=3D REVERT)
+				die(_("Your local changes would be overwritten by revert.\n"
+					  "Please, commit your changes or stash them to proceed."));
+			else
+				die(_("Your local changes would be overwritten by cherry-pick.\n"
+					  "Please, commit your changes or stash them to proceed."));
+		} else {
+			if (action =3D=3D REVERT)
+				die("Your local changes would be overwritten by revert.\n");
+			else
+				die("Your local changes would be overwritten by cherry-pick.\n");
+		}
 	}
 }
=20
--=20
1.7.2.3.313.gcd15
