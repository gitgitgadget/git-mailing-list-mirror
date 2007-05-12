From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t9400: Use the repository config and nothing else.
Date: Sat, 12 May 2007 10:21:15 -0700
Message-ID: <7vhcqi2c1g.fsf@assigned-by-dhcp.cox.net>
References: <7v8xbvj5mx.fsf@arte.twinsun.com>
	<20070512162819.GA7184@planck.djpig.de>
	<7vabwa3swp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat May 12 19:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmvHo-0003Em-4g
	for gcvg-git@gmane.org; Sat, 12 May 2007 19:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409AbXELRVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 13:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757052AbXELRVS
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 13:21:18 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44193 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042AbXELRVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 13:21:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512172115.SRTO1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 13:21:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yHMF1W0091kojtg0000000; Sat, 12 May 2007 13:21:15 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47066>

Junio C Hamano <junkio@cox.net> writes:

> Frank Lichtenheld <frank@lichtenheld.de> writes:
>
>> On Fri, May 11, 2007 at 04:35:18PM -0700, Junio Hamano wrote:
>>> This needs to be fixed, but thanks to that bug, a separate bug
>>> in t9400 test script was discovered.  The test discarded
>>> GIT_CONFIG instead of pointing at the proper one to be used in
>>> the exoprted repository.  This allowed user's .gitconfig and (if
>>> exists) systemwide /etc/gitconfig to affect the outcome of the
>>> test, which is a big no-no.
>>
>> Shouldn't you also remove the "unset GIT_CONFIG" then?
>
> I didn't test the side of the test that works on the git side,
> but I think you are right.

Actually that is not sufficient, as unsetting means using the
value set in test-lib.sh suitable for usual single-repository
tests.

When you prepare gitcvs.enabled config in the cloned gitcvs.git
repository, you do not want to have GIT_CONFIG=.git/config in
the environment.  As you give GIT_DIR to these two commands, not
having GIT_CONFIG would make them do the right thing.
