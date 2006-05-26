From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch possible regressions
Date: Thu, 25 May 2006 23:16:42 -0700
Message-ID: <7v4pzdqpit.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
	<7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7wpr97n.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605260125420.16816@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550605252309h2c4b74bcp50b095e09e6c133f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 08:16:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjVct-0004Av-RA
	for gcvg-git@gmane.org; Fri, 26 May 2006 08:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWEZGQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 02:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWEZGQp
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 02:16:45 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12215 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030454AbWEZGQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 02:16:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060526061643.DCQY27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 May 2006 02:16:43 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550605252309h2c4b74bcp50b095e09e6c133f@mail.gmail.com>
	(Marco Costalba's message of "Fri, 26 May 2006 08:09:12 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20798>

"Marco Costalba" <mcostalba@gmail.com> writes:

> I was thinking, probably wrong, that the number prepended in file name
> is used also to disambiguate two patches with the same subject.

What Johannes and I were discussing was the other number -- the
total in the series.  IOW, y in "[PATCH x/y]".  OTOH, the number
used for disambiguation you care about is x, which is made
adjustable with --start-number patch.

So the way for qgit to use it would become something like this.
Instead of giving a list of ranges like "a..b c..d e..f":

 * Run "format-patch a..b"; by reading from its stdout you know
   what patches you got -- you count them.

 * Run "format-patch --start-number=6 c..d" (if you got 5 out of
   a..b);

 * Run "format-patch --start-number=n e..f" (now you know the drill).

Then the sequence out of c..d would start with a file 0006-xxxx.txt,
which is what you want for disambiguation.
