From: Tuomo <tuo.tie@gmail.com>
Subject: Re: Another way to compare tools: is it possible to transfer full history?
Date: Wed, 29 Sep 2010 11:03:48 +0000 (UTC)
Message-ID: <loom.20100929T130008-795@post.gmane.org>
References: <loom.20100928T153519-936@post.gmane.org> <4CA20169.2040606@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 13:04:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0uSI-00044j-DW
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab0I2LD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 07:03:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:55662 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab0I2LD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 07:03:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P0uS4-0003zl-Qq
	for git@vger.kernel.org; Wed, 29 Sep 2010 13:03:56 +0200
Received: from esprx02x.nokia.com ([192.100.124.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:03:56 +0200
Received: from tuo.tie by esprx02x.nokia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:03:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.100.124.219 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157551>

Tomas Carnecky <tom <at> dbservice.com> writes:

> fast-import/export (man git-fast-export/import) seems to be the future.
> Git provides excellent support for it and other SCMs are adopting it as
> well. And then there are custom written conversion tools, just take a
> look at [1] to see which ones are available.
> 
> (shameless plug: just this weekend I started collecting the various fast
> import/export tools and made a webpage about it:
> http://caurea.org/fast-export-import/. It's far from complete though.
> And if you know any tools that perform better than those I've listed,
> I'd be glade to update the page).

Last time I was looking for conversions between source control tools, I could
not find any (but my attempt may have been a bit limited). I am very happy to
see that there is now not only a plethora of point-to-point conversion tools,
but a common exchange format. It means that the field of source control is
finally maturing, finding common concepts that most agree on.

However, the scanty documentation for the tools does not answer my question.
I'll try to formulate it again. You can move history from SCCS to RCS without
losing anything, but you cannot move from RCS to SCCS, because SCCS does not
handle sub-branches. You can move from RCS to CVS, but since RCS does not record
evolutionary relationships between tags, the result does not record the history
in the manner we'd expect in CVS. You can provide additional data to the
conversion, but that additional data cannot be automatically deduced by any
general algorithm. You can move stuff from CVS to RCS, but you lose the
evolution of the whole configuration. So, SCCS, RCS and CVS all belong to a
different class. Only the latest tools have enough in common that one can find
enough of information to make a full transfer of history without loss of data
that can be deduced by automatic means if a back-conversion is desired.

Which tools belong to the same class with Git? Strictly speaking, I am talking
about conversions that do not require us to inject any additional data,
conversions that are fully automatic. The page http://wiki.darcs.net/DarcsGit
mentions that Darcs->Git->Darcs roundtrip loses no information (but also notes
that the tool is nowadays broken and needs fixing), but the same is not true for
the other direction. That is the kind of information I am looking for.

Is it possible to make a round-trip Mercurial->Git->Mercurial or
Git->Mercurial->Git without loss of any information? I would expect that
Mercurial->Git->Mercurial might produce some differences if files have been
renamed or moved between directories, but other than that?

What particularly interests me is how the conversion handles unnamed Mercurial
branches? I am asking this because at work, I had to ponder once if it would be
possible to transfer histories from Synergy (ex Continuus) to some other tool,
and found it very difficult to imagine how to create named branches from the
version DAGs Synergy uses. You can never be sure if a new version is a successor
of its predecessor on the same branch or the first version on a sub.branch,
because Synergy doesn't treat them any differently. users often try to organize
the branches in ways compatible with other tools, but since Synergy has no way
of enforcing any of these methods, there is no guarantee of consistency. The
worst-case scenario is that every single version is its own branch. So, I really
would like to know how the unnamed branches from Mercurial are transferred to
named branches in Git?
