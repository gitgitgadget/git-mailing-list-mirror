From: David Kastrup <dak@gnu.org>
Subject: Re: Rewriting history with git-filter-branch and leaking objects (?)
Date: Fri, 17 Aug 2007 19:34:32 +0200
Message-ID: <86k5ruxdxz.fsf@lola.quinscape.zz>
References: <20070817171851.GB13891@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 19:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5j9-0003hD-TG
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbXHQRes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbXHQRes
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:34:48 -0400
Received: from main.gmane.org ([80.91.229.2]:40772 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbXHQRer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:34:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IM5ia-0006dn-Uh
	for git@vger.kernel.org; Fri, 17 Aug 2007 19:34:40 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 19:34:40 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 19:34:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:LPteTyQ4lSW/GiYhWWeVMalczIY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56074>

Mike Hommey <mh@glandium.org> writes:

> I've been playing with git-filter-branch, and was wondering how objects
> from the original branch are supposed to be removed.
>
> It looks like removing the refs/original/* refs is not enough.
>
> And it also looks like when all references seem to be removed, git-prune
> doesn't fully do its job...

It is quite quite hard to get rid of objects.  You need to get the
reflogs for the commits and the files expired.

The last time I tried this, I ended up unpacking the packed objects,
calling git-fsck with appropriate options to tell me about
unreferenced objects when ignoring reflogs, and removing the files
manually with xargs and rm.

Probably I was not able to do something reasonably intelligent, but
making git actually _lose_ data/commits/whatever is really, really
hard.  I have messed up my repo structure considerably several times,
and everything is still there, with the reflog telling you how to get
it.

Given how easy it is to shoot oneself in the foot with git, it is not
the worst thing.  But you really have to work if you _mean_ it.

-- 
David Kastrup
