From: Omar Othman <omar.othman@booking.com>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 14:06:07 +0100
Message-ID: <530C953F.9050805@booking.com>
References: <530B0395.5030407@booking.com> <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon McCaig <bamccaig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 14:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIHiA-0006wo-NO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 14:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaBYNGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 08:06:09 -0500
Received: from mail-out7.booking.com ([5.57.20.191]:48888 "EHLO
	mail-out7.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbaBYNGI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 08:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com; s=bk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=GVaabERvqcuv986X+u2ZLdDnMjl78ut65XRwxdOHIKU=;
	b=KUkGQG8jXf96ObeZzxFJpjJEyxo/WRSxFVyRn9Akzik4Jq1ysXwbuhrrhC6Vy7knd192gxMRODjeb0IuKTZ04fz6gI06wK/VnSOdLZodaPY3yWcHk05rFjxrlGE7Bzd4OCcmQu6lSoKYmI2wAacB8RzSdMZr8l+ty8S7Pe4k6/E=;
Received: from corpds-202.lhr4.corp.booking.com ([10.186.68.14]:59611)
	by mtx-203.lhr4.prod.booking.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIHi3-000AYw-N6; Tue, 25 Feb 2014 14:06:07 +0100
Received: from [10.155.74.57] (port=57778)
	by corpds-202.lhr4.corp.booking.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIHi3-0006mt-Hz; Tue, 25 Feb 2014 14:06:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242666>

Brandon:

Please note that what I am asking for is not always dropping the stash, 
but doing that *only* when the merge conflict is resolved. This is 
simply getting the whole command to be consistent. If you do `git stash 
pop` and it succeeds, the stash reference is dropped. If you do `git 
stash pop` and it succeeds *after resolving the merge conflict*, the 
stash reference is *not* dropped. This is *not* consistent and *is* a 
user experience problem. I'm not asking about dumbing git down by any means.

On 24-02-14 17:04, Brandon McCaig wrote:
> Omar:
>
> On Mon, Feb 24, 2014 at 3:32 AM, Omar Othman <omar.othman@booking.com> wrote:
>> In general, whenever something a user "should" do, git always tells. So, for
>> example, when things go wrong with a merge, you have the option to abort.
>> When you are doing a rebase, git tells you to do git commit --amend, and
>> then git rebase --continue... and so on.
>>
>> The point is: Because of this, git is expected to always instruct you on
>> what to do next in a multilevel operation, or instructing you what to do
>> when an operation has gone wrong.
>>
>> Now comes the problem. When you do a git stash pop, and a merge conflict
>> happens, git correctly tells you to fix the problems and then git add to
>> resolve the conflict. But once that happens, and the internal status of git
>> tells you that there are no more problems (I have a prompt that tells me
>> git's internal status), the operation is not culminated by dropping the
>> stash reference, which what normally happens automatically after a git stash
>> pop. This has actually confused me for a lot of time, till I ran into a git
>> committer and asked him, and only then were I 100% confident that I did
>> nothing wrong and it is indeed a UX problem. I wasted a lot of time to know
>> why the operation is not completed as expected (since I trusted that git
>> just does the right thing), and it turned out that it is git's fault.
>>
>> If this is accepted, please reply to this email and tell me to start working
>> on it. I've read the Documenation/SubmittingPatches guidelines, but I'll
>> appreciate also telling me where to base my change. My guess is maint, since
>> it's a "bug" in the sense of UX.
> Unlike a merge, when you pop a stash that history is lost. If you
> screw up the merge and the stash is dropped then there's generally no
> reliable way to get it back. I think that it's correct behavior for
> the stash to not be dropped if the merge conflicts. The user is
> expected to manually drop the stash when they're done with it. It's
> been a while since I've relied much on the stash (commits and branches
> are more powerful to work with) so I'm not really familiar with what
> help the UI gives when a conflict occurs now. Git's UI never really
> expects the user to be negligent. It does help to hint to you what is
> needed, but for the most part it still expects you to know what you're
> doing and does what you say, not what you mean.
>
> If there's any change that should be made it should be purely
> providing more detailed instructions to the user about how to deal
> with it. Either resolve the merge conflicts and git-add the
> conflicting files, or use git-reset to either reset the index
> (unstaging files nad clear) or reset index and working tree back to
> HEAD. In general, I almost always git-reset after a git-stash pop
> because I'm probably not ready to commit those changes yet and
> generally want to still see those changes with git diff (without
> --staged). Or perhaps just direct them to the appropriate sections of
> the man pages.
>
> I'm not really in favor of "dumbing down" Git in any way and I think
> that any step in that direction would be for the worst... Software
> should do what you say, not what you mean, because it's impossible to
> reliably guess what you meant. When a git-stash pop operation fails
> that might make the user rethink popping that stash. That's why it
> becomes a manual operation to drop it if still desired. And unlike
> git-reset --continue, which is explicitly the user saying "it is fixed
> and I accept the consequences, let's move on", there is no such option
> to git-stash to acknowledge that the merge conflicts have been
> resolved and you no longer need that stash (aside from git-stash drop,
> of course). It's not a UI problem. It's maybe a documentation problem,
> but again I'm not familiar with the current state of that.
>
> /not a git dev...yet
>
> Regards,
>
>
