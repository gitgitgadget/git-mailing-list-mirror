Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE222018D
	for <e@80x24.org>; Thu, 11 May 2017 17:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbdEKRvm (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:51:42 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36445 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933212AbdEKRvk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:51:40 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so17333772pfg.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zSRwqPCLSZvxKEd3xqA6Zg2uJUeypvkoe2n4Jbn6t3Y=;
        b=jidUBr8/TAdcfYS9XjFSVLu5ij/8FmnBFMryAcDrvLyiCll2tBVD+LeOoKwSzTQ1NE
         8ji3WutTYtCKjM1LqLg/6UAWCzjBAraBAnQ3Z8zzCQdEfjzCBd/ENaa1XQRPszDj87n8
         Ccor54qWxziJ3xjDX14+TuQPzoBw4oebGlQwzNnqI6tCmtj3sxGwCyG7JZRtLYWHHCXr
         pRikmlO5OTSm6c1z76eJd99H+ZBKEZJnVkN/gCXqh06sLK+6qGEPX1iat8HflWI4yYZt
         Th2qeE1o2fr75H9+eeU0dPPzsOi226QG1dy8i2NB0p4baWmb6nNE0FsbL4+lcqXcC1Gi
         W78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zSRwqPCLSZvxKEd3xqA6Zg2uJUeypvkoe2n4Jbn6t3Y=;
        b=p9xDEq4HmW3RmlwUUxYGCGEED1w9tZ0KVXyHz0zq9fiMHkDTwgwgn2GaI+TdXAxAs1
         l9k72DvjvqjUcB/8+84On0OOCbxxh30tzIKoP6XEuqMOKIAp9lAuev4w6M6hhCBmMHiA
         rb9jBwSzFzO/9TneEM8AVOmlm8ZUx3Hma6s9CAZN+Rsta8EFlv9WObuHtuYBe82BFXoK
         hHKKGsiuOnoy3JzIU/P1sZjNHG3NlxGyoWsvVI4bBIrMGYasojRdQfFUBvAmAyo+bg+G
         gPVeKrUlcC+ZC6ye7mIV4hX+J5iADmNbVlx0G8IW3b0+GiFQZYMDTFPrYfYbLZcY3D/B
         nqTg==
X-Gm-Message-State: AODbwcAwJuuui9S1QaR8wV7kFGoP5Hcr7A387tmSGTA9eHRRH5y9Ob9f
        3F3v92CzUowm7/04
X-Received: by 10.98.10.135 with SMTP id 7mr302379pfk.193.1494525099831;
        Thu, 11 May 2017 10:51:39 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:b4a0:153f:8bf7:7f6c])
        by smtp.gmail.com with ESMTPSA id q82sm1302019pfl.28.2017.05.11.10.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:51:38 -0700 (PDT)
Subject: Re: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
To:     Jeff King <peff@peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510221157.8971-1-jonathantanmy@google.com>
 <20170511094635.ljpwg3bxkqj2wmgc@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <695d833e-9ef1-4d74-265e-f5e3af8a54cd@google.com>
Date:   Thu, 11 May 2017 10:51:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170511094635.ljpwg3bxkqj2wmgc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your suggestions. I'll hold off on sending out a new patch 
(following Jonathan Nieder's suggestions [1]) until we decide if further 
optimizations (for example, as suggested by Peff) need to be done.

[1] <20170510232231.GC28740@aiede.svl.corp.google.com>

On 05/11/2017 02:46 AM, Jeff King wrote:
> On Wed, May 10, 2017 at 03:11:57PM -0700, Jonathan Tan wrote:
>
>> After looking at ways to solve jrnieder's performance concerns, if we're
>> going to need to manage one more item of state within the function, I
>> might as well use my earlier idea of storing unmatched refs in its own
>> list instead of immediately freeing them. This version of the patch
>> should have much better performance characteristics.
>
> Hrm. So the problem in your original was that the loop became quadratic
> in the number of refs when fetching all of them (because the original
> relies on the sorting to essentially do a list-merge). Are there any
> quadratic bits left?
>
>> @@ -649,6 +652,25 @@ static void filter_refs(struct fetch_pack_args *args,
>>
>>  		if ((allow_unadvertised_object_request &
>>  		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
>> +			can_append = 1;
>> +		} else {
>> +			struct ref *u;
>> +			/* Check all refs, including those already matched */
>> +			for (u = unmatched; u; u = u->next) {
>> +				if (!oidcmp(&ref->old_oid, &u->old_oid)) {
>> +					can_append = 1;
>> +					goto can_append;
>> +				}
>> +			}
>
> This is inside the nr_sought loop. So if I were to do:
>
>   git fetch origin $(git ls-remote origin | awk '{print $1}')
>
> we're back to being quadratic. I realize that's probably a silly thing
> to do, but in the general case, you're O(m*n), where "n" is number of
> unmatched remote refs and "m" is the number of SHA-1s you're looking
> for.

The original patch was quadratic regardless of whether we're fetching 
names or SHA-1s, which can be said to be bad since it is a regression in 
an existing and common use case (and I agree). This one is O(m*n), as 
you said - the "quadratic-ness" only kicks in if you fetch SHA-1s, which 
before this patch is impossible.

> Doing better would require either sorting both lists, or storing the
> oids in something that has better than linear-time lookup.  Perhaps a
> sha1_array or an oidset? We don't actually need to know anything about
> the unmatched refs after the first loop. We just need the list of oids
> that let us do can_append.

Having a sha1_array or oidset would require allocation (O(n log n) time, 
I think, in addition to O(n) space) and this cost would be incurred 
regardless of how many SHA-1s were actually fetched (if m is an order of 
magnitude less than log n, for example, having a sha1_array might be 
actually worse). Also, presumably we don't want to incur this cost if we 
are fetching zero SHA-1s, so we would need to do some sort of pre-check. 
I'm inclined to leave it the way it is and consider this only if the use 
case of fetching many SHA1-s comes up.

> AIUI, you could also avoid creating the unmatched list entirely when the
> server advertises tip/reachable sha1s. That's a small optimization, but
> I think it may actually make the logic clearer.

If you mean adding an "if" block at the point where we add the unmatched 
ref to the unmatched list (that either adds it to the list or 
immediately frees it), I think it makes the logic slightly more 
complicated. Or maybe you had something else in mind?
