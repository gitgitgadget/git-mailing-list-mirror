Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E7DEB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 10:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjHIKDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHIKDS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 06:03:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0B1BFA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 03:03:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so55233545e9.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691575396; x=1692180196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+sxsAR9qyftH/m1OvIqfYVbYYp4weX1h022CEOLDrA=;
        b=eqx2K5CTjEfFUTHuGqp2woKAT2BL/tJk0uvSOMMu1+7b3ygewN22tQBKeRMRcxJuZq
         AFpj6jKDmOKTE7VsTqbT7YO16Y4RrjIH3vwYaI+Xa7ehB77i3KjYfuQGUMYdT7zQVdUr
         duiME8U+bfDXBTfulJaAjoMJ1CUGgojRRpcjgY2yTlMdK5KD7bDFY83nFL0bGQKf4SbF
         8Xi8rPHVbJvky+ve8sJfUHShZ62jj+4m4VFeMXe+HfPKQuGTfcBiDfuNvfXa9vsBbJi6
         uab8IhOKaihgZxoVVeR/XuqHNZHn5YY9YtZNdTUnY9i5hUL7Cx4QF6n/cnGpSzRKh4YD
         Vk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575396; x=1692180196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+sxsAR9qyftH/m1OvIqfYVbYYp4weX1h022CEOLDrA=;
        b=X10ezznsDeJg58nP8shGJjIfb/jNllvkTnogkanCNO+02/5pHhHdIRbP48szd80zWC
         FlO242xdnD2DYJ7vhLD21KokMKXgAoHbzhW5YTlUhJZvoGOmPYotMlhdKZKqnIY1T3Jm
         3cxslkUv1VjEQYFiy02nkQmvCypt0GnhwM4aXTBTf/cqlYD7+8iG4sJfQDeaZ4L0pldU
         w4uXVdqMkBQ7I+rZMvfeS8VdTQaG7qefryFehpInW+aZbN8a1eVYqYCB93tXoggo4MeU
         HgKG4Xwur3u1HiFxXKGcmKiPuGRgBbr026FcvsLZpYywsuufP12KrQ+VA/pxb0bIQIpV
         nirg==
X-Gm-Message-State: AOJu0Yx2rwjlTGWdTqyvI+o0HRs5U6goeZ54v/9Q7MDINlrCmWx2bw/t
        QcnRblG/cm0n5nojZLq1Lw0=
X-Google-Smtp-Source: AGHT+IFFEPlfHoqcMZwlNRegWbfT3qUPIyDv7G4EH+6hCHYYh3R+lw7V3YV/mOSbNQI2JFOnB15HhQ==
X-Received: by 2002:adf:ee02:0:b0:313:f0d7:a43 with SMTP id y2-20020adfee02000000b00313f0d70a43mr1365528wrn.23.1691575396391;
        Wed, 09 Aug 2023 03:03:16 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm16426692wrq.20.2023.08.09.03.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 03:03:16 -0700 (PDT)
Message-ID: <44b7c1d7-83f3-c549-aa5f-2f06276ba599@gmail.com>
Date:   Wed, 9 Aug 2023 11:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <adc0cf80-c2e3-7af2-6d7f-036b95d27f80@gmail.com>
 <8aa7be24-f4a8-4515-8425-dd4bc69e07b1@github.com>
 <5bb4313a-01f3-4dea-b724-fb41a8def334@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <5bb4313a-01f3-4dea-b724-fb41a8def334@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/2023 18:24, Derrick Stolee wrote:
> On 8/8/2023 9:56 AM, Derrick Stolee wrote:
>> On 8/8/2023 5:53 AM, Phillip Wood wrote:> Hi Stolee
> 
>>> So only one of these jobs will succeed. The cron entries are careful to
>>> only run one job at a time, I think it would be worth doing the same
>>> thing here. I think the using the following format strings would fix this.
>>>
>>> Hourly: "Tue..Sun *-*-* 1..23:00:%02d"
>>> Daily:  "Tue..Sun *-*-* 00:00:%02d"
>>> Weekly: "Mon      *-*-* 00:00:%02d"
>>
>> I would modify this with dropping the "Tue..Sun" from the hourly schedule,
>> as we still want 23 runs on Mondays.

Oops, well spotted

>>> It looks like the launchctl schedule has the same issue.
>>
>> I will take a look at this and consider some additional patches to correct
>> these issues across both schedulers. Thank you for the attention to detail!
> 
> Taking a look, it seems that launchctl does not have this same problem.
> 
> The schedule is set via an <array> of <dict>s as follows:
> 
> 	case SCHEDULE_HOURLY:
> 		repeat = "<dict>\n"
> 			 "<key>Hour</key><integer>%d</integer>\n"
> 			 "<key>Minute</key><integer>%d</integer>\n"
> 			 "</dict>\n";
> 		for (i = 1; i <= 23; i++)
> 			strbuf_addf(&plist, repeat, i, minute);
> 		break;
> 
> 	case SCHEDULE_DAILY:
> 		repeat = "<dict>\n"
> 			 "<key>Day</key><integer>%d</integer>\n"
> 			 "<key>Hour</key><integer>0</integer>\n"
> 			 "<key>Minute</key><integer>%d</integer>\n"
> 			 "</dict>\n";
> 		for (i = 1; i <= 6; i++)
> 			strbuf_addf(&plist, repeat, i, minute);
> 		break;
> 
> This means that we create an hourly schedule for each hour 1..23
> (no 0th hour means no collision with daily or weekly schedule) and
> a daily schedule for each day 1..6 (no 0th day means no collision
> with the weekly schedule).
> 
> Does this match your understanding?

Yes, having read it again - sorry I'd misunderstood it yesterday.

> The overlap _definitely_ exists in systemd, which I will fix.

That's great

Best Wishes

Phillip

