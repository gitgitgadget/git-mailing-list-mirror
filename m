Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0CD1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 17:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeIGWh7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 18:37:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52723 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGWh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 18:37:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so15411440wmc.2
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=irVuM3RlR9VEFUI6COompLrz2+7JnY+Eml1kaibsV2U=;
        b=YQtzNNudDG8bdNT7p2+xnf1ecnWwUaaiCyYNFY7xKj8wIGuzwzNtfMJYlc2mRh7TLn
         2gEfbtQzKH8HDkcq5moyO1J8hO33oAXXZJnUagIotpLGsF2DrtaO2RBiT3yESdnHBY3I
         W3L0SYcECg7pVNmmUw6dwwXaenrM0FMwwPxFSHd5UXNzkAPXIEEZt0QXQnixGreuw+5g
         YFm45n9MYqi12WQ2qybCRCINzDRXMKEkymNlIKWWJmNHOOPixBaN7xx1jQa6NbmJCb7A
         kiEnSVCP2qheEBoNGQnVEQkWCVMmdkjRkSi5b6Qde72Hpdfv1asq8Q5nXJJudIAh4i4g
         vD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=irVuM3RlR9VEFUI6COompLrz2+7JnY+Eml1kaibsV2U=;
        b=sutefSd7Kl2zrtmkj/wdVuI2U9rWcUY8wJNtXbIIVcv5PuAUBfJbWRHXp1qKPgxAQM
         5ulfXOzpVJC39RHjSN222pyWT747Fb1qdqocVhyNEvIGLmY5G0xaYb2H+oPCqE0Lrt+1
         uqaAfw/6SdIcxcwa2aNxZ/2rkkM1iaSPtiNhpZohrX4IxWaqlCC31xbhGFSMkbGHrpA3
         C2D9HSmXJniFgbGpPBSwCoOsQjBHATF8vgr/k3pfIOyuKuV14IrYsDepoB54pRUr5wnL
         duBk1yTZOl2k2EQ+FT10HkyoMNVx3yozIcx57TNJyL8XWFJSuInwCO4Tk9cDCMFVJSMe
         UZmQ==
X-Gm-Message-State: APzg51BzocBl1Q1k4+7hy7pypLDmbhgYBBdxekfr73i4IOgKmRfXO3MU
        71A8FBzbNP9VZalCz1o6+aA=
X-Google-Smtp-Source: ANB0VdZ6EOg9Pgcl4u944NN4A+62zAmJYu1uSo4UU8F+A1blM9gaMOa1ldb1rEAgOFZ/p1PB5HFe3A==
X-Received: by 2002:a1c:638a:: with SMTP id x132-v6mr6143520wmb.33.1536342953883;
        Fri, 07 Sep 2018 10:55:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a9-v6sm7551800wmf.28.2018.09.07.10.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:55:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v3 2/4] eoie: add End of Index Entry (EOIE) extension
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180906210227.54368-1-benpeart@microsoft.com>
        <20180906210227.54368-3-benpeart@microsoft.com>
Date:   Fri, 07 Sep 2018 10:55:52 -0700
In-Reply-To: <20180906210227.54368-3-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 6 Sep 2018 21:03:56 +0000")
Message-ID: <xmqqpnxpw5sn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> The extension consists of:
>
> - 32-bit offset to the end of the index entries
>
> - 160-bit SHA-1 over the extension types and their sizes (but not
> their contents).  E.g. if we have "TREE" extension that is N-bytes
> long, "REUC" extension that is M-bytes long, followed by "EOIE",
> then the hash would be:
>
> SHA-1("TREE" + <binary representation of N> +
> 	"REUC" + <binary representation of M>)

I didn't look at the documentation patch in the larger context, but
please make sure that it is clear to the readers that these fixed
width integers "binary representations" use network byte order.

I briefly wondered if the above should include

    + "EOIE" + <binary representation of (32+160)/8 = 24>

as it is pretty much common file format design to include the header
part of the checksum record (with checksum values padded out with NUL
bytes) when you define a record to hold the checksum of the entire
file.  Since this does not protect the contents of each section from
bit-flipping, adding the data for EOIE itself in the sum does not
give us much (iow, what I am adding above is a constant that does
not contribute any entropy).

How big is a typical TREE extension in _your_ work repository
housing Windows sources?  I am guessing that replacing SHA-1 with
something faster (as this is not about security but is about disk
corruption) and instead hash also the contents of these sections
would NOT help all that much in the performance department, as
having to page them in to read through would already consume
non-trivial amount of time, and that is why you are not hashing the
contents.

> +	/*
> +	 * CACHE_EXT_ENDOFINDEXENTRIES must be written as the last entry before the SHA1

s/SHA1/trailing checksum/ or something so that we can withstand
NewHash world order?

> +	 * so that it can be found and processed before all the index entries are
> +	 * read.
> +	 */
> +	if (!strip_extensions && offset && !git_env_bool("GIT_TEST_DISABLE_EOIE", 0)) {
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		write_eoie_extension(&sb, &eoie_c, offset);
> +		err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
>  			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
>  		strbuf_release(&sb);
>  		if (err)

OK.

> +#define EOIE_SIZE 24 /* <4-byte offset> + <20-byte hash> */
> +#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */
> +
> +#ifndef NO_PTHREADS
> +static unsigned long read_eoie_extension(void *mmap, size_t mmap_size)
> +{
> +	/*
> +	 * The end of index entries (EOIE) extension is guaranteed to be last
> +	 * so that it can be found by scanning backwards from the EOF.
> +	 *
> +	 * "EOIE"
> +	 * <4-byte length>
> +	 * <4-byte offset>
> +	 * <20-byte hash>
> +	 */
> +	const char *index, *eoie = (const char *)mmap + mmap_size - GIT_SHA1_RAWSZ - EOIE_SIZE_WITH_HEADER;
> +	uint32_t extsize;
> +	unsigned long offset, src_offset;
> +	unsigned char hash[GIT_MAX_RAWSZ];
> +	git_hash_ctx c;
> +
> +	/* validate the extension signature */
> +	index = eoie;
> +	if (CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
> +		return 0;
> +	index += sizeof(uint32_t);
> +
> +	/* validate the extension size */
> +	extsize = get_be32(index);
> +	if (extsize != EOIE_SIZE)
> +		return 0;
> +	index += sizeof(uint32_t);

Do we know we have at least 8-byte to consume to perform the above
two checks, or is that something we need to verify at the beginning
of this function?  Better yet, as we know that a correct EOIE with
its own header is 28-byte long, we probably should abort if
mmap_size is smaller than that.

> +	/*
> +	 * Validate the offset we're going to look for the first extension
> +	 * signature is after the index header and before the eoie extension.
> +	 */
> +	offset = get_be32(index);
> +	if ((const char *)mmap + offset < (const char *)mmap + sizeof(struct cache_header))
> +		return 0;

Claims that the end is before the beginning, which we reject as bogus.  Good.

> +	if ((const char *)mmap + offset >= eoie)
> +		return 0;

Claims that the end is beyond the EOIE marker we should have placed
after it, which we reject as bogus.  Good.

> +	index += sizeof(uint32_t);
> +
> +	/*
> +	 * The hash is computed over extension types and their sizes (but not
> +	 * their contents).  E.g. if we have "TREE" extension that is N-bytes
> +	 * long, "REUC" extension that is M-bytes long, followed by "EOIE",
> +	 * then the hash would be:
> +	 *
> +	 * SHA-1("TREE" + <binary representation of N> +
> +	 *               "REUC" + <binary representation of M>)
> +	 */
> +	src_offset = offset;
> +	the_hash_algo->init_fn(&c);
> +	while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
> +		/* After an array of active_nr index entries,
(Style nit).
> +		 * there can be arbitrary number of extended
> +		 * sections, each of which is prefixed with
> +		 * extension name (4-byte) and section length
> +		 * in 4-byte network byte order.
> +		 */
> +		uint32_t extsize;
> +		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
> +		extsize = ntohl(extsize);

Earlier we were using get_be32() but now we use memcpy with ntohl()?
How are we choosing which one to use?

I think you meant to cast mmap to (const char *) here.  It may make it
easier to write and read if we started this function like so:

	static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size)
	{
		const char *mmap = mmap_;

then we do not have to keep casting mmap and cast to a wrong type by
mistake.

> +
> +		/* verify the extension size isn't so large it will wrap around */
> +		if (src_offset + 8 + extsize < src_offset)
> +			return 0;

Good.

> +		the_hash_algo->update_fn(&c, (const char *)mmap + src_offset, 8);
> +
> +		src_offset += 8;
> +		src_offset += extsize;
> +	}
> +	the_hash_algo->final_fn(hash, &c);
> +	if (hashcmp(hash, (unsigned char *)index))
> +		return 0;
> +
> +	/* Validate that the extension offsets returned us back to the eoie extension. */
> +	if (src_offset != mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER)
> +		return 0;

Very good.

> +	return offset;
> +}
> +#endif

Overall it looks like it is carefully done.
Thanks.
