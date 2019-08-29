Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CC81F461
	for <e@80x24.org>; Thu, 29 Aug 2019 13:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfH2NMk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 09:12:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37847 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfH2NMk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 09:12:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so3579020qto.4
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZyS5lNbrIOJc5fdsRkzyHC9bfkBrUx4oMFfWIjBvAts=;
        b=b1bVH31IrPLyt8H4vyUz5a9LB/0jqBi0tQC/wFSX+XQNtERfvqHJVC9xOL/PkfCuuC
         qyhkng1hBJy0y2oEmYVeXdkqOcFOzUi2t7nfo9gdjErna0b2I0mcLJA/RCQC41Rt7LKe
         NsSoL5BebUBepTm1MRnok3Kzz+4nSs3Jz6pF1PVPpHckaax1uDztJPmxlqk+SwCBQVvP
         BPkDrz6s+rtugHDNRKHCTnM92PTVVLVErpsYh1pNPrP+xorLEViQhouWee2LiBc9JfTE
         m3EHG0nDpCaK0UJ2aiDrI2PlOXQJwZVhACG0a17EjtJhm1c5MIrZ0C+1u7saSbXNrJ+5
         6ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyS5lNbrIOJc5fdsRkzyHC9bfkBrUx4oMFfWIjBvAts=;
        b=pdvgBCxu1jDuePSOPYs+CWbAh00sr4GocZs0DnzsFno8CS67bhwYuzqTlDEwHiUAkL
         F2l7k3fJcmzEXzw3dK/+SReKfszjd43Sf2tWrilUEQ5T12N2nCe1FRIXOT+A1F6BrXa2
         Diqcj8V4HL9XGEqDWrgebexZqw4h6hn5h2IXVktauVQOwG7OWYBSkp/4K1dC8a5fPgVr
         hWpVjbnPJ9Er8FJTkx2Pcu+7/pl152naiQSPOv67BysPMwtl/Co/2fRgjt8mrPujHN/M
         x6L2opUHIz9rEInESY7t8egvf5QAshn4BZRB5zTwAQq3I6TSvGv2thbjuKpLtOEIsVeB
         TGog==
X-Gm-Message-State: APjAAAXAaq44AcXYNmTUxd5Kohe1rvGsQLSMBuHPQuOsOgxJVNOn5zB3
        vyk5Bfq5iaz1BhxiHyyqe5g=
X-Google-Smtp-Source: APXvYqxDYNMCJmrpekS3XXIW71jhX8utH6BTuXckQ6feNefCml5XbRyeOHwUavyie6Y4papO4V17ig==
X-Received: by 2002:a0c:f610:: with SMTP id r16mr6355693qvm.216.1567084359609;
        Thu, 29 Aug 2019 06:12:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f9f6:adc0:ae8d:8f1f? ([2001:4898:a800:1010:ab2c:adc0:ae8d:8f1f])
        by smtp.gmail.com with ESMTPSA id x28sm1236407qtk.8.2019.08.29.06.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 06:12:39 -0700 (PDT)
Subject: Re: [PATCH 2/2] list-objects-filter: handle unresolved sparse filter
 OID
To:     Jon Simons <jon@jonsimons.org>, git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net
References: <20190828201824.1255-1-jon@jonsimons.org>
 <20190828201824.1255-3-jon@jonsimons.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <164fa8bc-bcf1-4cce-1b49-94b64535d332@gmail.com>
Date:   Thu, 29 Aug 2019 09:12:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190828201824.1255-3-jon@jonsimons.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2019 4:18 PM, Jon Simons wrote:
> Handle a potential NULL 'sparse_oid_value' when attempting to load
> sparse filter exclusions by blob, to avoid segfaulting later during
> 'add_excludes_from_blob_to_list'.
> 
> While here, uniquify the errors emitted to distinguish between the
> case that a given OID is NULL due to an earlier failure to resolve it,
> and when an OID resolves but parsing the sparse filter spec fails.

Adding localization here also seems like a good idea. Thanks!

-Stolee
> +test_expect_success 'partial clone with unresolvable sparse filter fails cleanly' '
> +	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master:sparse-filter "file://$(pwd)/sparse-src" sc1 2>err &&
> +	test_i18ngrep "unable to read sparse filter specification from sparse:oid=master:sparse-filter" err &&
> +	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master "file://$(pwd)/sparse-src" sc2 2>err &&
> +	test_i18ngrep "unable to parse sparse filter data in $(git -C sparse-src rev-parse master)" err

Just as a sanity check: when we use test_i18ngrep, how does it know how to
separate the part that is translated and which part is not?

	translated: "unable to read sparse filter specification from"
	not translated: "sparse:oid=master"

Thanks,
-Stolee
