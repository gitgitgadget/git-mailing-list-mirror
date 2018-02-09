Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77E91F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeBINqB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:46:01 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38525 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeBINp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:45:57 -0500
Received: by mail-qk0-f194.google.com with SMTP id w128so10014758qkb.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5T8tdqb0j27C0ARTg8DNn2v8G0ATEiYifHBV5pa2am0=;
        b=ko9cwjvtl3FBR+BkW+zfGqUBX/856rlteN/65254ox6f1p7JO1Z58GqZYHqVzhG2sl
         9dZfTXulNOQt7aRA7qzypuE+Ak8koQKbHJfeQ0YejHGEuuAyxWsQBmQagT51nvoPSWmV
         B5+jRSIylK4cQF6M8FFsFZkn3Q4SSdTAyV4rY7Yia3MR91tBn7CsGu01hb/P0ndon9n2
         yxVbX7d9gC1VP/cDrayM287o69ytBReFCbv7/xkS12CHc3kIy2Dvs6csVGVk98lWbM1L
         HeBbpiW9CV0ALbrmHwZ3tyMMytzcuH2aJM5DFdZAxctY2Q1EhO3L/7E+AM1qdlCdtw2n
         IbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5T8tdqb0j27C0ARTg8DNn2v8G0ATEiYifHBV5pa2am0=;
        b=D3ELV7jaoEBrWwvvqmLKorYm+zTv/X92a+ikuH+emEpfafGj6h8RPELPMdWiAo0Ckj
         UV3Nm3WYI0B7hDQ8uzTh8Xa6WpZWyynpNLL475l3Uuiv6sZRzDvbgVvQH20+jnFClKs/
         GDXAo7puroNyTcZ+IVhLa++MMgyGPPSmqnkSxB5NTo5f/+09PI9m2j6r5Ipzyva3Kmiu
         NZBf8Zbvmsi4l3SVDJh5peY5IVG0r4Us606CmwBwNqp7xVKAidORrZ9fGhNRe1q9QE/i
         JrLM9VqwvuqDXTJ9fQiwku2PK3JLNGyh5ThKcphpq/RBb0ps24P+hgMDsXHz6Bx/aNf1
         8V6g==
X-Gm-Message-State: APf1xPDvI2OZLgQGzWtOC/mRc65iAWXsZWtWPwNYtM+bBm9eQlcZQ5Bp
        0hg0ZCCoqwHdBrMECbeGKgc=
X-Google-Smtp-Source: AH8x2255t3V3/KrYWR4NR/t3evkFTsqqI1jNIxhOmfdYr1IpOGm/C5N/ETvSf/Xr+5TYQQFnKGRf3w==
X-Received: by 10.55.108.199 with SMTP id h190mr4137119qkc.78.1518183956655;
        Fri, 09 Feb 2018 05:45:56 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id s189sm1840923qke.16.2018.02.09.05.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 05:45:55 -0800 (PST)
Subject: Re: [PATCH v3 14/14] commit-graph: build graph from starting commits
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-15-git-send-email-dstolee@microsoft.com>
 <CAM0VKjk-JvCNebTiHVm16vtwKpLF+N-gfGNL=7sYR=OVTb979w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <054043b5-7f2e-0b69-d770-ab23b756f82b@gmail.com>
Date:   Fri, 9 Feb 2018 08:45:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjk-JvCNebTiHVm16vtwKpLF+N-gfGNL=7sYR=OVTb979w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2018 8:02 AM, SZEDER Gábor wrote:
> On Thu, Feb 8, 2018 at 9:37 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> Teach git-commit-graph to read commits from stdin when the
>> --stdin-commits flag is specified. Commits reachable from these
>> commits are added to the graph. This is a much faster way to construct
>> the graph than inspecting all packed objects, but is restricted to
>> known tips.
>>
>> For the Linux repository, 700,000+ commits were added to the graph
>> file starting from 'master' in 7-9 seconds, depending on the number
>> of packfiles in the repo (1, 24, or 120).
> It seems something went wrong with '--stdin-commits' in v3, look:
>
>    ~/src/git (commit-graph-v2 %)$ time { git rev-parse HEAD | ./git
> commit-graph --write --update-head --stdin-commits ; }
>    ee3223fe116bf7031a6c1ad6d41e0456beefa754
>
>    real  0m1.199s
>    user  0m1.123s
>    sys   0m0.024s
>
>    ~/src/git (commit-graph-v3 %)$ time { git rev-parse HEAD | ./git
> commit-graph write --update-head --stdin-commits ; }
>    ee3223fe116bf7031a6c1ad6d41e0456beefa754
>
>    real  0m30.766s
>    user  0m29.120s
>    sys   0m0.546s

Thanks, Szeder. You're right. This is the diff that I forgot to apply in 
the last commit:

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 28d043b..175b967 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -257,7 +257,7 @@ static int graph_write(int argc, const char **argv)

         has_existing = !!get_graph_head_hash(opts.pack_dir, 
&old_graph_hash);

-       if (opts.stdin_packs) {
+       if (opts.stdin_packs || opts.stdin_commits) {
                 struct strbuf buf = STRBUF_INIT;
                 nr_lines = 0;
                 alloc_lines = 128;


I'll work to create a test that ensures we are only adding commits 
reachable from specific commits to prevent this regression.

Thanks,
-Stolee
