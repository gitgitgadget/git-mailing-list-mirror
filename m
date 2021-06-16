Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20354C48BE8
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08608613D3
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFPSOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFPSOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 14:14:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44063C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 11:12:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 5so335839qkc.8
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zP+FW6CF/kiWlod2MGn2e1IqzrynVP3oOhkl3ypyr6A=;
        b=Kgqhiee87LxGQqKogUA3+lAlXQwl1toc3koQdfDzaadrGxmfatEHbt9aVe86MGsM47
         fIZb5VeV/QO7kwXlJe/HP/UUR+dt9rM4ElTf84xbq9RT4lS0kzti0wPVjC8z/lb1MOt/
         xvHMAs0LkJ+4T6ypIVK7lA7Dq4NZC16QXiYSYOwtii6dTZq7xeJ4NBVK9xNnHbK6bzQz
         pKASsAuWLJ6PzbVKzq2nrYpgNFFA6RoWTG75Qq6b49RP+Kpqf94hbn/m29wC7zOxYeUV
         nnOxjMfs5psOADC9dwgpNi4KAEiRG4cpjnivJFZ8BIUJvXg5eiJbHbEyBpR9YZZiC0OP
         UWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zP+FW6CF/kiWlod2MGn2e1IqzrynVP3oOhkl3ypyr6A=;
        b=oEjDh0hhx3C2nqYkunCAP2kJnvE4OlksjDwte0B8CJv8bOJ+5OFYXG7BbQVloi+oP6
         fFs5B0Bf9di1cm5XLSfPwuJjSOYhbSfnBnDKUf6/KctX0O2mQDj7bxibKAJci5RaediX
         hSMa27NXhDSZO4QZR6OAgVuIPBAYbU14Y5PwARANhroigh7WLOLrJY3nN0G8WXIfuYcQ
         R+eEBSzn/Z9iovOYADBQOoamhpo15IVHeK82V+F6PUePOXJthV8B6rRg1cAAoptzCwAl
         u4JZHopG3so1u7S+RLEC6vKP0CC8650/7fQQcTz9+KQBtJj3yhV9IgJrpmKcGL8IHhz5
         Z6IA==
X-Gm-Message-State: AOAM530LLLBLr66qpJUVrZ4MPU+vSVeK0aPeKu4/WYTJiCbByGgryi8A
        2CNjrqXPO+DETyVzE1BDcKTexpyvzPHzMdun
X-Google-Smtp-Source: ABdhPJzHAAVjZt/4zNm3rewajzncpPibzOO0m47Ri3Sh3TPiWQNJU7FFK1enwMoSXYHtuDJ35Pfq/w==
X-Received: by 2002:a37:cc1:: with SMTP id 184mr1435062qkm.218.1623867155238;
        Wed, 16 Jun 2021 11:12:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4142:2009:c909:559c? ([2600:1700:e72:80a0:4142:2009:c909:559c])
        by smtp.gmail.com with ESMTPSA id h4sm1663246qth.66.2021.06.16.11.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 11:12:34 -0700 (PDT)
Subject: Re: [PATCH v6 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20210608134000.663398-1-lenaic@lhuard.fr>
 <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210612165043.165579-3-lenaic@lhuard.fr>
 <CAPig+cSLi7aN=6ahrHwy4fO-7JMBN3pmzfpWe5ZXOcC9j4+e+g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5c4366e4-a891-0a3a-2534-af48ab0097c2@gmail.com>
Date:   Wed, 16 Jun 2021 14:12:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSLi7aN=6ahrHwy4fO-7JMBN3pmzfpWe5ZXOcC9j4+e+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2021 12:36 AM, Eric Sunshine wrote:
> On Sat, Jun 12, 2021 at 12:51 PM Lénaïc Huard <lenaic@lhuard.fr> wrote:
...
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> @@ -179,6 +179,17 @@ OPTIONS
>> +--scheduler=auto|crontab|launchctl|schtasks::
>> +       When combined with the `start` subcommand, specify the scheduler
>> +       to use to run the hourly, daily and weekly executions of
>> +       `git maintenance run`.
>> +       The possible values for `<scheduler>` depend on the system: `crontab`
>> +       is available on POSIX systems, `launchctl` is available on
>> +       MacOS and `schtasks` is available on Windows.
>> +       By default or when `auto` is specified, a suitable scheduler for
>> +       the system is used. On MacOS, `launchctl` is used. On Windows,
>> +       `schtasks` is used. On all other systems, `crontab` is used.
> 
> The above description is somewhat redundant. Another way to write it
> without the redundancy might be:
> 
>     Specify the scheduler -- in combination with subcommand `start` --

I think this change to the start is not contributing to the drop
in redundancy, but _does_ break from the pattern of previous
options. These start with "When combined with the `X` subcommand"
to clarify when they can be used.

I'm not against improving that pattern. I'm just saying that we
should do it across the whole file if we do it at all.

>     for running the hourly, daily and weekly invocations of `git
>     maintenance run`. Possible values for `<scheduler>` are `auto`,
>     `crontab` (POSIX), `launchctl` (macOS), and `schtasks` (Windows).
>     When `auto` is specified, the appropriate platform-specific
>     scheduler is used. Default is `auto`.

I find this to be a good way to reorganize the paragraph to be
very clear. How do you propose adding `systemd-timer` in the next
patch? Is it simply adding "`systemd-timer (Linux)`" or do we
need to be more careful using "(when available)"? Unlike the others,
the availability of that option is not as cut-and-dry.

...

> I don't see `auto` being tested anywhere. Do we want such a test? (It
> seems like it should be doable, though perhaps the complexity is too
> high -- I haven't thought it through fully.)

Unfortunately, `auto` seems to live in a world where we need to
actually run commands such as crontab and systemctl to determine
if they are available, but that happens only when
GIT_TEST_MAINT_SCHEDULER is unset. But, we don't want to actually
edit the timing information for the test runner, so some other
abstraction needs to be inserted at the proper layer.

It's worth a shot, but I expect it to be challenging to get right.

Thanks,
-Stolee
