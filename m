From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Use POSIX/Susv command substitution instead of backticks
Date: Tue, 05 Feb 2008 16:59:06 -0800
Message-ID: <7vhcgm7vdx.fsf@gitster.siamese.dyndns.org>
References: <lk5zxdix.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802052226340.8543@racer.site>
	<abmfxbg3.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802052305080.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYeX-0007xw-Qa
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbYBFA7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760682AbYBFA7b
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:59:31 -0500
Received: from rune.pobox.com ([208.210.124.79]:42698 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774AbYBFA7a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:59:30 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id DBE78193DBF;
	Tue,  5 Feb 2008 19:59:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D761193D8D;
	Tue,  5 Feb 2008 19:59:45 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802052305080.8543@racer.site> (Johannes
	Schindelin's message of "Tue, 5 Feb 2008 23:06:48 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72737>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And then you have to do it for all scripts in one go.  Mind you, it is not 
> really complicated: just one call to perl.

Please do not do this.  If other people have pending changes,
"cleanup for clean-up's sake" would create conflicts for no good
reason.

There are only two cases such a clean-up patch is good:

 (1) When the maintainer is not yet accepting any patches after
     a release-freeze and there is no pending patches from the
     community, and/or if you can convince people with pending
     patches to rebase on top of the clean-up because the
     current codebase is so unmaintainably bad, then a
     whole-tree clean-up patch should go in before anything
     else, forcing everybody to rebase on top of it;

 (2) If you will be working on the code in an area, you may want
     to have the first one in the series a "pure clean-up and
     nothing else" of the whole area, and then build your real
     changes on top.  You still need to coordinate with people
     whose patches may get hit by your clean-ups, but you have
     to do this anyway because you will have conflicts from your
     "real changes".

Any other "clean-up patch" would result in a not-so-appreciated
code churn.  Please don't encourage it.
