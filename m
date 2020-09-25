Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06130C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD19D21D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 19:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFQARpEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgIYTBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYTBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 15:01:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70CC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:01:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m6so4839272wrn.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kT0hgvl3YV3D6+VO8eB1BcVH6nTieruQhF0DRikvzBQ=;
        b=UFQARpEeCUuD63ndskkfh9Q7UUqA5XYFcvKW57cV/WAuUJPUROip05fMXJ99M3B2gF
         XO/49ajw+5YffidnAUJdU58wlyVTIF9684i3ECDe9F65Q4mEzNj7Fvex5FBgcuAAZ1qL
         AWkwaUBG1FVtaA0lUlBF0xbT+6fm50s2EW+Gxp1YsBRtrFRRJxoZmGk/vD4ybpVNs8bf
         GNvRf0J+Xk7yVLMkE1pEWHo1fJ9sBVeG7Js59ZQRwQ4JUe9RDJHI2oJNub8iBJZmn0IK
         K9fzSAKrFUBBHiEJMtu6+7pOkS4yM8gHf/niV+X3DGMzwyvsHsSt6EpZ8ZJOoNlzm02x
         ZQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kT0hgvl3YV3D6+VO8eB1BcVH6nTieruQhF0DRikvzBQ=;
        b=LJJyw6+UB2FSDfS9MgFqtMmyFRzVXJ1PuXIaKc+ZDrsjTpo6r81VLCMemfoN/ils7G
         QzWjtq1Y+9EseOy1khtPfgRsfajIFCqSpb5KbCpKDst3uRv+CfgmxaW9i6kHjqC39nUL
         QEiZlTght4cLzMDPJFyLRz98joxcAUYOzXPiS6Y6wbzS+1NinT+LdZHrUhQEGIpfImsJ
         O6y5e/VknxgQKbyx6IeaetbjXo92WkRTOfH4sGVjo1UsGUwlz4yQuLZFpPTX8cJlKLSy
         nKxa1pkXb8CeE2txLi9AJkTBDbcR/wSmVYlSJ3gkjV/76vO8zKiwdjD1g1msTWkL+GZL
         P3bQ==
X-Gm-Message-State: AOAM5331ShXvNDvWC408d8jqNDSIA/mSUdxtbgXOyzZ2LBuhh7iof5hr
        ba709fKyub17jVhwRbPymO4CjdowNY8=
X-Google-Smtp-Source: ABdhPJyw2/ohiM0RZddB13B+RwYhl925s+ruKmKN8zK88zXjdKi8q9cN2H/4pypAYeYMNdzomBbu2w==
X-Received: by 2002:a5d:540a:: with SMTP id g10mr5721272wrv.138.1601060470300;
        Fri, 25 Sep 2020 12:01:10 -0700 (PDT)
Received: from [192.168.1.240] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.gmail.com with ESMTPSA id a20sm3700528wmm.40.2020.09.25.12.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:01:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC 0/1] Leading whitespace as a function identification
 heuristic?
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
 <xmqqzh5fhduk.fsf@gitster.c.googlers.com>
 <20200924211725.GA3103003@coredump.intra.peff.net>
 <c759b472-c889-ef85-bcf2-6d9cbc588b51@rtzoeller.com>
 <1c03faa0-011c-39c2-acb6-d09a5fcfc818@gmail.com>
 <20200925184319.GA660343@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <005de229-ad05-437c-7b83-8f6502b4e27d@gmail.com>
Date:   Fri, 25 Sep 2020 20:01:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925184319.GA660343@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 25/09/2020 19:43, Jeff King wrote:
> On Fri, Sep 25, 2020 at 10:11:33AM +0100, Phillip Wood wrote:
> 
>> If I've understood correctly when ...code 2... contains changes that are
>> themselves indented then we'll pick the wrong function header for example
>>
>> 	void foo() {
>> 		void bar() {
>> 			...code 1...
>> 		}
>> 		for (...) {
>> 			// if this line is changed we pick bar rather
>> 			// than foo because it is the first function
>> 			// header with a smaller indentation than the
>> 			// first changed line.
>> 		}
>> 	}
>>
>> Unfortunately I suspect code like that is not uncommon and the diff would
>> regress with this simple heuristic. It might be possible to recalculate the
>> required indentation as we walk backwards up the file though, so when we hit
>> the "for" line we reduce the maximum indentation allowed for a match and so
>> skip "bar" as a function header.
> 
> Thanks, that's a great counter-example I hadn't considered.
> 
> Yes, I agree that adjusting the desired indentation as we walk backwards
> would work. That's assuming indentation is hierarchical, but I think
> that's implied by the existence of this feature at all.
> 
> Another possible corner case: tabs vs spaces. If I have:
> 
>    <space><space><space><space><space><space><space><space>foo
>    <tab><tab>bar
> 
> which is more indented? Counting isspace(), it is the first one. But
> visually, it would _usually_ be the second one. But of course it would
> depend on your tabstops.
> 
> The above example is obviously stupid and contrived, but I wonder if
> there are legitimate confusing cases where people mix tabs and spaces
> (e.g., mixed tabs and spaces to align function parameters, etc).

To calculate the indentation for diff 
--color-moved-ws=allow-indentation-change in fill_es_indent_data() we 
use the tabwidth whitespace attribute to calculate the width of a tab in 
spaces

	int tab_width = es->flags & WS_TAB_WIDTH_MASK;
	/* calculate the visual width of indentation */
	while(1) {
		if (s[off] == ' ') {
			width++;
			off++;
		} else if (s[off] == '\t') {
			width += tab_width - (width % tab_width);
			while (s[++off] == '\t')
				width += tab_width;
		} else {
			break;
		}
	}

I think we could probably do something similar here assuming it is the 
visual width of the indentation that we care about.

Best Wishes

Phillip

> -Peff
> 
