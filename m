From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-branch: be prepared for ref-logging
Date: Sat, 03 Feb 2007 10:55:20 -0800
Message-ID: <7vzm7v5aw7.fsf@assigned-by-dhcp.cox.net>
References: <11705213662728-git-send-email-tutufan@gmail.com>
	<11705266492308-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Coleman <tutufan@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 19:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDQ2s-0006nk-NU
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 19:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXBCSzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 13:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXBCSzW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 13:55:22 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:38905 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751065AbXBCSzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 13:55:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203185520.FQUE1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 13:55:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K6vL1W00d1kojtg0000000; Sat, 03 Feb 2007 13:55:21 -0500
In-Reply-To: <11705266492308-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Sat, 3 Feb 2007 19:17:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38586>

Lars Hjemli <hjemli@gmail.com> writes:

> The test for reflog parameter to create_branch() should also have tested
> for log_all_ref_updates. But there is no good reason not to prepare a
> reflog message, so lets just do it.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> If log_all_ref_updates==1 then the reflog will get an empty message with 
> your patch. That is better than using an uninitialized message, but I think
> it's still better to just prepare a proper message.

True, but don't you still need to set log_all_ref_updates while
you call write_ref_sha1() for that ref in order to make sure
that log_ref_write() sets O_CREAT in oflags?
