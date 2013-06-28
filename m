From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] completion: prefer to use local git-completion.bash
Date: Fri, 28 Jun 2013 19:48:08 +0530
Message-ID: <1372429088-385-5-git-send-email-artagnon@gmail.com>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZYS-0001hh-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab3F1OVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 10:21:37 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55131 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab3F1OVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:21:36 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so2484663pab.31
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i6Bos9OKFA4HLISKcqyusqIxTzGCrzR+GLqnYlxam78=;
        b=Vtg6tFjI28TCFmp+KIFPZY9of2eQXOQdZz8UEIHBeR8XT0DLy53eslE5jHCL3dZKZf
         ZvBAHcAY9hYPfdPAxRdNuvsWvlLEDUXPnRdpX7Qzx1/vGZne8eHM7SyYwqoQb7Vvxuq+
         WrkN4QdIrrEQ7FC4Wk2ypLdsLE/8CarwdvuEg0G+PucFrlFw5gvB79cMPsDa82CSpUFb
         qQ80EYHR64GdlkvkMg+EcZ/mYUC6aOjGmvWnIbtg+B+etKFQgy+UfFY14GXSybIFIl30
         5anVOpKJZCDZuJgpNSb3BtO5JI2Ak18cKy9QPdowCBbM/QzQd797YZ7o1ji7Nhl+tXFS
         UsoQ==
X-Received: by 10.68.52.10 with SMTP id p10mr11765821pbo.92.1372429294500;
        Fri, 28 Jun 2013 07:21:34 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id iq6sm8397665pbc.1.2013.06.28.07.21.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 07:21:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.585.g9832cb9
In-Reply-To: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229205>

git-completion.zsh looks in various "default" locations for
git-completion.bash.  During development, the location

  $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash

is the most obvious and up-to-date version.  Push it up on the list of
locations.

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
1.8.3.1.585.g9832cb9
