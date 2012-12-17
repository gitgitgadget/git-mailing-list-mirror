From: Woody Wu <narkewoody@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 05:06:33 +0000 (UTC)
Message-ID: <slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
 <CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 06:07:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkSux-0007D8-5q
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 06:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab2LQFGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 00:06:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:42810 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab2LQFGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 00:06:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TkSuo-00076z-G1
	for git@vger.kernel.org; Mon, 17 Dec 2012 06:06:58 +0100
Received: from 59.37.26.98 ([59.37.26.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 06:06:58 +0100
Received: from narkewoody by 59.37.26.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 06:06:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.37.26.98
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211630>

On 2012-12-17, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 17 December 2012 13:30, Woody Wu <narkewoody@gmail.com> wrote:
>> 1. git checkout foo
>> 2. git checkout origin/foo
>>
>> The first method run silently with success, but the second method
>> complains that I got a 'detached HEAD'.  So, I think I don't understand
>> the difference between 'foo' and 'origin/foo'.  Can someone give me a
>> hint?
>
> Hi Woody,
>
> I think you are just missing a couple of important distinctions that
> git makes about the different references that exist in your
> repository.
>
> A remote reference (origin/foo) describes exactly the state of
> somebody else's branch at the time you last synchronised with them. It
> does not make sense for you to be able to 'edit' this state, as it
> doesn't belong to you. Instead, we create a copy of that reference and
> give it a name (git checkout foo origin/foo) and call this a local
> reference (foo). Git then provides machinery around keeping these in
> sync with each other (git branch --set-upstream foo origin/foo) but we
> don't _have_ to keep these in sync at all! In fact, the names can be
> completely arbitrary and we don't have to track the upstream at all.
>
> If I have some other remote (remote-x) that has the same branch as
> origin but with some other changes I want to look at, we can just
> check that out to another branch (git checkout remote-x-foo
> remote-x/foo), or simply download it as a remote ref and merge the
> changes on top of my existing local branch (git fetch remote-x; git
> checkout foo; git merge remote-x/foo).

Thanks for explaining the concept of branch to me.  Now I understood the
difference between local and remote branch.  But I still have
difficulties in answering my own questions.

1. git checkout foo.
By this command, I think I am checking out files in my local branch
named foo, and after that I also switch to the branch. Right?

2. git checkout origin/foo
By this command, I am checking out files in remote branch origin/foo,
but don't create a local branch, so I am not in any branch now. This is
the reason why git tell me that I am in a 'detached HEAD'. Is this
understanding right?

>
> There are lots of patterns that can emerge from this functionality,
> but the main thing to remember is that to create changes on top of a
> remote branch, we first need to create a local copy of it. A 'detached
> HEAD' here means that we are looking at the remote repository's branch
> but don't have a local copy of it, so any changes we make might be
> 'lost' (that is, not have an easy to find branch name).
>

I think here is a little confuse to me.  You mean that a 'detached HEAD'
means I don't have a local copy, but I remember that if I run something
like:
    $ git checkout a-tag-name
then I ususally went into 'detached HEAD' but my local files really get
switched to those files in the tag 'a-tag-name'.  So what does you mean
by 'don't have a local copy'?

Many thanks!


-- 
woody
I can't go back to yesterday - because I was a different person then.
