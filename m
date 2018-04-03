Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288961F404
	for <e@80x24.org>; Tue,  3 Apr 2018 12:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbeDCMPN (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 08:15:13 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:40354 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 08:15:12 -0400
Received: by mail-qt0-f178.google.com with SMTP id g5so18876769qth.7
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=60kji29airkCsFUYP+i/MDUd/EcKmVwLLVzLqrECKL4=;
        b=AGNI1VpL651SwdmFMxQpMTiah6EeSk2NYpOfCPja8rFuirQREjV9IFPlr3qlpC9AU0
         gdWJ20dxSiojDqfUEPtKXUGtJdMXXmZYFYHLPKM9ZxpIZfRzEf4M/vT20BM1qpQzjmcU
         trUjZloRkhsECferiI2c6xMa+iWTu4BX8C3upk3hF0d+wTrxtAp1ilLUK2N0k3XW/H4L
         7NikH26zP9rIIIv54Rs0C+jdBO+x3TBvR40CWbys2SfiYifbO5ppqbmlSQEkTWzRKx0S
         bn9ag/7XgaPomfZ5FhXYhyG5S60ycbhL9QOrw4eniG4F4S6d6yE+O6bp6BZJcTBLHCQZ
         F/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=60kji29airkCsFUYP+i/MDUd/EcKmVwLLVzLqrECKL4=;
        b=NnirtoIEesWmUEH4h5sxiG4TM1GOtP8W4Zxb2CcwpGuC2Jiit3MpevvRf/ZtcxjVnR
         c8hxzGmWSsjE8O14TfMrZBRtcadWC5LYvifoComPsKVM1+1tV8brAskld62dgsxOcnjH
         352vot477OuSi7z6kg8iHwQHBXJcxmm0qKRbx/qz/396G9w0tKUu6y58Ky1vtgiYiAyO
         508W/TS7SBu2WfeKsQlpU501LXvzo/Ebh8H70pyNg8TImbD5BYf7R4uWm89k3i4S8IuD
         P8ZT3YhJMcij7hqUCxFAMqRl4kK4PdidNzMZrQiFUmxVfq/C4/fzvYR8CMnZFLVg+BnB
         jPng==
X-Gm-Message-State: ALQs6tCl0F1KVxhRO2RpYh7VTXJFwWhQobIn7jjTQbsTi1+C4mdamM+6
        4sGrSsooUuyz7xqHUAdNCR8eTDjQg7U=
X-Google-Smtp-Source: AIpwx4+rw/nYOM+Iw9+FZoEHeHnvx16Bh404Oydxf0DUbiS3XPXVMVRfFOBaSPMx/nYG47rqoz0wMw==
X-Received: by 10.200.102.71 with SMTP id j7mr6908503qtp.189.1522757711573;
        Tue, 03 Apr 2018 05:15:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n30sm2176002qtb.93.2018.04.03.05.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 05:15:10 -0700 (PDT)
Subject: Re: [PATCH 0/3] Lazy-load trees when reading commit-graph
To:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
References: <20180403120057.173849-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <00d5cd22-3492-73cf-3493-1f6f1ec15922@gmail.com>
Date:   Tue, 3 Apr 2018 08:15:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403120057.173849-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 8:00 AM, Derrick Stolee wrote:
> There are several commit-graph walks that require loading many commits
> but never walk the trees reachable from those commits. However, the
> current logic in parse_commit() requires the root tree to be loaded.
> This only uses lookup_tree(), but when reading commits from the commit-
> graph file, the hashcpy() to load the root tree hash and the time spent
> checking the object cache take more time than parsing the rest of the
> commit.
>
> In this patch series, all direct references to accessing the 'tree'
> member of struct commit are replaced instead by one of the following
> methods:
>
> 	struct tree *get_commit_tree(struct commit *)
> 	struct object_id *get_commit_tree_oid(struct commit *)
>
> This replacement was assisted by a Coccinelle script, but the 'tree'
> member is overloaded in other types, so the script gave false-positives
> that were removed from the diff.
>
> After all access is restricted to use these methods, we can then
> change the postcondition of parse_commit_in_graph() to allow 'tree'
> to be NULL. If the tree is accessed later, we can load the tree's
> OID from the commit-graph in constant time and perform the lookup_tree().
>
> On the Linux repository, performance tests were run for the following
> command:
>
>      git log --graph --oneline -1000
>
> Before: 0.83s
> After:  0.65s
> Rel %: -21.6%
>
> Adding '-- kernel/' to the command requires loading the root tree
> for every commit that is walked. There was no measureable performance
> change as a result of this patch.
>
> This patch series depends on v7 of ds/commit-graph.
>
> Derrick Stolee (3):
>    commit: create get_commit_tree() method
>    treewide: use get_commit_tree() for tree access
>    commit-graph: lazy-load trees
>

This patch series is also available as a GitHub pull request [1]

[1] https://github.com/derrickstolee/git/pull/4
