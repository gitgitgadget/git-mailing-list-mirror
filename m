From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git branch command is incompatible with bash
Date: Mon, 27 Jul 2015 23:11:04 +0200
Message-ID: <55B69E68.90306@kdbg.org>
References: <20150727121253.GC17338@2vizcon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anatol Rudolph <a.rudolph@2vizcon.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:11:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJpg1-0007Ry-Ol
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 23:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbbG0VLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 17:11:09 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:55826 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751587AbbG0VLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 17:11:08 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mgDMF0vzmz5tl9;
	Mon, 27 Jul 2015 23:11:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 99F155189;
	Mon, 27 Jul 2015 23:11:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20150727121253.GC17338@2vizcon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274709>

Am 27.07.2015 um 14:12 schrieb Anatol Rudolph:
> When using the git branch command, git uses a '*' to denote the current
> branch. Therefore, in bash this:
>
> 	$ branchName=$(git branch -q)
> 	$ echo $branchName
>
> produces a directory listing, because the '*' is interpreded by the
> shell.

Of course. You would write the last line as

   echo "$branchName"

These are shell fundamentals.

> While an (unwieldly) workaround exists:
>
> 	$ branchName=$(git symbolic-ref -q HEAD)
> 	$ branchName=${branch##refs/heads/}

If you want to do that in a script, this is not a work-around, but it is 
how you should do it. But you may want to use option --short to save the 
second line.

> it would still be nice, if there were a --current flag, that returned
> only the current branch name, omitting the star:
>
> 	$ branchName=$(git branch --current -q)
> 	$ echo $branchName
> 	master

Try

   branchName=$(git rev-parse --abbrev-ref HEAD)

-- Hannes
