From: Jeff King <peff@peff.net>
Subject: Re: FW: Git log --graph doesn't output color when redirected
Date: Thu, 13 Dec 2012 08:13:29 -0500
Message-ID: <20121213131329.GA5042@sigill.intra.peff.net>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Srb, Michal" <michal.srb11@imperial.ac.uk>
X-From: git-owner@vger.kernel.org Thu Dec 13 14:13:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj8bk-0001qe-SO
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 14:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab2LMNNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2012 08:13:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48587 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294Ab2LMNNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 08:13:31 -0500
Received: (qmail 3913 invoked by uid 107); 13 Dec 2012 13:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Dec 2012 08:14:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2012 08:13:29 -0500
Content-Disposition: inline
In-Reply-To: <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211452>

On Wed, Dec 12, 2012 at 05:35:17PM +0000, Srb, Michal wrote:

> Unlike --pretty-format, --graph doesn=E2=80=99t output colors when th=
e git log output
> is redirected.

I do not think it has anything to do with --graph in particular, but
rather that when colorization is set to the "auto" mode, it is enabled
only when stdout is a tty. Diff coloring, for example, follows the same
rules.  If you are using --format=3D"%C(red)" or similar placeholders,
they are the odd duck by not respecting the auto-color mode.

> Is there a setting somewhere in config to change this?

Yes. If you use "--color" on the command line, that means
"unconditionally use color". If you set color.ui (or any other color
config option) to "always", then you will always get color (and you can
disable it for a particular run with "--no-color"). Setting a color
config option to "true" is the same as "auto", which gets you the auto
mode.

-Peff
