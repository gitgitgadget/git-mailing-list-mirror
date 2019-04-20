Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C9120248
	for <e@80x24.org>; Sat, 20 Apr 2019 21:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfDTVB1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Apr 2019 17:01:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40065 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDTVB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Apr 2019 17:01:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id v7so5093435qti.7
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KLWJS1hELkU1gyMW51Za00SGTQYcxpE1oQUUdjPDyKM=;
        b=gsdt8FzIUORGOM/asQTkw/W/syVT8ux5jcx3EL5Vk/tBDhf2gOkZz+h3IcfTKGeIQK
         wKzan6Y/WsJwE9oOILmF5SDsRyqTiYkSuTePXcA5NMHbMuMTKFxP8leCKdC9bMDGPCxq
         +38TyvQ9aew1S9hl7onmHrA0H7GqKWF11AKYsSAz3REtD9OAnwgIVYL5EQMKGI71mRtE
         GuGbVniXRIQ6+N3UeQDv+8PqRkxNK5F/jNidPpDiQ+C3KEM6VNIk02V/8Q+nCvz2q/Hy
         THrdD/49k0MJ6CX7yLw4umEqzSKjaUp8Ef0SstHc7fvT1XVst3zQZm6PzT+c4pwL2ESM
         KjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KLWJS1hELkU1gyMW51Za00SGTQYcxpE1oQUUdjPDyKM=;
        b=JMbDWkMT28Yc3NjUwCyz1o1kySIgxm9IjxWJrh+4es4+DoX9qhQ6p1drhVikR1+YqY
         I3BNss5R4n722UKwx9xyYTLgSDywJHpVThmDb2eMiHCPmA3vaN05C5SVMaNBylcGvrFb
         HpAQmE5ednBRZqRRmRHhn9TJybxvLfnHaY5wQrnjxPcINoknCeAjTqM+8bw7DkyUjlPI
         u05t9pLd23AcvkGTHYM8eNgCFRA98dLpeGRYj1Dbh8Lf5E8d8mAcwOkfurWbG2iEppNk
         5HqDdiYWprU1IxuLEBDTnQiCuxoHEsMmEKWKdNZCqtw00saNXIStmeIcIKiIXQvmf/U9
         WWLA==
X-Gm-Message-State: APjAAAWLd//BRZNs133Tx+6p77i5OrCKI7L3vnaNPioGGmowI0S3vn7t
        oSE6BkKjYDEB3hkUEN4wCCg=
X-Google-Smtp-Source: APXvYqwyeyY2/MA1EIQ4QScQkyi9d6NnKvQZV8cD4rOaEq12PJkGrpjwwZqGWe34Dh2p5Dtly9Xy5g==
X-Received: by 2002:ac8:730c:: with SMTP id x12mr3125466qto.372.1555794086389;
        Sat, 20 Apr 2019 14:01:26 -0700 (PDT)
Received: from [10.0.1.4] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a8sm5015739qtc.19.2019.04.20.14.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 14:01:25 -0700 (PDT)
Subject: Re: [PATCH] t5304: add a test for pruning with bitmaps
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <49e2aa9b-ff22-a8d1-ba72-1c881ff5fab4@gmail.com>
 <20190418194953.GA15249@sigill.intra.peff.net>
 <20190418200827.GB15249@sigill.intra.peff.net>
 <ba16afb4-25c1-8148-602e-130b0e17fc89@gmail.com>
 <20190420032435.GA3559@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <78a60be8-414e-cd32-8eb2-36b47702c10d@gmail.com>
Date:   Sat, 20 Apr 2019 17:01:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190420032435.GA3559@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/19/2019 11:24 PM, Jeff King wrote:
> Try running t5304 with this:
> 
> diff --git a/reachable.c b/reachable.c
> index eba6f64e01..7ec73ef43f 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -191,6 +191,8 @@ static int mark_object_seen(const struct object_id *oid,
>  	if (!obj)
>  		die("unable to create object '%s'", oid_to_hex(oid));
>  
> +	if (!(obj->flags & SEEN))
> +		die("seen flag not already there");
>  	obj->flags |= SEEN;
>  	return 0;
>  }
> 
> which shows that we are indeed freshly setting SEEN on some objects.

Good point! Thanks for clearing that up for me.
 
> Interestingly, I don't _think_ you can cause an object to get pruned
> accidentally here, because:

[snip]

I appreciate the additional context that you gave (and I snipped). This
makes me comfortable accepting this test as an exercise of the code (to
guard against future changes that create failures like null-refs) and we
will need to rely on the performance suite to catch issues like removing
the SEEN markers that I had tested.

Thanks,
-Stolee

