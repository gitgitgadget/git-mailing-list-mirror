From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 02:54:19 -0700
Message-ID: <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 11:54:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGXNw-0008NO-Gz
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 11:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbXHBJyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 05:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbXHBJyV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 05:54:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59608 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbXHBJyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 05:54:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802095420.UZSY26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 05:54:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WxuK1X0051kojtg0000000; Thu, 02 Aug 2007 05:54:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54532>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I understand that it can be usefull, but I really don't like having it
> by default (is there a way to deactivate it BTW?):

You said it yourself below --- run git-status (or update-index --refresh)
first.

> I've hit this while working on a project, doing a lot of modifications
> through scripting (some regexp substitutions and such kinds of
> things).

I have to say that you are quite mistaken.

Scripted style bulk modification that indiscriminately touch
everbody but actually only modifies some, e.g. "perl -p -i", is
a fine component of people's workflow, but that is *NOT* the
norm.  If it were, then you are not programming nor editing --
your script is doing the work.  But as you know, after such a
bulk operation, you can always...

> ... until I run git-status again.

... refresh away the cache-dirtiness.

The default should be tuned for users who perform manual editing
with status checks.  And power users like yourself who run "bulk
touch indiscriminately but modify only some" scripts should
learn to run git-status (or "update-index --refresh") after such
operation.  Swapping the defaults to optimize for the abnormal
case is madness.
