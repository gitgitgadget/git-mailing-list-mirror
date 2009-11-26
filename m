From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Fri, 27 Nov 2009 00:37:49 +0100
Message-ID: <20091126233749.GA26228@atjola.homenet>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
 <7vd4355aaw.fsf@alter.siamese.dyndns.org>
 <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
 <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 00:38:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDnuT-0005er-4g
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 00:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZKZXht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 18:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbZKZXht
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 18:37:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:32928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753364AbZKZXhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 18:37:48 -0500
Received: (qmail invoked by alias); 26 Nov 2009 23:37:53 -0000
Received: from i59F5699E.versanet.de (EHLO atjola.homenet) [89.245.105.158]
  by mail.gmx.net (mp020) with SMTP; 27 Nov 2009 00:37:53 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/v2XIlJOLvvbIb5tTKhnbSLBsDKV3+otMTnP4flc
	JOOCgID6IdU+5T
Content-Disposition: inline
In-Reply-To: <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133849>

On 2009.11.26 15:11:27 -0800, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > On Thu, Nov 26, 2009 at 9:57 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
> >> I actually have a bigger question, though. =A0Does it even make se=
nse to
> >> allow pathspecs to format-patch? =A0We sure are currently loose an=
d take
> >> them, but I doubt it is by design.
> >
> > Not everyone has clean branches only with pertinent patches.
> >
> > I stumbled upon this trying to re-create (cleanly) a "branch" that =
was
> > constantly merged into another "master" branch that had a lot more
> > stuff. Maybe there was a smarter way to do that with 'git rebase', =
but
> > that doesn't mean format-patch -- <path> shouldn't work.
> >
> >> The patch itself looks good and is a candidate 'maint' material, i=
f the
> >> answer to the above question is a convincing "yes, because ...".
> >
> > Yeah, I also think this should go into 'maint'.
>=20
> Hmm, I have not seen a clear "yes, because..." yet.
>=20
> For one thing, Documentation/git-format-patch.txt does not even hint =
that
> you can give pathspecs.  builtin_format_patch_usage[] doesn't, either=
=2E  As
> I wrote the initial version of format-patch I can say with some autho=
rity
> that use with pathspecs were never meant to be supported---if it work=
s, it
> works by accident, giving long enough rope to users to potentially ca=
use
> themselves harm.
>=20
> I am inclined to think that we shouldn't encourage use of pathspecs (=
just
> like we never encouraged use of options like --name-only that never m=
akes
> sense in the context of the command) but I am undecided if we also sh=
ould
> forbid the use of pathspecs (just like we did for --name-only recentl=
y).

A year ago, there was someone who had done a subtree merge and had
commits that changed the subtree in the "supertree" branch. He wanted t=
o
generate patches to send them to upstream, and ended up using
format-patch with --relative and pathspecs.

http://thread.gmane.org/gmane.comp.version-control.git/101742

I guess this could be done by some "git rebase -s subtree ..."
invocation though, to first get commits that sit directly on the subtre=
e
branch, and then you could turn them into patches as usual... Hmm..

Bj=F6rn
