Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31C21F404
	for <e@80x24.org>; Fri,  6 Apr 2018 20:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeDFUl4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 16:41:56 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:39613 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeDFUlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 16:41:55 -0400
Received: by mail-yw0-f172.google.com with SMTP id q66so784885ywg.6
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nPX5jpA5uypY3/vtlaX2OnyUj5wJqveWLqsDM8SCsMs=;
        b=SXdhD0kzbqSMcQTZpLp07PHvvGW2NsN09oPbnfLWegUuQOZnpTvrcTFxQUb/T/WXKZ
         zZihMkTEgt+sDPPTjwkWKbKB5WzFKBMclDV+5AvT3om/gel95n9tKJV9He68dNCiy3JY
         rlxm0FwLu5yI+117/jh11sH13P/f5pV88In21xUvQUQkvWXe+etmveakQdGX5o7lJS1d
         Zum1ya70DNAnTwDcYrp/xcEYr7spiuwAEUqfIUqB6UAt0Z91k8a7vo1OpTaxMlFQKwt+
         TCNYdhw7rgS+gEIf/NQHNhugzo/c+1uDBb8TC5F/eUDhHhwRcQiPcNhkAP/NDXwlTSzr
         nJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nPX5jpA5uypY3/vtlaX2OnyUj5wJqveWLqsDM8SCsMs=;
        b=oqWiw9EEoQWBFHtdKRPrnGh20z/jKuZPdxmJPjEM/WmN3pzfecxLls5WvdTAztWEgA
         YB1Gy4jQlfJYBiLKVNbBiQaBV6V4GMrBkVbYxJmYlVEmbFT+hS9MZ9jCByiQKrq4lNT6
         6hr9VYHk1HriVmWcLUmsts6dcTNRI/QaSrzIUN3HU4EK3yV+3KsFmDIIyUro/n3Bzg9c
         JTBT95e9bJCoM4E4W+kJzaWioR8pMy6RjGAn9I/Zg+5rNSqDLCrBT7vbUomfLRYJC6qu
         1+ceVHMGAcpMKzGf6A8R3Y6HeLnncqvPJfOztUUWb7YS5hWAVbZ6qsOnvc+T8ZYRjGHG
         qxew==
X-Gm-Message-State: ALQs6tAOGo9eiDbBzJxqmH4whPDOrzEfffYmFGW39pQQ0KJjH4v4X6Y1
        HN/leSnDgskvz+M447ad7C/7afVX3JJ2RFTDgVaBZ7xf2zQ=
X-Google-Smtp-Source: AIpwx49DwJBoKJUFXVhNpBnVrKdSuk5xywX1r2pZTHGKW5XHCpCLoP8SrCZNLfrB2TG0dVsebrI8VuvlnT9OG8oxuCc=
X-Received: by 10.129.108.67 with SMTP id h64mr7642517ywc.500.1523047314586;
 Fri, 06 Apr 2018 13:41:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 6 Apr 2018 13:41:53 -0700 (PDT)
In-Reply-To: <20180406200443.GE11450@sigill.intra.peff.net>
References: <20180402224854.86922-1-sbeller@google.com> <20180402224854.86922-4-sbeller@google.com>
 <20180406200443.GE11450@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Apr 2018 13:41:53 -0700
Message-ID: <CAGZ79kY+Eke-nZ2R5ULVi1za4e8hvFKzuMQiEzXQF8GNA9=adw@mail.gmail.com>
Subject: Re: [PATCH 3/7] diff.c: do not pass diff options as keydata to hashmap
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Simon Ruderich <simon@ruderich.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, Apr 6, 2018 at 1:04 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 02, 2018 at 03:48:50PM -0700, Stefan Beller wrote:
>
>> The diff options are passed to the compare function as
>> 'hashmap_cmp_fn_data', which are given when the hashmaps
>> are initialized.
>>
>> A later patch will make use of the keydata to signal
>> different settings for comparision.
>
> I had to scratch my head here for a moment. Don't we use those options
> as part of the comparison?

Yes we do, but not as passed in here.

Stepping back a bit: There are 2 void pointers passed to the cmp function:

typedef int (*hashmap_cmp_fn)(const void *hashmap_cmp_fn_data,
      const void *entry, const void *entry_or_key,
      const void *keydata);

The hashmap_cmp_fn_data is the same pointer as we pass as
the equals_function data in

extern void hashmap_init(struct hashmap *map,
        hashmap_cmp_fn equals_function,
        const void *equals_function_data,
        size_t initial_size);

whereas the keydata is passed in either directly when calling cmp directly
or in hashmap_get_from_hash:

static inline void *hashmap_get_from_hash(const struct hashmap *map,
          unsigned int hash,
         const void *keydata)
{
        struct hashmap_entry key;
        hashmap_entry_init(&key, hash);
        return hashmap_get(map, &key, keydata);
}

It turns out we are passing the struct diff_options *o into the cmp
function twice, once via the inits equals_function_data, as well as
keydata directly. Omit the direct pass in.

This is mostly a cleanup as of now, as it turns out I do not need to
reuse the keydata field anyway.

> I took the "which" to mean "the compare function", but I think you mean
> "we pass these diff options already when the hashmap is initialized".

Oh, yes.

> Maybe something like this would be more clear:
>
>   When we initialize the hashmap, we give it a pointer to the
>   diff_options, which it then passes along to each call of the
>   hashmap_cmp_fn function. There's no need to pass it a second time as
>   the "keydata" parameter, and our comparison functions never look at
>   keydata.
>

Thanks for clearing this up, will take as-is.

>   This was a mistake left over from an earlier round of 2e2d5ac184
>   (diff.c: color moved lines differently, 2017-06-30), before hashmap
>   learned to pass the data pointer for us.

That sounds about right.

>
> (I'm just guessing on the second paragraph based on a quick look at
> git-blame and my recollection from the time).
>
> -Peff

Thanks,
Stefan
