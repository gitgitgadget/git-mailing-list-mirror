Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC6C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 19:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhKVTDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbhKVTDY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 14:03:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BFC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 11:00:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b12so34534159wrh.4
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6a9iLyZyMoV9v6d6cTA1hm6JE6GiyRRDiId1XtG8Tys=;
        b=K7Zf7tLxU8cy1hZkTvKGjt5smIkIgEi9bDZJwhIcCRwYEWYHJvHkgnuPzWTHVpBjUH
         ngbuEZRiFKy+1UhIVxxo9XpNYhMne5b+odflfp6kXjUrQjqpcIbwF6vj/fEilDXwbry+
         qKZrHlvdR7mBVncQiSPyrso9AUXzbVB/4XKztfxJURcSKrYtmnbsyiB3/jpHrKNjAzFy
         1yOozkDPljBuNpRHu+H9r8TZsChLVpGoe3Ok+dhe9eIpV8aKdxtT+bFvuHnwbWBtQqlS
         ttcq8zC7D0PthLnQd7m3MwjO92znIAEszYMBqfeovnYiqCi+ho5222qlbWHbebqK1c2j
         Am8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6a9iLyZyMoV9v6d6cTA1hm6JE6GiyRRDiId1XtG8Tys=;
        b=42c0SGWv6y/S0k5/0hq4boC4OKWtiaIsopJgNCqnYQEPCik4NQ9q5bOqBOGAwC1LTD
         lunYnrkqePVB3G4JT1NRaGa3GQsbsa9OLhpPFPTSfQtJtp4/B4u5AChvKBtj3i6Y+KVy
         ipKhZ7xB1enGcOlPk7OzEvN82VC/OrRIF/MHE84vpQgQo6dSqZ+bnIdbtUImi9A0+f+p
         naNb7xG5XD6vyr8XFbxoDzv33V1hsm50sz/bbPvRryJAjInOOIORGxQlkTCrpKZXOCSr
         tRLS8zVcuI64u+Jbj66kfnidb8HNAp9I1bf6gSHp4F1jpARftRGaD5trU9wAFgMQmt2U
         n1FQ==
X-Gm-Message-State: AOAM533NMhLjFJQmzsTwD/KmCHnfeZGe+ZHowZ+x/2Joisi3ugRifuWh
        m/A1NvWMPtldKMky3d+M/WI=
X-Google-Smtp-Source: ABdhPJyMMA1K3iL0mbK8wL9veSfXc7zM1WITzICZlee9P3KdURvSEQHlBPhUQE9ygIeKVVr3OZultQ==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr41902313wrq.71.1637607609263;
        Mon, 22 Nov 2021 11:00:09 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id v7sm9406078wrq.25.2021.11.22.11.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 11:00:08 -0800 (PST)
Message-ID: <a6ff589e-c968-8a96-a8ec-1a982d71f6be@gmail.com>
Date:   Mon, 22 Nov 2021 19:00:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 06/15] diff --color-moved: avoid false short line
 matches and bad zerba coloring
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
 <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
 <10b11526206d3b515ba08ac80ccf09ecb7a03420.1637056178.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2111221435140.63@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2111221435140.63@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

Thanks ever so much for taking a detailed look at this series.

On 22/11/2021 14:18, Johannes Schindelin wrote:
> Hi Phillip,
> 
> The commit's oneline has a typo: zerba instead of zebra.

Sigh, I thought I'd fixed that

> On Tue, 16 Nov 2021, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When marking moved lines it is possible for a block of potential
>> matched lines to extend past a change in sign when there is a sequence
>> of added lines whose text matches the text of a sequence of deleted
>> and added lines. Most of the time either `match` will be NULL or
>> `pmb_advance_or_null()` will fail when the loop encounters a change of
>> sign but there are corner cases where `match` is non-NULL and
>> `pmb_advance_or_null()` successfully advances the moved block despite
>> the change in sign.
>>
>> One consequence of this is highlighting a short line as moved when it
>> should not be. For example
>>
>> -moved line  # Correctly highlighted as moved
>> +short line  # Wrongly highlighted as moved
>>   context
>> +moved line  # Correctly highlighted as moved
>> +short line
>>   context
>> -short line
>>
>> The other consequence is coloring a moved addition following a moved
>> deletion in the wrong color. In the example below the first "+moved
>> line 3" should be highlighted as newMoved not newMovedAlternate.
>>
>> -moved line 1 # Correctly highlighted as oldMoved
>> -moved line 2 # Correctly highlighted as oldMovedAlternate
>> +moved line 3 # Wrongly highlighted as newMovedAlternate
>>   context      # Everything else is highlighted correctly
>> +moved line 2
>> +moved line 3
>>   context
>> +moved line 1
>> -moved line 3
>>
>> These false matches are more likely when using --color-moved-ws with
>> the exception of --color-moved-ws=allow-indentation-change which ties
>> the sign of the current whitespace delta to the sign of the line to
>> avoid this problem. The fix is to check that the sign of the new line
>> being matched is the same as the sign of the line that started the
>> block of potential matches.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   diff.c                     | 17 ++++++----
>>   t/t4015-diff-whitespace.sh | 65 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 76 insertions(+), 6 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 53f0df75329..efba2789354 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1176,7 +1176,7 @@ static void mark_color_as_moved(struct diff_options *o,
>>   	struct moved_block *pmb = NULL; /* potentially moved blocks */
>>   	int pmb_nr = 0, pmb_alloc = 0;
>>   	int n, flipped_block = 0, block_length = 0;
>> -	enum diff_symbol last_symbol = 0;
>> +	enum diff_symbol moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
> 
> The exact value does not matter, as long as it is different from whatever
> the next line will have, of course.
> 
>>
>>
>>   	for (n = 0; n < o->emitted_symbols->nr; n++) {
>> @@ -1202,7 +1202,7 @@ static void mark_color_as_moved(struct diff_options *o,
>>   			flipped_block = 0;
>>   		}
>>
>> -		if (!match) {
>> +		if (pmb_nr && (!match || l->s != moved_symbol)) {
>>   			int i;
>>
>>   			if (!adjust_last_block(o, n, block_length) &&
>> @@ -1219,12 +1219,13 @@ static void mark_color_as_moved(struct diff_options *o,
>>   			pmb_nr = 0;
>>   			block_length = 0;
>>   			flipped_block = 0;
>> -			last_symbol = l->s;
>> +		}
> 
> This is one of those instances where I dislike having the patch in a
> static mail. I so want to have a _convenient_ way to expand the diff
> context, to have a look around.
> 
> So I went over to
> https://github.com/gitgitgadget/git/pull/981/commits/10b11526206d3b515ba08ac80ccf09ecb7a03420
> to get the convenience I need for a pleasant reviewing experience.
> 
> In this instance, the `continue` that dropped out of that conditional
> block gave me pause.
> 
> My understanding is that the diff makes it essentially a lot harder to
> understand what is done here: this conditional block did two things, it
> re-set the possibly-moved-block, and it skipped to the next loop
> iteration. With this patch, we now re-set the possibly-moved-block in more
> cases, but still skip to the next loop iteration under the same condition
> as before:
> 
>> +		if (!match) {
>> +			moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
>>   			continue;
>>   		}
> 
> However, after reading the commit message, I would have expected the
> condition above to read `if (!match || l->s != moved_symbol)` instead of
> `if (!match)`. Could you help me understand what I am missing?

If there is a match we want to carry on executing the body of the loop 
to start a new block of moved lines. moved_symbol will be updated at the 
end of the loop.

>>
>>   		if (o->color_moved == COLOR_MOVED_PLAIN) {
>> -			last_symbol = l->s;
>>   			l->flags |= DIFF_SYMBOL_MOVED_LINE;
>>   			continue;
>>   		}
> 
> I want to make sure that I understand why the `last_symbol` assignment
> could be removed without any `moved_symbol` assignment in its place. But I
> don't, I still do not see why we do not need a `moved_symbol = l->s;`
> assignment here.

I had to think about it but I think the answer is that COLOR_MOVED_PLAIN 
does not care about moved_symbol - it is only used by the zebra coloring 
modes.

> Unless, that is, we extended the `!match` condition above to also cover
> the case where `l->s != moved_symbol`.
> 
>> @@ -1251,11 +1252,16 @@ static void mark_color_as_moved(struct diff_options *o,
>>   							    &pmb, &pmb_alloc,
>>   							    &pmb_nr);
>>
>> -			if (contiguous && pmb_nr && last_symbol == l->s)
>> +			if (contiguous && pmb_nr && moved_symbol == l->s)
>>   				flipped_block = (flipped_block + 1) % 2;
> 
> This is totally not your fault, but I really wish we could have the much
> simpler and much easier to understand `flipped_block = !flipped_block`
> here.

It's partially my fault - I should have simplified it when I moved that 
line in b0a2ba4776 ("diff --color-moved=zebra: be stricter with color 
alternation", 2018-11-23)

>>   			else
>>   				flipped_block = 0;
>>
>> +			if (pmb_nr)
>> +				moved_symbol = l->s;
>> +			else
>> +				moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
>> +

This is where we update moved_symbol when it did not match l->s above.

    			block_length = 0;
>>   		}
>>
>> @@ -1265,7 +1271,6 @@ static void mark_color_as_moved(struct diff_options *o,
>>   			if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
>>   				l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
>>   		}
>> -		last_symbol = l->s;
> 
> That makes sense: we only set `moved_symbol` when `pmb_nr` had been 0 now,
> and don't want it to be overridden.
 >
> As I said, I do not quite understand this patch yet, and am looking for
> your guidance to wrap my head around it.
> 
> Thank you for working on this!

Thanks for looking at it, I hope these comments help, let me know if 
I've failed to explain well enough.

Best Wishes

Phillip

> Dscho
> 
>>   	}
>>   	adjust_last_block(o, n, block_length);
>>
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 4e0fd76c6c5..15782c879d2 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -1514,6 +1514,71 @@ test_expect_success 'zebra alternate color is only used when necessary' '
>>   	test_cmp expected actual
>>   '
>>
>> +test_expect_success 'short lines of opposite sign do not get marked as moved' '
>> +	cat >old.txt <<-\EOF &&
>> +	this line should be marked as moved
>> +	unchanged
>> +	unchanged
>> +	unchanged
>> +	unchanged
>> +	too short
>> +	this line should be marked as oldMoved newMoved
>> +	this line should be marked as oldMovedAlternate newMoved
>> +	unchanged 1
>> +	unchanged 2
>> +	unchanged 3
>> +	unchanged 4
>> +	this line should be marked as oldMoved newMoved/newMovedAlternate
>> +	EOF
>> +	cat >new.txt <<-\EOF &&
>> +	too short
>> +	unchanged
>> +	unchanged
>> +	this line should be marked as moved
>> +	too short
>> +	unchanged
>> +	unchanged
>> +	this line should be marked as oldMoved newMoved/newMovedAlternate
>> +	unchanged 1
>> +	unchanged 2
>> +	this line should be marked as oldMovedAlternate newMoved
>> +	this line should be marked as oldMoved newMoved/newMovedAlternate
>> +	unchanged 3
>> +	this line should be marked as oldMoved newMoved
>> +	unchanged 4
>> +	EOF
>> +	test_expect_code 1 git diff --no-index --color --color-moved=zebra \
>> +		old.txt new.txt >output && cat output &&
>> +	grep -v index output | test_decode_color >actual &&
>> +	cat >expect <<-\EOF &&
>> +	<BOLD>diff --git a/old.txt b/new.txt<RESET>
>> +	<BOLD>--- a/old.txt<RESET>
>> +	<BOLD>+++ b/new.txt<RESET>
>> +	<CYAN>@@ -1,13 +1,15 @@<RESET>
>> +	<BOLD;MAGENTA>-this line should be marked as moved<RESET>
>> +	<GREEN>+<RESET><GREEN>too short<RESET>
>> +	 unchanged<RESET>
>> +	 unchanged<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as moved<RESET>
>> +	<GREEN>+<RESET><GREEN>too short<RESET>
>> +	 unchanged<RESET>
>> +	 unchanged<RESET>
>> +	<RED>-too short<RESET>
>> +	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved<RESET>
>> +	<BOLD;BLUE>-this line should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
>> +	 unchanged 1<RESET>
>> +	 unchanged 2<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
>> +	 unchanged 3<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved newMoved<RESET>
>> +	 unchanged 4<RESET>
>> +	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>>   test_expect_success 'cmd option assumes configured colored-moved' '
>>   	test_config color.diff.oldMoved "magenta" &&
>>   	test_config color.diff.newMoved "cyan" &&
>> --
>> gitgitgadget
>>
>>

