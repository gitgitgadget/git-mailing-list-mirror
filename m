From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH(amend)] Really run "git-clean -n" in test
Date: Sun, 06 May 2007 12:18:44 -0700
Message-ID: <7vlkg1bw17.fsf@assigned-by-dhcp.cox.net>
References: <463E19C4.8010601@uwaterloo.ca> <463E27BC.5060604@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Spang <mspang@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun May 06 21:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkmFt-00083Q-Qd
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbXEFTSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755133AbXEFTSq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:18:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42982 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122AbXEFTSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 15:18:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506191845.GUOH1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 6 May 2007 15:18:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id vvJk1W0091kojtg0000000; Sun, 06 May 2007 15:18:44 -0400
In-Reply-To: <463E27BC.5060604@uwaterloo.ca> (Michael Spang's message of "Sun,
	06 May 2007 15:08:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46365>

Michael Spang <mspang@uwaterloo.ca> writes:

> Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
> ---
>
> Whoops.
>
>  t/t7300-clean.sh |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

Oops indeed.

* This is not an "amend"; you are following up an earlier patch of
  your own.  Marking such a patch as "amend" is only confusing.
  Please do not do it.

>  test_expect_failure \
>      'clean.requireForce' \
> -    "mkdir -p build docs &&
> -    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> -    git-config clean.requireForce true &&
> +    "git-config clean.requireForce true &&
>      git-clean"

* Please do not do this.  test_expect_failure, unless used for a
  very simple single test, is almost always a bug.  You would
  not know which step of && chain failed, even though you may be
  expecting the failure from the last one.

* I do not think a "this reformats every existing tests" patch
  is needed nor wanted, but at least I'd like to see new scripts
  and updates to the existing ones to be consistently formatted
  like this:

	test_expect_success 'name of the test' '

		test body goes here &&
                like this &&
		and this

	'
