From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] bash completion: add space between branch name and status
	flags
Date: Wed, 30 Dec 2009 19:04:38 -0800
Message-ID: <20091231030438.GH6914@spearce.org>
References: <200911201309.16193.roman.fietze@telemotive.de> <7v4oopxeuf.fsf@alter.siamese.dyndns.org> <20091230224129.6117@nanako3.lavabit.com> <20091230145751.GE6914@spearce.org> <7veimc1cv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Roman Fietze <roman.fietze@telemotive.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 04:04:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQBLF-0006qD-GX
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 04:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbZLaDEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 22:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753097AbZLaDEn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 22:04:43 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:42663 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZLaDEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 22:04:42 -0500
Received: by iwn1 with SMTP id 1so8844932iwn.33
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 19:04:42 -0800 (PST)
Received: by 10.231.5.23 with SMTP id 23mr25581ibt.45.1262228682045;
        Wed, 30 Dec 2009 19:04:42 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm13370037iwn.4.2009.12.30.19.04.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 19:04:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7veimc1cv6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135930>

Improve the readability of the bash prompt by adding a space between
the branch name and the status flags (dirty, stash, untracked).

While we are cleaning up this section of code, the two cases for
formatting the prompt are identical except for the format string,
so make them the same.

Suggested-by: Roman Fietze <roman.fietze@telemotive.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
   Junio C Hamano <gitster@pobox.com> wrote:
   > I notice that printf argument look very similar.  Maybe we want to do
   > something like
   > 
   >     printf "${1:-" (%s)"}" ...
   > 
   > to avoid duplication?
   
   Ack.

   Because its rather far from the original poster's patch, I've
   taken blame for it.
   
 contrib/completion/git-completion.bash |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fbfa5f2..9ed7df2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -163,11 +163,9 @@ __git_ps1 ()
 			fi
 		fi
 
-		if [ -n "${1-}" ]; then
-			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
-		else
-			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
-		fi
+		local f="$w$i$s$u"
+		f="${f:+ $f}$r"
+		printf "${1:- (%s)}" "$c${b##refs/heads/}$f"
 	fi
 }
 
-- 
1.6.6.325.g6f5f

-- 
Shawn.
