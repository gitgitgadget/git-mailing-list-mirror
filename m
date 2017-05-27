Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3C6209FD
	for <e@80x24.org>; Sat, 27 May 2017 06:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbdE0G5T (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 02:57:19 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36149 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbdE0G5S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 02:57:18 -0400
Received: by mail-qk0-f169.google.com with SMTP id u75so21345327qka.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 23:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QtGAFlPCsPqT9Jvr3WWq3bvbufbEi5dF+GF2ELnvC9Q=;
        b=sbvpibXR36ldPv4NpYaEVrVS6X0fTy83lDUPgasnhzotBpSJCKl4sEbILPfIi9CXVu
         uk6Bo7vhfapP7e30GlWI0nQru1+LpvYRcrJAeX+XGCUV6JuvrZ5HkXxeVG4n3201QHJX
         7tnhS9j6CTxDzKynRc2TXOtHZn6C8xpq7Ewn3VgkIkpwo2k00Yd9Yb24QPN64obEq2HD
         LWiZj3DelEoakg2HkXB4KxM36/SJBfkPu4XAeDgTFlfFtrp6ClLIFtulLLXFw+PBhnBF
         5wHSUGzntBUbw5WZ98WDqFpqHJN6RCP3HX+XMmLyuMDBy4PUk8d8T3CgQqE8n7Pd5cSg
         txNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QtGAFlPCsPqT9Jvr3WWq3bvbufbEi5dF+GF2ELnvC9Q=;
        b=NtRkGUTvsuACNO3MjORB1Z1+Y9wLKK/bTiRxyiIE2e0KXdhPJ3M9lBMPjvbFShpQ1/
         ru1HUoiAZu2jkR4zC2XKZkBx/L0vy9zoOx8Sq5yGqlL+yXjPo+t9hX0+m5EkUuD9XV+L
         L1yUsJVLw39VQR499pIrOsrWvSISqDzR269AyuCnwh5OSEpEsCWOyRfKgdhWB8Siyp/Y
         8DYkT1bHBXntAFcMBTa/gwXk/HFnfvpUwv8Rgj2z+1Tc328cetCBAFLWJIe6gVXtExn0
         88w2S3w7Wkc9xKt9iVBTIzL/1V/U/RpcRfLDgza5NYC4EIbZjNJlGcEAvZIcGYJVbSFL
         mzNw==
X-Gm-Message-State: AODbwcA6Wgr7i2RNDomVtyrELtkPYN8Cxt1vxdsYkNsDjA91Alv0sIoz
        UyAqFtj6+I/U7P5J9oMWHIlXIjG7Sw==
X-Received: by 10.55.86.66 with SMTP id k63mr5970353qkb.46.1495868237137; Fri,
 26 May 2017 23:57:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Fri, 26 May 2017 23:57:16 -0700 (PDT)
In-Reply-To: <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com> <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 May 2017 08:57:16 +0200
Message-ID: <CAP8UFD1L+caWyLS5KCX3QqToVuzii+0tX81=eGA=1_+L6O7ynA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 3:55 PM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 5/24/2017 6:54 AM, Christian Couder wrote:
>>>
>>> Design
>>> ~~~~~~
>>>
>>> A new git hook (query-fsmonitor) must exist and be enabled
>>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>>> outputs to stdout all files that have been modified since the requested
>>> time.
>>
>>
>> Is there a reason why there is a new hook, instead of a
>> "core.fsmonitorquery" config option to which you could pass whatever
>> command line with options?
>
>
> A hook is a simple and well defined way to integrate git with another
> process.  If there is some fixed set of arguments that need to be passed to
> a file system monitor (beyond the timestamp stored in the index extension),
> they can be encoded in the integration script like I've done in the Watchman
> integration sample hook.

Yeah, they could be encoded in the integration script, but it could be
better if it was possible to just configure a generic command line.

For example if the directory that should be watched for filesystem
changes could be passed as well as the time since the last changes,
perhaps only a generic command line would be need.

I am also wondering about sparse checkout, as we might want to pass
all the directories we are interested in.
How is it supposed to work with sparse checkout?

>>> A new 'fsmonitor' index extension has been added to store the time the
>>> fsmonitor hook was last queried and a ewah bitmap of the current
>>> 'fsmonitor-dirty' files. Unmarked entries are 'fsmonitor-clean', marked
>>> entries are 'fsmonitor-dirty.'
>>>
>>> As needed, git will call the query-fsmonitor hook proc for the set of
>>> changes since the index was last updated. Git then uses this set of
>>> files along with the list saved in the fsmonitor index extension to flag
>>> the potentially dirty index and untracked cache entries.
>>
>>
>> So this can work only if "core.untrackedCache" is set to true?
>>
>
> This works with core.untrackedCache set to true or false.  If it is set to
> false, you get valid results, you just don't get the speed up when checking
> for untracked files.

Great!
