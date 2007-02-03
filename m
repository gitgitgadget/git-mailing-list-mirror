From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-clone wrongly setting branch.*.merge ? (Was: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".)
Date: Sat, 3 Feb 2007 15:47:25 +0100
Message-ID: <20070203144725.GK5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net> <20070202235655.GG5362@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702030416t4088e7e1yaf2ac0a4c30def8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 15:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDMBm-0005ct-22
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 15:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946466AbXBCOsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 09:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946467AbXBCOsV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 09:48:21 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:51326 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946466AbXBCOsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 09:48:20 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 814C94A182;
	Sat,  3 Feb 2007 15:48:19 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 4FA2B1F080; Sat,  3 Feb 2007 15:47:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702030416t4088e7e1yaf2ac0a4c30def8d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38565>

On Sat, Feb 03, 2007 at 12:16:47PM +0000, Catalin Marinas wrote:
> Yann,
> 
> On 02/02/07, Yann Dirson <ydirson@altern.org> wrote:
> >On Fri, Feb 02, 2007 at 07:07:06PM +0100, Yann Dirson wrote:
> >> On Fri, Feb 02, 2007 at 09:58:06AM +0000, Catalin Marinas wrote:
> >> > On 01/02/07, Yann Dirson <ydirson@altern.org> wrote:
> >> > >Previously we were just assuming that the remote from which we
> >> > >just failed defined a local branch whose name was the same as the
> >> > >remote def, and that this branch was the parent.  While this is true
> >> > >for the most common case (branch "origin" from remote "origin"), it is
> >> > >quite an unflexible assumption.
> >> >
> >> > The t1200-push-modified.sh test fails after applying this patch. It
> >> > looks like the 3rd test fails to pull the changes from 'foo' into
> >> > 'bar'.
> >
> >With current GIT HEAD, plain git-clone creates the following config
> >(when cloning a repo with HEAD pointing to branch "downstream":
> 
> As I haven't followed the GIT latest developments in this area, I
> can't comment.

As noted elsewhere, I have misinterpreted the branch.*.merge
parameter; I'm trying to get things right.

> Regarding StGIT, I'd like it to work with earlier
> stable versions of GIT and not just with the current HEAD. I (and
> probably many others) already have repositories cloned some (long)
> time ago and their gitconfig might not have the cloning information.

There are 2 issues there:

- support for running atop previous releases of Git. For this we
should select a policy like "we support the current stable branch (or
to-be-published, like 1.5.0), and the previous (ie. 1.4.4.x or
1.4.x)", and document that in the release notes so packagers can
update their dependencies.

- and continue to work with repos created with old releases.  For the
"pull" change, what's needed (or should be, modulo bugs such as this
one), is to tell people they need to "git config" the missing info
when it's not there.  I have tried to keep the old behaviour as much
as possible (ie. relying on the user to pass the info on command-line)
instead of insisting on the user providing the info in the config
file, but this work is probably not 100% finished.


> The (interim) solution I see is for StGIT pull command to default to
> using git-pull and people can configure it to git-fetch and the
> automatic rebase if they need it. I'd like to release 0.12 this
> weekend but

Right, it is reasonable to keep the old behaviour the default for now.


> 'pull' doesn't currently work.

I'll still try to make it work nevertheless before the release :)

Best regards,
-- 
Yann.
