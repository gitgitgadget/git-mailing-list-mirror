From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] Remove stray error message from sed
Date: Tue,  1 Jun 2010 11:20:22 +0200
Message-ID: <1275384022-12131-4-git-send-email-artagnon@gmail.com>
References: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:19:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNd5-0001dK-RK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab0FAJTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:19:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:51310 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab0FAJTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:19:17 -0400
Received: by ey-out-2122.google.com with SMTP id 9so123004eyd.5
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ir6AAO92yG7bNoDvdqqqV9CUYmazatKLfov1Up0fgvM=;
        b=QA/7+jpXJ4dssblYq4L3+Q2fcGYHlEDczJrEv2Q7e8DwJu0c2pSpUSdgCglkFqiLYu
         Jnr06iOK2vKj2CXDBj4KsCqqkVdXU69Kep6Y3rqN6hokQE12Hf6MEvhPYi5vugjele0D
         nFo8QxsnsdCXuaxIo7iD3C0F5355NNqLiWy+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lwtMh6Srh9KXYqf7XLtLbA9fA3u4ub2FjhQU536I5pzmu/OcO9ztTxENsfVa6AcF1U
         5zY2wsZUJd5DAaQYHUKZqndwson9V5B/JKi6kFvIZ47GroaqKJSKdMqVtf1RGGzMbumr
         9+0nfoCqzYs/sh5Cu0td0FnnI1gPwseeFhVrQ=
Received: by 10.213.28.138 with SMTP id m10mr3128193ebc.17.1275383956397;
        Tue, 01 Jun 2010 02:19:16 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm3622063ewy.5.2010.06.01.02.19.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 02:19:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148097>

When --continue is invoked without any changes, the following stray
error message appears- sed: can't read $dotest/final-commit: No such
file or directory. Remove this by making sure that the file actually
exists.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 04f02a8..e61f47a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -693,7 +693,7 @@ do
 	else
 	    action=yes
 	fi
-	FIRSTLINE=$(sed 1q "$dotest/final-commit")
+	test -e "$dotest/final-commit" && FIRSTLINE=$(sed 1q "$dotest/final-commit")
 
 	if test $action = skip
 	then
-- 
1.7.1
