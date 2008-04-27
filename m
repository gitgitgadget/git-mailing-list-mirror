From: Richard Quirk <richard.quirk@gmail.com>
Subject: [PATCH] bash: Add completion for gitk --merge
Date: Sun, 27 Apr 2008 17:35:10 +0200
Message-ID: <1209310510-7201-1-git-send-email-richard.quirk@gmail.com>
References: <20080427041816.GH29771@spearce.org>
Cc: git@vger.kernel.org, spearce@spearce.org,
	Richard Quirk <richard.quirk@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 27 17:36:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq8v6-0006Os-3o
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 17:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbYD0PfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 11:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbYD0PfR
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 11:35:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38413 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbYD0PfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 11:35:15 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1737541nfb.21
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=d2qrlGqvlfeJ36AEdUD/mYxYnkyfD4HXpm/hbGvZzZI=;
        b=e7L+mhxFNJFAzaNjV0pnw/Pfsx2sHKRQeSQg4/+txoANkxvp5wasLaiD3CepBy84MeAYLGYEh3ievaG6TaCUTlw9hXgsm/pD/HkD4hthQyvgowD34KrmznaiaI2SvnfbZzehvxDMaP5+lN8I90lDZzEoMriFGMxBhsNEVhmBoZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xVwV7HE3JGpH8uUFHb9xcBbrYbFQ5xrm4sVvfRUZPRGzzwZJkKmN01QBdPCS7c5vKlQ25djPSQke3WeYFd9Ge+DVaBJ+A7X9iCIau3y9qH1FKw0/gcPsEUJ3b0WiIx0TzG8DNMK8npcL3jDA+SotPDkHyLabhUpjGJ8ST+frQL0=
Received: by 10.210.23.3 with SMTP id 3mr4759917ebw.21.1209310514363;
        Sun, 27 Apr 2008 08:35:14 -0700 (PDT)
Received: from localhost ( [84.77.29.188])
        by mx.google.com with ESMTPS id k7sm6841583nfh.0.2008.04.27.08.35.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Apr 2008 08:35:13 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.79.g57cf
In-Reply-To: <20080427041816.GH29771@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80453>

Option is only completed when .git/MERGE_HEAD is present.

Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
---
 contrib/completion/git-completion.bash |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 665a895..23db664 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1346,9 +1346,14 @@ _git ()
 _gitk ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	local merge=""
+	if [ -f $g/MERGE_HEAD ]; then
+		merge="--merge"
+	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--not --all"
+		__gitcomp "--not --all $merge"
 		return
 		;;
 	esac
-- 
1.5.5.1.79.g57cf
