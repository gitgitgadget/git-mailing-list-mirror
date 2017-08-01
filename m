Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEFF2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 19:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbdHATzv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 15:55:51 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36532 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdHATzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 15:55:50 -0400
Received: by mail-wm0-f52.google.com with SMTP id t201so24009138wmt.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7PMHDw7Ij9QKfJJOsrUJuXxDYG8UeUrCh6ks38Bp5Mk=;
        b=l00OOaiFFzTec2nAVSo7kro6lmBPn6npIMzGdMkGaaGywt4KCvlhbh0TKUZLMcQZQj
         7/acyWjpFBDPtXjq3sVf7dYoAwSBQXEJFFcTojIgVSWzbBDYGk6Drs9tzedYb1JAB40c
         zqVFD1TYQGPgThgRV2WJPuTe2+UMbBXonlK2FQtJ/gWbVan6leY+ilGTJ8kzkIIWJ47e
         dhKXwq5FMN8xpbH48YaSg8AupmDuayqN4GrnkbA6xrUJqgWZ1/IJQUn5KceGtLKcO9oL
         tUi+dts3k4HMmJRLUy/uXtuXGtXnaOFuNsMUJlSOW0ZkE3WzsCdPv5hjuYY/oKDeyr13
         Fu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7PMHDw7Ij9QKfJJOsrUJuXxDYG8UeUrCh6ks38Bp5Mk=;
        b=JZYWbXM3M15ysqgHrU4tOgOK6yiCX0GPQ50ixZDQ4r2JZYEXA6kmM8+IUjXz/Z/6+q
         6q55ZzXUsbijvG4FyjWKaX9jpQ4rBp0+Bw4vNr+qqbza0a+4hN41adeTHVvc1h4b0G4h
         rIlM9EUdnBssJ6AD3d1JVDar6G/BOdfOOuo7ynRezeQACUTu/9okuuwSRVRa7M0nl9DK
         qE6Q8r9qQz08c3IoHGOW7uFcw3b3hRux5oUIP3jgOm36kDG4i8dc/MLuL4uKvD8jEbAj
         3HirlMdjMZeseY+UXuRD9vfPO56wOp0/J9sDDpGL439j1thZ9JJrEXK0AQrxLwmC/qy1
         n8bw==
X-Gm-Message-State: AIVw113WkX1WH3K3IZJwkSu4EONlGk7ED+1buPWnLm48gAop3izx3H1f
        w66U4bLgngkRpg==
X-Received: by 10.80.168.34 with SMTP id j31mr18804090edc.87.1501617349168;
        Tue, 01 Aug 2017 12:55:49 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id x53sm7925603edd.79.2017.08.01.12.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 12:55:47 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dcdGb-0000K2-CC; Tue, 01 Aug 2017 21:55:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Stieger <astieger@suse.com>
Subject: Re: [PATCH] hash: Allow building with the external sha1dc library
References: <s5hh8y19hyg.wl-tiwai@suse.de> <CACBZZX5yv-NzL7H-CH1yMeM9dWkz=PUhx=2wek_jBGpsz1=EAA@mail.gmail.com> <s5h8tj37scz.wl-tiwai@suse.de> <xmqqbmnzgu3z.fsf@gitster.mtv.corp.google.com> <s5hmv7jw9lx.wl-tiwai@suse.de>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <s5hmv7jw9lx.wl-tiwai@suse.de>
Date:   Tue, 01 Aug 2017 21:55:45 +0200
Message-ID: <87ini7m5a6.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 01 2017, Takashi Iwai jotted:

> On Tue, 01 Aug 2017 17:56:00 +0200,
> Junio C Hamano wrote:
>>
>> Takashi Iwai <tiwai@suse.de> writes:
>>
>> > On Fri, 28 Jul 2017 17:58:14 +0200,
>> > Ævar Arnfjörð Bjarmason wrote:
>> >>  ...
>> >> * We now have much of the same header code copy/pasted between
>> >> sha1dc_git.h and sha1dc_git_ext.h, did you consider just always
>> >> including the former but making what it's doing conditional on
>> >> DC_SHA1_EXTERNAL? I don't know if it would be worth it from a cursory
>> >> glance, but again your commit message doesn't list that among options
>> >> considered & discarded.
>> >
>> > I don't mind either way, there is no perfect solution in this case.
>> > As you know, many people think the ifdef ugly no matter how.
>> >
>> > I leave the decision to maintainer.  Just let me know which option is
>> > preferred.
>>
>> Yeah, I also found it somewhat confusing to have these two headers
>> that look quite similar to each other at the top-level of the tree.
>>
>> What's the "conditional" part between the two headers?  Is it just
>> whether the header for underlying library is included?  I wonder if
>> it's just the matter of adjusting "hash.h" to read like this
>>
>>     ...
>>     #if defined(DC_SHA1_EXTERNAL)
>>    -#include "sha1dc_git_ext.h"
>>    +#include <sha1dc/sha1.h>
>>    +#include "sha1dc_git.h"
>>     #elif  defined(DC_SHA1_SUBMODULE)
>>     ...
>>
>> or are there heavier tweaks needed that won't be solved by continuing
>> along the same line?  As _ext.h variant is included only at this place,
>> if we can do with minimum tweaks around here without introducing it,
>> it may be ideal, I would think.
>
> Well, a tricky part is that currently sha1dc_git.h is included from
> sha1dc/sha1.h implicitly by SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H
> definition.  IMO, we should stop this, and use the standard inclusion
> instead, i.e. in hash.h,

It's just like this because when I hacked up that facility I was making
the bare minimum change needed to not make local modifications to the
upstream code. If there's better ways to do this in the presence of
DC_SHA1_EXTERNAL & without that would be most welcome. Thanks.

> #if defined(DC_SHA1_EXTERNAL)
> #include <sha1dc/sha1.h>
> #elif defined(DC_SHA1_SUBMODULE)
> #include "sha1collisiondetection/lib/sha1.h"
> #else
> #include "sha1dc/sha1.h"
> #endif
> #include "sha1dc_git.h"
>
> In sha1dc_git.h, we'd need another ifdef for DC_SHA1_EXTERNAL to
> define the own git_SHA1DCInit(), but it's trivial.
>
>
> Takashi
