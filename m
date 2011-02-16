From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1.5/2] bash: teach __git_ps1 about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 15:55:41 -0600
Message-ID: <20110216215541.GD2615@elie>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
 <1297850903-65038-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:55:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PppLn-0003SI-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1BPVzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:55:51 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36615 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab1BPVzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:55:50 -0500
Received: by qyk12 with SMTP id 12so1961246qyk.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 13:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=n0Bog/I2WAWAx4YMjKYhlPQlVKxx4H/T3v6zvf61Q5c=;
        b=X2MRTSXn7QbxO/Uicof9+VqulHZZTj4ZFj+bd17qHAKwKOJN/fRKJ9bdGODmy75Hne
         zuwLTp0mqCTsI6kzO5RYJ9BKT2HLJU4vsk5E0EklAJGF0UUwjB7Ig4oeXGxpHkoumAbu
         x1VNU+9U5eJaIhLWdxWWY5M+pcOcq+4ifpDpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xregtbFYv1oTH/3BMJ1d0Sd0edRVOgA2BChkH5fCZXZ3J560xa3eW4u9wmuQiX41az
         gLwNI/oYEqlOVgdTV+vJjGh7hhyECqR7IV/z0uLQLsrRHrx+tA8tGR7aU+q3A551SFNU
         3u7leq1d0hwSChgzr0I3zvwmKtueMAZI8wib0=
Received: by 10.224.45.74 with SMTP id d10mr1490159qaf.304.1297893349042;
        Wed, 16 Feb 2011 13:55:49 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id p13sm165617qcu.29.2011.02.16.13.55.46
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 13:55:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297850903-65038-3-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167009>

From: Jay Soffian <jaysoffian@gmail.com>

Make the git prompt (when enabled) show a CHERRY-PICKING indicator
when we are in the middle of a conflicted cherry-pick, analogous
to the existing MERGING and BISECTING flags.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
> * While we're at it, we update git-completion.bash to be
>   CHERRY_PICK_HEAD aware.

Hmm, it seems I don't like this "while at it". :)

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
1.7.4.1
