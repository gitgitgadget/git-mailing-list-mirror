From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Munge ChangeLog-style commit messages, and grab author name and email.
Date: Fri, 10 Feb 2006 21:39:16 -0800
Message-ID: <7v3biqpi7v.fsf@assigned-by-dhcp.cox.net>
References: <87slqqvgj2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 06:39:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7nTo-0007o5-B3
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 06:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWBKFjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 00:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBKFjS
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 00:39:18 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49039 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750984AbWBKFjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 00:39:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211053623.JFGL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 00:36:23 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87slqqvgj2.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	10 Feb 2006 17:19:13 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15928>

Carl Worth <cworth@cworth.org> writes:

> The cairo project has been using ChangeLog-style commit messages, such as:
>
> 	2006-01-18  Carl Worth  <cworth@cworth.org>
>
> 		* src/cairo-pdf-surface.c: (cairo_pdf_surface_create_for_stream),
> 		(cairo_pdf_surface_create): Fix compilation-breaking typo.
>
> This patch recognizes that style and munges it up into:
>
> 	Fix compilation-breaking typo.
>
> which results in a much more useful headline within git.

I welcome discussion on this patch, but as its in current shape,
it looks a bit too specific to one particular style.

I think the one you quoted above is the GNU official style which
is used in many projects.  I suspect your patch would help
people converting other projects as well.  Having said that, as
you said it yourself, it would make more sense to make a more
generalized log munging interface.

Even though there might be many different schools of style,
hopefully each project consistently sticks to one style.  Log
messages out of SVN repository tend to have their own styles.
We could define a common command line option, say --log-filter,
that are available across importers.  E.g.

	git-cvsimport --log-filter=gnu-log-style
	git-svnimport --log-filter=gnu-log-style

'gnu-log-style' would be the massager you have hardcoded in the
patch, but made into a traditional UNIXy filter.  We could
create contrib/commit-filters directory in git.git repository
and ship collections of such log massagers.
