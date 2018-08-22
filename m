Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6541F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeHWBIF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:08:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33451 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeHWBIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:08:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id i134-v6so556955wmf.0
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sNu1YmMgTNPzisCvqW2TolnPrnDXZqdtbsc3xc2eJcQ=;
        b=LUp9pje1wKe944SVSNKJkqhHoHUFxeiQpXzTORWtMCpUTHyPio2g2vBGyKyPQog6ED
         UIGUlHr/WMvrSpCVmpi13zr+UI9zfuNYSSVySmjKWcxsjsv6IplBKfR//DMWM2g2FHNT
         w4Dz/Sb9NS9CugfBI9fuc9J4TyHCM08Ooi0lmt4Py2nltaiiQWp2WGyh+8zCr7kld++f
         Tsna7mo+j2or9diKIdg0ZYlUOy25akwPMHDbbwfRHksp1Jj+wijTcArios57K1rHZd2H
         1GkZOVmula8XwSiJEJDEAdYLfdqgubfT/guUMd43JPvnmTqNIGn+FuS+rTcrHscHkDb0
         TJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sNu1YmMgTNPzisCvqW2TolnPrnDXZqdtbsc3xc2eJcQ=;
        b=ApLESQjLuVPKDZAhrnYhr3OnM7k1gE+Fp3JG1vN8bSjHmaJx5YdFcQIC/29o5Hpga3
         BQkK3zD8Yf9WLF4nX/IsQ1UKN2vXL8df10yPnc6FY6C8jOArqpmYl3zxsKqEdgROSA/C
         nBNgDydq9Oaf4jy1f7nkxSgZpWQQ17tJ/SXflLRU5i2kgLyxrc7UdqrlHyjVYs2iNYDy
         tNte5tBvzrvgf0LS+XE5swRVx0aacsAR7X6kmIhtXwC4+96hJOqRUIzJaUamAgv2oJr5
         Yk5ZFysiSHabhgHalPzQOQG3qLrQIjwXsCr8SGlICziTOUHvcMevsBi8udTZ449taTLd
         EKkQ==
X-Gm-Message-State: APzg51DeBTz4mzcfkqSKPwW3seJv6OX/3fBWHBHtAfB/xnDDtPTjtxb1
        yWp/SqCN5rA1UvoxdaZ76QM=
X-Google-Smtp-Source: ANB0VdaIz1/8e/Iy6hFzkuM4/mMZmQLRPLabZSiipR7uNXAmHNJkYicoq+UMcPMcbeSCPmCznfM9DQ==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr3533287wmd.44.1534974088183;
        Wed, 22 Aug 2018 14:41:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z16-v6sm1639138wrq.78.2018.08.22.14.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 14:41:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-list: make empty --stdin not an error
References: <20180727174811.27360-1-avarab@gmail.com>
        <20180822174820.12909-1-szeder.dev@gmail.com>
        <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
        <20180822192308.GB19730@sigill.intra.peff.net>
        <20180822195045.GC19730@sigill.intra.peff.net>
        <xmqqa7pem8ul.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 22 Aug 2018 14:41:27 -0700
In-Reply-To: <xmqqa7pem8ul.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 22 Aug 2018 13:42:26 -0700")
Message-ID: <xmqqva82krjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think this makes sense, but if we were to give a dedicated field
> in the revs structure, can we lose the local variable at the same
> time, I wonder?
>
> Thanks.

Well, the answer to "can we" is always "yes"; what I was truly
wondering was if it makes sense to do so.  I am on the fence.

>
>> diff --git a/revision.c b/revision.c
>> index de4dce600d..4d53102cf4 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2369,6 +2369,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>  				}
>>  				if (read_from_stdin++)
>>  					die("--stdin given twice?");
>> +				revs->read_from_stdin = 1;
>>  				read_revisions_from_stdin(revs, &prune_data);
>>  				continue;
