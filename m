From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:33:22 -0500
Message-ID: <20130211043322.GA12735@sigill.intra.peff.net>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4l5P-0002lI-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab3BKEdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:33:24 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43971 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044Ab3BKEdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:33:24 -0500
Received: (qmail 18184 invoked by uid 107); 11 Feb 2013 04:34:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Feb 2013 23:34:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2013 23:33:22 -0500
Content-Disposition: inline
In-Reply-To: <20130211042609.GC15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215989>

On Sun, Feb 10, 2013 at 08:26:09PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Sun, Feb 10, 2013 at 08:14:04PM -0800, Jonathan Nieder wrote:
> 
> >> Only interactive connections.  That's the existing behavior.
> >
> > Ah, sorry. I misread the patch. I see now that we already run help, and
> > this is just making the exit value significant. In that case, yeah, I
> > think it's fine.
> 
> No problem --- the description was unclear.  Would retitling the patch
> to "shell: pay attention to exit status from 'help' command" work?

I think what threw me off was reading the documentation part of the
patch, which adds a note that we run "help" on startup, and then
elaborates on the exit value. I didn't realize that the first half was
documenting what already happened.

Tweaking the third paragraph of the commit message to:

  An appropriate greeting might even include more complex information,
  like a list of repositories the user has access to.  If the
  git-shell-commands directory exists and contains a "help" script, we
  already run it when the shell is run without any commands, giving the
  server a chance to provide a custom message. Unfortunately, the
  presence of the git-shell-commands directory means we also enter an
  interactive mode, prompting and accepting commands (of which there may
  be none) from the user, which many servers would not want. To solve
  this, we abort the interactive shell on a non-zero exit code from the
  "help" script. This lets the server say whatever it likes, and then
  hangup.

makes it more clear to me. But once you explained it, I realize that I
also could have just read the C code part of the patch more carefully. :)

So I'm fine with or without that change.

-Peff
