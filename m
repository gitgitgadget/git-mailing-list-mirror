Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE6C433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 12:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A68A64FDE
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 12:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhBEMXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 07:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhBEMUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 07:20:42 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33197C0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 04:19:55 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id y11so6701623otq.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 04:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hgAgI8RbdO39HOhps2Tj4F5P/sJ+iDb3dcaoreoeFxs=;
        b=GxWdEXBcW+futE4kdUVcvIHzq8d1Wo7CQeyRc65LydzNXyKrd9C3q6I3qWCclLgWbv
         xzMeoVCPkILSs0/nrgbTUPbLrnSj7Vo8fvuKUyG7SqRplrTU7ApeCpBIsuRWMzNtH2/a
         vSJzNAi9amL76v+RLsDotDUGmRcjQmJCzMhQjXENuAyvs+z/KlukJxbbVSqSKL3+9xH2
         dgj3MAepQwS4CGDCdT/+L8+klkggb7jNspwuu3JB94Q7bmEryspbBNwFkZuezT6Qwkzx
         T/Oa/d4Vqily5GYXeqg5RHho/bV9zPc8yieAQSc/wJldk0Aco/T8QMwQCHVAmDd1wlTA
         YczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hgAgI8RbdO39HOhps2Tj4F5P/sJ+iDb3dcaoreoeFxs=;
        b=VnJZNTB8t/9/eaefd5tF7n0f5CQa/FnFr8rX2q9wGy9cohsG9nG9MgOlAOz4pJlTt5
         cNh57sB7WqM2MYRRuF7Iai0ThSjtwd7WgJIve3Q+Yg8xTJAnq6WaFB9FG/0vAhpndjTC
         a2dysODFQMxnyojLoI2ucDZNE4Z+AEeT1yLHxmcIABuhJv7kDVgFJWgbzbkFT8REamj0
         fj209dMfhQUWtLJntDGz2B0B24TyL1S1wWNmEm6NHj/opCdZIzDH7Tv/AebR6VnNeC/1
         9hP0A8S8UtPePwlcUsNOXZzChvet8nCL9e+DlJKC4HmUTTQDoMnRCrX1Hr7jTSXsgDOH
         KrHA==
X-Gm-Message-State: AOAM533iyc+yBVVWPiMJ7FjCQAJm+6O52t+E9zryJS6qlsePl1LKLtGM
        +DLLGfKl5tfwpD5xe77AExo=
X-Google-Smtp-Source: ABdhPJwHGR8vL4K2Q8CnYr53NzNGnkfgMY5tCtKgi/moX+0CLf8TJ3AYC7lrW/s/iqVfpXhFjIC0mQ==
X-Received: by 2002:a9d:5a05:: with SMTP id v5mr3222948oth.17.1612527594428;
        Fri, 05 Feb 2021 04:19:54 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4dc9:c09:30f7:a417? ([2600:1700:e72:80a0:4dc9:c09:30f7:a417])
        by smtp.gmail.com with UTF8SMTPSA id a71sm1740987oob.48.2021.02.05.04.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 04:19:53 -0800 (PST)
Message-ID: <1278de82-417c-a6ee-a5fe-055fa0ef1903@gmail.com>
Date:   Fri, 5 Feb 2021 07:19:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 12/17] chunk-format: create read chunk API
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
 <xmqqczxf4d2k.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqczxf4d2k.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2021 6:40 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> We are re-using the anonymous 'struct chunkfile' data, as it is internal
>> to the chunk-format API. This gives it essentially two modes: write and
>> read. If the same struct instance was used for both reads and writes,
>> then there would be failures.
> 
> Writing it here won't help future developers very much.  I think
> that belongs to API/function doc for init_chunkfile().

I will add a clear comment there. Thanks.

>> +int read_table_of_contents(struct chunkfile *cf,
>> +			   const unsigned char *mfile,
>> +			   size_t mfile_size,
>> +			   uint64_t toc_offset,
>> +			   int toc_length)
> 
> It's a bit of mystery, having seen how the table-of-contents is laid
> out by reading the writing side of the code, how toc_offset and
> toc_length are discovered by the caller.  IIRC, the size to cover
> everything from the beginning of the file to the end of the
> table-of-contents was recorded as the length of a non-existent chunk
> with id 0, but we need to be able to somehow find it to use that as
> a way to get to the (end of) table-of-contents from the beginning of
> the file.   I guess we'll learn enough when we get to read the code
> that calls this function.

The existing formats have a byte in their header specifying how
many chunks are in the table of contents. That's how this information
is known in advance.

If we want to instead rely on the terminating chunk id with value 0,
then this method could be modified in the future. It does complicate
the allocation of cf->chunks slightly.

>> +	chunk_id = get_be32(table_of_contents);
>> +	if (chunk_id) {
>> +		error(_("final chunk has non-zero id %"PRIx32""), chunk_id);
>> +		return -1;
>> +	}
> 
> Shouldn't we be validating the size component associated with this
> "id=0" fake chunk that appears at the end as well?  IIRC, the size
> field should be pointing at the byte immediately after the TOC entry
> for the last true chunk, immediately before this zero chunk id?

During the loop, we scanned ahead to find the offset of the
terminating chunk and compute the size of the last "real" chunk.

Any size validation here would be to check that the offset points
_exactly_ to the terminating hash, but that might be too restrictive
on the format. (Who knows if there is a legit reason to have non-
chunked data between the chunked data and the trailing hash?)

As I re-roll, I plan to skip this final check. It would be easy to
add it in a forward fix, thought.

>> +int pair_chunk(struct chunkfile *cf,
>> +	       uint32_t chunk_id,
>> +	       const unsigned char **p)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < cf->chunks_nr; i++) {
>> +		if (cf->chunks[i].id == chunk_id) {
>> +			*p = cf->chunks[i].start;
>> +			return 0;
>> +		}
> 
> OK, the assumption here is that there will be at most one chunk that
> has the chunk_id we seek to find (or putting it differently, second
> and subsequent chunks with the same ID are ignored).  We may want to
> write it down somewhere.

This is enforced by a later patch, as you discovered.

>> +	for (i = 0; i < cf->chunks_nr; i++) {
>> +		if (cf->chunks[i].id == chunk_id)
>> +			return fn(cf->chunks[i].start, cf->chunks[i].size, data);
> 
> It is curious why pair_chunk() exists in the first place.  With
> something like this:
> 
>         int pair_chunk_fn(const unsigned char *chunk_start,
>                           size_t chunk_size,
>                           void *data)
>         {
>                 const unsigned char **p = data;
>                 *p = chunk_start;
>                 return 0;
>         }
> 
> instead of
> 
> 	const unsigned char *location;
> 
> 	pair_chunk(cf, chunk_id, &location);
> 
> we can write
> 
> 	const unsigned char *location;
> 
> 	read_chunk(cf, chunk_id, pair_chunk_fn, &location);
> 
> no?  That would allow us to reorganize the in-core TOC more easily
> if it turns out to be necessary in the future.

I like this, but why not just use pair_chunk_fn inside of
the implementation of pair_chunk() so callers have an easy
interface. This results in the implementation:

static int pair_chunk_fn(const unsigned char *chunk_start,
			 size_t chunk_size,
			 void *data)
{
	const unsigned char **p = data;
	*p = chunk_start;
	return 0;
}

int pair_chunk(struct chunkfile *cf,
	       uint32_t chunk_id,
	       const unsigned char **p)
{
	return read_chunk(cf, chunk_id, pair_chunk_fn, p);
}

>> +typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
>> +			     size_t chunk_size, void *data);
> 
> Is the assumption throughout the chunked file API that reading is
> actually not done as a "seek+read+process", but as a normal memory
> access over mmapped region?  The reason I ask is because the answer
> affects the choice of the right type for the offset.  The function
> signature of read_table_of_contents() uses size_t to represent the
> length of the entire mmapped region that holds the data from the
> file, and that is better than off_t, especially if size_t were
> smaller than off_t (i.e. we may not be able to mmap a huge size that
> filesystem can handle and let us access with seek+read).
> 
> But the assumption that the whole mfile can be mmapped in as a whole
> is only in read_table_of_contents(), and users of read_chunk() API
> can be oblivious, I think---IOW, we could "page in" the chunk's data
> in read_chunk() while the callback function works on it in-core, and
> then discard it, if we wanted to change the implementation [*].
> 
> 	Side note: for that to work, the API must say that the
> 	callback function MUST NOT assume that the memory region
> 	starting at chunk_start it is given will stay in memory
> 	after it returns.  Otherwise, we cannot "page in" and "page
> 	out".
> 
> I am not advocating that we should not assume the entire file can be
> mapped in.  I would however advocate to be explicit in documenting
> what the users of API can and cannot do (e.g. if we want the "read"
> callbacks to take advantage of the fact that mfile will stay mapped
> until the chunkfile is discarded, we should say so, so that they will
> not make unnecessary copies out of the mmapped region).

I will add this expectation to the documentation.

>> +/*
>> + * Find 'chunk_id' in the given chunkfile and call the
>> + * given chunk_read_fn method with the information for
>> + * that chunk.
>> + *
>> + * Returns CHUNK_NOT_FOUND if the chunk does not exist.
>> + */
>> +int read_chunk(struct chunkfile *cf,
>> +	       uint32_t chunk_id,
>> +	       chunk_read_fn fn,
>> +	       void *data);
> 
> Did I miss an update to free_chunkfile() to release resources used
> to read this file?  For some reason, unlike the writing side, the
> reading side of this API feels a bit incomplete to me.

free_chunkfile(cf) already frees cf->chunks (and cf itself). No
other resources are allocated during the read. The caller is
responsible for the mmap'd file resource.

The reading side could use more documentation. I will think about
this.

Thanks,
-Stolee
