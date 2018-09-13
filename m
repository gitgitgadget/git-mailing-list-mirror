Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C811F404
	for <e@80x24.org>; Thu, 13 Sep 2018 16:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIMVsf (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 17:48:35 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39831 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbeIMVsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 17:48:35 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so5963761qtk.6
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FeS20pKBK4A2vN4Ia+oPee0d/ABTiuY5B1Bg3+gYoGI=;
        b=iHwRKcJ0cmX7Bvo5dgFNrcPt8NU5pdEsUyNddLbG+AqacNPEIThtOVjD/nbQMObhWB
         4iQdF1q2xXfuzGgnye7cgq2qUoge2STEbk0l9rla5pD+By8fvYgyilU8FaEkL5CsrQP1
         QQgWp7t+HUmDxS2BBLF7+nl5XaCJGsVo041Fpv1QAcg5pOSjYV67zKVOormuq8EF82PI
         +NCJtsMrElEnQd4zUR4rinf/sajvcBnPYsO0hTommonShYxPmtKxrDiMQuTXf7Jc47lW
         a3qSwbuqpjCXrUC3UphYu+vnSDaL9wiAPCMvb5dN5Ss9Tw8NvIwVqiAX1SJ+mjD8zgVR
         NNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FeS20pKBK4A2vN4Ia+oPee0d/ABTiuY5B1Bg3+gYoGI=;
        b=Nb+kjgK6RaL0dMkkpmahtTVllQy3HsR6s9S4ADZJzkcQROU+w3ZKrMB+DWr1XrD29x
         ar01NJv6q+NslBFRAocgELtFQ1VwPA/VBz4wsYxfJS/edPy4AsDVuBo5MQV8fn+/CBOp
         hc6Nl+SLh3MosTkSVwD+C9whsUCOjQlYiQ9HPOgKJY++8jb70sl0Vnyo2NmC/IWnD8/T
         OaNWpFzGv6EVt2m8CxEn6/dPAPm7mUBK3Df3LIqKvPVKrIpCt/4NTmWJwvhPn21V1ITL
         QElKDve4OpXWYB9wTDLhNkXtvfzgYpGzelbzsP2O+fYdevLXlGa7LCJsExIqMJOOkMzo
         fDSQ==
X-Gm-Message-State: APzg51DN9UyOAcvIrIhm30AykBfV2hBo84cMOm05TwF0wvP0/nxc+BIV
        Jcz3WoL06Y8Lbnhv243TqNA=
X-Google-Smtp-Source: ANB0Vdbk9/rzBdYMYwzp99BWaIJKQFWfHYVr74TlJKlI48LS0SAED0W4leZKoZ+ACw4gIk6knMs4gw==
X-Received: by 2002:aed:20f1:: with SMTP id 104-v6mr6069749qtb.81.1536856697946;
        Thu, 13 Sep 2018 09:38:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d087:f807:1318:50bb? ([2001:4898:8010:0:b9bd:f807:1318:50bb])
        by smtp.gmail.com with ESMTPSA id k15-v6sm3026780qtf.95.2018.09.13.09.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 09:38:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] commit-reach: properly peel tags
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.39.git.gitgitgadget@gmail.com>
 <pull.39.v2.git.gitgitgadget@gmail.com>
 <4bf21204ddf8b9daa823db9954ddde98ab264a1b.1536855032.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com>
Date:   Thu, 13 Sep 2018 12:38:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4bf21204ddf8b9daa823db9954ddde98ab264a1b.1536855032.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2018 12:10 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The can_all_from_reach_with_flag() algorithm was refactored in 4fbcca4e
> "commit-reach: make can_all_from_reach... linear" but incorrectly
> assumed that all objects provided were commits. During a fetch
> negotiation, ok_to_give_up() in upload-pack.c may provide unpeeled tags
> to the 'from' array. The current code creates a segfault.
>
> Add a direct call to can_all_from_reach_with_flag() in 'test-tool reach'
> and add a test in t6600-test-reach.sh that demonstrates this segfault.
>
> Correct the issue by peeling tags when investigating the initial list
> of objects in the 'from' array.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   commit-reach.c        | 33 ++++++++++++++++++++++++++-------
>   t/helper/test-reach.c | 22 +++++++++++++++++-----
>   t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++--
>   3 files changed, 71 insertions(+), 14 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 86715c103c..4048a2132a 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -544,20 +544,39 @@ int can_all_from_reach_with_flag(struct object_array *from,
>   {
>   	struct commit **list = NULL;
>   	int i;
> +	int nr_commits;
>   	int result = 1;
>   
>   	ALLOC_ARRAY(list, from->nr);
> +	nr_commits = 0;
>   	for (i = 0; i < from->nr; i++) {
> -		list[i] = (struct commit *)from->objects[i].item;
> +		struct object *from_one = from->objects[i].item;
>   
> -		if (parse_commit(list[i]) ||
> -		    list[i]->generation < min_generation)
> -			return 0;
> +		if (!from_one || from_one->flags & assign_flag)
> +			continue;
> +
> +		from_one = deref_tag(the_repository, from_one,
> +				     "a from object", 0);
> +		if (!from_one || from_one->type != OBJ_COMMIT) {
> +			/* no way to tell if this is reachable by
> +			 * looking at the ancestry chain alone, so
> +			 * leave a note to ourselves not to worry about
> +			 * this object anymore.
> +			 */
> +			from->objects[i].item->flags |= assign_flag;
> +			continue;
> +		}
> +
> +		list[nr_commits] = (struct commit *)from_one;
> +		if (parse_commit(list[nr_commits]) ||
> +		    list[nr_commits]->generation < min_generation)
> +			return 0; /* is this a leak? */

Of course, after sending v2, I see this comment. This is a leak of 
'list' and should be fixed.

Not only is it a leak here, it is also a leak in the 'cleanup' section. 
I'll squash the following into v3, but I'll let v2 simmer for review 
before rerolling.


diff --git a/commit-reach.c b/commit-reach.c
index 4048a2132a..c457d8d85f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -569,8 +569,11 @@ int can_all_from_reach_with_flag(struct 
object_array *from,

                 list[nr_commits] = (struct commit *)from_one;
                 if (parse_commit(list[nr_commits]) ||
-                   list[nr_commits]->generation < min_generation)
-                       return 0; /* is this a leak? */
+                   list[nr_commits]->generation < min_generation) {
+                       result = 0;
+                       goto cleanup;
+               }
+
                 nr_commits++;
         }

@@ -623,6 +626,7 @@ int can_all_from_reach_with_flag(struct object_array 
*from,
                 clear_commit_marks(list[i], RESULT);
                 clear_commit_marks(list[i], assign_flag);
         }
+       free(list);
         return result;
  }

