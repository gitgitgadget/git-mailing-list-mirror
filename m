From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git string manipulation functions wrong?
Date: Mon, 21 May 2007 16:36:16 +0200
Message-ID: <20070521143616.GG4489@pasky.or.cz>
References: <20070521131103.GN8200@gateway.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Mouw <mouw@nl.linux.org>
X-From: git-owner@vger.kernel.org Mon May 21 16:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq8zr-0000RV-GO
	for gcvg-git@gmane.org; Mon, 21 May 2007 16:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbXEUOgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756589AbXEUOgT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 10:36:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40247 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756429AbXEUOgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 10:36:18 -0400
Received: (qmail 16011 invoked by uid 2001); 21 May 2007 16:36:16 +0200
Content-Disposition: inline
In-Reply-To: <20070521131103.GN8200@gateway.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48020>

On Mon, May 21, 2007 at 03:11:03PM CEST, Erik Mouw wrote:
> Hi,
> 
> I got this forwarded from a friend who is subscribed to the Dovecot
> mailing lists (dovecot is a pop3/imap server).
> 
>   http://www.dovecot.org/list/dovecot/2007-May/022853.html
>   http://www.dovecot.org/list/dovecot/2007-May/022856.html
> 
> The Dovecot author claims there are "basic string manipulation errors"
> in the git code and that's a reason for him not to use git.
> 
> I can see his problem with *snprintf() functions in the case where the
> amount of output is larger than the buffer size: *snprintf() will
> return the number of characters written if there would have been enough
> space to write them, which will lead to problems with code like "len +=
> snprintf(buf, max, bla, ...)". I don't see his problems with strncpy(),
> though.

It's the opposite for me - we don't properly set the NUL byte for smoe
of our strncpy() calls, but I don't really see his problem with
snprintf(), we seem to handle its return value correctly everywhere
(except diff.c, but there the buffer sizes should be designed in such a
way that an overflow should be impossible).

-- 
				Petr "Pasky the Sleepy" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
