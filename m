From: Dave Abrahams <dave@boostpro.com>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Mon, 21 Feb 2011 23:49:37 +0000 (UTC)
Message-ID: <loom.20110222T004926-60@post.gmane.org>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 00:50:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrfW5-0000sf-03
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 00:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1BUXt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 18:49:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:51717 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab1BUXty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 18:49:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PrfVn-0000jR-Jr
	for git@vger.kernel.org; Tue, 22 Feb 2011 00:49:51 +0100
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 00:49:51 +0100
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 00:49:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.172.223.249 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-us) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167514>

Johan Herland <johan <at> herland.net> writes:

> 
> On Friday 11 February 2011, skillzero <at> gmail.com wrote:
> > On Thu, Feb 10, 2011 at 1:13 PM, John Wiegley
> > <johnw <at> boostpro.com> wrote:
>
> > I don't know very much about how git really works so what I'm saying
> > may be dumb, but rather than record where a commit came from, would it
> > be reasonable for rebase to look at the patch-id for each change on
> > the topic branch after the merge base and automatically remove topic
> > branch commits that match that patch-id? So in your example, rebase
> > would check each topic branch commit against 3', d, e*, and f and see
> > that the 3' patch-id is the same as the topic branch 3 and remove
> > topic branch 3 before it gets to e*?
> 
> I believe "git rebase" already does exactly what you describe [1].

I can imagine that we could make merges do something similar:

git merge <sources> :=

   Attempt the merge as it works today
   If there are conflicts
       for s in <sources>
            rebase s onto HEAD
       if there are no conflicts
            use the current tree as the result of
                the merge (with the merge's heritage)
            commit
       else
            reset to the conflicted merge state
