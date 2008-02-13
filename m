From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merge-Recursive Improvements
Date: Wed, 13 Feb 2008 09:46:35 +0100
Message-ID: <47B2AE6B.2030700@viscovery.net>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <47B29EBF.7060607@viscovery.net> <E105587B-9E61-4A21-91F5-6310A83C3F41@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Voltage Spike <voltspike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 09:47:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPDGu-0004g2-2W
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbYBMIql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 03:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYBMIql
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:46:41 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15995 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbYBMIqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:46:40 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JPDFr-0007Wg-95; Wed, 13 Feb 2008 09:46:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 91E0769F; Wed, 13 Feb 2008 09:46:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <E105587B-9E61-4A21-91F5-6310A83C3F41@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73757>

Voltage Spike schrieb:
> On Feb 13, 2008, at 12:39 AM, Johannes Sixt wrote:
> 
>> Voltage Spike schrieb:
>>> Third, git doesn't appear to have any sense of context when performing a
>>> merge. Another contrived example which wouldn't be flagged as a merge
>>> conflict:
>>>
>>>   ptr = malloc(len); // Added in HEAD.
>>>   init();            // Included in merge-base.
>>>   ptr = malloc(len); // Added in "merge".
>>
>> You seem to say that you want this to result in a merge conflict.
> 
> Yes, it appears that I wasn't clear that I see the above as a conflict.
> 
>> I'm opposed to this: It means that you would mark a conflict if there
>> is a
>> single unchanged line between the two changes that come from the merged
>> branches. So far it has happened for me much more frequently that such
>> merges were correct, and I should not be bothered with conflict
>> markers. I
>> conciously prefer to pay the price that such a merge is incorrect on
>> occasion.
> 
> That is why I'm hoping to make it configurable. I know that we have more
> information than during a simple patch, but it seems odd that changes
> can be occurring all around your local modifications and you'll never be
> notified.
> 
> Which leads to a different point: does this lessen the value of falling
> back to a 3-way merge during a rebase?

The current non-conflicting merges are invaluable for my workflow, which
involves lots and lots of rebasing and cherry-picking.

>> You also need to draw a border line: a single unchanged line between the
>> changes? Or better also conflict at 2 lines? Or 3?
> 
> I naturally assumed the default number of context lines: 3. If I recall
> correctly, this isn't typically configurable.

Nawww... Guess how many, many more conflicts this would report?

Practically all merges that I do are during rebase and cherry-pick. During
this work I often have changes that are separated by only a single line.
The potential merge conflicts that fall in the above category I know in
advance because I've made the changes just two minutes ago, and I can fix
them even without being reminded by a merge conflict.

IOW: I don't need conflict markers in this case - I need them not to
conflict at all.

-- Hannes
