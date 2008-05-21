From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Git-new-workdir
Date: Wed, 21 May 2008 14:07:34 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794301FC8B25@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com> <9af502e50805211153ya79f73y60d4975d46ef8edd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 21:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jytga-0001Tq-LX
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936994AbYEUTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936992AbYEUTHj
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:07:39 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:11347 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936988AbYEUTHg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 15:07:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <9af502e50805211153ya79f73y60d4975d46ef8edd@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-new-workdir
Thread-Index: Aci7c/ZK8tAYs3zyRYaaxOFv6Ym47AAAKRhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82566>

> From: Robert Anderson [mailto:rwa000@gmail.com] 
> 
> On Wed, May 21, 2008 at 11:21 AM, Craig L. Ching 
> <cching@mqsoftware.com> wrote:
> 
> 
> 	Hi all,
> 	
> 	I'm a bit of a newbie to Git, but I have started using 
> it in earnest for
> 	the past couple of months.  I had asked on IRC about a 
> potential problem
> 	I saw with git and how it fit into our workflow.  We 
> currently use CVS
> 	and have used it for the past ten years.  A lot of us have grown
> 	accustomed to keeping multiple builds around for 
> different things, e.g.
> 	defects we're working on, new features, etc., we do a 
> lot of task
> 	switching and very rarely can we work on something 
> start to finish
> 	without being interrupted with something else.  The 
> normal workflow of
> 	git seems to cut across that need to keep many builds around.
> 	Generally, building our software is not trivial and 
> takes a fair amount
> 	of time, so just "git checkout" out a new branch and 
> rebuilding is not
> 	really an option for us.  
> 
> 
> You haven't explained your issue very well.  
> 
> What does "keeping multiple builds around" mean?  Taken at 
> face value this is irrelevant to source control.  So you must 
> mean something else, but you haven't explained what.  I keep 
> multiple builds around by using separate build directories 
> which are not source controlled.  Whether or not I keep 
> multiple builds of a source tree just isn't relevant to my 
> source control whether it be CVS or git or whatever.  Perhaps 
> you mean "different variations of the same source tree" or 
> something like that, in which case "git seems to cut across 
> that need" seems like an absurd thing to say.
> 
> Can you give an actual scenario, and say how you use CVS in that case?
> 
Sure, what I mean is that you checkout a branch, the workspace reflects
the state of that branch.  If you do a build in the workspace, the build
artifacts match up with the source that's in the workspace.  If you then
checkout a new branch, it's unlikely that the source reflects the build
artifacts any more.

Here's how we did it in CVS.  Any feature or defect got it's own branch,
no matter how trivial it was (yes, it was very painful with CVS, but the
benefits outweighed the pain.  Moving to Git is very easy for us since
we already have the "branch for everything" mindset ;-) ).  So, say you
have two defects, A and B.  We'd create two separate branches named
after the defects, so two branches named A and B.  Then we'd do:

Cd ~/dev/
Mkdir A && cd A && cvs co -r A && make
Mkdir B && cd B && cvs co -r B && make

That way we'd have two separate workspaces where the build artifacts
match with the source.  Now, I suppose you could suggest we change our
build procedure so that it puts the build artifacts outside of the VCS
workspace, i.e. our makefiles could "git branch" and create a directory
for those build artifacts outside of the source workspace?  That might
work, I'd have to think about it a bit more, but I know for our java
sources that might be a problem with a lot of java build tool
conventions, e.g. maven puts the build artifacts in the same top-level
directory that contains the sources.

Cheers,
Craig
