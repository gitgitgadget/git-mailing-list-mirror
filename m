Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538A7C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 21:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAD2206A1
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 21:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k8zMhV6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgDIVbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:31:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56364 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgDIVbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 17:31:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4E7340A8A;
        Thu,  9 Apr 2020 17:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c3eI9RaJoYzAgmBBX/7c3/xWDMY=; b=k8zMhV
        6GHWQ0tlfcGQt2UcftsWLPU7fk08vc4jDRpmnYxplQFzywYqlSWiPf+y2XdCeZ9m
        UVeOtyl4O1r0dwjZH1qqbQR86oQZV45pYBwNc686pp7JfbZUQsi38rt+NZAjyfaJ
        FWKVknBuT4QEUlYu18UvPQ1MNcE4k8aLWYfRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UXardVV0mwsa197cns0xnPzvz13htA1/
        bf9Ca5ehpLNkoIYqTfCk1LiJss0yyRjcKQrVQFGQJ8Xmjmw8GlkPFtwVFNaIb5gx
        2JuaP4OG+r9h96dARE04ZRa/VHX3KWi7BdPrDsPw4wJEoEqevfQWp4P2IElAvIJe
        KIq3hB/UVs0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD5FF40A87;
        Thu,  9 Apr 2020 17:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5685B40A86;
        Thu,  9 Apr 2020 17:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alba Mendez via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alba Mendez <me@alba.sh>
Subject: Re: [PATCH] pack-format: document missing fields
References: <pull.605.git.1586459494321.gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 14:31:32 -0700
In-Reply-To: <pull.605.git.1586459494321.gitgitgadget@gmail.com> (Alba Mendez
        via GitGitGadget's message of "Thu, 09 Apr 2020 19:11:34 +0000")
Message-ID: <xmqqlfn4mjm3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BD2C144-7AA9-11EA-BF28-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alba Mendez via GitGitGadget" <gitgitgadget@gmail.com> writes:

>       4-byte version number (network byte order):
> -	 Git currently accepts version number 2 or 3 but
> +         Git currently accepts version number 2 or 3 but
>           generates version 2 only.

Hmph, what is this hunk about?

> -     (undeltified representation)
> -     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
> -     compressed data
> -
> -     (deltified representation)
> -     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
> -     20-byte base object name if OBJ_REF_DELTA or a negative relative
> -	 offset from the delta object's position in the pack if this
> -	 is an OBJ_OFS_DELTA object
> -     compressed delta data


> +     packed object header:
> +        1-byte size extension bit (MSB)
> +            type (next 3-bit)
> +            size0 (lower 4-bit)
> +        n-byte sizeN (as long as MSB is set, each 7-bit)
> +            size0..sizeN form 4+7+7+..+7 bit integer, size0
> +            is the least significant part, and sizeN is the
> +            most significant part.
> +     packed object data:
> +        If it is not DELTA, then deflated bytes (the
> +            size above is the size before compression).

Correct.

> +        If it is REF_DELTA, then
> +            20-byte base object name SHA-1.
> +            deflated delta data (the size above is the
> +                size of this data before compression).

Correct.

> +        If it is OFS_DELTA, then
> +            n-byte offset (see below) interpreted as a
> +                negative offset from the type-byte of
> +                the header of the ofs-delta entry.

Correct, and "see below" here is very important.

> +            deflated delta data (the size above is the
> +                size of this data before compression).

> +     offset encoding:
> +        n bytes with MSB set in all but the last one.
> +        The offset is then the number constructed by
> +        concatenating the lower 7 bit of each byte, and
> +        for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
> +        to the result.

Correct.  Shouldn't we have a similar explanation for the object
length varint above (in other words, how 4+7+7+..+7 bits are
combined to form an integer)?

> @@ -67,7 +82,9 @@ Ref-delta can also refer to an object outside the pack (i.e. the
>  so-called "thin pack"). When stored on disk however, the pack should
>  be self contained to avoid cyclic dependency.
>  
> -The delta data is a sequence of instructions to reconstruct an object
> +The deflated delta data begins with two n-byte sizes: the size of
> +the base object data, and the size of the reconstructed object data.

Similarly, not just "n-byte size", but clarify that this is a pair
of "varint" and specify which kind of "varint" it is (IIRC, this
encoding did not use the "save-one-bit" trick the offset encoding
uses).

> @@ -186,36 +203,6 @@ trailer	  | | packfile checksum              |
>                    |
>  Pack file entry: <+
>  
> -     packed object header:
> -	1-byte size extension bit (MSB)
> -	       type (next 3 bit)
> -	       size0 (lower 4-bit)
> -        n-byte sizeN (as long as MSB is set, each 7-bit)
> -		size0..sizeN form 4+7+7+..+7 bit integer, size0
> -		is the least significant part, and sizeN is the
> -		most significant part.
> -     packed object data:
> -        If it is not DELTA, then deflated bytes (the size above
> -		is the size before compression).
> -	If it is REF_DELTA, then
> -	  20-byte base object name SHA-1 (the size above is the
> -		size of the delta data that follows).
> -          delta data, deflated.
> -	If it is OFS_DELTA, then
> -	  n-byte offset (see below) interpreted as a negative
> -		offset from the type-byte of the header of the
> -		ofs-delta entry (the size above is the size of
> -		the delta data that follows).
> -	  delta data, deflated.
> -
> -     offset encoding:
> -	  n bytes with MSB set in all but the last one.
> -	  The offset is then the number constructed by
> -	  concatenating the lower 7 bit of each byte, and
> -	  for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
> -	  to the result.
> -
> -

Hmph, I kept saying "Correct" above, but it seems that the
correctness come from the original.  So, why is this patch so big?

As far as I can tell, the only thing it improved (content-wise) was
to say that the delta data has two varints that lets reader to
validate the length of the original contents that the delta applies
to, and to allocate the buffer to hold the result before applying
the delta.  Puzzled.

Thanks.

