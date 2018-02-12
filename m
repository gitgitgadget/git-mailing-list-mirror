Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E3B1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeBLVY7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:24:59 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36227 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932308AbeBLVY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:24:57 -0500
Received: by mail-qk0-f179.google.com with SMTP id 15so20102845qkl.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 13:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v9c7ZMDD2YHdZJkXmI6f/lzNjGq8lhsbRcc9UmQsO0Y=;
        b=bv9+yG63SpCUc7EN4E4zo060FrcXGAMSLLnhzf+IXTfJGr5x7CeJSKhQrBEMNqSA+U
         09HmbYZUalqlpgsVjYeRSdNJtTq50WOqFGzHwjYKPwSGWVvtlnfLmzw05daR881iGX3N
         WawvIew+oNWAmz7e8jetMMWlxr9bAiuWJtrODDNU0Ppmj58dtFzAC7f3h9cr/2cqFteM
         2iH2TibpA63SEaIFNjHdfGtw1UjHMC96YhGHCndS6kDzH45EvLVHGMVtYh7K5YbC1T5L
         NszvfRD0Fcgb+9v7JLobJ0V89p9FU2qRZXwFJg+6YCufU8UQe2P+Ai7MrsrIw8TUwUXe
         TCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v9c7ZMDD2YHdZJkXmI6f/lzNjGq8lhsbRcc9UmQsO0Y=;
        b=crg5BQJ0Dnyv6zMU9Imhrpr9uUNYcfoGY9ff9JXl5t90hXHA4zRMEkCDEi5t4GkrKC
         P1M1aWeYKVwP91CTHWYqbtAS3P7CQXbxkWZrmZhcFerSLwraxXj9DZny/wsK4y8s8Ujh
         nqNFmxaNQOr6DpGKoIVYpjnMFysHfG3u0BguoPiU9+kfvANDLFNQoxQ5AZuneBqBeg8A
         cB+RmCXxxIUR7vw4P7aRcih5rMOxvkENqmHbFfRNVCUfnVH1F/MEJ81pQ02O0jJnVJTC
         RcIIIIAOMdE1md/R2cJGvIJRMrOamqNdE1Es2Z24F4ZItmGJmtaA/U4eErUfs5gYIng7
         Yxxg==
X-Gm-Message-State: APf1xPA/RvAJif2/6dxa0LYobN2PH5g3v6FtgL8aGuvA0Xap13tCCgnm
        K5eaP5srbtxJ9Mdi56tPwVM=
X-Google-Smtp-Source: AH8x226L+XvsZsEXIwmyvv/2pA/UWCznlbu0W0tDR1wm8bpfZPhViZowfE7AXqTUv4nsTXu7Qat5Tg==
X-Received: by 10.55.16.137 with SMTP id 9mr18445824qkq.189.1518470696870;
        Mon, 12 Feb 2018 13:24:56 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id o14sm4196601qta.67.2018.02.12.13.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 13:24:56 -0800 (PST)
Subject: Re: [PATCH v3 07/14] commit-graph: update graph-head during write
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-8-git-send-email-dstolee@microsoft.com>
 <xmqqeflqt4st.fsf@gitster-ct.c.googlers.com>
 <xmqqwozirlky.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <99543db0-26e4-8daa-a580-b618497e48ba@gmail.com>
Date:   Mon, 12 Feb 2018 16:24:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqwozirlky.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/12/2018 3:37 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> It is possible to have multiple commit graph files in a pack directory,
>>> but only one is important at a time. Use a 'graph_head' file to point
>>> to the important file. Teach git-commit-graph to write 'graph_head' upon
>>> writing a new commit graph file.
>> Why this design, instead of what "repack -a" would do, iow, if there
>> always is a singleton that is the only one that matters, shouldn't
>> the creation of that latest singleton just clear the older ones
>> before it returns control?
> Note that I am not complaining---I am just curious why we want to
> expose this "there is one relevant one but we keep irrelevant ones
> we usually do not look at and need to be garbage collected" to end
> users, and also expect readers of the series, resulting code and
> docs would have the same puzzled feeling.
>

Aside: I forgot to mention in my cover letter that the experience around 
the "--delete-expired" flag for "git commit-graph write" is different 
than v2. If specified, we delete all ".graph" files in the pack 
directory other than the one referenced by "graph_head" at the beginning 
of the process or the one written by the process. If these deletes fail, 
then we ignore the failure (assuming that they are being used by another 
Git process). In usual cases, we will delete these expired files in the 
next instance. I believe this matches similar behavior in gc and repack.

-- Back to discussion about the value of "graph_head" --

The current design of using a pointer file (graph_head) is intended to 
have these benefits:

1. We do not need to rely on a directory listing and mtimes to determine 
which graph file to use.

2. If we write a new graph file while another git process is reading the 
existing graph file, we can update the graph_head pointer without 
deleting the file that is currently memory-mapped. (This is why we 
cannot just rely on a canonical file name, such as "the_graph", to store 
the data.)

3. We can atomically change the 'graph_head' file without interrupting 
concurrent git processes. I think this is different from the "repack" 
situation because a concurrent process would load all packfiles in the 
pack directory and possibly have open handles when the repack is trying 
to delete them.

4. We remain open to making the graph file incremental (as the MIDX 
feature is designed to do; see [1]). It is less crucial to have an 
incremental graph file structure (the graph file for the Windows 
repository is currently ~120MB versus a MIDX file of 1.25 GB), but the 
graph_head pattern makes this a possibility.

I tried to avoid item 1 due to personal taste, and since I am storing 
the files in the objects/pack directory (so that listing may be very 
large with a lot of wasted entries). This is less important with our 
pending change of moving the graph files to a different directory. This 
also satisfies items 2 and 3, as long as we never write graph files so 
quickly that we have a collision on mtime.

I cannot think of another design that satisfies item 4.

As for your end user concerns: My philosophy with this feature is that 
end users will never interact with the commit-graph builtin. 99% of 
users will benefit from a repack or GC automatically computing a commit 
graph (when we add that integration point). The other uses for the 
builtin are for users who want extreme control over their data, such as 
code servers and build agents.

Perhaps someone with experience managing large repositories with git in 
a server environment could chime in with some design requirements they 
would need.

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20180107181459.222909-2-dstolee@microsoft.com/
     [RFC PATCH 01/18] docs: Multi-Pack Index (MIDX) Design Notes
