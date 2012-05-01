From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log-tree: use custom line terminator in line termination
 mode
Date: Tue, 1 May 2012 04:56:49 -0400
Message-ID: <20120501085649.GD4998@sigill.intra.peff.net>
References: <86ty01qez7.fsf@red.stonehenge.com>
 <1335811555-23564-1-git-send-email-jk@jk.gs>
 <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 10:57:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP8tH-0004wI-30
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 10:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab2EAI4y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 04:56:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52831
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703Ab2EAI4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 04:56:54 -0400
Received: (qmail 2030 invoked by uid 107); 1 May 2012 08:57:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 04:57:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 04:56:49 -0400
Content-Disposition: inline
In-Reply-To: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196673>

On Mon, Apr 30, 2012 at 12:36:07PM -0700, Junio C Hamano wrote:

> Jan Kr=C3=BCger <jk@jk.gs> writes:
>=20
> > When using a custom format in line termination mode (as opposed to =
line
> > separation mode), the configured line terminator is not used, so th=
ings
> > like "git log --pretty=3Dtformat:%H -z" do not work properly.
> >
> > Make it use the line terminator the user ordered.
> >
> > Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> > ---
> >  log-tree.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/log-tree.c b/log-tree.c
> > index 34c49e7..44f0268 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -682,7 +682,7 @@ void show_log(struct rev_info *opt)
> >  	if (opt->use_terminator) {
> >  		if (!opt->missing_newline)
> >  			graph_show_padding(opt->graph);
> > -		putchar('\n');
> > +		putchar(opt->diffopt.line_termination);
> >  	}
> > =20
> >  	strbuf_release(&msgbuf);
>=20
> Looks sensible.  Perhaps we would want to add a test?

Hmm. This came up before, and the issue is (or can be) slightly more
complex:

  http://thread.gmane.org/gmane.comp.version-control.git/122478/focus=3D=
122568

-Peff
