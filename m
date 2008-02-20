From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: new stacked git feature
Date: Wed, 20 Feb 2008 23:06:07 +0000
Message-ID: <b0943d9e0802201506w353b5c05vece9f99730d7663c@mail.gmail.com>
References: <20080111194946.GA7504@redhat.com>
	 <1202834567.14175.68.camel@pc1117.cambridge.arm.com>
	 <20080213000806.GB25839@diana.vm.bytemark.co.uk>
	 <b0943d9e0802131429p76f0981cm6e54a6a07042f229@mail.gmail.com>
	 <20080213235204.GA10335@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jason Baron" <jbaron@redhat.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Yann Dirson" <ydirson@altern.org>, git <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 00:07:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRy1h-0000Aq-2o
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbYBTXGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Feb 2008 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755785AbYBTXGO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:06:14 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:15524 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbYBTXGL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2008 18:06:11 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2336263wxd.4
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 15:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CxkX/g128sEA9TPKX/x0sHZE4u6bYVI5fqFUvn+hTus=;
        b=SnmAODNOTojiVKRBn3MIsNejcPBZvgly4CdPMaBWOTt/jWuKnPxcGbza4WmoPLcWCKWIXkrU3Rj+rVcWEi/7j3OPTJqAcfGbfExYQgsxkwL40MdK2qyBjUc8JAoIChETTaXvIWDB3N8WATs21irrVY9QdE7FJ0pScCWUbuMRUUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bjlxeZlbWeM7PzawVLMZ4IpiHBM04MzV+eRBljwY6QlKHDzAl/Ci8fPjRJhWlmIURASlhGZL1nBwwHSV4aIXvt3VWxpkoScQM/YZfPnAZAArdH1oh6o/EbheKr6orqmmimVFkPRLBOHowCzg5fqd/SouL6l95smQ22PMqHsgR9U=
Received: by 10.140.251.1 with SMTP id y1mr6150255rvh.102.1203548767178;
        Wed, 20 Feb 2008 15:06:07 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Wed, 20 Feb 2008 15:06:07 -0800 (PST)
In-Reply-To: <20080213235204.GA10335@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74564>

On 13/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-02-13 22:29:34 +0000, Catalin Marinas wrote:
>
>  > On 13/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>  >
>
> > >   * Every time the patch stack is modified (that is, any time an
>  > >     StGit command modifies anything at all), a new commit is mad=
e
>  > >     to a log branch. Each StGit branch has one such log branch.
>  >
>  > We already have another commit for the patch history. If we add
>  > this, we end up with 3 commit for each patch command. People alrea=
dy
>  > complained that StGIT is slow, I wouldn't go this route.
>
>
> I intend to get rid of the current per-patch log. It doesn't save
>  enough information to be useful anyway.

I use it from time to time. The commit message gives you the commit id
of the patch at that time and the commit diff gives you the changes
made by a refresh. It's mainly useful if you ran refresh and don't
remember what changes you've added.

>  As for the speed: we'll have to write one blob and one tree per
>  modified patch, plus one top-level tree and a small constant number =
of
>  blobs. (Caveat: my current implementation is too stupid to realize
>  that not all patches were modified all the time.) These simple
>  create-an-object-from-data-on-stdin commands should be fast enough
>  that this won't be a problem (and if a dozen extra calls to git is t=
oo
>  expensive, we'll just have to build a git command that can take them
>  all in one go).

As I said in the other e-mail, it needs a run through stg-prof to see
what the impact is with large number of patches.

>  I'd like to try my scheme out first, however. It's potentially more
>  powerful, since it can be pulled between repositories and maybe even
>  merged.

That's interesting indeed (though I don't fully understand all of this)=
=2E

>  > >   2. The merged stack base is created with a normal recursive
>  > >      merge.
>  >
>  > A recursive merge with the HEAD of another stack containing simila=
r
>  > patches? If yes, when pushing it is likely that the patches alread=
y
>  > in the base will be emptied during a three-way merge.
>
>
> No, a merge of the stack _bases_, with all patches popped off. And
>  this would be a regular git merge, so no emptying of patches.

OK, but we would need the StGIT information about stack bases to be
passed between repositories. And, after this merge, how do you merge
common patches (but maybe slightly modified)?

>  > >   3. When a conflicting patch is pushed, we do the following:
>  > >
>  > >        1. For each of .ours, .theirs, .base0, ..., create a new
>  > >           "b" tree just like we do when we normally push a patch=
=2E
>  > >           If there are conflicts, autoresolve them like
>  > >           merge-recursive does internally.
>  > >
>  > >        2. Create the single new "b" tree by making a recursive
>  > >           merge of all these updated "b" trees. Represent any
>  > >           conflicts like we usually do when pushing patches.
>  >
>  > My idea is to merge each patch with the corresponding commit in th=
e
>  > other branch and leave the base unchanged (like "stg sync"). The
>  > difficulty is in identifying which commit from the other branch ha=
s
>  > to be used. We could try guessing by the number of changes or just
>  > using the subject line, assuming that it won't change (or an extra
>  > id field in the commit text).
>
>
> I was thinking about the same thing: just match up the patches with
>  the same name. If the user has renamed a patch, she can coalesce the
>  two manually.

Ah, OK. But how do we pass the patch name information? I think the
commit log wouldn't be enough as it can be easily modified. There is
also a situation when patches on the remote stack were reordered and
with some conflicts fixed. In this case, merging gets even more
complicated (I think darcs solves this by making all the patches
immutable but the base feature of StGIT is that patches are easily
modifiable).

>  > I find this workflow pretty difficult to implement since the StGIT
>  > patches are pretty volatile. It might be better to use topic
>  > branches instead.
>
>
> I agree that it's far from certain that this will be a very useful
>  workflow. But I'm willing to bet a couple of day's work that it is, =
so
>  I'll build a prototype and see.

It would be nice to allow an easy workflow for people trying to share
the same repository and benefit from StGIT. There was a recent thread
on the Linux kernel lists about a new branch, linux-next, which
included some discussions on GIT, patch management, rebasing etc. Some
people mentioned that they ended up using classic patch management
(quilt) and storing the patches in a repository which can be shared
between developers.

--=20
Catalin
