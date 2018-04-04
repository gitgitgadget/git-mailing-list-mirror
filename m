Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913B91F42D
	for <e@80x24.org>; Wed,  4 Apr 2018 19:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeDDTGa (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 15:06:30 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36059 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDDTG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 15:06:29 -0400
Received: by mail-qk0-f180.google.com with SMTP id o205so23677649qke.3
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 12:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=izUwizxD2Ue8fuV6lWM5pBjKlGg8awLUvzC8EbTwi2I=;
        b=l4DOmjThj+jm6D9HUmERfXfNyhhYwHH/swAKxiTCSmO/Q8yb+2lsxOdxrDJANB5kOh
         531JGzlIh19xMUPYrJprVBHaie2tt9qfqeD6Getzzimvj7IJ1NA/pYKxgWKtEpx/52Tj
         q1gX/+yL0SEW/62E0LnP9ZTApBAiX7HfRyMNBSlJfDShNHu1kUm19GNllCBSKuB8wJ0S
         vnNKh0BllpFm8A+zdc4r1sIvlx8C1iSYyIjKmnrD0WbxowTA6Xz7wAo+xDZQaSuss/OM
         NMAtrsw8W0uIeBIFQokPG2DghjuJXwcm8DNtDYOTTB1y4x2RAkl/GPBYJYnBtcoobWbL
         7FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=izUwizxD2Ue8fuV6lWM5pBjKlGg8awLUvzC8EbTwi2I=;
        b=GouHO9J0xi+SEGrX39F2wZNATc4IIW/yxOekg6HrusnwPf+BkXHjDrIsMoCorZfqEd
         3Iab+1Q+guGV2pY7MoeA3YPM1YYJGnytxdLFiDpxoD3s8AFtOEwFGaMUuY51lqL7jnoD
         vLkgFANV3+DvgWENnDoICIcJizRD3CpYp9QzhVJTULPyP1EyjA4uLn9yf0jz7YAX8b4K
         il9M8NTVWiyTyeavg1hn//u3wHk7XAUasK4HzO8GLvFLvzEhIJu1p9lxF/+JDFX94Z+R
         ArjjfDpIa2AynQCT3SSfBR7vZyx/Td+FMYCm+dGCoy+l10I/D16UE7S0PGa1DTR93saB
         xwMA==
X-Gm-Message-State: ALQs6tDXL0CvxxxLYBAUcY8hiifCYJeP+8vZnqZ9JVWefKd7XYm7PCwk
        EMIjeY33cbXWte0/dMZ0I6o=
X-Google-Smtp-Source: AIpwx4+5gDm3JEaQJLxtFX9Ya7BFkRlvi/x+ZLOaBxpUATNWyhPeBPv5p0ywTpRDyKfzrPv5IvMEtQ==
X-Received: by 10.55.5.8 with SMTP id 8mr25941204qkf.84.1522868788618;
        Wed, 04 Apr 2018 12:06:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m67sm3240586qkc.88.2018.04.04.12.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 12:06:27 -0700 (PDT)
Subject: Re: [PATCH 7/6] ref-filter: use generation number for --contains
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@gmail.com,
        larsxschneider@gmail.com, bmwill@google.com
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404182242.GA9055@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1cc07683-8d2e-e9fa-ffee-2663057704be@gmail.com>
Date:   Wed, 4 Apr 2018 15:06:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404182242.GA9055@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2018 2:22 PM, Jeff King wrote:
> On Wed, Apr 04, 2018 at 11:45:53AM -0400, Derrick Stolee wrote:
>
>> @@ -1615,8 +1619,20 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>>   					      struct contains_cache *cache)
>>   {
>>   	struct contains_stack contains_stack = { 0, 0, NULL };
>> -	enum contains_result result = contains_test(candidate, want, cache);
>> +	enum contains_result result;
>> +	uint32_t cutoff = GENERATION_NUMBER_UNDEF;
>> +	const struct commit_list *p;
>> +
>> +	for (p = want; p; p = p->next) {
>> +		struct commit *c = p->item;
>> +		parse_commit_or_die(c);
>> +		if (c->generation < cutoff)
>> +			cutoff = c->generation;
>> +	}

Now that you mention it, let me split out the portion you are probably 
talking about as incorrect:

>> +	if (cutoff == GENERATION_NUMBER_UNDEF)
>> +		cutoff = GENERATION_NUMBER_NONE;

You're right, we don't want this. Since GENERATION_NUMBER_NONE == 0, we 
get no benefit from this. If we keep it GENERATION_NUMBER_UNDEF, then 
our walk will be limited to commits NOT in the commit-graph (which we 
hope is small if proper hygiene is followed).

> Hmm, on reflection, I'm not sure if this is right in the face of
> multiple "want" commits, only some of which have generation numbers.  We
> probably want to disable the cutoff if _any_ "want" commit doesn't have
> a number.
>
> There's also an obvious corner case where this won't kick in, and you'd
> really like it to: recently added commits. E.g,. if I do this:
>
>    git gc ;# imagine this writes generation numbers
>    git pull
>    git tag --contains HEAD
>
> then HEAD isn't going to have a generation number. But this is the case
> where we have the most to gain, since we could throw away all of the
> ancient tags immediately upon seeing that their generation numbers are
> way less than that of HEAD.
>
> I wonder to what degree it's worth traversing to come up with a
> generation number for the "want" commits. If we walked, say, 50 commits
> to do it, you'd probably save a lot of work (since the alternative is
> walking thousands of commits until you realize that some ancient "v1.0"
> tag is not useful).
>
> I'd actually go so far as to say that any amount of traversal is
> generally going to be worth it to come up with the correct generation
> cutoff here. You can come up with pathological cases where you only have
> one really recent tag or something, but in practice every repository
> where performance is a concern is going to end up with refs much further
> back than it would take to reach the cutoff condition.

Perhaps there is some value in walking to find the correct cutoff value, 
but it is difficult to determine how far we are from commits with 
correct generation numbers _a priori_. I'd rather rely on the 
commit-graph being in a good state, not too far behind the refs. An 
added complexity of computing generation numbers dynamically is that we 
would need to add a dependence on the commit-graph file's existence at all.

Thanks,
-Stolee
