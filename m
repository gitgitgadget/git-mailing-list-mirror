Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B90211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 17:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfAKRYN (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 12:24:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39467 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731333AbfAKRYN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 12:24:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so3103576wmi.4
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 09:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tdg7UoFqkdaZp9TqbvzAE8uaPuWyiRN1pUIf7IPHM3U=;
        b=M26easlSrCMroNQRGCfguCaFAM2Xa/81D/rd95K3/mHGpupJdaofudvFZWup0P3YPS
         ONjdl6QkFfYbrq7ZJN8+08irzJd8vhdZt+J5/jxEQhwsCfaLZeYviVdSCngxRwXeM0on
         3gEmhJjKO9uVJDC6HuPAA5NklpV1Xzp2/2cAwdQzO1WbqxCdyI82idQfpkyAvz7dXeYR
         8DzNwsMtXo46lJj50g0cJnpy72kRL5IdLDss35zfapTD0Cces5Oy6wRai42bslkRYo5a
         loYo/3kZLzQ2IgdsgLzEsodDvmIsTRQ6uam8WZfdDgtz2B+b/3AUfS0je538NBiQbxA4
         puNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tdg7UoFqkdaZp9TqbvzAE8uaPuWyiRN1pUIf7IPHM3U=;
        b=H7WAoIb89IMxeq3DRRCM6O3Ryk4Rsojjxr0f/+G/XU8JOWMQeby9XFxj+XEURXK2SO
         5K0psjSQ6jRA9LXJcTvYYM3ZAElQ/ZBB8JVBIR/rvKAIxqMKZgEXruTGOLJpDsAaJ/1G
         oQakkqgV5HYeIX9j8HcPjAzlycTPU9WsuyrHmM3vQdesQS6nDSWmL58RTUJPRwQ5gfN/
         7gZWewyzfruS8c7VkCHMbBS3pzfbWQu5qIom8SA87bYC5sMGPcSov22TFSO5kYFv03MJ
         4aglnHwJWXxrMX0PIP1rA8mc7Kzkl6Grmj5nd3s4AR229blCb04K8qyBz0VZLeCqL0yJ
         T3xw==
X-Gm-Message-State: AJcUukfDYpO+NrFuDzVS/ywbmHr4edXErWdI/cI38o7BGrzOrRSr9/+r
        Dt9s1vm5dC8DTEnPA14Yl88=
X-Google-Smtp-Source: ALg8bN6bK12xQGyZSriH/mpO/GTsKaYJuVCEBqhOge/NHYrUDt/Y1o3j7zzseLJp6nnKtWo8d0fK3g==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr3058394wmd.2.1547227451041;
        Fri, 11 Jan 2019 09:24:11 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g129sm19979541wmf.39.2019.01.11.09.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:24:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] gc/repack: release packs when needed
References: <pull.95.git.gitgitgadget@gmail.com>
        <7eee3d107927b30bd3e1ec422e833111627252ce.1544911438.git.gitgitgadget@gmail.com>
        <xmqqmuo81b2n.fsf@gitster-ct.c.googlers.com>
        <20190111161021.GE16754@sigill.intra.peff.net>
Date:   Fri, 11 Jan 2019 09:24:08 -0800
In-Reply-To: <20190111161021.GE16754@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Jan 2019 11:10:22 -0500")
Message-ID: <xmqqlg3ryuo7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 10, 2019 at 01:01:36PM -0800, Junio C Hamano wrote:
>
>> > diff --git a/builtin/gc.c b/builtin/gc.c
>> > index 871a56f1c5..df90fd7f51 100644
>> > --- a/builtin/gc.c
>> > +++ b/builtin/gc.c
>> > @@ -659,8 +659,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>> >  
>> >  	report_garbage = report_pack_garbage;
>> >  	reprepare_packed_git(the_repository);
>> > -	if (pack_garbage.nr > 0)
>> > +	if (pack_garbage.nr > 0) {
>> > +		close_all_packs(the_repository->objects);
>> >  		clean_pack_garbage();
>> > +	}
>> 
>> Closing before removing does make sense, but wouldn't we want to
>> move reprepare_packed_git() after clean_pack_garbage() while at it?
>> After all, the logical sequence is that we used the current set of
>> packs to figure out whihch ones are garbage, then now we are about
>> to discard.  We close the packs in the current set (i.e. the fix
>> made in this patch), discard the garbage packs.  It would make sense
>> to start using the new set (i.e. "reprepare") after all that is
>> done, no?  Especially, given that the next step (write-commit-graph)
>> still wants to read quite a lot of data from now the latest set of
>> packfiles...
>
> I agree that your suggested ordering makes more sense, but I don't think
> it matters in practice with the current code. reprepare_packed_git()
> never throws away old pack entries (and if they're mmap'd, we might even
> continue to use them). So the end result is the same either way.

Yeah, it would not make difference to the machine.  I was trying to
be more helpful to human readers.

In any case, this patch from Dec 15 last year is where my backlog
sweeping is at right now X-<.
