From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase: allow -X for non-recursive strategy
Date: Tue,  9 Nov 2010 21:58:19 +0100
Message-ID: <1289336299-28282-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 10 04:04:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG0z7-0006JL-BP
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 04:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab0KJDEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 22:04:24 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54780 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab0KJDEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 22:04:24 -0500
Received: by qyk12 with SMTP id 12so2539043qyk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 19:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NlTXisF7xJ2sJGZ5otQPb0xe2iIsLysG5fi0wv/L/p0=;
        b=Sv+OAtnzO+AQ7qnp6lFxAIAshl/fRzRHPnGF8roJxcrPcT6vBgThRnliYtXcRGDahU
         7WOzdz6ve/V86hXm2I2z93oKwxRi5e242ja+2esaMw4jAxv6qSzqeRlq1rm9ZG2Kb/C1
         TGB29DXlSrnc1NW+TvtxvvO0zaKQkB8iL5jZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=q+duVzeRohIBVQCvqu2u+enQaHf6G63Y5W3dvIS6o3Lk8iVIMcZ79zLF0eV7tuyqlE
         WLixmkWL3TjWyrQWSQeb/ycc0AVpoX3ODMti0kT9xNP5gE3UZCvtmZlMgri5Gnq1253q
         qF1tEBST6ZU++R0Jj+cIzYbdXGrk2o+M3p2uw=
Received: by 10.224.193.195 with SMTP id dv3mr693524qab.180.1289357930414;
        Tue, 09 Nov 2010 18:58:50 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id j21sm90601vcr.10.2010.11.09.18.58.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 18:58:48 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161126>

If any strategy options are passed to -X, the strategy will always be
set to 'recursive'. According to the documentation, it should default to
'recursive' if it is not set, but it should be possible to set it to
other values.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Maybe I'm missing something, but it looks very much like that '-n'
should have been a '-z'. But still, 'strategy' is set to 'recursive' at
the start of the script and doesn't seem to be unset anywhere, so the
block shouldn't be necessary at all.

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
