From: Cristian Peraferrer <corellian.c@gmail.com>
Subject: [PATCH] Added the 'errno' on die msg when the attempt to open the COMMIT_EDITMSG file fails.
Date: Tue, 27 May 2008 02:11:57 +0200
Message-ID: <B09AB9DB-FF7F-4B4A-9080-EB455DD10A96@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 02:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0moG-0005T5-Lp
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 02:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbYE0AMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 20:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754916AbYE0AMH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 20:12:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:29836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbYE0AMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 20:12:06 -0400
Received: by ug-out-1314.google.com with SMTP id h2so553048ugf.16
        for <git@vger.kernel.org>; Mon, 26 May 2008 17:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=e9m6yrtCO9TQgKKgXeZL662L5Oi3UlvUo2qEw46pISI=;
        b=NaEuW1Oey3RSljcwkEPpSl5G5NL18r4nw+NyjMXaaVAMHgmiG0WZyjF64HL+kyhYPFkTCB0C/zcgAJ7bdnYF0H+IgGiHZan7PjhoQK7oqZRC6AwzGLHtNWyp+gnK9xKugKp2Qviof3jtZsNkjG4+LTeIRHs683g+xw+ncANdi/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=bFth/iwSyPYQbY5BfweD3kf67cg9VUXe6Lb08uZk9g5lToPj9oSr44RUZ/1engHPQIAsbEp+afw5KB5NBwfEZtUSYMIiPYNM6bZcHuyzm60ovvI+BD4RgEpxeqUXTdatjZbU0eisfsxD9P/HqFg0AOMqh53p6x/nh+WiJHpAVYc=
Received: by 10.67.32.7 with SMTP id k7mr6172985ugj.22.1211847123200;
        Mon, 26 May 2008 17:12:03 -0700 (PDT)
Received: from ?192.168.1.5? ( [80.33.90.183])
        by mx.google.com with ESMTPS id c1sm2997814ugf.60.2008.05.26.17.12.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 May 2008 17:12:02 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82979>

I have added the strerror(errno) in the die message when the attempt
to open the COMMIT_EDITMSG file fails.

Signed-off-by: Cristian Peraferrer <corellian.c@gmail.com>
---
  builtin-commit.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 07872c8..014a406 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -500,7 +500,7 @@ static int prepare_to_commit(const char  
*index_file, const char *prefix)

         fp = fopen(git_path(commit_editmsg), "w");
         if (fp == NULL)
-               die("could not open %s", git_path(commit_editmsg));
+               die("could not open %s: %s", git_path(commit_editmsg),  
strerror(errno));

         if (cleanup_mode != CLEANUP_NONE)
                 stripspace(&sb, 0);
-- 
1.5.5
