From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 7/11] Avoid git-fetch in `git-pull .` when possible.
Date: Thu, 28 Dec 2006 01:35:03 -0800
Message-ID: <7vac18wego.fsf@assigned-by-dhcp.cox.net>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
	<20061228073517.GG17867@spearce.org>
	<7v8xgsxx1r.fsf@assigned-by-dhcp.cox.net>
	<20061228081701.GA18029@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 10:35:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrfJ-0004kx-Tq
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbWL1JfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWL1JfF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:35:05 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50632 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827AbWL1JfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:35:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228093503.PDWT15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 04:35:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 49bH1W0081kojtg0000000; Thu, 28 Dec 2006 04:35:17 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061228081701.GA18029@spearce.org> (Shawn Pearce's message of
	"Thu, 28 Dec 2006 03:17:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35552>

Shawn Pearce <spearce@spearce.org> writes:

>> I personally think this is not an improvement, but rather a new
>> source of confusion.  If the user wants a local merge, there is
>> 'git-merge'.  And the distinction between the commands makes it
>> clear that local merge can merge any commits exactly because
>> they are available locally, while remote fetch+merge needs to
>> choose from what the remote side offers so not arbitrary commits
>> like foo@{3.days.ago} cannot be pulled.
>
> True.  But you know you are doing a local merge with `git pull .`.
> So why should you be restricted from using the capabilities of a
> local merge just because the frontend you prefer to use is limited
> when its doing remote merges?

Personally I do not mind much about it because I happen to
understand what "git pull" is doing.

But I do mind having to spend time defending why we special case
only the dot form, when people with twisted minds start
complaining about inconsistencies among "git pull .git", "git
pull ." and "git pull $(pwd)".  And no, I do not want to
introduce likes of "test `cd .git && pwd` == `cd $1 && pwd`" in
the code to make them behave consistently.
