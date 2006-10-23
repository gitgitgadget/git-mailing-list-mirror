From: Junio C Hamano <junkio@cox.net>
Subject: Re: prune/prune-packed
Date: Sun, 22 Oct 2006 20:27:49 -0700
Message-ID: <7vvembzp6y.fsf@assigned-by-dhcp.cox.net>
References: <20061022035919.GA4420@fieldses.org>
	<7vy7r954k7.fsf@assigned-by-dhcp.cox.net>
	<20061022231422.GA9375@fieldses.org>
	<20061023005336.GA12932@fieldses.org> <453C1A35.70504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 05:28:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbqTl-0005I6-EG
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 05:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWJWD1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 23:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWJWD1v
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 23:27:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54736 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751359AbWJWD1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 23:27:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061023032750.KYQI12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Oct 2006 23:27:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dfTZ1V00h1kojtg0000000
	Sun, 22 Oct 2006 23:27:34 -0400
To: gitzilla@gmail.com
In-Reply-To: <453C1A35.70504@gmail.com> (A. Large Angry's message of "Sun, 22
	Oct 2006 18:26:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29813>

A Large Angry SCM <gitzilla@gmail.com> writes:

> J. Bruce Fields wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>>> I am considering the following to address irritation some people
>>> (including me, actually) are experiencing with this change when
>>> viewing a small (or no) diff.  Any objections?
>>
>> So for me, if I run
>>
>> 	less -FRS file
>>
>> where "file" is less than a page, I see nothing happen whatsoever.
>>
>> At a guess, maybe it's clearing the screen, displaying the file, the
>> restoring, all before I see anything happen?
>
> Junio,
>
> How about reverting this change? From the reports here, is causing
> problems on a number of different distributions.

Hmmm.  I thought I was using gnome-terminal as well, but I
always work in screen and did not see this problem.

Sorry, but you are right and Linus is more right.  How about
doing FRSX.

diff --git a/pager.c b/pager.c
index 8bd33a1..4587fbb 100644
--- a/pager.c
+++ b/pager.c
@@ -50,7 +50,7 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	setenv("LESS", "FRS", 0);
+	setenv("LESS", "FRSX", 0);
 	run_pager(pager);
 	die("unable to execute pager '%s'", pager);
 	exit(255);
