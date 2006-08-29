From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add local time and timezone to git_print_authorship
Date: Tue, 29 Aug 2006 02:05:23 -0700
Message-ID: <7vu03voqss.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
	<11567998513000-git-send-email-jnareb@gmail.com>
	<7vveocpfa3.fsf@assigned-by-dhcp.cox.net> <ed0ths$okn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 11:05:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHzWV-0001PH-Tq
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 11:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWH2JEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 05:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWH2JEk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 05:04:40 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:57774 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751337AbWH2JEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 05:04:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060829090439.SSLK29796.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 Aug 2006 05:04:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id Fl4f1V0074Noztg0000000
	Tue, 29 Aug 2006 05:04:39 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26193>

Jakub Narebski <jnareb@gmail.com> writes:

> Could you use full hex color length? Everywhere else in CSS we use 
> 6-char wide hex colours.

Will do for consistency's sake, although I do not think we
really care about the extra precision in this application.

> We have age_class subroutine which does something similar.

Yeah, but...

 (1) When somebody says "there are three age classes: age0,
     age1, and age2", can you tell which one represents older
     ones?  I think they are misnamed.

 (2) The classification of age_class seems to be useful for the
     project age, which is to check if anything happened in the
     last two hours and last two days.  Unless the project is
     really dead/dormant it should not be more than a month.  On
     the other hand, a mature and stable project should have
     more than 80% lines that are more than a year old, even if
     it is very active and have many lines that are less than
     two hours old.

     The yardstick age_class uses is really geared toward
     checking project's last activity and not appropriate for
     use in blame.  Luckily, blame2 does not use it.

 (3) I'd like to eventually get rid of the abbreviated commit
     object name from blame output, so the setting in gitweb.css
     for table.blame td.age[012] (different colors and font
     styles) is not appropriate for what I am shooting at.

I have a bit updated 3-series for review.
