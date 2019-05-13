Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D845A1F461
	for <e@80x24.org>; Mon, 13 May 2019 11:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfEMLHn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 07:07:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33181 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfEMLHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 07:07:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so11087282qtf.0
        for <git@vger.kernel.org>; Mon, 13 May 2019 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=udbDbo/0Wo6jpArJB0h+Ek74vctQdjql0tqya/SP2k4=;
        b=LmqtQ9c7WcbHkCLOujX4qGFpOT3vdRsWoY8741JaZcpNS8HsIuaV0xIlfTGxlazPG4
         NRb3M4OyEi7Cf4pSLoJxDlsmSdNlurJ3TRpGgJC+TXsq+C6SRBP016cv9MWxGjwwRlg5
         WFqCarKxX5k+oOYYBRIKXpvnbfUXLZKehVmE/liS6UbrdCRJOUqTUA7+dw6myr1Y4JeL
         nj5vLZ0bfZycp50G3RkHx6i4+sNndwxY47KZBTYBZb3nSh5ply1EDoIIXH8hFFFOty71
         bzHV6a29IXcYv+twYch6kgYteXIxdeN5QHseuVd9mnSusTayCjGVPSgEm1dwmpidgnj/
         TcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udbDbo/0Wo6jpArJB0h+Ek74vctQdjql0tqya/SP2k4=;
        b=kCyGKUmyR9uUUXeAQNyUQX/m2jEyBMNmpVoyOXFsI47brRB3M6HpIPhoHOLLvhMYF+
         HKb00uTGoBsho73Ywmb4iwBX5uDcC9WgBzr0BRJ5Nm+35ibdI2lwX4sW+yNayB9uMQnV
         B4B/vVztcGvWD8YrhTl36/B1JNf0dTugBj21TkRucLW2soj4v98uC8TWOhMoukbLDHK1
         5MdigfO6yH1hYQTcOWST1xcS1HyR2qYWbHfcwU4Pc5VmIz7UDfSViyraX0zoa3s8JFEm
         cEUB9KLAq26cRtNDX5s0bL7cQU6kM0gzzEoEs7DGALZupiUcR7MyCFPZpWwODssBq5z+
         33OA==
X-Gm-Message-State: APjAAAVqbrhh1ERWjVjs6Lxgmk0c5v/Pk1oLUhisGRzirGgR+zrjMA+6
        hvpYi7TU+8HD+vZQoOfTJhc=
X-Google-Smtp-Source: APXvYqywcdlvXHEnziPEgtsGIFVwn9TC5A1p8QDjFS4Jyk5XaTQb5enWkYsck7Bp2JnImHbpnfTqXg==
X-Received: by 2002:ac8:415e:: with SMTP id e30mr23725605qtm.279.1557745662361;
        Mon, 13 May 2019 04:07:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3130:3ffc:dbb9:1565? ([2001:4898:8010:0:1a66:3ffc:dbb9:1565])
        by smtp.gmail.com with ESMTPSA id 74sm6512790qta.15.2019.05.13.04.07.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:07:41 -0700 (PDT)
Subject: Re: [PATCH v4 03/11] commit-graph: collapse parameters into flags
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
 <pull.112.v4.git.gitgitgadget@gmail.com>
 <469d0c9a32ba5a3f797b5bb50f37d6ac7746385b.1557411749.git.gitgitgadget@gmail.com>
 <xmqqy33bc91q.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad42ab76-76c9-c91c-55a2-a613080c2a01@gmail.com>
Date:   Mon, 13 May 2019 07:07:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqy33bc91q.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2019 11:44 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The write_commit_graph() and write_commit_graph_reachable() methods
>> currently take two boolean parameters: 'append' and 'report_progress'.
>> We will soon expand the possible options to send to these methods, so
>> instead of complicating the parameter list, first simplify it.
> 
> I think this change to introduce "flags" and pack these two into a
> single parameter, even if there is no plan to add code that starts
> using third and subsequent bits immediately.
> 
> We are no longer adding anything beyond PROGRESS and APPEND in this
> series, no?

In this series, we are no longer expanding the options. I will add
a flag when I update the incremental file format series. I can modify
the message to no longer hint at an immediate addition.

>>
>> Collapse these parameters into a 'flags' parameter, and adjust the
>> callers to provide flags as necessary.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  builtin/commit-graph.c | 8 +++++---
>>  builtin/commit.c       | 2 +-
>>  builtin/gc.c           | 4 ++--
>>  commit-graph.c         | 9 +++++----
>>  commit-graph.h         | 8 +++++---
>>  5 files changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 2e86251f02..828b1a713f 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -142,6 +142,7 @@ static int graph_write(int argc, const char **argv)
>>  	struct string_list *commit_hex = NULL;
>>  	struct string_list lines;
>>  	int result;
>> +	int flags = COMMIT_GRAPH_PROGRESS;
> 
> Make it a habit to use "unsigned" not a signed type, when you pack a
> collection of bits into a flag word, unless you are treating the MSB
> specially, e.g. checking to see if it is negative is cheaper than
> masking with MSB to see if it is set.

Ah sorry. I missed this one after changing the parameter in your earlier
feedback.
 
>> ...
>>  	result = write_commit_graph(opts.obj_dir,
>>  				    pack_indexes,
>>  				    commit_hex,
>> -				    opts.append,
>> -				    1);
>> +				    flags);
>> ...
>> -int write_commit_graph_reachable(const char *obj_dir, int append,
>> -				 int report_progress)
>> +int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
>> ...
>>  int write_commit_graph(const char *obj_dir,
>>  		       struct string_list *pack_indexes,
>>  		       struct string_list *commit_hex,
>> -		       int append, int report_progress)
>> +		       unsigned int flags)
> 
> OK, so the receivers of the flags word know the collection is
> unsigned; it's just the user of the API in graph_write() that gets
> the signedness wrong.  OK, easy enough to correct, I guess.
> 

