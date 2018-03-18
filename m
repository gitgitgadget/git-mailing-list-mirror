Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A4B1FAE2
	for <e@80x24.org>; Sun, 18 Mar 2018 05:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbeCRFJs (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 01:09:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56171 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeCRFJr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 01:09:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id q83so9742193wme.5
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 22:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gLv0pkzCwqWQX2v003UA0KDoQ6kXbJMTpoPwBVUuPkc=;
        b=JfK2YTgE4tDxO2pwtgqQTif5E9wLLvIbkfVx+uogaTlJ1bP6Y8zalB1IBvZ6KIb5zv
         KWbebHyQNBPq35dRNXeOgQI8weH1WGSz15/fT/72z+gGQJOaLEGNjSPK0ewXM2ZBxjsq
         I/9aPfQcNAXbTrWlIaODY/oVSaPkSx4G9l3oMlIvzUXo0kt4okOarX+F5RW6M4zWpuDZ
         vx3KafkME4sGwI+OSevmtEUJzqeEazZ0/YJd58MsxdBi9EjwWm3CjtmlVTfYN+u98OtB
         3i4t1ZwIs4aCetC1m6COHer5oiukCwTXIqa8x/lh7TYvRv379WVxk6U9XACb70Gb2C3P
         kb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gLv0pkzCwqWQX2v003UA0KDoQ6kXbJMTpoPwBVUuPkc=;
        b=uiTdlABuekMU6bVw4t8UkVGRfW02FUm+uae7jlD+JqMQ9kLiG0k1WExPzhO44pgOmM
         ahh/635po2nnQtZaltZlUidlY6JCMcSd6My2Oy3vLpBrQD8vawQCH/l/TGKEkKciyums
         WI6Ici5D4EAHWZIgIgIEhF+Ga1mUVNLKuuwSskD33lMwZMFqNmJkckMZdgaUnYo0wb+c
         8BmMmsN5UQ+/Ng4BucGkD/PysJSwZcBbF+2MrYwKKTk+kBVnRjQhxBItRfqmU4ICwau9
         OIusScSjfgXYEmTsRyovMX44oalnC5YBur35tnnuVv1RLDGPcLYwWcHvLLCEDZCMWULc
         /S7A==
X-Gm-Message-State: AElRT7GKPCq6nFR4QkjHyJJs0Gw38yoiFnateyF+E7GuewtJSoMJmbeG
        FmYuPKT/cNskOeHEEUXRirg=
X-Google-Smtp-Source: AG47ELuIcZ9zVckmgbqakk1ZO64elkh8KYltbFm9GSa4J4dry7XPpav2HCma91xr3JhDaU29y1vvqg==
X-Received: by 10.28.133.200 with SMTP id h191mr5887384wmd.39.1521349785533;
        Sat, 17 Mar 2018 22:09:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z16sm17661875wrc.70.2018.03.17.22.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 22:09:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 09/11] pack-objects: shrink size field in struct object_entry
References: <20180316183200.31014-1-pclouds@gmail.com>
        <20180317141033.21545-1-pclouds@gmail.com>
        <20180317141033.21545-10-pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 22:09:42 -0700
In-Reply-To: <20180317141033.21545-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 17 Mar 2018 15:10:31 +0100")
Message-ID: <xmqq8taqx949.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +static inline int contains_in_32bits(unsigned long limit)
> +{

This name somehow does not sound right.

If the verb "contain" must be used, the way to phrase what this
function does with the verb is to say "limit can be contained in a
32-bit int", so "contains" is probably where the funniness comes
from.

"fits in 32bits" is OK, I think.

> +	uint32_t truncated_limit = (uint32_t)limit;
> +
> +	return limit == truncated_limit;
> +}

I am guessing that a compiler that is clever enough will make this
function a no-op on a 32-bit arch and that is why it is a static
inline function?

> +static inline int oe_size_less_than(const struct object_entry *e,
> +				    unsigned long limit)
> +{
> +	if (e->size_valid)
> +		return e->size_ < limit;

e->size_ is the true size so we can compare it to see if it is smaller
than limit.

> +	if (contains_in_32bits(limit))
> +		return 1;

If limit is small enough, and because e->size_valid means e->size_
does not fit in 32-bit, we know size is larger than limit.
Shouldn't we be returning 0 that means "no, the size is not less
than limit" from here?

> +	return oe_size(e) < limit;
> +}
> +
> +static inline int oe_size_greater_than(const struct object_entry *e,
> +				       unsigned long limit)
> +{
> +	if (e->size_valid)
> +		return e->size_ > limit;

e->size_ is the true size so we compare and return if it is larger
than limit.

> +	if (contains_in_32bits(limit))
> +		return 0;

Now e->size_ is larger than what would fit within 32-bit.  If limit
fits within 32-bit, then size must be larger than limit.  Again,
shouldn't we be returning 1 that means "yes, the size is greater
than limit" from here?

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
