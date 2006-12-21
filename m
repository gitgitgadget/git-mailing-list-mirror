From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Thu, 21 Dec 2006 00:49:48 -0800
Message-ID: <7v7iwleiqb.fsf@assigned-by-dhcp.cox.net>
References: <200612200901.30584.andyparkins@gmail.com>
	<7vslfae4uv.fsf@assigned-by-dhcp.cox.net>
	<200612210839.35980.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 09:49:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJce-0007eC-K9
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422868AbWLUItu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 03:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbWLUItu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:49:50 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39366 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422868AbWLUItt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 03:49:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221084948.DUFZ25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 03:49:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Lp61W00B1kojtg0000000; Thu, 21 Dec 2006 03:49:07 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200612210839.35980.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 21 Dec 2006 08:39:34 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35032>

Andy Parkins <andyparkins@gmail.com> writes:

>> As you fix them and enhance the support, I suspect you would
>> want a separate command to manage .gitmodule file and submodules
>> referenced by it.  I think it would be better to keep the patch
>> to the template to the minimum (for example, run "git submodule
>> update" if there is .gitmodules file at the toplevel), and
>> implement the body of the processing in "git-submodule.sh", or
>> something like that.
>
> That's an interesting idea.  I was thinking that git-commit
> itself would have been the final target; but I certainly don't
> have any problem with a separate command.

I do not think the commit command would be the "final" one.

When you have a loosely coupled subproject, sometimes you might
want to check out subprojects recursively, so you would also
want "checkout" action to "git submodule", which might hook into
"git checkout" just like your patch hooked into "git commit".
Similarly your future versions certainly would want to hook into
"git fetch/pull".

Just like some peoples' workflow avoid "git pull" but do "git
fetch" and "git merge" as separate steps, some people may want
to disable the above "hooks", and prefer using "git submodule"
from the command line as a separate step, especially if they
want very loose coupling.
