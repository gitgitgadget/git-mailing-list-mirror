From: Jeff King <peff@peff.net>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Fri, 19 Nov 2010 16:15:33 -0500
Message-ID: <20101119211533.GA18942@sigill.intra.peff.net>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101113095140.GH8911@home.lan>
 <AANLkTin+3FuuX_pavZQMrbi4qxjTRvM7nHk1PXcFbeiZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 22:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJYJ4-0006hl-9M
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 22:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab0KSVPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 16:15:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43224 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab0KSVPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 16:15:36 -0500
Received: (qmail 28644 invoked by uid 111); 19 Nov 2010 21:15:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 21:15:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 16:15:33 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin+3FuuX_pavZQMrbi4qxjTRvM7nHk1PXcFbeiZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161786>

On Tue, Nov 16, 2010 at 09:29:46PM -0500, Martin von Zweigbergk wrote:

> > What about simply checking if "rev-parse @{u}" succeeds, in which c=
ase
> > we can use upstream_name=3D@{u} ? =C2=A0If it fails, then we can do=
 the work
> > of finding where the config flaw is (and delegate this to a func).
> > That would help keep the nominal code path short.
>=20
> Will make sure to find out the error only when needed as you suggest.
>=20
> I thought I would need the ref name to be able to walk the reflog if =
my
> other propasal would be accepted (see
> http://thread.gmane.org/gmane.comp.version-control.git/161381), but i=
t
> seems to work with @{u} as well. I just adapted the call from 'git pu=
ll'
> (git-parse-remote.sh), but I guess I could use 'git rev-parse @{upstr=
eam}'
> instead. It does seem more natural to me.
>=20
> Maybe one of the guys on the CC list can advise?

I'm not quite sure I understand the question, coming into the middle of
the conversation. If you want to know "can I traverse the reflog of the
upstream with @{u}", the answer is yes. We dereference the ref first
(similarly, foo@{u}@{3.days.ago} looks at the upstream branch's reflog)=
=2E
If you want the refname, you can also use "git rev-parse
--symbolic-full-name @{u}".

Does that help?

-Peff
