From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC proposal for svn remote helper
Date: Fri, 8 Apr 2011 00:21:26 -0500
Message-ID: <20110408052126.GA22256@elie>
References: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com>
 <BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, artagnon@gmail.com, david.barr@cordelta.com,
	srabbelier@gmail.com, Eric Wong <normalperson@yhbt.net>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 07:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q848Z-0006gY-5z
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 07:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1DHFVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 01:21:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53533 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1DHFVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 01:21:33 -0400
Received: by gyd10 with SMTP id 10so1312156gyd.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YNL8Mwe4gdE4FzHX2pPDMSUmd2dsEY1SQ7VfEq78C9g=;
        b=LMydefgU+EqEj8Aw3Vo+pQJ4hAByTVElfHJjW44kQOgcbIgTVI5rMJ5bAkyULi+RoU
         3nIoiXzWYIeMJIj7qBltu2K6u5ReN2H5qZS3Yz5JlE34n9UG1uR4lOaIY9lXhNbSu6xK
         Hr/nwrjvl16dqj7Zz0O035t0+R5Zk3OJzOwWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dl3piEn4VpZsnX0SYlkhkgRCLl+nRUbaPjH5y6M5ADXVNSsan/MTkwuQvP0kSG1thX
         sMFVQBNvC7O1Gmh5wC0ss8hj7/TfV8hAwAMZ1XMJK3H3TnHrDlyMXnki7PmFRO+S3Gnx
         G7s4cEd3HQVANhv6OuzbWvlL/nqyAD3ko4KTg=
Received: by 10.150.72.32 with SMTP id u32mr1535674yba.69.1302240092408;
        Thu, 07 Apr 2011 22:21:32 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id t16sm1291713ybe.19.2011.04.07.22.21.30
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 22:21:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171104>

(+cc: Eric who brought us git-svn)
Hi Dmitry,

Dmitry Ivankov wrote:

> This is the second iteration of my GSoC proposal

Great; let's iron this out.

> I would like to work on "Remote helper for Subversion and git-svn".
> My major motivation is to make git-svn repository easy to clone, and to make
> git-svn (fetch) faster on huge repositories.

So, my new first impression is that this goal might make things hard[1].

I think replacing git-svn with an imperfect emulation would not leave
people happy.  Existing configurations need to continue to work.

> Project Goals:
> + * Design and create fully functional prototype of new git-svn which is
> cloneable and quite fast.

*If* one does not have this goal ("new git-svn") then there is a
chance to move past some of git-svn's limitations[2].

All that said, these tools could be used to speed up git-svn.  

> By fully functional I mean that it'll be
> able to fetch, push, etc. but probably won't have automatic tags and
> branches discovery and like, but will allow it to be implemented on
> top. Oh, it just hit me that given a path (read trunk) to track and a
> svndump it looks trivial to discover all it's branches - just seek for
> copies.

As mentioned before, this sounds very ambitious.  Once we have a
timeline showing how this breaks down into small steps it should
hopefully be clearer way.

> + * Get all the needed core git changes merged.

The following is probably controversial.  It's my opinion only.

Since you can't control what other people do, I don't think it's right
to judge your project's success or failure based on whether it gets
merged.  Put another way, the product of your work that can be judged
is not whatever fraction gets accepted in git.git by the end of the
summer[3].

So I think the goal is whatever it is (a working and suitable "git
clone svn://foo" command, say) and getting feedback by pushing changes
upstream and responding to it is a part of how that happens.

At some point there will probably be a point of no return --- "if the
design of this patch is not right, I would have to rewrite everything
on top of a redesign of it".  I'd encourage getting input on such
patches _very_ early and working hard to get them merged at least to
"next" (i.e., to have a rough consensus that they are suitable modulo
small tweaks).  I would love it if the proposal included a timeline
pointing out some examples of this.

> Some of these exist already and
> only need help with polishing, reviewing and merging.

Do you mean support for parsing "svnadmin dump --deltas" output?  It
is already polished and reviewed; it's only sitting out-of-tree for
now because it makes the commandline usage awkward and it would be
nice to merge some improvements to that at the same time.

> + * Make the prototype as close to being merged as possible.

That's kind of vague, you know. :)

> Milestones for prototype functionality:
[list of features snipped]

Could you say something about how you would go about implementing
these?

Sorry for the ramble, and thanks for working on this.

Ciao,
Jonathan

[1] git-svn.perl is a work of art and a wonder to behold, and if your aim
is to make a compatible replacement for it, the first step will be to
understand its design deeply.  And the thing is, that much, while
valuable anyway, is pretty hard already.

You see, "git svn" has heuristics for

 - matching up git history to svn history by reading commit messages;
 - pushing mergy history as linear history by rebasing internally
   (dcommit);
 - finding the branches, merges, branch renames, and so on in an
   imperfectly structured history (find_parent etc)
 - what particular paths are relevant  (--ignore-paths)

and maintains some of its own data in the repository:

 - a configuration scheme and wide variety of supported configurations;
 - a log for unhandled pieces of history;
 - a cache mapping svn revision numbers to git commits

and people rely a lot on an odd coincidence:

 - using "git svn clone" twice with the same configuration on the same
   repository will, at least most of the time, give the same commit
   names.

[2] Well, it mostly comes down to one limitation.  To give a quick
sketch:

If I clone a repository with "git svn", then I am in a way a
second-class citizen.  The history shown with "git log" is filled
with "git-svn-id:" lines that are not very interesting to me (the
revision number is still interesting, of course).  I cannot use
"git push" to push my work, and in fact I cannot push my work as a
branch reflecting the real development history at all --- I have to
rebase it at the same time as pushing.  Whenever I push, the commit
names for my work change, so other branches based on my work don't
show up in "gitk" as based on my work any more.

Wouldn't it be nicer to be able to do

 alice$ git clone svn::http://svn.apache.org/repos/asf/subversion
 alice$ cd subversion
 alice$ ... hack hack hack ...

 bob$ git clone 'alice:~/src/subversion'
 bob$ cd subversion
 bob$ ... hack hack hack ...;	# make some changes on top of alice's work

 alice$ git fetch origin; # anything new upstream?
 alice$ git push origin; # push my changes upstream

 bob$ git remote add upstream svn::http://svn.apache.org/repos/asf/subversion
 bob$ git fetch upstream
 bob$ # push my changes on top of alice's (which were already pushed):
 bob$ git push upstream

That is the dream.  Because there is not a clearly appropriate
one-to-one mapping between possible svn histories and possible git
histories, there are going to have to be limitations[1], but that is
an ideal to strive for.

Sounds hard, maybe?  Yeah, it is, but getting at least fetch support
using the tools David and Ram made sounds easier to me than a fully
compatible replacement for git-svn.

[3] Meanwhile, just writing and publishing code is not enough, since
the code might have a fatal flaw that means no one will use it ("ivory
tour syndrome").  So what do I mean by the above?

As students work, I hope they will keep the mailing list posted on
their progress and find small pieces to review and merge early.  In
response they might get some questions and suggestions for
improvement; the response to these is just as important as the code.

On one hand this feedback is an important sanity check on the broad
features of your work and a means to get the details right for
inclusion in git (i.e., get it merged).  On the other hand, one should
not be tempted by interesting side tracks and avoid getting the actual
project done; you have to be able to say "no, I will not be working on
that".  Out of these conversations emerge better code and
documentation of the design in the form of list archives.

See [4] for a better explanation of this workflow.

[4] http://thread.gmane.org/gmane.comp.version-control.git/142623/focus=142877
