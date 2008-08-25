From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH] Fix start_command() pipe bug when stdin is closed.
Date: Mon, 25 Aug 2008 08:56:57 -0700
Message-ID: <quack.20080825T0856.lth63ppulyu@roar.cs.berkeley.edu>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
	<48B28CF8.2060306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 17:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXeSd-0003Su-4d
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 17:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYHYP5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbYHYP5F
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 11:57:05 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:47076 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbYHYP5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 11:57:04 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 325B434401; Mon, 25 Aug 2008 08:56:57 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <48B28CF8.2060306@viscovery.net> (Johannes Sixt's message of "Mon\, 25 Aug 2008 12\:44\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93637>

>>>>> On 2008-08-25 03:44 PDT, Johannes Sixt writes:

    Johannes> When I try these instructions I don't get an error;
    Johannes> instead the command runs successfully.

Weird.  I see the symptom on two machines, both 1.5.6 and tracking
master.  The 1.5.6 system installation could be interfering even
though I used PATH=/path/to/git:$PATH.

    Johannes> While I do see that there is a problem, it is only
    Johannes> half of the story, and your patch addresses only
    Johannes> this half.

    Johannes> What if stdout is closed, too? Then the ends of the
    Johannes> first allocated pipe would go to fds 0 and 1, and
    Johannes> then the pipe end at 1 would be closed by a
    Johannes> subsequent dup2(xxx, 1).

My patch was intended to fix the problem for any renaming where
fd_from==fd_to, including target stdout.  I didn't say so in the
changelog though.
