From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 12:40:21 +0100
Message-ID: <20071219114021.GB5565@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <m3hcigot3h.fsf@roke.D-201> <20071219093816.GB4361@diana.vm.bytemark.co.uk> <200712191144.59747.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xIL-0002MA-LI
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbXLSLk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbXLSLk3
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:40:29 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1469 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbXLSLk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:40:28 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4xHh-0001aC-00; Wed, 19 Dec 2007 11:40:21 +0000
Content-Disposition: inline
In-Reply-To: <200712191144.59747.jnareb@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68890>

On 2007-12-19 11:44:57 +0100, Jakub Narebski wrote:

> On Wed, 19 Dec 2007, Karl Hasselstr=F6m wrote:
>
> > On 2007-12-18 08:39:52 -0800, Jakub Narebski wrote:
> >
> > > I also would like to have this command kept (and shown in 'stg
> > > help'!). Contrary to 'git add' it can check and add to index /
> > > update index only for files with conflict; we have -r
> > > (ancestor|current|patched) to choose one side, and we could add
> > > --check to check if there are no conflict markers with files
> > > (useful with -a/--all).
> >
> > This too sounds like stuff that could profitably be added to "git
> > add". Except for the ancestor/current/patched words, it is not
> > specific to patch stacks, so the implementation should be in git
> > and not in stg.
>
> No it cannot, at least the '-r (ancestor|current|patched)' part for
> resetting file to given version, even if we change the wording to
> ancestor, ours and theirs. The git-add command is about adding
> contents, which updates index, which almost as a intended
> side-effect clears merge state, i.e. stages; and not about resetting
> to stage.

  git checkout-index --stage=3D1|2|3 <filename>

does what you want. But "git cat-file" knows this handy syntax for
getting at particular index stages:

  :stage:<filename>

It would be very convenient to be able to do

  git checkout :stage:<filename>

but it doesn't seem to work currently. Does anyone know the "best" way
of manually checking out a particular index stage in git?

> Besides with "stg resolved" you can update index _only_ for files
> which were in the conflict, also for -a/--all, and not all the files
> not only those which were in the conflict like "git add -u" does.

This sounds like a straightforward addition to "git add".

> "stg resolved --check" could happily ignore things that only look
> like conflict markers, but must have been intended, because they are
> in files not in conflict.

git knows about conflicting files too.

> Unless you are talking about adding "resolve"/"resolved" command to
> git-core, as a porcelain wrapper around git-update-index, like "git
> add"...

Yes, that's what I want. You and others like what "stg resolved" does,
but I don't want it in StGit because it's a generic git enhancement
that has nothing to with patch stacks. People who don't use StGit
would presumably like it as well.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
