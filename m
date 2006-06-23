From: Pavel Roskin <proski@gnu.org>
Subject: Re: Ideas for qgit
Date: Fri, 23 Jun 2006 16:59:05 -0400
Message-ID: <1151096345.10112.41.camel@dv>
References: <1151035711.25640.6.camel@dv>
	 <e5bfff550606231112l6ca67799m7dddfabcee055045@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 22:59:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtskD-0001oE-DB
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 22:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWFWU7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWFWU7K
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 16:59:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:47507 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1752051AbWFWU7J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 16:59:09 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ftsk7-0001Sc-S0
	for git@vger.kernel.org; Fri, 23 Jun 2006 16:59:08 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Ftsk5-0002kG-Pt; Fri, 23 Jun 2006 16:59:05 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606231112l6ca67799m7dddfabcee055045@mail.gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22439>

On Fri, 2006-06-23 at 20:12 +0200, Marco Costalba wrote:
> On 6/23/06, Pavel Roskin <proski@gnu.org> wrote:
> > Hi, Marco!
> >
> > As promised, here's what I would like to see in qgit:
> >
> > 1) Bookmarks or quick tags (qtags).  It may be useful to mark some
> > commits to make it easier to navigate qgit.  Yet I don't want them to
> > mix with real tags.  Perhaps qgit could save them separately, e.g.
> > in .git/refs/qtags to facilitate navigation.  qtags should appear
> > separately in the popup menu.
> >
> 
> Currently we have two types of tags, signed and simple.

I guess they should be shown a bit differently.

>  If it is
> possible I would really like to stay with git tags, because bookmarks
> seems to me like reinventing the (broken) wheel.

OK, I don't insist.  Then we need a user-friendlier implementation of
Ctrl-Rightclick in the revision list.  I stumbled upon it accidentally,
and it looked like a bug at the first glance, when the file box suddenly
went turquoise and stopped showing modified files.  I still couldn't
figure out how to turn it off without going to the Patch tab and setting
diff to parent.

> Git is very good in tagging and untagging and IMHO we should stay with
> them, perhaps in the simple version. I really don't see any advantage
> nor immediate and less in the long term to almost duplicate that
> functionality and loosing proven git native tag handling features.

OK

> > 2) The "Patch" tab should be redesigned so that the diff can be shown
> > against the parent or against head/tag/qtag.  Users are not supposed to
> > enter SHA1.  If they have to, then it only confirms that qgit needs
> > qtags.
> >
> 
> Well, you can write also a ref name in SHA1 field. Try with
> "v2.6.17-rc6" or "v1.4.0".
> Perhaps this should be better documented and the SHA1 name is misleading.

I think it also shows that a wrong widget is used.  Probably an editable
listbox with all tag and branch names would be better.

> > 3) It would be nice to have some minimal navigating capabilities on the
> > Patch tab.  At least it should be possible to go up and down the
> > revision list and go to any head/tag/qtag/stgit patch.  It would
> > eliminate the need to switch to the "Rev list" too often.
> >
> 
> This make me think of biting the bullet and append patch information
> _also_ below revision description, yes, a la gitk. I think this is
> really what you feel is missing.

Maybe.  "Rev list" and "Patch" represent essentially the same thing
shown differently.  They can be replaced with one tab if it offers
enough flexibility to use the screen space differently for different
tasks.

> > 4) Some bisect support would be nice, at least as good as in gitk.
> > Actually, I'm not using bisect too much, but it's probably because I'm
> > not debugging Wine these days.  Everything else is intelligible :-)
> >
> 
> I don't use bisect and I don't know the gitk implementation.
> I will investigate when I found some time. Not a top priority, at
> least for my kind of workflow ;-)

I agree.

> > 5) Branch view based on reflog.  Probably there should be an interface
> > allowing to limit the displayed revisions to one branch.  I think qgit
> > should still load all revisions that it loads now, but if users start
> > complaining about performance too much, maybe qgit should have an option
> > to load only the logged branch.  The problem is that some parents will
> > be unavailable in the view.
> >
> 
> I think I didn't understand this. Isn't there command line arguments
> for narrowing loaded revision set?

As far as I understand, reflog is only used to resolve references
specified as branch@date.  It doesn't seem to be well integrated with
the rest of git.

> > 7) qgit command line should be documented.  "qgit --help" should display
> > help on stdout.
> >
> 
> All the stuff in command line is sent directly to git-rev-parse. I
> think this is good because avoids any overlapping between qgit and git
> options and guarantees future compatibility with _any_  git option.

This also means that features not related to git-rev-parse (including
StGIT and possible reflog support) cannot be controlled from the command
line.  It's not critical now, but it may become more important.

-- 
Regards,
Pavel Roskin
