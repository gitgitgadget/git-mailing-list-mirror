Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4861F403
	for <e@80x24.org>; Fri, 15 Jun 2018 17:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756284AbeFORMD (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 13:12:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39672 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbeFORMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 13:12:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so10615072wrn.6
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LGcsVmecCoRvIygrW02AHKPkCIY2AvmnnfCDDHGkWJ0=;
        b=e6/cBCTaljwcLECjMJ8WELvhcEgsq/mMFu5XMJRVp2Aj3P6KdDF2Cz4WsmJ+rVWDxG
         FnkKGfKrQG1wTU80XoBFEFcspNSHtgZEIyQWt77iU/wiKPB6cmWlgkn17zWl68pjPeRM
         t7l0KtvlZVuT5Bsn9Tg5soMbUaupBp3oBLk/PAQUd3Qc2nJtMMkBWeQAkm/k15aAPmdI
         HRNRypwQDI7ZDGds4zDL54dUJIYgdmrI/q2YQ5vZsB9gwUHgswHMvPrgiRW5nIauNzQO
         IsQ9p4FaZVg15XNWmqkrVscFedhzM+OEG5qxioMNIjFu1Qvt1ZdFRAnHQBvMBY8FR0Gr
         aYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LGcsVmecCoRvIygrW02AHKPkCIY2AvmnnfCDDHGkWJ0=;
        b=FSCJv+lHOEDL57E6uzyx4vP7wNEI48/v6/wMBqDsPNE53l11CtAHxwTIX1EtAf0SPr
         U5+gq/cuUkjc7/4ZN/98HMM/ze5Op9Hj4DqVpBj/FKAgWgf8WunqyJoq6Itm4JoELZTM
         LIgHIevXDYb3uaj/a8PGKNse0g8cGBdCT6uFK9dO0pFSajRuM3DojZ5pWdzdSkVfT/7B
         IAOeUYEKugYtBwwwr5Qrg7MJ1FJ2o9LjHlAlgmruMe4X9tQCU4PQ414v+VQL0PME9EiP
         HHjlEpbP83mL6X3+b9LcRIunN1LtPd5Xz0Hs8cCs6BTk5gcwU6Eaaos6gsuJf8Dj1LWg
         gyPw==
X-Gm-Message-State: APt69E2ryuf9gpGMkGoAzBFiSnbysPWsW/KY1vLazzb0VQdWD3EkDqaQ
        Gu1hqsPQt20YPs57vgAhb4o=
X-Google-Smtp-Source: ADUXVKL+PAkKaPvbK8Llm95dHd3ovlnOyzKmRsEsql5cxaZH7UG5lg0pK3hHs3P4asmkAOucQvOjww==
X-Received: by 2002:adf:a6b8:: with SMTP id t53-v6mr2530631wrc.45.1529082721578;
        Fri, 15 Jun 2018 10:12:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s10-v6sm2723977wmb.12.2018.06.15.10.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 10:12:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] ewah: adjust callers of ewah_read_mmap()
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
        <20180615032850.GA23241@sigill.intra.peff.net>
        <20180615034442.GA14422@sigill.intra.peff.net>
Date:   Fri, 15 Jun 2018 10:12:00 -0700
In-Reply-To: <20180615034442.GA14422@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 14 Jun 2018 23:44:43 -0400")
Message-ID: <xmqqo9gc0yan.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jun 14, 2018 at 11:28:50PM -0400, Jeff King wrote:
>
>> Yep. We also fail to check if we even have enough bytes to read the
>> buffer_size in the first place.
>> 
>> Here are some patches. The first one fixes the problem you found. The
>> second one drops some dead code that has a related problem. And the
>> third just drops some dead code that I noticed in the same file. :)
>> 
>>   [1/3]: ewah_read_mmap: bounds-check mmap reads
>>   [2/3]: ewah: drop ewah_deserialize function
>>   [3/3]: ewah: drop ewah_serialize_native function
>
> Actually, we'd want this one on top. Arguably it could be squashed into
> patch 1.
>
> -- >8 --
> Subject: ewah: adjust callers of ewah_read_mmap()
>
> The return value of ewah_read_mmap() is now an ssize_t,
> since we could (in theory) process up to 32GB of data. This
> would never happen in practice, but a corrupt or malicious
> .bitmap or index file could convince us to do so.
>
> Let's make sure that we don't stuff the value into an int,
> which would cause us to incorrectly move our pointer
> forward.  We'd always move too little, since negative values
> are used for reporting errors. So the worst case is just
> that we end up reporting a corrupt file, not an
> out-of-bounds read.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense.

>  dir.c         | 3 ++-
>  pack-bitmap.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 61b513a078..d5185660f1 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2725,7 +2725,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
>  	struct read_data rd;
>  	const unsigned char *next = data, *end = (const unsigned char *)data + sz;
>  	const char *ident;
> -	int ident_len, len;
> +	int ident_len;
> +	ssize_t len;
>  	const char *exclude_per_dir;
>  
>  	if (sz <= 1 || end[-1] != '\0')
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 369bf69d75..2f27b10e35 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -125,7 +125,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
>  {
>  	struct ewah_bitmap *b = ewah_pool_new();
>  
> -	int bitmap_size = ewah_read_mmap(b,
> +	ssize_t bitmap_size = ewah_read_mmap(b,
>  		index->map + index->map_pos,
>  		index->map_size - index->map_pos);
