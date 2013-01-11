From: Dylan Smith <dylan.ah.smith@gmail.com>
Subject: [PATCH] git-completion.bash: Silence not a valid object errors
Date: Fri, 11 Jan 2013 03:06:22 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1301110304220.26739@antec>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 09:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtZdP-0003cq-6O
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 09:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab3AKIGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 03:06:19 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:38130 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab3AKIGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 03:06:18 -0500
Received: by mail-ia0-f175.google.com with SMTP id 21so1289951iay.6
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 00:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:user-agent:mime-version
         :content-type;
        bh=apLES+023ixC1lGxue2wAiWeaM5mRGI38yalIlFwBp4=;
        b=bvrKStrN84/UCU/s5KFymSbcpsZyLHBdDPB4AACdQlKzRp0b8/xNUy3Fxu71liSbaY
         tnxDraAqfoPVMSl1TbWfBRsej24lqkWvTC3xSDAk+K5+f6HgzmHbyyZtCFCbzHzJy6kk
         aTOvNc9JAKvx3YTKFnogkxyyVWqlrf7QQdttI0jwEbXLaS1FpsH6fIdcXoG96RPpkNJY
         1zr7UwL9il98vDNsKVKsuc38lf7iBbFLEexrHbuOc+0YHNS+A0Fc5VIK6uzgjs8VGkpM
         M8ixZHm4ecDtfibyQOT0fznNesJGLIhd0iIFyEtl/qm2epOTRGjGFyDhPNI55GkvL99u
         F3Gw==
X-Received: by 10.50.13.138 with SMTP id h10mr8319430igc.55.1357891577986;
        Fri, 11 Jan 2013 00:06:17 -0800 (PST)
Received: from antec ([108.162.129.103])
        by mx.google.com with ESMTPS id x7sm4123501igk.8.2013.01.11.00.06.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 00:06:17 -0800 (PST)
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213184>

Trying to complete the command

  git show master:./file

would cause a "Not a valid object name" error to be output on standard
error. Silence the error so it won't appear on the command line.

Signed-off-by: Dylan Smith <dylan.ah.smith@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..d4c7bfe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -397,7 +397,7 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
+		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
-- 
1.7.9.5
