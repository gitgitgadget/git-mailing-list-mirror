From: Jeff King <peff@peff.net>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 06:06:09 -0400
Message-ID: <20070730100609.GB8829@coredump.intra.peff.net>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr> <863az6uscz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 12:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFS8l-0005M3-JV
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbXG3KGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbXG3KGM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:06:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1424 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbXG3KGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:06:11 -0400
Received: (qmail 12241 invoked from network); 30 Jul 2007 10:06:12 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jul 2007 10:06:12 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2007 06:06:09 -0400
Content-Disposition: inline
In-Reply-To: <863az6uscz.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54218>

On Mon, Jul 30, 2007 at 11:57:00AM +0200, David Kastrup wrote:

> > This looks like an incorrect installation, with git-stash in your
> > $PATH, but not in the place git looks for its commands (I don't
> > remember the exact mechanism).
> 
> I don't think so: in git.c we have at lines 362ff
> 
>                 { "show-branch", cmd_show_branch, RUN_SETUP },
>                 { "show", cmd_show, RUN_SETUP | USE_PAGER },
>                 { "stripspace", cmd_stripspace },
>                 { "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
> 
> So it really seems like stash is not known to git.c.  Of course, I
> have no real clue about git.c's operation (or I'd have proferred a
> patch) and not right now the time to look further.

That list is for builtins; git-stash is an external shell script. See
execv_git_cmd for the list of places where it is looking for git-stash.

Since I seem to recall you working some symlink magic with your
installation in a recent message, that might be related. Is it just
git-stash, or are other scripts failing (try "git status")?

-Peff
