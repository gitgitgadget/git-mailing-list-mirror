Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0834C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 08:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC1D61CDF
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 08:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGHIXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 04:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhGHIXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 04:23:05 -0400
Received: from mx4.uni-regensburg.de (mx4.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:4:4e7a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851CAC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 01:20:23 -0700 (PDT)
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id E25C46000051
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 10:20:19 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id C601E600004E
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 10:20:19 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 08 Jul 2021 10:20:19 +0200
Message-Id: <60E6B541020000A1000423C8@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Thu, 08 Jul 2021 10:20:17 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <l.s.r@web.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Antw: [EXT] Re: bug in "git fsck"?
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 <xmqqczs0popg.fsf@gitster.g> <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
 <60E2B7FB020000A1000422A0@gwsmtp.uni-regensburg.de>
 <77655a4e-8c39-5ccc-71af-d2d8684bf208@web.de>
 <60E40275020000A1000422F7@gwsmtp.uni-regensburg.de>
 <fcfd0401-df5b-15ec-29c4-74d2903274cd@web.de>
In-Reply-To: <fcfd0401-df5b-15ec-29c4-74d2903274cd@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> René Scharfe <l.s.r@web.de> schrieb am 06.07.2021 um 16:25 in Nachricht
<fcfd0401-df5b-15ec-29c4-74d2903274cd@web.de>:
> Am 06.07.21 um 09:12 schrieb Ulrich Windl:
>>>>> René Scharfe <l.s.r@web.de> schrieb am 05.07.2021 um 16:44 in Nachricht
>> <77655a4e-8c39-5ccc-71af-d2d8684bf208@web.de>:
>>> Am 05.07.21 um 09:42 schrieb Ulrich Windl:
>>>>> You *can* overwrite them using "git branch --force foo" and then
>>>>> "git branch -d foo" works.
>>>>
>>>> Would it be OK to force the branch to any commit (e.g.: "master"),
relying
>>
>>> on
>>>> the fact that any reference (read: "master") to that commit will prevent
>>> actual
>>>> removal of the commit?
>>>
>>> Yes, any valid commit would do.  This turns dangling branches into
>>> normal delete-able ones.  Other branches are unaffected.
>>
>> OK, but either it does not work, or I did not understand what to do:
>>
>>> git branch --force bitmap-generic
>> fatal: Not a valid object name: 'bitmap-generic'.
>>> git fsck
>> Checking object directories: 100% (256/256), done.
>> Checking objects: 100% (173/173), done.
>> notice: HEAD points to an unborn branch (bitmap-generic)
>> dangling blob 0458be7cf03f35be365c819afe0104ff3c178ca0
>> dangling blob 3000d29f0a652f3f7ed25572cac9969b90adeca5
>> dangling commit 90e8531086d3efaeefdf6c8d39b6782e49dd2a0d
>> dangling commit b598195f859106662bde746f391a7df9162231e9
>> dangling tree fb4866ab5cc2f0c34a63334b90550ef7199a2098
>> ...
> 
> First: Please make backups.
> 
> Here's what works for me.  First reproducing the error:
> 
>    $ echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa >.git/refs/heads/broken

Hi!

Thanks for the hints. But first the problem is in the repository, not in the
workspace, so I don't have a ".git/refs/", but "refs/".
The other thing is that the only "refs" that is there is "master"; the one
with the problem isn't there.

So I tried:
% echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa >refs/heads/bitmap-generic
Then "git branch" indicated that "bitmap-generic" would be the current
branch:
% cat HEAD
ref: refs/heads/bitmap-generic

Next I brute-force edited HEAD, repacing bitmap-generic with master.

Still, that would not work:
% git branch --delete --force bitmap-generic
error: Couldn't look up commit object for 'refs/heads/bitmap-generic'

But the next command worked:
% git branch --force bitmap-generic

Finally, this also worked:
% git branch --delete bitmap-generic
Deleted branch bitmap-generic (was 03aa7ca).

Most importantly "git fsck" did no longer complain.

Thanks for the help! Do you want to provide an answer to stackexchange, or may
I use your procedure to write an answer?

Regards,
Ulrich

>    $ git branch --delete --force broken
>    error: Couldn't look up commit object for 'refs/heads/broken'
> 
> Now I have a broken branch that I cannot delete.  We should be on the
> same page now.
> 
>    $ git branch
>      broken
>    * master
> 
> So I'm on master, a valid branch.
> 
>    $ git branch --force broken
> 
> Now the broken branch is overwritten and points to the same commit as
> master.
> 
>    $ git branch --delete broken
>    Deleted branch broken (was 83d267b).
> 
> And now it's gone.
> 
> René



