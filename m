Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC07C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2718A20838
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf4s0Zn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbgJLQ5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390355AbgJLQ5f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 12:57:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A8C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 09:57:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so1434478pgt.8
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GDkDrc5koqM1BxgJZ129ye54RTkAE0lhZyxr6hqfW6Q=;
        b=cf4s0Zn3pzc+qeHJFxUQ5bfvkq4CWhNOONK/oYJCy82n3CRhimKf3iKhVT31DgKgw/
         YJXr2o3vyjbuRyT5D/++L4pZ2ONNWhyAZp1hcWIXh3k2UXDMftvumlYqmzLytoqmNUok
         y3knsg2JIZcV9qAiGti7rpUIh2BdfHWlVpsxeTZ2MTDVB9Wb3mW+Luro5t44bqZQESka
         Q3Psf46WIAKNOBxLcnJy3pBmguxWCHayzVb0N5WevL5NcsvXfyCsGZ6yispxBQKzhXN+
         +esE29Vhu4uOGIXjZaWLOrNAdHVRjxQSi6Y2FddQSARHuDyjcs3sOxsOpl6lUvgAc+F0
         CtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GDkDrc5koqM1BxgJZ129ye54RTkAE0lhZyxr6hqfW6Q=;
        b=NRxvXR9VpblYu8JnlgSUWpIPxnE9l+evsXpTHQyz59uG1ZZlUmC/FlFzVgfIcHn2Ol
         KgVNixgNGAX4AZd7FzsgVo2hHNTg8XoU/tCMEA+VBVot7y/zlFWk1EPJfhRt37y3Q1ql
         cQE/+IG6eK1eZ9snLjjVdmOzfxxvqgjAMBpJZcgVcUJD4eElQruDFrhK2fXjEtnvbUjT
         npqtLJdfTG2S1ZfEKVVtVJ/Kq3ydx4MEIm8LbFg7aKLirDCaXuAf8xrNkmBFLxynD6Di
         MGaqGgaFh9BJjyB2MNdzhMQb8w90gcettigxTDZ9mWsVp600cyCFU2yuM9LId4CA+6P4
         uTZA==
X-Gm-Message-State: AOAM530QNi0JuslkqlLu14x3CdtZcbniT2kbR0QyJsYnTzXsC5oOGSgk
        GOaDq4JwCH0qa6BICWZV4cU=
X-Google-Smtp-Source: ABdhPJzJxYDQJs49Qb7VnhNAQwhOG+IkKxfwcSy/fEdGLCr7Ewl3nsZ3MYnPIySp5efLX9NVuj0tcw==
X-Received: by 2002:aa7:8f17:0:b029:152:349f:34df with SMTP id x23-20020aa78f170000b0290152349f34dfmr25041570pfr.54.1602521852923;
        Mon, 12 Oct 2020 09:57:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id h2sm23621207pjv.4.2020.10.12.09.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:57:32 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:57:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
Message-ID: <20201012165730.GC3740546@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
 <20201002035851.GB3252492@google.com>
 <CAFQ2z_NU_hBF2Gz4yFK+Q-KreBQONeMF+pJYESp7hVnKCWvmDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_NU_hBF2Gz4yFK+Q-KreBQONeMF+pJYESp7hVnKCWvmDg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys wrote:
> On Fri, Oct 2, 2020 at 5:58 AM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Adding a header in a separate patch from the implementation doesn't
>> match the usual practice.  Can we add declarations in the same patch
>> as the functions being declared instead?
>
> We could, but it would considerably complicate work on this patch
> series, as the commit boundary then doesn't fall on file boundaries
> anymore. Would you be open to having multiple headers for the public
> interface? eg. reftable-record.h, reftable-reader.h etc. ?

I'd be more than open to it: I think that would make for a clearer API.

For example, a caller like refs.c wouldn't have any need to use
reftable-block.h because that's a lower-level detail that operates
behind the scenes when operating on a stack of reftables.  So I think
this would be a good step toward addressing the feedback Jonathan gave
about the set of functions exposed by the API being overwhelming.

>>> +     /* Misuse of the API:
>>> +        - on writing a record with NULL refname.
>>> +        - on writing a reftable_ref_record outside the table limits
>>> +        - on writing a ref or log record before the stack's next_update_index
>>> +        - on writing a log record with multiline message with
>>> +        exact_log_message unset
>>> +        - on reading a reftable_ref_record from log iterator, or vice versa.
>>> +     */
>>> +     REFTABLE_API_ERROR = -6,
>>
>> Should these call BUG()?  Or is it useful for some callers to be able
>> to recover from these errors?
>
> Since this was written as a standalone library, it's up to the caller
> to decide what should be done.

I'm not strongly opinionated about this, but just a quick note: this
implies that the library would need to make sure it is producing a
valid state in error cases.

Does the API documentation describe what state a handle is in after
an error --- e.g., what operations are permitted after that?

>>> +
>>> +/*
>>> + * Convert the numeric error code to an equivalent errno code.
>>> + */
>>> +int reftable_error_to_errno(int err);
>>
>> What is the intended use of this function?
>
> The read_raw_ref method in the ref backend API uses errno values as
> out-of-band communication mechanism.

Could we change that?  It sounds error-prone.

[...]
>>> +/* Set the range of update indices for the records we will add.  When
>>> +   writing a table into a stack, the min should be at least
>>> +   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
>>> +
>>> +   For transactional updates, typically min==max. When converting an existing
>>> +   ref database into a single reftable, this would be a range of update-index
>>> +   timestamps.
>>> + */
>>> +void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>>> +                             uint64_t max);
>>
>> What happens if I write to a reftable_writer without setting limits
>> first?
>
> you get an REFTABLE_API_ERROR.

(To be clear, with all of these questions, I am asking not only for my
own curiosity but so that the documentation, naming, etc can be
cleared up to help the next person who wonders the same thing.)

[...]
>> Do I pass in the 'struct block_source *' as the source arg?  If so, why
>> are these declared as void *?
>
> you pass in block_source->arg. Should struct implementations of
> polymorphic types carry a pointer to their own vtable instead?

I think a pointer to block_source would make it more self-explanatory,
yes.

(Aside: this is a difference between how Go and e.g. Java and C++
implement polymorphism.  In Go, an interface object contains a vtable
and a pointer to the object.  In Java and C++, the object contains a
vptr.)

>> Is the reason this manages the buffer instead of requiring a
>> caller-supplied buffer to support zero-copy?
>
> Log blocks are compressed, so the caller doesn't know the correct size
> to supply. By letting the block source handle the management, we can
> swap out the block read from the file for a block managed by malloc on
> decompressing a log block.

Hm, my naive assumption would have been that we'd use different
buffers for the compressed and uncompressed data.

>>> + Generic tables
>>> +
>>> + A unified API for reading tables, either merged tables, or single readers.
>>
>> Are there callers/helpers that don't know whether they want one or the
>> other?
>
> The setup with per-worktree refs means that there are two reftable
> stacks in a .git repo. In order to iterate over the entire ref space,
> you have to merge two merged tables, but the stack itslef merges a set
> of simple reftables.

I see.  That's subtle, so it seems worth documenting for the next
person reading this documentation and wondering why.

Thanks,
Jonathan
