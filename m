Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA3C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AFF64E56
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 11:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBELks (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 06:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhBELij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 06:38:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F8C0617A9
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 03:37:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d85so6494959qkg.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6ifg1pUoCFOr0jCBp8szlWTas7R98xL/VDk2swmrKN8=;
        b=jo2+2kDoTZqUZTljBfOMUWTETJZgO6os/nfHVKn0pOYZ+7XO1rXs36eT8wYFREw7ry
         xYbzrOmXmj3i6YaOH6Ptl3SU7BZ+S1QyylRncngomxK14pLJqbcHPGzu8pPMZFqpr0zV
         hgL8bJKjkOe6nu99QObGmo2wIweq4sIsUyRqZ7RKW2oOeG7G6MpQItQUwn/i+PPHMNy7
         DuYlqWIyrBpeLCOi5Il0IbS229LPv5QnAci7IgCuP7955O+UqfuCfvH+6qwVigjmu0/N
         Po2viefsGlTn199n2J2/dudQmnWOFZzl71a1f1c7dWi0BwHhNFFQcMSg3x5UcGKkF6Qg
         FakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ifg1pUoCFOr0jCBp8szlWTas7R98xL/VDk2swmrKN8=;
        b=cKgCc7g1ViEBgHMNNG7k/DgnYIZBeP+ZD6qeV1dYaMlAjDZ8CuEeQ4dDzyZCgZMz1K
         mxJ7TkDDssyeVGgaBsqixmVudxVn7uzPY+eZlhKvOiHfbZPu2pcM/cChZBbLh5RwRFCE
         SgBxcYF2Xz1M+IdAOrJKzl3Pl9J1x3Ouhsbd7RRjMH2IZMDHa8nZ2lwvdvXZmwGInY9r
         UPlddk5A3rxG7SOOl6a89DpGOHHuyEGhtPRB54WZSwn0EP2GmtawKjCWLS4Oq++Pcsfx
         6ILmKJcTHWnD9n6BbROP5vpCXQXa5l/NtRcJbgCc3prNOH1JW3IbsFIkaqYjPPTAOqVR
         9c0w==
X-Gm-Message-State: AOAM532CRzicxUIsHjiUzjffB1HBcZ1pw9rPnPgra+o8utAb6MtWyd6Y
        eCZrCuTfUvsA1aroD3hf7s4=
X-Google-Smtp-Source: ABdhPJybtlNJXr145zMYxjv2Bc3wytyMwQf3NpopcgOaTUEVHaSCbaJ7I5fEGEudBIryyprKuMXvzA==
X-Received: by 2002:a37:8e06:: with SMTP id q6mr3793300qkd.402.1612525071036;
        Fri, 05 Feb 2021 03:37:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4dc9:c09:30f7:a417? ([2600:1700:e72:80a0:4dc9:c09:30f7:a417])
        by smtp.gmail.com with UTF8SMTPSA id z5sm8718756qkc.61.2021.02.05.03.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:37:50 -0800 (PST)
Message-ID: <d5097b51-e096-16b3-5b7b-2c7dd1cbe918@gmail.com>
Date:   Fri, 5 Feb 2021 06:37:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 02/17] chunk-format: create chunk format write API
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <814512f216719d89f41822753d5c71df5e49385d.1611759716.git.gitgitgadget@gmail.com>
 <xmqq5z375xxf.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5z375xxf.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2021 4:24 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +/*
>> + * When writing a chunk-based file format, collect the chunks in
>> + * an array of chunk_info structs. The size stores the _expected_
>> + * amount of data that will be written by write_fn.
>> + */
>> +struct chunk_info {
>> +	uint32_t id;
>> +	uint64_t size;
>> +	chunk_write_fn write_fn;
>> +};
>> +...
>> +void add_chunk(struct chunkfile *cf,
>> +	       uint64_t id,
>> +	       chunk_write_fn fn,
>> +	       size_t size)
>> +{
>> +	ALLOC_GROW(cf->chunks, cf->chunks_nr + 1, cf->chunks_alloc);
>> +
>> +	cf->chunks[cf->chunks_nr].id = id;
>> +	cf->chunks[cf->chunks_nr].write_fn = fn;
>> +	cf->chunks[cf->chunks_nr].size = size;
>> +	cf->chunks_nr++;
>> +}
> 
> Somebody somewhere between the caller in the higher part of the
> callchain (that has to work with platform native types) and the
> on-disk format at the bottom of the callchain (that has to work
> with fixed size data fields) needs to make sure that the size that
> the higher level caller has fits on-disk data structure we define,
> and the data we read from disk fits the in-core structure our caller
> use on the reading side.
> 
> If there is a function at the one level closer to the disk than
> "struct chunk_info" that takes a "struct chunk_info" and writes the
> id and size to disk (and fills "struct chunk_info" from what is read
> from the disk, on the reading side), it would be a good place to do
> the size_t to uint64_t conversion.

I'm fine with keeping the external interface focused on size_t
instead of uint64_t.

> It is OK to do the conversion-while-checking in add_chunk(), too.
> 
> But a silent type casting from size_t to uint64_t done silently by
> assignment bothers me. 

Does this bother you only because its part of the external interface?
If I understand correctly, uint64_t will always be at least as big
as size_t, so this doesn't need any protections for overflow or
anything. Is there something I should be doing before casting?

> Also, I think you meant to make the incoming
> ID uint32_t; am I missing something, or did nobody notice it in the
> review of the previous round?

Yes, this should be 32-bits. Will fix.
 
>> +int write_chunkfile(struct chunkfile *cf, void *data)
>> +{
>> +	int i;
>> +	size_t cur_offset = cf->f->offset + cf->f->total;
> 
> That ought to be off_t, as it is a seek position inside a file
> (struct hashfile.total is already off_t).

I can use off_t for the other offsets in this computation, but
cur_offset will be used in hashwrite_be64(), so maybe it is best
to use uint64_t here?

> Use csum-file.h::hashfile_total() instead, perhaps?  .offset member
> is an implementation detail of the hashfile API (i.e. some leftover
> bits are kept in in-core buffer, until we accumulate enough to make
> it worth flushing to the disk), and by using the helper, this code
> does not have to know about it.

Thanks! This is cleaner.

>> +	/* Add the table of contents to the current offset */
>> +	cur_offset += (cf->chunks_nr + 1) * CHUNK_LOOKUP_WIDTH;
> 
> Is that 12 == sizeof(chunk_info.id) + sizeof(chunk_info.size)?
> If so, this makes sense.

Yes.

>> +	for (i = 0; i < cf->chunks_nr; i++) {
>> +		hashwrite_be32(cf->f, cf->chunks[i].id);
>> +		hashwrite_be64(cf->f, cur_offset);
>> +
>> +		cur_offset += cf->chunks[i].size;
>> +	}
>> +
>> +	/* Trailing entry marks the end of the chunks */
>> +	hashwrite_be32(cf->f, 0);
>> +	hashwrite_be64(cf->f, cur_offset);
> 
> OK.  This helper does not tell us anything about what comes in the
> on-disk file before this point, but we write a table of contents
> that says "chunk with this ID has this size, chunk with that ID has
> that size, ...", concluded by something that looks like another
> entry with chunk ID 0 that records the current offset as its size.

Right. The table of contents gives us enough information to find
the start _and_ end of each chunk (and hence compute their size).

>> +	for (i = 0; i < cf->chunks_nr; i++) {
>> +		uint64_t start_offset = cf->f->total + cf->f->offset;
> 
> Likewise about the type and use of hashfile_total().

This one can definitely be off_t.

>> +		int result = cf->chunks[i].write_fn(cf->f, data);
>> +
>> +		if (result)
>> +			return result;
>> +
>> +		if (cf->f->total + cf->f->offset - start_offset != cf->chunks[i].size)
>> +			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
>> +			    cf->chunks[i].size, cf->chunks[i].id,
>> +			    cf->f->total + cf->f->offset - start_offset);
> 
> I won't complain, as this apparently is sufficient to abstract out
> the two existing chunked format files, but it somehow feels a bit
> limiting that the one that calls add_chunk() is required to know
> what the size of generated data would be, way before .write_fn() is
> called to produce the actual data here.

This was pointed out earlier, but it _is_ part of the existing users
of the format. The table of contents is written at the start of the
file instead of the end (such as in the .zip format).

The current chunk format API makes the same assumption (ToC comes
first) but could be adjusted later to let this part of the method
dynamically compute the chunk sizes and fill a ToC at the end. The
way to modify this API would be to add a 'flags' parameter.

So far, this has not been necessary, but might be in the future.

>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/chunk-format.h b/chunk-format.h
>> new file mode 100644
>> index 00000000000..bfaed672813
>> --- /dev/null
>> +++ b/chunk-format.h
>> @@ -0,0 +1,20 @@
>> +#ifndef CHUNK_FORMAT_H
>> +#define CHUNK_FORMAT_H
>> +
>> +#include "git-compat-util.h"
>> +
>> +struct hashfile;
>> +struct chunkfile;
>> +
>> +struct chunkfile *init_chunkfile(struct hashfile *f);
>> +void free_chunkfile(struct chunkfile *cf);
>> +int get_num_chunks(struct chunkfile *cf);
>> +typedef int (*chunk_write_fn)(struct hashfile *f,
>> +			      void *data);
> 
> Write this on a single line.

Will do.

Thanks,
-Stolee
