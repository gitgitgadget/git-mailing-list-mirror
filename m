Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5CE1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 11:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeFDLzk (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 07:55:40 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34472 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeFDLzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 07:55:38 -0400
Received: by mail-qt0-f194.google.com with SMTP id d3-v6so5598337qto.1
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AZI2W48w9YFu/YevSd0iDcmm1i3pc/nKW7tWaSnUkM4=;
        b=b8zSi0hDQznvgcZ03xZ0rlt3RN2ev+wc6xiD/qXRL2DBqf/Lr9vW7v+a+ESBySil6g
         JZdtzVZHBS85vpj+gVtf4NgsniIm8rKoPrV0dmOk9/qPbo/KW1Lh3P5hPBy894eNTMpR
         N9rAv+ou6BGUQ7KtwoJ5I/PKU9SZlT39Xyk3PGyUkeBQNS+uOe/wDj7mc4lXrl0ZhtZk
         ir4z2WIXH/VAXt0JqB1KJJPFScTOiY3GLyKXhw8gz7u5+HehYzS4CtcMEn0yNW1j7mu8
         e6bVpo0T5dWEWuTqN7l8xcXODFWQBQ/DS+SuOlnyhNtnelaG4Ihm/2jz8jPn9E5fG3/J
         9XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AZI2W48w9YFu/YevSd0iDcmm1i3pc/nKW7tWaSnUkM4=;
        b=qm3KRIlD2DdHygMHMNkqguJ+5LEgqUDbBsrIlQ0wVCKi6h2FUr12SERI8n2oYYhH/C
         uRKvATbuf//YuvxNpTBfCgEVWCANEnaQwozksoVj+lCGXb7VZn+N450NVsW1DcfIBVa2
         zGZdqYF0SZFs198zJ/8SBWc4dKBxTozmBMzoy/WegXqvTuno5yukSvQys/xY4Esb4eSo
         4/GUaUOT6OtepNnqG/XpDvyJ0fMsH43s1SnDgAvaFgep0cW9tzXVr1Xrt+iE6AZ5aEqC
         9pNit7ke90OnOsabNmD4nEKEcoVpgzw4Ly3yKUCfs5WZk59FM/WM3zBPfHtDWQTSmZtr
         O0YA==
X-Gm-Message-State: APt69E3wJKbUto8ajl3cumXloA97WaAi8R5ePntgJ0pcxR2Wv+T9odG0
        jI3TTR3Ci5twVvn824W9VnE=
X-Google-Smtp-Source: ADUXVKLT2nz9MN4T17nkFCm3G10hDTPIub5DZfDpd9KYE9tHnNEKL+6PtB91QLrLnBoCbB2gXVtY9Q==
X-Received: by 2002:ac8:64a:: with SMTP id e10-v6mr20463972qth.163.1528113337968;
        Mon, 04 Jun 2018 04:55:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2d1c:9d08:485:87f2? ([2001:4898:8010:0:1652:9d08:485:87f2])
        by smtp.gmail.com with ESMTPSA id y131-v6sm7369082qka.30.2018.06.04.04.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 04:55:37 -0700 (PDT)
Subject: Re: [PATCH v3 16/20] commit-graph: verify contents match checksum
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-17-dstolee@microsoft.com> <86muwdtcc7.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b7695b6-049a-de92-b4ee-70a73e5cf583@gmail.com>
Date:   Mon, 4 Jun 2018 07:55:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86muwdtcc7.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 11:52 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The commit-graph file ends with a SHA1 hash of the previous contents. If
>> a commit-graph file has errors but the checksum hash is correct, then we
>> know that the problem is a bug in Git and not simply file corruption
>> after-the-fact.
>>
>> Compute the checksum right away so it is the first error that appears,
>> and make the message translatable since this error can be "corrected" by
>> a user by simply deleting the file and recomputing. The rest of the
>> errors are useful only to developers.
> Should we then provide --quiet / --verbose options, so that ordinary
> user is not flooded with error messages meant for power users and Git
> developers, then?
>
>> Be sure to continue checking the rest of the file data if the checksum
>> is wrong. This is important for our tests, as we break the checksum as
>> we modify bytes of the commit-graph file.
> Well, we could have used sha1sum program, or test-sha1 helper to fix the
> checksum after corrupting the commit-graph file...
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c          | 16 ++++++++++++++--
>>   t/t5318-commit-graph.sh |  6 ++++++
>>   2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index d2b291aca2..a33600c584 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -841,6 +841,7 @@ void write_commit_graph(const char *obj_dir,
>>   	oids.nr = 0;
>>   }
>>   
>> +#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
>>   static int verify_commit_graph_error;
>>   
>>   static void graph_report(const char *fmt, ...)
>> @@ -860,7 +861,9 @@ static void graph_report(const char *fmt, ...)
>>   int verify_commit_graph(struct commit_graph *g)
>>   {
>>   	uint32_t i, cur_fanout_pos = 0;
>> -	struct object_id prev_oid, cur_oid;
>> +	struct object_id prev_oid, cur_oid, checksum;
>> +	struct hashfile *f;
>> +	int devnull;
>>   
>>   	if (!g) {
>>   		graph_report("no commit-graph file loaded");
>> @@ -879,6 +882,15 @@ int verify_commit_graph(struct commit_graph *g)
>>   	if (verify_commit_graph_error)
>>   		return verify_commit_graph_error;
>>   
>> +	devnull = open("/dev/null", O_WRONLY);
>> +	f = hashfd(devnull, NULL);
>> +	hashwrite(f, g->data, g->data_len - g->hash_len);
>> +	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
>> +	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
>> +		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
>> +		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
>> +	}
> Is it the best way of calculating the SHA-1 checksum that out internal
> APIs provide?  Is it how SHA-1 checksum is calculated and checked for
> packfiles?
This pattern is similar to hashfd_check() in csum-file.c, except we are 
hashing the file data directly instead of re-creating it from scratch 
(as is done for 'git index-pack --verify').

>
>> +
>>   	for (i = 0; i < g->num_commits; i++) {
>>   		struct commit *graph_commit;
>>   
>> @@ -916,7 +928,7 @@ int verify_commit_graph(struct commit_graph *g)
>>   		cur_fanout_pos++;
>>   	}
>>   
>> -	if (verify_commit_graph_error)
>> +	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>>   		return verify_commit_graph_error;
> So if we detected that checksum do not match, but we have not found an
> error, we say that it is all right?

This only prevents us from stopping early. We will still report an error.

>
>>   
>>   	for (i = 0; i < g->num_commits; i++) {
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 240aef6add..2680a2ebff 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -279,6 +279,7 @@ GRAPH_COMMIT_DATA_WIDTH=`expr $HASH_LEN + 16`
>>   GRAPH_OCTOPUS_DATA_OFFSET=`expr $GRAPH_COMMIT_DATA_OFFSET + \
>>   				$GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS`
>>   GRAPH_BYTE_OCTOPUS=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4`
>> +GRAPH_BYTE_FOOTER=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4 \* $NUM_OCTOPUS_EDGES`
>>   
>>   # usage: corrupt_graph_and_verify <position> <data> <string>
>>   # Manipulates the commit-graph file at the position
>> @@ -388,4 +389,9 @@ test_expect_success 'detect incorrect parent for octopus merge' '
>>   		"invalid parent"
>>   '
>>   
>> +test_expect_success 'detect invalid checksum hash' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
>> +		"incorrect checksum"
> This would not work under GETTEXT_POISON, as the message is marked as
> translatable, but corrupt_graph_and_verify uses 'grep' and not
> 'test_i18grep' from t/test-lib-functions.sh

I fixed this locally based on Szeder's comment.

>
>> +'
> If it is pure checksum corruption, wouldn't this fail because it is not
> a failure (exit code is 0)?

It is not zero, so the test passes.

