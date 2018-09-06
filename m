Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81181F404
	for <e@80x24.org>; Thu,  6 Sep 2018 13:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeIFSOY (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 14:14:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSOY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 14:14:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so11499223wrc.0
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VOB+s5hbf8W/Jjw66IUeo+r85rObJfDx7G5O0hPHhC0=;
        b=I3/62J5kRmjuXdYPh1KeVxuwUuFzKhEXVfr0lt6MVzxy8/jTDhuWFoVtdoYNrOsiXx
         jofbYzv4/EKLtTekEPeQK7BgFVA/hgQmwjRpygOsuf5x0Rr7+8Eh43ZiC1UFZklLZ/KO
         NipQphIZIifAH7jEl0SEZCJjEgHyBWQVAzL4XoHvxa9u847LzQERyuMHr8/B+7fYp/6v
         h/VSxeFd7oNvvX7OtzJBo2nSLvKvGkLkc2G9OUn6u+Au6ET8bJPqKMpSCh1AgiNU+rWr
         02hPEFXecoJIDJi/hpd/i71sA90aIGVxVC2qN7+4MY2L+bTFgT69c5G7WYzuqgvjZHYF
         5hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VOB+s5hbf8W/Jjw66IUeo+r85rObJfDx7G5O0hPHhC0=;
        b=S84qRBGidg+JZH0cink5kIfo1Wym3vjFLZtU36PVyISb8RS4KvUSZuiq+A/WoVFP+z
         8rOwufVZNO9dGMqHBYIKiQPNmuXxclXznqhepYVwqdErLapEH6M9ahtv3CCb2+j0Z8US
         x6LBgmvIi2ThLC561fIqjHciXrAkZGjW6qqwP1fs31LuURCDQ09OYcNxzvmGnK/aeQPN
         CfQys/TW9gS3B8GiW3mEZG8dIcrZv59yXB+NDqQ92ddIgupHV/YXMkXU9uDiwkJBYJgh
         /dlvjM0/a6D3vO9oKRaK8uYYL3kH2cIWXFoF6yfQCG3QxM9CG3Njhu8567ezK3pNJuw6
         yx0w==
X-Gm-Message-State: APzg51ACNPWHiZmtygSHpNOcLEB8qfCF+9qdmzAZ0mJdAw+ux4ul39do
        6hddpl/j6uwnqYxvlHMhEImh438M
X-Google-Smtp-Source: ANB0Vda349qqLVdI3z/ETSJTnSX4ktghNGPYkjwxBPTqaCHK7y3sReMU+pl8pVRF7HjDBybNOlDjqw==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr2521424wri.221.1536241127898;
        Thu, 06 Sep 2018 06:38:47 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b22-v6sm4993903wme.48.2018.09.06.06.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 06:38:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
References: <20180905085427.4099-1-timschumi@gmx.de> <20180905173455.GA2336@sigill.intra.peff.net> <cd9a3a74-fdd6-0fb5-ae22-41d552391478@gmx.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <cd9a3a74-fdd6-0fb5-ae22-41d552391478@gmx.de>
Date:   Thu, 06 Sep 2018 15:38:45 +0200
Message-ID: <87r2i6rbiy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 05 2018, Tim Schumacher wrote:

> On 05.09.18 19:34, Jeff King wrote:
>> On Wed, Sep 05, 2018 at 10:54:27AM +0200, Tim Schumacher wrote:
>>
>>> Aliases can only contain non-alias git commands and their
>>> arguments, not other user-defined aliases. Resolving further
>>> (nested) aliases is prevented by breaking the loop after the
>>> first alias was processed. Git then fails with a command-not-found
>>> error.
>>>
>>> Allow resolving nested aliases by not breaking the loop in
>>> run_argv() after the first alias was processed. Instead, continue
>>> incrementing `done_alias` until `handle_alias()` fails, which means that
>>> there are no further aliases that can be processed. Prevent looping
>>> aliases by storing substituted commands in `cmd_list` and checking if
>>> a command has been substituted previously.
>>> ---
>>>
>>> This is what I've come up with to prevent looping aliases. I'm not too
>>> happy with the number of indentations needed, but this seemed to be the
>>> easiest way to search an array for a value.
>>
>> I think this approach is OK, though I wonder if we'd also be fine with
>> just:
>>
>>    if (done_alias++ > 100)
>> 	die("woah, is your alias looping?");
>>
>> The point is just to prevent a runaway infinite loop, and this does that
>> while keeping the cost very low for the common case (not that one string
>> insertion is probably breaking the bank).
>
> I'd opt to use the list-approach instead of aborting when the
> counter reaches 100 (or any other value), because it aborts
> at the earliest known looping point. I didn't run any tests
> comparing both solutions, but I assume the list would perform
> faster than the hard-limit, even if it requires slightly more
> memory and lines of code.

I agree that this use of a list is better for a completely different
reason (which I'll comment on in the v4 thread), but this reason doesn't
make any sense to me.

If we're looking at performance we're paying a fixed performance cost
for storing this list of strings over a counter for everything we do
with aliases.

It only helps over a counter for the case where we do have a loop, but
at that point who cares? We're going to exit with an erro anyway and the
user has to fix his config, it doesn't matter if that error happens 1
millisecond earlier.
