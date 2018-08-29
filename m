Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA97E1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeH2QiX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:38:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45041 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2QiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:38:23 -0400
Received: by mail-qk0-f196.google.com with SMTP id d131-v6so3194253qke.11
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=q1bw4QzoYuWdBpqXLRRqkcWSqasQAbR4VjmtTyEWEs4=;
        b=JnJi5iV0w0JInORIsG1RXh3SKWlAVHxXnVFS4ibHC65sgs9m5U7esrugxl2m9qnmYl
         l6LpCZpNMZkaAbmjlIq7HK8iVVJBYuVX/LTo7hooRPg/pwRCNEpmd+kyKcRKe+WiOhfV
         +nLonJwC2SFctykoX4qYOOYv0rgkDwRXOnfGi9NJayACsdw3KcHfWUV7y1E88bz6ZF7Q
         Fmbp93jgGWOZ4piwtSb3Z8K1DUPlmLuYHHyU7QAphmaW/3x6BeiCFpOJXwxVQOO4Mgpb
         vr6cqULdp2QdgX0sl2A0gSa5La8rmGgr8yFRjVTcxi0epIW5WPCQgNP5lXDTzHDxUuE2
         DmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q1bw4QzoYuWdBpqXLRRqkcWSqasQAbR4VjmtTyEWEs4=;
        b=Vv5R/aFeUntkVyw0SddOiMQMcVwhsyW4dLz/RXSu2jOcd25m8pRuHR3RtnhlixF8yu
         /AWpS555Iq8iGEkGRAxMuu33lfrYRc4d+q7F3WSxWgI4zmAILB/G6dOya9prBmpOhmAb
         FtMrQEaE/ESoE0l+Xto9Ll2eIowjOabWFH0+JrbzjvIeECGjwkdO3tqOsyTBL0E9YNJj
         0+llH6RXyDWMRdSPeHP0qQgNkRnKbWl9EhEjeh9bZE9jEYtYcwGCuJkKUPTkpwfgjqvi
         TDsZTQuoO6jiJZ6uxcUU+2R2q2C6QbEtoRqJyDh/UIkfojurdOn7GtuUPu4VLx1DCt2N
         WT+g==
X-Gm-Message-State: APzg51CjNmVe6fKJtg7H1u3+g0/LLWMJpgLvqI6rFPYP51k+lPjlqR96
        cK7Yl3kGt+3QicaAzcvGQkLvVHSENJU=
X-Google-Smtp-Source: ANB0VdY9V/HApBejU43sQvd3hVcg1Pid1EN4T18uqz8caibloaxXqynzcd5rUIOXoPOo4/LEb+FnsQ==
X-Received: by 2002:a37:8dc2:: with SMTP id p185-v6mr5953667qkd.53.1535546497928;
        Wed, 29 Aug 2018 05:41:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f86b:1660:ae35:a1de? ([2001:4898:8010:0:e1a1:1660:ae35:a1de])
        by smtp.gmail.com with ESMTPSA id r20-v6sm2496722qtc.81.2018.08.29.05.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:41:37 -0700 (PDT)
Subject: Re: [RFC PATCH 08/12] commit-graph: convert to using the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <20180829005857.980820-9-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef3f5ff2-a774-9e9b-d73a-b21630bede53@gmail.com>
Date:   Wed, 29 Aug 2018 08:41:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180829005857.980820-9-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 8:58 PM, brian m. carlson wrote:
> Instead of using hard-coded constants for object sizes, use
> the_hash_algo to look them up.  In addition, use a function call to look
> up the object ID version and produce the correct value.

The C code in this patch looks good to me. The only issue is that I 
predict failure in the 'git commit-graph verify' tests in 
t5318-commit-graph.sh. Squashing in this commit should help (assuming 
that test_oid works, it doesn't at my current branch):

-->8--

Subject: [PATCH] t5318-commit-graph.sh: use test_oid for HASH_LEN

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
  t/t5318-commit-graph.sh | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6aee861f78..676c1a9ae0 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -333,7 +333,7 @@ test_expect_success 'git commit-graph verify' '

  NUM_COMMITS=9
  NUM_OCTOPUS_EDGES=2
-HASH_LEN=20
+HASH_LEN="$(test_oid rawsz)"
  GRAPH_BYTE_VERSION=4
  GRAPH_BYTE_HASH=5
  GRAPH_BYTE_CHUNK_COUNT=6
--
2.19.0.rc1
