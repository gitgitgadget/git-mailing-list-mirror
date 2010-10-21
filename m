From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Thu, 21 Oct 2010 10:00:04 -0400 (EDT)
Message-ID: <4424833.537061.1287669604786.JavaMail.root@mail.hq.genarts.com>
References: <1287652097.9207.31.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 16:00:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8vh0-00051w-UO
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 16:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296Ab0JUOAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 10:00:14 -0400
Received: from hq.genarts.com ([173.9.65.1]:58353 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758159Ab0JUOAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 10:00:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 7F4181E26334;
	Thu, 21 Oct 2010 10:00:11 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TiD9pc5i9Sle; Thu, 21 Oct 2010 10:00:04 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id E1D5F1E26377;
	Thu, 21 Oct 2010 10:00:04 -0400 (EDT)
In-Reply-To: <1287652097.9207.31.camel@wpalmer.simply-domain>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159505>

----- Original Message -----
> From: "Will Palmer" <wmpalmer@gmail.com>
> To: "Jakub Narebski" <jnareb@gmail.com>
> Sent: Thursday, October 21, 2010 5:08:17 AM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> On Wed, 2010-10-20 at 22:44 +0200, Jakub Narebski wrote:
>
> It's tedious, but still fairly simple, to
> walk the history and build a new history consisting only of edits to a
> subtree (even if the commit messages don't always make sense out of
> context). It really doesn't matter one lick whether a single svn
> commit touched multiple generated git commits.

After reading your first entry into this thread, this is certainly what I was envisioning.  I'm still a little worried about initial clone size (over the weekend I had to wait over an hour for my full-svn-history git repository to clone from work to home), but it is certainly an intriguing idea.  With appropriate mapping information (copyfrom properties and some user input) I think you could create a very convincing Git history by creating commit objects using subtrees of the SVN-imported history.  I had been thinking about a very similar solution, but I was planning on pruning the original SVN-imported commit objects to save space...
 
> Of course, "ignoring merges" is temporary and a total cop-out

This is still bugging me...  Even with svn mergeinfo (which I think is a small percentage of the SVN revisions in the world), IMO an SVN merge is *not* a Git merge.  I think of it as a git cherry-pick (someone correct me if this mental model is wrong).  The key point in my mind is SVN merge doesn't have to merge the entire branch history.  Perhaps some heuristics can be applied in Git to decide if an SVN merge is a "true merge" or a cherry-pick?  But I have a nagging feeling that in the end the model mismatch is going to be very hard to overcome.

Thanks,
Stephen
