Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06088C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83C42070A
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 12:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLVMrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 07:47:10 -0500
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:57304
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLVMrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 07:47:09 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1ij0dY-000ilw-0e
        for git@vger.kernel.org; Sun, 22 Dec 2019 13:47:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 2/2] contrib/git-jump: add mode commit
Date:   Sun, 22 Dec 2019 13:47:00 +0100
Message-ID: <94d850de-cb73-e124-bced-4dc3f6b970a6@drbeat.li>
References: <20191221113846.169538-1-dev+git@drbeat.li>
 <20191221113846.169538-2-dev+git@drbeat.li>
 <20191221192348.GA3339249@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
Cc:     git@vger.kernel.org
In-Reply-To: <20191221192348.GA3339249@coredump.intra.peff.net>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20191222124700.IMMzESxmZDvlpr7GAmGcKiprQeTTUFHyudEnwAb03E8@z>

On 21.12.19 20:23, Jeff King wrote:
> On Sat, Dec 21, 2019 at 12:38:46PM +0100, Beat Bolli wrote:
> 
>> After committing, I often want to return to the place of the latest
>> change to continue my work. Add the new mode "commit" which does exactly
>> this.
> 
> That's one of my primary uses for git-jump, too. But you can already do
> that by jumping to the diff of HEAD^. Which has the additional advantage
> that it's a diff against the working tree. So if you did a partial
> commit, the diff will include any leftover changes.
> 
> So I'm not opposed to this patch per se, given that it's not very many
> lines. But I'm not sure I see much advantage over "git jump diff HEAD^".
> It's slightly less typing, but I already alias "git jump diff" since
> it's so long.
> 
>> Optional arguments are given to the "git show" call. So it's possible to
>> jump to changes of other commits than HEAD.
> 
> This can also be done with "git jump diff $commit^ $commit". However,
> I've found that jumping based on older diffs is mostly useless, because
> the line numbers at $commit and those in the working tree don't always
> match up (and inherently you're always jumping in the working tree
> copy).

Thanks, I didn't realize that git diff could just as well be used to
generate the diff of an arbitrary commit. I have added this new shortcut
to my bash aliases:

    gjc() { git jump diff ${1:-HEAD}^ ${1:-HEAD}; }


Cheers, Beat

