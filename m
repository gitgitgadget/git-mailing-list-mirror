Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8918EC4332B
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4DD222F9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgL1Wzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:38 -0500
Received: from ciao.gmane.io ([116.202.254.214]:46056 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbgL1URr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 15:17:47 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1ktywz-0003gz-Sx
        for git@vger.kernel.org; Mon, 28 Dec 2020 21:17:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [BUG] Destructive access to an "objects/info/alternates" repository
Date:   Mon, 28 Dec 2020 15:17:01 -0500
Message-ID: <jwvlfdhbsbs.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
        <jwv8s9hd9cg.fsf-monnier+Inbox@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:QcpmuPIrCUKX6gE18yoQHQWwX+g=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>     git clone --reference ~otheruser/nongnu
>>
>> This doesn't appear to be a proper command, because it's missing actual
>> repository to clone, only the repository to use as reference. This is the
>> proper usage of --reference:
>>
>> git clone --reference ~/some/repo https://some/remote/repo.git
>
> Indeed, thanks:
>
> git clone --reference ~otheruser/nongnu https://git.savannah.gnu.org/r/emacs/nongnu.git
>
>> Without knowing exactly what you did, it's hard to tell what went wrong. You
>> can try running "find nongnu" to see if what you think is your own checkout is
>> actually a symlink or some combination thereof.
>
> Not sure what you mean by that.
>
> In any case, I just reproduced the problem:

FWIW, I just tried it with

    git clone --shared ~otheruser/nongnu

and got the same result.
I also tried with another repository, still with the same result (tho
different pack.idx names, of course).


        Stefan

