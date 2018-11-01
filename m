Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2DB1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeKAWwb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:52:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37648 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKAWw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:52:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id d14-v6so21119815qto.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OlVswPtWENe+fvUxGQKEc2J/vup9/2RH9pZnTbe8PPc=;
        b=aZHiaPcBMHxRK5SNaMQmV93dprpX+5/mP1DCxmAUsMWZbmWjNoiAz2LfOm5qMG3ZEj
         cEpI6TR+owZHJwq9rUrVU1c4N97S7pf5GE4KqQVUrjw7OSMYHuFqtjlYYeHQt5Nvp4x2
         G+oIj2sxQ/D86pj4vZzWFaN6ml+iDGHAOGvKNYQkOFDSLwsrWfDTA5yElCJgwOEkMtdO
         r/n61Zgvo5a7pg4w+qtXxxm+zBASE9g1eiC4LBf52UKllERDA9OmdDB5w0oCEvPWGHX5
         z8NMQ43iT6ld0bbKCVTnCGqhRHgiB/vOKhcOcggJLmXHvUEhG+0zQ9GgZk6hvfwfmJnX
         6U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OlVswPtWENe+fvUxGQKEc2J/vup9/2RH9pZnTbe8PPc=;
        b=A65a8L4UhMEg90qoE1+9iDDMyzER2HpEDareoJ2vlty7NjrObrMJQFmX7XouOx1os2
         2cKkj29b40ONsKHu3yC4JusgYS4jjhjMRbb8PGv+C7nGSfBTSKnH6M9hVxPEV97ac+gT
         5FzHALRSMRwaNtdYxQ6+Fc9Bc/P3FMAa8Lbzfcplk619hftPMY8z8J9jabea9XGNKzOu
         te1uFFSGHulLL5GWWHOWx2MyYzgV86Vsrr6YOkwuI9AP2/QMYEUXEv3ryih39yTWle6K
         nRjBuhHFGp4e0AQ3e32EsXSbVk1HjdRGZDDgLu6O1mYS0AJqlwUyeV964olhKU36/GLj
         gBIg==
X-Gm-Message-State: AGRZ1gKMesCeBUAQLswplTyqhqhaOfRxz3gdAnvL7uXdqK4fN9nNXZsH
        xgecF+wAGEnzhfGA32F4Rxc=
X-Google-Smtp-Source: AJdET5dqnfPvW5QfdkUJi2jTWG/qrlRKA0tSJtswG54UtRmuGdY/ihIuci7kVHlozlQnCIBwZFq52A==
X-Received: by 2002:a0c:f648:: with SMTP id s8mr6824369qvm.122.1541080164040;
        Thu, 01 Nov 2018 06:49:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:eddc:3ff3:d342:de1b? ([2001:4898:8010:0:d712:3ff3:d342:de1b])
        by smtp.gmail.com with ESMTPSA id n101sm1061394qkh.61.2018.11.01.06.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:49:23 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Use generation numbers for --topo-order
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <pull.25.v3.git.gitgitgadget@gmail.com>
 <pull.25.v4.git.gitgitgadget@gmail.com>
 <xmqqpnvptlta.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9ffd8ecd-5595-ad19-cfe1-a268e3fa1bd3@gmail.com>
Date:   Thu, 1 Nov 2018 09:49:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnvptlta.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/1/2018 1:21 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This patch series performs a decently-sized refactoring of the revision-walk
>> machinery. Well, "refactoring" is probably the wrong word, as I don't
>> actually remove the old code. Instead, when we see certain options in the
>> 'rev_info' struct, we redirect the commit-walk logic to a new set of methods
>> that distribute the workload differently. By using generation numbers in the
>> commit-graph, we can significantly improve 'git log --graph' commands (and
>> the underlying 'git rev-list --topo-order').
> Review discussions seem to have petered out.  Would we merge this to
> 'next' and start cooking, perhaps for the remainder of this cycle?

Thanks, but I've just sent a v5 responding to Jakub's feedback on v4. [1]

I'd be happy to let it sit in next until you feel it has cooked long 
enough. I'm available to respond to feedback in the form of new topics.

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20181101134623.84055-1-dstolee@microsoft.com/T/#u
