Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB654C38BE1
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CA220838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0giX5An"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBXS3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:29:49 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41929 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBXS3t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:29:49 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so4562762qvn.8
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EI1kIAg3UhkgtFizVP8NCaSI5JFs8SXUMJ3JHOsKevg=;
        b=d0giX5AnOVExK8FHpUI8G7+rAtv8vEo4mOoipGn/vUZqxmLH8Umt/8MTyBdLknZ6v8
         8BZb9nmtoTjn3O9OGGR6ePpftD0Dj4kY4ozzYvxj8L6jEZecFmMWvHBFVdqB4afheWcS
         0izrq4bBgRPslMeDDY05fm4NBffIUK5WBruYDWokklo5mTwu3m0eiNbLGTQQ2we7kBv1
         +uPqUIm56OumqrtCt0pMg6lNU1Fsk3jCmdiRfxyDdxj3Hoixz2KK12AlsP8eK6cC4Tdx
         yGQ55lruhs3NQjuBtEgp4PKog9rTngiqvzVScQkdkODk3n9akEiQUnxbLI/p5p6ApRqy
         IZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EI1kIAg3UhkgtFizVP8NCaSI5JFs8SXUMJ3JHOsKevg=;
        b=oNW0dQXHWpUcEgQ1pTlIFOe6jpBbT+ikxxg/RRMLzumuPDMvzNcLyyhTVnYSp5bli/
         Aptat5YCR3jY1fm7OUjPEho/eFkKjE92yngstFM+NK2aG9s6yyAkwiNLupa0MU91bMke
         Q97ly8FMAG/kvObgnkbYfIpN15dWcYWij+PvkgaNsq0QXUJbprEUBWoMY142VEd2PhyN
         rZ3Uxj05GQh0o+OOb++/pBRBPEyPQbZmT2/0JRQwjqk6TxCCQYXbhB07uRO1quSjkdMG
         +rWu35nUeVNkFXkGWNg9Ij7aiFAAdJc+PGcvD6hPXiVGMnLA8yfSEJymT8EbrRFVd3ga
         Q/Xw==
X-Gm-Message-State: APjAAAUFtOfgHIPswTuTI7XIiqyfrB/baJdtxrLG+dt44hLBilK7GOVk
        XMvIsodadvjdySKlLF3s4RbnvkKW
X-Google-Smtp-Source: APXvYqzGFz73BAzs5TE1sYgANCywb6S9O4+eEdq9ARxtq/QdNWRCey08bvn4ltJ9qAPacPAr/JnKfw==
X-Received: by 2002:ad4:490d:: with SMTP id bh13mr46134594qvb.180.1582568988581;
        Mon, 24 Feb 2020 10:29:48 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:68d1:9775:6b44:857a? ([2001:4898:a800:1012:1a06:9775:6b44:857a])
        by smtp.gmail.com with ESMTPSA id m6sm2943134qki.24.2020.02.24.10.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 10:29:48 -0800 (PST)
Subject: Re: [PATCH v2 05/11] commit-graph: examine changed-path objects in
 pack order
To:     Jakub Narebski <jnareb@gmail.com>,
        Jeff King via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <78e8e49c3a1131ffacf660603de60729b3dbadc9.1580943390.git.gitgitgadget@gmail.com>
 <86k14jkc8s.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <f7a0d25d-0dfe-6b16-712b-1b2744378982@gmail.com>
Date:   Mon, 24 Feb 2020 13:29:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86k14jkc8s.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/18/2020 12:59 PM, Jakub Narebski wrote:
> "Jeff King via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff King <peff@peff.net>
>>
>> Looking at the diff of commit objects in pack order is much faster than
>> in sha1 order, as it gives locality to the access of tree deltas
> 
> Nitpick: should we still say sha1 order?  Git is still using SHA-1 as an
> *oid*, but hopefully soon it will be transitioning to NewHash = SHA-256.
> (No need to change anything.)
> 
>> (whereas sha1 order is effectively random). Unfortunately the
>> commit-graph code sorts the commits (several times, sometimes as an oid
>> and sometimes a pointer-to-commit), and we ultimately traverse in sha1
>> order.
> 
> Actually, commit-graph code needs write_commit_graph_context.commits.list
> to be in lexicographical order to be able to turn position in graph into
> reference to a commit.  The information about the parents of the commit
> are stored using positional references within the graph file.
> 

You are right. Fixing the commit message in v3. 

>>
>> Instead, let's remember the position at which we see each commit, and
>> traverse in that order when looking at bloom filters. This drops my time
>> for "git commit-graph write --changed-paths" in linux.git from ~4
>> minutes to ~1.5 minutes.
> 
> Nitpick: with reordering of patches (which I think is otherwise a good
> thing) this patch actually comes before the one adding "--changed-paths"
> option to "git commit-graph write".  So it 'This would drop my time'
> rather than 'This drops my time...' ;-)
> 

:) I will fix that up. 

>>
>> Probably the "--reachable" code path would want something similar.
> 
> Has anyone tried doing this?
> 

I will and I will include the perf numbers in the appropriately in v3. 


>> +
>>  char *get_commit_graph_filename(const char *obj_dir)
>>  {
>>  	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
>> @@ -1027,6 +1051,8 @@ static int add_packed_commits(const struct object_id *oid,
>>  	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
>>  	ctx->oids.nr++;
>>  
>> +	set_commit_pos(ctx->r, oid);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1147,6 +1173,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>>  {
>>  	int i;
>>  	struct progress *progress = NULL;
>> +	struct commit **sorted_by_pos;
> 
> In the next patch in series we would sort commits by generation number
> and creation data; shouldn't this variable name be more generic to
> reflect this, for example just `sorted_commits` or `commits_sorted`?
> 

Good call. I will clean this up in both commits. 

Thanks for the review! 
Cheers! 
Garima Singh
