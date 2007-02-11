From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sat, 10 Feb 2007 19:13:46 -0500
Message-ID: <20070211001346.GA19656@thunk.org>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu> <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu> <20070210181357.GE25607@thunk.org> <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 11 01:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG2Ls-0006kL-SR
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 01:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbXBKANy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 19:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbXBKANx
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 19:13:53 -0500
Received: from THUNK.ORG ([69.25.196.29]:35408 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbXBKANx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 19:13:53 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HG2Qs-0003ck-BU; Sat, 10 Feb 2007 19:19:06 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HG2Li-0008RC-78; Sat, 10 Feb 2007 19:13:46 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39265>

On Sat, Feb 10, 2007 at 09:34:38PM +0100, Johannes Schindelin wrote:
> > +		if (alias_string[0] == '!') {
> > +			trace_printf("trace: alias to shell cmd: %s => %s\n",
> > +				     alias_command, alias_string+1);
> 
> Here, you add 1 to alias string (though I would put spaces around the 
> plus, but that's really a nit).

That's not how I code but it does seem to be the prevailing git coding
style, so I'll change it.

> > +			die("Failed to run '%s' when expanding alias '%s'\n", 
> > +			    alias_string, alias_command);
> 
> So, shouldn't you here, too?

Yes, that makes the error message look a bit nicer.  I'll respin the
patch.

> It made me feel a little uneasy that we can execute _any_ command now, but 
> I can only find one way to exploit this, when an attacker does not have 
> shell access anyway: git-shell.

... and git-shell only allows git-receive-pack and git-upload-pack to
be called, with a single argument, and aliases aren't allowed to
override commands.  So we're safe here, I think.

						- Ted
