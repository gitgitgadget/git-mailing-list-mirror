From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Thu, 28 Aug 2008 17:31:18 +0200
Message-ID: <20080828153118.GA13169@diana.vm.bytemark.co.uk>
References: <20080808211318.GA4396@efreet.light.src> <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com> <20080817195839.GB4542@efreet.light.src> <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com> <20080818180048.GA15520@efreet.light.src> <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com> <20080827201819.GD15520@efreet.light.src> <e5bfff550808280429h63496f9byfa4454af7adb0e86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYj8i-0005Q6-MI
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbYH1PJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 11:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYH1PJT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:09:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1057 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYH1PJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:09:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KYjSx-0003ZY-00; Thu, 28 Aug 2008 16:31:19 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550808280429h63496f9byfa4454af7adb0e86@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94066>

On 2008-08-28 13:29:25 +0200, Marco Costalba wrote:

> On Wed, Aug 27, 2008 at 10:18 PM, Jan Hudec <bulb@ucw.cz> wrote:
>
> > Actually, I just wrote a first simple test for it. I didn't find
> > this (now the stg branch finds out properly), but I found another
> > problem -- when switching from non-stgit branch to a stgit one,
> > Git::init will not notice, because the path didn't change, so the
> > check is not re-run. Applies to the other direction too, of
> > course.
>
> I have never tested on repos where some branches are under stgit and
> others are not. Actually I even didn't know it was possible.

StGit has no per-repo data. It's all per-branch. "stg init" operates
on the current branch, not the whole repo.

> The command:
>
> isStGIT =3D run("stg branch", &stgCurBranch); // slow command
>
> is used to check if a repo is under StGit control, i.e 'stg init'
> has been run in the repo working directory (it doesn't mean that
> there are StGit patches applied or unapplied, could be also without
> them).

Hmm. For me, "stg branch" succeeds even if "stg init" has not yet been
run (which is arguably as it should be, since it doesn't require that
stg init has been run in the current branch). "stg series" or
something is probably better for this purpose.

Though if you're concerned about speed (as the comment indicates), you
should probably do something cheaper than running stg, such as
checking if .git/patches/<branchname> exists.

> So it's not very clear to me what does it mean "switching from
> non-stgit branch to a stgit one"

Switching from a branch where "stg init" hasn't been run, to one where
it has.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
