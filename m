From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 13:05:45 -0600
Message-ID: <4A130309.2060407@nortel.com>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <NFLo0xGp2o-oBdtr_pq1jvwATe1ZALaD9dHkr5hmKNkU30gr_isMpQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue May 19 21:06:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6UdR-0002g0-3G
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 21:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbZESTFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbZESTFt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 15:05:49 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:49413 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbZESTFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 15:05:48 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id n4JJ4io13470;
	Tue, 19 May 2009 19:04:44 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 15:05:46 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <NFLo0xGp2o-oBdtr_pq1jvwATe1ZALaD9dHkr5hmKNkU30gr_isMpQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 May 2009 19:05:46.0675 (UTC) FILETIME=[D0DEE030:01C9D8B4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119559>

Brandon Casey wrote:

> Try these commands:
> 
>   git describe $main
>   git describe $arch_branch
>   git tag -m 'a test tag' my_tag $main
>   git describe $main
>   git describe $arch_branch

In the commands below, "main" is $main, and "arch" is $arch_branch.
I'm starting out with the arch branch checked out.

[cfriesen@localhost linux]$ git describe main
dynamic_ftrace_excluded-auto-mark-225-g7c2dc32
[cfriesen@localhost linux]$ git describe arch
dynamic_ftrace_excluded-auto-mark-225-g7c2dc32
[cfriesen@localhost linux]$ git tag -m 'a test tag' my_tag ncgl
[cfriesen@localhost linux]$ git describe arch
my_tag
[cfriesen@localhost linux]$ git describe arch
my_tag

So far so good.  Now I make a change to the arch branch, and add
another tag to the main branch.

[cfriesen@localhost linux]$ echo a > asdf
[cfriesen@localhost linux]$ git add asdf
[cfriesen@localhost linux]$ git commit
Created commit 4c8dfa7: blah
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 asdf

[cfriesen@localhost linux]$ git describe main
my_tag
[cfriesen@localhost linux]$ git describe arch
my_tag-1-g4c8dfa7


Now we add another tag to the main branch:

[cfriesen@localhost linux]$ git tag -m 'a test tag' my_tag2 main
[cfriesen@localhost linux]$ git describe main
my_tag
[cfriesen@localhost linux]$ git describe arch
my_tag-1-g4c8dfa7

I assume that since there were no code changes on the main branch,
it doesn't think that there is any difference between the two tags.

Chris
