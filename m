From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 4/4] completion: fix remote.pushdefault
Date: Fri,  3 Jan 2014 13:30:31 +0530
Message-ID: <1388736031-6068-5-git-send-email-artagnon@gmail.com>
References: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 09:01:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyzgg-0005d3-21
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 09:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbaACIAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 03:00:52 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47295 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaACIAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 03:00:51 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so15135350pde.0
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 00:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OkOwTdvK7Bq3cpU63N6AojNwKxucM8MYiflELTpM+t4=;
        b=ESaPhWmpkzNfA9HXfs9Uv1Hmkc+tbhbOvnEUMMsEZ+PObT3ZteVCOhUj5pGFd0MBfi
         eAb2LKsGMCUS1xLdq5AQG4VMG8OrE7gYIhzy1lNiHDdK+TeaXv31JB8UQ+r4WxFXplAy
         ReQfGsCW/80SIGwRWrQvqUuJwzQ0Ud++4bzp6ytEhyYXRP3sofOdSIqYGvKrgeS2NTy8
         3yLr9eCu3vMWqjalWU0/16M1Y5kov/f7YO/NB1/Cb41Tk+ykpKoapF5c9AC0b+z6O6wK
         j71hnZpfSPz5IEwW/DvLm+w/zZhOiNRdcn9NJ3x9Prl2zo9qmYmQ4toym1NrHot6UdcU
         mjaQ==
X-Received: by 10.66.146.229 with SMTP id tf5mr32700325pab.50.1388736046618;
        Fri, 03 Jan 2014 00:00:46 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id gf5sm106943913pbc.22.2014.01.03.00.00.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 00:00:46 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239910>

When attempting to complete

  $ git config remote.push<TAB>

'pushdefault' doesn't come up. This is because "$cur" is matched with
"remote.*" and a list of remotes are completed. Add 'pushdefault' to the
list of remotes using __gitcomp_2 ().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cbb4eca..04d72a1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1900,7 +1900,7 @@ _git_config ()
 		;;
 	remote.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
-		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
+		__gitcomp_2 "$(__git_remotes)" "pushdefault" "$pfx" "$cur_" "."
 		return
 		;;
 	url.*.*)
-- 
1.8.5.2.227.g53f3478
