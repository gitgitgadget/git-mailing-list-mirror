From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add --aggressive option to 'git gc'
Date: Wed, 9 May 2007 18:22:21 -0400
Message-ID: <20070509222221.GA10322@thunk.org>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org> <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <20070509194839.GB10280@thunk.org> <7v4pmlu4ut.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 00:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HluYV-0002DK-C7
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXEIWWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbXEIWWi
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:22:38 -0400
Received: from thunk.org ([69.25.196.29]:55002 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbXEIWWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:22:37 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Hluf8-0003Nz-Iu; Wed, 09 May 2007 18:29:34 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HluYA-0003C6-34; Wed, 09 May 2007 18:22:22 -0400
Content-Disposition: inline
In-Reply-To: <7v4pmlu4ut.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46801>

On Wed, May 09, 2007 at 01:19:54PM -0700, Junio C Hamano wrote:
> It's tricky that it defaults to 10 and still called aggressive.
> When the configuration variable is left unspecified, the only
> reason it is called aggressive is because it passes '-f' to
> repack, right?  It was not very clear at the first sight and I
> was about to ask why the default is 10, not higher.

Yes, it's called aggressive because it causes git-gc to recalculate
the delta's.  So that means that git-gc --aggressive will take around
9-10 times longer than git-gc.  If the user changes
gc.aggressive-window to some larger value, say like 30, then git-gc
--aggressive would take around 20 times longer than git-gc.

So that's why I didn't make the default bigger, but instead left it as
something which could be configured by the user.  Maybe the default
should be larger; I don't strong opposition towards making it be more
like 30, but it seemed to me that doubling the run time for a 5%
decrease in pack size wasn't worth it.

Regards,

					- Ted
