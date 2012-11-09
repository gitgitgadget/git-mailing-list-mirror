From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Fri, 9 Nov 2012 19:27:53 +0100
Message-ID: <20121109182753.GQ69724@acme.spoerlein.net>
References: <20121109133132.GK69724@acme.spoerlein.net>
 <m2y5iarf5s.fsf@igel.home>
 <20121109154245.GP69724@acme.spoerlein.net>
 <vpq390idb8v.fsf@grenoble-inp.fr>
 <20121109161647.GB19725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtJX-0004ih-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab2KIS2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 13:28:10 -0500
Received: from acme.spoerlein.net ([88.198.49.12]:60601 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab2KIS2I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:28:08 -0500
Received: from localhost (acme.spoerlein.net [IPv6:2a01:4f8:131:23c2::1])
	by acme.spoerlein.net (8.14.5/8.14.5) with ESMTP id qA9IRrIg015787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 9 Nov 2012 19:27:53 +0100 (CET)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1352485674;
	bh=6s7zCZcixdKWZKxIHizhkvwm44xP9Tbar/8vNLmVP+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rp847+UzYmNyjXUGVEos/XoMBMX9G5BOZNHJ2oDVq21D+z/emhxmGT7vF/z+3sg1a
	 efpdpscAH2wtHFEOpEebiX+FFdMJEoFevta3nEuEFWD918wBodFwy5buc3qShqPF6R
	 LVCzMD3sELv9Oq1s7Ok4av180U/DAE8S1ZChzrYc=
Content-Disposition: inline
In-Reply-To: <20121109161647.GB19725@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209233>

On Fri, 2012-11-09 at 11:16:47 -0500, Jeff King wrote:
> On Fri, Nov 09, 2012 at 04:52:48PM +0100, Matthieu Moy wrote:
>=20
> > Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:
> >=20
> > >> > 2. Why the hell is the commit hash dependent on the ordering o=
f the
> > >> > parent commits? IMHO it should sort the set of parents before
> > >> > calculating the hash ...
> > >>=20
> > >> What would be the sort key?
> > >
> > > Trivially, the hash of the parents itself. So you'd always get
> > >
> > > ...
> > > parent 0000
> > > parent 1111
> > > parent aaaa
> > > parent ffff
> >=20
> > That would change the behavior of --first-parent. Or you'd need to
> > compute the sha1 of the sorted list, but keep the unsorted one in t=
he
> > commit. Possible, but weird ;-).
>=20
> Right. The reason that merge parents are stored in the order given on
> the command line is not random or because it was not considered. It
> encodes a valuable piece of information: did the user merge "foo" int=
o
> "bar", or did they merge "bar" into "foo"?
>=20
> So I think this discussion is going in the wrong direction; git shoul=
d
> never sort the parents, because the order is meaningful. The original
> complaint was that a run of svn2git produced different results on two
> different git versions. The important question to me is: did svn2git
> feed the parents to git in the same order?
>=20
> If it did, and git produced different results, then that is a serious
> bug.
>=20
> If it did not, then the issue needs to be resolved in svn2git (which
> _may_ want to sort the parents that it feeds to git, but it would dep=
end
> on whether the order it is currently presenting is meaningful).

Yeah, thanks, looks like I have some more work to do. I don't quite get
how it could come up with a different order, seeing that it is using sv=
n
as the base.

Will run some more experiments, thanks for the info so far.

Cheers,
Uli
