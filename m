From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Site dependent repositories
Date: Sun, 21 Aug 2011 18:14:30 +0200
Message-ID: <4E512EE6.60900@web.de>
References: <4E507C05.2090700@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stewart A. Brown" <sabrown256@sbcglobal.net>, git@vger.kernel.org
To: sabrown256@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 21 18:14:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvAfY-0006s7-Sy
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 18:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab1HUQOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 12:14:36 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:37218 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab1HUQOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 12:14:35 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2C85A1A8ED34F;
	Sun, 21 Aug 2011 18:14:34 +0200 (CEST)
Received: from [79.247.242.104] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QvAfR-00088V-00; Sun, 21 Aug 2011 18:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <4E507C05.2090700@sbcglobal.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+QahLiXG+r0IWSc/MrMu31pn2kHAxuovRz4keX
	icXDo+5GzOFd1Z+COeajickwCGW/Gj0p68Km7m64l4rhozn5Wy
	yWTXC/LWWDnEbhPUO3uw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179805>

Am 21.08.2011 05:31, schrieb Stewart A. Brown:
> I am wondering whether or not git has the functionality to handle
> my situation.
> 
> I have git repositories at multiple sites.  At each site the git repository
> has site dependent sources.  Each repository is organised something
> like:
> 
> top/a/local
>       b
>       c/d/extensions
>       e
> 
> The directories top, a, b, c, d, and e have sources that need to be
> pushed or pulled between the repositories at all sites.  The directories
> 'local' and 'extensions' have sources that must be managed within sites
> but never pushed or pulled between sites.
> 
> The ignore mechanism will not suffice because the files in 'local' and
> 'extensions' must be source managed.  I have looked a bit into
> submodules, filters, and hooks.  None of these jumps out as obvious, but
> they are rich mechanisms with plenty of subtleties.
> 
> Does git have a way of letting me do this?

It would work if you could set it up like this:

top/shared
    non-shared-stuff

where "top" is your git repository, "shared" is a submodule you put all the
non-site specific stuff in and have that version controlled together with
your local stuff. If you can't rearrange your directory tree you might be
able to use symlinks to achieve that layout:

top/a/local -> ../local
      b
      c/d/extensions -> ../../extensions
      e
top/extension
top/local

where "a" is your shared submodule that lives together with "extensions" and
"local" in the top level repo.
