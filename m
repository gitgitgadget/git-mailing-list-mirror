From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Add some basic pserver tests
Date: Sun, 13 May 2007 11:38:36 -0700
Message-ID: <7vzm48sh5f.fsf@assigned-by-dhcp.cox.net>
References: <1179078566806-git-send-email-frank@lichtenheld.de>
	<11790785662928-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun May 13 20:39:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIyH-0000Yq-4Q
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807AbXEMSii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 14:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757658AbXEMSii
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:38:38 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35016 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392AbXEMSih (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 14:38:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513183837.FSZO1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 14:38:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yiec1W00J1kojtg0000000; Sun, 13 May 2007 14:38:36 -0400
In-Reply-To: <11790785662928-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Sun, 13 May 2007 19:49:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47164>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> While we can easily test the cvs <-> git-cvsserver
> communication with :fork: and git-cvsserver server
> there are some pserver specifics we should test, too.
>
> Currently this are two tests of the pserver authentication.
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
>...
> +test_expect_success 'authentication' \
> +  'cat <<EOF | git-cvsserver pserver >log 2>&1 &&
> +BEGIN AUTH REQUEST
> +$SERVERDIR
> +anonymous
> +
> +END AUTH REQUEST
> +EOF
> +   tail -n1 log | grep -q "^I LOVE YOU$"'

In the past, some people with non-bash shells had trouble with
here text (i.e. <<HERE) inside our test scripts Either our use
of eval to run the test in test_expect_success is not kosher, or
their implementation of eval was slightly broken --- I do not
recall if we ever dug down to the bottom of the problem.  That
is why most tests have here-text to prepare test vectors outside
of tests themselves.
