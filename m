From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-clone: add --track <headname> support
Date: Thu, 12 Apr 2007 03:23:15 -0700
Message-ID: <7vk5whki24.fsf@assigned-by-dhcp.cox.net>
References: <1176372539871-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Apr 12 12:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbwSW-0000U2-IM
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 12:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992450AbXDLKXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 06:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992452AbXDLKXR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 06:23:17 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35043 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992450AbXDLKXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 06:23:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412102316.TTTA1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 06:23:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mAPF1W0071kojtg0000000; Thu, 12 Apr 2007 06:23:15 -0400
In-Reply-To: <1176372539871-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Thu, 12 Apr 2007 22:08:59 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44334>

Martin Langhoff <martin@catalyst.net.nz> writes:

> Add support for a simplified workflow where users
> want to clone and start working on a head that is
> different from the HEAD of the repository.
>
> Calling
>
>    git-clone --track maint <repo>
>
> Is equivalent to
>
>    git-clone <repo> mydir
>    cd mydir
>    git-checkout --track -b maint origin/maint
>
> --
>
> Not sure if Junio wants this, but if I am going to migrate
> away from cogito, I'd like these common operations to be
> dead simple. 

I am not interested in moving people away from cogito ;-).

With the talk about making more things built-in, I think the
changes to clone and fetch should be done by first rewriting
git-clone as a very thin shell wrapper that essentially does:

	figure out the directory name to use
        mkdir that directory and cd into it
        run git init with appropriate options
        run git remote add with appropriate options
        run git fetch with appropriate options
        run git checkout with appropriate options (unless -n)

Also you might want to check "branch.autosetupmerge" config.  It
seems to be described in git-branch manual page without being
listed in Documentation/config.txt, which is a bad that happend
some time ago X-<.

It seems that today has been a day to discover many bads that
happened some time ago for me X-<.  I should quit and call it a
day now...
