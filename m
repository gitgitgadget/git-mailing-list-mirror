From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix tests when using bash_completion
Date: Mon, 23 Apr 2007 14:56:27 -0700
Message-ID: <7vvefmdab8.fsf@assigned-by-dhcp.cox.net>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org>
	<7vvefmeqs6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704232235280.7626@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ron Parker <ron.parker@mobot.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg6WO-0002c9-Hg
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 23:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbXDWV43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 17:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbXDWV43
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 17:56:29 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38791 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbXDWV43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 17:56:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423215630.PWJI1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 17:56:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qlwT1W00m1kojtg0000000; Mon, 23 Apr 2007 17:56:28 -0400
In-Reply-To: <Pine.LNX.4.64.0704232235280.7626@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Mon, 23 Apr 2007 22:39:20 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45368>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> (I'm not the only one who thinks CDPATH is ick am I? :S)

CDPATH is Ok as long as it stays as an interactive shell
variable.

Sadly, if you google for "CDPATH environment", you would see
many many hits.  That variable is not meant to be used as an
environment variable.

Something like this in .bashrc is acceptable:

	case "$PS1" in
        '')
        	;; # do not do useless thing for noninteractive
	?*)
        	CDPATH=my:favorite:path
                . $HOME/.bash-completion
		;;
	esac

but people usually are way too careless than that and export
CDPATH to the environment, and that is where breakages start.
