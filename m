From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try3] completion: use more proper emulation for zsh
Date: Sun, 11 Nov 2012 14:51:24 +0100
Message-ID: <1352641884-27444-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 14:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXXxL-0003tQ-Ik
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 14:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab2KKNv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 08:51:58 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64699 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2KKNv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 08:51:57 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2061296bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XM3KodW6wp2I7I+BaQ9vTtw4BxK6UXziiz4KIFQ+YkQ=;
        b=zkmEMImCS9eW0vaAd6NTGh3pE8SuEY26RxivqP12JN8685FDz9MAmTuHPNc1qu1Ncs
         E8RhbdgduRMinCAGE0+zKPxM86V8v/kFQge4FQmwjtbREgQwowOZlwOm20C7HLcqF56X
         ZP9d0UHtOeUCuSIf2xzTJL+QIucFYTqiJXUH37T197xJlOiZEeL0/2TtCbmYW+0o07Zz
         1aQd9lo3anh576PvX1QBCh/YvNrUGDyfZh/uVRPXhuijQxIRymgAFhXtBG+fda6ikrS7
         lh44GKPsILGgt/o+qgePvD8NA8gisyrkPxgpFiLlNljQ6O/uUwBSeN00dJoXEuDRSWEg
         bCXg==
Received: by 10.204.150.218 with SMTP id z26mr1230749bkv.95.1352641915908;
        Sun, 11 Nov 2012 05:51:55 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id z22sm1486153bkw.2.2012.11.11.05.51.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 05:51:54 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209354>

It turns out there's no 'bash' emulation in zsh. Anything that starts
with a 'b' is mapped to the 'sh' emulation, presumably because of
_b_ourne shell.

kzh emulation seems closer to bash, and at least I haven't had problems
with this.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This is the third time I send this patch.

 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..d7439a5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2432,8 +2432,7 @@ __gitk_main ()
 __git_func_wrap ()
 {
 	if [[ -n ${ZSH_VERSION-} ]]; then
-		emulate -L bash
-		setopt KSH_TYPESET
+		emulate -L ksh
 
 		# workaround zsh's bug that leaves 'words' as a special
 		# variable in versions < 4.3.12
-- 
1.8.0
