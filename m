Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53184211B3
	for <e@80x24.org>; Mon, 17 Dec 2018 14:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeLQOUX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 09:20:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40332 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLQOUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 09:20:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so14171726qtf.7
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FS6/I7WZUvD6ldVvZyJyqHYWnxRVcgi6q7mK+A+MW8A=;
        b=XqSqGTN3JWlrUnpmC6AMJKvI6lkOhfpKY9JHNeiewbE5pp58e/S0MAHmfh8YL9PP08
         0dt2Eioum/lDphkZWtgeRuaPbrCDcvIYtSuoGaQiala/s+PdjrrfviL5bDpQx3ConnMo
         QCJuW6B9rUhjk5y4s874P6bATJLWAqBC0wlYWGMmhBeMlyBemByhCwCfwq1z6yGBEImT
         nJ89Vh26RvEnoZVULKYWLAkCFMsZMCb+iBEGf9nCDS/5t9Phskrz/wch40VwoEOrD9VQ
         VfaA+aWb2zTA2ZX417/mzjeRnwe2CU9KZg7ZwFWQJxjHrKhZTMQaeLT0o0hntfqPkF4T
         1n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FS6/I7WZUvD6ldVvZyJyqHYWnxRVcgi6q7mK+A+MW8A=;
        b=k9Bfe7kgVZjnu0Lz4jVH2l6K3Whn+L2OV0sJdfdvKx6wM/QBHLjn5WBl1BIcf1g9m5
         WRUPda0ZZVroLWqUPAWgjOCcVKyuR7RIBgqXYo4tOHX0Aa/YIvH9rw8vo079L5yRo4ea
         4YYwTtiY8Ko6KkpzlfXDSTYWS2ooINTnqEySppqzR8vI1GHMZx+Ok8s+Apo4ZQCXl1jE
         XlPmhZXiJwLLDDCHB9HXswplLKG3HTgBLRTaUYKAnUbWTbrs8OTYU4tZI+NOML3ZW0Nv
         klrupg7WOw/DF7g0SvC6C+oVJDtacsppV7adQ12v6F4CLMRHxqms4cS9/sOvi8/aXklE
         A2ww==
X-Gm-Message-State: AA+aEWY/nCRWR4zVYRndHTq3zAjrPR9gAAvs4NV/fejVIx0EmCgKCx2T
        MvwoKDYzYHekm/ptx3Kq/t4=
X-Google-Smtp-Source: AFSGD/XfFolCMkH3HN7J6NHN0zgyYCSNTKQ9gaLC5WIoHccJpFIhF23aTMkoIcgOM0dcKCwzfUVoHA==
X-Received: by 2002:a0c:d124:: with SMTP id a33mr13127245qvh.19.1545056421527;
        Mon, 17 Dec 2018 06:20:21 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b986:23f4:3544:4b58? ([2001:4898:8010:0:a2bc:23f4:3544:4b58])
        by smtp.gmail.com with ESMTPSA id t123sm5534902qkc.6.2018.12.17.06.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 06:20:20 -0800 (PST)
Subject: Re: [PATCH v4 4/6] revision: implement sparse algorithm
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
 <pull.89.v4.git.gitgitgadget@gmail.com>
 <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com>
 <87efaj1y77.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <867aa5c3-60e0-2467-795a-40aac58f306b@gmail.com>
Date:   Mon, 17 Dec 2018 09:20:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <87efaj1y77.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2018 6:32 PM, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Dec 14 2018, Derrick Stolee via GitGitGadget wrote:
>
>> Despite these potential drawbacks, the benefits of the algorithm
>> are clear. By adding a counter to 'add_children_by_path' and
>> 'mark_tree_contents_uninteresting', I measured the number of
>> parsed trees for the two algorithms in a variety of repos.
> We spend a long time printing those out before we ever get to
> "Enumerating objects".
>
> Which was where I was trying to test this, i.e. is this a lot of work we
> perform before we print out the progress bar, and regardless of this
> optimization should have other progress output there, so we can see this
> time we're spending on this?

It is true that part of the problem is that a 'git push' will sit for a 
while without presenting any feedback until this part of the algorithm 
is complete. The current series intends to significantly reduce this time.

As for adding progress to this step, I'm open to it. It can be done as a 
sequel series.

What would we use to describe this section? "Enumerating remote objects"?

Thanks,
-Stolee
