Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240481F424
	for <e@80x24.org>; Fri, 20 Apr 2018 11:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbeDTLvj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 07:51:39 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34467 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754619AbeDTLvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 07:51:37 -0400
Received: by mail-wr0-f176.google.com with SMTP id p18-v6so3070988wrm.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 04:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0fYZio32QGd5BO1zn14lZVFH2E414iHiVaWQmCpqYqU=;
        b=Tmvi3v1vzkJ0by1pxZc8imJ3EoIKalLCYveADiT/uduJkoseH72ug4YKUbjZubB72K
         6q8zU1zVEvNVFxSQ88TP/JQAPv771YcbFI2pu39NxxrxvCl8Bxyyqax5z7ZfCrI90d10
         nxGz9aUNVUCV3YbIZ+HVXoZf717ROl4n/2fvw309TswRTmoaMfdfhAwUr9qAfXMCx4ml
         juPJftQTT/TzTd6ToUG19fLdAZY6ptd7oXgyrLfg6GcfcsscYzI9T7JlJjK/Pmudb+8J
         jeDeDAmx0p1sKW1G5EndbDucSa4YObrGYAx61RPs3ukKvjpNUm2zaEX3DqsX/pjn739P
         EHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=0fYZio32QGd5BO1zn14lZVFH2E414iHiVaWQmCpqYqU=;
        b=Y7lybpqb5R0cVj2w/tmcngxX6uvSFR+jH7s+MS0r6lXgt6Qqg9pjrm8dv0tR/mP/pd
         B/rcXCNSdHWXoAa0P1LtkG8e4PNtzFvPa/LozWDhEKll4mbG+5EgpCqnEMfPNm+S8U8o
         pq/g8jGpf1phGut4qDrW4m9Npst/LfB+5nITgEZr/FBnc4MDCOvxRoGFD0qELw+z8C/y
         EKDsQtfAUxEmZpmZ02/96vCLYh5JCeRYfxO1OSpF5jururCPbRBHpEE08pro2XF+v6J0
         YS9tPN1MOvPvc+xISInGuF+lzwtMjtE8896lIkh0kEdKQ4jdKvL8EEg8esIexhFajHMa
         q6wA==
X-Gm-Message-State: ALQs6tBOlYam8FJyBg98Tw4IpOx40I+GyrsIyyKPajhQrtHrKid4IMZ+
        Axhy6Pj9ktQR5lg95z3CK5Wv3ogh
X-Google-Smtp-Source: AIpwx4/cjro+nggRgUb+b0k3qV8o7JvMN1klnvyzFpro3tunQ5ZOEfDp5aIfOPKvnMYtJXq4J1lAIA==
X-Received: by 10.28.225.130 with SMTP id y124mr876837wmg.57.1524225096592;
        Fri, 20 Apr 2018 04:51:36 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id o101-v6sm8028381wrb.44.2018.04.20.04.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 04:51:35 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] replace: "libify" create_graft()
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
        <cover.1524125760.git.johannes.schindelin@gmx.de>
        <1f1c64314088383570dd2232e08a88c8df3298f5.1524125760.git.johannes.schindelin@gmx.de>
        <xmqqh8o6d8rg.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 20 Apr 2018 13:51:34 +0200
In-Reply-To: <xmqqh8o6d8rg.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 20 Apr 2018 09:25:07 +0900")
Message-ID: <86zi1ydrjt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> It is quite convenient to simply die() in builtins, in the absence of
>> proper exception handling, because it allows us to just go belly up
>> without having to implement error handling chains.
>>
>> Of course, for reusable library functions, this is a big no-no, so we
>> (try to) restrict the usage of die() to one-shot commands, i.e. places
>> where we know that the caller does not want to, say, give the user a
>> useful high-level error message, i.e. a message that the function calling
>> die() could not possibly know.
>>
>> The problem with this reasoning is that sooner or later, pretty much all
>> useful functions will *need* to be libified: the more useful a function,
>> the more likely it is to be called from a call chain where the outer
>> function implements a high-level operation that needs to provide
>> additional advice to the user in case of failure.
>>
>> This is the case here: the create_graft() function is useful enough to be
>> called in a loop, say, in the upcoming patch to convert a graft file in
>> one fell swoop. Therefore, this function must not be allowed to die(), nor
>> any of its callees.
>
> All of the first three paragraphs are already widely known to the
> project, and I do not think you need to verbosely repeat it, if
> brevity demands it.

[taking the role of Advocatus Diaboli]

Well, this information (first three paragraphs) is maybe widely known to
the project, but do we have it explicitely documented somwehere, like
CodingGuidelines, or FAQ on some web site?

> One thing that the proposed log message for this step would be far
> more useful to say is that the current callers of create_graft() is
> fine with the behaviour change (i.e. prepared to act on an error
> return).

Right.

>
> Also it may want to say why the other die() we see in this function
> in the pre-context is OK.  I actually think it is not OK and should
> return error(not a valid object name) the same way (I suspect that
> this is mere omission/mistake, and you did not intend to leave it
> dying).  As long as the caller is prepared to deal with an error
> return, that is, which was the previous point.

[taking the role of Advocatus Diaboli]

Maybe they are errors that caller cannot handle sanely in any way?
If I understand things correctly the problem is with parameter to the
--graft option...

>
> FWIW, I fully agree with the goal of making this (or other pieces
> that would be useful if they were reusable) reusable.
>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  builtin/replace.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index 935647be6bd..43264f0998e 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -395,7 +395,9 @@ static int create_graft(int argc, const char **argv, int force)
>>  
>>  	if (get_oid(old_ref, &old_oid) < 0)
>>  		die(_("Not a valid object name: '%s'"), old_ref);
>> -	commit = lookup_commit_or_die(&old_oid, old_ref);
>> +	commit = lookup_commit_reference(&old_oid);
>> +	if (!commit)
>> +		return error(_("could not parse %s"), old_ref);
>>  
>>  	buffer = get_commit_buffer(commit, &size);
>>  	strbuf_add(&buf, buffer, size);
