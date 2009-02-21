From: Heiko Voigt <git-list@hvoigt.net>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow
 to pre-commit
Date: Sat, 21 Feb 2009 14:31:01 +0100
Message-ID: <49A00215.9070106@hvoigt.net>
References: <499EF2B6.7060103@hvoigt.net> <C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com> <499FDDC2.90502@hvoigt.net> <200902211216.43964.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 21 14:32:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lary8-0002Zn-2U
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 14:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbZBUNbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 08:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZBUNbG
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 08:31:06 -0500
Received: from darksea.de ([83.133.111.250]:46864 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751629AbZBUNbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 08:31:05 -0500
Received: (qmail 5837 invoked from network); 21 Feb 2009 14:30:53 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 21 Feb 2009 14:30:53 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <200902211216.43964.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110953>

Thomas Rast schrieb:
> Heiko Voigt wrote:
>> This leads me to a completely different solution to the same problem.
>> How about teaching git to inherit its hooks from the parental project
>> (e.g. the one it was cloned from)? That way we are not limited to
>> one default behaviour but many that would match the one from the
>> upstream project.
> [...]
>> What do you think about that?
> 
> Three words: huge security hole.
> 
> Especially on cloning, where the checkout immediately afterwards
> would already run the post-checkout hook, without any chance for the
> user to inspect its contents.

Good point here as well. 

> The usual advice is to track the hooks in the repository, e.g., under
> hooks/, and instruct the users to copy them to .git/hooks/ if they
> want them.

I read about that possibility but it does not completely satisfy me,
because a new user to a project can not just 

   git clone url/to/somewhere

and start working.

How about combining my first approach with the second idea? Teach git
different default sets of hooks. So something like:

   git init --workflow="topic-branches"

would initialize and install a certain set of hooks.

Implement the possibility to propagate this setting to the server, by
using a config variable or similar. This way only secure hooks will
automatically be inherited and the user has the benefit of a more
specific workflow support.

cheers Heiko
