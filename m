Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E1C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D222361163
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbhJFU6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhJFU6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:58:21 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A5C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 13:56:28 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e16so4117206qts.4
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=59duNwCB5QNAElO2VKUf4NbET1C0j3atPTsxYLeFIPI=;
        b=BTeH5UHAnLHlPdfPkP+K6L2LRr/stzYWiXfuat/h5g55pmimk/y/7YMLWF02DEZox5
         gZP68OFIjrXh2gXZj3QcDHVapJrBzIjZzMjwh+h7cJFjFaZOa1PHiyr4/XAPCGztrK36
         72cFlYRTMPGY5XVZ8SeQgK0k2XDeP1MQS3EN2hcEM33mxv3sYrje+zMz88szMXEdV+Bp
         nlASdBmThg9vK5+PYiTlnLlozThshaVvFKxiImclJTgb8dWyI7gFIlFtwk/z7P7Z8R6f
         l4s4z5KlINIGvt7HCNhpmV9g1XpT8L5ODjDOzc26oIs4BovnVeWMquQQY0fyQY/glUow
         +whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=59duNwCB5QNAElO2VKUf4NbET1C0j3atPTsxYLeFIPI=;
        b=BUUJfqC3DYefVMnMjg4JBPe7l2L0/cAk8p438Jc0361WiGOvcoZdgtRk5/b7mB+BN8
         mSAwhepAfAWhmdxN3gb9eudLaaFbbhaeKBhNvgZwruR8FxomtFTjOVau7yTrW0BdRKmP
         tRkbMA9lM94UbwBIAwtpvrhUEMtsNxQJ/5quMXimJanhV4B8o83ArihPar/v8nzDsqgJ
         BXVjDDv39U+KYifeWEicHipjYv+zSStKKNxrDRbEhUfRFWhCDaonxOjKwkcMdbH/ZxMP
         ZvQbsVjkPUPCNDJ9oqy33K8PPm6072bn0/oW0n24BWQS5OhP2V8ZWK7+ShTaODchabta
         4SXg==
X-Gm-Message-State: AOAM530n9gVZQbhEJ6G6VkhvlkjiHGiMUMo5ffcQ3Rv/5eW/qzZRlGzF
        0LClQrHvuJG512d8f9jM98Go
X-Google-Smtp-Source: ABdhPJztWNW5aeHJOFp8KJXdK9EdPzFPvRi+SFUBWMr6seb0L2C5IL7X7V5Xg7yBDaW/9ou3gH9aCw==
X-Received: by 2002:ac8:7384:: with SMTP id t4mr427042qtp.83.1633553787552;
        Wed, 06 Oct 2021 13:56:27 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id m24sm11832804qki.40.2021.10.06.13.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:56:15 -0700 (PDT)
Message-ID: <52237528-8ceb-d8d5-5590-5db3c8251717@github.com>
Date:   Wed, 6 Oct 2021 16:56:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 5/7] reset: make sparse-aware (except --mixed)
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com>
 <CABPp-BFHNOMTerrV2Bhufb5d9d6JuM+CWW_t1jYg1Uu7F1dhhA@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BFHNOMTerrV2Bhufb5d9d6JuM+CWW_t1jYg1Uu7F1dhhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
>> +static void prime_cache_tree_sparse_dir(struct repository *r,
>> +                                       struct cache_tree *it,
>> +                                       struct tree *tree,
>> +                                       struct strbuf *tree_path)
>> +{
>> +
>> +       oidcpy(&it->oid, &tree->object.oid);
>> +       it->entry_count = 1;
>> +       return;
> 
> Why are 'r' and 'tree_path' passed to this function?
> 

I mindlessly copied the function signature of `prime_cache_tree_rec` and
didn't notice those variables weren't needed (I'll remove them in V3).

>> +}
>> +
>>  static void prime_cache_tree_rec(struct repository *r,
>>                                  struct cache_tree *it,
>> -                                struct tree *tree)
>> +                                struct tree *tree,
>> +                                struct strbuf *tree_path)
>>  {
>> +       struct strbuf subtree_path = STRBUF_INIT;
>>         struct tree_desc desc;
>>         struct name_entry entry;
>>         int cnt;
>>
>>         oidcpy(&it->oid, &tree->object.oid);
>> +
> 
> Why the blank line addition here?
> 

My goal was to visually separate the parts of `prime_cache_tree_rec` that
update the properties of the `tree` itself and the parts that deal with its
entries. For me, it was helpful when reading and understanding what this
function does and seemed like an good (minor) readability change.

>>         init_tree_desc(&desc, tree->buffer, tree->size);
>>         cnt = 0;
>>         while (tree_entry(&desc, &entry)) {
>> @@ -757,27 +771,49 @@ static void prime_cache_tree_rec(struct repository *r,
>>                 else {
>>                         struct cache_tree_sub *sub;
>>                         struct tree *subtree = lookup_tree(r, &entry.oid);
>> +
>>                         if (!subtree->object.parsed)
>>                                 parse_tree(subtree);
>>                         sub = cache_tree_sub(it, entry.path);
>>                         sub->cache_tree = cache_tree();
>> -                       prime_cache_tree_rec(r, sub->cache_tree, subtree);
> 
>> +                       strbuf_reset(&subtree_path);
>> +                       strbuf_grow(&subtree_path, tree_path->len + entry.pathlen + 1);
>> +                       strbuf_addbuf(&subtree_path, tree_path);
>> +                       strbuf_add(&subtree_path, entry.path, entry.pathlen);
>> +                       strbuf_addch(&subtree_path, '/');
> 
> Reconstructing the full path each time?  And despite only being useful
> for the sparse-index case?
> 
> Would it be better to drop subtree_path from this function, then
> append entry.path + '/' here to tree_path, and then after the if-block
> below, call strbuf_setlen to remove the part that this function call
> added?  That way, we don't need subtree_path, and don't have to copy
> the leading path every time.
> 
> Also, maybe it'd be better to only do this strbuf manipulation if
> r->index->sparse_index, since it's not ever used otherwise?
> 

[...]

>> -static int index_name_stage_pos(struct index_state *istate, const char *name, int namelen, int stage)
>> +static int index_name_stage_pos(struct index_state *istate,
>> +                               const char *name, int namelen,
>> +                               int stage,
>> +                               int search_sparse)
> 
> It'd be nicer to make search_sparse an enum defined within this file, so that...
> 
>>  {
>>         int first, last;
>>
>> @@ -570,7 +573,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>>                 first = next+1;
>>         }
>>
>> -       if (istate->sparse_index &&
>> +       if (search_sparse && istate->sparse_index &&
>>             first > 0) {
>>                 /* Note: first <= istate->cache_nr */
>>                 struct cache_entry *ce = istate->cache[first - 1];
>> @@ -586,7 +589,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>>                     ce_namelen(ce) < namelen &&
>>                     !strncmp(name, ce->name, ce_namelen(ce))) {
>>                         ensure_full_index(istate);
>> -                       return index_name_stage_pos(istate, name, namelen, stage);
>> +                       return index_name_stage_pos(istate, name, namelen, stage, search_sparse);
>>                 }
>>         }
>>
>> @@ -595,7 +598,12 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>>
>>  int index_name_pos(struct index_state *istate, const char *name, int namelen)
>>  {
>> -       return index_name_stage_pos(istate, name, namelen, 0);
>> +       return index_name_stage_pos(istate, name, namelen, 0, 1);
> 
> ...this could use SEARCH_SPARSE or some name like that which is more
> meaningful than "1" here.
> 
>> +}
>> +
>> +int index_entry_exists(struct index_state *istate, const char *name, int namelen)
>> +{
>> +       return index_name_stage_pos(istate, name, namelen, 0, 0) >= 0;
> 
> ...and likewise this spot could use SEARCH_FULL or some name like
> that, which is more meaningful than the second "0".
> 
> Similarly for multiple call sites below...
> 
> 

I like all of these suggestions and will include them in the next version. Thanks!
