From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 00:24:15 -0400
Message-ID: <45345AEF.6070107@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 06:24:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZgV9-0008Cr-Vk
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 06:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWJQEYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 00:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWJQEYZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 00:24:25 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:11954 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1422954AbWJQEYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 00:24:24 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZgV0-0000J7-00; Tue, 17 Oct 2006 00:24:19 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29015>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Mon, 16 Oct 2006, Aaron Bentley wrote:
>> Bazaar's namespace is "simple" because all branches can be named by a
>> URL, and all revisions can be named by a URL + a number.

> I pretty much _guarantee_ that a "number" is not a valid way to uniquely 
> name a revision in a distributed environment, though. I bet the "number" 
> really only names a revision in one _single_ repository, right?

Right.  That's why I said all revisions can be named by a URL + a
number, because it's the combination of the URL + a number that is
unique.  (In bzr, each branch has a URL.)

> In contrast, in git, a revision is a revision is a revision. 

I agree that a revision is a revision, but I don't think that's a
property unique to git. :-)

> If you give 
> the SHA1 name, it's well-defined even between different repositories, and 
> you can tell somebody that "revision XYZ is when the problem started", and 
> they'll know _exactly_ which revision it is, even if they don't have your 
> particular repository.

When two people have copies of the same revision, it's usually because
they are each pulling from a common branch, and so the revision in that
branch can be named.  Bazaar does use unique ids internally, but it's
extremely rare that the user needs to use them.

> Now _that_ is true simplicity. It does automatically mean that the names 
> are a bit longer, but in this case, "longer" really _does_ mean "simpler".
> 
> If you want a short, human-readable name, you _tag_ it. It takes all of a 
> hundredth of a second to to or so.

But tags have local meaning only, unless someone has access to your
repository, right?

>>> About "checkouts", i.e. working directories with repository elsewhere:
>>> you can use GIT_DIR environmental variable or "git --git-dir" option,
>>> or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
>>> "symref"-like file to point to repository passes, we can use that.
>> It sounds like the .gitdir/.git proposal would give Git "checkouts", by
>> our meaning of the term.
> 
> Well, in the git world, it's really just one shared repository that has 
> separate branch-namespaces, and separate working trees (aka "checkouts"). 
> So yes, it probably matches what bazaar would call a checkout.

The key thing about a checkout is that it's stored in a different
location from its repository.  This provides a few benefits:

- - you can publish a repository without publishing its working tree,
  possibly using standard mirroring tools like rsync.

- - you can have working trees on local systems while having the
  repository on a remote system.  This makes it easy to work on one
  logical branch from multiple locations, without getting out of sync.

- - you can use a checkout to maintain a local mirror of a read-only
  branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).

> Almost nobody seems to actually use it that way in git - it's mostly more 
> efficient to just have five different branches in the same working tree, 
> and switch between them. When you switch between branches in git, git only 
> rewrites the part of your working tree that actually changed, so switching 
> is extremely efficient even with a large repo.

You can operate that way in bzr too, but I find it nicer to have one
checkout for each active branch, plus a checkout of bzr.dev.  Our switch
command also rewrites only the changed part of the working tree.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNFrv0F+nu1YWqI0RAgBHAJ9XpmdvuCNDysxFhnyeCmkEG/z0ggCggMsJ
WyW6lqGMokh0k0It1KOdgtk=
=L1SR
-----END PGP SIGNATURE-----
