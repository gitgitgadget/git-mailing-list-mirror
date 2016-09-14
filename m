Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E59A1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 20:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbcINUEa (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 16:04:30 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35707 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933041AbcINUE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 16:04:27 -0400
Received: by mail-it0-f51.google.com with SMTP id r192so61350147ita.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4mRWb0KWD49KjJbEFYE3Xd6vE690H8HAz7+nmvt225Y=;
        b=JcGQyLaF1wPtN6VXxaWwPN963wwmf0Rd17GHodq/PsSov7I1XGjXf17vN806SZ/cwA
         8dxBWCSOrSyevw1yEO89tcETcbNs81lK/we4HjiwA8z2cU2n1kDaV1HTQaFzpuClmr7k
         TOEKv7Q5FreUKduyFZexlje2LdG+D23HIy/GOlknJmZswnntEkWEIS60P5b6wm5VElNb
         idfgyNqBONXAM5FJanlTnz8Pwvy/OJBTWDfzh3llLscEt/93+rNHheqhqCoWm8xeejLV
         ZSKm+31d6DEXfYpeyzb7pLHoeavvwc2iz77r8pEFIAqgjeHaEoSIXQzmOoKz8ejIgQ0q
         ILKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4mRWb0KWD49KjJbEFYE3Xd6vE690H8HAz7+nmvt225Y=;
        b=K49r1lQ7OBwtoHzNP5kVDpRjpocBQvlIpAt6qi9ByUXTKrDF4M5MzeVt8NwQBvWf1m
         dWPzlEHq/GUbMGOkZjPJobBHoTtLfkzKRRDH3j5IEFRLEvO9NhFiTOgkdhI6I+Y/xLuS
         97QQae7yJKXUXj0+FgbvIvMYmNxnbMwEDZ/ZUttAvRQNQ0TVdh5l47NScidJtTEBx8ZZ
         WxfUwlDUpWQ1xDBbVn7O3lsU9bh+3mldjrXJizoNJnSDkOBhsXDRWd3dzJVT47R8Btq6
         HOgSI7kv4yAXeJJ05Jjt31KQYVoCU+z2pdGEOi9Nu+ud+imuyIOX+uTiSXphLT3PTkJo
         88Tw==
X-Gm-Message-State: AE9vXwO4Ocrf36wfW7mU+wLKDCTd5AeIlYERdwWpbw+YGenQrsExrYhXsWSVltie+36iJGFgsoHMW56J5uh/G4Ad
X-Received: by 10.107.131.8 with SMTP id f8mr9484808iod.91.1473883465690; Wed,
 14 Sep 2016 13:04:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Wed, 14 Sep 2016 13:04:25 -0700 (PDT)
In-Reply-To: <20160914194643.GC7613@sandbox>
References: <20160824173017.24782-1-sbeller@google.com> <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com> <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net> <20160914175130.GB7613@sandbox>
 <20160914194643.GC7613@sandbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Sep 2016 13:04:25 -0700
Message-ID: <CAGZ79kbFFwHLhCC=XA=g_hKAgwPrsrwCrmXvW7cRK38w4k48Vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] serialize collection of refs that contain submodule changes
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 12:46 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Wed, Sep 14, 2016 at 07:51:30PM +0200, Heiko Voigt wrote:
>> Here are some numbers (using the my development clone of git
>> itself) from my local machine:
>>
>> rm -rf <test-git> && mkdir <test-git> &&
>> (cd <test-git> && git init) &&
>> time git push --mirror <test-git>
>>
>>    real       0m16.056s
>>    user       0m24.424s
>>    sys        0m1.380s
>>
>>    real       0m15.885s
>>    user       0m24.204s
>>    sys        0m1.296s
>>
>>    real       0m16.731s
>>    user       0m24.176s
>>    sys        0m1.244s
>>
>> rm -rf <test-git> && mkdir <test-git> &&
>> (cd <test-git> && git init) &&
>> time git push --mirror --recurse-submodules=check <test-git>
>>
>>    real       0m21.441s
>>    user       0m29.560s
>>    sys        0m1.480s
>>
>>    real       0m21.319s
>>    user       0m29.484s
>>    sys        0m1.464s
>>
>>    real       0m21.261s
>>    user       0m29.252s
>>    sys        0m1.592s
>>
>> Without my patches and --recurse-submodules=check the numbers are
>> basically the same. I stopped the test with --recurse-submodules=check
>> after ~ 9 minutes.
>
> Fun fact, I let the push without my patch and with
> --recurse-submodules=check finish:

Thanks for the numbers, one of the major push backs for
origin/sb/push-make-submodule-check-the-default
was that it introduced slowness; this patch might help a bit there.
