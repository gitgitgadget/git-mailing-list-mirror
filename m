From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] rebase -i: explain how to discard all commits
Date: Sat, 15 Jan 2011 20:02:07 -0600
Message-ID: <20110116020207.GC28137@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:02:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeHwj-0004At-DP
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab1APCCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 21:02:16 -0500
Received: from mail-yi0-f42.google.com ([209.85.218.42]:51412 "EHLO
	mail-yi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab1APCCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 21:02:15 -0500
Received: by yia28 with SMTP id 28so2072539yia.1
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 18:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xn+w2EEAkECQtqpsmGCSR3CW0JlI99aEb8XbGE6jKwE=;
        b=oj29XJJogRRvvO+yMDGCZPCmXT4bf95iBz3CMq05DveQp07m9ZN6K52TpC/D+tmDrd
         I+qljn4arPkMC1HDNjiwR60tkvDgmVsR4yM7WXPYzDko0mB2PvDqJsjfYFwc7cQLfIFm
         KNPxGn7oZClUN6teQbG0wLfpy2GcpORZr5xx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eeLUzS4fRMUnfikyWEL9ItzCrT0aC4SuuqxFuuU/nonbOBCg67e4nFUV9WQL0B0hb0
         ln7aCb41aDrsv7hjeSaZhv+DAC9RKYHHLHVdzURADqJGZPv8SmGZLmUhW/PSPyA9OPDt
         4nQjfblOFlUXClEQykLebPjGLejQjYmqpmIbY=
Received: by 10.100.164.1 with SMTP id m1mr1655239ane.269.1295143335175;
        Sat, 15 Jan 2011 18:02:15 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id d15sm3479992ana.35.2011.01.15.18.02.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 18:02:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110116015941.GA28137@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165152>

Preparing a patch series for submission (as explained under
INTERACTIVE MODE in the git rebase manual) sometimes involves
discarding commits representing changes that turned out to be a bad
idea.  Usually this is quite simple to do by deleting the appropriate
"pick" lines, but if all commits are removed then the "remove
everything means abort" logic kicks in and the rebase is cancelled.
One can override that behavior by adding a line with the text "noop".

This is a follow-up to v1.6.0.3~21 (rebase -i: do not fail when there
is no commit to cherry-pick, 2008-10-10).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-rebase--interactive.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 09aeecf..d9dfc75 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1025,6 +1025,7 @@ first and then run 'git rebase --continue' again."
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
+# Use the "noop" command if you really want to remove all commits.
 #
 EOF
 
-- 
1.7.4.rc2
