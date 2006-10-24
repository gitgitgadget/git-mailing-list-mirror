From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-send-email: do not pass custom Date: header
Date: Mon, 23 Oct 2006 23:46:48 -0700
Message-ID: <7vr6wyqkh3.fsf@assigned-by-dhcp.cox.net>
References: <11615895973387-git-send-email-normalperson@yhbt.net>
	<ehhv6g$4js$1@sea.gmane.org> <20061023093824.GB8749@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:47:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcG3t-0003iA-Dj
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbWJXGqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbWJXGqu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:46:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34234 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1752099AbWJXGqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 02:46:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024064649.KJSQ18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Oct 2006 02:46:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id e6ms1V00h1kojtg0000000
	Tue, 24 Oct 2006 02:46:53 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29936>

Eric Wong <normalperson@yhbt.net> writes:

> Jakub Narebski <jnareb@gmail.com> wrote:
>> Eric Wong wrote:
>> 
>> > We already generate a Date: header based on when the patch was
>> > emailed. ?git-format-patch includes the Date: header of the
>> > patch. ?Having two Date: headers is just confusing, so we
>> > just use the current Date:
>> > 
>> > Often the mailed patches in a patch series are created over a
>> > series of several hours or days, so the Date: header from the
>> > original commit is incorrect for email, and often far off enough
>> > for spam filters to complain.
>> 
>> But that makes us lose original commit date. And git format-patch
>> is if I remember correctly together with git-am used in git-rebase.
>
> This patch is for git-send-email, and only affects the way they
> are sent over SMTP.  Output of git-format-patch is unchanged.

An alternative to satisfy both (Jakub wants original author date
propagated to the recipient of the e-mail who will run "git-am"
to apply the patch; you do not want to throw potentially ancient
author date as the e-mail's Date: to SMTP layer) is to use
sending date in e-mail header (like your patch does) _and_ leave
the Date: header for the original author date as the first line
of the e-mail message, separated with the real body of the message
with a blank line.
