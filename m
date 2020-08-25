Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB07C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C8F2075F
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URHHMF1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHYNOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHYNOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 09:14:22 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDEBC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 06:14:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j21so1670824oii.10
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VFUcnAWJ4ggXqTR7v/9CKCchHPxlSKkf5y+9c8f3IZs=;
        b=URHHMF1r6cVEbZCWj1L/Y2wsGLXcrX2/kWYht3OUOO2xSH2G7OGUfgy6r7MH65e47L
         kAxBClSj4mp5kxSCirCbbCHvvYBh0Dl3lRhxFxapexio5Yh3BCNWuzWnFYAkAkYWFBeS
         uaILA8F8rowX/fRutSFNhxMb3vpbzkzurQ6KoO34lR0E6IsC/cylP4YoCzXQveFZGYD5
         5zHIiz1cmoG20QVQdDRKZkq4yH+oIVaZ1cO0kd/rMrFBGaL1nt40rzxzwr4shkHcRIuT
         Dsb2Mc4UaWx6WviJ2X7DIjjhWWhpakaSzo+ubknEk4thDjR8GLAJnJEYXu1A3M7Hov2b
         A3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFUcnAWJ4ggXqTR7v/9CKCchHPxlSKkf5y+9c8f3IZs=;
        b=mw+W9L9Ep/Zbc1pmkKnQpoJY7WU2Br0C+gfee+mb4dNB4UWYWyh3AU8iw2BrkpFjZV
         cG11bv9eI4HlxWwKyhhPCnS3XnEzDkbYyu3+TUodbQfjgtAJMe6/8iV3Sqbj08oDIwIx
         ouah+Ffz7O1GH0jT/lVd5DCdZv39OSdJNtrc41miOOqWrVD1uZCrtBaqbvlZC4BwLnWX
         aJW8h0qC7gkEJjb9kejRxbtYe6iyU+sE/RqLsMo5TdQnlTg0ACFTVKFlojeX8QtK4x5u
         NK2OVkOpK6FiMDoDbGvPTQ+A9O3O3oeDjGi3ARXe1urLVQUc+CXJ4rIGWBPAzHIIe4Ta
         lbEA==
X-Gm-Message-State: AOAM5335HbfRuwiVtwi/xYw03BCBbVhTYVodpWr2XP9Qe0UYxcYiqN7F
        +iEl8dSRywMttcxpWmJfpE1jq92HMPglXQ==
X-Google-Smtp-Source: ABdhPJxmuEE4IlD6jQIj9Of3WbBNrsHu0xId6HO8sMQ1yNKWgBXc15KlI4lEMcw+Cqd90vE4bF3dEw==
X-Received: by 2002:aca:130f:: with SMTP id e15mr945750oii.173.1598361260597;
        Tue, 25 Aug 2020 06:14:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:600d:49d2:12ae:f5e7? ([2600:1700:e72:80a0:600d:49d2:12ae:f5e7])
        by smtp.gmail.com with ESMTPSA id n186sm32378oig.33.2020.08.25.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 06:14:19 -0700 (PDT)
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <20200825023710.GA98081@syl.lan>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7eb9fb6-f1ea-f932-efaa-7434ad809989@gmail.com>
Date:   Tue, 25 Aug 2020 09:14:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200825023710.GA98081@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2020 10:37 PM, Taylor Blau wrote:
> On Mon, Aug 24, 2020 at 10:26:14PM -0400, Jeff King wrote:
>> On Mon, Aug 24, 2020 at 10:01:04PM -0400, Taylor Blau wrote:
>>
>>> In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
>>> learned to remove a multi-pack-index file if it added or removed a pack
>>> from the object store.
>>>
>>> This mechanism is a little over-eager, since it is only necessary to
>>> drop a MIDX if 'git repack' removes a pack that the MIDX references.
>>> Adding a pack outside of the MIDX does not require invalidating the
>>> MIDX, and likewise for removing a pack the MIDX does not know about.
>>
>> Does "git repack" ever remove just one pack? Obviously "git repack -ad"
>> or "git repack -Ad" is going to pack everything and delete the old
>> packs. So I think we'd want to remove a midx there.
>>
>> And "git repack -d" I think of as deleting only loose objects that we
>> just packed. But I guess it could also remove a pack that has now been
>> made redundant? That seems like a rare case in practice, but I suppose
>> is possible.
> 
> Yeah, the patch message makes this sound more likely than it actually
> is, which I agree is very rare. I often write 'git repack' instead of
> 'git pack-objects' to slurp up everything loose into a new pack without
> having to list loose objects by name.
> 
> That's the case that I really care about here: purely adding a new pack
> should not invalidate the existing MIDX.
> 
>> Not exactly related to your fix, but kind of the flip side of it: would
>> we ever need to retain a midx that mentions some packs that still exist?
>>
>> E.g., imagine we have a midx that points to packs A and B, and
>> git-repack deletes B. By your logic above, we need to remove the midx
>> because now it points to objects in B which aren't accessible. But by
>> deleting it, could we be deleting the only thing that mentions the
>> objects in A?
>>
>> I _think_ the answer is "no", because we never went all-in on midx and
>> allowed deleting the matching .idx files for contained packs. So we'd
>> still have that A.idx, and we could just use the pack as normal. But
>> it's an interesting corner case if we ever do go in that direction.
> 
> Agreed. Maybe a (admittedly somewhat large) #leftoverbits.
> 
>> If you'll let me muse a bit more on midx-lifetime issues (which I've
>> never really thought about before just now):
>>
>> I'm also a little curious how bad it is to have a midx whose pack has
>> gone away. I guess we'd answer queries for "yes, we have this object"
>> even if we don't, which is bad. Though in practice we'd only delete
>> those packs if we have their objects elsewhere. And the pack code is
>> pretty good about retrying other copies of objects that can't be
>> accessed. Alternatively, I wonder if the midx-loading code ought to
>> check that all of the constituent packs are available.
>>
>> In that line of thinking, do we even need to delete midx files if one of
>> their packs goes away? The reading side probably ought to be able to
>> handle that gracefully.
> 
> I think that this is probably the right direction, although I've only
> spend time in the MIDX code over the past couple of weeks, so I can't
> say with authority. It seems like it would be pretty annoying, though.
> For example, code that cares about listing all objects in a MIDX would
> have to check first whether the pack they're in still exists before
> emitting them. On top of that, there are more corner cases when object X
> exists in more than one pack, but some strict subset of those packs
> containing X have gone away.
> 
> I don't think that it couldn't be done, though.
> 
>> And the more interesting case is when you repack everything with "-ad"
>> or similar, at which point you shouldn't even need to look up what's in
>> the midx to see if you deleted its packs. The point of your operation is
>> to put it all-into-one, so you know the old midx should be discarded.
>>
>>> Teach 'git repack' to check for this by loading the MIDX, and checking
>>> whether the to-be-removed pack is known to the MIDX. This requires a
>>> slightly odd alternation to a test in t5319, which is explained with a
>>> comment.
>>
>> My above musings aside, this seems like an obvious improvement.
>>
>>> diff --git a/builtin/repack.c b/builtin/repack.c
>>> index 04c5ceaf7e..98fac03946 100644
>>> --- a/builtin/repack.c
>>> +++ b/builtin/repack.c
>>> @@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
>>>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
>>>  {
>>>  	struct strbuf buf = STRBUF_INIT;
>>> -	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
>>> +	struct multi_pack_index *m = get_multi_pack_index(the_repository);
>>> +	strbuf_addf(&buf, "%s.pack", base_name);
>>> +	if (m && midx_contains_pack(m, buf.buf))
>>> +		clear_midx_file(the_repository);
>>> +	strbuf_insertf(&buf, 0, "%s/", dir_name);
>>
>> Makes sense. midx_contains_pack() is a binary search, so we'll spend
>> O(n log n) effort deleting the packs (I wondered if this might be
>> accidentally quadratic over the number of packs).
> 
> Right. The MIDX stores packs in lexographic order, so checking them is
> O(log n), which we do at most 'n' times.
> 
>> And after we clear, "m" will be NULL, so we'll do it at most once. Which
>> is why you can get rid of the manual "midx_cleared" flag from the
>> preimage.
> 
> Yep. I thought briefly about passing 'm' as a parameter, but then you
> have to worry about a dangling reference to
> 'the_repository->objects->multi_pack_index' after calling
> 'clear_midx_file()', so it's easier to look it up each time.

The discussion in this thread matches my understanding of the
situation.

>> So the patch looks good to me.

The code in builtin/repack.c looks good for sure. I have a quick question
about this new test:

+test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
+	git multi-pack-index write &&
+	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
+	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
+
+	# Write a new pack that is unknown to the multi-pack-index.
+	git hash-object -w </dev/null >blob &&
+	git pack-objects $objdir/pack/pack <blob &&
+
+	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
+	test_cmp_bin $objdir/pack/multi-pack-index \
+		$objdir/pack/multi-pack-index.bak
+'
+

You create an arbitrary blob, and then add it to a pack-file. Do we
know that 'git repack' is definitely creating a new pack-file that makes
our manually-created pack-file redundant?

My suggestion is to have the test check itself:

+test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
+	git multi-pack-index write &&
+	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
+	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
+
+	# Write a new pack that is unknown to the multi-pack-index.
+	git hash-object -w </dev/null >blob &&
+	HASH=$(git pack-objects $objdir/pack/pack <blob) &&
+
+	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
+	test_cmp_bin $objdir/pack/multi-pack-index \
+		$objdir/pack/multi-pack-index.bak &&
+	test_path_is_missing $objdir/pack/pack-$HASH.pack
+'
+

This test fails for me, on the 'test_path_is_missing'. Likely, the
blob is seen as already in a pack-file so is just pruned by 'git repack'
instead. I thought that perhaps we need to add a new pack ourselves that
overrides the small pack. Here is my attempt:

test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
	git multi-pack-index write &&
	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&

	# Write a new pack that is unknown to the multi-pack-index.
	BLOB1=$(echo blob1 | git hash-object -w --stdin) &&
	BLOB2=$(echo blob2 | git hash-object -w --stdin) &&
	cat >blobs <<-EOF &&
	$BLOB1
	$BLOB2
	EOF
	HASH1=$(echo $BLOB1 | git pack-objects $objdir/pack/pack) &&
	HASH2=$(git pack-objects $objdir/pack/pack <blobs) &&
	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
	test_cmp_bin $objdir/pack/multi-pack-index \
		$objdir/pack/multi-pack-index.bak &&
	test_path_is_file $objdir/pack/pack-$HASH2.pack &&
	test_path_is_missing $objdir/pack/pack-$HASH1.pack
'

However, this _still_ fails on the "test_path_is_missing" line, so I'm not sure
how to make sure your logic is tested. I saw that 'git repack' was writing
"nothing new to pack" in the output, so I also tested adding a few commits and
trying to force it to repack reachable data, but I cannot seem to trigger it
to create a new pack that overrides only one pack that is not in the MIDX.

Likely, I just don't know how 'git rebase' works well enough to trigger this
behavior. But the test as-is is not testing what you want it to test.

Thanks,
-Stolee

