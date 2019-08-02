Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3ED1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 20:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406896AbfHBUAT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 16:00:19 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42093 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403882AbfHBUAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 16:00:19 -0400
Received: from localhost.localdomain (unknown [1.186.12.38])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 74623200006;
        Fri,  2 Aug 2019 20:00:15 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
 <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet>
 <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1908021414530.46@tvgsbejvaqbjf.bet>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <a68f09be-949f-b16b-a585-9ca2a1991a4f@yadavpratyush.com>
Date:   Sat, 3 Aug 2019 01:30:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1908021414530.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/19 6:09 PM, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 2 Aug 2019, Pratyush Yadav wrote:
> 
>> On 8/1/19 1:12 AM, Johannes Schindelin wrote:
>>>
>>> I would be _extremely_ cautious to base an argument on one
>>> particular setup, using on particular hardware with one particular
>>> OS and one particular repository.
>>>
>>
>> Agreed. That's why I asked for benchmarks from other people.
>> Unfortunately, no one replied.
> 
> What stops _you_ from performing more tests yourself? There are tons of
> real-world repositories out there, we even talk about options for large
> repositories to test with in Git for Windows' Contributing Guidelines:
> https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#performance-tests

I thought the point was to not base all data off a single setup?

Anyway, I'll see if I can manage to clone the Chromium source (I have 
flaky internet), and I'll run some tests.

Aside: I looked into the resumeable clones discussion in the mailing 
list archives. I don't think the feature made it through. But the work 
seems too complicated for me to look into reviving it. Maybe some other day.

> 
>> I am worried about exactly this problem that other users will have
>> performance problems. I usually reserve judgment till I see some
>> actual benchmarks, but since in this case we aren't getting any, it is
>> probably better to err on the side of caution.
> 
> Well, you proposed it without testing it first e.g. on Kotlin or even
> Linux.  Personally, I would have chosen Chromium, as it is a pretty big
> one.

When I first proposed the patch, I thought the git repo was large 
enough. And testing on it was pretty fast for me.

> 
> Maybe you want to do that now.
> 
>>> When it comes to repositories that are worked on actively, git.git is
>>> not actually a representative example, it is way smaller than what users
>>> deal with.
>>
>> Out of curiosity, what would you consider large enough? The Linux kernel
>> (855,753 commits as of writing this)?
> 
> As your patch is about refreshing the Git GUI, the number of Git commits
> is irrelevant. The number of worktree files is relevant.
> 
> Unfortunately, you cannot search for this dimension on GitHub, but you
> can search for "repository size", which is at least loosely correlated:
> 
> https://github.com/search?utf8=%E2%9C%93&q=size%3A%3E5000000&type=Repositories&ref=advsearch&l=&l=
> 
> Personally, I would probably have chosen either of these, for testing:
> 
> * https://github.com/chromium/chromium
> * https://github.com/WebKit/webkit
> * https://github.com/raspberrypi/firmware
> * https://github.com/MicrosoftDocs/azure-docs
> * https://github.com/facebookresearch/FAIR-Play
> 
>>> At this point, I am gently inclined against the presented approach, in
>>> particular given that even context menus reportedly trigger the re-scan
>>> (which I suspect might actually be a Linux-only issue, as context menus
>>> are top-level windows on X11, at least if I remember correctly, and I
>>> also seem to remember that they are dependent windows on Aqua and Win32,
>>> just to add yet another argument against overfitting considerations onto
>>> a single, specific setup).
>>
>> All right, the patch in its current state can't fly. So what is the correct
>> way to do this? I see the following options:
>>
>> 1. Add this as an option that is disabled by default, but people who don't
>> mind it can enable it. This is the easiest to implement. But I leave it to you
>> and Junio (and anyone else who wants to pitch in :)) to decide if it is a good
>> idea.
> 
> That would probably be much easier to get accepted.
> 
>> 2. Watch all files for changes. Atom does this for their git gui [0]. We can
>> probably use watchman [1] for this, but this adds another external dependency.
> 
> I am currently looking at watchman, and it seems that it has its own
> performance issues in big repositories (for which it is actually most
> relevant). Besides, Windows support is kinda flaky, so I would rule this
> out (Git is supported on many more platforms than watchman supports).
> 
> Besides, what your patch wants to do is not to know when things have
> changed. Your patch wants to refresh the UI at opportune moments, and it
> is unclear how watchman could help decide when to refresh.
>

But we do want to know when things have changed, because that's when we 
are supposed to refresh. The most opportune moment to refresh is right 
when some file changes. The user is very likely to not be looking at git 
gui at that point because they'd probably in their editor, so we get to 
refresh in the background. Watchman lets us do this, but it is just an 
example. Any cross-platform method of watching a directory tree works 
just as well.

Maybe we can use Watchdog [0], which might be better (disclaimer: I 
haven't actually looked into watchdog, I'm just saying it maybe is 
better). It is an added dependency regardless.

A Linux-only alternative is tcl-inotify [1], but I don't know if you 
folks will like a platform dependent solution.

>> 3. Leave this feature out. I of course don't like this option very much, and
>> will probably have to run a fork, but if it is better for the project, it is
>> better for the project.
> 
> That would indeed be the safest.
> 
> I wonder, however, whether you can think of a better method to figure
> out when to auto-refresh. Focus seems to be a low-hanging fruit, but as
> you noticed it is not very accurate. Maybe if you combine it with a
> timeout? Or maybe you can detect idle time in Tcl/Tk?
> 

Hm, I don't see a better alternative than file system watches. Timeouts 
are a heuristic that can potentially be problematic. If you do a refresh 
too frequently, you hog up the user's resources for little benefit. You 
don't refresh frequently enough, then sometimes the user sees an updated 
view, sometimes a not-updated view. This inconsistency, if not fine 
tuned properly, can prove detrimental to UX.

If you are fine with the above inconsistency, refreshing every few 
seconds shouldn't be too difficult.

[0] https://pythonhosted.org/watchdog/
[1] http://tcl-inotify.sourceforge.net/

-- 
Regards,
Pratyush Yadav
