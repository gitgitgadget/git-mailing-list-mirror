Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FBD1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbfFJXlr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:41:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35382 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390561AbfFJXlr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:41:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so12447924qto.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gb8YMSZVLE2H+rri3lOy/OhRvuw3nmeP2qFQ5ldeuOI=;
        b=Av3Cw8kVs01qXJl9gJ+ZQRQI2KE9gErBmR/6avxMZAdViF60/0QB3qxhyjibybC2X7
         OqrtiCz4Bg74Y/n9gwemncgU7boRRiqlYM92uewxXHuH56IOyaqRxkOyJqWIABtBr+Ty
         em/qkAuTrKImvtal0nGzORVe6ZIDQF23QlEXtRiVceg9mqnPeCvKT+MwegwipvyDzb0U
         piPuK8RxnXN7UhjUIjBe/aHlLL8tmy/aFQzn/mpznrK+E0t5IUwJNsQq1QaZf7cvcOMp
         ybMxqAxl5Jkj3oV6oPJ+UY3SZKuh5TnCh0Vf7B7BwgpuvNJBztiI1lYF/M2bA7tNNQPR
         bFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gb8YMSZVLE2H+rri3lOy/OhRvuw3nmeP2qFQ5ldeuOI=;
        b=VpnVL//1Ds3NfuYv0VUZOxBm1vSunnhzAPf4fSnmmnHjQHBUK6rpzOkMBxsMSNTtCK
         OLw4m5gpEa5MM2cYFWL+JNyLDOPW5/hNrxuKEf55mWD6VhZrWWyWjGjFC8IN4r8SiOr5
         zdrYMyLseea5crFYfjT08exOy/rQ5nVd+YWdBAY5nRBAg9mnB5oca1qBEH2vjM0noYYl
         xyDfb2q2pN0Roewnq9FFADtKYIb0Zl9lNECorS+YbYo9I7sKTwkFlMjGBpMqSiezYwp+
         DTv6CVKlcNnNC3xKofEwKw+RPuKpBgAdllP0/jSC3+dWILOABExzwRzstpcq8l2+Bzzz
         AHzg==
X-Gm-Message-State: APjAAAXFP8ref1Z6YEQgpEQ/e9rFdk1lXJVbKDtGzGLThuHZVeceb53o
        mZjsEJeUWiC/EnQSg+Wzuxk=
X-Google-Smtp-Source: APXvYqxsq+wvwRIvIvw83O3eHPErTO8VTOyiGUOCvjXrIR13WWNXYgR+68VyneuGxANh9C4KYro0sw==
X-Received: by 2002:ac8:6b95:: with SMTP id z21mr59575125qts.337.1560210106516;
        Mon, 10 Jun 2019 16:41:46 -0700 (PDT)
Received: from [10.0.1.7] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id s66sm5614840qkh.17.2019.06.10.16.41.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:41:45 -0700 (PDT)
Subject: Re: [PATCH v5 04/16] commit-graph: load commit-graph chains
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
 <pull.184.v5.git.gitgitgadget@gmail.com>
 <fc3423046b9b2fc43bf8323dd41281f0a29b9d0a.1559932699.git.gitgitgadget@gmail.com>
 <xmqqy329kt9j.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <74c1009c-748a-6e68-7c87-c03b01ebf885@gmail.com>
Date:   Mon, 10 Jun 2019 19:41:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqy329kt9j.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2019 5:47 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> +		if (get_oid_hex(line.buf, &oids[i])) {
>> +			warning(_("invalid commit-graph chain: line '%s' not a hash"),
>> +				line.buf);
>> +			valid = 0;
>> +			break;
>> +		}
>> +
>> +		graph_name = get_split_graph_filename(obj_dir, line.buf);
>> +		g = load_commit_graph_one(graph_name);
>> +		free(graph_name);
>> +
>> +		if (g && add_graph_to_chain(g, graph_chain, oids, i))
>> +			graph_chain = g;
>> +		else
>> +			valid = 0;
>> +	}
> 
> At this point, if 'i' is smaller than 'count', that would indicate
> that the file was corrupt (we hit one of the 'break' in the loop).

This is correct.
 
> How would we handle such an error?  It appears that the strategy
> taken in this loop is to "read as many as possible without an error
> and then give up upon the first error---keep whatever we have read
> so far", so from that point of view, the only thing that is missing
> may be a warning() after the loop.

Based on previous experience with the commit-graph feature, I am
deliberately trying to ensure the commit-graph feature does not lead
to a failure case whenever possible. If we can continue with the data
at hand (and maybe lose some performance benefits if we cannot read
a graph file) then we should keep going.

I believe that with this "only warning" case, the next write would
fix the issue. The chain builds only from the graphs that successfully
load. That way, this should be a "self-healing" state.

Thanks,
-Stolee
