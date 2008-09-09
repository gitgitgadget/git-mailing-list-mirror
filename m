From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 00:56:03 +0200
Message-ID: <20080909225603.GA7459@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdC95-00041A-4j
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 00:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbYIIW4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 18:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbYIIW4H
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 18:56:07 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:60772 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbYIIW4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 18:56:06 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B9A835465; Wed, 10 Sep 2008 00:56:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909211355.GB10544@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95453>

Petr Baudis wrote:
>On Tue, Sep 09, 2008 at 03:22:12PM +0200, Stephen R. van den Berg wrote:
>> - During fetch/push/pull the full commit including the origin fields is
>>   transmitted, however, the objects the origin links are referring to
>>   are not (unless they are being transmitted because of other reasons).

>> - When fetching/pulling it is optionally possible to tell git to
>>   actually transmit objects referred to by origin links even if it would
>>   otherwise not have done so.

>I think this is misguided. In general case, cherrypicks can be from
>completely unrelated histories, and if you are doing the cherry pick,
>you are saying that actually, the history *does not matter*. In that

That is a false assumption in general, I'd say.

>case, this kind of link tries to impose a meaning where there is none,
>and in an ill-defined way when whether the commit is actually around
>anywhere is essentially random.

The purpose I'd use the origin links for is to manage software projects
that consist of 7 main branches which have branched in (on average) two
year intervals, which never get merged anymore.  The only thing that
happens is that there are backports amongst the branches about two per
week.

The only way to perform the backports is by using cherry-pick.
The history of each backport *is* important though.
Since all the developers who care about the multiple release branches
have all the relevant branches in their repository, the presence of
a origin object is by no means random, it's a certainty.

>Why do you actually *follow* the origin link at all anyway? Without its
>parents, the associated tree etc., the object is essentially useless for
>you; the authorship information and commit message should've been
>preserved by a proper cherry-pick anyway. You're cluttering the object
>store with invalid objects, which also breaks quite some fundamental
>logic within Git (which assumes that if an object exists, all its
>references are valid - give or take few special cases like shallow
>repositories, but this would have very different characteristics).

I'd prefer to formalise the (weak) relationship of an origin link, instead of
relying on vague assumptions when parsing the free-form commit message
and then guessing what the mentioned hash might mean.

>Having history browsers draw fancy lines is fine but I see nothing wrong
>with them extracting this from the free-form part of the commit message.
>For informative purposes, we don't shy away from heuristics anyway, c.f.
>our renames detection (heck, we are even brave enough to use that for
>merges).

It's not just that.  If I make a change to an area that was cherrypicked
from another branch, then I find it rather important to check if any
changes to this area need to be backported/forwardported to the branches
the origin links are pointing to.
I.e. the origin link allows me to improve my efficiency as a programmer.
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
