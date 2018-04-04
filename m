Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9BBF1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 19:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDDTW7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 15:22:59 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:42665 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeDDTWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 15:22:04 -0400
Received: by mail-qt0-f176.google.com with SMTP id j3so24338095qtn.9
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r4t1Zi0t8QKpWnKIATC0H8M6ViRw0JWtgl4dLdDmmtM=;
        b=jNwxpFeDA2GXjXbDdGmX4RvKswPOCDQsEWkit36x2NUyLB5CvBPKaD+kPMaSsLvt98
         sgiCivTvrrJuYv7DrRpPQLD8MFMyA4J4Nx6SCA2ZQSg26j021BE1TJ8gaP7YaJ8Yghke
         OVSKGzClUxQCyTCfSqnqRgeNqYbVLD2F/s6O1K4S/7Hk+9RUxi9NYlI1GydV3VD1LP8l
         hvh8VyJ7L8APQjh28756QgL63l0ZtGRheoYUwo3A7GbTlyDyy//Rshruml2aS1NaGuIZ
         KzEoCEBqn6UNP+IF+KBxV5uajCs+QMPYZrdQrTK7/3gPw+XXEl12WNub8RPUaZwqgCZW
         QCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r4t1Zi0t8QKpWnKIATC0H8M6ViRw0JWtgl4dLdDmmtM=;
        b=ZKPWyZuTUZXTj7Q7pOhO65+FbKulgwU7oKlT1lAMQE64Hw4Rv0T9MesHOCZBWn7d1k
         2jqwbfRCl5+rzJSc8nTaMgC648Pys+Kw8kY+OaLwdN1RrDOm+ey9je/3UwfjGJXE803w
         nxgtD2YCPOrZxaE5gauB5yg/DCrfi25u4a8hh3P7BiP2L3TA499lJmg0CTtkAvt/5Aqa
         51vin0XYz3FptNfLva+lfnpgk+066ZFkYDkkjq/SXtBT4iOIC8w0nmnFm/ghLmdeDkpa
         tpMZ93B1UO1jRBiV0C7KEolArmnicyy/MNwjgnZ1UVkF7zU3FfheTq+5DhhWdtUVtMWY
         TS4w==
X-Gm-Message-State: ALQs6tAoeZzogqtU0sF6RMY38j053jcae74Yir3U8qZZLOO/kVMxpkzW
        s+joAnJjJdWXi1Br5W0ZvQI=
X-Google-Smtp-Source: AIpwx4+PQfIs+88Cv2nhcYWULk6IF/d6tEQrhYg3VtIbT4lsDPCYh7ArGoffd5h64HwmFr6f8qq5JQ==
X-Received: by 10.200.3.91 with SMTP id w27mr27718218qtg.149.1522869723485;
        Wed, 04 Apr 2018 12:22:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n31sm5032650qtf.40.2018.04.04.12.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 12:22:02 -0700 (PDT)
Subject: Re: [PATCH 7/6] ref-filter: use generation number for --contains
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@gmail.com, larsxschneider@gmail.com,
        bmwill@google.com
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404182242.GA9055@sigill.intra.peff.net>
 <1cc07683-8d2e-e9fa-ffee-2663057704be@gmail.com>
 <20180404191657.GA13543@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fcded90f-cb12-dafd-f21a-18ea67e99406@gmail.com>
Date:   Wed, 4 Apr 2018 15:22:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404191657.GA13543@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2018 3:16 PM, Jeff King wrote:
> On Wed, Apr 04, 2018 at 03:06:26PM -0400, Derrick Stolee wrote:
>
>>>> @@ -1615,8 +1619,20 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>>>>    					      struct contains_cache *cache)
>>>>    {
>>>>    	struct contains_stack contains_stack = { 0, 0, NULL };
>>>> -	enum contains_result result = contains_test(candidate, want, cache);
>>>> +	enum contains_result result;
>>>> +	uint32_t cutoff = GENERATION_NUMBER_UNDEF;
>>>> +	const struct commit_list *p;
>>>> +
>>>> +	for (p = want; p; p = p->next) {
>>>> +		struct commit *c = p->item;
>>>> +		parse_commit_or_die(c);
>>>> +		if (c->generation < cutoff)
>>>> +			cutoff = c->generation;
>>>> +	}
>> Now that you mention it, let me split out the portion you are probably
>> talking about as incorrect:
>>
>>>> +	if (cutoff == GENERATION_NUMBER_UNDEF)
>>>> +		cutoff = GENERATION_NUMBER_NONE;
>> You're right, we don't want this. Since GENERATION_NUMBER_NONE == 0, we get
>> no benefit from this. If we keep it GENERATION_NUMBER_UNDEF, then our walk
>> will be limited to commits NOT in the commit-graph (which we hope is small
>> if proper hygiene is followed).
> I think it's more than that. If we leave it at UNDEF, that's wrong,
> because contains_test() compares:
>
>    candidate->generation < cutoff
>
> which would _always_ be true. In other words, we're saying that our
> "want" has an insanely high generation number, and traversing can never
> find it. Which is clearly wrong.

That condition is not always true (which is why we use strict comparison 
instead of <=). If a commit is not in the commit-graph file, then its 
generation is equal to GENERATION_NUMBER_UNDEF, as shown in alloc.c:

void *alloc_commit_node(void)
{
         struct commit *c = alloc_node(&commit_state, sizeof(struct 
commit));
         c->object.type = OBJ_COMMIT;
         c->index = alloc_commit_index();
         c->graph_pos = COMMIT_NOT_FROM_GRAPH;
         c->generation = GENERATION_NUMBER_UNDEF;
         return c;
}


> So we have to put it at "0", to say "you should always traverse, we
> can't tell you that this is a dead end". So that part of the logic is
> currently correct.
>
> But what I was getting at is that the loop behavior can't just pick the
> min cutoff. The min is effectively "0" if there's even a single ref for
> which we don't have a generation number, because we cannot ever stop
> traversing (we might get to that commit if we kept going).
>
> (It's also possible I'm confused about how UNDEF and NONE are used; I'm
> assuming commits for which we don't have a generation number available
> would get UNDEF in their commit->generation field).

I think it is this case.

> If you could make the assumption that when we have a generation for
> commit X, then we have a generation for all of its ancestors, things get
> easier. Because then if you hit commit X with a generation number and
> want to compare it to a cutoff, you know that either:
>
>    1. The cutoff is defined, in which case you can stop traversing if
>       we've gone past the cutoff.
>
>    2. The cutoff is undefined, in which case we cannot possibly reach
>       our "want" by traversing. Even if it has a smaller generation
>       number than us, it's on an unrelated line of development.
>
> I don't know that the reachability property is explicitly promised by
> your work, but it seems like it would be a natural fallout (after all,
> you have to know the generation of each ancestor in order to compute the
> later ones, so you're really just promising that you've actually stored
> all the ones you've computed).

The commit-graph is closed under reachability, so if a commit has a 
generation number then it is in the graph and so are all its ancestors.

The reason for GENERATION_NUMBER_NONE is that the commit-graph file 
stores "0" for generation number until this patch. It still satisfies 
the condition that gen(A) < gen(B) if B can reach A, but also gives us a 
condition for "this commit still needs its generation number computed".

>
>>> I wonder to what degree it's worth traversing to come up with a
>>> generation number for the "want" commits. If we walked, say, 50 commits
>>> to do it, you'd probably save a lot of work (since the alternative is
>>> walking thousands of commits until you realize that some ancient "v1.0"
>>> tag is not useful).
>>>
>>> I'd actually go so far as to say that any amount of traversal is
>>> generally going to be worth it to come up with the correct generation
>>> cutoff here. You can come up with pathological cases where you only have
>>> one really recent tag or something, but in practice every repository
>>> where performance is a concern is going to end up with refs much further
>>> back than it would take to reach the cutoff condition.
>> Perhaps there is some value in walking to find the correct cutoff value, but
>> it is difficult to determine how far we are from commits with correct
>> generation numbers _a priori_. I'd rather rely on the commit-graph being in
>> a good state, not too far behind the refs. An added complexity of computing
>> generation numbers dynamically is that we would need to add a dependence on
>> the commit-graph file's existence at all.
> If you could make the reachability assumption, I think this question
> just goes away. As soon as you hit a commit with _any_ generation
> number, you could quit traversing down that path.
That is the idea. I should make this clearer in all of my commit messages.

Thanks,
-Stolee
