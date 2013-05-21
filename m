From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: trivial fix for zsh
Date: Mon, 20 May 2013 19:33:03 -0500
Message-ID: <1369096383-28733-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 02:34:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeaXL-0002Ef-GP
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 02:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548Ab3EUAei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 20:34:38 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47824 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab3EUAei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 20:34:38 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so54585obc.7
        for <git@vger.kernel.org>; Mon, 20 May 2013 17:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=wDsha4jDxOmPT/lPFEKx9sAy5SJFQUfaVaZ9pUXGpps=;
        b=F8jMbbEPG9qpB4llD5Xa9+e/HXRRBzCmjlwZDYNJIw+8RDXyDRGGlwrqywR28XY04L
         iE5THEu+1fHXGKArup46Jq9xdUmc5lQyzCF/YgV+DbfH+jnSPqfrl0IGAlAoUSbXHoqR
         ++DqbxNC+ErfLXaorlK5stqS6lwM4KSGcw7ZPep+THPc/rqaqr5H5uF5O2r9+edkpWN/
         Yz5bHYR8eKUwQ8eAnxr4ZFw0L9xJUope8ZJRhaPTxCUcqu/+11s0ImbjvPC6iuK+PwGB
         +JqxOZXdXpzBhjMpYoCfN5FmrYTVN3ngosz91hgQQi19iIMZIglaZOR0YkRFjMh1lLTT
         yL2Q==
X-Received: by 10.60.178.242 with SMTP id db18mr27936493oec.74.1369096477583;
        Mon, 20 May 2013 17:34:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm267753oep.1.2013.05.20.17.34.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 17:34:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.286.g3d43083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225005>

zsh completion wrapper doesn't reimplement __gitcompadd(). Although it
should be trivial to do that, let's use __gitcomp_nl() which achieves
exactly the same thing, specially since the suffix ($4) has to be empty.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a98c2fd..1c35eef 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1831,7 +1831,7 @@ _git_config ()
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
 		if [ -z "$cur" ]; then
-			__gitcompadd "refs/heads/" "" "" ""
+			__gitcomp_nl "refs/heads/" "" "" ""
 			return
 		fi
 		__gitcomp_nl "$(__git_refs_remotes "$remote")"
-- 
1.8.3.rc3.286.g3d43083
