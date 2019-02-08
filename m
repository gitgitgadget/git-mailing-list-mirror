Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61711F453
	for <e@80x24.org>; Fri,  8 Feb 2019 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfBHRut (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 12:50:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40471 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBHRut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 12:50:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so4392162wmc.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 09:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cOY6g94abOEWmxoithxCLiZiWCLW2Bp4pCS0OUbIFAg=;
        b=fz12tvGlw1OIERAu0kRv+zsKf+bTbjJDzTXBp9pVuq0j0+aAp0wAh/af7Zk531L3PE
         qBoobjuPAodJEAzfLpk3ahiHsyWkVG24xC8gO4RbQRELgZ8AlkCL6pf17oDEtwlYz2hF
         kfLVoTCPNqZts8unX8uw5Bx894NG5sM8tzRc3g2Vc+P2SVhXk9B6p3UtQ+cynSUoCIDn
         APFc06tEXWv2UM+VJo0p8pQIUUT0i3BP2W6SYGBI0BPvO7NTxzoxA4HF3SE3lRNNjyzf
         dOxuIpd2Vc0XKV9CnKGQwlQx3Lo8XvPlRCP2gmi9iChDl6NsRW2d85e+lCLgr9+p7q+7
         +kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cOY6g94abOEWmxoithxCLiZiWCLW2Bp4pCS0OUbIFAg=;
        b=AXImBG9+YtIGJyuXAuyQi6YNLmpJfG6szF7muAsOSoASiRZ4JtrKWQqfC+b8EgQXk0
         TCu6s7EvHPWze7gY0C6NGr0SkLebJO8WBh8pkoXIMrFX+iQUWHPJJn28areRdi7xZ0dB
         UF2U6F4+LiORJ5839z9/OANaYF39HlYseQcN28FBwuCtx0DIucBebPGNXOsy51tAK5Lw
         xbNioPBy1kB188Q7GkMmsPTPToQdjEg4rtnfSvWlGzxLJ+ngKHZ/xrbTEvMupobhwIw+
         qjeEyY72xoLpmqFOFCS0LrLqFjfGOJeri9AaU5s1s+AN/NqxZNNZXeoxTWKePW7XgFxr
         aaRA==
X-Gm-Message-State: AHQUAubsHReyBLm4Eq0WhZFMv3ymXC331XbXAeOBZklQf/w3v8aWTnkV
        cGK7s7tzz6kCl71SP14jxGk=
X-Google-Smtp-Source: AHgI3IZC8bcb2Maa4a3HAU5mzfNEW0qH77c3zmpgtdJQBP6YGowPNAQBtcjAC0s0GTPJBQqWskfmKg==
X-Received: by 2002:a7b:c945:: with SMTP id i5mr12911953wml.33.1549648247216;
        Fri, 08 Feb 2019 09:50:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x1sm1365414wru.34.2019.02.08.09.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 09:50:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 1/2] log,diff-tree: add --combined-all-paths option
References: <20190204200754.16413-1-newren@gmail.com>
        <20190208011247.21021-1-newren@gmail.com>
        <20190208011247.21021-2-newren@gmail.com>
        <xmqq8syrlyj5.fsf@gitster-ct.c.googlers.com>
        <CABPp-BECeDCKpcM6DExxbPrn41k_VVqVik=z8WWU53eoFNM0jA@mail.gmail.com>
Date:   Fri, 08 Feb 2019 09:50:46 -0800
In-Reply-To: <CABPp-BECeDCKpcM6DExxbPrn41k_VVqVik=z8WWU53eoFNM0jA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 7 Feb 2019 22:52:03 -0800")
Message-ID: <xmqqmun6kw3t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Feb 7, 2019 at 8:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > +For `-c` and `--cc`, only the destination or final path is shown even
>> > +if the file was renamed on any side of history.  With
>> > +`--combined-all-paths`, the name of the path in each parent is shown
>> > +followed by the name of the path in the merge commit.
>> > +
>> > +Examples for `-c` and `-cc` without `--combined-all-paths`:
>>
>> s/-cc/--cc/
>
> Thanks for catching that.  I was going to go fixup and resubmit, and
> drop patch 2 while at it, but it looks like you've already squashed
> this fix in to commit d76ce4f73 that you've pushed out to pu.  Do you
> want to just drop patch two from that series and call it good?

Sure.
Thanks.
