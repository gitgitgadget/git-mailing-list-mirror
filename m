Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461ED2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 10:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbdFAK0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 06:26:11 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38449 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdFAK0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 06:26:10 -0400
Received: by mail-it0-f45.google.com with SMTP id r63so30409603itc.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R5TMnGAL+f1OAAAGJSmYxT0mHREIFD28NhXM/nnPd3w=;
        b=sBabjSXZ3CfY5aFxliyRnd7vJ1yK5dBM6Ki3XYr4xuBTKOaFY6n8QBNluVfbNPQ1gF
         1tDsvV5Z9Qoi8XRLVW6ohHYBH3FfQX1oFM01sB4P23PVObbLeg2pxuuxa5/j0fvdH+e2
         Xmzp3ppnQW1La0/4zVHCJYdhtXe5QvMIbcjpKUR2bG30PacQzgk9uqYrpgKl7TCqEGVR
         RB8yShjJRl4cmPus+WJAnRkd+mbr53oIl/6toetguYACZGaSN29zBLoPYwW0xJGFQ+R0
         IToYdkosTpQebOoa6MqNp+cWrHOd7mIZaXrW2xphL4jC2oi3RdRqENtUYcUW6WT4ak8z
         n1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R5TMnGAL+f1OAAAGJSmYxT0mHREIFD28NhXM/nnPd3w=;
        b=pmxBFgfwyTxZvaNQBznvxWmI4HnsBUspg2AtHTZ5Q8OZSLi2xMI0NNrBtBH8iPjIzY
         jG4oQnPffMeNVRy0Q+e7tFrq4vlWTGSlPz4nJmIqWq90xtzhdhRCSY5K0Dc64SpKzlZI
         cJw9QNjMBAIWgNBuuED3fZ1K7Qn4r5+k6PW8Doo1NDScHviFXx7xOhkxFIN91HnQO7gh
         P9HjGEzbVbvB0LA2Rm7sztiUHVBtGcgWoVcvpva72UpYYiAZQHSLF1xuBZ1s5YFdE1QP
         BjMr3+wJn6ZsARkTjBKd2/3RttzWaUoPspOdOOI6LTU0UT4KVfp3EtEspJx8RFWSib6Z
         qDsA==
X-Gm-Message-State: AODbwcBQM+nF+fTFzd2B5BkMNVg0Be8u1o5ZzPWu2kplQxM8htEG7CXk
        yYyoJocwEwMhnQTfgI7kAcAfZleVpA==
X-Received: by 10.84.193.129 with SMTP id f1mr95872489pld.129.1496312769568;
 Thu, 01 Jun 2017 03:26:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.137.233 with HTTP; Thu, 1 Jun 2017 03:26:08 -0700 (PDT)
In-Reply-To: <mvmmv9st3yv.fsf@suse.de>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 1 Jun 2017 12:26:08 +0200
Message-ID: <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     Andreas Schwab <schwab@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        Marc Stevens <marc@marc-stevens.nl>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 June 2017 at 12:08, Andreas Schwab <schwab@suse.de> wrote:
> On Jun 01 2017, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Depending on the model of "ARM" (or "SPARC") emulated with QEMU, and
>> depending on the OS that runs on such an "ARM" or "SPARC", we may
>> not see this---if the emulated OS has the "software unaligned-access
>> emulation" our userland may not see a SIGBUS.
>
> Even if the architecture implements unaligned accesses in hardware, it
> is still undefined behaviour, and the compiler will (eventually) take
> advantage of it.

I tried to optically follow the macros and ended up on line 87/89 in
lib/sha1.c of the sha1dc-library, where there is undefined behavior if
the address is unaligned, which it seems it could be. Maybe Git uses
some particular combination of macro-definitions and I went down the
wrong path... There might also be other spots; I haven't thrown UBSan
at the code.

Using memcpy on those lines should not be a performance problem on
platforms where unaligned access is ok, of course assuming the
compiler sees the opportunity.

Martin
