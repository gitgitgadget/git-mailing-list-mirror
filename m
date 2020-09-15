Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B26C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727E62193E
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjh8rHxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgIORzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgIORzO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 13:55:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F2C061788
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 10:55:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bd2so1742978plb.7
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L88fmZMnYFpRzJgtUVh2lHoTcrSSYOtuIGZDsbVgDHA=;
        b=qjh8rHxTjCzWxcEbPj4UTpXyHIw777kwlHfhXvr7tIqlnUP/vaCG8Cb9lUDDinOXu3
         TnrVKVnBUkOxzKJ7TxpV7BC53w4pxa6fQGJuyMTQ5gDxnE9XQQEbEeEzxwCxQSQUgGna
         34pNRglW9O0qPasH0Ziq5c4FjAhATtqFEj4jqfG/b2Ja0+wWP61DlhoKxMgu7LwrKjOg
         mItKvTqi6kCiE9wU9p5Dxj9mgJDqoYVzjuIqifjYQu4G+sG6un2GWju4Jr+pfaOQK5fW
         JLOzB4pcjTslRZ9b14SSeAtkhbgGofYpQ0EDLZUMevI+djhS5iBGNTpFoNkaBinPNGJ5
         HTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L88fmZMnYFpRzJgtUVh2lHoTcrSSYOtuIGZDsbVgDHA=;
        b=FQPWZt1OaB3gOfNaYsd+M3dQdjH/uaeWFzlKTNDhd1w2U3/U0aXPVURCkyA1V+sQij
         ilkS6/0d80srNcFjnT6xx3MOqWj4lBSx6JbX6r+9Y4yBTFHNSJvr1fW3cxHt+E+4HG1p
         w/j3MT0bsTj/HVie4cntVketKA+OlH8FXtbAiNY6SqqjkaNYHtYXy903YJZcKIT2ks0u
         dQJsEAK8VNDyADIDfLE/aVYTaJhzIGrOlRhPim+LqWOTksy9f0+XLmmp8yXRjX04TAnN
         +2pfSExle59w7sFPaMNqONy0UY4yVSHKV/0kcCO+yhIUNukHRMSd9xxYH3V3Eflz3Mkp
         fASA==
X-Gm-Message-State: AOAM530knPwBM/+qa1uL+K1tupzsKzkBf5cb2GhlE8IcQyoSOPw80G2K
        23tHMTCyT6d/R7UJy+zJY3I=
X-Google-Smtp-Source: ABdhPJxT7hHagSkDDlZam7Z0ZYk8EuCzS8oAxA9I3p7rMy3Ce/ZhEHw5ZUtJlAuXJCMdvYyxXZcc3A==
X-Received: by 2002:a17:902:c692:b029:d0:90a3:24f4 with SMTP id r18-20020a170902c692b02900d090a324f4mr19916650plx.12.1600192512771;
        Tue, 15 Sep 2020 10:55:12 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.82.68])
        by smtp.gmail.com with ESMTPSA id f28sm14430851pfq.191.2020.09.15.10.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:55:12 -0700 (PDT)
Subject: Re: Git in Outreachy?
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com>
 <20200901125119.GA3250129@coredump.intra.peff.net>
 <20200903054126.GA2053272@coredump.intra.peff.net>
 <20200915173529.GA2859918@coredump.intra.peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <12c349f3-aeee-7e44-08fd-ae03b3f16dab@gmail.com>
Date:   Tue, 15 Sep 2020 23:25:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200915173529.GA2859918@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15-09-2020 23:05, Jeff King wrote:
> On Thu, Sep 03, 2020 at 01:41:26AM -0400, Jeff King wrote:
> 
>> I'm still working out funding details, but in the meantime we're signed
>> up. Potential mentors should propose projects here:
>>
>>   https://www.outreachy.org/communities/cfp/git/
>>
>> Sooner is better than later. We can technically submit projects up until
>> the 24th, but student applications are open now, and have to be in by
>> September 20th.
> 
> [Adding everybody to the cc list who has been in the Outreachy
> thread this year...]
> 
> AFAICT we still have no proposed projects nor signed-up mentors.

Just to ensure I didn't miss anything, a person who's signing up as a
mentor for an organization needs to propose a project or wait for one to
be proposed, right? Or is there some other way to express interest in
mentoring without proposing a project?

I ask this because I would be willing to sign up as a co-mentor for a
project in the organization but don't have any project proposals in
mind. I only see a way to "submit a project proposal" in the following
page:

    https://www.outreachy.org/communities/cfp/git/

> If you're interested in mentoring, the time to propose is definitely
> ASAP.
> 
-- 
Sivaraam
