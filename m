From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] completion: use git rev-parse to detect bare repos
Date: Mon, 18 May 2009 18:24:30 +0200
Message-ID: <1242663870-11895-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 18 18:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M65e8-0006U4-A9
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 18:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbZERQYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 12:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbZERQYo
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 12:24:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:62388 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbZERQYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 12:24:43 -0400
Received: by fg-out-1718.google.com with SMTP id d23so658471fga.17
        for <git@vger.kernel.org>; Mon, 18 May 2009 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Zd6LgcYWqLXC51rbb+WayoKx/hXwG1REQLNbKM6+FxE=;
        b=J48DsQEqz4AOv1B8mmAfvxu/JzrHbevNw4ZrrcvUdLg5ABK0c8lulazQ4gPc+nettZ
         sqDdHUBhjNRB4u2yGvg0hfyAQNlOVtGA9WjBaEQJJZDzEtLbLn3EKKaA6Ht3ceLtN5O9
         69XmuAIPFG1W86Lx+Ptq2Vfqcr9d1nmjPzNTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=T8TynxpeNilJiw0eAvPjGcmmrai/c3wHJpOW80/cYEjm95cnecJbUOdmtlO9ieQBeb
         ClHSUOP6IYj7klfomR2pgHaJY1E+wgeari/lkt4kE0adr/RN8diu6LHdOeWJtsLmHAYP
         8dVs2X0IEFA+/1OHrOuwkwPaXC2cfOHCxDIvQ=
Received: by 10.86.49.13 with SMTP id w13mr6919770fgw.31.1242663882048;
        Mon, 18 May 2009 09:24:42 -0700 (PDT)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id l12sm562100fgb.6.2009.05.18.09.24.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 09:24:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.137.g29aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119456>

Its check is more robust than a config check for core.bare
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba13c49..0c8bb53 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -132,7 +132,7 @@ __git_ps1 ()
 		local c
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
-			if [ "true" = "$(git config --bool core.bare 2>/dev/null)" ]; then
+			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
 				c="BARE:"
 			else
 				b="GIT_DIR!"
-- 
1.6.3.1.137.g29aa
