Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C10E1F42D
	for <e@80x24.org>; Wed,  4 Apr 2018 15:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDDPsr (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 11:48:47 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34446 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeDDPsp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 11:48:45 -0400
Received: by mail-qt0-f170.google.com with SMTP id l18so23606070qtj.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DcUVrR57KEFUF7hV3kovfVflbdYK1vlNub3bpgs9tIo=;
        b=MMs5ntxpS9llF2//XOc0rZ0KGuFi5iPlsDVnWqLjsM7TafxVhdgltIEFf1P9OUzmHc
         80xBtKw5F+cf5WpmViDVlN9TtK9E2PkZOlAHnvtkIEsM7yTHGK4CXRWC+Eq8XMYGxser
         V8svRwsMJfuc0l9KX/+eYHGWPKwx4+sEEJs4vyiUqoHMeqWEWfqX4ajFWhxUaIO6JRlH
         be7M2MW5KowLt3Z4zo6tDOsFdwomo8R88tPfSIBAD+tSPyETOQu2b1rdIQOlJIQJpE15
         R/y+GY6ODtXIle55w4u+mptoNV3mIq9jUsxEcyWeIM9VYXCMoFHk0WP0jdJHH8i0ecYU
         Nv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DcUVrR57KEFUF7hV3kovfVflbdYK1vlNub3bpgs9tIo=;
        b=H7aFnxw1DyhGvPn7RFH0iQ+IwrsvtU/dZyEClDVMZmAV2pjUdQh2DONTPIEq2U1AKV
         fk9lhMIaKhIvTjZ1NRukYCdboV99HSKZE180DmuoU+gbp/g+QkNjUaoRGdT934vOUN8a
         5A+yYji/s4Yg4RJsiOzbZQzm4uMcb1BtHuxFDNonKrScYpnbRc2BehVhvHwsusFD6lmq
         CIVRZwaqmwDTgXfvZBb2KL1yMOGnY35JZwW3tqkYIwr9gJhHyVKqzBA6V6iHpOucCAXv
         CE6xp9vlzyVHMhyVVsrZSVUbBuIczIM7mYXCXGtz90rjdqOBsLC1972lr1jm7iEAPfc1
         FQdw==
X-Gm-Message-State: ALQs6tB+9FnzknkhNSOhpHtMVFQ9vrISanS+IDiTNt+F/4OqNzBsPvwN
        zL3e/tEsCuG1I/XIL5vwaBpCcM/G
X-Google-Smtp-Source: AIpwx4869wtd39fQNRCdKRFPehM1RgLsvvwz+D1RGJoQOzJHxxkUeMfCBmiQ0goO/U+yLfSE0/Lz1g==
X-Received: by 10.200.48.71 with SMTP id g7mr26834492qte.56.1522856924439;
        Wed, 04 Apr 2018 08:48:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id q184sm3930063qkf.79.2018.04.04.08.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 08:48:43 -0700 (PDT)
Subject: Re: [PATCH 8/6] commit: use generation numbers for in_merge_bases()
To:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, sbeller@gmail.com,
        larsxschneider@gmail.com, bmwill@google.com
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404154554.140716-2-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <14e4e1d3-5c77-dc7c-10d5-e9406b992f0e@gmail.com>
Date:   Wed, 4 Apr 2018 11:48:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404154554.140716-2-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2018 11:45 AM, Derrick Stolee wrote:
> The containment algorithm for 'git branch --contains' is different
> from that for 'git tag --contains' in that it uses is_descendant_of()
> instead of contains_tag_algo(). The expensive portion of the branch
> algorithm is computing merge bases.
>
> When a commit-graph file exists with generation numbers computed,
> we can avoid this merge-base calculation when the target commit has
> a larger generation number than the target commits.
>
> Performance tests were run on a copy of the Linux repository where
> HEAD is contained in v4.13 but no earlier tag. Also, all tags were
> copied to branches and 'git branch --contains' was tested:
>
> Before: 60.0s
> After:   0.4s
> Rel %: -99.3%
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   commit.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index 858f4fdbc9..2566cba79f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1059,12 +1059,19 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>   {
>   	struct commit_list *bases;
>   	int ret = 0, i;
> +	uint32_t min_generation = GENERATION_NUMBER_UNDEF;
>   
>   	if (parse_commit(commit))
>   		return ret;
> -	for (i = 0; i < nr_reference; i++)
> +	for (i = 0; i < nr_reference; i++) {
>   		if (parse_commit(reference[i]))
>   			return ret;
> +		if (min_generation > reference[i]->generation)
> +			min_generation = reference[i]->generation;
> +	}
> +
> +	if (commit->generation > min_generation)
> +		return 0;
>   
>   	bases = paint_down_to_common(commit, nr_reference, reference);
>   	if (commit->object.flags & PARENT2)

This patch may suffice to speed up 'git branch --contains' instead of 
needing to always use the 'git tag --contains' algorithm as considered 
in [1].

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20180303051516.GE27689@sigill.intra.peff.net/
     Re: [PATCH 0/4] Speed up git tag --contains
