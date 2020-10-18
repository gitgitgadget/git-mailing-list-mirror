Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FEEC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3744420773
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 16:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0DDSCc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgJRQBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 12:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgJRQBB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 12:01:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D0AC061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 09:01:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b127so10280137wmb.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WHLJR4L00JxKP4wj8jNCM1sixW34RM/5Z1+o43KYNF8=;
        b=p0DDSCc4tDX7Znixp3L+QqClZ6wBA3lydOxvD390psE7jGpBARQPRW8DFaAtr9Qo2m
         icJGjcjscksiuX+K5a+1kFFqCu8bDoNJwCZvpz2ZQSTYK0rN1f5Jai9nh6Mqkz8icrhY
         4PHZSx5dkFpNa3hoWs6A9i5iBiQZarMHCIQ794yKvnWzOSJ3wqzTXvgThDKCXk+e1iOr
         Cj/psYSR+6RjB/L0A/0pi3gzkjEyyUXe6PHtdPeo2Nps/zC5H1nEr6pwVu8JI8h0ZBw3
         7upGUUoIoAQklTSZG7xMIzbc0vO7ZuB2hVSSgyHrJp3m5wOmQ35CW6sRwV2WojWI/f3+
         /qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WHLJR4L00JxKP4wj8jNCM1sixW34RM/5Z1+o43KYNF8=;
        b=cvfjFkQtcjm4iiHXsjEMZM/PjSxoFjvqH8hjPM7myH7sFqoLSXuHVA/48/U/hI1Y5w
         /M8xEbO0EFtsQ4lyi8M0FsOjP/rlkCLw2hhqJuJmTGGf4X2jax/kgE0by+ojOfM9sLh5
         4wwC4Mba0sJmxyDpOdsGFRwdxMqg4uydOe9HU+7G6KkUQBAk6o8sJ9db++4qm/Uor0f1
         oEkkpw+3kQB+TbIR8iJjjISijjvS+TsAQD6sLDKOCzBzQ+3+siEXOeBUXC/ZM9Y5JB/F
         V/DQbVZFcRQyiUN93vpKdY5hk1vcrDc4YQ1GQqFzT9u02p0KseTGklEM2Pl3DgGMFuVX
         ysUg==
X-Gm-Message-State: AOAM531o1rp3TXkdTThXl1uXEbikvKLkvTqglICLiGTeOcmmQLI+AkSF
        f1OvW22R3sJ4h/Nws9diTAw=
X-Google-Smtp-Source: ABdhPJx8sqCKyLNE+6hj9f3/JQ+1Bj3331nLR4WNItIe3I4k+LXqGR1FA1KdWduPK7c6Q+9Tz0bRNw==
X-Received: by 2002:a1c:a5c4:: with SMTP id o187mr13439423wme.171.1603036859503;
        Sun, 18 Oct 2020 09:00:59 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id e25sm14774173wra.71.2020.10.18.09.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 09:00:58 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Why does git diff-index show intent-to-add file as "Added"?
To:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20201017162111.gvisfz2daqvhnjmb@yadavpratyush.com>
 <xmqqimb88v35.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <55ed2ace-5dfd-55f9-d9a6-da71ff795716@gmail.com>
Date:   Sun, 18 Oct 2020 17:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqimb88v35.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/10/2020 21:18, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
>> In this case, running diff-files gives:
>>
>>    :000000 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 A	foo
> 
> Yes, it says "when comparing the index and the working tree, working
> tree side has it, and the index side does not, so it is an addition".
> 
> Of course, if it is truly a new file that the index does not even
> know about, we'd stay silent, but a path that are marked with i-t-a
> bit is what the user told us to keey an eye on, so that is what you
> would get.
> 
>> Running diff-index gives:
>>
>>    :000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A	foo
> 
> If this is "diff-index HEAD", then I think it is expected.  "when
> comparing the HEAD and the working tree, working tree side has it,
> and the tree side does not, so it is an addition."  Exactly the same
> story as "diff-files".
> 
> What should happen in "diff-index --cached HEAD", I offhand do not
> know.  "diff-index --cached HEAD" is a request to compare two trees,
> i.e. the tree that _would_ be produced if you wrote the index out as
> a tree (i.e. "git write-tree") right now, and the tree of HEAD.  So
> I think it may be sensible for the command to behave as if the i-t-a
> path does not even exist in the index when it is run with "--cached";
> I may be missing some subtleties that require us to do something
> different, but that is what I would think.

If a user runs `add -N file` then if they run `git reset -p` (which runs 
`git diff-index --cached HEAD`) it will ask them if they want to remove 
`file` from the index. If `diff-index --cached` hid i-t-a entries we'd 
lose that or have to get the i-t-a entries another way. Having said that 
it does seem strange for `diff-index --cached` to be showing i-t-a 
entries. Perhaps `diff-index --cached` should default to 
--ita-invisible-in-index?

Best Wishes

Phillip

