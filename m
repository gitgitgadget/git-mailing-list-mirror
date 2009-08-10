From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Implementing $Date$ substitution - problem with git status
Date: Mon, 10 Aug 2009 05:41:01 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908100535150.17908@ds9.cixit.se>
References: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se> <200908092252.58363.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 06:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaMhK-0002jS-QM
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 06:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbZHJElG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbZHJElG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 00:41:06 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:44573 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750814AbZHJElF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 00:41:05 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7A4f1Rk018182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Aug 2009 06:41:01 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7A4f1S9018178;
	Mon, 10 Aug 2009 06:41:01 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <200908092252.58363.j6t@kdbg.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 10 Aug 2009 06:41:01 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125401>

Johannes Sixt:

> The clean filter is applied before 'git diff' generates the diff. Since you
> have unstaged changes (I take [...] to mean this), you see a new date on
> every invocation.

Sorry for being unclear; no, the $Date$ line is the only change that shows 
up. I removed the surrounding context because I didn't want to publish them.

On another machine, there is another file that exhibits the same problem.

> After 'git add .htaccess' subsequent 'git diff' should not show any changes.

But then I need to check it in again, and I'd like to avoid that, if possible.


Is it possible to have a filter run on "commit" instead of "add"? (Or is 
"commit" just moving changes from the index to the repository, making that 
impossible?)

>> Doing "git reset --hard" or "git checkout master filename" does not 
>> help, the file is still believed to be modified by git.
>
> Now, that's an entirely different problem, and I think that there is a 
> bug. I have observed this as well with my own clean filter sometimes, but 
> not always. I haven't found a recipe that reliably exhibits the problem.

It seems to be triggered by using my date script and doing

   git add file
   git commit file
   git reset --hard file

the last command gives me a local copy with the keyword expanded, but marked 
dirty.


Is it possible to have "git add" expand the keyword (both the Git-internal 
"ident", i.e "$Id$", and my "$Date$")? Would duplicating the "clean" filter 
as a "smudge" one accomplish that?

-- 
\\// Peter - http://www.softwolves.pp.se/
