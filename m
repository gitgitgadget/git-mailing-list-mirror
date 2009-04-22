From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Bug(let): status reports 'can fast-forward' when not true
Date: Wed, 22 Apr 2009 10:07:42 +0200
Organization: private
Message-ID: <86d4b5i01d.fsf@broadpark.no>
References: <20090421205352.GA29125@hashpling.org>
 <20090421210233.GB13151@coredump.intra.peff.net>
 <7veivl60yt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Charles Bailey <charles@hashpling.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 10:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwXWX-00044e-3r
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 10:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbZDVIIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 04:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbZDVIIG
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 04:08:06 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:48555 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZDVIIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 04:08:05 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIH00FK7T9DZ5D0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 22 Apr 2009 10:08:01 +0200 (CEST)
Received: from localhost ([84.48.79.162]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIH00CV6T9C5NC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 22 Apr 2009 10:08:01 +0200 (CEST)
In-reply-to: <7veivl60yt.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117180>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> [cc'ing Kjetil, as this is a fallout of 19de5d6]
>>
>> On Tue, Apr 21, 2009 at 09:53:52PM +0100, Charles Bailey wrote:
>>
>>> I was not really thinking when I get fetched, and ran git status on my
>>> pu branch. I was told that pu was behind origin/pu by 104 commits and
>>> could be fast-forwarded, so I git merged origin/pu and was mildly
>>> surprised when git merge made a commit for me.
>>> 
>>> A quick investigation revealed that pu had (of course) been rewound,
>>> but the only commits that it had that the new pu didn't, were merge
>>> commits.
>>
>> I think this is an unintended consequence of 19de5d6
>> (stat_tracking_info(): only count real commits, 2009-03-04). It is
>> perhaps more useful when seeing the actual numbers to see only the count
>> of real commits, but it makes statements like "can be fast-forwarded" no
>> longer true.
>>
>> So I think we need to either:
>>
>>   1. reword the "can be fast-forwarded" text to something else
>>
>>   2. revert 19de5d6, since merge commits _can_ be interesting
>>
>>   3. refactor stat_tracking_info to return "real" and "merge" counts,
>>      and change the text for the case of "real == 0 && merge > 0".
>>
>> -Peff
>
> Let's revert it for now and then try #3 after 1.6.3 final.

  OK.  

  Then I have some time thinking about a solution.  Maybe:

  4. Introduce an argument "--no-merges", and then only show real
     commits when used.

  -- kjetil
