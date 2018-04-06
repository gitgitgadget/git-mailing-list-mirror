Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C89A1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeDFTmE (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:42:04 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33842 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeDFTmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:42:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id q9so1472428pff.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0PDkK846V0F4FqAT7D2JnZpBl8KOoCOT0ixCsgkL5AA=;
        b=UXL8UZM1IoHGCkkMXtKR+AxoeTyXjw+X1FBuR8ybH66kP22/BFRyXgdOMT5KOR7e0w
         HoddeMakfizdCK3o/Wx2e5VM2t0oB5iuGZg+e7UrQsFGkMCMVmB7wA9r5lim+8yAPYtN
         uu+DT3YUAZm7Mvp11MTLlrWj5u9a6sUC5LmC+ufwNTL1rC+OTMm/NRvXDjDYEZds9P57
         AXMb2zTBnmVbsvUCrfwrxBtecWv2J1s7B54+2q7K4/IEzmQ7ZQCp2DCEitxtx6cXNRTm
         3YqW+evolNct9MY7c41C9zcLWky7YKh6uQBf2n1yGAqIbeiT/vhA87HmloLekLP8H5Y0
         ABbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0PDkK846V0F4FqAT7D2JnZpBl8KOoCOT0ixCsgkL5AA=;
        b=EsyGwDE5YN3E/LuONTsx3CtuODz/nk+kaVeoCEFYLdAbEzLSMN/w+EY+JWCR3v6juK
         pnNUXmSDuqGY8WB7DfCAzINDkDyi7JgPe1HQ7bZ2DdZhaUaiUrMsSdOfRbDYKmactal9
         CnKNOm/YZZs8JiUKOjQ1RkP3JefdjymkuaI/5DeFyDTLIei+9noXx3W+VAzMIOexyB4s
         oTloTIVGYr4U/jEEXOzmy6KD/TqVUUpPnDxbGUpAyBwDFN0eBOHPZZKO9BBpblxFKhbK
         CaEeRTEdEVCBnMVoS8qBuGaG3iFxRWuU7vs6b0xujhY/q6l7jdbI+DvvsR1NQEMvf9f2
         /fDQ==
X-Gm-Message-State: AElRT7G7NUFzurefr9ybKcuDj1Qa/PP8uYqgLd9Uorluxdw+QNcR68Ey
        jRX8tjqiRKROC5rcBEoicyU=
X-Google-Smtp-Source: AIpwx49xy4X8P1LnGXjwkmjVpt6VwanupFnpIP3QkG2ruZ43F7o6xVWGmcXCMVeDhi6xd010iJNv1A==
X-Received: by 10.98.65.220 with SMTP id g89mr21260511pfd.97.1523043722904;
        Fri, 06 Apr 2018 12:42:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id e73sm24859987pfj.186.2018.04.06.12.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 12:42:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com>
 <20180406192146.GC921@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f3a8b9ff-4aba-100f-e59e-613f6a094513@gmail.com>
Date:   Fri, 6 Apr 2018 15:41:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406192146.GC921@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2018 3:21 PM, Jeff King wrote:
> On Fri, Apr 06, 2018 at 07:09:30PM +0000, Derrick Stolee wrote:
>
>> Derrick Stolee (4):
>>    treewide: rename tree to maybe_tree
>>    commit: create get_commit_tree() method
>>    treewide: replace maybe_tree with accessor methods
>>    commit-graph: lazy-load trees for commits
> I gave this only a cursory read, but it addresses my concern from the
> previous round.
>
> If I were doing it myself, I probably would have folded patches 1 and 3
> together. They are touching all the same spots, and it would be an error
> for any case converted in patch 1 to not get converted in patch 3. I'm
> assuming you caught them all due to Coccinelle, though IMHO it is
> somewhat overkill here. By folding them together the compiler could tell
> you which spots you missed.
>
> And going forward, I doubt it is going to be a common error for people
> to use maybe_tree directly. Between the name and the warning comment,
> you'd have to really try to shoot yourself in the foot with it. The
> primary concern was catching people using the existing "tree" name,
> whose semantics changed.
>
> All that said, I'm fine with having it done this way, too.

Thanks. As a double-check that I caught all of the 'maybe_tree' 
accesses, I ran the following:

$ git grep maybe_tree | grep -v get_commit_tree
commit-graph.c: item->maybe_tree = NULL;
commit-graph.c: c->maybe_tree = lookup_tree(&oid);
commit-graph.c: return c->maybe_tree;
commit-graph.c: if (c->maybe_tree)
commit-graph.c:         return c->maybe_tree;
commit.c:       if (commit->maybe_tree || !commit->object.parsed)
commit.c:               return commit->maybe_tree;
commit.c:       item->maybe_tree = lookup_tree(&parent);
commit.h:       struct tree *maybe_tree;
contrib/coccinelle/commit.cocci:- &c->maybe_tree->object.oid
contrib/coccinelle/commit.cocci:- c->maybe_tree->object.oid.hash
contrib/coccinelle/commit.cocci:- c->maybe_tree
contrib/coccinelle/commit.cocci:+ c->maybe_tree = s
contrib/coccinelle/commit.cocci:+ return c->maybe_tree;
merge-recursive.c:      commit->maybe_tree = tree;

Thanks,
-Stolee
