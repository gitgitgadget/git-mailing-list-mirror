From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Odd rebase behavior
Date: Fri, 18 Dec 2015 22:05:37 +0100
Message-ID: <56747521.9090701@kdbg.org>
References: <877fkf9j5h.fsf@waller.obbligato.org>
 <20151216221716.GD1581@serenity.lan> <nngmvt73b63.fsf@lnx-dag.us.cray.com>
 <20151218180549.GA14056@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
	gitster@pobox.com
To: John Keeping <john@keeping.me.uk>,
	"David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 22:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA2Dn-0008N5-G4
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 22:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965401AbbLRVFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 16:05:49 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:31606 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965372AbbLRVFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 16:05:41 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pMjQV6CQwz5tlK;
	Fri, 18 Dec 2015 22:05:38 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3E1F52F63;
	Fri, 18 Dec 2015 22:05:38 +0100 (CET)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <20151218180549.GA14056@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282716>

Am 18.12.2015 um 19:05 schrieb John Keeping:
> On Fri, Dec 18, 2015 at 11:43:16AM -0600, David A. Greene wrote:
>> John Keeping <john@keeping.me.uk> writes:
>>
>>> It seems that the problem is introduces by --preserve-merges (and
>>> -Xsubtree causes something interesting to happen as well).  I see the
>>> following behaviour:
>>
>> Thanks for narrowing this down!  Is it possible this is actually a
>> cherry-pick problem since --preserve-merges forces rebase to use
>> cherry-pick?
>
> I'm pretty sure this a result of the code in git-rebase--interactive.sh
> just below the comment "Watch for commits that have been dropped by
> cherry-pick", which filters out certain commits.  However, I'm not at
> all familiar with the --preserve-merges code in git-rebase so I could be
> completely wrong.
>
>>> git rebase -Xsubtree=files_subtree --onto files-master master
>>>
>>> 	fatal: Could not parse object 'b15c4133fc3146e1330c84159886f0f7a09fbf43^'
>>> 	Unknown exit code (128) from command: git-merge-recursive
>>> b15c4133fc3146e1330c84159886f0f7a09fbf43^ -- HEAD
>>> b15c4133fc3146e1330c84159886f0f7a09fbf43
>>
>> Ah, good!  I had seen this behavior as well but couldn't remember what I
>> did to trigger it.
>>
>> I don't think I have the expertise to fix rebase and/or cherry-pick.
>> What's the process for adding these tests to the testbase and marking
>> them so the appropriate person can fix them?  I see a lot of TODO tests.
>> Should I mark these similarly and propose a patch to the testbase?
>
> I think marking them with test_expect_failure (instead of
> test_expect_success) is enough.
>

There are a few known breakages recorded in 
t3512-cherry-pick-submodule.sh. Perhaps the one observed here is already 
among them?

-- Hannes
