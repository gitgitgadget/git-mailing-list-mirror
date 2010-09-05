From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sun, 05 Sep 2010 19:52:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009051820100.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
 <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
 <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
 <4C81DC34.2090800@gmail.com> <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
 <AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
 <AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
 <alpine.LFD.2.00.1009042132500.19366@xanadu.home>
 <AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_cSYg+o3GhxrZAzAxI8Iugw)"
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 01:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsP0h-0000Fg-3B
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 01:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab0IEXw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 19:52:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab0IEXwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 19:52:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L8A00EDZSZBSI10@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 05 Sep 2010 19:52:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155500>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_cSYg+o3GhxrZAzAxI8Iugw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 5 Sep 2010, Luke Kenneth Casson Leighton wrote:

> On Sun, Sep 5, 2010 at 3:16 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Sat, 4 Sep 2010, Luke Kenneth Casson Leighton wrote:
> >
> >> * git-index-pack requires a pack file in order to re-create the index:
> >> i don't want that
> >> * git-pack-objects appears to have no way of telling it "just gimme
> >> index file please"
> >> * fast-import.c appears not to be what's needed either.
> >>
> >> so - any other methods for just getting the index file (exclusively?)
> >> any other commands i've missed?  if not, are there any other ways of
> >> getting a pack's index of objects without err... getting the index
> >> file?  (i believe the answer to be no, but i'm just making sure) and
> >> on that basis i believe it is safe to ask: any objections to a patch
> >> which adds "--index-only" to builtin/pack-objects.c?
> >
> > No patch is needed.
> >
> > First, what you want is an index of objects you are willing to share,
> > and not the index of whatever pack file you might have on your disk,
> > especially if you have multiple packs which is typical.
> 
>  blast.  so *sigh* ignoring the benefits that can be obtained by the
> delta-compression thing, somewhat; ignoring the fact that perhaps less
> traffic miight be transferred by happening to borrow objects from
> another branch (which is the situation that, i believe, happens with
> "git pull" over http:// or git://); ignoring the fact that i actually
> implemented using the .idx file yesterday ... :)

Please, let's get it slow.

There are 2 concepts you really need to master in order to come up with 
a solution.  And those concepts are completely independent from 
each other, but at the moment you are blending them up together and 
that's not good.

The first one is all about object enumeration.  And object enumeration 
is all about 'git rev-list'.  This is important when offering objects to 
the outside world that you actually do offer _all_ the needed objects, 
but _only_ the needed objects.  If some objects are missing you get a 
broken repository.  But more objects can also be a security problem as 
those extra objects may contain confidential data that you never 
intended to publish.

And object enumeration has absolutely nothing to do with packs, nor .idx 
files for that matter.  As I said, the objects you want might be split 
across multiple packs, and also in loose form, and also in some 
alternate location that is shared amongst many repositories on the same 
filesystem.  But a single pack may also contain more than what you want 
to offer, and it is extremely important that you do _not_ offer those 
objects that are not reachable from the branch you want to publish.

Following me so far?

The second concept is all about object _representation_ or _encoding_.  
That's where the deltas come into play.  So the idea is to grab the list 
of objects you want to publish, and then look into existing packs to see 
if you could find them in delta form.  So, for each object, if you do 
find them in delta form, and the objec the delta is made against is 1) 
also part of the list of objects you want to send, or 2) is already 
available at the remote end, then you may simply reuse that delta data 
as is from the pack.  Finding if a particular pack has the wanted object 
is easy: you just need to look it up in the .idx file.  Then, in the 
corresponding pack file you parse the object header to find out if it is 
a delta, and what its base object is.

>  ... there is a bit of a disadvantage to using pack index files that
> it goes all the way down (if i am reading things correctly) and cannot
> be told "give me just the objects related to a particular commit"....

Exact.  The .idx file gives you a list of objects that exists in the 
corresponding pack.  That list of object might belong to a totally 
random number of random commits.  You may also have a random number of 
packs across which some or all objects are distributed.  Because, of 
course, not all the objects you need are always packed.

So... I hope you understand now that there is no relation between 
commits and .idx files.  The only exception is when you do create a 
custom pack with 'git pack-objects'.

> > Try this instead:
> >
> >    git rev-list --objects HEAD | cut -c -40 | sort
> >
> > That will give you a sorted list of all objects reachable from the
> > current branch.  With the Linux repo, you may replace "HEAD" with
> > "v2.6.34..v2.6.35" if you wish, and that would give you the list of the
> > new objects that were introduced between v2.6.34 and v2.6.35.
> 
>  ... unlike this, which is in fact much more along the lines of what i
> was looking for (minus the loveliness of the delta compression oh
> well)

Again, delta compression is a _separate_ issue.

> > This will
> > provide you with 84642 objects instead of the 1.7 million objects that
> > the Linux repo contains (easier when testing stuff).
> 
>  hurrah! :)  [but, then if you actually want to go back and get alll
> commits, that's ... well, we'll not worry about that too much, given
> the benefits of being able to get smaller chunks.]

If you want all commits then you just need --all instead of HEAD.

> > That sorted list of objects is more or less what the pack index file
> > contains, plus an offset in the pack for each entry.  It is used to
> > quickly find the offset for a given object in the corresponding pack
> > file, and the fanout is only a way to cut 3 iterations in the binary
> > search.
> >
> > But anyway, what you want is really to select the precise set of objects
> > you wish to share, and not blindly using the pack index file.  If you
> > have a public branch and a private branch in your repository, then
> > objects from both branches may end up in the same pack
> 
>  slightly confused: are you of the belief that i intend to ignore
> refs/branches/* starting points?

I don't know what your exact understanding of Git is, and although I 
know one or two things about the Git storage model, I get confused 
myself by some of your comments, such as this one above.

> > and you probably
> > don't want to publish those objects from the private branch.
> 
>  ahh, i wondered where i'd seen the bit about "confusing" two
> branches, i thought it was in another message.  so many flying back &
> forth :)  from what i can gather, this is exactly what happens with
> git fetch from http:// or git:// so what's the big deal about that?
> why stop gitp2p from benefitting from the extra compression that could
> result from "borrowing" bits of another branch's objects, neh?

No.  git:// will _never_ ever transfer any object that is not part of 
the published branch(es).  If an object that does get transmitted is 
actually a delta against an object that is only part of a branch that is 
not published, then the delta will be expanded and redone against 
another suitable object before transmission.


Nicolas

--Boundary_(ID_cSYg+o3GhxrZAzAxI8Iugw)--
