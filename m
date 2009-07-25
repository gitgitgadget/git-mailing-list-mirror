From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Sat, 25 Jul 2009 11:35:31 +0200
Message-ID: <200907251135.33164.trast@student.ethz.ch>
References: <20090723074104.GI4750@laphroaig.corp> <20090724170622.GA20247@sigill.intra.peff.net> <7v1vo537m0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 11:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUdfT-0007xY-1Z
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 11:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbZGYJfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 05:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZGYJfo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 05:35:44 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:40147 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZGYJfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 05:35:43 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 11:35:42 +0200
Received: from thomas.localnet ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 11:35:41 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <7v1vo537m0.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 25 Jul 2009 09:35:41.0919 (UTC) FILETIME=[46EC8EF0:01CA0D0B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123998>

Junio C Hamano wrote:
> 
> Yeah, such a stash entry would be more like "trash can".  It is not
> "to-be-deleted" but "have been deleted, but you _could_ resurrect".
> 
> It may not be a bad idea to do it that way, or perhaps "git checkout -p"
> can automatically create such a trash can while undoing the local changes
> in the work tree.

I'd rather implement this as part of the generic "worktree/index log"
that was proposed a while back, where any index- or
worktree-overwriting operation that actually discards data would save
the lost state in a special reflog.  That way people won't complain
because 'git checkout -p -- $file' <press a> saved their state, but
'git checkout -- $file' didn't, even though they should be equivalent.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
