Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C708A1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 16:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405922AbfIFQso (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 12:48:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42415 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfIFQsn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 12:48:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so3797543pgb.9
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gJ1eGZk61T/KtOzo4yoH+k1Q4Zotss9NscqDgBFRgUw=;
        b=SPnShSU6p31l4QEDu0pZ8h7Zn3gZbPU3nFqMAIjPD5yvgItGPmOue5WCbnNgQQWcZ+
         H6V3pO4fRCjHU1cZHbv3UtEvLiXsDvlo/pnh6Ww2KHj9Kbrf1ONBZU7oV85dzAkXTNFC
         cewcM+HTHC4Fnbj/ekvlOPWdBSNveiMGpf0PdmfY9bW11sDajqw8u5Xdc8X4qIZqzJhb
         jie1t6ld7zuKIeD+3gtuiAdBLmQaTScFNp5/ZQPe5G3TXKQpNinS1HVUb9gYaTa/mkvO
         wJQlQuQxJX+XDXXPpq7hHiyvxGCA8sPhofZK62vTgDiQ8MPQ8rxqVq8Y0eX+5ID6MO7r
         /5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gJ1eGZk61T/KtOzo4yoH+k1Q4Zotss9NscqDgBFRgUw=;
        b=HmcqThqSFlwpmtTSIqnvVCRRk0dbNExRsfjIQG5gWDBZ8ri4BkSWS2J3+yQEiTr52+
         grhoIa5UWt6nwOWvT6NPcbf4CJtQJrPk0Q9EZpUm1T/lbwAabFcwqq0dwCDyUfgYaIZ8
         WVDJd2FLAtbEgXWzdHEFJPdJuDm1aKKMkPslVX0mkbdwYIR1Wpvwakuu+IQ6TwoifMVA
         obX1JH8p62nMTvlSJxCpYf2K9fxMu2fhGr7/7MhlYgebasR4bRpSMOPL0l7IbYPDMeTs
         0TiQcFlPpP4tCuTqXkZITzJaT+mXh7HKjIshjflh+xcBG4YnMXhPirsJFDEmjormbQpQ
         n51g==
X-Gm-Message-State: APjAAAVEbZ/IPgYiLdAEjulSCgnyvc4yuhX7VVBBOVuZufzHyjvKypaw
        Py+dvVEtB7fFK3tpq9bmn7E=
X-Google-Smtp-Source: APXvYqwVQp3i2fI0UF9mfrOe3Cl5XFDIyxfbzxWfBgO9cqi6j0QvljcMn3xtafdlEWqVUi300nbcgA==
X-Received: by 2002:a62:d45a:: with SMTP id u26mr9473794pfl.137.1567788523176;
        Fri, 06 Sep 2019 09:48:43 -0700 (PDT)
Received: from ?IPv6:2603:3023:803:400:4c28:4024:4b1c:1fde? ([2603:3023:803:400:4c28:4024:4b1c:1fde])
        by smtp.gmail.com with ESMTPSA id z4sm5413379pgp.80.2019.09.06.09.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:48:42 -0700 (PDT)
Subject: Re: [RFC PATCH 0/1] commit-graph.c: handle corrupt commit trees
To:     Taylor Blau <me@ttaylorr.com>, Garima Singh <garimasigit@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <cover.1567563244.git.me@ttaylorr.com>
 <c5ba4eaa-f995-5f2e-4f0f-a8f59ba65fd3@gmail.com>
 <20190904212121.GB20904@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a2f6d2d9-e7ea-addd-97a0-f05fa3f1be51@gmail.com>
Date:   Fri, 6 Sep 2019 12:48:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190904212121.GB20904@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/4/2019 5:21 PM, Taylor Blau wrote:
> Hi Garima,
> 
> On Wed, Sep 04, 2019 at 02:25:55PM -0400, Garima Singh wrote:
>>
>> On 9/3/2019 10:22 PM, Taylor Blau wrote:
>>> Hi,
>>>
>>> I was running some of the new 'git commit-graph' commands, and noticed
>>> that I could consistently get 'git commit-graph write --reachable' to
>>> segfault when a commit's root tree is corrupt.
>>>
>>> I have an extremely-unfinished fix attached as an RFC PATCH below, but I
>>> wanted to get a few thoughts on this before sending it out as a non-RFC.
>>>
>>> In my patch, I simply 'die()' when a commit isn't able to be parsed
>>> (i.e., when 'parse_commit_no_graph' returns a non-zero code), but I
>>> wanted to see if others thought that this was an OK approach. Some
>>> thoughts:
>>
>> I like the idea of completely bailing if the commit can't be parsed too.
>> Only question: Is there a reason you chose to die() instead of BUG() like
>> the other two places in that function? What is the criteria of choosing one
>> over the other?
> 
> I did not call 'BUG' here because 'BUG' is traditionally used to
> indicate an internal bug, e.g., an unexpected state or some such. On the
> other side of that coin, 'BUG' is _not_ used to indicate repository
> corruption, since that is not an issue in the Git codebase, rather in
> the user's repository.
> 
> Though, to be honest, I've never seen that rule written out explicitly
> (maybe if it were to be written somewhere, it could be stored in
> Documentation/CodingGuidelines?). I think that this is some good
> #leftoverbits material.
> 
>>>
>>>    * It seems like we could write a commit-graph by placing a "filler"
>>>      entry where the broken commit would have gone. I don't see any place
>>>      where this is implemented currently, but this seems like a viable
>>>      alternative to not writing _any_ commits into the commit-graph.
>>
>> I would rather we didn't do this cause it will probably kick open the can of
>> always watching for that filler when we are working with the commit-graph.
>> Or do we already do that today? Maybe @stolee can chime in on what we do in
>> cases of shallow clones and other potential gaps in the walk
> 
> Yeah, I think that the consensus is that it makes sense to just die
> here, which is fine by me.

I agree the die() is the best thing to do for now.

If we wanted to salvage as much as possible, then we could use these
corrupt marks and then use the "reverse walk" in compute_generation_numbers()
to mark all commits that can reach the corrupt commit as corrupt.
We would then need to remove all corrupt commits from the list we are
planning to write.

However, that is just hiding a corrupt object in the object database,
which is not a situation we want to leave unnoticed.

Thanks,
-Stolee
