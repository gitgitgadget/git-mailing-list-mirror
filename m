Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B21C433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EC720EDD
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 09:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNswD77H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGNJwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNJwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 05:52:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798CDC061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 02:52:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so4139336wmg.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nN1udJo9KHlWC8HNXlpbUN1YSVqmRLmyJ0NE4QPgbVc=;
        b=kNswD77HIDW3A8mXb2LWLaTH+fymYRU+czAyGQvv9jKWtxvcMody1pyy1cxsEQbqKb
         WfThxzo1kNGfGbWxhpgUJayaehKQeMk9Q0XDXx+qpYP12g3NaeuN9BYO+lqeUusnWKVI
         U49yt950CGqVGy0PAHUscC2+OslYmmvvk4oGk39OoZsfkY147Li+8hDQ8T9Vy3iieX5k
         ygSiB+1KJ30FGafw0qoFXLN3sIxjQlm/zaPrPh1Wg9VdfbQj/l6eJuwRvMHRaordAZFW
         AwR5fz4yKqjAzGoSdqFlJJbO/RaloIHqk7vvkvSSGNYqcmErNSTUyMZ1nDD/MTDWEo4R
         kDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nN1udJo9KHlWC8HNXlpbUN1YSVqmRLmyJ0NE4QPgbVc=;
        b=mZ+LHMHHOOgazZM0QiiP5L/nR/DR4ZuimXWMgYG9l5ie44vFM/amGaCIUwvDrAIFKq
         JH2zrkZehjig8m8kmWLkE6tl+0mfxjVIQqUSxWaVZa2rjiRTqRA0APkIRn9iSlXpAHkl
         r/xoJlJ2f/PJxOzy8XlY9LugY+mSPl7FuPGu5Q5lJZAV+G+MgvcdtFl0rTz48J7GaQXt
         2vjTZl+Wda6mZoHxlQnpBcj5+t4E5eOzud6Kzp+k4ICCIIDBi2pDe3bjs6vy0ZEn6Ifu
         zk6hQMObsYjYeA8r3hXa4jIf0DTYSfjGMiZ2YbAEXo89vjJiWgV7FSX4tszBMv4inMz4
         isPA==
X-Gm-Message-State: AOAM531Koiz0D0AOg+zgS0HYGboc/ZHFlSHCF1/vlZGTJc2xU9lBMrj4
        XBgEYQ9pa7+nfaELlBmwPOM=
X-Google-Smtp-Source: ABdhPJw92NVAmO20pRb9SuySCkd02QBBQt0gugOCvho1Q33RrFNlqN801xMPguXlRPowxrf/j6x2/Q==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr3267171wmh.108.1594720328229;
        Tue, 14 Jul 2020 02:52:08 -0700 (PDT)
Received: from [192.168.1.240] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id c136sm3760142wmd.10.2020.07.14.02.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 02:52:07 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] should `git rebase --keep-base` imply
 `--reapply-cherry-picks` ?
To:     Denton Liu <liu.denton@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
References: <0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com>
 <20200714031017.GA15143@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9c6dff59-b204-1ace-e0aa-0885dd502214@gmail.com>
Date:   Tue, 14 Jul 2020 10:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714031017.GA15143@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 14/07/2020 04:10, Denton Liu wrote:
> Hi Philippe,
> 
> On Mon, Jul 13, 2020 at 10:44:06PM -0400, Philippe Blain wrote:
>> Hello,
>>
>> I learned today that doing `git rebase --keep-base master`
>> will drop commits that were cherry-picked from master to the current branch.
>> I was simply doing a code clean up on my feature branch (the full command was
>> `git rebase -i --keep-base master`), and this kind of confused me for a moment.
> 
> Glad I'm not the only one using this feature :)
> 
>> Is this a sane default ? I understand that it is a good default when we are rebasing
>> *on top* of master, but here I'm just doing some squashing and fixup's and I did not
>> want the commit I had cherry-picked from master to disappear (yet). In fact, because it
>> was dropped, it created a modify/delete conflict because in a subsequent commit
>> in my feature branch I'm modifying files that are added in the commit I cherry-picked.
> 
> So if I'm not mistaken, if we have the following graph
> 
> 	A - B - C - D (master)
> 	     \
> 	       - C' - D (feature)
> 
> and we do `git rebase --keep-base master` from feature, C' will be
> dropped? Indeed, I am surprised by how this interacts with the
> default setting of --reapply-cherry-picks.

To me the question is why are we looking at the upstream commits at all 
with `--keep-base`? I had expected `rebase --keep-base` to be the same 
as `rebase $(git merge-base [--fork-point] @{upstream} HEAD)` but 
looking at the code it seems to be `rebase --onto $(git merge-base 
@{upstream} HEAD) @{upstream}`. I didn't really follow the development 
of this feature - is there a reason we don't just use the merge-base as 
the upstream commit?

Best Wishes

Phillip

> 
>> How would a change that made '--reapply-cherry-picks' be the default when using 'keep-base'
>> be received ?
> 
> I'm somewhat surprised that --no-reapply-cherry-picks is the default. I
> would argue that it _shouldn't_ be the default at all. It's an
> optimisation for when no --onto or --keep-base are specified but it
> definitely can cause problems otherwise, as we've seen.
> 
> I think I would argue for the following in decreasing order of
> preference:
> 
> 	1. Make --no-reapply-cherry-picks the default in all cases.
> 	   (Those who need the optimisation can enable it manually and
> 	   we can add a configuration option for it.)
> 
> 	2. Make --no-reapply-cherry-picks only active if no --onto or
> 	   --keep-base are given (--keep-base is a special case of --onto
> 	   so we only have to handle it in one place).
> 
>> Tangential question: in any case, would it make sense to still add the "dropped because
>> already upstream" commits to the todo list, in the case of an interactive rebase ?
>> (maybe commented out, or listed as 'drop' with some kind of comment saying those
>> are dropped because they appear textually upstream?)
> 
> That would make sense to me. I don't have a preference between either.
> 
> Thanks,
> 
> Denton
> 
>> Cheers,
>> Philippe.
>> P.S. I CC'd those who were involved with the 'keep-base' patch or the 'reapply-cherry-picks' patch.
