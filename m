From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v4 3/4] bash: teach __git_ps1 about CHERRY_PICK_HEAD
Date: Sat, 19 Feb 2011 23:12:28 -0500
Message-ID: <1298175149-41178-4-git-send-email-jaysoffian@gmail.com>
References: <1298175149-41178-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 20 05:13:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr0fn-0002em-Os
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 05:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1BTENT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 23:13:19 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53232 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab1BTENS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 23:13:18 -0500
Received: by mail-qw0-f46.google.com with SMTP id 7so1290012qwd.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 20:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/qgkZ1GSdN4irN+E+mh1QWJSZxe6KH/dl0xIwvBMXGw=;
        b=Z8hSgT7ubS9xxJlXu0IgmZnXJ+9ykH6OqTewnc8hTg58zagAqf+oeX6kNxSxxYkKYu
         K7sHt1ZwOF/mG+Aj95XwsEJ+a2r8fAM0Cpw5rzUa1w6aGmL0Zc4f2u8P/xraTiNphUyf
         xq1pnmN1MZSZy2YRK9ed5DvA7/K2KZo2+aeMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hbor3swiHH2gDTmCKrdJCh9SaFx9M36yudJ+qLbsyrfgszkbc4BCbiOWThacPSGtxg
         lL68rRGwsUTBGRCDQOjPXac8U7Tvvj88uzfoKxpEUb3s+fbhFjdDoFMU7CZC9Ig+AfPW
         nNrA+rxlCYpqjfM+8kJTVk85bqQoobRK9XVnY=
Received: by 10.224.20.73 with SMTP id e9mr1997151qab.74.1298175197693;
        Sat, 19 Feb 2011 20:13:17 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id y17sm2780000qci.33.2011.02.19.20.13.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 20:13:17 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.51.g615e0
In-Reply-To: <1298175149-41178-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167399>

Make the git prompt (when enabled) show a CHERRY-PICKING indicator
when we are in the middle of a conflicted cherry-pick, analogous
to the existing MERGING and BISECTING flags.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
1.7.4.1.51.g615e0
