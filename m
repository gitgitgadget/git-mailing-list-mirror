Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61372203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbdGXXAx (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 19:00:53 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:37937 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdGXXAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 19:00:51 -0400
Received: by mail-ua0-f169.google.com with SMTP id w45so90258856uac.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d4VZO2qEowW+bVuHXPZ0f+pCJu48b6lyqXGS4/GtHtw=;
        b=OSPp4Ew/1fl+xl2VlCGOR1EU+9mEnoz6moS4MI5xaXn10p3mehqPucYm3yKtKGXDlL
         q4rnG3yO18BHBCJ0OlYTgLuFYEF5K9lISLee89JsvhcsqKqsisJJygOu0VNbtB7XSTVt
         bxS/zx+qTxlx/XF8CRrV2OzWLU+mInMizjIMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d4VZO2qEowW+bVuHXPZ0f+pCJu48b6lyqXGS4/GtHtw=;
        b=cfotu7Yo7dTJtHRttuqvIHjp+gDPRbmjxmo+I7VPsxzNlz7kbc/AK6kYVk8Tw0/hLJ
         QjouZ0zrId/ztUyG25J14QFz5MiJ3IYhVqwkdwKnoAcDTqkEoFWGHrmFn6VFgT2QwaD6
         rbuj4gp9S5iEckSu0FTyrTS+gxY6arUi8HsFnEdk+PPW1lcpLpZe1c+Pbzl7I2VuzNIE
         gFe1Ta0bJoe22QbCBuUCUScURsrmFrmwJOcHvG2P5i6pfFudTrg0zzKKUyfUbSKrTP9S
         KUPeM5LI08u52ZEktDfXrQXXm9pdf6uRSuwnTtO3TJVV1sIBmPPOpNw2zrKS7izjX07Z
         aDlQ==
X-Gm-Message-State: AIVw113tesVDMVlhmSDgVYd2JR3+gFYQRMhmNusTvxPANHWiqJb9Wpvv
        bccnPzmppZVRli6PtUx57plHAGCF0K4P
X-Received: by 10.31.3.99 with SMTP id 96mr10083778vkd.185.1500937249662; Mon,
 24 Jul 2017 16:00:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Mon, 24 Jul 2017 16:00:29 -0700 (PDT)
In-Reply-To: <CAGZ79kZ48zTsHxrW-fvHRFQih=vBuywExSxA8a_=wzjdJPbtrg@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
 <CAGZ79kZ48zTsHxrW-fvHRFQih=vBuywExSxA8a_=wzjdJPbtrg@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Mon, 24 Jul 2017 16:00:29 -0700
Message-ID: <CAJo=hJuCXFem8saH9kgBu1ROV3uuhRxHcHXz_Bp7xB+taW5S=Q@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 3:22 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Jul 22, 2017 at 11:29 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> 3rd iteration of the reftable storage format.
>>
>> You can read a rendered version of this here:
>> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>>
>> Significant changes from v2:
>> - efficient lookup by SHA-1 for allow-tip-sha1-in-want.
>
> I'll focus on that in the review, it sounds exciting.


>> ### Ref block format
> ...
>
>> A variable number of 4-byte `restart_offset` values follow the
>> records.  Offsets are relative to the start of the block and refer to
>> the first byte of any `ref_record` whose name has not been prefix
>> compressed.  Readers can start linear scans from any of these records.
>> Offsets in the first block are relative to the start of the file
>> (position 0), and include the file header.  This requires the first
>> restart in the first block to be at offset 8.
>>
>> The 2-byte `restart_count_m1` stores *one less* than the number of
>> entries in the `restart_offset` list.  There is always a restart
>> corresponding to the first ref record. Readers are responsible for
>> computing `restart_count = restart_count_m1 + 1`.
>
> I had to reread these two paragraphs a couple of times as it calls out
> the uninteresting things[1] and the interesting part is the logical
> conclusion that one has to make themselves,
> here is how I would write it:
>
>     Readers can start linear scans from any record whose name has
>     not been prefix compressed. The first record of a block must not
>     be prefix-compressed.
>
>     To aid finding the entry points for linear scans, a variable number
>     of 4-byte `restart_offset` values follow the records. Offsets are
>     relative to the start of the block and refer to the first byte of any
>     such `ref_record` that is not prefix compressed.
>     The first record can be omitted in the `restart_offset` values as it
>     is implicit.

No, the first record must be listed in the restart_offset table. Its
not implicit. The count of it is implicit, to allow up to 65536
restart_offset entries using only a uint16 restart_count. Maybe that
is being too cute, and the count should just be the entry count.

>     The `restart_offset' values must be sorted (ascending,
>     descending?).

Sorted, ascending.


>> The `value` follows.  Its format is determined by `value_type`, one of
>> the following:
>>
>> - `0x0`: deletion; no value data (see transactions, below)
>> - `0x1`: one 20-byte object id; value of the ref
>> - `0x2`: two 20-byte object ids; value of the ref, peeled target
>
> Up to here it is easy to spot a pattern:
> The number indicates how many oids follow.
>
>> - `0x3`: symbolic reference: `varint( target_len ) target`
>> - `0x4`: length delimited extension: `varint( data_len ) data`
>
> This breaks the pattern.
>
> Instead of hardcoding the numbers here, I wonder if we rather
> want to make the bits more meaningful:
>
>   bit 0, 1: number of oids iff bit 2 unset
>
>   Iff bit 2 set, then we have a "varint (len) data"
>   that follows, bits 0,1 are used for a different purpose,
>   00 indicates 'symlink' and data is the string
>   01 indicates 'multihead' such as FETCH_HEAD
>   1* is reserved for now.
>
> This *may* be neat micro optimization, but hardcoding all bits
> to a lookup table is fine, too.

The problem I have with this bit-based rule is it breaks down later as
you use additional codes, or you find yourself limited by the bit
scheme and don't have the full range of 8 values available. So I
decided to be very literal about what the codes mean, and use a lookup
table.


>   Note that symrefs and multiheads could share the same
>   type, iff we had dissallowed '\n' in refnames. (we do?
>   otherwise FETCH_HEAD would be broken)
>   The differentiator would be the '\n' or '\0' at the end of the
>   first target.

True, \n is not allowed in a ref name, and neither is \0.

Symrefs in loose ref format use "ref: <target>\n" as their content. We
could use that format in reftable, and then HEAD and FETCH_HEAD could
use the same value code, 0x3.


>> #### index record
>>
>> An index record describes the last entry in another block.
>> Index records are written as:
>>
>>     varint( prefix_length )
>>     varint( (suffix_length << 3) | 0 )
>>     suffix
>>     varint( block_offset )
>>
>> Index records use prefix compression exactly like `ref_record`.
>>
>> Index records store `block_offset` after the suffix, specifying the
>> offset in bytes (from the start of the file) of the block that ends
>> with this reference.
>
> Instead of hardcoding the "0" in the last 3 bits, maybe pick one
> of the reserved bit patterns to be there? I would imagine this
> makes debugging easier:
>
>     0x5? Hah that must be an index block I have been
>     looking at the wrong block!

This is an excellent suggestion. I'll include it in the next iteration.


>> ### Obj block format
>>
>> Object blocks use unique, abbreviated 2-20 byte SHA-1s keys, mapping
>> to ref blocks containing references pointing to that object directly,
...
>> Each record contains `block_count` number of block identifiers for ref
>> blocks.  The `block_count` is determined by:
>>
>>     block_count = cnt_3
>>     if (cnt_3 == 0x7) {
>>       block_count += cnt_rest
>>     }
>
> Instead of having the first seven blocks treated special (omission of
> cnt_rest), we could also pick one of the reserved bit patterns here to
> aid debuggers, as a downside we'd require cnt_rest to be present at
> all times.

Always including cnt_rest adds a byte per object, which I'm not in favor of.

> Additionally we could give an offset to a restart block to start searching
> from inside a ref block.
>
> Coupled with the idea from above of having a reserved bit pattern, an
> alternative design could look like:
>
>     varint( prefix_length )
>     varint( (suffix_length << 3) | special_bit_pattern )
>     suffix
>     varint( cnt_rest )
>     (varint( block_delta ), varint( restart_offset ))+

This adds a lot of complexity for a writer to maintain the
bookkeeping, increases the size per object by at least 1 byte, and
doesn't improve the performance very much on lookups.


>> #### log record
>>
>> Log record keys are structured as:
>>
>>     ref_name '\0' reverse_int64( time_usec )
>
> repeating from v2:
>
>   The size of the integer
>   is determined by the suffix length encoding and the preceding '\0',
>   such that the file format allows arbitrary integer size. So instead of
>   pretending we can only do 64 bit here, just say 'reverse_int' ?

I was trying to simplify things for readers and writers by forcing the
size to be fixed width.

>> ### Log index
>>
>> The log index stores the log key (`refname \0 reverse_int32(time_sec)`)
>
> int64 now?
>
>
>> Log index format is identical to ref index, except the keys are 5
>> bytes longer to include `'\0'` and the 4-byte `reverse_int32(time)`.
>> Records use `block_offset` to refer to the start of a log block.
>
> also 64? /me is confused.

Yes, two mistakes. I'll fix them s/32/64/, thank you.


>> ### Footer
...
> By the design of the footer, refs must come first.
> Whether objects or logs come thereafter can both be encoded here,
> however the initial design claims an order.

Even though the footer seems to allow changing the order of objects
vs. logs, the format is clear the objects (if present) come before
logs (if present).
