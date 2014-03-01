From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Sat, 01 Mar 2014 02:47:44 -0600
Message-ID: <85bnxq1f0v.fsf@stephe-leake.org>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<xmqqeh2nw2p4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 09:48:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJfah-00084X-NK
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 09:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbaCAIrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 03:47:48 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:43631 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751711AbaCAIrs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Mar 2014 03:47:48 -0500
Received: from [70.94.38.149] ([70.94.38.149:50019] helo=TAKVER)
	by cdptpa-oedge01 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id C6/DD-10928-2BE91135; Sat, 01 Mar 2014 08:47:47 +0000
In-Reply-To: <xmqqeh2nw2p4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 28 Feb 2014 09:45:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243054>

Junio C Hamano <gitster@pobox.com> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> lists@haller-berlin.de (Stefan Haller) writes:
>>>
>>>> Your intention was clearly to drop the stash, it just wasn't dropped
>>>> because of the conflict. Dropping it automatically once the conflict
>>>> is resolved would be nice.
>>>
>>> Your intention when you ran "git stash pop", yes. Your intention when
>>> you ran "git add", I call that guessing.
>>
>> You might be adding other files for other reasons. But if you add a file
>> that does resolve a conflict caused by 'git stash pop', it is not
>> guessing.
>
> The only thing you know for sure is that the user has consumed _one_
> part of the stashed change, no?  What if the stash had changes for
> more than one path?

Count the unmerged paths in the index; when the count is zero, all
conflicts are resolved.

paths in the stash that had no conflicts are already in the index.

So _if_ there is nothing going on except finishing the stash pop, an
unmerged path count of zero means you are done with the stash, and it
can be dropped.

> At the time of "git add $path", can you reliably tell if the
> conflict to the $path the user is resolving came from a previous
> "git stash pop", not from any other mergy operations, e.g. "git
> stash apply" or "git apply -3"?

This is the real problem. I can impose a rule on my team of "don't do
more than one merge at a time" by implementing that in the front-end,
but git can't assume that.

-- 
-- Stephe
