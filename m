Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682D71F42D
	for <e@80x24.org>; Tue, 29 May 2018 12:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933975AbeE2MhT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 08:37:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46802 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933935AbeE2MhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 08:37:16 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so10336560qtm.13
        for <git@vger.kernel.org>; Tue, 29 May 2018 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7zGw0n7LWVN1E+7Q5F5lWf3WIPG3BO4rDQzIcnHPQyE=;
        b=arT8DyWQw4+DOxYGpjaeSBoOi1EEU5bft5F6Bkn6kZlGmbzNyVRLH39xciA/o5M+pG
         qQcFEc4ZsxUCzJC4Sk4Wx4Gv/q4mPPjTM+VDjszD30r6u1OgUc81rndsPW6FoF0JpaaZ
         nsRBuxdufOwnzJGrUJUdbSarBMyFYgeCSoO4Ktk3P/H+g2MTDIYa6HRfQzc5+zXlauUw
         +Ph3qgl5HsNcBHtwuuKCy+W588oUhBX3M2KdNm9SZA3qNjGgkUkFyHr8yZoQYInNod2o
         xxkTSuZCtGMCjSA4U+ZWd7lXaAmt7iyoVtTqrHSdoL35+z3qXcJuLy/fUcGDXyYi5/Eu
         WS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7zGw0n7LWVN1E+7Q5F5lWf3WIPG3BO4rDQzIcnHPQyE=;
        b=LrZaDI3c+3wbA0Q2Y9cS03Bz+jhQ43ZZSkpYXkyNK1PT8BeJv4+hlFDgUsEtmXZR/U
         sth7D4nng42PZ5BQENhR7yWd1t45Fl7e0Jh+p680YvxdcaBhflLIBgpJTAHfpQrrl4f4
         B/XXLizdhUlvCI+mF051GSq0bMgd2mRsFOjMilXMbOXAHxl8EEi+CO5qdhR8Sos+yLAt
         U70n//N9PflMPKsdabhiehCggGa8IDPiwOdmQYRQf6mAH1lDmp8ZpdKFmFf3SzB9mNfr
         8hsjhg6sdMtPbCBkiVKOkHmc3JPg65ZpCr9a2BUK83MXzlAhdTdp+/c0+xybWO8T44kV
         rdWw==
X-Gm-Message-State: ALKqPwdXiI6+pMuvaxRdwG4D5nWJIbiAHLzYbTP9ViVxvdHwYrIvZTqS
        iqEFjbcFSiVcBPiTIm/vF7M=
X-Google-Smtp-Source: ADUXVKLrwL45GUOr7zt90zTXiXQtjQ7nWC+x1IVH477QmRltI+CAwCdc6k5c2/HYnp2oD8kOVoNfOg==
X-Received: by 2002:aed:3030:: with SMTP id 45-v6mr15484621qte.384.1527597435312;
        Tue, 29 May 2018 05:37:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:85b8:1327:9ae7:c654? ([2001:4898:8010:0:6eee:1327:9ae7:c654])
        by smtp.gmail.com with ESMTPSA id a64-v6sm23042552qkd.7.2018.05.29.05.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 May 2018 05:37:14 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] Integrate commit-graph into 'fsck' and 'gc'
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <xmqqzi0jgk70.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c5a11465-67ac-fbae-dbea-d20e6958bf1a@gmail.com>
Date:   Tue, 29 May 2018 08:37:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi0jgk70.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2018 12:27 AM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Thanks for all the feedback on v2. I've tried to make this round's
>> review a bit easier by splitting up the commits into smaller pieces.
>> Also, the test script now has less boilerplate and uses variables and
>> clear arithmetic to explain which bytes are being modified.
>>
>> One other change worth mentioning: in "commit-graph: add '--reachable'
>> option" I put the ref-iteration into a new external
>> 'write_commit_graph_reachable()' method inside commit-graph.c. This
>> makes the 'gc: automatically write commit-graph files' a simpler change.
> I finally managed to find time to resolve conflicts this topic has
> with other topics (of your own included, if I am not mistaken).
> Please double check the resolution when I push out the day's
> integration result later today.

Sorry about the confusion. I was operating on my copy of 
ds/generation-numbers (34fdd43339) but fetching just now I see you 
updated that branch to 1472978ec6. I reset my local branch to 
ds/commit-graph-fsk (53dd1e6600). The only diff I see between my v3 
branch and that commit are the changes from ds/commit-graph-lockfile-fix 
(33286dcd6d).

Thanks,
-Stolee
