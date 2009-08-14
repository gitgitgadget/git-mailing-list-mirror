From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: rebase-with-history -- a technique for rebasing without trashing
 your repo history
Date: Fri, 14 Aug 2009 23:21:01 +0200
Message-ID: <4A85D53D.9050805@alum.mit.edu>
References: <4A840B0F.9060003@alum.mit.edu> <20090813161256.GA8292@atjola.homenet> <4A849634.1020609@alum.mit.edu> <20090813233027.GA19833@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc4D6-0004Bx-FJ
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 23:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbZHNVVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 17:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbZHNVVG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 17:21:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40618 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbZHNVVG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 17:21:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (p4FC1EC2D.dip.t-dialin.net [79.193.236.45])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n7ELL3ji011161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Aug 2009 23:21:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.22) Gecko/20090608 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
In-Reply-To: <20090813233027.GA19833@atjola.homenet>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125956>

Bj=F6rn Steinbrink wrote:
> On 2009.08.14 00:39:48 +0200, Michael Haggerty wrote:
>> Bj=F6rn Steinbrink wrote:
>>> On 2009.08.13 14:46:07 +0200, Michael Haggerty wrote:
>>> And even for just continously forward porting a series of commits, =
a
>>> common case might be that upstream applied some patches, but not al=
l.
>>> Can you deal with that?

[A discussion of various unsatisfactory approaches omitted...]

> But that's obviously total crap.

So I think we agree that it is not possible to retain history for a cas=
e
like this (which is essentially a general cherry-pick).

> [...]
> Doing a plain "git rebase subsystem topic" would of course also try t=
o
> rebase the "o" commits, so that problematic. Instead, you do:
>=20
> git rebase --onto subsystem O topic
>=20
> That turns O..topic (the * commits) into patches, and applies them on
> top of O'. So the "o" commits aren't to be rebased.
>=20
> And that's exactly what your rebase-with-history would do as well. Ju=
st
> that O is naturally a common ancestor of subsystem and topic, and so
> just using "git rebase-w-h subsystem topic" would be enough. Conflict=
s
> etc. should be 100% the same.
>=20
> If you know that your upstream is going to rebase/rewrite history, yo=
u
> can tag (or otherwise mark) the current branching point of your branc=
h,
> so you can easily specify it for the --onto rebase. IOW: This is
> primarily a social problem (tell your downstream that you rebase this=
 or
> that branch), but having built-in support to store the branching poin=
t
> for rebasing _might_ be worth a thought.

Recording branch points manually, coordinating merges via email -- OMG
you are giving me flashbacks of CVS ;-)

*Of course* you can get around all of these problems if you put the
burden of bookkeeping on the user.  The whole point of
rebase-with-history is to have the VCS handle it automatically!

>> and merging in a topic branch makes it more difficult to create an
>> easily-reviewable patch series.  rebase-with-history has neither of
>> these problems.
>=20
> Sure, merging is a no-go if you submit patches by email (or other,
> similar means). But you compared that to an "enhanced" rebase approac=
h,
> instead of comparing your rebase approach to the currently available
> one.

In [1] I compared rebase-with-history with both of the
currently-available options (rebase and merge).  Rebase and merge can
each deal with some of the issues that come up, but each one falls flat
on others.  I believe that rebase-with-history has the advantages of bo=
th.

The example in [2] was taken straight from the git-rebase man page [3];
I did not want to claim that current practice would use merging in this
situation, but rather just to show that rebase-with-history removes the
pain from this well-known example.

I think we are mostly in agreement.  Rebase-with-history is obviously
not an earth-shattering revolution in DVCS technology, but my hope is
that it could unobtrusively assist with a few minor pain points.

Michael

[1]
http://softwareswirl.blogspot.com/2009/04/truce-in-merge-vs-rebase-war.=
html
[2]
http://softwareswirl.blogspot.com/2009/08/upstream-rebase-just-works-if=
-history.html
[3] http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html
