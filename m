Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3F01F453
	for <e@80x24.org>; Wed,  3 Oct 2018 12:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJCSwk (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 14:52:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34812 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeJCSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 14:52:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id x23-v6so5567772qtr.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RE6lbc1c2bxu8VMeYX3aFdCiyM8wDccPX+pGWtV5Glo=;
        b=c77UvkTUYr2kSXA0s+dZcxFj9NoGlMK6VzFdyV8thxg3dXbnvVhggL6YjJ/3cGMH6o
         zkntgQz5xqQO31m8UlnOczSWajQeBiIyVb1R+dMtmFH9L6jxWNzfHDYcApxlg4fHBQw4
         bXRtyLB+KfTujiIuBvRfPmmgSM8JFSv9VAkURVCUDPHKtUAcSEUKHUuJoh5r3xmRl0CS
         zxHQ62GT/CVy8yVYoY7upzBSdgVbmOP3oVOHycaJe19w2odhW3BTFnEChTZQ6vX5U8Fp
         r+fkB9pEmuOS0cAM1wKowgaGlmo1ulHJOTScFgnSgpC2uLeQnKtDFkK4zxqvTHNhmLIp
         HMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RE6lbc1c2bxu8VMeYX3aFdCiyM8wDccPX+pGWtV5Glo=;
        b=sysmIGh+57jKcpq1jQ9ZIWDHV/gWborTP/RHaVOeFFG25rr6CL/y1H8xqLCezn0egq
         jArl8lgWeaQH0y7MWvcda8WVUXXMP40cosaYThZ4Tizzw5uxwFhTLS2N3az7HvEICa+D
         llExFyRVyLpzIbj/8TzOaUIlHNA4o5qRQhPaLGFRqvbeZ/5M/oYIA1CiAqKBq3FLB4iI
         Ljcepf0xq5Z1tAElzfs9PKB77Np7fF22ALrYtdWhPVZp5+DtjTrmFWVQkhsd7N1ugnxS
         wGrRWPj2lRIoCiYHOZEvRhTM73TuuQqtFyb0YQb5BfrRZocNgaGWvwnlTezzVqprm6OF
         81Yw==
X-Gm-Message-State: ABuFfohI70dW3YHug+w6hYHWpqxGWNxkEESYG9E0RkDBk41kY2WpVxqw
        hegXQavhqJ3Q/hhODrSpdts=
X-Google-Smtp-Source: ACcGV62eqQDj5Yubsh4Sxqnw35B+KooD0Wp4PJ17EaVOMERPjMayVB4vaG5o5Y35loxoLoEI34g1gQ==
X-Received: by 2002:aed:3403:: with SMTP id w3-v6mr875284qtd.326.1538568272151;
        Wed, 03 Oct 2018 05:04:32 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:81f3:8f89:2be9:a31b? ([2001:4898:8010:0:6b29:8f89:2be9:a31b])
        by smtp.gmail.com with ESMTPSA id b10-v6sm512107qkj.25.2018.10.03.05.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:04:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] commit-graph: clean up leaked memory during write
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.42.git.gitgitgadget@gmail.com>
 <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
 <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
 <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
 <CAN0heSqOjYDXRf4KE_C0GDnFW8r4qVfWnUVuW-Q+4D87nhFURQ@mail.gmail.com>
 <CAGZ79kb2pE3pFQx4A=oo-mYORjN1ubCgV6Gotc78i7d+BqZdBw@mail.gmail.com>
 <20181002223434.GA5588@sigill.intra.peff.net>
 <CAGZ79kaatUeHEGnW9HXv7Xgsj1Sf_M6hcgQ_5oVAOM85rqn34Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1686b309-e0af-5518-0fa5-4635b2f481b9@gmail.com>
Date:   Wed, 3 Oct 2018 08:04:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaatUeHEGnW9HXv7Xgsj1Sf_M6hcgQ_5oVAOM85rqn34Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/2/2018 6:44 PM, Stefan Beller wrote:
>> My preference is to avoid them in the name of simplicity. If you're
>> using "make SANITIZE=leak test" to check for leaks, it will skip these
>> cases. If you're using valgrind, I think these may be reported as
>> "reachable". But that number already isn't useful for finding real
>> leaks, because it includes cases like the "foo" above as well as
>> program-lifetime globals.
>>
>> The only argument (IMHO) for such an UNLEAK() is that it annotates the
>> location for when somebody later changes the function to "return -1"
>> instead of dying. But if we are going to do such annotation, we may as
>> well actually call free(), which is what the "return" version will
>> ultimately have to do.
> Heh, that was part of my reasoning why we'd want to have *something*.
>
>> I'd actually be _more_ favorable to calling free() instead of UNLEAK()
>> there, but I'm still mildly negative, just because it may go stale (and
>> our leak-checking wouldn't usefully notice these cases). Anybody
>> converting that die() to a return needs to re-analyze the function for
>> what might need to be released (and that includes non-memory bits like
>> descriptors, too).
> Sounds reasonable, so then the consensus (between Martin, you and me)
> is to drop the UNLEAK.
Thanks for the discussion here. I'll drop the UNLEAK for now and think 
about how to remove the die() calls from commit-graph.c in a later series.

Thanks,
-Stolee
