From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-base: update the clean-up postprocessing
Date: Wed, 05 Jul 2006 00:51:08 -0700
Message-ID: <7vejx0cwwj.fsf@assigned-by-dhcp.cox.net>
References: <44AB0948.9070606@gmail.com>
	<7vy7v8dctz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 09:51:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy2AV-0003aq-5A
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 09:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWGEHvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 03:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWGEHvK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 03:51:10 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55689 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932172AbWGEHvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 03:51:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060705075108.FSCB12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Jul 2006 03:51:08 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <7vy7v8dctz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 04 Jul 2006 19:07:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23339>

A fixed up version of this patch, along with your updated test,
is at the tip of "pu".

It does affect the processing time for cases where there are
more than one merge bases negatively.  To compute all merge-base
for the 23 merges in the kernel reporitory, the old code with
the "contaminate the well a bit more" clean-up phase takes 2.5
seconds, while the new code takes 3.9 seconds.

Processing all 2215 merges in the kernel repository (the other
2192 merges have one merge-base between the parents) takes 160
seconds either way.  In other words, multi merge-base merges are
relatively rare and a bit more time spent to clean-up with the
new code is lost in the noise.

The numbers are taken from /usr/bin/time on an Athron 64X2 3800.
