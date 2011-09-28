From: Auke Schrijnen <auke@schrijnen.nl>
Subject: [PATCH] git-completion: offer remotes for 'git remote update'
Date: Wed, 28 Sep 2011 10:54:28 +0200
Message-ID: <1fe2227149aa8b1024dd0f220e32af20@schrijnen.nl>
References: <347b845858abcc62551d83df324e5c10@schrijnen.nl>
 <7v8vp9trvu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 10:54:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8puU-0001P4-QV
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 10:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab1I1Iya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 04:54:30 -0400
Received: from server6.bhosted.nl ([94.124.120.40]:1243 "HELO
	server6.bhosted.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752509Ab1I1Iya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 04:54:30 -0400
Received: (qmail 29543 invoked by uid 1011); 28 Sep 2011 10:54:28 +0200
In-Reply-To: <7v8vp9trvu.fsf@alter.siamese.dyndns.org>
X-Sender: auke@schrijnen.nl
User-Agent: Roundcube Webmail/0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182302>

Completion for 'git remote update' only offers configured remote
groups. This is fine if one uses remote groups but there is no
completion without those groups.

Add all remotes to the completion when no configured groups are found.

Signed-off-by: Auke Schrijnen <auke@schrijnen.nl>
---
  contrib/completion/git-completion.bash |    6 +++++-
  1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
index 8648a36..12058bf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2298,7 +2298,11 @@ _git_remote ()
  			i="${i#remotes.}"
  			c="$c ${i/ */}"
  		done
-		__gitcomp "$c"
+		if [ -z "$c" ]; then
+			__gitcomp "$(__git_remotes)"
+		else
+			__gitcomp "$c"
+		fi
  		;;
  	*)
  		COMPREPLY=()
-- 
1.7.6.1
