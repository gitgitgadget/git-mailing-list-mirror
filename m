From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 30/31] rebase -i: don't read unused variable preserve_merges
Date: Sun,  6 Feb 2011 13:43:59 -0500
Message-ID: <1297017841-20678-31-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eK-0005ZO-QD
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab1BFSqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:49 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab1BFSqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:40 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=YpkGFoMQL+6xWF4N7h/8GHlbgCYXeSyDsVZQpRechk8=;
        b=Ds++t21KXCTSeNgO/38205ES+S/HqYMH2Kb1qH9L9douD0i1W5WszRARbtJs3IxIPN
         258n0rTZHEBJpvXfCKOi1eN67OJ41vFnxSgxWq1KbLqrCDn9klPYPNs61NVC/Y2bVtny
         6nKUbtpjz75lPakavmBYPQE69uqYJkdD9kg5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JICUmzeOQ6pquPb0QPKr7eXyEImvL27m6rN6iHQlD3fzaEoqQWC86NFuBZ2bCiDe/p
         S8C/OLRJD9DyIdARcVHGWPGUE2+4cGhmrb7GP/l+7IBWm7CCEM0Kp/Fdh2OsehvyqMwC
         bsdzH/aao8CTmm8h1qtP62Ld8G/9u3jqrOqxU=
Received: by 10.224.37.70 with SMTP id w6mr4240908qad.73.1297017999674;
        Sun, 06 Feb 2011 10:46:39 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:38 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166184>

Since 8e4a91b (rebase -i: remember the settings of -v, -s and -p when
interrupted, 2007-07-08), the variable preserve_merges (then called
PRESERVE_MERGES) was detected from the state saved in
$GIT_DIR/rebase-merge in order to be used when the rebase resumed, but
its value was never actually used. The variable's value was only used
when the rebase was initated.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Changes since v1:

 * Added back call to get_saved_options that I had removed by mistake
   while reordering commits.

 git-rebase--interactive.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5773b75..cf19bf5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -583,7 +583,6 @@ skip_unnecessary_picks () {
 }
 
 get_saved_options () {
-	test -d "$rewritten" && preserve_merges=t
 	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
-- 
1.7.4.rc2.33.g8a14f
