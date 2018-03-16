Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A831FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCPUCJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:02:09 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43733 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeCPUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:02:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id o1so12732995wro.10
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CNI4U4zkLRNwCOGMGmvVa9guyH6b+fQ0u1/0NhpK8Pw=;
        b=Rp2v5tUq1gE/OHG/j1aJGxlmhgYWA+wxJLx3Qx5Q8FlxtJb4RkkNG8gZo8aaew/zh+
         1zfuIG8bzPhFhULC7lqVoV37sgzFhrs44N/79B2F0mO2VD0m8bDzkjUx9ancQef/FSkV
         NGJH95JgufmaIwZLuaFbt3zSLfUkVaBd/2ZrYVpfKPVJhjr5aqKQh+Tl809fNk+bi8Lm
         z/SAE5aZRNtA20zIVk1OIXGsTSXGT1fCUJFGKqaJCTNt46Rnz7kCVPnLTUW3iROsibOr
         tyRxEsayWfb71GINCifKqMPsCVRF+h2bAHjkoqf4lDNbFWYoqKutx1z17GdjiVZ3yEDx
         rkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CNI4U4zkLRNwCOGMGmvVa9guyH6b+fQ0u1/0NhpK8Pw=;
        b=fI7yRqE54xUwlmfYkL3bIhF6qUX7BbR8BmYloUloSzTDdlFu004CDmUidzJ32fVquX
         saCk3+qk1f65KUqDhuxneuaK7lE1UkhColPGLLhOzdPl23DkbAaANCnLf3TZwm1lvytB
         e2YXcqBQVJBVtA0h74Uiz+TIHqh5+sK4CFKdq2UHjZ2iSR3toZ7KBajUyIPUqgc3V9ml
         vN5gdBN7dCNeMC2ykJPY3kIo06U2kLQmQ3cl2bk/iBUVREDkWHspIA0AicvGyk18mrO8
         YpjHPnFjS2fhQtJzH01GiArkDQnQ2ADMjV5l33TGvHOjVDLHYIb+U/1D836c2PSUoJiJ
         ES8w==
X-Gm-Message-State: AElRT7EQPQQu0AXJ1Yzd5fS+nE8rE4/DytnFc2xdFmjrtHas09gNwB2T
        dUSD08OIHmNxE+30gBq7yHcJpTCn
X-Google-Smtp-Source: AG47ELv8Uo7hCX71OjDyRw8xfZzbh8V0HAQdyjPH7CZyHIB99JOVKjWM3s/3MV2R5GU9LJA7nXmJ9Q==
X-Received: by 10.223.226.14 with SMTP id j14mr2568348wri.17.1521229203773;
        Fri, 16 Mar 2018 12:40:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o47sm9750625wrc.7.2018.03.16.12.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 12:40:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 08/11] pack-objects: shrink z_delta_size field in struct object_entry
References: <20180308114232.10508-1-pclouds@gmail.com>
        <20180316183200.31014-1-pclouds@gmail.com>
        <20180316183200.31014-9-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 12:40:02 -0700
In-Reply-To: <20180316183200.31014-9-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 16 Mar 2018 19:31:57 +0100")
Message-ID: <xmqqr2oj24j1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> We only cache deltas when it's smaller than a certain limit. This limit
> defaults to 1000 but save its compressed length in a 64-bit field.
> Shrink that field down to 16 bits, so you can only cache 65kb deltas.
> Larger deltas must be recomputed at when the pack is written down.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

>  		if (entry->delta_data && !pack_to_stdout) {
> -			entry->z_delta_size = do_compress(&entry->delta_data,
> -							  entry->delta_size);
> -			cache_lock();
> -			delta_cache_size -= entry->delta_size;
> -			delta_cache_size += entry->z_delta_size;
> -			cache_unlock();
> +			unsigned long size;
> +
> +			size = do_compress(&entry->delta_data, entry->delta_size);
> +			entry->z_delta_size = size;
> +			if (entry->z_delta_size == size) {

It is confusing to readers to write

	A = B;
	if (A == B) {
		/* OK, A was big enough */
	} else {
		/* No, B is too big to fit on A */
	}

I actually was about to complain that you attempted an unrelated
micro-optimization to skip cache_lock/unlock when delta_size and
z_delta_size are the same, and made a typo.  Something like:

	size = do_compress(...);
	if (size < (1 << OE_Z_DELTA_BITS)) {
		entry->z_delta_size = size;
		cache_lock();
		...
                cache_unlock();
	} else {
		FREE_AND_NULL(entry->delta_data);
		entry->z_delta_size = 0;
	}

would have saved me a few dozens of seconds of head-scratching.

> +				cache_lock();
> +				delta_cache_size -= entry->delta_size;
> +				delta_cache_size += entry->z_delta_size;
> +				cache_unlock();
> +			} else {
> +				FREE_AND_NULL(entry->delta_data);
> +				entry->z_delta_size = 0;
> +			}
>  		}
