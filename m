From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 2/4] bash: teach __git_ps1 about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 23:18:43 -0500
Message-ID: <1297916325-89688-3-git-send-email-jaysoffian@gmail.com>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 05:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpvL9-0007tY-6q
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab1BQETN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:19:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49724 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab1BQETI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 23:19:08 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so2060916qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 20:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=3eWW/C0b8UHX9ZerQempvHVb3ht2BLVTneuRVqgTyHY=;
        b=KfvWGesZgThypMu1oF4rjNetBhGP36ry2KR/DWlMwWklYch1Rqla/+lLxkndA7LGQx
         vigObllFJrWBQoNvQcQZMo3UXPjaWOEX0BbG6m9YkTS8GAkxF05ATHZHeqMTyOEX8bXO
         M1IN1jW12UO44uJwxhLD3XNhHjGyZGphPUIME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Tr1MmAyULvi7hclEKNJZR8/7yKDQkC/7sznL+GtnYl9owidYLQhu01R/PER2/YqnMc
         Slol+HOsRodyd7NDu/X7LFoau9s0GOIyEiCN4h9LgwwoodU4gsguE0BdzlVOOHUZwQab
         qr+mdYfY61gIj/M+5rJJhak9C2NYiWxE+lzyY=
Received: by 10.224.45.132 with SMTP id e4mr1815520qaf.296.1297916346158;
        Wed, 16 Feb 2011 20:19:06 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id y17sm410634qci.9.2011.02.16.20.19.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 20:19:05 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.g7fe09
In-Reply-To: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167033>

Make the git prompt (when enabled) show a CHERRY-PICKING indicator
when we are in the middle of a conflicted cherry-pick, analogous
to the existing MERGING and BISECTING flags.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Split this out into its own patch per 
http://article.gmane.org/gmane.comp.version-control.git/167009

 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 893b771..0b0b913 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -246,6 +246,8 @@ __git_ps1 ()
 				fi
 			elif [ -f "$g/MERGE_HEAD" ]; then
 				r="|MERGING"
+			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
+				r="|CHERRY-PICKING"
 			elif [ -f "$g/BISECT_LOG" ]; then
 				r="|BISECTING"
 			fi
-- 
1.7.4.1.30.g7fe09
