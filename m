Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93758201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbdF3ST2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:19:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33685 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdF3ST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:19:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so16136645pgb.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y0mtPGlv32DKA/9RednhdPuLXyTuNcdg23a5KULIiic=;
        b=YEBGlkwWjMUbNIFXxjnKIi1Jszq0ROsw30JFSU5vZjnUFagXmovlyb4Y6QLjO3N+3Y
         LR6SKlItmXDSS4umJrnRwXSAFBuRYljfdLraqoB5JsPRl8Klsega9LjnC6NPFVZoYFTW
         VkJc6uJ7gYexYwbXDysndzCM+tCxYB9/iCWCauG8wWyjmisiesbKfy2fCwYHY1FJAYhC
         hCylD8slTxxUVe3CWVpnGCojPFPpJkPkLRfZSUur8o7dXKZ6Zhtp0Aa1YKYb2jM+BS+t
         h3U27h+lx4tj7YwId51anvJBOyqsl1Ftya9p83m/0m3eeReWVzN9Ddug8wHvTyI/HuA3
         svbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y0mtPGlv32DKA/9RednhdPuLXyTuNcdg23a5KULIiic=;
        b=U5L9UMnEq5mcoC/rZB5v+qKnYbdNJKpHF0FIy9w/827fswobINjwjWUqcL1H/UXC1X
         3uxCxYdAvLvkaUmU9GCQLIe6YMwx3j8GNlv8tPoM8IuDnVJsKpXW7R6MN3zNd+WSFfUl
         +hqGu2RxH/GTybRvfMpmzm7P4GV3OJkAwGcTu92TT4IyP36b1dCrrIjv4QKEISPbWX0S
         S4KwrtdM8KmxcmXZ/DUPkhg0wmduUnQt/9vL52uXE8FrAoK0gzfKX6+IxS1Wlm2VYYtT
         OESLG+D18VxxL9lGh6WBn3YPGNZWwCLJslR9mekZFC2TpDHLa90fJi7Q/yIKvJj+fhFB
         PpKA==
X-Gm-Message-State: AKS2vOyW50HTy4GTU+auXVA2W29eBAWt0327noxbqT4zRKmvrXojYD1Z
        UtwjkuCfZGdXVg==
X-Received: by 10.99.101.135 with SMTP id z129mr22119056pgb.66.1498846766780;
        Fri, 30 Jun 2017 11:19:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id l3sm18471607pfk.34.2017.06.30.11.19.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 11:19:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, peff@peff.net, tboegi@web.de,
        e@80x24.org, ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v8 6/6] convert: add "status=delayed" to filter process protocol
References: <20170628212952.60781-1-larsxschneider@gmail.com>
        <20170628212952.60781-7-larsxschneider@gmail.com>
        <xmqqinjetzgc.fsf@gitster.mtv.corp.google.com>
        <C36BBCCA-6694-40EC-8E1A-36B0CB9D4B2D@gmail.com>
Date:   Fri, 30 Jun 2017 11:19:25 -0700
In-Reply-To: <C36BBCCA-6694-40EC-8E1A-36B0CB9D4B2D@gmail.com> (Lars
        Schneider's message of "Thu, 29 Jun 2017 20:46:21 +0200")
Message-ID: <xmqq4luxs5hu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 29 Jun 2017, at 20:34, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> You seem to have squashed an unrelated "table-driven" clean-up into
>> this step.  While I think the end result looks good, I would have
>> liked to see it as a separate step, either as a preparatory "now we
>> are going to add the third one, let's make it table-driven before
>> doing so" step, or a follow-up "now we have done everything we
>> wanted to do, let's make this clean-up at the end" step.
>
> I am sorry. That was a misunderstanding - I thought you want to have 
> this change squashed. 
>
> The "preparatory" patch sounds good! 
> Would you be OK if I send a v9 with this change?

That would be more than OK.  I think we are pretty much ready to hit
'next'.

Thanks.
