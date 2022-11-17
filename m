Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0228DC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 19:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiKQT3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 14:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKQT3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 14:29:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1778A16A
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 11:29:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j12so2558111plj.5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 11:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X61HGDH96Cc493E0oH/ISkOEsapmYHYmJIpx51N0X8c=;
        b=Ckq7eKA3xktrfRDIMJzQWaGV7OOKxaQblthaDbbCK1Xw/iliO8PQgRooH8SZ5lsDCi
         mzyRTLntvsc7Pb+fCCwSSZCdrLRkFBvJ1Dq0cXuMEFGQgqEAbPuVkzC1APBT6FMHlh+e
         JyMnwAWXNuZVj+Laos95XgJh6U0UPIYL+A3urX3CnZgWcSvS01ubpIu6yPVDcGaiy0Vm
         R1ENh4ISrLG1d0KR09UupOP04d1QHvKyvSQDjWXMl0NYngXto761BufEql6sS5ZDCvrK
         vXX+vw+psydz3TYwswd2c0bVlUyEq7TyVjO4ZD7CSzRrYTSjXkm3WCwoJLAVtYxGAlP/
         fFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X61HGDH96Cc493E0oH/ISkOEsapmYHYmJIpx51N0X8c=;
        b=LFsrwORJ3fIixDSu0zWzn5WHBYEObi3UVCAS91tzpiKBIdDPCrXrZzWU7eiqmVosXc
         t6+BsKqFDyJHldXXvMUkoZRyUzDDSEgpr07++JwEm2l9U0+9eh6PDkshdVW+Jg44GscE
         ZJF3TtH75S1/ovifC86TmfeTm8fY6cAbKaAX9IHMEB5m8KDcErPGLPSI38RjLwXByRuP
         oG1FaxGy4GRBU+0NblB8NiPhhFjPeRnBm5tVJrO/WR7AS8kulchyvh+lh8h60+n0JODA
         locsfsUK6UykP7xoyX0v0fG2oKQw++xO5W92RuITC7U3C7ySYzSlsglIn3zjLmwP2t99
         R+Xg==
X-Gm-Message-State: ANoB5pkfXqKBDKHwh9Ek0J5ZFD+Msr87tgiMMh/N/yKsMnlMZSNY5kH/
        ST8j1aaJ8dKOUBRM4S3kld7PrMnvdAW1GQ==
X-Google-Smtp-Source: AA0mqf6kDgPMzj0RSzG1fZUF2K1vgY/ndouaciI6qWR2fTkFRY6cRmJ/9796rwk+Yt3/RC/csA3FRQ==
X-Received: by 2002:a17:90b:228e:b0:20a:88c9:47ef with SMTP id kx14-20020a17090b228e00b0020a88c947efmr10256774pjb.9.1668713377739;
        Thu, 17 Nov 2022 11:29:37 -0800 (PST)
Received: from ?IPV6:2601:602:a380:3e00:9c2f:9cb5:3334:5a19? ([2601:602:a380:3e00:9c2f:9cb5:3334:5a19])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b0016cf3f124e1sm1711800plb.234.2022.11.17.11.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 11:29:37 -0800 (PST)
Message-ID: <a76a5e37-0c0a-b9e8-13cb-abaa44cf8911@gmail.com>
Date:   Thu, 17 Nov 2022 11:29:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: The enduring popularity of git-credential-store
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net>
 <AS2PR03MB98158D49DC655F6DC6D10ECDC0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
 <Y3aCx1SYq6jrYfuO@coredump.intra.peff.net>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <Y3aCx1SYq6jrYfuO@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/22 10:51 AM, Jeff King wrote:
> I do think having the docs say "you should go use X" means that X will
> have an advantage over other projects which may compete with it. So I
> think we need to be careful to be inclusive of what we'll mention, and
> to word it so that we're not endorsing any one project.
> 
> -Peff

Completely agree with this. I've long wished for a page on git-scm.com 
that's dedicated to (1) explaining what a credential helper is and
(2) offering a list of suggested helpers along with scenarios for which
each is best-suited. This could also be a good place to call out the risks
of using helpers like git-credential-store in a factual, unbiased way.

Thanks,
Lessley
