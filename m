Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2661F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeCPUNt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:13:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34286 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeCPUNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:13:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id o8so12828725wra.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FCzb+dTvFEzGK13rp+IxWGh7UTLPK3Kv/O0RC3QNAPI=;
        b=goZ637EqUb2ihQ1pIm08nHLPndLH0XGylIq3E3cADsp72cqFWh94YbjWzSFOC0C47Z
         u06JDmBomzDYBFkS/KtOcLs6U+ALribyQiHd6QkseG3SKXuOOBdNVRxaCNoIG6BvezlG
         HCwO153/WlYKjuno3HNY5AovEOVbBdIwBkeQOFa8M2+hsaq+wyPpN05kerT0x6VyNZSg
         nhyVu4i/uO7nwrmTywDsEp2T/7WNAzciM49lmgg1By+hLBQujL6se+vjhB4I0u3z+2S4
         uGTQMLFzRLnMqmZArqlpia7vNL45iiw+6YBdOIp8TbZt+kR8yU7inHdQf65HZ0zNMpPX
         WYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FCzb+dTvFEzGK13rp+IxWGh7UTLPK3Kv/O0RC3QNAPI=;
        b=SEaKuEBsbrfhAoGCA/AMAT6nloJpU8CvjUvJLzFvclGQ2wD3L18uPA5FzG9HU2BKuZ
         FFrEn5qY7mF7BsfPFf5U1DU0n6Orf6j2+5Ae3TyIOdfc+DJzOhHABdw/mrS3IOX52PUH
         Cf034ZDQ8Px133A/4CsURNwumgqieLpatBYTB60cW87YeCa/EFQuyGkFnlGU0scr1ORt
         55phd0KyAGVN2JBaheV79JxYW4S9hPYkMR3OjnPQdg7tQNHKl9YpGDY95B8QszpScQhL
         v7a6ko3kXnYV16IBd7yp/dh+95wcC7ZE1QB0B3HQ2AS+adonrRQdgSL9WblBLmn2H1Ot
         bzBw==
X-Gm-Message-State: AElRT7Fhk/QqekkNPf2geTshrNRYjj+00SFCdDVcOcxyJKjzmSf408CX
        FfA6xNeuQnf5l4LccxBDCSLyJCBn
X-Google-Smtp-Source: AG47ELvMFCYDrIYzoCbwgOr8cu1e4Wxy//gtm6t+4WDlko46oFqbhYmUYpsHSLCuWecpJ23Qd/vBPg==
X-Received: by 10.223.135.148 with SMTP id b20mr2670797wrb.100.1521229785793;
        Fri, 16 Mar 2018 12:49:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m71sm7508563wmd.6.2018.03.16.12.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 12:49:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 09/11] pack-objects: shrink size field in struct object_entry
References: <20180308114232.10508-1-pclouds@gmail.com>
        <20180316183200.31014-1-pclouds@gmail.com>
        <20180316183200.31014-10-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 12:49:44 -0700
In-Reply-To: <20180316183200.31014-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 16 Mar 2018 19:31:58 +0100")
Message-ID: <xmqqmuz7242v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> It's very very rare that an uncompressd object is larger than 4GB
> (partly because Git does not handle those large files very well to
> begin with). Let's optimize it for the common case where object size
> is smaller than this limit.
>
> Shrink size field down to 32 bits [1] and one overflow bit. If the size
> is too large, we read it back from disk.

OK.

> Add two compare helpers that can take advantage of the overflow
> bit (e.g. if the file is 4GB+, chances are it's already larger than
> core.bigFileThreshold and there's no point in comparing the actual
> value).

I had trouble reading the callers of these helpers.

> +static inline int oe_size_less_than(const struct object_entry *e,
> +				    unsigned long limit)
> +{
> +	if (e->size_valid)
> +		return e->size_ < limit;
> +	if (limit > maximum_unsigned_value_of_type(uint32_t))
> +		return 1;

When size_valid bit is false, that means that the size is larger
than 4GB.  If "limit" is larger than 4GB, then we do not know
anything, no?  I'd understand if this "optimization" were

	if (limit < 4GB) {
		/*
		 * we know e whose size won't fit in 4GB is larger
		 * than that!
		 */
		return 0;
	}

> +	return oe_size(e) < limit;
> +}

Also, don't we want to use uintmax_t throughout the callchain?  How
would the code in this series work when your ulong is 32-bit?

> +
> +static inline int oe_size_greater_than(const struct object_entry *e,
> +				       unsigned long limit)
> +{
> +	if (e->size_valid)
> +		return e->size_ > limit;
> +	if (limit <= maximum_unsigned_value_of_type(uint32_t))
> +		return 1;
> +	return oe_size(e) > limit;
> +}
> +
> +static inline void oe_set_size(struct object_entry *e,
> +			       unsigned long size)
> +{
> +	e->size_ = size;
> +	e->size_valid = e->size_ == size;
> +}
> +
>  #endif
