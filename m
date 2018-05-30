Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010411F42D
	for <e@80x24.org>; Wed, 30 May 2018 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeE3TS1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 15:18:27 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41140 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbeE3TS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 15:18:26 -0400
Received: by mail-qt0-f193.google.com with SMTP id g13-v6so24723863qth.8
        for <git@vger.kernel.org>; Wed, 30 May 2018 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RSD5LMhryaY4zzmYq7e0lgstdkfGE9QcH4MY4AKM1Hk=;
        b=lFY1xzspCWDrlG60s57Ln3ZYo9ReChjwH18Vqu06WmYJa51iJiOk0ox6sQJd2qt6T7
         gwo1CRkhqeuYKMNtOvmfORxkq0SU3/MiaCDICabk73qJcVoqgXuAO+jwm5SCNgpnPgXr
         nLQZFwWedHcQymhAwANvlP7AcAM87GZb8qBghF8NgNlX8HDgsnFjOyjQ/C5KLzuctknA
         SXTKbdn6A9PMs09hbxeIFttScJ+70zw6rhq9Nqv86plPtQaPV0J03e1v/ot53UYyH/Sa
         IRp7vfzTqo8n03i/ojyuKSAD6/vrOViMpBVPcMvATw5Y8vDTVyxIGV8GaJit2pSv1mgg
         49ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RSD5LMhryaY4zzmYq7e0lgstdkfGE9QcH4MY4AKM1Hk=;
        b=k5qwtLQGPC1q8R2A52W4eKXLJbGTtlhEJEamk0wBHTg9deOIrvt9XND4SB9tN2N8td
         zTVKFy8a6pqoOYWT1BiHcaAf0qwNAwGtgXIvyaZ1V4tsUA5vUBRowX/BJeqE521uThS5
         yZC0zX+9S7mh0qGAEt5oVXBF2EP6S0RGMcqioYhdsdsCIkLt8gn1PqYu2ItQf4fvExwJ
         xZfECgDvqJZhp7fUJ+WkpgSYANz1FlHNcvPCE4hQ33qtOU9JjQCq4zCoAEamcNLY2a8x
         +TIoctSn1u7DSrHyKqfh02XsRKzPLvCXVzP0L3K5Cb8mjkGWCgqReaagsGju6m6NP7E2
         sSLA==
X-Gm-Message-State: APt69E10MMMLFeLHoVBLtjTG8PH2kH9A2oVz34ZOXQcMG5rJ7UylazWr
        00dyhyFt7uC/NmHbNOuNmKY=
X-Google-Smtp-Source: ADUXVKLqbLEttrfkn5duOL29XpO3FUjdrc07RFWo9kepZXHQGNegzfrBub9yxHtT4ZGafcZBrFVycg==
X-Received: by 2002:a0c:a465:: with SMTP id w92-v6mr3855126qvw.46.1527707905917;
        Wed, 30 May 2018 12:18:25 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 141-v6sm11162126qkn.38.2018.05.30.12.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 12:18:25 -0700 (PDT)
Subject: Re: [RFC PATCH 00/35] object-store: lookup_commit
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <627c65a9-d807-8912-b96d-ef7feecb9ea4@gmail.com>
 <CAGZ79kaEHhE=suT2-Rzrbu2P7z8KPzRdCOFNCTqsOiV0+HjJ9A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6e18e6bb-cc11-a1b4-becb-4115df124284@gmail.com>
Date:   Wed, 30 May 2018 15:18:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaEHhE=suT2-Rzrbu2P7z8KPzRdCOFNCTqsOiV0+HjJ9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2018 11:18 PM, Stefan Beller wrote:
> On Tue, May 29, 2018 at 6:05 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> On 5/29/2018 8:47 PM, Stefan Beller wrote:
>>> This applies on the merge of nd/commit-util-to-slab and
>>> sb/object-store-grafts,
>>> and is available at http://github.com/stefanbeller/ as branch
>>> object-store-lookup-commit
>>> as the merge has some merge conflicts as well as syntactical conflicts
>>> (upload-pack.c
>>> and fetch-pack.c introduce new calls of functions that would want to take
>>> a repository struct
>>> in the object-store-grafts series)
>>>
>>> As layed out in
>>> https://public-inbox.org/git/20180517225154.9200-1-sbeller@google.com/
>>> this is getting close to finishing the set of object store series though
>>> the last
>>> unfinished part of this RFC hints at new work on the plate:
>>> * To give this series a nice polish, we'd want to convert parse_commit,
>>> too.
>>>     But that requires the conversion of the new commit graph. Maybe we need
>>>     to split this series into 2.
>>
>> I'll take a look at this series tomorrow. I've been working in
>> ds/commit-graph-fsck to make many of the methods take a 'struct commit_graph
>> *' parameter, which could easily be 'r->commit_graph' for a 'struct
>> the_repository *r' instead of the global 'commit_graph'. Those graph-local
>> methods will make the transformation to be repo-local a lot easier. (There
>> still may be some need to insert a repository, though.)
>>
>> Since you are working on the commit-slab stuff in this patch, I'll (continue
>> to) delay my patch series on using the commit-slab for generation numbers to
>> avoid collisions with your work.
> This series touches the commit slabs in the last few commits only.
> I don't think there will be huge conflicts, as all I had to do was
> move the definition from a global to inside the parsed object store.

I went through the whole series and didn't find any issue with the code. 
The commit messages reference coccinelle scripts that I never saw, so 
those should be struck from the messages.

If anyone else plans to review, these two commits are worth special 
attention compared to the others:

[PATCH 27/35] commit-slabs: remove realloc counter outside of slab struct
[PATCH 28/35] commit.c: migrate the commit buffer to the parsed object store

I found no issue with them, but they do actually change behavior slightly as opposed to the other commits which have no change other than to relax the dependence on the_repository as a global. I also like the pattern of storing the slabs inside the parsed object structure in the_repository. I'll use a similar pattern when looking into using slabs for generation number.

For Junio: I know this will conflict with ds/commit-graph-fsck (specifically, I add new references to lookup_commit() and manipulate parse_commit_gently()). If this series is ready to be queued quickly, I can rebase my v4 onto these commits as they are placed into 'pu' (and please eject ds/commit-graph-fsck at that time).

Thanks,
-Stolee

