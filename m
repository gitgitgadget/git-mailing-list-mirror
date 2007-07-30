From: Jeff King <peff@peff.net>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 07:03:55 -0400
Message-ID: <20070730110354.GA11676@coredump.intra.peff.net>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr> <863az6uscz.fsf@lola.quinscape.zz> <20070730100609.GB8829@coredump.intra.peff.net> <86lkcytci4.fsf@lola.quinscape.zz> <20070730103720.GA11309@coredump.intra.peff.net> <86bqdutb7r.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 13:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFT2s-00041q-Vg
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 13:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733AbXG3LD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 07:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757483AbXG3LD5
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 07:03:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3261 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757608AbXG3LD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 07:03:57 -0400
Received: (qmail 13081 invoked from network); 30 Jul 2007 11:03:57 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jul 2007 11:03:57 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2007 07:03:55 -0400
Content-Disposition: inline
In-Reply-To: <86bqdutb7r.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54225>

On Mon, Jul 30, 2007 at 12:52:40PM +0200, David Kastrup wrote:

> How does it calculate its exec path?  It would appear that it would
> not contain _either_ /usr/local/bin _or_ /opt/git/bin in my
> installation if it can't find git-stash (which should be statable in
> both places).

See exec_cmd.c:execv_git_cmd. It checks in order:
  1. --exec-path= on command line
  2. $GIT_EXEC_PATH from environment
  3. GIT_EXEC_PATH defined at compile-time (set by Makefile from
      $(gitexecdir), which is generally the same as $(bindir))

So it should have /opt/git/bin in your case, but it's possible since
that is a Makefile variable that you failed to recompile correctly after
changing its value.

> Have a command handy for checking the exec path?

git --exec-path

-Peff
