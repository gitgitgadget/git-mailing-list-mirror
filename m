From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2] rebase -X: do not clobber strategy
Date: Wed, 10 Nov 2010 08:14:26 +0100
Message-ID: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 10 14:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGAW2-0006jp-OC
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 14:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992Ab0KJNPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 08:15:01 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47314 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab0KJNPA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 08:15:00 -0500
Received: by qyk12 with SMTP id 12so3007808qyk.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 05:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=e8Nudwe8rFN4OQRbBXpxjx2CIRJoTx7e/cgR+7LO2nM=;
        b=rZ7udhB/Uu22wnZZKxV64pXCdcBaDQ5CMKh5Pz/582TjOhD0O/TR496BG/bbfNYrcJ
         C4nTtKwUIrbpz8pnYHLTH0Hq6fl9EVuyhc3c91YU22C8XHbDsNvtQTFIaNykTjBjZQvO
         thx2ekHltzkWKpNsg6uJ0hIj02d3gwyIOQb9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Q2QcBVQ99LGqwsA07yIMAZIoiPvbi6PEuNqvkhJvy38dkpPK4tyha7IBRpnlCh2a2P
         q6iruK1oAEKmeVTMoXmWPYvg2x1A/3BVNX0dxyDYmlFBtnrkCo4BEuk+dNKpYiUeO5xz
         hWi+SXzvzDF5NKHNzTP/a8pP4x1ybcsl95kxg=
Received: by 10.224.216.6 with SMTP id hg6mr6612849qab.112.1289394899668;
        Wed, 10 Nov 2010 05:14:59 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id m7sm633054qck.37.2010.11.10.05.14.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 05:14:59 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161150>

If any strategy options are passed to -X, the strategy will always be
set to 'recursive'. According to the documentation, it should default to
'recursive' if it is not set, but it should be possible to set it to
other values.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 42c0628..ec08f9c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -312,10 +312,6 @@ do
 		esac
 		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$newopt")"
 		do_merge=t
-		if test -n "$strategy"
-		then
-			strategy=recursive
-		fi
 		;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
-- 
1.7.3.2.167.ga361b
