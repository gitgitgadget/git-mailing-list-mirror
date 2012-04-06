From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: use more proper emulation for zsh
Date: Fri,  6 Apr 2012 15:19:04 +0300
Message-ID: <1333714744-21481-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Mark Lodato" <lodatom@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 14:19:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG88w-0004eR-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 14:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab2DFMTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 08:19:23 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55323 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752989Ab2DFMTW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 08:19:22 -0400
Received: by lahj13 with SMTP id j13so2114643lah.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ampCq5t9kpvNPpUYlHq2Vct4Sxz6DPsffq3gi7hlOXs=;
        b=NiDAnNaf1Q8bFdLk0yY+jJAyjMELoapJDFfwm887LA+SMHkfNLNctQZrthCyupawsN
         /MyVASapLZDyuubxVEmUb25EDJRf8UXJMpoFaWSK2ecITWSgmviTb/4CwOwZPM4O7MEC
         owO5hI4RETu2pOnIyCwkDgof0eYUj1+Adtf9MCX6k24My4/tyL8bDF8d/HcZD2Kf5fej
         Wt9iW1ERwJJWZy+Qmymv1gK1K+FHoKgwMYbR68VSSHc/Ix2gEhzr/jKhUnv+tvx9sFFf
         33ffQcesp5Yd6S0s9dfKB+/PIX9o93hcOlGPqvSx7TTyARPjga4acC+vlhiz4DgksxfO
         SIDg==
Received: by 10.152.127.163 with SMTP id nh3mr8348671lab.15.1333714760643;
        Fri, 06 Apr 2012 05:19:20 -0700 (PDT)
Received: from localhost (80-186-93-53.elisa-mobile.fi. [80.186.93.53])
        by mx.google.com with ESMTPS id ox7sm8772080lbb.17.2012.04.06.05.19.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 05:19:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194867>

It turns out there's no 'bash' emulation in zsh. Anything that starts
with a 'b' is mapped to the 'sh' emulation, presumably because of
_b_ourne shell.

kzh emulation seems closer to bash, and at least I haven't had problems
with this.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..e75925f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2604,8 +2604,7 @@ _git ()
 	local i c=1 command __git_dir
 
 	if [[ -n ${ZSH_VERSION-} ]]; then
-		emulate -L bash
-		setopt KSH_TYPESET
+		emulate -L ksh
 
 		# workaround zsh's bug that leaves 'words' as a special
 		# variable in versions < 4.3.12
@@ -2664,8 +2663,7 @@ _git ()
 _gitk ()
 {
 	if [[ -n ${ZSH_VERSION-} ]]; then
-		emulate -L bash
-		setopt KSH_TYPESET
+		emulate -L ksh
 
 		# workaround zsh's bug that leaves 'words' as a special
 		# variable in versions < 4.3.12
-- 
1.7.9.6
