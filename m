From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 20:08:01 -0500
Message-ID: <20071127010801.GF14735@spearce.org>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net> <7vy7ckgbpf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwow8-0004S9-SA
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbXK0BIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbXK0BIJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:08:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41532 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbXK0BII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:08:08 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IwovZ-0004ll-2S; Mon, 26 Nov 2007 20:07:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D171220FBAE; Mon, 26 Nov 2007 20:08:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vy7ckgbpf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66150>

Junio C Hamano <gitster@pobox.com> wrote:
> I would not object to renaming all of them to have the leading
> underscore, though.  That would make it clear that they are very
> different from ordinary environment variables for the user to set
> (e.g. GIT_INDEX_FILE, GIT_AUTHOR_NAME).  Does any third party tool like
> qgit already use GITHEAD_${objectname} and/or GIT_REFLOG_ACTION?

git-gui apparently doesn't use either name right now.  It avoids
needing to use GIT_REFLOG_ACTION by invoking only plumbing, except
in the case of git-merge, where it invokes git-merge and thus avoids
the need to set GITHEAD_* to get conflict markers right when the
recursive strategy gets used.

I had started to replace git-merge in Tcl and have git-gui directly
invoke merge-recursive but I haven't gotten around to really
doing that.

So I guess we could rename those two "internal" environment variables
to use a leading _ to make them different from "user level" variables,
but why change them now?  I really don't see a compelling reason to
break that part of the "API" between porcelain/plumbing.

-- 
Shawn.
