From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] perl bindings fix compilation errors
Date: Mon, 25 Sep 2006 21:54:04 -0700
Message-ID: <7vfyeftehf.fsf@assigned-by-dhcp.cox.net>
References: <20060925100319.GA1655@shadowen.org>
	<Pine.LNX.4.63.0609251223590.25371@wbgn013.biozentrum.uni-wuerzburg.de>
	<4517BEBC.4000002@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 06:54:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4xP-0004hA-RU
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWIZEyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWIZEyI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:54:08 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34449 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750784AbWIZEyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:54:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926045405.BBWP21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:54:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ssu21V00d1kojtg0000000
	Tue, 26 Sep 2006 00:54:03 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4517BEBC.4000002@shadowen.org> (Andy Whitcroft's message of
	"Mon, 25 Sep 2006 12:34:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27771>

Andy Whitcroft <apw@shadowen.org> writes:

> I am somewhat unhappy that a make clean at the top level and remake was
> not sufficient to get a working tree.

Sympathetic I am (since I was bitten by it too), but I am not
sure what the right thing to do.

It is certainly incorrect to say that it is a driver error to
git-pull (or git-checkout to switch branches) without running
"make clean" first to get rid of perl/Git.c while your Makefile
still knows it is a generated file.  Our Makefile should be more
helpful.

But the question is Makefile in which branch?

Ideally, if Makefile of each and every branch head currently
alive knew that perl/Git.c is problematic and removed it, then
we would not suffer from this problem.  But it's obviously not
practical.
