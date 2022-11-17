Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3644C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 10:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiKQKJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 05:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiKQKJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 05:09:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC840916
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 02:09:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e13so1809882edj.7
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z/3BMBZOijDiYXOpsK/1HMOB/XYd7IBfMM6C3Kdh9F8=;
        b=gMx6bPCq4vC+LG+8/EZSSZVdjsd+spxV1sH2GRVhpKK6LYCdQojVETObRpehkrE/kT
         8a+DnfgOFncqMsuyGGydE6IAzqoLtnX6hswQQFu/TPwQ3aBxRe+g3wiUBHJxn/0iWVWY
         A5MsFjG7xbgWyHkRMQGcOlkMJ1iNWD0BLUhf0SMOqu9a9YXPB4NxwpVtWPOrBPmiTvT3
         JnvBlhI/yycpk2dNIfdyBD/78aTuN+2ECoW9F2pO9BfQXDXMn3niZKn9SiIeKAQ2Mifu
         y0tS71S3OpshqUS0wFInTovwD0VOLMI1US5OUcZtf2gEkPWgVEXbv4XkRzUHaau1LkXC
         bNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/3BMBZOijDiYXOpsK/1HMOB/XYd7IBfMM6C3Kdh9F8=;
        b=kBHdnk9ViByaVkxH2p8s3PsY7AMk0iJqlbeLM15ZegCNSITwQuyJnjpCXczjbR5A8R
         XJ8xoTdvSwp+5oLFp46vXp3dqLtIp3ciBpsHihhSespVMzkpMhMMIRSHBQZdR+NT86UG
         zyAjECoTMH8NNHFVEJNvv5LcDWVwQFZu3R0OrGtgfxC3nSLEeCEuDptH1jVZsMbaK1R2
         YKK1P9kwW+6chVGdNfAsz6UyIiQVOCSj0gaMTC3ByQ34j552pe4FaT2aAtlNOiCCrwfL
         bUGntp5NGIuwezfHQM88G5hhWXuFowfcx4WmohO+6AgPfqlP9sQtr++sURaJeIk9gMqh
         OhFQ==
X-Gm-Message-State: ANoB5pm3SoCBVxndXEFS4jxeTUthdEIwHiDg+n3h2jBSC8IpLHSV6iec
        B3Y5dfzbMa+mxaMJUdO4Lc+O8xZSTMg=
X-Google-Smtp-Source: AA0mqf5pY1kzJ70vaiPv0/3omgHWNRdjytRgTy8cvXaxWUCd9KBm6KhLwx3/SiA99SZzG6kC35bqXg==
X-Received: by 2002:a05:6402:ea0:b0:463:a83c:e019 with SMTP id h32-20020a0564020ea000b00463a83ce019mr1520445eda.253.1668679767605;
        Thu, 17 Nov 2022 02:09:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id mm18-20020a170906cc5200b00780b1979adesm149687ejb.218.2022.11.17.02.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:09:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovbpm-004iTq-2U;
        Thu, 17 Nov 2022 11:09:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7610: use "file:///dev/null", not "/dev/null", fixes
 MinGW
Date:   Thu, 17 Nov 2022 11:08:08 +0100
References: <Y3PrjMLcEGfoHifZ@nand.local>
 <patch-1.1-21a9cb49299-20221115T233516Z-avarab@gmail.com>
 <Y3Q3xQeaXGPemcWv@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3Q3xQeaXGPemcWv@nand.local>
Message-ID: <221117.86o7t5j3jd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 15 2022, Taylor Blau wrote:

> On Wed, Nov 16, 2022 at 12:40:14AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> On MinGW the "/dev/null" is translated to "nul" on command-lines, even
>> though as in this case it'll never end up referring to an actual file.
>>
>> So on Windows the fix for the previous "example.com" timeout issue in
>> 8354cf752ec (t7610: fix flaky timeout issue, don't clone from
>> example.com, 2022-11-05) would yield:
>>
>>   fatal: repo URL: 'nul' must be absolute or begin with ./|../
>>
>> Let's evade this yet again by prefixing this with "file://", which
>> makes this pass in the Windows CI.
>
> Thanks very much. I just picked this up on top of my 'ab/t7610-timeout'
> branch and pushed it out to ttaylorr/git to double-check your results
> against CI. (Not that I don't trust you, of course, but I'm feeling like
> I should be extra-cautious ;-)).
>
> Assuming that all looks good, then I'll push out a new version of 'next'
> and dependent branches to the usual spots so that we can get 'next' back
> to green.
>
> Thanks for working on this so quickly.

And thank for picking it up! Looks like "next" is passing CI now:
https://github.com/git/git/actions/runs/3475751137/jobs/5810308794

