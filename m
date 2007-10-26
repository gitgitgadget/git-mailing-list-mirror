From: Andreas Ericsson <ae@op5.se>
Subject: Re: Trouble with case-insensitive filesystems
Date: Fri, 26 Oct 2007 17:22:52 +0200
Message-ID: <4722064C.1000201@op5.se>
References: <20071026145204.GA294@localhost.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlR2E-0008AT-K8
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 17:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbXJZPW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 11:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbXJZPW7
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 11:22:59 -0400
Received: from mail.op5.se ([193.201.96.20]:34271 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247AbXJZPW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 11:22:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E9EFC17306F3
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 17:22:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EgzA7jsTgYYK for <git@vger.kernel.org>;
	Fri, 26 Oct 2007 17:22:08 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 9D01017306E6
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 17:22:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071026145204.GA294@localhost.daprodeges.fqdn.th-h.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62416>

Rocco Rutte wrote:
> Hi,
> 
> after importing the opensolaris hg repo into git, I noticed that git 
> gets confused if the repo contains files that clash on case-insensitive 
> filesystems (here on OS X, I can't test Cygwin and Win32). git-checkout 
> tells me that these files are modified, git-status gives me:
> 
> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HB
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HB.name
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HI
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HI.name
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HX
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HX.name
> #       modified:   
> usr/src/cmd/lp/filter/postscript/font/devpost/charlib/LH
> #       modified:   usr/src/lib/libldap4/common/Version.c
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> ...without touching anything. Yes, there's a version.c file next to 
> Version.c, HI.name next to Hi.name and so on.
> 
> I'm not really sure what I'm expecting git to do, but I guess I want it 
> to abort a checkout and only continue with -f. But at the very least, it 
> should issue a big fat warning (one may decide to work in some area 
> without clashes).
> 
> I really have no idea how to efficiently detect that at runtime and 
> which areas of git to look at for patching...
> 

There are no areas in git to patch. There's no sane way to handle your
case, so the best you could opt for is to import it to a system with
sane case-handling, alter the repo so no two filenames clash, and then
check it out on your case-insensitive filesystem. Note that you'll
have to make sure that you never check anything out prior to the
commit that renames the case-name clashes, or you'll end up with this
same trouble all over again.

On a side note; Please don't set the Reply-To: header for mails to
git@vger.kernel.org. Some consider it rude, and it makes the ones
you're asking for help have to work if they want to provide you
with anything off-list. It's a tad rude.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
