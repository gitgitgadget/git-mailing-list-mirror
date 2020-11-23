Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D83C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C552920773
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrpiOlL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgKWOy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 09:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbgKWOy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 09:54:27 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D3C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 06:54:27 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so13519723qts.5
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 06:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9fHd65qkvEBezqvL17xxRq+EojtZmfo3ENmDPBI0kgs=;
        b=jrpiOlL+QxotZrJyX3KWhj44wcDQwKihKasT3VYvUhGL5Ih1VIZLsvmAZgGxPwZS5X
         Zlhg+/zGd+oABf74AcxmsBnnopfQTvA5rpFZx+PnPb68dmiNPaAM+wUYOa+a7mzmBvNM
         Ar+NEu6qs5aQOjplJL/BgKvx4ZspLS1yNUoW0eXGoY0HKVfrTHjG6A2qlg+qk6fFzxPN
         fgZPiYyemgFDZL2sXUZVOqUgDfjqJtyUAf99XqDwsgUd2O0hEU5VyRjVffP18K9Wnz7I
         MK/penm1yGajKAjEH3WG/VoPy2ilGCgfWm9KKxcEXbPDMkBP2Leh4bQSZ7j62cynTLBh
         hcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9fHd65qkvEBezqvL17xxRq+EojtZmfo3ENmDPBI0kgs=;
        b=OsDIw6GEA14KHBXzUFiQ1p96m7ceZxEp5f2DrsQXDcj8Rnc0E9vwEi9Pq3bpbn+ag9
         os9MEFiVTaBhRqK0kr+ovmPPOT/YhdbSzmPitaJNzmHtZpmp+8NWDrVoDOuw4+OmkAFB
         Upepw5Pj3pWIDv8yIxmyBS9e/Yc5BHCj5TV+2GmFnlGb8u97HTq9cPbGACZDNHxoqSwi
         RJ1N51vD3336o6jbbJIJgMwFHXMqhe8+E25wqbMvozAVZPZt0wg+vJmOpa3J7/VEKUTR
         vDx3vMwaS7lVluKzE6pIpQhpfcf+h7wAUFUROg175y4fw9+ZuWZeEyLF7AKqNrzfrA85
         Nk+A==
X-Gm-Message-State: AOAM530bPmm6j4MsBwgh23al21rWF8ZNSjZBlvAZY8yCuFumTW86eX8r
        9464Ad3WP6TnVSe3VMZOcgs=
X-Google-Smtp-Source: ABdhPJwCSflqUgS9hP0iu2J2W5j54d+n0QZseGMLF7OW1XlZeBeaEkzCl1fNMb2MGco6U+wFzGEmig==
X-Received: by 2002:ac8:7c9a:: with SMTP id y26mr28710591qtv.287.1606143266761;
        Mon, 23 Nov 2020 06:54:26 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id n21sm9819872qke.21.2020.11.23.06.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 06:54:26 -0800 (PST)
Subject: Re: [PATCH v2 12/24] pack-bitmap-write: fill bitmap with commit
 history
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <8e5607929d66a3c808dbe3a06c312d0cda1ef568.1605649533.git.me@ttaylorr.com>
 <xmqqy2itoyco.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f6d89171-f343-0d4c-7cf4-725c49615b99@gmail.com>
Date:   Mon, 23 Nov 2020 09:54:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2itoyco.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/2020 4:50 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The fill_bitmap_commit() method assumes that every parent of the given
>> commit is already part of the current bitmap. Instead of making that
>> assumption, let's walk parents until we reach commits already part of
>> the bitmap. Set the value for that parent immediately after querying to
>> save time doing double calls to find_object_pos() and to avoid inserting
>> the parent into the queue multiple times.
> 
> Is it because somebody found a case where the assumption does not
> hold and the code with the assumption produces a wrong result?  Is
> it because we can get a better result without making the assumption
> the current code does?

The algorithm from "pack-bitmap-write: reimplement bitmap writing"
that calls fill_bitmap_commit() satisfies this assumption, since it
computes a reachability bitmap for every commit during the reverse
walk. We will soon change that algorithm to "skip" commits, so we
need this step in fill_bitmap_commit() to walk forward to fill the
gaps.

> In other words, can we explain why we are making the change in the
> proposed log message?
I'm sure Taylor and I can work out a better wording to make this
more clear.

Thanks,
-Stolee


