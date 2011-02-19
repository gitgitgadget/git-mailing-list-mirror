From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 20/72] gettextize: git-checkout: our/their version message
Date: Sat, 19 Feb 2011 19:24:03 +0000
Message-ID: <1298143495-3681-21-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsT9-0002tu-Ef
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab1BST1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:45 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab1BST1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:38 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=aTb3WLNT0wzrILy7VDdeq+FRSJr0dm3zZKHucif0uwk=;
        b=TQ8FIzt11s/TUnC4d06h1VpBhWwn/s3iYNzgWl0zzYZKkBYbHddVC10McT0gLeiwZP
         1Mj1XSpG0mKPLU5g/hpZiRvaSwO3M/IW+7avTgqqyfEcmooqlLzBVh//swv18sfqHMrP
         9+mk6dPxSMpTm+kQ0ZJTk6ghSmpfL028tUbQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NnG0U9/FrdInYUt4+weIiLKZcTvvz8G0RC0M9fYrDJhpGBUnPje92tLYsq2aqCPLJ/
         2VeGk+s3wGyke/awJt0M6Em0YeCwr+FVSEZ5Ujga/uSewf02szwGeaYhLoGcCIWfMTIt
         5nDuzLhf4N2OFLZg68BPbX6lgYYv5M/mQ37+w=
Received: by 10.213.11.4 with SMTP id r4mr88251ebr.47.1298143658006;
        Sat, 19 Feb 2011 11:27:38 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.36
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:37 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167326>

Split up the "does not have our/their version" message to make it
easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5060ab..7ba0788 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -103,9 +103,10 @@ static int check_stage(int stage, struct cache_ent=
ry *ce, int pos)
 			return 0;
 		pos++;
 	}
-	return error("path '%s' does not have %s version",
-		     ce->name,
-		     (stage =3D=3D 2) ? "our" : "their");
+	if (stage =3D=3D 2)
+		return error(_("path '%s' does not have our version"), ce->name);
+	else
+		return error(_("path '%s' does not have their version"), ce->name);
 }
=20
 static int check_all_stages(struct cache_entry *ce, int pos)
@@ -130,9 +131,10 @@ static int checkout_stage(int stage, struct cache_=
entry *ce, int pos,
 			return checkout_entry(active_cache[pos], state, NULL);
 		pos++;
 	}
-	return error("path '%s' does not have %s version",
-		     ce->name,
-		     (stage =3D=3D 2) ? "our" : "their");
+	if (stage =3D=3D 2)
+		return error(_("path '%s' does not have our version"), ce->name);
+	else
+		return error(_("path '%s' does not have their version"), ce->name);
 }
=20
 static int checkout_merged(int pos, struct checkout *state)
--=20
1.7.2.3
