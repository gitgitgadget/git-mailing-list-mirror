Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E6C43462
	for <git@archiver.kernel.org>; Mon, 17 May 2021 07:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F996121F
	for <git@archiver.kernel.org>; Mon, 17 May 2021 07:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhEQHp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 03:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhEQHpz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 03:45:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802FC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 00:44:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so2988498wmq.0
        for <git@vger.kernel.org>; Mon, 17 May 2021 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9Bjlr/OreNSRklK48V779rZlLtRxsxkfR5rlv9nkrMQ=;
        b=W8HrIcrqmTR5RWi4Wd5o4Hc4PCqn+oftejL+PjKzjWUxpbyhWlydjEcRHNid08WOIU
         UmRyXfep+GsFu1g41XdvHxawPUNIaWEUU3Qy6D9rQ6OXg8p/mN70SCeZDNCAkDH0fTdt
         KUMGCsYh2hnwutttHsjuTkcUXJzVzcD3Rsjxzgk+Dh0v4GNw3yjVkC8NUjJXqKAHbwy6
         R7nkqAo0JOfIrMYFiJA3QuZC5SSgqigTMkmsL/96kEgGT0Hn9G1XG/pvf7PHosvsCRvX
         oWYazs6bRzwJcvFrlMJRrKVVXOEM7Z7AdqcHwpZwUWzCAVAE/UMjR76fFREVV8vUZtIU
         9iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9Bjlr/OreNSRklK48V779rZlLtRxsxkfR5rlv9nkrMQ=;
        b=qbEpPi/TrdMqVWug//8mkjWBjTSIKITeCSI86S2ibPjF4xo+Mh3A1PDYjdKiw3qqA1
         l0ssLDqSyIh7ZCxChL4N72oXaBcACfEAQiZTQU7d0XgFKXiEfxhWCWeIjo2AkH3HQrrV
         81Tp7ur+RK2ZM2e1SI8RBem+oFkNpfKRuZcPfY4i5JhT7TpIgtL6RB4BN2QJAC5jfh9Q
         XYJfTqN71pYXyr5ZcR3LDFfzdmCVzz5KZ07Lmn0muVaboq6bNHzHawv/VIZqNn9y9cwy
         vnZDl5Y5Qfcpnl/mcNF902ID1NBs2fsPcxGVYYUffuEyPukS87oVHisiV/AxqJgTVbLH
         BECA==
X-Gm-Message-State: AOAM532DqHGPPhYDUEzwgS6g17CKAo+jEAqI39NIqP1wDJdFqN5jNtrH
        x4if/DqcC0wBJkk6cL1ygJo=
X-Google-Smtp-Source: ABdhPJzJXl1dllS6+bqeqW+/00rYjUN22AJlmnVmqYCJCA0cjHlojfXMEkZDdeWWykB4xdTfoWMbOQ==
X-Received: by 2002:a05:600c:379a:: with SMTP id o26mr1793354wmr.86.1621237463847;
        Mon, 17 May 2021 00:44:23 -0700 (PDT)
Received: from Inspiron (2a01cb04010c42001d97d57b11f780ca.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1d97:d57b:11f7:80ca])
        by smtp.gmail.com with ESMTPSA id c15sm16344540wrd.49.2021.05.17.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 00:44:23 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] t/README: document test_config
In-Reply-To: <5faaa5a6-8ebf-b2ef-805f-551a36ab7e6c@gmail.com>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210515152721.885728-1-firminmartin24@gmail.com>
 <20210515152721.885728-2-firminmartin24@gmail.com>
 <5faaa5a6-8ebf-b2ef-805f-551a36ab7e6c@gmail.com>
Date:   Mon, 17 May 2021 09:44:22 +0200
Message-ID: <87cztpg5yh.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 15/05/21 22.27, Firmin Martin wrote:
>>   
>> + - test_config <config-option> [<value>]
>> +
>> +   Set the configuration option <config-option> to <value>, and unset it at the
>> +   end of the current test. For a similar purpose, test_config_global for
>> +   global configuration is also available. Note, however, that test_config_*
>> +   must not be used in a subshell.
>> +

>  From the syntax above, when I omit <value>, default value for <config-option>
> will be set, right? 
Good remark. I thought the same as you, but no, it will "git config
<config-option>" (query the value of <config-option>) and then "git
config --unset <config-option>" which is dangerous. Doing so is more
likely an error and should be forbidden, as in this case, it is
equivalent to test_unconfig <config-option>. Will reflect this in v3.
> You forgot to mention it.
I'll thus drop square brackets.

>> +   Example:
>> +
>> +	test_config format.coverLetter auto
>> +
>> +   Is a concise way to write:
>> +	test_when_finished "git config --unset format.coverLetter" &&
>> +	git config format.coverLetter auto
>> +
>>   
>
> The description said "set the config, then unset it". But the expanded version
> said "unsetting the config is deferred to the end of test and set the config".
>
> The documentation for test_when_finished said:
>
>>    Prepend <script> to a list of commands to run to clean up
>>    at the end of the current test.  If some clean-up command
>>    fails, the test will not pass.
>
> Is my interpretation above correct?
Yes.

> Oh yeah, maybe it's better to say:
> "For example: <blah> have the same effect as <blah>."
I agree, because the two lines have not exactly the same behaviour as
test_config. Will fix wording.

Thanks,

Firmin
