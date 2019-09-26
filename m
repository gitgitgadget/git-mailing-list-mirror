Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2981F463
	for <e@80x24.org>; Thu, 26 Sep 2019 13:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfIZNMV (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:12:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36060 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfIZNMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:12:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so1701941qkc.3
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dJ1n+/8MWHWQgqjH7Qv6sKBgitRcy1bYHVYno6MjqX8=;
        b=HhWG7WZ8aZB8KXuD105btVngH+k/keT++z2m0V91e+ClMblA5Tucmzzyd95i+idgoh
         DTOtomJ5NoHoO0F36lglLO8OL856HNQrvv7NPhJRclicxZt9UnpNOl6PQ/02xyx6Go7s
         2/s8tm+EaVbnJybdpDre2BGw383XsRM7jgYxFfCJv2kSipEs5EJOJG3n9V0ElhPsIsAS
         86QmuRTLKa3JSJRv7mZVPmNz09PyDxVdd5Aq172miJoNa6KatM3/R/O9HBlFQdJ1Om9b
         UsZLYZOioRt4vft5XVJQ1DD641BGPvYpFFmUS3TEuTac1JaC40pPQog3/gMzg79PEpYL
         YKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJ1n+/8MWHWQgqjH7Qv6sKBgitRcy1bYHVYno6MjqX8=;
        b=rvZtEWVUsgbRlhFstuyCAV8GGH1NsC1zcjX4QMfqHYsB9H4MYc+VOBJUjl0hERimbu
         Cusu1ZI6zn49ss5b//6aRb+FAYfPuG/I53vTN7cNnaL8iqETMYrxbX5bI6ddNZnLrKPN
         mIgc/UeQezKnpVIbjduvwq62ycn+HQqVWJhGn+v1BKVjTZ9MPwUfc0zjjzXKli7NuSQI
         GFnN7pGf5B9r3lWT8uCHa5g5gCx8TxgWdvX59awbRLWGakpyUD7Tg1N3LiS9Kq0y3lUQ
         oOWinvsAeVh1MAyw3CeZpMVOPtZBq25vwqduxfqICybmmqZEY/1M2Pi1uYCY6oV2vh57
         T9zw==
X-Gm-Message-State: APjAAAXPuUZ2oubNd2at2WkliJUoKRrGuZ4tLMfOwK7x2tqRKZbf/tI+
        pHcITSp7Y2Jggkfo20SYhIo=
X-Google-Smtp-Source: APXvYqzUEK1pHvn1XBa31C2PtP0dKV00VtyQt4Td6F6HdqppKSwriDgCk9AsRjnF3r5uMkxcPNNmZw==
X-Received: by 2002:a37:a409:: with SMTP id n9mr3060432qke.485.1569503538779;
        Thu, 26 Sep 2019 06:12:18 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b594:20f6:c10f:d45d? ([2001:4898:a800:1012:66c8:20f6:c10f:d45d])
        by smtp.gmail.com with ESMTPSA id g194sm1032852qke.46.2019.09.26.06.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:12:18 -0700 (PDT)
Subject: Re: [PATCH 2/3] diffcore-break: use a goto instead of a redundant if
 statement
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, davvid@gmail.com
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-3-alexhenrie24@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5382f6cc-d699-0c99-6d61-60cae45f27c2@gmail.com>
Date:   Thu, 26 Sep 2019 09:12:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190925020158.751492-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2019 10:01 PM, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  diffcore-break.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/diffcore-break.c b/diffcore-break.c
> index 875aefd3fe..f6ab74141b 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -286,18 +286,17 @@ void diffcore_merge_broken(void)
>  					/* Peer survived.  Merge them */
>  					merge_broken(p, pp, &outq);
>  					q->queue[j] = NULL;
> -					break;
> +					goto done;
>  				}
>  			}
> -			if (q->nr <= j)
> -				/* The peer did not survive, so we keep
> -				 * it in the output.
> -				 */
> -				diff_q(&outq, p);
> +			/* The peer did not survive, so we keep
> +			 * it in the output.
> +			 */
>  		}
> -		else
> -			diff_q(&outq, p);
> +		diff_q(&outq, p);
>  	}
> +
> +done:
>  	free(q->queue);
>  	*q = outq;

This took a little more context to check.

The "if (q->nr <= j)" condition essentially means "did the
for loop above end via the sentinel, not a break?" This
means that the diff_q() call is run if the for loop finishes
normally OR if we hit the visible "else" call.

There is some subtlety with the if / else if / else conditions.
The 'if' condition has a 'continue' which avoids the diff_q in
its new position.

Something like the two paragraphs above would be good to add
to the commit message so we can more easily read this patch
in the future.

Here is the full method context (in master) to help others:

void diffcore_merge_broken(void)
{
        struct diff_queue_struct *q = &diff_queued_diff;
        struct diff_queue_struct outq;
        int i, j;

        DIFF_QUEUE_CLEAR(&outq);

        for (i = 0; i < q->nr; i++) {
                struct diff_filepair *p = q->queue[i];
                if (!p)
                        /* we already merged this with its peer */
                        continue;
                else if (p->broken_pair &&
                         !strcmp(p->one->path, p->two->path)) {
                        /* If the peer also survived rename/copy, then
                         * we merge them back together.
                         */
                        for (j = i + 1; j < q->nr; j++) {
                                struct diff_filepair *pp = q->queue[j];
                                if (pp->broken_pair &&
                                    !strcmp(pp->one->path, pp->two->path) &&
                                    !strcmp(p->one->path, pp->two->path)) {
                                        /* Peer survived.  Merge them */
                                        merge_broken(p, pp, &outq);
                                        q->queue[j] = NULL;
                                        break;
                                }
                        }
                        if (q->nr <= j)
                                /* The peer did not survive, so we keep
                                 * it in the output.
                                 */
                                diff_q(&outq, p);
                }
                else
                        diff_q(&outq, p);
        }
        free(q->queue);
        *q = outq;

        return;
}
