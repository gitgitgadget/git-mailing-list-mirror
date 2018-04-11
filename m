Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6998E1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 12:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeDKMtz (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 08:49:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33049 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbeDKMtx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 08:49:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id w12-v6so416172plp.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/TiG0nSO7woABpf5FZxZwkQ8prwZIp1HZAr1YiXMxes=;
        b=Ew2yuorLGb0SUKHXuUM1l3ltsxRR1v/acs3HcN8r7LPASiXKE+91J3r/Rfwm4LshpP
         eQNmMBAkQS1QGfWvHpWTDRXkzvd3S7Tn50gc4gLqmJeAOH2p4/Cfrdth+tADDHnWNS8E
         YLlp36NPjep9bfjCKxUWs+AHAXWQ5FtUY1t4afFcYXtyFDXuTxOuelcg4mRnPEAkWGfU
         h8/5LdyjPhIqhH9dqqC/o7QWs+FXHzW5d7Vo6ha954Vc/6aIc83RSSVcHXnhlVowh+a5
         tyxQb3l61TJhgk6P5kxJ0pgfcUFXHIGUVKqSlH+gldchbzwYi4+HqL27XUiEqYzgeELG
         bP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/TiG0nSO7woABpf5FZxZwkQ8prwZIp1HZAr1YiXMxes=;
        b=lJdlerqrDqeTGshbiZIX5Xey0PJLOjfuXIpPiXLpSqruHj6eJ/AgU8Pu+uGYNZ+JE9
         oavG1x6CJnDPIv1UwqYEwgt7UkM2yWGm8QeaCUYK9g7RCFsweaK0JcgG15nPcr89xqiZ
         bkldPlBBEtovZMxBG1NlxrSTUeQM7lRQOi7jbkSjCiq/jA/7iAINxQM2oX2J5Y2S4bah
         ne7AgwaXPQEis6O5Zp3jZB32AZRGJfCwjcSDSv029HmmlCYawl7ReRdJHosP+UcnqNwU
         L7VLhkgGY32ChxNt0BlDv6Oa79FNptGa7h3coX3uFk69d3CYUoqFvs3C4CGn46HOn3KN
         1TIg==
X-Gm-Message-State: ALQs6tAhT7648n1pmbNDB/MXZCVCGdxEo0y10pAV6SH4KgEuQ1rB68gM
        K6uGM5Y1oPzl3Tvay37b+ow=
X-Google-Smtp-Source: AIpwx4+FmGLD90l31MEHaVrlEh8ijHV99HppnrUAklmjWPgdbV5aIEeA1HBjXMtyQd/mVlGbeS4ggg==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr5003802pla.150.1523450992714;
        Wed, 11 Apr 2018 05:49:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b65sm4612408pfl.145.2018.04.11.05.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 05:49:51 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] merge: check config before loading commits
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-3-dstolee@microsoft.com>
 <xmqqo9iqze1g.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <197f4c77-ab2a-cf5b-463f-471bd5f8966f@gmail.com>
Date:   Wed, 11 Apr 2018 08:49:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9iqze1g.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2018 10:12 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index ee050a47f3..20897f8223 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -1183,13 +1183,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>>   	branch = branch_to_free = resolve_refdup("HEAD", 0, &head_oid, NULL);
>>   	if (branch)
>>   		skip_prefix(branch, "refs/heads/", &branch);
>> +	init_diff_ui_defaults();
>> +	git_config(git_merge_config, NULL);
>> +
>>   	if (!branch || is_null_oid(&head_oid))
>>   		head_commit = NULL;
>>   	else
>>   		head_commit = lookup_commit_or_die(&head_oid, "HEAD");
>>   
>> -	init_diff_ui_defaults();
>> -	git_config(git_merge_config, NULL);
> Wow, that's tricky.  git_merge_config() wants to know which "branch"
> we are on, and this place is as early as we can move the call to
> without breaking things.  Is this to allow parse_object() called
> in lookup_commit_reference_gently() to know if we can rely on the
> data cached in the commit-graph data?

When I saw the bug on my machine, I tracked the issue down to a call to 
parse_commit_in_graph() that skipped the graph check since 
core_commit_graph was not set. The call stack from this call is as follows:

* lookup_commit_or_die()
* lookup_commit_reference()
* lookup_commit_reference_gently()
* parse_object()
* parse_object_buffer()
* parse_commit_in_graph() [as introduced in PATCH 01/10]

>
>> Move the config load to be between the initialization of 'branch'
>> and the commit lookup. Also add a test to t5318-commit-graph.sh
>> that exercises this code path to prevent a regression.
> It is not clear to me how a successful merge of commits/8
> demonstrates that reading the config earlier than before is
> regression free.

I didn't want to introduce commits in an order that led to a commit 
failing tests, but if you drop the change to builtin/merge.c from this 
series, the tip commit will fail this test with "BUG: bad generation skip".

The reason for this failure is that commits/5 is loaded from HEAD from 
the object database, so its generation is marked as 
GENERATION_NUMBER_INFINITY, and the commit is marked as parsed. Later, 
the commit at merges/3 is loaded from the graph with generation 4. This 
triggers the BUG statement in paint_down_to_common(). That is why it is 
important to check a fast-forward merge.

In the 'graph_git_behavior' steps of t5318-commit-graph.sh, we were 
already testing 'git merge-base' to check the commit walk logic.

Thanks,
-Stolee
