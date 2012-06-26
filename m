From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: Jobs and skipSubmitEdit
Date: Tue, 26 Jun 2012 07:21:15 -0400
Message-ID: <20120626112115.GA3439@padd.com>
References: <CAFLRbop2aETNp0-6AdvSTx7Jmh7epYZ6rQc6hhFHbxZrGdEo9g@mail.gmail.com>
 <20120624202445.GA27664@padd.com>
 <CAFLRbootAje0BvLOYiH2xOagfUsQ+a_d+9YeTuG1C0a1Pg__Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <mike@horowitz.name>
X-From: git-owner@vger.kernel.org Tue Jun 26 13:21:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjTpn-0006to-OI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 13:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab2FZLVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 07:21:20 -0400
Received: from honk.padd.com ([74.3.171.149]:43923 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab2FZLVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 07:21:19 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 85E341E43;
	Tue, 26 Jun 2012 04:21:18 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 90FE231383; Tue, 26 Jun 2012 07:21:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAFLRbootAje0BvLOYiH2xOagfUsQ+a_d+9YeTuG1C0a1Pg__Rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200639>

mike@horowitz.name wrote on Tue, 26 Jun 2012 01:07 -0400:
> Well, "Jobs:" is the only thing I use.  Everything else is filled in
> automatically by git-p4.
>=20
> Yeah, so "Jobs:" appears once on a line by itself, and then multiple
> lines tabbed in of whatever the Job ids are, in our case they are JIR=
A
> issue numbers.  So, it might look like:
>=20
> Jobs:
>     PROJECTNAME-123
>     PROJECTNAME-456
>=20
> I think that if someone is using git-p4 and they have "Jobs:" at the
> beginning of a line by itself in a git commit message, then it is saf=
e
> to stop pre-pending tabs to the lines from there on.  It can also be
> an option to turn this behavior on.

I agree that it is simpler to explain if Jobs: must come last.
=46or the option, I'd prefer not to add another one, and instead
hope that it's unlikely to find such a construct in a commit
message that does not want this feature to happen.

I coded it up already, but with a couple little differences.
Once I get a couple more of the series on which it depends mailed
out, I'll send it along for you to play with.

		-- Pete

> On Sun, Jun 24, 2012 at 4:24 PM, Pete Wyckoff <pw@padd.com> wrote:
> > mike@horowitz.name wrote on Fri, 22 Jun 2012 12:15 -0400:
> >> I've written a git prepare-commit-msg hook to do what the Perforce
> >> JobsView would essentially do, so I can include the jobs directly =
in
> >> my git commit message, and then use git-p4.skipSubmitEdit=3Dtrue, =
so I
> >> can just push things into Perforce directly from git without ever
> >> being prompted by Perforce.
> >>
> >> Problem is that this doesn't work, because git-p4 tabs in the enti=
re
> >> commit message to put it in the "Description:" section of the Perf=
orce
> >> changelist, and my "Jobs:" ends up tabbed in, and it it required b=
y
> >> Perforce to be at the beginning of the line. =A0The submit ends up
> >> failing, because "Jobs:" is required. =A0I am forced to turn off
> >> skipSubmitEdit and edit the message to remove the tab from the "Jo=
bs:"
> >> line each commit.
> >>
> >> Is there any option to make this work right, or does the git-p4 no=
t
> >> support this?
> >
> > This is a great idea, and something I've thought would be useful
> > too. =A0There's no code to handle it currently, but it shouldn't be
> > too hard.
> >
> > I'm imagining that special strings in the git commit are hoisted
> > up out of the description when building the p4 change message,
> > as you describe. =A0Are there any more than "Jobs:"? =A0Is it just
> > a single instance that might appear?
> >
> > An easy way to do this is to change prepareLogMessage to alter
> > or add a Jobs line. =A0Unless we decide this needs to be more
> > general.
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Pete
>=20
