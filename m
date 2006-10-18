From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:46:17 +0200
Message-ID: <200610180246.18758.jnareb__16169.8141987019$1161134921$gmane$org@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:49:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzZ9-0001RN-Iq
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWJRApt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWJRApt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:45:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58249 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWJRAps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 20:45:48 -0400
Received: by ug-out-1314.google.com with SMTP id o38so77800ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 17:45:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Eqs6cqZk2MqhrqLXNhOhcvwjikx8X3n/ZFGEIrHzoh1IPk27DesOaaOCT1Y1Nw4rQiAfPJJLSZ5BMVDRPWoRzb3qF5p3y0Dx6DwWg4x4h2MJe17H2VL8PKfi7kxRu1I77jtQENQQ56Iam+cW3wUbqSAxIGL9mJbSoHq3qzoiqb0=
Received: by 10.67.105.19 with SMTP id h19mr2507479ugm;
        Tue, 17 Oct 2006 17:45:46 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 5sm292031ugc.2006.10.17.17.45.45;
        Tue, 17 Oct 2006 17:45:46 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45357411.20500@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29160>

Aaron Bentley wrote:
> Linus Torvalds wrote:
>>
>> On Tue, 17 Oct 2006, Aaron Bentley wrote:
> >>> Excuse me? What does that "throws away your local commit ordering" mean?
> >> Say this is the ordering in branch A:
> >>
> >> a
> >> |
> >> b
> >> |
> >> c
> >>
> >> Say this is the ordering in branch B:
> >>
> >> a
> >> |
> >> b
> >> |\
> >> d c
> >> |/
> >> e
> >>
> >> When A pulls B, it gets the same ordering as B has.  If B did not have e
> >> and c, the pull would fail.
> >
> > Sure. But that doesn't throw away any local commit ordering. The original
> > order (a->b->c) is still very much there.
> 
> After the pull, it's no longer the mainline ordering for the branch.  c
> is represented a revision that was merged into the branch, while d is
> represented as a commit on the mainline of the branch.

Well, that is another example while generation number is/can be global,
any numbering of branches must be local-only.

> > The fact that there was a branch
> > off 'b' and there is also (a->b->d) and a merge of the two at 'e' doesn't
> > take away anything from the original local commit ordering.
> 
> It means the the order that revisions are shown in log commands changes,

That doesn't matter...

> and the revision numbers can change.

...but that means that revision numers are totally, absolutely useless.
Unless by some miracle of engineering, or adding namespace, they can be
made unchangeable.

> > But that's a totally specious "record". It has no meaning in a distributed
> > SCM. There is absolutely zero semantic information in it.
> 
> It records the committer, the date, the commit message, the parent
> revisions.

All totally empty information. What should be commit message? I have
fetched changes from remote repository? You can remove one of parents
(the one of pointing to before fast-forward "merge") without changing
reachability.

              ---------
             /         \
     *--*---x---*---*---y---*

> > The fact that you _locally_ want to remember where you were is a total
> > non-issue for a true distributed system. You shouldn't force everybody
> > else to see your local view - since it has no relevance to them, and
> > doesn't add any information.
> 
> Nobody is forced to use your local view.

But if you record "fast-forward merge", you force all people pulling
from your repository to have this purely local and without any significant
information "I have fetched then" marker.

> > In other words, the empty merge is totally semantically empty even in the
> > bazaar world. Why does it exist?
> 
> It exists because it is useful.  Because it makes the behavior of bzr
> merge uniform.  Because in some workflows, commits show that a person
> has signed off on a change.

Signing off the fact of fetching changes? For true merge you are signing
off the fact that there were no conflicts, or you sign off your conflict
resolution.

> It's not something special-- it's just another commit, like regular
> commits, and merge commits.  It would be harder to forbid than it is to
> permit.

Actualy the check is very easy. And you have to do similar check when
fetchin/pushing to ensure that you don't clobber your changes.
-- 
Jakub Narebski
Poland
