Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA8820248
	for <e@80x24.org>; Fri,  8 Mar 2019 01:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCHBJF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 20:09:05 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36981 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCHBJF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 20:09:05 -0500
Received: by mail-wr1-f52.google.com with SMTP id w6so19578540wrs.4
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 17:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5lau9zGp+307EV43NQp+9fPZ3X1/PHQ8jv2YKnWwzz8=;
        b=QE23qKbgw93ucJ+UwbFJ7ZhoU3vmd99WMNsChIO7JXPrbZsptI/ZfvUFWwlxD1PIh2
         XvxottgREcLNaS3HUVoPaydJBDsHyiaAjfuV5Mt6qx5Hc3OSViLuxVjQ4arAIq6s80AK
         A+jykRqlpHz5lmhk/y1attt3NK29iFK1TnW78Qj3m2BCjbbGcmCu+5SPhCayHwaZXX8D
         oNPaL0cTJXrK8mF9tGnO/eh2T8BL44aTuWL0HoeGexIU5Lmm4/DPPICRhxuuYkk0RLid
         CeGWiB2PFQUwEfpS6E9vzc9o2EGaK3RchoVHlaYisx9fgZ3iKkkTEM4EYLXxlXlXtbuh
         gVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5lau9zGp+307EV43NQp+9fPZ3X1/PHQ8jv2YKnWwzz8=;
        b=gogqBkrUFVFOUgUAdCGj1qCmJbMYbAxdH+yBZIRtmprjIxbcwc6omePGbTmNPFNVQ8
         QGO4kHgJ+CPebuAr/yKY70O8djgaIr0WRgQwn80DjUNm+jAWuGEBMGu8c6eAeg7BeJ++
         2aIHXVXR5xSVFE3j8uADqbP5S6G/cZFiUt26e7I/Mvi3uoFGOgRjGOiLehNDcEvOrjS7
         epTofZM/Tj3Lnux//1vRZkfoVKY0DgEuUnNV/nM8dx5dp/3aJz8+gkq7J+De1B4116/7
         Hh3nlH2cjam8MpnUgDdEVQSq73TKr5dco7PiE+++YR9gT/r9bcsthEpOXXPazDv/MtFN
         kC/Q==
X-Gm-Message-State: APjAAAWbMFBMrxex9pTo1FnTcv6DxFxFvg6RvJJMUrwzqOa+cWZZv2Ko
        VvIzx6oUCX6rZTr40km6Jt8=
X-Google-Smtp-Source: APXvYqwL8IghP19xmgIZguQzRLcTmV5LVvoRxN2pcs1pCJefmiyKkxxBzHniPXzqod75XTJ/u3zrNQ==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr300729wro.185.1552007343393;
        Thu, 07 Mar 2019 17:09:03 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a204sm6854447wmf.12.2019.03.07.17.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 17:09:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Huynh <alex@grande.coffee>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] fetching all remote branches results in failed multiple updates
References: <20190307214447.GA4909@chabuduo>
        <20190307234015.GD28939@szeder.dev> <20190308000810.GA8044@chabuduo>
Date:   Fri, 08 Mar 2019 10:09:00 +0900
In-Reply-To: <20190308000810.GA8044@chabuduo> (Alexander Huynh's message of
        "Fri, 8 Mar 2019 00:08:10 +0000")
Message-ID: <xmqqef7ikw9f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Huynh <alex@grande.coffee> writes:

> Thanks for the clarification! One question: should we update the documentation
> at https://git-scm.com/docs/git-fetch#CRTB to not list this as an example to
> follow?

The example itself is valuable.  The way it is labeled might be
misleading to some people (although personally I do not find it
so).  It says "Typically such a variable may look like this" and
shows the fetch refspec that is given to a repository cloned from
anywhere by default.

I think it might help to update the text to clearly state that the
sample one is what you get in a clone without doing anything
special.  The example is primarily there to show you how each part
of the fetch refspec is used in the operations described in the
following paragraphs,and it is not there to tell you that you have
to add duplicate yourself to make these things described in the
following paragraphs to happen.

