From: Jeff King <peff@peff.net>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Wed, 23 Jan 2013 15:02:22 -0500
Message-ID: <20130123200222.GB19832@sigill.intra.peff.net>
References: <20130123143816.GA579@krypton.darkbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Armin <netzverweigerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6X0-0007Jh-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab3AWUC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:02:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45200 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028Ab3AWUCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:02:24 -0500
Received: (qmail 6085 invoked by uid 107); 23 Jan 2013 20:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 15:03:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 15:02:22 -0500
Content-Disposition: inline
In-Reply-To: <20130123143816.GA579@krypton.darkbyte.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214355>

On Wed, Jan 23, 2013 at 03:38:16PM +0100, Armin wrote:

> Hello dear git people.
> 
> I experience a reproducible segmentation fault on one of my
> repositories when doing a "git log --submodule -p", tested with newest
> version on Arch Linux (git version 1.8.1.1) and built fresh (git
> version 1.8.1.1.347.g9591fcc), tried on 2 seperate systems:
> 
> 
> Program terminated with signal 11, Segmentation fault.
> #0  0x00000000004b51e5 in parse_commit_header (context=0x7ffff69b6980) at pretty.c:752
> 752     for (i = 0; msg[i]; i++) {
> [...]
> (gdb) l
> 747 static void parse_commit_header(struct format_commit_context *context)
> 748 {
> 749     const char *msg = context->message;
> 750     int i;
> 751 
> 752     for (i = 0; msg[i]; i++) {
> 753         int eol;
> 754         for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
> 755             ; /* do nothing */
> 756 
> (gdb) p msg
> $7 = <optimized out>
> (gdb) p context->message
> $8 = 0x0

Yeah, that should definitely not be NULL. I can't reproduce here with a
few simple examples, though.

Does it fail with older versions of git? If so, can you bisect?

Is it possible for you to make your repo available?

-Peff
