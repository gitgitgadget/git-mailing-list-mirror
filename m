From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 13:47:36 -0500
Message-ID: <1197571656.28742.13.camel@hinata.boston.redhat.com>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	 <20071213090604.GA12398@artemis.madism.org>
	 <20071213091055.GA5674@coredump.intra.peff.net>
	 <20071213093536.GC12398@artemis.madism.org>
	 <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	 <20071213180347.GE1224@artemis.madism.org>
	 <1197570521.28742.0.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:59:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2tGt-0002gu-0j
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 19:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759138AbXLMS6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 13:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758772AbXLMS6f
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 13:58:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54455 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758543AbXLMS6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 13:58:34 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBDIljB5007274;
	Thu, 13 Dec 2007 13:47:45 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBDIlj7W021045;
	Thu, 13 Dec 2007 13:47:45 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBDIlflj024010;
	Thu, 13 Dec 2007 13:47:42 -0500
In-Reply-To: <1197570521.28742.0.camel@hinata.boston.redhat.com>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68184>

On Thu, 2007-12-13 at 13:28 -0500, Kristian H=C3=B8gsberg wrote:
> On Thu, 2007-12-13 at 19:03 +0100, Pierre Habouzit wrote:
> > On Thu, Dec 13, 2007 at 05:40:23PM +0000, Junio C Hamano wrote:
> > > Pierre Habouzit <madcoder@debian.org> writes:
> > >=20
> > > > In fact we have kind of the issue for every single optional arg=
ument out
> > > > there:
> > > >
> > > > $ git describe --abbrev HEAD
> > > > error: option `abbrev' expects a numerical value
> > > > [...]
> > > >
> > > >   *ouch*
> > > >
> > > > So I believe that with optional arguments we must change the wa=
y we do
> > > > things, and that we _must_ enforce the argument to be sticked i=
n that
> > > > case.
> > >=20
> > > I think "Must" is a bit too strong an expression.
> > >=20
> > > 	git describe --abbrev 7 HEAD
> > >         git describe --abbrev HEAD
> > >         git describe --abbrev=3DHEAD
> > > 	git describe --abbrev=3D7 HEAD
> > > 	git describe --abbrev
> > >=20
> > > The --abbrev parser in this case could be asked with this questio=
n: "You
> > > are on the command line.  There is a token after you.  Is it your
> > > parameter?".
> >=20
> >   I thought of that, but it's really convoluted and can definitely =
lead
> > to very subtle issues. The number of git commands with optional
> > arguments is quite low, mostly due to legacy, I don't expect _new_
> > commands to take optional arguments. I don't really like the ambigu=
ity
> > it creates, and in some cases you just won't be able to disambiguat=
e at
> > all. Here it looks nice because --abbrev takes an integer argument,=
 and
> > it's likely that no branch nor reference names will be only made of
> > digits. Though for commands taking an optional string[0] argument t=
his is
> > way more fishy.
>=20
> My=20

Oops, sorry about that.  I just wanted to say we shouldn't jump through
all these hoops to make the option parser support every type of option
there ever was in the git command line ui.  A lot of these were probabl=
y
decided somewhat arbitrarily by whoever implemented the command.
Instead it's an opportunity to retroactively enforce some consistency
and predictability to the various option-styles that have been
hand-rolled over time in different git commands.

Kristian
