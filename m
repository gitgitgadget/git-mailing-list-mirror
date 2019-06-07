Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD19E1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 12:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfFGMoq (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 08:44:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43279 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFGMoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 08:44:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so1111550qka.10
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hiaxii61iHfWTqPuXZGIgtcpT48+3XxzeI+HLUN4zVI=;
        b=djw26Q6/C2rOzkZubcZ/H0pKoOBFjIlcE41AzAl8BwoAyeEz5t+y3g6+w5h6rwC40L
         va2eo61JME4CQQqhXdE0i5aqioUJr3E5BRZ0f9+Aa5dZu9wjwUVP3Yw5MqRMIStfEhD5
         bPK9K0EnyD9FM6M6br3elEFlqPnMwVkEwEGv8U8bZ8tgeld7D3ndpxYOdm4jEL1euAAt
         bEZdrY/z7HpPohAyfSZW7LOYtKZCxkbSq+gpWMfR/xPkvT82ht5X2pkK8CXnz11i9d2Y
         Q8Ur1/7yE+RhRceC/zRMGJyugZlGUrcT95lcloQTI2zUfzmFhCF4JcUIzIPxe7lX+R0U
         cnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hiaxii61iHfWTqPuXZGIgtcpT48+3XxzeI+HLUN4zVI=;
        b=c88TXT0dzfxe5kvOnE+TixeC1Pgl8N+oYi03JIJWZT7XFaKnuACQAyhFfbQ+GTVwiq
         7lh3GMks3xdOBhmPGGirN6Gdj6VdZ1njmS2aEKc52tarReOYbNmeMn3SBU6dsbECue13
         AYb9gx2awOim9nA8bwIR5oT2G66NNV4B9hcCVc4RSOzepUOD76oWP507g5XxBJc5RfPW
         PFuc9V8ZpDmHJZt1DJ3poEGSZ1uKKAYbFPvLdVD2rSywOtA6WrGKzyK/w4Oo88LUriXX
         RMy23dXjx5s56RaYNOnrV5MGMkpI94OVlWYvmj6iTQFmvRJPa3aaryrIHQtElgBr0sgf
         p05Q==
X-Gm-Message-State: APjAAAUaYFA2fIGH0slQ6O5Fl6xDBvJ8rvk5krGLXf18D+il1lL6cYpV
        z22pGzjK6lD7wSLXMiqqx0o=
X-Google-Smtp-Source: APXvYqxK9GcfSC66IXtFHGdoVCHfLFvYWr5Jnpuv10mZrSMBNWbUHigF4fGvL1wxSoKC2ybfMOz2zg==
X-Received: by 2002:a37:8002:: with SMTP id b2mr44381444qkd.289.1559911485029;
        Fri, 07 Jun 2019 05:44:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4daa:35d6:a381:1849? ([2001:4898:a800:1012:fedd:35d6:a381:1849])
        by smtp.gmail.com with ESMTPSA id 45sm1132201qtn.82.2019.06.07.05.44.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 05:44:44 -0700 (PDT)
Subject: Re: [PATCH v4 02/14] commit-graph: prepare for commit-graph chains
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
 <pull.184.v4.git.gitgitgadget@gmail.com>
 <d0dc154a27c80a8113ff47eb60a6b6f98fbeec91.1559830527.git.gitgitgadget@gmail.com>
 <xmqqd0jqqu8p.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4e2263fb-1499-7aae-d8f9-c0f789b83744@gmail.com>
Date:   Fri, 7 Jun 2019 08:44:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0jqqu8p.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2019 5:28 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +static void load_oid_from_graph(struct commit_graph *g, int pos, struct object_id *oid)
>> +{
>> +	uint32_t lex_index;
>> +
>> +	if (!g)
>> +		BUG("NULL commit-graph");
>> +
>> +	while (pos < g->num_commits_in_base)
>> +		g = g->base_graph;
> 
> If a rogue caller calls this function with pos < 0, this loop would
> eventually exhaust the chain and make g==NULL, I think.  Shouldn't a
> similar assert exist upfront for "if (pos < 0)" or perhaps make pos
> unsigned int instead?

This is a good point. I will use 'uint32_t' since the only caller is
insert_parent_or_die() which has an unsigned position. I did notice that
insert_parent_or_die() uses "uint64_t pos" but its only caller passes a
"uint32_t edge_value". The 32-bit value makes more sense because of the
built-in limits in the commit-graph format for number of commits. I'll
change insert_parent_or_die() to use 32-bits as well.

As for the while loop, it would also be good to rearrange the checks
as follows:

        while (g && pos < g->num_commits_in_base)
                g = g->base_graph;

        if (!g)
                BUG("NULL commit-graph");

> 
>> +	if (pos >= g->num_commits + g->num_commits_in_base)
>> +		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
>> +		    pos, g->num_commits, g->num_commits_in_base);
> 
> Where does 'pos' typically come from?  Taken from a parent commit
> field of a commit-graph file or something like that?

It comes from the commit-graph file.

> As this is a "BUG()" and not a "die()", the callers of this function
> are responsible for making sure that, even if they are fed a set of
> corrupt commit-graph files, they never feed 'pos' that is out of
> bounds to this function.  The same is true for the other BUG() in
> fill_commit_in_graph().> 
> I am wondering if they have already sufficient protection, or if we
> are better off having die() instead saying "corrupted commit graph
> file" or something.  I dunno.

I can replace this with a die() that points to a corrupt commit-graph
file. Perhaps "BUG()" made more sense while I was developing the feature
and wanted to tell myself why the error condition happened. That doesn't
make sense any more now that the feature is working.

Thanks,
-Stolee

