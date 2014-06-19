From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] rebase --root: Empty root commit is replaced with sentinel
Date: Thu, 19 Jun 2014 15:08:18 +0200
Message-ID: <53A2E0C2.1000004@alum.mit.edu>
References: <53A18198.7070301@gmail.com> <53A2CB18.7020408@alum.mit.edu> <53A2DA17.4060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Webb <chris@arachsys.com>
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 15:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxc4n-0005hh-F6
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 15:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbaFSNIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 09:08:21 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60575 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752434AbaFSNIV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2014 09:08:21 -0400
X-AuditID: 1207440d-f79c26d000000b51-34-53a2e0c414e6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 10.8C.02897.4C0E2A35; Thu, 19 Jun 2014 09:08:20 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3EB8.dip0.t-ipconnect.de [93.219.62.184])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5JD8Ivx004202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 19 Jun 2014 09:08:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53A2DA17.4060905@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqHvkwaJgg9OvBC0Ozb3HbnFgg6NF
	15VuJgdmj/8rZzN67Jx1l93j8ya5AOYobpukxJKy4Mz0PH27BO6MJ6tPMxb80qjo+bGHsYGx
	WaGLkZNDQsBEYkX3DjYIW0ziwr31QDYXh5DAZUaJhq97mCCc80wS12c3sIBU8QpoS+z5sRes
	g0VAVeLj1w5GEJtNQFdiUU8zE4gtKhAkMfvzPHaIekGJkzOfgPWKCJhLHN8xCyzOLKAs0Xxs
	HlivsICvxLJzPawgtpBAqsTmq8+YQWxOAU2J+6/uA83kALpOXKKnMQiiVUfiXd8DZghbXmL7
	2znMExgFZyHZNgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5i
	hIQ07w7G/+tkDjEKcDAq8fAuuLwwWIg1say4MvcQoyQHk5Ior8adRcFCfEn5KZUZicUZ8UWl
	OanFhxglOJiVRHi7DwDleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoS
	vPrA2BUSLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VwfDEwhkFSPEB72UDaeYsL
	EnOBohCtpxh1OU7dOdbGJMSSl5+XKiXO++w+UJEASFFGaR7cClgCe8UoDvSxMC8/yCgeYPKD
	m/QKaAkT0JLFPWBLShIRUlINjFLfrFxO/ZusfsRU55KNzEr1O+b7t9x2KOMoyFq2wHmP8SWD
	P2kh1tK5dYET5e9e/1PMER7+mqnu7rXEL8p3f27s1ZrJJdaftOJnO+f5dqOKC7xH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252112>

On 06/19/2014 02:39 PM, Fabian Ruch wrote:
> Hi Michael,
> 
> thanks for your reply.
> 
> On 06/19/2014 01:35 PM, Michael Haggerty wrote:
>> On 06/18/2014 02:10 PM, Fabian Ruch wrote:
>>> `rebase` supports the option `--root` both with and without `--onto`.
>>> The case where `--onto` is not specified is handled by creating a
>>> sentinel commit and squashing the root commit into it. The sentinel
>>> commit refers to the empty tree and does not have a log message
>>> associated with it. Its purpose is that `rebase` can rely on having a
>>> rebase base even without `--onto`.
>>>
>>> The combination of `--root` and no `--onto` implies an interactive
>>> rebase. When `--preserve-merges` is not specified on the `rebase`
>>> command line, `rebase--interactive` uses `--cherry-pick` with
>>> git-rev-list to put the initial to-do list together. If the root commit
>>> is empty, it is treated as a cherry-pick of the sentinel commit and
>>> omitted from the todo-list. This is unexpected because the user does not
>>> know of the sentinel commit.
>>
>> I see that your new tests below both use --keep-empty.  Without
>> --keep-empty, I would have expected empty commits to be discarded by
>> design.  If that is the case, then there is only a bug if --keep-empty
>> is used, and I think you should mention that option earlier in this
>> description.
> 
> Now that you mention it, --keep-empty is crucial for this to be a bug
> (except for the case where the branch consists solely of empty commits).
> I intended to use --keep-empty merely as a pedagogic tool so nobody
> would get confused about what is on the to-do list.
> 
>> Also, I think this bug strikes if *any* of the commits to be rebased is
>> empty, not only the first commit.
> 
> Ah, I really did not deduce that all empty commits would disappear with
> --root and --keep-empty. Thanks.
> 
>>> Add a test case. Create an empty root commit, run `rebase --root` and
>>> check that it is still there. If the branch consists of the root commit
>>> only, the bug described above causes the resulting history to consist of
>>> the sentinel commit only. If the root commit has children, the resulting
>>> history contains neither the root nor the sentinel commit. This
>>> behaviour is the same with `--keep-empty`.
>>>
>>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>>> ---
>>>
>>> Notes:
>>>     Hi,
>>>     
>>>     This is not a fix yet.
>>
>> It is actually OK to add failing tests to the test suite, but they must
>> be added with 'test_expect_failure' instead of 'test_expect_success'.
>> Though of course it is preferred if the new test is followed by a commit
>> that fixes it :-)
> 
> I did not plan to have this accepted but to amend the patch with a fix
> later on. Also, I hoped the ready-to-apply tests would give someone else
> a smoother start when taking over and compensate for a possibly
> incomprehensible problem description.
> 
>>>     We are currently special casing in `do_pick` and whether the current
>>>     head is the sentinel commit is not a special case that would fit into
>>>     `do_pick`'s interface description. What if we added the feature of
>>>     creating root commits to `do_pick`, using `commit-tree` just like when
>>>     creating the sentinel commit? We would have to add another special case
>>>     (`test -z "$onto"`) to where the to-do list is put together in
>>>     `rebase--interactive`. An empty `$onto` would imply
>>>     
>>>         git rev-list $orig_head
>>>     
>>>     to form the to-do list. The rebase comment in the commit message editor
>>>     would have to become something similar to
>>>     
>>>         Rebase $shortrevisions as new history
>>>     
>>>     , which might be even less confusing than mentioning the hash of the
>>>     sentinel commit.
>>
>> Since you are working on a hammer, I'm tempted to see this problem as a
>> nail.  Would it make it easier to encode the special behavior into the
>> todo list itself?:
>>
>>     pick --orphan 0cf23b1 New initial commit
>>     pick 144a852 Second commit
>>     pick 255f8de Third commit
> 
> While I agree to enable pick to create orphan commits, I don't think a
> user option --orphan is of much help. Firstly, does --orphan make sense
> for any commit but the first one on the to-do list? Secondly, does
> --orphan make sense when we are rebasing onto another branch? The second
> point is related to the first in the sense that "pick --orphan" would be
> used on a commit that is understood to have a parent.

--orphan as a user option would only really make sense if we get around
to supporting interactive rebase of arbitrary DAGs.

Perhaps a more practical problem with --orphan is that it makes it
harder for the user to change the order of the first two commits.

Another possible construct would be a separate "orphan" command:

    orphan
    pick 0cf23b1 New initial commit
    pick 144a852 Second commit
    pick 255f8de Third commit

But these are just wild ideas.  I haven't thought enough about the
problem to advocate anything.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
