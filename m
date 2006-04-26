From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Wed, 26 Apr 2006 14:01:41 +0200
Organization: At home
Message-ID: <e2nne7$4sp$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>	<e2kgga$d7q$1@sea.gmane.org>	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org> <BAYC1-PASMTP086A906CFB378AB229C2D8AEBF0@CEZ.ICE> <444F58B0.6090603@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 26 14:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYiij-0003Zi-D7
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 14:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWDZMCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 08:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWDZMCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 08:02:09 -0400
Received: from main.gmane.org ([80.91.229.2]:33230 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932407AbWDZMCI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 08:02:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYiiM-0003TS-0M
	for git@vger.kernel.org; Wed, 26 Apr 2006 14:01:50 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 14:01:50 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 14:01:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19201>

Andreas Ericsson wrote:

> I've suggested before that arbitrary headers could be added to git
> commits by prefixing them with X- (preferrably followed by an abbrev of
> the porcelain name adding the note). This way it's easy to filter, you
> get the free ride, and porcelains can do whatever they want while core
> git can strip everything following the sequence "\nX-" up to and
> including the next newline.
> 
> This way you have only one special byte-sequence with special meaning
> that the plumbing has to know it should ignore, which is a lot more
> extensible (not to mention easier to code).
> 
> In addition, if those X- lines aren't included in the sha1 computation
> they can easily be removed and added to without affecting the ancestry
> chain. This would probably have quite a performance impact though.
> 
> That said, I don't think even "X-" headers is a very good idea. Perhaps
> i've just got poor imagination but I can't think of a good use for them.

Well, the "note" headers are just that, but instead of prefixing 'extra'
headers with "X-" you prefix them with "note ".

I think that the "note" (or X-) headers should be included in calculating
sha1, as the free-form of commit (the comment) is.

As to use: for now 'git cherry-pick' and 'git revert' records the commit
picked or commit reverted in free form. It could be recorded in "note"
header, or additionally as "note" header. 'git rebase' could also record
the original commit e.g. as "note original <branchname> <sha1-of-commit>".

And it would be the place for Porcelain to record simple information which
is of use to them, but usualy not interesting to user, so it would be
better if it wouldn't pollute free-form/comment area.


The "prior" (for saving "pu"-like branches previous state) and "bind" (for
managing subprojects) I think should be rather of "related"/"link" kind.

-- 
Jakub Narebski
Warsaw, Poland
