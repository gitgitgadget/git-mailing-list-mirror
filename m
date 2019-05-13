Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A361F461
	for <e@80x24.org>; Mon, 13 May 2019 11:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfEMLEn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 07:04:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45635 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfEMLEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 07:04:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so5217568qtc.12
        for <git@vger.kernel.org>; Mon, 13 May 2019 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vqUghadQt0cFtEpZlkiy3XQEC938649ur59TUYwHUu4=;
        b=W4k7XGtJupE+zQj6ISRU/0xCo84YNW7E0aPAWs06hSArBVME8+Ga0/7/UQ8M64KALf
         vL5Ha1X89rKPUgVSE2Xz3PIzaWHCzn1U2ozcmukRrD6iwTyHlWPQ67UrfJew2fTxuiOr
         piQCYNk5X92xez22n0stI0+pro5ajaKj6UvgJtnMUizmcDZyqm5ON88sl93Y/SKehDkr
         XiSKhzs2DWNM3y1Pk0P2XEB5TPGzHLMWzImfAbwx8V7m2Z/fBXNaPfDFhDItDOB6Kpih
         peq2TSX/MJ2YC+iaqMXi7f1uj5VEbqLZDJNPweHGNlfJ0/ZZYKxpVjMHIhbqoN+5tgZj
         tXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqUghadQt0cFtEpZlkiy3XQEC938649ur59TUYwHUu4=;
        b=lJmE1cHRn+JoX9nbqdfSz+5R6nNq03lVeArezDJem6brx4LRZDBQYCnYAkUzPRRR43
         OLRXmMGp0Woqpo5zFXtuklou1V/b9sFkBVAv05RKM+qyn3Atw7+oQfLu7CQ6HqjjXZvu
         nSxJFpyB8vNHL6DLxUFrYbOC1pZn30Q/FSsfs/yiauyFiU/BnJMnaAxStAJZOBwPXBE+
         Rp0SfDfv174RAfelrWM2HyB1C8AveLpz7wS1oaoi3t6S12dFLRJX0+JMl0tYUJ7nmXrp
         TEpRjgFV1S0nJ+x3aW/VkZLDzpGDvKnydwKK38iBHYPpHhLq5j5tIGaPKnO0DBo0xegE
         hfdA==
X-Gm-Message-State: APjAAAUbHlDGrVpBIaLuWRNFML2UgYmzEIUFLZ7eIQ2y+N5VVysOtVV8
        hQLbkCPUes+ZbscneA5J+D94sompGNM=
X-Google-Smtp-Source: APXvYqz6JwMDJfm+wXSIQQVKOp2WhNEIbFxa8AdLjKB1nLDL0tQ8gDMBasUOhH5I1nPIzohKN8/wVA==
X-Received: by 2002:ac8:338a:: with SMTP id c10mr23801273qtb.41.1557745481597;
        Mon, 13 May 2019 04:04:41 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3130:3ffc:dbb9:1565? ([2001:4898:8010:0:1a66:3ffc:dbb9:1565])
        by smtp.gmail.com with ESMTPSA id c30sm2302448qta.25.2019.05.13.04.04.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:04:40 -0700 (PDT)
Subject: Re: [PATCH v4 02/11] commit-graph: return with errors during write
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
 <pull.112.v4.git.gitgitgadget@gmail.com>
 <a4082b827eb1999f6e46780b4147962d6dd87975.1557411749.git.gitgitgadget@gmail.com>
 <xmqq36ljdp2s.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <17829620-1084-74e5-54ad-aa95990f4dbd@gmail.com>
Date:   Mon, 13 May 2019 07:04:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqq36ljdp2s.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2019 11:13 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> @@ -188,14 +187,14 @@ static int graph_write(int argc, const char **argv)
>>  		UNLEAK(buf);
>>  	}
>>  
>> -	write_commit_graph(opts.obj_dir,
>> -			   pack_indexes,
>> -			   commit_hex,
>> -			   opts.append,
>> -			   1);
>> +	result = write_commit_graph(opts.obj_dir,
>> +				    pack_indexes,
>> +				    commit_hex,
>> +				    opts.append,
>> +				    1);
>>  
>>  	UNLEAK(lines);
>> -	return 0;
>> +	return result;
>>  }
> 
> What were the error values this function used to return?  I am
> wondering if the callers of this function are prepraed to see the
> returned values from write_commit_graph() this function stores in
> 'result' (which presumably are small negative value like our usual
> internal API convention)?

The only caller is cmd_commit_graph() and it is in this snippet:

        if (argc > 0) {
                if (!strcmp(argv[0], "read"))
                        return graph_read(argc, argv);
                if (!strcmp(argv[0], "verify"))
                        return graph_verify(argc, argv);
                if (!strcmp(argv[0], "write"))
                        return graph_write(argc, argv);
        }

So these return values are passed directly to the result of the
builtin. If that is against convention (passing an error code from
the library to the result of the builtin) then I can modify.

> OK.  The callers of write_commit_graph_reachable() can be careful
> about its return values to the same degree as the callers of
> write_commit_graph().
> 
> These functions perhaps deserves
> /*
>  * returns X when ....
>  */
> in front (or in *.h)?

Can do, in commit-graph.h.

>> +int write_commit_graph(const char *obj_dir,
>> +		       struct string_list *pack_indexes,
>> +		       struct string_list *commit_hex,
>> +		       int append, int report_progress)
>>  {
>>  	struct packed_oid_list oids;
>>  	struct packed_commit_list commits;
>>  	struct hashfile *f;
>>  	uint32_t i, count_distinct = 0;
>> -	char *graph_name;
>> +	char *graph_name = NULL;
>>  	struct lock_file lk = LOCK_INIT;
>>  	uint32_t chunk_ids[5];
>>  	uint64_t chunk_offsets[5];
>> @@ -883,15 +886,17 @@ void write_commit_graph(const char *obj_dir,
>>  	uint64_t progress_cnt = 0;
>>  	struct strbuf progress_title = STRBUF_INIT;
>>  	unsigned long approx_nr_objects;
>> +	int res = 0;
>>  
>>  	if (!commit_graph_compatible(the_repository))
>> -		return;
>> +		return 0;
> 
> OK.  I tend to find "return 0" easier to read/follow than "return
> res" here.

Yes, this choice was deliberate as there is no cleanup to do if we
return this early. Also note that we don't "fail" because we did
exactly as much work as we expect in this scenario. I'll be careful
to point this out when I add a comment to the header file.

>>  	oids.nr = 0;
>>  	approx_nr_objects = approximate_object_count();
>>  	oids.alloc = approx_nr_objects / 32;
>>  	oids.progress = NULL;
>>  	oids.progress_done = 0;
>> +	commits.list = NULL;
>>  
>>  	if (append) {
>>  		prepare_commit_graph_one(the_repository, obj_dir);
>> @@ -932,10 +937,16 @@ void write_commit_graph(const char *obj_dir,
>>  			strbuf_setlen(&packname, dirlen);
>>  			strbuf_addstr(&packname, pack_indexes->items[i].string);
>>  			p = add_packed_git(packname.buf, packname.len, 1);
>> -			if (!p)
>> -				die(_("error adding pack %s"), packname.buf);
>> -			if (open_pack_index(p))
>> -				die(_("error opening index for %s"), packname.buf);
>> +			if (!p) {
>> +				error(_("error adding pack %s"), packname.buf);
>> +				res = 1;
>> +				goto cleanup;
>> +			}
>> +			if (open_pack_index(p)) {
>> +				error(_("error opening index for %s"), packname.buf);
>> +				res = 1;
>> +				goto cleanup;
>> +			}
> 
> Hmph, is this signal an error by returning a positive "1"?  That's a
> bit unusual.

Your hint above of "passing a negative value by convention" did make me
think I must be doing something wrong.

>> @@ -1006,8 +1017,11 @@ void write_commit_graph(const char *obj_dir,
>>  	}
>>  	stop_progress(&progress);
>>  
>> -	if (count_distinct >= GRAPH_EDGE_LAST_MASK)
>> -		die(_("the commit graph format cannot write %d commits"), count_distinct);
>> +	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
>> +		error(_("the commit graph format cannot write %d commits"), count_distinct);
>> +		res = 1;
>> +		goto cleanup;
>> +	}
>>  
>>  	commits.nr = 0;
>>  	commits.alloc = count_distinct;
>> @@ -1039,16 +1053,21 @@ void write_commit_graph(const char *obj_dir,
>>  	num_chunks = num_extra_edges ? 4 : 3;
>>  	stop_progress(&progress);
>>  
>> -	if (commits.nr >= GRAPH_EDGE_LAST_MASK)
>> -		die(_("too many commits to write graph"));
>> +	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
>> +		error(_("too many commits to write graph"));
>> +		res = 1;
>> +		goto cleanup;
>> +	}
>>  
>>  	compute_generation_numbers(&commits, report_progress);
>>  
>>  	graph_name = get_commit_graph_filename(obj_dir);
>>  	if (safe_create_leading_directories(graph_name)) {
>>  		UNLEAK(graph_name);
>> -		die_errno(_("unable to create leading directories of %s"),
>> -			  graph_name);
>> +		error(_("unable to create leading directories of %s"),
>> +			graph_name);
>> +		res = errno;
>> +		goto cleanup;
>>  	}
> 
> Hmph.  Do we know errno==0 means no error everywhere?  Do we know
> errno==1 is not used by anybody as a meaningful value?
> 
> What I am getting at is if a hardcoded "1" we saw above as "error
> exists but we are not telling the caller what kind of system-level
> error led to it by returning errno" (and a hardcoded "0" as "there
> is no error") are consistent with this use of "res" where "the
> callers are allowed to learn what system-level error led to this
> error return from this function by sending the return value of this
> function to strerror() or comparing with EWHATEVER".  I do not think
> this is a good design.

That's a good point. In a new design, would you like me to (1) ignore
errno here and use a constant value for "write_commit_graph() failed
at some point" or to (2) split the possible _reasons_ for the failure
into different constants? I believe the use of error() should prevent
the need for the second option. The first option would only change
this 'res = errno' into 'res = 1'.

Thanks,
-Stolee
