Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F4C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiADM7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:59:37 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:22496 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbiADM7g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:59:36 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n4jPa-0005N3-Ea; Tue, 04 Jan 2022 12:59:35 +0000
Message-ID: <1240d0cd-230d-8a80-2250-37336b834834@iee.email>
Date:   Tue, 4 Jan 2022 12:59:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [BUG] git pull --rebase ignores rebase.autostash config when
 fast-forwarding
Content-Language: en-GB
To:     Tilman Vogel <tilman.vogel@web.de>, git@vger.kernel.org
References: <9749fa2c-b08d-c08b-ce43-041d13852d02@web.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <9749fa2c-b08d-c08b-ce43-041d13852d02@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01/2022 18:08, Tilman Vogel wrote:
> Hi git-people,
>
> I ran into strange behavior when having rebase.autostash enabled and
> doing a git pull --rebase:
>
>> git config rebase.autostash true
>> git pull --rebase
> Updating cd9ff8a..f3c9840
> error: Your local changes to the following files would be overwritten by
> merge:
>         content
> Please commit your changes or stash them before you merge.
> Aborting
>
> Confusingly, this fixes the issue:
>
>> git config merge.autostash true
>> git pull --rebase
> Updating cd9ff8a..f3c9840
> Created autostash: c615fda
> Fast-forward
>  content | 1 +
>  1 file changed, 1 insertion(+)
> Applied autostash.
>
> Leaving me wonder why merge config options fix rebase behavior.
>
> So, in order to make it easier to check the problem, I added some
> test-cases to the git test-suite. Please see the attached patch.
>
> Or here:
> https://github.com/tvogel/git/commit/bc941f9357518a34cfa11788dfb8e7fa7f711705
>
> I did not try to find the root-cause as I am not experienced with the
> code-base but if there are questions, let me know.

Which version are you running?

There was a problem in 2.33.1 as per thread discussion:
 https://lore.kernel.org/git/YYFEE%2F2g3SiM04zx@hades.panopticon/
 (I'd searched the logs for ".autostash true")

Does that provide any guidance?
--
Philip

