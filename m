From: Christof =?iso-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: removing files from history but not filesystem
Date: Tue, 28 Jun 2011 09:04:59 +0200 (CEST)
Message-ID: <218bf1d3b2bf197a5f56d542c6a91960.squirrel@mail.localhost.li>
References: <CFCCFA00-B4BF-4A88-88A5-2F588630F7BB@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Shantanu Pavgi" <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Tue Jun 28 09:08:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbSPB-0001dS-FH
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 09:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319Ab1F1HFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 03:05:31 -0400
Received: from vserver.localhost.li ([85.214.46.152]:35591 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215Ab1F1HFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 03:05:07 -0400
Received: from localhost ([127.0.0.1]:59777 helo=mail.localhost.li)
	by mail.localhost.li with esmtp (Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1QbSLz-0008Jq-LN; Tue, 28 Jun 2011 09:05:01 +0200
Received: from 194.39.218.10
        (SquirrelMail authenticated user mail@christof-krueger.de)
        by mail.localhost.li with HTTP;
        Tue, 28 Jun 2011 09:04:59 +0200 (CEST)
In-Reply-To: <CFCCFA00-B4BF-4A88-88A5-2F588630F7BB@uab.edu>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176384>

Hi,

> $ git filter-branch --index-filter 'git rm --cached --ignore-unmatch
> */one.txt' HEAD

The following should work:

git branch temp
git filter-branch --index-filter 'git rm --cached --ignore-unmatch foo' temp
git reset temp

This creates branch "temp" pointing to the same commit as "master".
Then you filter-branch the "temp" branch. This leaves file "foo" in your
working directory intact, as your current branch is actually "master". The
third step resets your current "branch" to the commit pointed by the
rewritten branch "temp". The default for git reset is --mixed which
according to the man page leaves the working tree alone.

Regards,
  Chris
