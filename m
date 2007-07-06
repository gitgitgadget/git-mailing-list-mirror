From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Fri, 06 Jul 2007 01:33:02 -0700
Message-ID: <7vir8yextt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site>
	<20070705135824.GB5493@sigill.intra.peff.net>
	<Pine.LNX.4.64.0707051636240.9789@racer.site>
	<468DE9F3.B4489CDE@eudaptics.com> <863b02j6qs.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:33:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6jFW-0004Uu-VO
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 10:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbXGFIdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 04:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbXGFIdG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 04:33:06 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61902 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbXGFIdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 04:33:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706083303.XTUG1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Jul 2007 04:33:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L8Z21X0091kojtg0000000; Fri, 06 Jul 2007 04:33:03 -0400
In-Reply-To: <863b02j6qs.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Fri, 06 Jul 2007 10:06:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51732>

David Kastrup <dak@gnu.org> writes:

> Instead of "grep ." one could also do something like
>
> if read line then
>   while echo "$line" && read line; do :; done
>   die
> fi
>
> which is fork-less.

I'd agree with you that "grep ^" would be preferable _if_ we
were to do this.  But in your fork-less example, you are
assuming that (1) "read" does not molest what is read, (2)
"echo" is built-in, and (3) "echo" does not munge the
parameter.

Since I am one of old fashioned shell people (I readily admit
that I used to have _fun_ with autoconf generated shell
scripts), I'd love to continue shell skill show-offs, but for
the purpose of updating this script, I would say a temporary
file is much better than any of the alternatives around 1>&3.
For one thing, it would make debugging the script while
developing and tweaking it, _and_ while using it, much more
pleasant.
