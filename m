Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF5CC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiHJRvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiHJRvd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:51:33 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFD63CE
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:51:32 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v185so12734351ioe.11
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kS3ZPwfcL/jyAbnGHcPpmHze+RLXDCZ9k30aLpyNSfA=;
        b=BTRMTQ2EqrjfAdjcK5+sFneJrk0WKpe77F+gq4ujDTokC4amooXK2FbHs7clktvYz6
         Kmuj6RyvkK8tsp+lEV2z7CNUI9OBjc6w99/Oi2Cy2hhIKfzGUR+5jTbfQpVkfG8n+q+/
         b+lnwt4PdhJv55pcWsFBFl75nrxXeJFixSoR49Bs+y4SuiyMfxTDF3MpE/+Hk3aDcE9Z
         z/ihLhlt/rQf+jWzR0hofG90y/sebwmifIbjrgL6cc+g/cH+mMsqmTgpw+6p+1CT40FU
         boAyTufEGD77W++WKw9dqBZPsUyatNBwaNVYUA3MEpkthGlqwT1PkBMXGFmNp0L25gJz
         AUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kS3ZPwfcL/jyAbnGHcPpmHze+RLXDCZ9k30aLpyNSfA=;
        b=R9HVWfgoO705FNyyqdUhtYdwGg7AoKmvaxokxyEHXyOjs9rg2h9SVNGtpOQabMasK4
         VyYnwsD3hWaswUHjzraKvtpn2oks8YUtD92MlcILDCz5nC/7ZgLkOhp8FODpM7Okr8sz
         44jm2Di4EZzmrLs3a91obKBDJnojpFc2UFDuIf7K21Od5Bv0othpE6yv5WC41gdYakgs
         ZI/qNr0oVHW+/aAC1pUdqzI0NndVxqtchkISk5LLtHLLJoGpuN/bCLsFGNz723eumZxZ
         reha4M7prcIZGRHVN2ddnyKuhq8/2FNn0INZ8oyqRbwcfOjIZDSwIf6U4t49W8DsHD+Q
         Ul7w==
X-Gm-Message-State: ACgBeo2jlZTRD7kelRC7gx26jhBG5rU8wZphti06qCCH5tdNxk/LtQaX
        k8XJvlLOHHKBN7Rt++buyOGN
X-Google-Smtp-Source: AA6agR5EO2/3vi+eV4asBgmcWUbUZa2m9Ere+xA2+BfB3wdDKKRCjqe995MEEeHJVZRboGnV+OVrVg==
X-Received: by 2002:a05:6638:451a:b0:342:a64b:835c with SMTP id bs26-20020a056638451a00b00342a64b835cmr12651798jab.13.1660153888665;
        Wed, 10 Aug 2022 10:51:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:51d1:38a9:eee4:f5d1? ([2600:1700:e72:80a0:51d1:38a9:eee4:f5d1])
        by smtp.gmail.com with ESMTPSA id p17-20020a0566022b1100b0067be568081fsm2492408iov.43.2022.08.10.10.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 10:51:28 -0700 (PDT)
Message-ID: <805fb0df-45ab-7edd-8787-662b84201e2b@github.com>
Date:   Wed, 10 Aug 2022 13:51:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr>
 <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
 <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr>
 <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
 <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/2022 6:04 AM, Abhradeep Chakraborty wrote:
> On Wed, Aug 10, 2022 at 2:50 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Abhradeep,
>> I instrumented this, and saw that the `multi-pack-index` and
>> `multi-pack-index*.bitmap` files were unchanged by the `git repack`
>> invocation.
> 
> Yeah, those two files remain unchanged here.
> 
>> Re-generating the MIDX bitmap forcefully after the repack seems to fix
>> things over here:
>>
>> -- snip --
>> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
>> index a95537e759b..564124bda27 100644
>> --- a/t/lib-bitmap.sh
>> +++ b/t/lib-bitmap.sh
>> @@ -438,7 +438,10 @@ midx_bitmap_partial_tests () {
>>
>>         test_expect_success 'setup partial bitmaps' '
>>                 test_commit packed &&
>> +ls -l .git/objects/pack/ &&
>>                 git repack &&
>> +git multi-pack-index write --bitmap &&
>> +ls -l .git/objects/pack/ &&
>>                 test_commit loose &&
>>                 git multi-pack-index write --bitmap 2>err &&
>>                 test_path_is_file $midx &&
>> -- snap --
>>
>> This suggests to me that the `multi-pack-index write --bitmap 2>err` call
>> in this hunk might reuse a stale MIDX bitmap, and that _that_  might be
>> the root cause of this breakage.
> 
> Yeah, the `multi-pack-index write --bitmap 2>err` is creating the
> problem. More specifically the `multi-pack-index write` part. As you
> can see in my previous  comment (if you get the comment), I shared a
> screenshot there which pointed out that the multi-pack-index files in
> both cases are different. The portion from which it started to differ
> belongs to the `RIDX` chunk.
> 
> So, I used some debug lines in `midx_pack_order()` function[1] and
> found that the objects are sorted differently in those cases (i.e.
> passing case and failing case). For passing case, the RIDX chunk
> contents are like below -
> 
> pack_order = [ 1, 36, 11, 6, 18, 3, 19, 12, 5, 31, 27, 23, 29, 8, 38,
> 22, 9, 15, 14, 24, 37, 28, 7, 39, 10, 34, 26, 4, 30, 33, 2, 35, 17,
> 32, 0, 21, 16, 25, 13, 40, 20,]
> 
> And in the failing case, this is -
> 
> pack_order = [ 12, 18, 3, 19, 1, 36, 11, 6, 5, 31, 27, 23, 29, 8, 38,
> 22, 9, 15, 14, 24, 37, 28, 7, 39, 10, 34, 26, 4, 30, 33, 2, 35, 17,
> 32, 0, 21, 16, 25, 13, 40, 20,]
> 
> I went further and realized that this is due to the line[2] -
> 
>     if (!e->preferred)
>         data[i].pack |= (1U << 31);
> 
> I.e. 4- 5 `pack_midx_entry` objects have different `preferred` values
> in those cases. For example,
> "46193a971f5045cb3ca6022957541f9ccddfbfe78591d8506e2d952f8113059b"
> (with pack order 12) is `preferred` in failing case (that's why it is
> in the first position) and the same is `not preferred` in the passing
> case.
> 
> It may be because of reusing a stale midx bitmap (as you said). But I
> am not sure. Just to ensure myself, I compared all the other
> packfiles, idx files and a pack `.bitmap` file (which you can see
> using ls command) of failing and passing cases and found that they are
> the same.

You are right that this choice of a 'preferred' pack is part of the
root cause for this flake. This choice is not deterministic if the
mtime of some pack-files are within the same second.

I can make the flake go away with this change:

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index a95537e759b0..30347285f10f 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -438,7 +438,9 @@ midx_bitmap_partial_tests () {
 
 	test_expect_success 'setup partial bitmaps' '
 		test_commit packed &&
+		test_tick &&
 		git repack &&
+		test_tick &&
 		test_commit loose &&
 		git multi-pack-index write --bitmap 2>err &&
 		test_path_is_file $midx &&


However, that doesn't help us actually find out what the problem is
in our case.

I've tried exploring other considerations, resulting in this diff:

diff --git a/midx.c b/midx.c
index 9c26d04bfded..3b9094d55ae5 100644
--- a/midx.c
+++ b/midx.c
@@ -921,8 +921,9 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
 		struct object_entry *to = packlist_alloc(pdata, &from->oid);
 
+		/* Why does removing the permutation here not change the outcome? */
 		oe_set_in_pack(pdata, to,
-			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
+			       ctx->info[from->pack_int_id].p);
 	}
 }
 
This method is setting up some important information, supposedly, and
in the failing case I see that the ctx->pack_perm performs a 5-cycle
( 0->1, 1->2, 2->3, 3->4, 4->0 ) but this removal does not affect _any
existing test cases_!

Turns out that the packfile sent here goes through this very trivial
path in oe_set_in_pack() every time we are writing a multi-pack-index:

static inline void oe_set_in_pack(struct packing_data *pack,
				  struct object_entry *e,
				  struct packed_git *p)
{
	if (pack->in_pack_by_idx) {
		if (p->index) {
			e->in_pack_idx = p->index;
			return;
		}
		/*
		 * We're accessing packs by index, but this pack doesn't have
		 * an index (e.g., because it was added since we created the
		 * in_pack_by_idx array). Bail to oe_map_new_pack(), which
		 * will convert us to using the full in_pack array, and then
		 * fall through to our in_pack handling.
		 */
		oe_map_new_pack(pack);
	}
	pack->in_pack[e - pack->objects] = p;
}

By debugging, I discovered we are hitting the case that calls
oe_map_new_pack(pack). The documentation for that method provides
the following (**emphasis mine**):

/*
 * A new pack appears after prepare_in_pack_by_idx() has been
 * run. **This is likely a race.**
 *
 * We could map this new pack to in_pack_by_idx[] array, but then we
 * have to deal with full array anyway. And since it's hard to test
 * this fall back code, just stay simple and fall back to using
 * in_pack[] array.
 */
void oe_map_new_pack(struct packing_data *pack)

The issue being that prepare_packing_data() uses get_all_packs() to
get the list of pack-files, but that list is stale for some reason.
Adding a reprepare_packed_git() in advance of that call also removes
the flake (with always passing):

diff --git a/midx.c b/midx.c
index 9c26d04bfded..48db91d2728a 100644
--- a/midx.c
+++ b/midx.c
@@ -915,6 +915,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	uint32_t i;
 
 	memset(pdata, 0, sizeof(struct packing_data));
+	reprepare_packed_git(the_repository);
 	prepare_packing_data(the_repository, pdata);
 
 	for (i = 0; i < ctx->entries_nr; i++) {

But this still appears like it is just a band-aid over a trickier
underlying issue.

Hopefully my rambling helps push you in a helpful direction to find
a more complete fix.

Thanks,
-Stolee
