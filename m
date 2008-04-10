From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Intricacies of submodules
Date: Thu, 10 Apr 2008 13:32:58 -0700
Message-ID: <1207859579.13123.306.camel@work.sfbay.sun.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Avery Pennarun <apenwarr@gmail.com>, stuart.freeman@et.gatech.edu,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 22:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk3MG-00070d-Gf
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 22:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632AbYDJUZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 16:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755965AbYDJUZo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 16:25:44 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:37268 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbYDJUZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 16:25:43 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3AKPfYZ006929
	for <git@vger.kernel.org>; Thu, 10 Apr 2008 13:25:41 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZ400L01M1EJ700@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Thu, 10 Apr 2008 13:25:41 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZ400AKBM2P7400@fe-sfbay-09.sun.com>; Thu,
 10 Apr 2008 13:25:37 -0700 (PDT)
In-reply-to: <7v63uqz265.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79248>

On Wed, 2008-04-09 at 22:53 -0700, Junio C Hamano wrote:
> Roman Shaposhnik <rvs@sun.com> writes:
> 
> > ... Yet, even with the latest version of Git we don't have
> > "git submodule add" updating .git/config. So here comes the first  
> > question:
> >      * Do you consider this behavior to be a bug or do you a have a  
> > reasonable
> >          explanation for it?
> 
> I would say that the part is simply underdeveloped.

Fair enough. Which is good news for me, since I can not really imagine
how the repositories I need to establish can survive without solid
Submodule support. I'm very interested in getting this functionality
right with git-submodule. And I can be either your guinea pig or
a frenetic hamster. After all, you don't mind complete newcomers
to the development process sending you code, do you? ;-)

> I do not think many people from the core circle of the git community are 
> heavy users of submodules.

I wonder why. Most of the software projects that I have to deal with
seem to be a pretty hefty collections of loosely coupled things. In that
other thread I had on git-repack there was a typical example of what
happens if you put something like that into a single repo (700
subdirectories at the top level -- that's what :-(). Does it all mean
that the core Git community mostly works on projects like Linux kernel
and not things like OpenOffice or Mozilla, etc?

> However, the way others will obtain a copy of the submodule repository
> will be quite different from the way you access it (you already have it,
> so you do not need to clone it from elsewhere to initialize it).  It may
> not make much sense to record the URL that you tell others to use in your
> own .git/config in the repository of the originator of such a superproject
> vs submodule combination.  So in that sense, I am not sure if not mucking
> with .git/config is even a bad thing.

It is all about consistency as far as I see it. One huge advantage of
Git is that it is a DSCM. It makes things totally symmetric. The
paragraph that I quoted above hints at a possibility of treating the
initial repo somewhat differently from its copies. That would break
a nice symmetry. And it would do that unnecessarily.

> After working with the project for a while (i.e. you pull and perhaps push
> back or send patches upstream), .gitmodules file changes and it now says
> the repository resides at host B.xz because the project relocated.  You
> would want the next "git submodule update" to notice that your .git/config
> records a URL you derived from git://A.xz/project.git/, and that you have
> not seen this new URL git://B.xz/project.git/, and give you a chance to
> make adjustments if needed.

I guess something like that could be implemented via Git hooks, right?

> After that happens, if you seeked to an old version (perhaps you wanted to
> work on an old bug), .gitmodules file that is checked out of that old
> version may say the "upstream" is at A.xz, but the entry in .git/config
> may already be based on B.xz.  But because you have already seen this old
> URL in .gitmodules, you may not want to get asked about adjusting the
> entry in .git/config merely because you checked out an old version.  What
> this means is that it is not enough to just record "What the current URL
> you chose to use is" in .git/config (which is obvious), and it is also not
> enough to record "what URL .gitmodules had when you made that choice", but
> you would also need to record "What URLs you have _seen_ when making that
> choice".

Good point.

> >       * Has an idea of having a regular file (subject to having  
> > history, etc.)
> >         called something like .gitconfig at the top level of Git's  
> > repository ever
> >         been considered (implemented?). That way you a repository  
> > maintainer
> >         would be able to force a particular set of settings on all of  
> > its clones
> >         yet clones will be able to override then in .git/config if  
> > needed.
> 
> Considered, yes, implemented, no.  Not because nobody bothered to, but
> because it is unclear if it is a good thing to do in general to begin
> with.  What's recorded in .git/config is pretty much personal (e.g. "who
> you are known as to this project?", "what's the SMTP host, user and
> password when sending out patches from here?", "do you want to use color
> in diff?"), dependent on local needs (e.g. "what protocol a particular
> remote repository should be reached via"), or what the repository (as
> opposed to "project") is about (e.g. "is this a bare, shared distribution
> point, or is this a developer repository with a work tree?").

Some of it is personal, yes. But sometimes those personal preferences
need to be enforced on a project level (of course, giving everybody
a way to override the setting if they really want to). For a big
software organization with a mix of senior and junior engineers I need
a way to set up *my* workspace in such a way that everybody who
clones/pulls from it get not only the source code, but also "Git best
practices". That would simplify things a great deal for me, because
I can always say: "just pull my latest .gitconfig, make sure you
don't have any extra stuff in your .git/confing and everything 
in Git will work for you". That would also simplify things for junior
guys as well -- they can be sure that whatever needs to be done
with Git's setup I can do for them and all they have to do is pull.

Perhaps, this model is different from what the majority of Git
developers uses (especially working on OpenSource projects) but I'm
pretty sure it is quite widespread within corporate firewalls.

> Project policies do not belong to .git/config and should be propagated
> in-tree.  For example, "indenting with more than 8 spaces is a whitespace
> error for *.c files" is described in .gitattributes and given to all
> cloners.

Agreed. But what I have in mind is more of: in this project everybody
shall use super-duper-GUI-merge by default. I can't really propagate 
merge.tool in any way, can I? But I really need to. Since the health
of my project really depends on junior engineers not being confused
when doing the merges.

What is also not clear to me is the difference between what is
considered to be an attribute (part of .gitattributes) and
what it considered to be a setting (part of .git/config). It seems
that the line gets quite blurry (at least for me it does) and thus
I'd totally appreciate any help understanding this difference
better.

> There may be some behaviour that is currently controlled by what is
> recorded in .git/config but should be enforced project-wide.  If there are
> such things, we may want to have a mechanism that reads from in-tree data,
> just like the attributes code does.

That's exactly what I have in mind. 

Thanks,
Roman.
