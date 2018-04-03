Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A09A1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeDCSW6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:22:58 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43450 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeDCSW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:22:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id s48so20236394qtb.10
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eWIY1rMzVJS/Ddapx4hLjEPDtCUQgTI5hw9QO1yF9IA=;
        b=exJ+oe4O3k6nQEj+5AA4/tpIZzqYM3q+vwMf3AZkxI1JFfVsPJgl2WU2JTKwOoQU9c
         wGACTBsH7q8vkkJZAUJGYKnRFZmyr9QPmoyN5norVo9zFrgA6Nul9FrBb7xHOx2ZNETB
         Jjm0gbri5nqTbJwy2BGpO3cQuuH6dJeH2yx7AevzA/BPSJZO5/xbDbH6ZbTOwjsW7IfS
         0/JT76mkMLZtzT5rT2357ukQ12hhXtTDp+t6Q0ilrMpVhAyk83Np2pghlmRE7mTamc58
         O2ct3LoYHnFvPAzRMkB64aWU5epkCH5KCmEu9EEl8IComE79Ir5dBg/7UiVi5xt3V1Ib
         S/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eWIY1rMzVJS/Ddapx4hLjEPDtCUQgTI5hw9QO1yF9IA=;
        b=Yui6qROh57aGqRTc1Zfvr507FRPQvbMsAti0t26FQRc+stDFoftyfFF803vD4S7Uuy
         TdcphpCzyXP6afqLETuoPuwf07QRccY0Q72ZwJ6zpV12Q4hC/mfggnz750mUc0X1SLtI
         4p2tTbVc/Vtbnj0d+SCYW2yfhZT1CdBXIbSV2b6C2otMgTgLl+QLRkpwZd4QvmMNr2xP
         sWFyLqc5djuAVey+k+9ekd6/MSrkK9jre6keSOqHdSr7UYbug/yegJexqfbHnijA2Ej2
         G941uVmbKYOHV+KaQUNqaoY6RCFpQZG4pc4rJwPdy+qaJl8wg3Y0owmqZ3L7Ir6uL5RV
         iGuw==
X-Gm-Message-State: ALQs6tCKB2pZfk0cRWtB+s/50Wa451VZSAXgx95bhiCK8xh+UVTWfCPg
        +ibV9wRn6LZdiN6V+PKuGwU=
X-Google-Smtp-Source: AIpwx48iDGjfLcF2fMI3t/bjb0oWdbTmz03FY27IdjOmryWtdixRanObuZ1s2aFJMNoOIh3ZDuA+IA==
X-Received: by 10.237.41.129 with SMTP id o1mr22046103qtd.202.1522779776529;
        Tue, 03 Apr 2018 11:22:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id k188sm2494661qkb.14.2018.04.03.11.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 11:22:55 -0700 (PDT)
Subject: Re: [PATCH 3/3] commit-graph: lazy-load trees
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Lars Schneider <larsxschneider@gmail.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180403120057.173849-4-dstolee@microsoft.com>
 <CAGZ79kZ0XZRiKcJG-5Ckd=XjE-3GfGHkNuyu4590OyfGPve4Rg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa3340e8-dbd9-7cf7-1711-a6f675bf6b8c@gmail.com>
Date:   Tue, 3 Apr 2018 14:22:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ0XZRiKcJG-5Ckd=XjE-3GfGHkNuyu4590OyfGPve4Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 2:00 PM, Stefan Beller wrote:
> On Tue, Apr 3, 2018 at 5:00 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
>> The commit-graph file provides quick access to commit data, including
>> the OID of the root tree for each commit in the graph. When performing
>> a deep commit-graph walk, we may not need to load most of the trees
>> for these commits.
>>
>> Delay loading the tree object for a commit loaded from the graph
>> until requested via get_commit_tree(). Do not lazy-load trees for
>> commits not in the graph, since that requires duplicate parsing
>> and the relative peformance improvement when trees are not needed
>> is small.
>>
>> On the Linux repository, performance tests were run for the following
>> command:
>>
>>          git log --graph --oneline -1000
>>
>> Before: 0.83s
>> After:  0.65s
>> Rel %: -21.6%
> This is an awesome speedup.
>
>> Adding '-- kernel/' to the command requires loading the root tree
>> for every commit that is walked.
> and as the walk prunes those commits that do not touch kernel/
> which from my quick glance is the real core thing. Linus' announcements
> claim that > 50% is drivers, networking and documentation[1].
> So the "-- kernel/" walk needs to walk twice as many commits to find
> a thousand commits that actually touch kernel/ ?
>
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1801.3/02794.html
> http://lkml.iu.edu/hypermail/linux/kernel/1803.3/00580.html
>
>> There was no measureable performance
>> change as a result of this patch.
> ... which means that the walking itself is really fast now and the
> dominating effects are setup and checking the tree?

Yeah. I was concerned that since we take two accesses into the 
commit-graph file that we could measurably slow down cases where we need 
to load the trees. That is not an issue since we will likely parse the 
tree after loading, and parsing is much slower than these commit-graph 
accesses.


> Is git smart enough to not load the root tree for "log -- ./" or
> would we get the desired performance numbers from that?

I wonder, since it only really needs the OID of the root tree to 
determine TREESAME. If it cares about following TREESAME relationships 
on ./, then it should do that.

>
>> @@ -317,6 +315,27 @@ int parse_commit_in_graph(struct commit *item)
>>          return 0;
>>   }
>>
>> +static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
>> +{
>> +       struct object_id oid;
>> +       const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * (c->graph_pos);
> What is 16? (I imagine it is the "length of the row" - g->hash_len ?)
> Would it make sense to have a constant/define for an entire row instead?
> (By any chance what is the meaning of GRAPH_DATA_WIDTH, which is 36?
> That is defined but never used.)

Yeah, I should use GRAPH_DATA_WIDTH here instead.

>
>> +struct tree *get_commit_tree_in_graph(const struct commit *c)
>> +{
>> +       if (c->tree)
>> +               return c->tree;
> This double checking is defensive programming, in case someone
> doesn't check themselves (as get_commit_tree does below).
>
> ok.
>
>> @@ -17,6 +17,13 @@ char *get_commit_graph_filename(const char *obj_dir);
>>    */
>>   int parse_commit_in_graph(struct commit *item);
>>
>> +/*
>> + * For performance reasons, a commit loaded from the graph does not
>> + * have a tree loaded until trying to consume it for the first time.
> That is the theme of this series/patch, but do we need to write it down
> into the codebase? I'd be inclined to omit this part and only go with:
>
>    Load the root tree of a commit and return the tree.

OK.

>
>>   struct tree *get_commit_tree(const struct commit *commit)
>>   {
>> -       return commit->tree;
>> +       if (commit->tree || !commit->object.parsed)
> I understand to return the tree from the commit
> when we have the tree in the commit object (the first
> part).
>
> But 'when we have not (yet) parsed the commit object',
> we also just return its tree? Could you explain the
> second part of the condition?
> Is that for commits that are not part of the commit graph?
> (But then why does it need to be negated?)

Some callers check the value of 'commit->tree' without a guarantee that 
the commit was parsed. In this case, the way to preserve the existing 
behavior is to continue returning NULL. If I remove the "|| 
!commit->object.parsed" then the BUG("commit has NULL tree, but was not 
loaded from commit-graph") is hit in these two tests:

t6012-rev-list-simplify.sh
t6110-rev-list-sparse.sh

I prefer to keep the BUG() statement and instead use this if statement. 
If someone has more clarity on why this is a good existing behavior, 
then please chime in.

Thanks,
-Stolee
