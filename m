From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 2/3] Add -y/--no-prompt option to mergetool
Date: Sat, 15 Nov 2008 10:50:48 -0500
Message-ID: <20081115155048.GC22948@mit.edu>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	William Pursell <bill.pursell@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 16:52:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1NRU-0003g9-0g
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 16:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYKOPu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 10:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYKOPu5
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 10:50:57 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:46647 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751447AbYKOPu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 10:50:56 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1L1NQB-0005rx-Hd; Sat, 15 Nov 2008 10:50:51 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1L1NQ8-0008G4-QS; Sat, 15 Nov 2008 10:50:48 -0500
Content-Disposition: inline
In-Reply-To: <1226580075-29289-3-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101074>

On Thu, Nov 13, 2008 at 12:41:14PM +0000, Charles Bailey wrote:
> This option lets git mergetool invoke the conflict resolution program
> without waiting for a user prompt each time.
> 
> Also added a mergetool.prompt (default true) configuration variable
> controlling the same behaviour

My apologies for not commeting earlier on your patches; I've been a
bit overloaded as of late --- way too much conference travel!  :-(

I can see why this should perhaps be the default for gui-based merge
program.  The one place where it should perhaps not be the default is if
the tool could be text based (i.e., if you are using text-based emacs
to do the emerge).   So perhaps what we should do is 

1) Make the question of whether or not a particular back-end merge
program should require the user to hit return first to be configured
on a per-gui tool basis.

2) For all of the gui tools default the answer to be to _not_ prompt
first.

3) For the emacs-based merge, make the default be based on whether or
not $DISPLAY is set.  (But allow an overide based on
mergetool.emerge.prompt.)

I think this much more accurately would model what users want, and if
we get the default right for most users, that's definitely a win.

Regards,

							- Ted
