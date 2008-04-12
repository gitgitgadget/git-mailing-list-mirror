From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable
	and world-readable
Date: Sat, 12 Apr 2008 11:17:23 +0200
Message-ID: <20080412091723.GB20443@atjola.homenet>
References: <20080411140916.GA30667@zakalwe.fi> <7vfxtrnban.fsf@gitster.siamese.dyndns.org> <20080412030021.GB31039@zakalwe.fi> <7vzlrzlluj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 11:18:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkbsu-0001TA-C8
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 11:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbYDLJSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 05:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756287AbYDLJSL
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 05:18:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:50896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756266AbYDLJSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 05:18:10 -0400
Received: (qmail invoked by alias); 12 Apr 2008 09:18:07 -0000
Received: from i577B8E52.versanet.de (EHLO atjola.local) [87.123.142.82]
  by mail.gmx.net (mp030) with SMTP; 12 Apr 2008 11:18:07 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+yJMBsunmyGAoEqYxKsDU5lPamwTZKSWRmJ0zWVS
	r4xmonYNXCzGhh
Content-Disposition: inline
In-Reply-To: <7vzlrzlluj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79339>

On 2008.04.11 21:48:36 -0700, Junio C Hamano wrote:
> Heikki Orsila <shdl@zakalwe.fi> writes:
>=20
> > On Fri, Apr 11, 2008 at 05:53:36PM -0700, Junio C Hamano wrote:
> > ...
> >> For example, you may want to enforce "ug+rw,o=3D" in a repository.=
  How
> >> would you do that?
> >
> > Isn't that PERM_GROUP? The user always keeps u+rw for oneself.
>=20
> My question was about the "o=3D" part.  I did not see you dropping bi=
ts for
> others in your patch.
>=20
> And if your answer is "the user should have xx7 umask", that defeats =
the
> whole point of your patch, as you are trying to dissociate the umask =
used
> by the user for his usual task and enforce particular permission poli=
cy
> for the repository.

I don't think it defeats the purpose of the patch. Currently, I guess
that for most users (umask like 0022 or 0077), both shared and all mean
that the umask is overriden in a way that grants more permissions on th=
e
repository. As it is, we only support that in a way that grants write
permissions to the group, while others may get read-only access (via
"all"). From that point of view, I think that the patch is a natural
enhancement, allowing to override the umask in a way that only grants
additional read permissions for either the group, or the group and
others. And that's exactly what Heikki was after.

Of course, having a "ignore the umask, use those permissions" setting
might be nice, but short of that, the patch makes sense to me.

Bj=F6rn
