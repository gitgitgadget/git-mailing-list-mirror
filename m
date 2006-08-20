From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Helper function to shell quote all arg values at once.
Date: Sun, 20 Aug 2006 15:57:11 -0700
Message-ID: <7vsljrxbg8.fsf@assigned-by-dhcp.cox.net>
References: <20060820080749.e31276dd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 00:57:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEwEF-0003WC-Tu
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 00:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWHTW5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 18:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWHTW5N
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 18:57:13 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:20665 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751776AbWHTW5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 18:57:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060820225712.JYJL18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Aug 2006 18:57:12 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060820080749.e31276dd.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 20 Aug 2006 08:07:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25770>

Christian Couder <chriscool@tuxfamily.org> writes:

> The new sq_quote_argv function is used to refactor the
> tracing code in "git.c" and "exec_cmd.c".
> This function allocates memory and fills it with a string
> containing the quoted argument values. Then it returns a
> pointer to this memory that must be freed afterwards.

Sorry, I do not see a point in this.

If your original were doing malloc-print-free per iteration,
then perhaps it makes sense to first format all into one
allocated buffer, print all, and then free at once, like this
patch does.  But that was not what the original had.

If the new function were to get a (const char **) array and
FILE *, and print them, quoted and separated with spaces, then
it would have shortened what two call sites did, which would
have been an improvement.  But that is not what this patch does,
either.
