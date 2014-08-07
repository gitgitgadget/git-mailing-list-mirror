From: Tony Finch <dot@dotat.at>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 12:38:48 +0100
Message-ID: <alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com> <20140806200726.GE23449@localhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-825576390-1407411528=:13901"
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 13:38:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFM26-0000id-Uy
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 13:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbaHGLiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 07:38:55 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:43922 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbaHGLiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 07:38:54 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:48104)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XFM1w-0002A8-Dk (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 07 Aug 2014 12:38:48 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XFM1w-0006mt-4V (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 07 Aug 2014 12:38:48 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <20140806200726.GE23449@localhost>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254948>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-825576390-1407411528=:13901
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Nico Williams <nico@cryptonector.com> wrote:
> On Wed, Aug 06, 2014 at 08:31:18PM +0200, Jakub Nar=C4=99bski wrote:
> > On Wed, Aug 6, 2014 at 6:26 PM, Nico Williams <nico@cryptonector.com> w=
rote:
> > >
> > > My proposal was to put this sort of ancillary history info in a
> > > "branch object" (and that branches should be objects).
> >
> > Is it something like object-ified reflog, similar to how replacement
> > objects (git-replace) can be thought to be object-ified grafts (I know
> > they are more)? Do I understand it correctly?
>
> Yes, per-branch.  At push time a commit would be pushed to the upstream
> branch listing the commits pushed now (and who by).  Locally every
> rebase/cherry-pick/merge/commit onto the branch would appear in the
> branch object's history, kinda just like the reflog.  The main
> difference is that the upstream branch's history could be viewed.
>
> > With rebases the problem is that it would be nice to have (at least
> > for a short time) the history of series of patches (the metahistory,
> > or history of a branch), but usually one doesn't need old pre-rebase
> > version after cleaning up the history for publishing.
>
> Right.

I have been fiddling around in this area.

What I want to be able to do is develop fixes for open source code that I
run, and get those fixes upstream. This means I need a rebasing workflow,
to keep the patches up-to-date and to deal with code review feedback.

But this is inconvenient for deploying the patched version to production
(which is the point of developing the fixes) - I want a fast-forwarding
branch for that. And it would be nice to be able to share the history of
the patch series, so others can see what changed between revisions more
easily.

So I have a small tool which maintains a publication branch which tracks
the head of a rebasing branch. It's reasonably satisfactory so far...

https://git.csx.cam.ac.uk/x/ucs/git/git-repub.git

=2E.. though the structure of the publication branch is weird and not very
easy to navigate. You can see it in action in my git.git repo:

https://git.csx.cam.ac.uk/x/ucs/git/git.git/shortlog/refs/heads/ucam/fanf2/=
patch

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Irish Sea: Variable 4. Slight. Showers. Good.
--1870869256-825576390-1407411528=:13901--
