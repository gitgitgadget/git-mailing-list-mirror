Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE79C433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 07:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbiEYHtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiEYHs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 03:48:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6399B7A810
        for <git@vger.kernel.org>; Wed, 25 May 2022 00:48:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gk22so544017pjb.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5EztO6NT6S9gS4QZlUqQ9zIawps0Bt1Jm80NRz458oc=;
        b=ZTzzcwNbSv7rMkF0MBj4SuuhVvojyQx4hJk9LHrhmT5BRq0f6K12PU143EcyuI5hPz
         iCLRQG46R1m1XVePlSp3GziNecbKaB9KaW1hWsJFvWrwaGbyjfxb0x4P0rYPK/2sfiPU
         Ef+sp8NmG60kTij5mz6oKWuc6wOdbiurisBf6hDFz0nkDVzzH9MiUwonyNavjWHoCTKz
         kjLNIBp86YCPb04b/mKvNAKVtjD00gdMr7s6crVoQDVQdfCU2UFxnDfu1rYyyc13fBaX
         VPmfJqZ9p8SZxPgLFbx+O0IeoZ58J3UBIFl7Brty7mWqQLxn6B/MelwyST/4Shvy9ziv
         8sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5EztO6NT6S9gS4QZlUqQ9zIawps0Bt1Jm80NRz458oc=;
        b=Xy4zWcRvfa0+ev7ZV0aC4vaLh3KmZDsFNZ1JCf+7gDIS6irqooGms7qXgth0PlmmpD
         ++34ggrGZQkWVNZDyc7mBK2Ah7EJf3IThf/x2fsvw/SMAKzs5/0mDm7c2m4I3IcGIIYp
         GbfMvFA1j1DJutkpWHqSvBODQ9TP2Yg08qHgwrCIFIh9rBWBjplbjuicWDQi0MaI7hfL
         KzRFc+pbuoZVg50jqLxxNjV8u4YMH/BKmHWw5uHOnhAVAgKLqoRoRNUyPpRhuLLfgH1X
         GxpPUgMxVKvcGMGE3tAgKIH84Cun/5hycVeAdmrb4r4ogKmJz9BymmRKIh0xuJGqgl3w
         0dDg==
X-Gm-Message-State: AOAM531kg584QZIPmaePLBHuHJg0iMIHCXQxSATZAha6y1srw4WbGdku
        EqUmoVsbYbBZnE+MfhPNtno=
X-Google-Smtp-Source: ABdhPJwKRIBYqDmt3Qz52kOm178TNJgNLTt0vJfGyvNtVdsOlef9Ps/t1JfGa9YnygygPS0i4z4CQA==
X-Received: by 2002:a17:902:d483:b0:161:b6a3:4dba with SMTP id c3-20020a170902d48300b00161b6a34dbamr32158762plg.155.1653464936679;
        Wed, 25 May 2022 00:48:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:52ba:872d:8735:1c87])
        by smtp.gmail.com with ESMTPSA id x64-20020a628643000000b0050e006279bfsm10568391pfd.137.2022.05.25.00.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:48:56 -0700 (PDT)
Date:   Wed, 25 May 2022 00:48:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo3fZkpkCLPbAC8B@google.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
 <Yo1aaLDmPKJ5/rh5@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo1aaLDmPKJ5/rh5@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:
> On Tue, May 24, 2022 at 12:32:01PM -0700, Jonathan Nieder wrote:

>> Makes sense.  Does this intend to produce any functional change?  I'm
>> guessing not (and the lack of tests agrees), but the commit message
>> doesn't say so.
[...]
> This does not produce a functional change, no. This commit in isolation
> adds a bunch of dead code that will be used (and tested) in the
> following patches.
[...]
>> What does mtimes_map contain?  A comment would help.
>
> It contains a pointer at the beginning of the mmapped region of the
> .mtimes file, similar to revindex_map above it.

To be clear, in cases like this by "comment" I mean "in-code comment".
I.e., my interest is not that _I_ find out the answer but that the
code becomes more maintainable via the answer becoming easier to find.

[...]
>> This seems simple enough that it's not obvious we need more code
>> sharing.  Do you agree?  If so, I'd suggest just removing the
>> NEEDSWORK comment.
>
> Yeah, it is conceptually simple, though it feels like the sort of thing
> that could benefit from not having to be written once for each
> extension (hence the comment).

The reason I asked is that the NEEDSWORK here actually got in the way
of comprehension for me --- it made me wonder "is there some
complexity here I'm missing?"

That's why I'd suggest one of
- removing the NEEDSWORK comment
- going ahead and implementing the code sharing you mean, or
- fleshing out the NEEDSWORK comment so the reader can wonder less

>>> +
>>> +#define MTIMES_HEADER_SIZE (12)
>>> +#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))
>>
>> Hm, the all-caps name makes this feel like a compile-time constant but
>> it contains a reference to the_hash_algo.  Could it be an inline
>> function instead?
>
> Yes, it could be an inline function, but I don't think there is
> necessarily anything wrong with it being a #define'd macro. There are
> some other examples, e.g., RIDX_MIN_SIZE, MIDX_MIN_SIZE,
> GRAPH_DATA_WIDTH, and PACK_SIZE_THRESHOLD (to name a few) which also use
> the_hash_algo on the right-hand side of a `#define`.

Those are due to an incomplete migration from use of the true constant
GIT_SHA1_RAWSZ to use of the dynamic value the_hash_algo->rawsz, no?
In other words, "other examples do it wrong" doesn't feel like a great
justification for making it worse in new code.

[...]
>>> +static int load_pack_mtimes_file(char *mtimes_file,
>>> +				 uint32_t num_objects,
>>> +				 const uint32_t **data_p, size_t *len_p)
>>
>> What does this function do?  A comment would help.
>
> I know that I'm biased as the author of this code, but I think the
> signature is clear here. At least, I'm not sure what information a
> comment would add that the function name and its arguments don't already
> convey.

Ah, thanks for this point of clarification.  What isn't clear from the
signature is
- when should I call this function?
- what does its return value represent?
- how does it handle errors?

I agree that the parameters are self-explanatory.

>>> +cleanup:
>>> +	if (ret) {
>>> +		if (data)
>>> +			munmap(data, mtimes_size);
>>> +	} else {
>>> +		*len_p = mtimes_size;
>>> +		*data_p = (const uint32_t *)data;
>>
>> Do we know that 'data' is uint32_t aligned?  Casting earlier in the
>> function could make that more obvious.
>
> `data` is definitely uint32_t aligned, but this is a tradeoff, since if
> we wrote:
>
>     uint32_t *data = xmmap(...);
>
> then I think we would have to change the case where ret is non-zero to be:
>
>     if (data)
>         munmap((void*)data, ...);
>
> and likewise, data_p is const.

Doing it that way sounds great to me.  That way, the type contains the
information we need up-front and the safety of the cast is obvious in
the place where the cast is needed.

(Although my understanding is also that in C it's fine to pass a
uint32_t* to a function expecting a void*, so the second cast would
also not be needed.)

[...]
>>> +int load_pack_mtimes(struct packed_git *p)
>>
>> This could use a doc comment in the header file.  For example, what
>> requirements do we have on what the caller passes as 'p'?
>>
>> [...]
>>> +uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos)
>>
>> Likewise.
>
> Sure. I wonder when we should do that, though. I'm not trying to be
> impatient to get this merged, but iterating on the documentation feels
> like it could be done on top without having to re-send the substantive
> parts of this series over and over.

In terms of re-sending patches, sending a "fixup!" patch with the
minor changes you want to make doesn't seem too problematic to me.  In
general a major benefit of code review is getting others' eyes on new
code from the standpoint of readability and maintainability; including
comments like this up front doesn't seem like a huge amount to ask
(versus getting those comments to be perfect, which would be
unreasonable to expect since it's not hard to update them over time).

> Thanks,
> Taylor

Thanks for looking it through.

Sincerely,
Jonathan
