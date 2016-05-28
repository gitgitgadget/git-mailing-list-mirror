From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Date: Sat, 28 May 2016 08:37:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605280815040.4449@virtualbox>
References: <1464356141-3797-1-git-send-email-dak@gnu.org> <alpine.DEB.2.20.1605271633230.4449@virtualbox> <87d1o7pkyy.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1141733199-1464417436=:4449"
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 28 08:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6XsK-0007fZ-9U
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 08:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbcE1Gh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 02:37:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:61713 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbcE1GhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 02:37:25 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MEFIm-1bHU6F1dhw-00FRPB; Sat, 28 May 2016 08:37:15
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <87d1o7pkyy.fsf@fencepost.gnu.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1S5AKXtpY4Sm3FBguoIVIdaokknJFJNGf84MrlN4EuXcF/BNaBs
 XCib1264IAlQBmf+/52QYIqlRUPjjBr2eAVqiW+s4OBX0eAPI6xwMFJ+i4ORLvf6MsZmv2D
 jzbRQl3F18fSVEgx+X8BY1h8qhhH13HHTj0nzlPo8O/xoFDRep+ZC1lOwQx+vA0cpmqAKwM
 jCwwUGV1if+BInaHl4f0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:97cudXQEXrY=:+fXSDwIvqHiqZ9fW7dC4C2
 vyMGULQf+4x+RL16si8GvbYBgywkM6BeijgHQCeyhgVug6kswm7qio3Kft54Akg7snkX64aYd
 o7bOP9q7gfyaKQeS7Ca0Yv09a2pC0QqxxWb7pNo/z8TKwWEQbOdKfTQPD5EqAo60iRJYNZUN6
 aeF74o8rzOwnwUt5ZyZAlk6lrJoiQ/a6wKTIlmcXF2M+XT/2PbopRoFwZDqx0T2Ca5cFJYn/D
 VIlZnqAnoXryd0/vqMWnqkkDhHQvPLU+LYR9z+myqCp7mwk+l90/VcoTxVGvQ1hqBkfMWg9f8
 fmgphRPWizrJYCSoVsqOfkX8m4qCBT+L0lZ3AX73I97KkUbzjpaKoQVWoIRuo5WG2GmqT8N3G
 TsE6BEVsi+TXS+ZHoyn/pFndo2OnTAqEsPwvpvrqjvNN51tbOkAGgXB23ib0nbs7sFRg4knP7
 3Uvd8bwj6IhvzaqZc3jN/J9zSjY7eFe96Y7nSqYR1iVoiZucIRjW6SIj1mEh84r13cC6dWEr5
 ZCCYODspX9U5DFCYVEkNbpLQmrqLaXJ/KFU6TOYsGPbFesNJK6kdZJ38UY0uJegAdwGVQLWc2
 lIWxTkZ/tKTGHGcsK2jpeDdPtqAFGKKiIzO+w8IMbEKY5QIAzRR8wY1VCzraSzrLusuu3aOuW
 mlt9buxU5WALGZpQg5QPplVkoLOUpe7KMtW+mip/9U5YDu19Ch+A4rocpYSJlrvhl45Cyuz9j
 /3jOvtB5A1FJxECoryklJXsT/+iyrZBy9o8AWS14P3xZPN2fhatGRMySJxuWblqY+H5fLZY0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295802>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1141733199-1464417436=:4449
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi David,

On Fri, 27 May 2016, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Fri, 27 May 2016, David Kastrup wrote:
> >
> >> pressure particularly when the history contains lots of merges from
> >> long-diverged branches.  In practice, this optimization appears to
> >> behave quite benignly,
> >
> > Why not just stop here?
>=20
> Because there is a caveat.
>=20
> > I say that because...
> >
> >> and a viable strategy for limiting the total amount of cached blobs in=
 a
> >> useful manner seems rather hard to implement.
> >
> > ... this sounds awfully handwaving.
>=20
> Because it is.

Hrm. Are you really happy with this, on public record?

> > Since we already have reference counting, it sounds fishy to claim
> > that simply piggybacking a global counter on top of it would be
> > "rather hard".
>=20
> You'll see that the patch is from 2014.

No I do not. There was no indication of that.

> When I actively worked on it, I=C2=A0found no convincing/feasible way to
> enforce a reasonable hard limit.  I am not picking up work on this again
> but am merely flushing my queue so that the patch going to waste is not
> on my conscience.

Hmm. Speaking from my point of view as a maintainer, this raises a yellow
alert. Sure, I do not maintain git.git, but if I were, I would want my
confidence in the quality of this patch, and in the patch author being
around when things go south with it, strengthened. This paragraph achieves
the opposite.

> >> In addition, calling git-blame with -C leads to similar memory retenti=
on
> >> patterns.
> >
> > This is a red herring. Just delete it. I, for one, being a heavy user o=
f
> > `git blame`, could count the number of times I used blame's -C option
> > without any remaining hands. Zero times.
> >
> > Besides, -C is *supposed* to look harder.
>=20
> We are not talking about "looking harder" but "taking more memory than
> the set limit".

I meant to say: *of course* it uses more memory, it has a much harder job.

> > Also: is there an easy way to reproduce your claims of better I/O
> > characteristics? Something like a command-line, ideally with a file in
> > git.git's own history, that demonstrates the I/O before and after the
> > patch, would be an excellent addition to the commit message.
>=20
> I've used it on the wortliste repository and system time goes down from
> about 70 seconds to 50 seconds (this is a flash drive).  User time from
> about 4:20 to 4:00.  It is a rather degenerate repository (predominantly
> small changes in one humongous text file) so savings for more typical
> cases might end up less than that.  But then it is degenerate
> repositories that are most costly to blame.

Well, obviously I did not mean to measure time, but I/O. Something like an
strace call that pipes into some grep that in turn pipes into wc.

> > Further: I would have at least expected some rudimentary discussion
> > why this patch -- which seems to at least partially contradict 7c3c796
> > (blame: drop blob data after passing blame to the parent, 2007-12-11)
> > -- is not regressing on the intent of said commit.
>=20
> It is regressing on the intent of said commit by _retaining_ blob data
> that it is _sure_ to look at again because of already having this data
> asked for again in the priority queue.  That's the point.  It only drops
> the blob data for which it has no request queued yet.  But there is no
> handle on when the request is going to pop up until it actually leaves
> the priority queue: the priority queue is a heap IIRC and thus only
> provides partial orderings.

Again, this lowers my confidence in the patch. Mind you, the patch could
be totally sound! Yet its commit message, and unfortunately even more so
the discussion we are having right now, offer no adequate reason to assume
that. If you, as the patch author, state that you are not sure what this
thing does exactly, we must conservatively assume that it contains flaws.

> >> diff --git a/builtin/blame.c b/builtin/blame.c
> >> index 21f42b0..2596fbc 100644
> >> --- a/builtin/blame.c
> >> +++ b/builtin/blame.c
> >> @@ -1556,7 +1556,8 @@ finish:
> >>  =09}
> >>  =09for (i =3D 0; i < num_sg; i++) {
> >>  =09=09if (sg_origin[i]) {
> >> -=09=09=09drop_origin_blob(sg_origin[i]);
> >> +=09=09=09if (!sg_origin[i]->suspects)
> >> +=09=09=09=09drop_origin_blob(sg_origin[i]);
> >>  =09=09=09origin_decref(sg_origin[i]);
> >>  =09=09}
> >
> > It would be good to mention in the commit message that this patch does =
not
> > change anything for blobs with only one remaining reference (the curren=
t
> > one) because origin_decref() would do the same job as drop_origin_blob
> > when decrementing the reference counter to 0.
>=20
> A sizable number of references but not blobs are retained and needed for
> producing the information in the final printed output (at least when
> using the default sequential output instead of --incremental or
> --porcelaine or similar).

Sorry, please help me understand how that response relates to my
suggestion to improve the commit message.

> > In fact, I suspect that simply removing the drop_origin_blob() call
> > might result in the exact same I/O pattern.
>=20
> It's been years since I actually worked on the code but I'm still pretty
> sure you are wrong.

The short version of your answer is that you will leave this patch in its
current form and address none of my concerns because you moved on,
correct? If so, that's totally okay, it just needs to be spelled out.

Ciao,
Johannes
--8323329-1141733199-1464417436=:4449--
