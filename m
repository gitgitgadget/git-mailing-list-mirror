Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF4C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C68620737
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inzeqiwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636108AbgDON14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636102AbgDON1v (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 09:27:51 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE43C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 06:27:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m13so67836otf.6
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6l7A5lbxkbCzO6GVeqPNECdGgLqevNsduvPXAuIRQ8=;
        b=inzeqiwD5Cly3Gh7kZWS0rEc/zBwyIq+JYPF4bPQnYngDtsJHbKeYdi0Vu5p7XLKbm
         qzsPn0XmKqfVrkoQYcvZ1zpqBo9fGWcnSbqKTDTH08jCL5wxCA2ll23l9EIa/IdX6x/Z
         9tYN5tKnu/yc7Zvr4ej7MzE+KZtT6vA/SH8oAJp5uG7Rw7JRrzzJ6wfQtyUyVn7iF7/z
         +oKy4dwfi0KV6gikAx3Zbml4L+rEsnmsKgvkKkeaPRqNMGBrh4ZRBl7fct6YMFV4e/VT
         PFCLIdUaH8KE1UlRAJiRT6YX1RbLNLeenw9LmTAfxOx+K1ve/48J/Fck4u4gChQ2xHby
         9ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6l7A5lbxkbCzO6GVeqPNECdGgLqevNsduvPXAuIRQ8=;
        b=BXgQ5Kp1iGObfKsAfscaWRGS7QeSKR3XiW82mE9Iclb1vA8ECIUfQgqxZrFjtaxrF1
         fk6OEpjgrqkMr4CsPwEORPD77focHiTazacRxyUoivcmGIHFI2K0i9Q4o3z5bhoXRILf
         M+vKuoqmIVQzqcIC2VqQLm6YLGtPEZlKq1iT3re3I72D21KqAgKDLp3HrMsZW6Zigd7k
         tUzWKZcnK0+GWFw+SMxJM+NUUTMIdNmWfxplq3jDSmQfd2O8bFUjyKFzM6B8CFesdggH
         30+wRrhUrW0uAmKjT6ojXMRlXz3HWU/Z894lOLO0k0TlhlGKZHDF9cRVEBbPDuHOvO3v
         CssA==
X-Gm-Message-State: AGi0PuYam+iTovp08/mL2aMoYwMnpvC90p+iQiNWTyMjUqfdg8GO8IL1
        fITz7cVzcRNyD6b4oDCN2pQ=
X-Google-Smtp-Source: APiQypLZSDamJ17jv/jtQFY5llyS8mSI7Zx83k9Q4xhBC8wQPjuK+jVWxkQN1W419P8Dh/C7NGB5mA==
X-Received: by 2002:a9d:629a:: with SMTP id x26mr20633541otk.201.1586957269019;
        Wed, 15 Apr 2020 06:27:49 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f45sm6300703otf.30.2020.04.15.06.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 06:27:46 -0700 (PDT)
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com>
 <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
 <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
Date:   Wed, 15 Apr 2020 09:27:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 2:25 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> But if users may use icase pathspec very often, it may be worth
>>> considering to build the bloom filter after downcasing the paths,
>>> perhaps?  Given that many projects extract their source code to a
>>> case insensitive filesystem, I would imagine that downcasing paths
>>> would map two originally different paths into the same thing only
>>> rarely, if ever, so there may not be much downside to do so.
>>
>> This behavior could be extended later, and carefully. My initial
>> thought was that the case check would happen on every commit. If
>> the :(icase) check only happens at the walk tip(s), then we could
>> compute a single Bloom key at the start.
> 
> Sorry, I am not sure what you mean.

That's my fault. There are a couple of things I misunderstood here.

1. Thinking about "git blame" we would need to "collapse" a pathspec
   to a specific file before starting history. But blame doesn't
   allow ":(icase)" anyway.

2. With that context of "git blame" in my head, I was thinking
   (incorrectly) that "git log" would collapse the pathspec based on
   what file(s) match the pattern at HEAD. The tests in
   t6131-pathspec-icase.sh clearly show that this is wrong. In fact,
   if we apply the following diff to this patch, then we can get failures
   with the changed-path filters:

diff --git a/revision.c b/revision.c
index f78c636e4d..a02be25feb 100644
--- a/revision.c
+++ b/revision.c
@@ -652,13 +652,14 @@ static void trace2_bloom_filter_statistics_atexit(void)
 
 static int forbid_bloom_filters(struct pathspec *spec)
 {
+       int allowed_flags = PATHSPEC_LITERAL | PATHSPEC_ICASE;
        if (spec->has_wildcard)
                return 1;
        if (spec->nr > 1)
                return 1;
-       if (spec->magic & ~PATHSPEC_LITERAL)
+       if (spec->magic & ~allowed_flags)
                return 1;
-       if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
+       if (spec->nr && (spec->items[0].magic & ~allowed_flags))
                return 1;
 
        return 0;

> Do you mean that we notice that the user wants to match 'foo' case
> insensitively, and tell the logic that uses changed-path records in
> the graph file that commits that cannot possibly have touched any or
> the paths 'foo', 'foO', 'fOo', ... (all 8 case permutations) are not
> interesting?
> 
> I guess that would work, but I was wondering if it is simpler
> without much downside if the changed-path records in the graph file
> are prepared on paths after they are normalized to a single case.
> That would lose information (e.g. you no longer can say "commits
> that touch the path 'foo' is interesting, but those that touch the
> path 'Foo' are not"), but makes the side that queries much simpler
> (i.e. you do not have to prepare all 8 case permutations---you only
> ask about 'foo').
> 
> And because the Bloom filter is used only for performance to cull
> commits that can never possibly match, allowing a false positive
> that would be discarded by actually running tree-diff anyway, the
> only potential downside happens when the project has too many paths
> that are different only in cases by increased collisions and by
> reducing our chances to skip running tree-diff (and never affects
> correctness).  
> 
> But this is not the "could be extended later" kind of behaviour, I
> am afraid.  It is baked in the data stored in the graph file.

Since the feature is not released, we still have time to update the
format if we so desired. With the current format, we would need to
disable the filters when using an :(icase) pathspec as the current
patch does.

I'm not against the idea. Logically, collapsing case before hashing
the Bloom keys should not increase the probabilities of false
positives except in the situations where we have case conflicts.
There is a small cost in the pre-hashing step to change the case of
the paths, but that should be much lower than the cost of the hash
itself and the tree parsing to find the changed paths.

> It all depends on how often people want :(icase) pathspec matches in
> the history, I suspect.  My point was that we need to declare that
> :(icase) won't matter in real life (hence we won't optimize our data
> to support that use case), before the way in which the data stored
> in the graph file is computed is cast in stone.

My earlier statement can be summarized as "we could make this happen"
and you ask here "is it worth doing?"

I will play around with how complicated the change would be while
the community considers the "is it worth doing?" question.

Thanks,
-Stolee
