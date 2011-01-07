From: "r.ductor@gmail.com" <r.ductor@gmail.com>
Subject: Re: [PATCH/RFC] Documentation/checkout: explain behavior wrt local changes
Date: Fri, 7 Jan 2011 15:27:42 +0100
Message-ID: <201101071527.42544.r.ductor@gmail.com>
References: <20110106154418.3348.29438.reportbug@localhost> <20110106225222.GA15900@burratino> <7vtyhl8t5y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 16:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbED9-0001vJ-Q9
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 16:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab1AGP0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 10:26:34 -0500
Received: from cirse-out.extra.cea.fr ([132.166.172.106]:33937 "EHLO
	cirse-out.extra.cea.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab1AGP0d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 10:26:33 -0500
X-Greylist: delayed 3489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2011 10:26:33 EST
Received: from epeire2.extra.cea.fr (epeire2.extra.cea.fr [132.167.198.32])
	by cirse.extra.cea.fr (8.14.2/8.14.2/CEAnet-Internet-out-2.0) with ESMTP id p07ERuSB005118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Jan 2011 15:27:56 +0100
Received: from orpin1.extra.cea.fr (orpin1.extra.cea.fr [132.167.198.4])
	by epeire2.extra.cea.fr (8.14.4/8.14.4) with ESMTP id p07ERtnA007241;
	Fri, 7 Jan 2011 15:27:56 +0100
	(envelope-from r.ductor@gmail.com)
Received: from galileo.localnet ([132.166.22.182])
	by orpin1.extra.cea.fr (8.13.8/8.13.8/CEAnet-Extranet-out-1.1) with ESMTP id p07ERt9H032673;
	Fri, 7 Jan 2011 15:27:55 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vtyhl8t5y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164718>

Dear all

I'm a beginner git user trying to defend the beginners' party. Using Jonathan's explanations (and some educated guess on git behavior) I tried to concoct the man git-checkout documentation I would have liked to read, which is somewhat more explicit than Jonathan's patch. If you want to implement/improve it please double check it (and maybe warn me about my own errors). If you are happy about that I will try to send more suggestions. Thanks for your time and your work.

riccardo   

git checkout [<branch>]
git checkout -b|-B <new_branch> [<start point>]

     Tries to change the current HEAD to <branch> (or <start point>) and to safely update the working tree and the index.
     If there exist files having three distinct contents in the current commit, in the new branch and in the working tree, then the operation is canceled and all state is preserved.
     (This behavior may be changed with the option --merge.) If this is not the case, for all other files it acts as follows.  
       - Files not differing between the current commit and the new branch: their contents in the working tree (and eventually in the index) are left unchanged. 
       - Files in the current commit, unchanged or absent in the working tree, but not present in the new branch are removed from the working tree and from the index.
       - Files in the new branch but not in the current commit are added to the working tree and to the index (if they were already there they must have had the same contents by hypothesis).
       - Files in the working tree or in the index that are absent in the current commit and in the new branch are left unchanged.
    
    If -b is given, ...



On Friday 07 January 2011 01:16:25 Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >  'git checkout' [<branch>]::
> >  'git checkout' -b|-B <new_branch> [<start point>]::
> >  
> > -	This form switches branches by updating the index, working
> > -	tree, and HEAD to reflect the specified branch.
> > +	This form switches branches by changing `HEAD` and updating the
> > +	tracked files to the specified branch.  'git checkout' will
> > +	stop without doing anything if local changes overlap with
> > +	changes to the tracked files.  (Any local changes that do not
> > +	overlap with changes from `HEAD` to the specified branch will
> > +	be preserved.)
> 
