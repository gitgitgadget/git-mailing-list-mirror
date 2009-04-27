From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Mon, 27 Apr 2009 02:00:07 +0200
Message-ID: <20090427000007.GE12338@atjola.homenet>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <alpine.LNX.2.00.0904241911590.2147@iabervon.org> <b4087cc50904241629u76454b1chc6e84e95066a9100@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyEIu-0004SW-QS
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 02:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbZD0AAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 20:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZD0AAW
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 20:00:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:57042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750920AbZD0AAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 20:00:21 -0400
Received: (qmail invoked by alias); 27 Apr 2009 00:00:20 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp021) with SMTP; 27 Apr 2009 02:00:20 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/S3nJJg3nSvsSWnoTTTgnuDpucRPTE9wqPpWnRkR
	2l7jgBS1KvthkE
Content-Disposition: inline
In-Reply-To: <b4087cc50904241629u76454b1chc6e84e95066a9100@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117607>

On 2009.04.24 18:29:22 -0500, Michael Witten wrote:
> On Fri, Apr 24, 2009 at 18:21, Daniel Barkalow <barkalow@iabervon.org=
> wrote:
> > "git blame 1a2b3c:Makefile" worked despite this technically being
> > incoherent.
>=20
> It seems to work on my end, and it's perfectly coherent if you
> consider git-blame to be overloaded to handle both pointers and
> addresses (or references and object names, if you prefer).

=46ails for me. And it's technically incoherent in that it makes no sen=
se
to use blame with a blob object. 1a2b3c:Makefile identifies "just" a
blob object. And that has no parents and no history, just contents. Onl=
y
the commit objects have the references that connect them to form a
history.

=46or example, you could have a history like this:

A---B---C---D---E

And a file "foo" that has the same contents for A and E. Then "A:foo"
and "E:foo" lead to the same blob object, and you can't uniquely go fro=
m
that blob object to any commit object. So technically, you can't tell i=
f
"git blame E:foo" means "git blame E foo" or "git blame A foo" (and you
can add a bunch of complexity by having, for example, a second file
with a different name that had the same content at some point).

To make that coherent, you must change the definition of the
<tree-ish>:<path> syntax so that the context in which the path is
resolved is kept, it must no longer just identify an object, but
something more complex.

Bj=F6rn
