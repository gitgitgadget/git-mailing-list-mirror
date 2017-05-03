Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C627207F8
	for <e@80x24.org>; Wed,  3 May 2017 12:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdECM3r convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 May 2017 08:29:47 -0400
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:37593 "EHLO
        rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbdECM3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 08:29:46 -0400
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 2F05073492
        for <git@vger.kernel.org>; Wed,  3 May 2017 14:29:44 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id 0F2CD73388
        for <git@vger.kernel.org>; Wed,  3 May 2017 14:29:44 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Wed, 03 May 2017 14:29:43 +0200
Message-Id: <5909CD36020000A100025CC7@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 14.2.2 
Date:   Wed, 03 May 2017 14:29:42 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Samuel Lijin" <sxlijin@gmail.com>, <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: Terrible bad performance for it blame --date=iso -C
 -C master -- <file>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
 <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
 <CAJZjrdUt+=oLt0cDcs2+bJMCFR4h8UUSFmZkx6-1menz4haPig@mail.gmail.com>
 <xmqqfugof4zb.fsf@gitster.mtv.corp.google.com>
 <CAJZjrdVZ7gTZvm=CcG7pUPWtXjsMsHgyMRiE8xoXm=bZ4j6FEQ@mail.gmail.com>
In-Reply-To: <CAJZjrdVZ7gTZvm=CcG7pUPWtXjsMsHgyMRiE8xoXm=bZ4j6FEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Samuel Lijin <sxlijin@gmail.com> schrieb am 03.05.2017 um 09:12 in Nachricht
<CAJZjrdVZ7gTZvm=CcG7pUPWtXjsMsHgyMRiE8xoXm=bZ4j6FEQ@mail.gmail.com>:
> On Mon, May 1, 2017 at 7:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Samuel Lijin <sxlijin@gmail.com> writes:
>>
>>> On Fri, Mar 31, 2017 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> It might not be a bad idea to teach "blame" not to pay attention to
>>>> any path that is marked as "-diff" (e.g. binary files) when trying
>>>> to see if remaining contents appeared by borrowing from them.  We do
>>>> not have that heuristics (yet).
>>>
>>> Could you elaborate on this? Do you mean to tell diffcore-rename to
>>> ignore diff_filespec objects if they're binary?
>>
>> No and yes ;-).  I do not think it is a good idea to unconditionally
>> ignore binary in diffcore-rename.
>>
>> But when we know that the rename detection is called from inside
>> blame.c, where by definition we would be digging line-oriented
>> contents, there is no point checking if the contents we are looking
>> for came from an existing binary file.
> 
> A followup thought: perhaps it would make sense for blame.c rename
> detection to only consider files with the same extension?

As traditionally file type and file name extension had little to do with each other in UNIX, I thing that would not be a good solution (to assume the opposite). I also know that Git does not care too much about hierarchies also, but my idea was so find candidates "nearby", i.e. look in the subdirectories of the first level and in the parent directory; then, if needed, widen the radius of the search...

Regards,
Ulrich





