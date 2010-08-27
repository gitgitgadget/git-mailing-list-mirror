From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git pull --rebase differs in behavior from git fetch +
 git rebase
Date: Fri, 27 Aug 2010 16:29:58 -0600
Message-ID: <4C783C66.3000008@workspacewhiz.com>
References: <4C772A01.5030207@workspacewhiz.com>	<alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>	<4C77DE60.6020809@workspacewhiz.com> <AANLkTimEO==c7Pzi99VfvDp7S9HN=V2j6t0kk--w1kb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Olszewski <cxreg@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 00:30:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op7RC-00021w-4N
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 00:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab0H0WaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 18:30:11 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:43064 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab0H0WaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 18:30:10 -0400
Received: (qmail 29969 invoked by uid 399); 27 Aug 2010 16:30:09 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.190.236)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Aug 2010 16:30:09 -0600
X-Originating-IP: 75.220.190.236
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTimEO==c7Pzi99VfvDp7S9HN=V2j6t0kk--w1kb9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154623>

  ----- Original Message -----
From: Elijah Newren
Date: 8/27/2010 12:46 PM
> On Fri, Aug 27, 2010 at 9:48 AM, Joshua Jensen
> <jjensen@workspacewhiz.com>  wrote:
>>> The main difference between "git pull --rebase" and "git fetch&&  git
>>> rebase @{u}" is that "git pull --rebase" will attempt to use the reflog
>>> to find a suitable "upstream" candidate instead of assuming your
>>> tracking branch is the upstream itself.  This is intended to help
>>> recover from upstream rebases, but has adverse effects sometimes, which
>>> commit cf65426de should help with.
>> Unfortunately, commit cf65426de helps only a little.  The 'git pull
>> --rebase' reports "Nothing to do" and moves the master branch to
>> origin/master, leaving behind the commit needing to be rebased.
>>
>> What else might there be to try?  I would like to help with a repro, if
>> possible.
> Try modifying the git-pull script; change the last line from
>    eval "exec $eval"
> to
>    echo "exec $eval"
> .
>
> Is the output of the form
>    git-rebase --onto XXXX YYYY
> or
>    git-rebase --onto XXXX XXXX
> ?
>
> With cf65426de, and from what I'm guessing from your description, I'd
> expect the latter.  And, I'd assume the latter is equivalent to
> 'git-rebase XXXX', but you say that's not the behavior you're getting.
>   Finding out which of my assumptions is wrong may help you debug the
> issue.
It reports to me 'git-rebase --onto XXXX XXXX'.

And it reports nothing to do.

XXXX is properly the origin/master in this case.

git rebase origin/master           works.
git rebase --onto origin/master origin/master       does not work.

Thoughts?

Josh
