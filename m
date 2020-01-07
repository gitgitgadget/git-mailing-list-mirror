Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF77FC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F8C222D9
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIMOQTiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgAGOWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:22:37 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:39515 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGOWh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:22:37 -0500
Received: by mail-qt1-f179.google.com with SMTP id e5so45399750qtm.6
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EaSJkDo7voNeFLOvyvGGRohc6qYnR2BZpTSH7TMiJH0=;
        b=KIMOQTiUzcc7lIqythRUC//oo0Va9H2aDHUh+hPr3XVt91ZSu83fuW23l/xQ4CesMt
         ggreQBiYYPGGQefTxYv5dvAxypQRH84R1mM+kvN4jNvgLqaNofwYe6UiEo3OoRd5X4I3
         jOWcl+uyCIShWKppKIxJtebFzyDnuppEenaiX6uM5U3mgRlbGSiTLwr+a5RtEBzsTon2
         GWZSPnTzT4zeiQ/nNaFtwD0utwk9LPttu0pmkKKAERRiHge5+8DTNj8HL+awrNJTa8Fv
         xLXJBZOW4CvC9IIOuaObOibbOOaDAD9LfL0o4I7K9gfIWLkfHS/Iv/nXwFkWYgvLCaIe
         2x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EaSJkDo7voNeFLOvyvGGRohc6qYnR2BZpTSH7TMiJH0=;
        b=TtHGz5EIu+iZNQO8HocSpgRRIYL78tvm55Us85ds4Ou0/eGX+XIGUtMCjbsSy5npqd
         0xyXTiu/V11B/3l4FhiVs1pOjjR1AGawdstFLsa+93jVOqPKCL6B4FfjriaRJbb/aEWd
         r/EflAMJHa3M6ROPlTJPuysfjh6pgtMDZo95JpKlil7pxd1CFkGP0vHxJm93fBXGAeqG
         HXoLwJuBay2kWVeHlCUaDCN/EfajqsyKFh+xJH2680QsemLgCBSAedaxWXjIc9fzaVzT
         JqIbAkvO8bOKs0w39B/PBJbMxxpOl9J/F2zfRm7XsC5ExP8lf5w6PkC2yL28RShaUx1K
         6LXQ==
X-Gm-Message-State: APjAAAWV4iIY2MdiFlwddwV3beTN1oE6kF4wCA2+9/Pm7igsj+I3IXVN
        wUZS9AZdY0oFGEmYAnWcpQPryiYx
X-Google-Smtp-Source: APXvYqxhgim+SjfejxyUX+mkVJdYGuVUapZ3CH1Lo9AK7VNPpMB3FpL2bl32w0TIDZtf8mWZu5FOng==
X-Received: by 2002:ac8:337c:: with SMTP id u57mr71281580qta.42.1578406955959;
        Tue, 07 Jan 2020 06:22:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1012:f14b:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id h8sm24682524qtm.51.2020.01.07.06.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 06:22:35 -0800 (PST)
Subject: Re: Assertion in git log graphing [regression in v2.25]
To:     Jeff King <peff@peff.net>
Cc:     Bradley Smith <brad@brad-smith.co.uk>,
        Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>, git@vger.kernel.org
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net>
 <5f956281-e861-f274-be43-95d99a625abb@gmail.com>
 <20200107140417.GA12242@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39277f9a-f88d-94a3-2a8b-b6e0a3dfdc62@gmail.com>
Date:   Tue, 7 Jan 2020 09:22:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200107140417.GA12242@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 9:04 AM, Jeff King wrote:
> On Tue, Jan 07, 2020 at 08:25:59AM -0500, Derrick Stolee wrote:
> 
>> On 1/7/2020 6:48 AM, Jeff King wrote:
>>> The assertion itself is quite old, so I wondered if it was even still
>>> relevant. Removing it does produce a reasonable-looking graph:
>>
>> As I'm digging into this case, and finding when the assertion is hit,
>> I see that the issue is in the line further below your coloring issue:
> 
> Oh, you're right. I totally missed that.
> 
> So perhaps we have two bugs, or perhaps they have the same root cause.
> 
>>>   | | | | * dd068b4 Merge commit '8f076d8' into HEAD
>>>   | |_|_|/| 
>>>   |/| | |/  
>>>   | | |/|   
>>>   | |/| |   
>>>   | * | | 8f076d8 5
>>
>> What is output is actually this, above. But the logic that includes the
>> assert is checking where the underscores end, and the shown underscores
>> actually pass the check. The issue is that it seems like it really wants
>> to show this:
>>
>>>   | | | | * dd068b4 Merge commit '8f076d8' into HEAD
>>>   | |_|_|/| 
>>>   |/| |_|/  
>>>   | |/| |   
>>>   | * | | 8f076d8 5
>>
>> Note that I dropped a line and compressed a slash into an underscore. It's
>> on that line that this condition is being hit.
> 
> Hrm. I could see either being acceptable, but I do think the second one
> is a bit easier to read. I'm not sure which was intended for this case.
Somewhat expanding the situation to test more of these collapses, I can get
the following graph:

*   6_M1
|\
| | *   6_M2
| | |\
| | | * 6_H
| | | | *   6_M3
| | | | |\
| | | | | * 6_J
| | | | * | 6_I
| | | | | | *   6_M4
| |_|_|_|_|/|\
|/| | | | |/ /
| | | | |/| /
| | | |/| |/
| | |/| |/|
| |/| |/| |
| | |/| | |
| | * | | | 6_G
| | | |_|/
| | |/| |
| | * | | 6_F
| * | | | 6_E
| | |/ /
| |/| |
| * | | 6_D
| | |/
| |/|
* | | 6_C
| |/
|/|
* | 6_B
|/
* 6_A

Note how 6_M4 has three parents, and the first parent has a horizontal
edge. Even giving an extra padding line between horizontal edges, we
_could_ output the following instead:


| | | | | | *   6_M4
| |_|_|_|_|/|\
|/| | | | |/ /
| | |_|_|/| /
| |/| | | |/
| | | |_|/|
| | |/| | |
| | * | | | 6_G

However, I'll stick with the fix for the coloring issue. I think it
was a previous bug that just wasn't hit until now.

Thanks,
-Stolee
