From: John Tapsell <johnflux@gmail.com>
Subject: Re: Improving git branch
Date: Wed, 17 Dec 2014 11:51:32 +0000
Message-ID: <CAHQ6N+pjT9zCdbvjJnFTmJEM=btjDxn8LTRV-j1vbqGfqwks5A@mail.gmail.com>
References: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com>
 <549168DD.1080906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 12:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1D95-0000df-6c
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 12:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaLQLvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 06:51:54 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:64437 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbaLQLvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 06:51:54 -0500
Received: by mail-oi0-f41.google.com with SMTP id a3so11050319oib.28
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 03:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aylZf6cQBuLYMgWisMz2VdocajBMTHYQb7fCNUgQSpE=;
        b=nVxF1Wjt1MZoy+WLyrR/DKH9Mmo44j/vflQJuMIVpUmalk6Q+wQwkiBDwXhHiZyto5
         Vj9uRQ3wFrR7UCiRehdsHL0Cy0BZj5CSGHuo0TVbvRBUrjFtdqFnSyvp9klhuA/ZIulW
         jsQ9u9DiZ8jcmMSJBJygR4IpiydCaFAqDZhc1/msDSbSHP3YXIvbNrCnU9EQBL9Mdok4
         p1MT2qM7gk8uQtwcA/cm2htHF0nyA8uHa/I13q56UuPbPBTRdK4aNpAK8ZfjesjOAe1k
         Ox+Qpr8uZq5YyBz9/u+Vkgwwd/2engmFsJx2v3urrIeG+BkJKuJi8ln7KYEScdiN5Gcm
         WOSg==
X-Received: by 10.60.52.193 with SMTP id v1mr25738516oeo.19.1418817113734;
 Wed, 17 Dec 2014 03:51:53 -0800 (PST)
Received: by 10.60.25.6 with HTTP; Wed, 17 Dec 2014 03:51:32 -0800 (PST)
In-Reply-To: <549168DD.1080906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261481>

I don't fully understand - if I did that, then what difference would
an average user actually see?

On 17 December 2014 at 11:28, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> John Tapsell schrieb am 17.12.2014 um 12:10:
>> Hi all,
>>
>>   I'm interested in putting in some time and effort into improving the
>> output of "git branch".
>>
>>   What I'm thinking is an output like this:
>>
>> $ git branch
>>
>> 2014-12-17 * (detached from origin/master)     deaba04 Do stuff
>> 2014-12-15   john.ta/add_timing_info                6edbcfa  Add timing stuff
>> 2014-12-14   master                                          8537316
>> [origin/master: ahead 1, behind 16] Some stuff
>> 2014-12-12   john.ta/new_reduce_memory       99d84db Reintroduce: memory stuff
>> 2014-12-05   john.ta/bugfixes                            e15c95e Add stuff
>> 2014-12-03   john.ta/container                           e9fd4e5 This
>> branch is a test bed for containers
>>
>>
>> (These columns are supposed to be all aligned nicely..)
>>
>> So, features:
>>
>> 1. Show the date of the last commit
>> 2. Sort by date.  Most recently used branches at the top
>> 3. Show the branch name, including your current "branch", with a * to
>> indicate that it's checked out.
>> 4. Show the sha
>> 5. Show the branch DESCRIPTION - and if that's not available, show the
>> short-line of the most recent commit.
>>
>> There is also a small amount of color here that I can't paste here, to
>> follow the coloring in the current git branch.
>>
>> Before I start making patches etc, what do people think?  Would I have
>> a chance of getting this in?  Should I change some aspects etc?
>>
>> Thanks,
>>
>> John Tapsell
>>
>
> I support the general goal, we have quite some way to go there.
>
> As to the method: "git branch" in list mode, "git tag" in list mode and
> "git for-each-ref" all do similar things and are in turn not dissimilar
> from "git log --no-walk" with appropriate formatting and rev options.
>
> Rather than extending "git branch" any further[*], I suggest a bolder
> strategy:
>
> - unify/merge for-each-ref and pretty formats (and code) as far as possible
> - leverage that for the list modes of branch and tag
>
> That would allow everyone to get their favourite listing, just like for
> logs. Otherwise it would be very difficult to agree on *the* proper
> format for an extended branch or tag list.
>
> Michael
>
>
> [*] I know I'm a sinner, too.
