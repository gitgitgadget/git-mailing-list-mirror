From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 1/4] zsh completion: find matching custom bash completion
Date: Sun,  5 Jan 2014 15:48:02 +0530
Message-ID: <1388917085-18701-2-git-send-email-artagnon@gmail.com>
References: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 11:18:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzkmd-0002ev-5h
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 11:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaAEKSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 05:18:09 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:60192 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaAEKSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 05:18:06 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so17008002pdj.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dwi2ZoVwHEK7pd0ZRmy47UgbjW+xZ4ngGlN+lEXCwRY=;
        b=R305ubiMqNKBgg+m9MJJpditrxK+lwEQqwbtfgLM0FVxqnKQLHhkoQ+mqSY5+X8/Sf
         68hI7n+mkQJoZSr4XHrMkAtP5VJPV5ImFGNrstC9lhEm/Di14No/YIMREikaOV1mw+2U
         i8QEInX5pTKlavAsCGyyPWQ61Dg/g1MzFkVBMhsmIt7nNtqptnqlnQTar0aqXcjhMR1/
         MRaoHda3XwwwscprOfWeuomv4/y4gIrn9AWwGBD76ii4/CBoXokRQy+pGmzplxyZFjha
         EsEKZwxIepc9J0P1wkgzDeNQB/f1YczoMBONYxdli/ZKStEFAVVRceMcgnVEz2tgPi43
         eFKw==
X-Received: by 10.68.253.7 with SMTP id zw7mr112385596pbc.83.1388917085964;
        Sun, 05 Jan 2014 02:18:05 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id fk4sm25113615pab.23.2014.01.05.02.18.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2014 02:18:05 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239962>

If zsh completion is being read from a location that is different from
system-wide default, it is likely that the user is trying to use a
custom version, perhaps closer to the bleeding edge, installed in her
own directory. We will more likely to find the matching bash completion
script in the same directory than in those system default places.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index fac5e71..6fca145 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -30,10 +30,10 @@ if [ -z "$script" ]; then
 	local -a locations
 	local e
 	locations=(
+		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
 		'/etc/bash_completion.d/git' # fedora, old debian
 		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
 		'/usr/share/bash-completion/git' # gentoo
-		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
 		)
 	for e in $locations; do
 		test -f $e && script="$e" && break
-- 
1.8.5.2.227.g53f3478
