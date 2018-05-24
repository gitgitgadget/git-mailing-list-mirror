Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB36F1F42D
	for <e@80x24.org>; Thu, 24 May 2018 04:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeEXEw1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 00:52:27 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47047 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeEXEw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 00:52:26 -0400
Received: by mail-wr0-f195.google.com with SMTP id x9-v6so505235wrl.13
        for <git@vger.kernel.org>; Wed, 23 May 2018 21:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rlXsckfCkrZVoM0Pl8ExjbFUF39CBqObQjyPx/IYvh0=;
        b=NFTA9/6VaX02/ATi+iOUI73IEv8uITy5taRLDqqIJUvvvwQjY5/Usj666UvqB5ldSK
         zYpRW4gMrLC3udC0GFsgIxl4s5rJ9elJmiRt1on+huY1mu4rkDbITgZrUaiJFyQXvbxp
         aK/1pPKMl6OWIh7PJOdSC5I7Xx22AbS9qYdLZKTh37A8ysPK5KS+NcVT/pkAATiyxGcw
         WLZK2gb03jGDIkxkFMVR21Idn19fuk/6hYwx+gE4C0Hko5TR0f6H0AQd77jkQkH9HTZd
         BTBBISVb/ipsDMPebK2+JXk8BcgO3nToZwbNnarnpF5td/FlewymVOkLYdxXRRJThH1S
         8mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rlXsckfCkrZVoM0Pl8ExjbFUF39CBqObQjyPx/IYvh0=;
        b=TK16i5Og4/RRTBPjPdAWIIR1aTJe9+btqoHUQ5r1vwm7cJ7uBX8n2tRUCgAtWBmjlQ
         Gx3tl6Ai6Zq3Gm0JOZDPMnTjoHTQgr9NJ2plE+RfGEJ0FsOhLgN4jkHABLK5am1/48i0
         VBKZ/esDNBsSQwx0INYLWxFjw2khwXuxMgruw8SJtKZm4YWOPoqtEnxDPafF4W0c/u/C
         A9qRoYykQCzq/mO46ui0G6vBHu3/sVFRpVVif8zdCj/4NUKhZUiRJBxHyUDkIOJF68hC
         vLa5jresu9TNEPxZRnZZkCGIZdOY62DmJE9MNyX7O8FWaz1317G48ajJU/bHKcm/NSAf
         GuQw==
X-Gm-Message-State: ALKqPweItsSjYW/q+M+7fUV0jyye0FggaWaXxyYb3uAF18CPjU5QeCSX
        7GXWfav8gNFqtDJx6X1zHDY=
X-Google-Smtp-Source: AB8JxZqTRcy+ab2prVYP2hxzz/0n3CAKdrwNgjqFTW9ceX4oV260OBz1p4ip8V5BXAShcN9hAqFsdw==
X-Received: by 2002:adf:9441:: with SMTP id 59-v6mr4582831wrq.194.1527137544518;
        Wed, 23 May 2018 21:52:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 109-v6sm18133951wra.32.2018.05.23.21.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 21:52:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "peartben\@gmail.com" <peartben@gmail.com>
Subject: Re: [PATCH v3 2/7] block alloc: add lifecycle APIs for cache_entry structs
References: <20180417163400.3875-1-jamill@microsoft.com>
        <20180523144637.153551-1-jamill@microsoft.com>
        <20180523144637.153551-3-jamill@microsoft.com>
Date:   Thu, 24 May 2018 13:52:23 +0900
In-Reply-To: <20180523144637.153551-3-jamill@microsoft.com> (Jameson Miller's
        message of "Wed, 23 May 2018 14:47:36 +0000")
Message-ID: <xmqqefi1sliw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> Add an API around managing the lifetime of cache_entry
> structs. Abstracting memory management details behind an API will
> allow for alternative memory management strategies without affecting
> all the call sites.  This commit does not change how memory is
> allocated / freed. A later commit in this series will allocate cache
> entries from memory pools as appropriate.
>
> Motivation:
> It has been observed that the time spent loading an index with a large
> number of entries is partly dominated by malloc() calls. This change
> is in preparation for using memory pools to reduce the number of
> malloc() calls made when loading an index.
>
> This API makes a distinction between cache entries that are intended
> for use with a particular index and cache entries that are not. This
> enables us to use the knowledge about how a cache entry will be used
> to make informed decisions about how to handle the corresponding
> memory.

Yuck.  make_index_cache_entry()?

Generally we use "cache" when working on the_index without passing
istate, and otherwise "index", which means that readers can assume
that distim_cache_entry(...)" is a shorter and more limited way to
say "distim_index_entry(&the_index, ...)".  Having both index and
cache in the same name smells crazy.

If most of the alocations are for permanent kind, give it a shorter
name call it make_cache_entry(&the_index, ...), and call the other
non-permanent one with a longer and more cumbersome name, perhaps
make_transient_cache_entry(...).  Avoid saying "index" in the former
name, as the design decision this series is making to allocate
memory for a cache-entry from a pool associated to an index_state is
already seen by what its first parameter is.

> diff --git a/cache.h b/cache.h
> index f0a407602c..204f788438 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -339,6 +339,29 @@ extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
>  extern void free_name_hash(struct index_state *istate);
>  
>  
> +/* Cache entry creation and freeing */
> +
> +/*
> + * Create cache_entry intended for use in the specified index. Caller
> + * is responsible for discarding the cache_entry with
> + * `discard_cache_entry`.
> + */
> +extern struct cache_entry *make_index_cache_entry(struct index_state *istate, unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
> +extern struct cache_entry *make_empty_index_cache_entry(struct index_state *istate, size_t name_len);
> +
> +/*
> + * Create a cache_entry that is not intended to be added to an index.
> + * Caller is responsible for discarding the cache_entry
> + * with `discard_cache_entry`.
> + */
> +extern struct cache_entry *make_transient_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage);
> +extern struct cache_entry *make_empty_transient_cache_entry(size_t name_len);
> +
> +/*
> + * Discard cache entry.
> + */
> +void discard_cache_entry(struct cache_entry *ce);

I am not yet convinced that it is a good idea to require each istate
to hold a separate pool.  Anything that uses unpack_trees() can do
"starting from this src_index, perform various mergy operations and
deposit the result in dst_index".  Sometimes the two logical indices
point at the same istate, sometimes different.  When src and dst are
different istates, the code that used to simply add another pointer
to the same ce to the dst index now needs to duplicate it out of the
pool associated with dst?

In any case, perhaps it will become clearer why it is a good idea as
we read on, so let's do so.
