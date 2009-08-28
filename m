From: "Matthias Andree" <matthias.andree@uni-paderborn.de>
Subject: Re: git-svn intermittent issues with absent_file
Date: Fri, 28 Aug 2009 08:58:21 +0200
Organization: Universitaet Paderborn
Message-ID: <op.uzc1njug3myrm3@merlin.emma.line.org>
References: <op.uzbs4bsq3myrm3@balu.cs.uni-paderborn.de>
 <20090827191902.GA3185@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 08:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgvQ4-0005dq-5T
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 08:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbZH1G6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 02:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbZH1G63
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 02:58:29 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:18196 "EHLO
	mail.uni-paderborn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZH1G63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 02:58:29 -0400
Received: from tweenies.uni-paderborn.de ([131.234.200.43] helo=localhost.localdomain)
	by mail.uni-paderborn.de with esmtp (Exim 4.63 zuban)
	id 1MgvPp-0002AS-MS; Fri, 28 Aug 2009 08:58:30 +0200
Received: from mail.uni-paderborn.de
	by tweenies with queue id 11895376-5;
	Fri, 28 Aug 2009 06:58:24 GMT
Received: from matthias.andree@uni-paderborn.de (g230102245.adsl.alicedsl.de [92.230.102.245])
	by mail.uni-paderborn.de with SMTP id 1MgvPk-0001s9-QB;
	Fri, 28 Aug 2009 06:58:24 GMT
	(envelope-from matthias.andree@uni-paderborn.de)
Received: from g230102245.adsl.alicedsl.de ([92.230.102.245] helo=mandree.no-ip.org)
	by mail.uni-paderborn.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63 hoth)
	id 1MgvPk-0001s9-QB; Fri, 28 Aug 2009 08:58:24 +0200
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 7A7C9946DE;
	Fri, 28 Aug 2009 08:58:22 +0200 (CEST)
User-Agent: Opera Mail/9.64 (Linux)
In-Reply-To: <20090827191902.GA3185@dcvr.yhbt.net>
X-Envelope-From: <matthias.andree@uni-paderborn.de>
X-IMT-Authenticated-Sender: uid=mandree,ou=People,o=upb,c=de
X-PMX-Version: 5.5.7.378829, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2009.8.28.64536
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127272>

Am 27.08.2009, 21:19 Uhr, schrieb Eric Wong <normalperson@yhbt.net>:

> Matthias Andree <matthias.andree@uni-paderborn.de> wrote:
>> Greetings,
>>
>> we seem to have issues with checking out files from an SVN server via
>> https://. The problem is hard to reproduce, and shows as "absent_file"
>> warnings, i. e. files that are in the SVN checkout don't make it to the
>> Git checkin.
>>
>> Perhaps this rings a bell with someone or there are similar reports that
>> relate to our issues...
>
> Hi Matthias,
>
> I don't recall any issues with the "absent_file" callback ever being
> reported to me.  I don't think I've ever touched a repo that triggered
> it, either...

Hi Eric,

thank you for the prompt reply.

>> ## ISSUE ## Once in a while, a git-svn clone or rebase fails with files
>> missing from commits, as mentioned above. We haven't been able to figure
>> out under what circumstances this happens. If we try to reproduce this
>> (i. e. kill the directory completely and re-run the git svn clone),
>> another revision (for instance 170) might show this, or the clone may
>> succeed.
>>   This was observed with Git 1.6.0.4 under Ubuntu Linux Jaunty Jackalope
>> (9.04) and on a different computer with Git 1.6.4.1.196.g31f0b (from the
>> master branch) under a fully updated Cygwin 1.5.
>
> I assume this happens with the latest git under Ubuntu Linux, too; but
> can you give that a try just in case?

The latest git was on Cygwin, but we'll see to trying it on Linux.

> There have been a few odd bugs fixed since 1.6.0.4, but nothing rings a
> bell here.  This doesn't seem to be a Cygwin/Win32-related issue, but
> I'd like to minimize the number of variables since I can't support
> Cygwin/Win32 directly.

The other question is how many arcane APR or Subversion binding issues we
hit here. Subversion 1.6 + bindings surely is rather picky on Cygwin 1.5,
as discussed earlier on this list.

>> Questions:
>>
>> 1. What causes these absent_file issues? How can we assist with  
>> debugging
>> this?
>
> Permissions would be my first (and only) guess as I have no experience
> with this condition...

Hm. In that case: who writes the file that goes missing, and why isn't the
error logged then? Is there a way to have the SVN bindings or the
interfacing code in Git-SVN log file creation/write errors with decoded
errno? That might help a big deal already.

> Are you using anything weird in ~/.subversion/config by any chance?

Not to my knowledge.

> And you're sure you're using the same user/account in all cases?

Yes indeed. All under the same account.

> Are the files you're hitting absent_file on unusually large and
> hitting some limit on the server side?

The files aren't, the whole changeset might. We haven't yet observed this
on small (as in one .tex file) commits.

>> 2. What does "Delta source ended unexpectedly" mean? (the line number is
>> bogus, it's just the finish_report call)
>
> Sometimes the server can just shut down/drop connections.  Do you have
> access to the server logs?  How many simultaneous connections can
> it accept?  Which version of the Subversion server is running?

The server doesn't permit user logins, so we need to ask the support
staff. Answer times are unpredictable.

> How reliable is your network connection to the server?
> Anything weird with the network configuration?  Mismatched MTU, odd
> firewall rules, non-standard TCP stack configuration, VPN, proxies...

Uncritical. Company network, "direct connection" (through switches).

>> 3. Is this or a similar issue known? Is this an issue with the SVN
>> server, the SVN bindings, or the git svn adaptor?
>
> The "Incomplete data: Delta source ended unexpectedly" happens
> from time to time on a few odd servers, but I've never found it
> reproducible and retrying "git svn fetch" always fixes it.
> This is more than likely the fault of the network or server.

Seems plausible, but...

> The "absent_file" issue I've never seen...

...in such a case, some part of the overall system (I'm not saying it's  
git-svn though) must ignore an error and continue.

>> We're happy to test patches.
>
> Cool.  I don't have any ideas for patches right now, but does this
> problem happen with other SVN clients?  Even svk/svm could be
> worth a shot for testing...

I can try svk, but what's svm?

-- 
Matthias Andree
