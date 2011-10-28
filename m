From: David Kastrup <dak@gnu.org>
Subject: git rebase -p does not find mainline
Date: Fri, 28 Oct 2011 09:51:14 +0200
Organization: Organization?!?
Message-ID: <874nytlfkd.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 09:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJhE2-0008Ph-M2
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 09:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab1J1Hve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 03:51:34 -0400
Received: from lo.gmane.org ([80.91.229.12]:59888 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab1J1Hvd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 03:51:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJhDw-0008Nb-AW
	for git@vger.kernel.org; Fri, 28 Oct 2011 09:51:32 +0200
Received: from p508edece.dip.t-dialin.net ([80.142.222.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 09:51:32 +0200
Received: from dak by p508edece.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 09:51:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p508edece.dip.t-dialin.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.90 (gnu/linux)
Cancel-Lock: sha1:trZ/DRUOnuQTfUBR+B++sQyGXFM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184342>


When doing git rebase -p in order to do a non-trivial rebase tracking
merges, I get a message about a missing -m option for specifying the
mainline.

git rebase does not have the corresponding option.  The fix is to do

git cherry-pick -m 1 offending-merge-commit
git rebase --continue

but that is quite unobvious from the resulting error message that does
not even mention "cherry-pick".  Since git rebase -p is supposed to
"preserve merges", it should just cherry-pick with the same mainline
that the original merge commit had, without asking the user questions or
even failing.

This is the version of git delivered with Ubuntu 11.10, namely 1.7.5.4.

-- 
David Kastrup
