From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2 v2] rebase -i: clarify in-editor documentation of "exec"
Date: Thu, 20 Jan 2011 18:36:24 -0600
Message-ID: <20110121003624.GB23139@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
 <20110116020132.GB28137@burratino>
 <vpq39otrvmk.fsf@bauges.imag.fr>
 <20110120200949.GB11702@burratino>
 <7vy66fqoji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 01:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4zg-00012G-4u
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 01:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936Ab1AUAgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 19:36:43 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40348 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab1AUAgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 19:36:42 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so543098vws.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bY10U3Q/FyaKaJy/2OXZR/KvoF9hkF8pX/qZ54fDU30=;
        b=ZWtdXW1Jyh4oVa8PEJRncNm4PjDu+rcX0CaItCxKUdA+fxJPYIIzuwB78tBN6NU/eH
         YDzE+5UFE9FA6uh0C+AdVLSRq+t2ahQw1QyyUmTYAf485u1KDQm4N4qXL+mBGrXEzvTK
         4e40SQFQHO20BruxO9Re0cpAdw8LRrCaYHFiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xWrTaJ0S/e8G0hQT5DL3T6wx8qfWRA2wS9J/fbOofNClLsNSfZMrQkJwMDQSkc8YZ6
         wsOeEGOB7PeUX1ORxVYvlOgow4ybJqhxqFcUAlJ7G6VQPhH13FDd5HVmfuxJxGePMOif
         MgOjWOR7jULUm5SbAMsusatgRaDJq1Hm6y9QI=
Received: by 10.220.182.137 with SMTP id cc9mr438760vcb.99.1295570201761;
        Thu, 20 Jan 2011 16:36:41 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id e18sm5300924vbm.5.2011.01.20.16.36.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 16:36:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vy66fqoji.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165353>

The hints in the current "instruction sheet" template look like so:

 # Rebase 3f14246..a1d7e01 onto 3f14246
 #
 # Commands:
 #  p, pick = use commit
 #  r, reword = use commit, but edit the commit message
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
 #  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #

This does not make it clear that the format of each line is

	<insn> <commit id> <explanatory text that will be printed>

but the reader will probably infer that from the automatically
generated pick examples above it.

What about the "exec" instruction?  By analogy, I might imagine that
the format of that line is "exec <command> <explanatory text>", and
the "x <cmd>" hint does not address that question (at first I read it
as taking an argument <cmd> that is the name of a shell).  Meanwhile,
the mention of <cmd> makes the hints harder to scan as a table.

So remove the <cmd> and add some words to remind the reader that
"exec" runs a command named by the rest of the line.  To make room, it
is left to the manpage to explain that that command is run using
$SHELL and that nonzero status from that command will pause the
rebase.

Wording from Junio.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> If we wanted to be more helpful, perhaps s/(see below)/specified on the
> rest of the line/ should be sufficient without adding extra lines.

Sounds good.

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a5ffd9a..a18c9b1 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1021,7 +1021,7 @@ first and then run 'git rebase --continue' again."
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
-#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
+#  x, exec = run command specified on the rest of the line
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
-- 
1.7.4.rc2
