From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 11:45:25 -0600
Message-ID: <85r46n168a.fsf@stephe-leake.org>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
	<851tynz2yg.fsf@stephe-leake.org> <87mwhb1azp.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 18:45:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRVF-0003wo-6m
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbaB1Rpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:45:32 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:46916 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752393AbaB1Rp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 12:45:29 -0500
Received: from [75.87.81.6] ([75.87.81.6:49292] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 4B/AD-02678-83BC0135; Fri, 28 Feb 2014 17:45:28 +0000
In-Reply-To: <87mwhb1azp.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 28 Feb 2014 17:02:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242993>

David Kastrup <dak@gnu.org> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>> Brandon McCaig <bamccaig@gmail.com> writes:
>>
>>> On Thu, Feb 27, 2014 at 9:57 PM, Stephen Leake
>>> <stephen_leake@stephe-leake.org> wrote:
>>>> You might be adding other files for other reasons. But if you add a file
>>>> that does resolve a conflict caused by 'git stash pop', it is not
>>>> guessing.
>>>
>>> Staging a file doesn't tell git that you resolved a conflict. Git will
>>> happily accept a blob full of conflict markers. Git doesn't know the
>>> difference. Git expects the user to know what is right. The user has
>>> the freedom to manipulate the index as they see fit, which means both
>>> adding and removing from it anytime they wish.
>>
>> But git has a notion of "unresolved conflict".
>
> Not really.  It has a notion of "unmerged path".
>
> <snip>

> The index contains the unmerged versions of the file.  Possibly also the
> version with conflict markers, but it's been too long since I last
> checked.

Paraphrasing, is this correct? 

    "the index contains both versions of the unmerged file; any file
     with more than one version in the index is unmerged".

So what 'git add' does in this case is replace both versions of the file
in the index with a new version.

I was not aware that the git system could support more than one version
of a file in one branch. That makes it more like monotone :).

> If you apply a stash with unmerged paths to a worktree/index, possibly
> containing unmerged paths of its own, possibly getting new unmerged
> paths by failing to apply the stash, you get unmerged paths from several
> different unresolved conflicts.

Yes; doing too many things at once is a bad idea. But that should never
cause git to lose data or do something wrong.

At the same time, it seems all unmerged paths result from unresolved
merge conflicts, so the two notions are equivalent for git?

> Git has no idea about the history of unmerged paths.  So having "git
> add" modify the operation of "git reset" whenever "git add" overwrites
> an unmerged path in the index could lead to quite funny results.

Ok; I'll take that as describing a large class of "bad thing" use cases.

-- 
-- Stephe
