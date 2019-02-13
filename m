Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4E61F453
	for <e@80x24.org>; Wed, 13 Feb 2019 22:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbfBMW1w (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 17:27:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50273 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbfBMW1w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 17:27:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so4290587wmj.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 14:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=W1ktKL5OfcwaBuKI0pjBdlmGVNFTjD6Z+3IV/uD1jPk=;
        b=ofCUkwf09EqfMmqdoWAHm4tTid10d2lM2+yaEFG2PblyMNZyyE+Y0iSRaCSvL/2dnZ
         GqLuacBKBegrM5xkjEoFXEonbW6Qm20HmM2e62khDhRJ7PY4WoMK9HuQsvRnoX+NFwZG
         H7vp2VgcGSkd4vJaFWGRDf20C3FDWNJyy6rErHJAOCfthaRDSlNgLyVnCiPI3siiO4Y7
         do1rxz8CDunWGX0vaAAqHVfZhnjf+e4YiV5GSWk+6BBMkpR/viIVFNb/eI7MnmfTJwMX
         vmFSkYc6gTrAplWNknMaM9SQiHJmkPcUmMZbuwzRzHeQ/tWiM5ue/VuWI06UKFqGHdGA
         4kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=W1ktKL5OfcwaBuKI0pjBdlmGVNFTjD6Z+3IV/uD1jPk=;
        b=bTlFtcOdmT9qVW9malyuJon38H416fYIyjQff/2pISQeqkKxaxB3pPNgWgfqWq59xe
         LJNoQK+HyqHsLORuzAAa+tGWxHV4ZIK/CYeXUjLh9tfi6EOb2H9qnN1K63N06QAaQqPd
         L8f0YAuHlsStNxVz0lmpsaubYgmU8/sTNOU/5EGZZuN0wFX/pqKYidl+c7KOegkv3s1/
         +WshmQjuFjBjS4rbZE7gmcnjF0gyvKf0GpYi2p+M24F8JKf4OAP2+zYkBtz8Rwg4SvGp
         Uz5cDuO6uOgEwAUneiiYnJhZudFSfsx6eXcbSU+Uwblq24h91/U4SNpwTECwfaMLdmOD
         CoOQ==
X-Gm-Message-State: AHQUAub+BCc1wTtMIU54EQR+K997YMibWWXDRp//Ndy2bWrwLeITxoFo
        M+o4Au/rCcMceUACDUJpIAM=
X-Google-Smtp-Source: AHgI3IZf/3ygWBR3ztH3C8jIsXodub7nJw1/wL3bYDXDEEi7qjuTTTz5Y5l6rKWSADEu5E8y8QOE1Q==
X-Received: by 2002:a7b:c00f:: with SMTP id c15mr274470wmb.14.1550096869610;
        Wed, 13 Feb 2019 14:27:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c139sm744153wmd.13.2019.02.13.14.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:27:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] read-cache.c: index format v5 -- 30% smaller/faster than v4
References: <20190213120807.25326-1-pclouds@gmail.com>
Date:   Wed, 13 Feb 2019 14:27:46 -0800
In-Reply-To: <20190213120807.25326-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 13 Feb 2019 19:08:07 +0700")
Message-ID: <xmqq1s4bb9y5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -1749,16 +1750,16 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  	 * number of bytes to be stripped from the end of the previous name,
>  	 * and the bytes to append to the result, to come up with its name.
>  	 */
> -	int expand_name_field = version == 4;
> +	int expand_name_field = version >= 4;

The code can be lazy like this, insteasd of being more descriptive
to say "version 4 or 5", because we won't accept version 6 or later
anyway.  Which is OK, I guess.

>  	if (flags & CE_EXTENDED) {
> -		struct ondisk_cache_entry_extended *ondisk2;
> +		const struct ondisk_cache_entry_extended *ondisk2 = mmap;
>  		int extended_flags;
> -		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
> +
>  		extended_flags = get_be16(&ondisk2->flags2) << 16;
>  		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
>  		if (extended_flags & ~CE_EXTENDED_FLAGS)

This part may be a good clean-up regardless.

> @@ -1820,6 +1821,113 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  	return ce;
>  }
>  
> +enum same_value_bit {
> +	DELTA_FORMAT = 1 << 0,
> +	SAME_CTIME   = 1 << 1, /* only covers sec, not nsec */
> +	SAME_MTIME   = 1 << 2, /* only covers sec, not nsec */
> +	SAME_DEV     = 1 << 3,
> +	SAME_INO     = 1 << 4,
> +	SAME_MODE    = 1 << 5,
> +	SAME_UID     = 1 << 6,
> +	SAME_GID     = 1 << 7,
> +	SAME_FLAGS   = 1 << 7
> +};

Hmph, really?

> +static struct cache_entry no_previous_ce;
> +
> +static uintmax_t decode_varoffset(const unsigned char **bufp, uintmax_t prev)
> +{
> +	uintmax_t val = decode_varint(bufp);

You'd need to make sure (1) !val, which indicates an overflow of the
varint, and (2) bufp after decoding haven't over-read the mmapped
index file.  We may want to improve decode_varint() API so that we
can detect truncated data (i.e. (2)) more reliably without first
reading too much.  Loose error checking like these would make good
targets for fuzz tests, I suspect.

> +	return val & 1 ? prev - (val >> 1) : prev + (val >> 1);
> +}

So, the LSB is used for sign, and the magnitude is shifted by one?
OK.

> +static uintmax_t decode_varoffset_same(const unsigned char **bufp, uintmax_t prev,
> +				       int same_flag)
> +{
> +	return same_flag ? prev : decode_varoffset(bufp, prev);
> +}
> +
> +static uintmax_t decode_varint_same(const unsigned char **bufp, uintmax_t prev,
> +				    int same_flag)
> +{
> +	return same_flag ? prev : decode_varint(bufp);
> +}

Likewise about two error conditions.

> @@ -1967,12 +2075,18 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
>  	unsigned long src_offset = start_offset;
>  
>  	for (i = offset; i < offset + nr; i++) {
> -		struct ondisk_cache_entry *disk_ce;
>  		struct cache_entry *ce;
>  		unsigned long consumed;
>  
> -		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
> -		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
> +		if (istate->version <= 4)
> +			ce = create_from_disk(ce_mem_pool, istate->version,
> +					      mmap + src_offset, &consumed,
> +					      previous_ce);
> +		else
> +			ce = create_from_disk_v5(ce_mem_pool,
> +						 mmap + src_offset,
> +						 &consumed,
> +						 previous_ce);

This goes directly against the spirit of "create_from_disk()"
internal API, doesn't it?  It takes istate->version because it is an
implementation detail of that function how bytes at
&mmap[src_offset] are consumed, possibly using previous_ce
information.

IOW, I think the version dependent switch should go inside that
function and not in this loop.


> +static int ce_write_varint(git_hash_ctx *c, int fd, uintmax_t value)
> +{
> +	unsigned char varint[16];

We may want to do something about these "16".

> +static int ce_write_varoffset(git_hash_ctx *c, int fd, uintmax_t next, uintmax_t prev)
> +{
> +	unsigned char varint[16];

