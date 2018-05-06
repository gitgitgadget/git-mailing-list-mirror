Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8380200B9
	for <e@80x24.org>; Sun,  6 May 2018 00:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeEFAZg (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 20:25:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62317 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbeEFAZf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 20:25:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E868FEFF3A;
        Sat,  5 May 2018 20:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=jsE6MQ5mNheXIYgjAQ67nckTMLw=; b=rk9WWUa
        w3nhqsZnvrGrUC9tuU6k+HUtc84TC8LtoAw98eJGBXB31EcZdxRzKOeNE6RIKG8P
        Bmf5X0g5Gq64wJMopsQIiorKFUDtO957UugVynFAruXny1Bgr+KXrRRnvZQXPjvk
        IPX9s2MCMGmQRoeF0+3rY0rUB4gyx6nkE5us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=VceFl/eCUZKMT8mTinYGaBjsSKmvIdy5w
        25fjlrJw4RC5UvDDzVxPT1MR3bIbasMH38GOSR1DUzeHXg1Il0CDPtT2b724uPc0
        K4dRg28xZIAXf0s5JqcryHY1hZLbtnHSdNOYj5dzFgV1G/YHHxD5dF8a/3x4RW+4
        NCsuo1YRRc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E06D3EFF39;
        Sat,  5 May 2018 20:25:34 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42927EFF38;
        Sat,  5 May 2018 20:25:34 -0400 (EDT)
Date:   Sat, 5 May 2018 20:25:32 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
Message-ID: <20180506002532.GS26695@zaya.teonanacatl.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: FDF9F94C-50C3-11E8-A3E9-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin wrote:
> On Sat, 5 May 2018, Jeff King wrote:
>> One minor point about the name: will it become annoying as a tab
>> completion conflict with git-branch?
> 
> I did mention this in the commit message of 18/18:
> 
>     Without this patch, we would only complete the `branch-diff` part but
>     not the options and other arguments.
> 
>     This of itself may already be slightly disruptive for well-trained
>     fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
>     `git branch origin/master`, as we now no longer automatically append a
>     space after completing `git branch`: this is now ambiguous.
> 
>> It feels really petty complaining about the name, but I just want to
>> raise the point, since it will never be easier to change than right now.
> 
> I do hear you. Especially since I hate `git cherry` every single time that
> I try to tab-complete `git cherry-pick`.
> 
>> (And no, I don't really have another name in mind; I'm just wondering if
>> "subset" names like this might be a mild annoyance in the long run).
> 
> They totally are, and if you can come up with a better name, I am really
> interested in changing it before this hits `next`, even.

Would it be possible and reasonable to teach 'git branch' to
call this as a subcommand, i.e. as 'git branch diff'?  Then
the completion wouldn't offer git branch-diff.

Users could still call it directly if they wanted, though
I'd tend to think that should be discouraged and have it
treated as an implementation detail that it's a separate
binary.

We have a number of commands which take subcommands this way
(bundle, bisect, notes, submodule, and stash come to mind).
I don't know if any are used with and without a subcommand,
but it doesn't seem too strange from a UI point of view, to
me.

(I don't know if it's coincidental that of the existing
commands I noted above, 3 of the 5 are currently implemented
as shell scripts.  But they've all seen at least some work
toward converting them to C, I believe).

The idea might be gross and/or unreasonable from an
implementation or UI view.  I'm not sure, but I thought I
would toss the idea out.

This wouldn't work for git cherry{,-pick} where you wouldn't
consider 'git cherry pick' as related to 'git cherry'
though.

We also have this with git show{,-branch} and some others.
It's a mild annoyance, but muscle memory adapts eventually.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A budget is just a method of worrying before you spend money, as well
as afterward.

