From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 18:42:50 +0800
Message-ID: <a7e835d40610200342ibc56fd9t542a60230ebe0020@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <87ods727pn.wl%cworth@cworth.org>
	 <a7e835d40610191953i467ce853k4b4740bbfdd92936@mail.gmail.com>
	 <200610201151.13199.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 12:42:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Garq4-0000WX-Ml
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 12:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWJTKmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 06:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWJTKmx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 06:42:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:23173 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1160993AbWJTKmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 06:42:52 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1383491nfe
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 03:42:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NpiZhJd3bOHayCM0xVWMHW9JjxV0cXggkC00Inoem+9gKGlCsApXCbC5Bn48g/+J4/oUGE6464ZxHsDNCI/jKfQVl9xOmbS4HgkUBD0oxkhYhefB1NJXjxN2mb7efI/WIAmeZ94QGpZlO+JInizwdYCKcgpwZk1WMV7QDYiw/Tk=
Received: by 10.82.105.13 with SMTP id d13mr415388buc;
        Fri, 20 Oct 2006 03:42:50 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Fri, 20 Oct 2006 03:42:50 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610201151.13199.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: ffcc8bc5de63dcfb
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29441>

On 20/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
> James Henstridge wrote:
> > On 20/10/06, Carl Worth <cworth@cworth.org> wrote:
> >> On Thu, 19 Oct 2006 19:01:58 -0400, Aaron Bentley wrote:
>
> >>>             Additionally, the new mainline can keep a mirror of the
> >>> abandoned mainline in its repository, because there are virtually no
> >>> additional storage requirements to doing so.
> >>
> >> And this part I don't understand. I can understand the mainline
> >> storing the revisions, but I don't understand how it could make them
> >> accessible by the published revision numbers of the "abandoned"
> >> line. And that's the problem.
> >
> > With this sort of setup, I would publish my branches in a directory
> > tree like this:
> >
> >     /repo
> >         /branch1
> >         /branch2
> >
> > I make "/repo" a Bazaar repository so that it stores the revision data
> > for all branches contained in the directory (the tree contents,
> > revision meta data, etc).
>
> And here we have a feature which is as far as I see unique to git,
> namely to have persistent branches with _separate namespace_. It means
> that we can have hierarchical branch names (including names like
> "remotes/<remotename>/<branch of remote>", or "jc/diff"), and we don't
> have to guess where repository name ends and branch name begins.

With the above layout, I would just type:
    bzr branch http://server/repo/branch1

This command behaves identically whether the repository data is in
/repo or in /repo/branch1.  Someone pulling from the branch doesn't
have to care what the repository structure is.  Having a separate
namespace for branch names only really makes sense if the user needs
to care about it.

As for heirarchical names, there is nothing stopping you from using
deaper directory structures with Bazaar too.  Bazaar just checks each
successive parent directory til it finds a repository for the branch.


> The idea of "branches (and tags) as directories" was if I understand
> it correctly introduced by Subversion, and from what can be seen from
> troubles with git-svn (stemming from the fact that division between
> project name and branch name is the matter of _convention_) at least
> slightly brain-damaged.

I think you are a bit confused about how Bazaar works here.  A Bazaar
repository is a store of trees and revision metadata.  A Bazaar branch
is just a pointer to a head revision in the repository.  As you can
probably guess, the data for the branch is a lot smaller than the data
for the repository.

You can store the repository and branch in the same directory to get a
standalone branch.  The layout I described above has a repository in a
parent directory, shared by multiple branches.

If you are comparing Subversion and Bazaar, a Bazaar branch shares
more properties with a full Subversion repository rather than a
Subversion branch.


> > The "/repo/branch1" essentially just contains a list of mainline
> > revision IDs that identify the branch.  This could probably be just
> > store the head revision ID, but there are some optimisations that make
> > use of the linear history here.
> >
> > If the ancestry of "/repo/branch2" is a subset of branch1 (as it might
> > be if the in the case of forked then merged projects), then all its
> > revision data will already be in the repository when branch1 was
> > imported.  The only cost of keeping the branch around (and publishing
> > it) is the list of revision IDs in its mainline history.
> >
> > For similar reasons, the cost of publishing 20 related Bazaar branches
> > on my web server is generally not 20 times the cost of publishing a
> > single branch.
> >
> > I understand that you get similar benefits by a GIT repository with
> > multiple head revisions.
>
> You can get similar benefits by a GIT repository with shared object
> database using alternates mechanism. And that is usually preferred
> over storing unrelated branches, i.e. branches pointing to disconnected
> DAG (separate trees in BK terminology) of revision, if that you mean by
> multiple head revisions (because in GIT there is no notion of "mainline"
> branch, only of current (HEAD) branch).

I may have got the git terminology wrong. I was trying to draw
parallels between the .git/refs/... files in a git repository and the
way multiple branches can be stored in a Bazaar repository.

I am not claiming that you'll get bandwidth or disk space benefits for
storing unrelated branches in a single Bazaar repository.  But if the
branches are related, then there will be space savings (which is what
the great-grandparent post was asking about).


> >>>> But for these communications, revision numbers will not provide
> >>>> historically stable values that can be used.
> >>>
> >>> They certainly can.
> >>>
> >>> The coder says "I've put up a branch at http://example.com/bzr/feature.
> >>>  In revision 5, I started work on feature A.  I finished work in
> >>> revision 6.  But then I had to fix a related bug in revision 7."
> >>
> >> "I've put this branch up" isn't historically stable...
> >
> > With the repository structure mentioned above, the cost of publishing
> > multiple branches is quite low.  If I continue to work on the project,
> > then there is no particular bandwidth or disk space reasons for me to
> > cut off access to my old branches.
> >
> > For similar reasons, it doesn't cost me much to mirror other people's
> > related branches if I really care about them.
>
> But the revision number in this case _changes_. It is from 7 to
> branch:7 but still it changes somewhat.

A revision number is only has meaning in the context of a branch.  If
I mirror a branch, the revision numbers in the context of each will
refer to the same revision IDs.

I am not sure what sort of distinction you are trying to draw.


> >> The naming in git really is beautiful and beautifully simple.
> >
> > I don't think anyone is saying that universally unique names are bad.
> > But I also don't see a problem with using shorter names that only have
> > meaning in a local scope.
> >
> > I've noticed some people using abbreviated SHA1 sums with GIT.  Isn't
> > that also a case of trading potential global uniqueness for
> > convenience when working in a local scope?
>
> Emphasisis on _potential_. SHA1 id abbreviated to 6 characters might
> be not unique in larger project, but for example the chance that
> SHA1 id abbreviated to 7 or 8 characters is not unique is really low.

My point was that by shortening the IDs with GIT, you are trading
global uniqueness (i.e. the identifier may clash with one found in a
different context) for the convenience of shorter identifiers.

Provided you know that the tradeoff is being made, it isn't generally
much of a problem.  I agree that the ability to pick how much of a
tradeoff is made by altering the length of the identifier is a nice
property of GIT.


> Yet another analogy:
>
> SHA1 identifiers of commits (and not only commits) can be compared
> to Message-Ids of Usenet messages, while revision numbers can be compared
> to Xref number of Usenet message which if I understand correctly is unique
> only for given news server. But Message-Ids cannot be shortened
> meaningfully like SHA1 ids can; newertheless they are used in communication
> without any problems. Even if namespace is not simple ;-)

I can't say I ever used usenet much, so can't comment too much.  But
from your description, a (server, xref) tuple could be used to look up
the unique identifier in a similar way to how you can do so in Bazaar
with a (branch_url, revno) tuple.

James.
