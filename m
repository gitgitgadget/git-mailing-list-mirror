Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477DBC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350785AbhLFVTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351013AbhLFVTh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:19:37 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F97C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 13:16:07 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bk14so23826386oib.7
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 13:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MNtqRu3LI1mfBPoIJB1z3c6bNzxZdJQo/8sDeqJQIyw=;
        b=SYo23TX85SoNmPiHy3fABYxzciX/2bA6kRJ/tNTRV47/qW0M9GFz05gNXyS+32ASce
         Xl+ZVhJ1ROHRmt6e+DeiwmGLEJXkMSWAKx2AToIrRjMHu7SzHObkcXvxhnEC3+sGxCg3
         IPwe0lgfAx3ZovMPKrP6ZltkIFpwYBufEL8G4OiCEn3kGO14aQaNJLVPXs8hJmIxIxMS
         NhTs6SlzKWsG5YhWVusj4DaLVbVXN9GO6VUxloGapNQB+L5Uia1XkylnON/3GNtA/W4j
         oLd6i086vIYABMGBfp/1nniRB3M1h1Kzj0D91m9wCaQJFYQzZdjxkqevgKgAdq/eb+80
         5jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MNtqRu3LI1mfBPoIJB1z3c6bNzxZdJQo/8sDeqJQIyw=;
        b=ZMNIFp/fMf2Lwo/K28wJD/dein7Ob9vGRAAB4nNAzeRw5+k6hAMgi4OvRFYQGTM302
         QHnK416JTJE+3Ys0cX23rkhO2b+hlScAzFQMQuctsWXJZfsmp2RKRaDtZlv+dQc1ib2V
         Kr1Qlhw80GLc2DJ0zPUjy5lnJEGao5bPe53jtGiLGaWpKIR361FAfEMYzlo8drObOvdT
         y5YeaZBFPrzNobEvYCmJ28g4L4zXiuv7/PYnSE2Qmby8HVJN3xDlBPuBHv4ljAoicGJ8
         n3fx2G0F8aTNeHao9t4C126FRzvo4brQThBBk8HS25zFArOuzTN7ZiFx4ljm1rX+ETvA
         ML1A==
X-Gm-Message-State: AOAM533uS6R/7ZnhObOR/zXtbr7BHSt+xiykyBJGTmAYHkZtHCNtXCPN
        ZSr/vS5bXLRsXWjRyGU/iH4=
X-Google-Smtp-Source: ABdhPJwagfqZzYNmtT1kY0zOTGUNZ7zyqvqP0VnC3dNPuWtaJ/0D7q40s8L8N3qQcMuQ2mz/aBJKKw==
X-Received: by 2002:a54:480b:: with SMTP id j11mr1214948oij.102.1638825366719;
        Mon, 06 Dec 2021 13:16:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:88f0:5cbe:30c7:d6dc? ([2600:1700:e72:80a0:88f0:5cbe:30c7:d6dc])
        by smtp.gmail.com with ESMTPSA id m22sm2613779ooj.8.2021.12.06.13.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:16:05 -0800 (PST)
Message-ID: <15f1bbc6-7ae6-0ed3-872a-51feebd1296c@gmail.com>
Date:   Mon, 6 Dec 2021 16:16:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 06/17] t/helper: add 'pack-mtimes' test-tool
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <e0a7b3b310c69350d8e2c0561e0991bb7045a66d.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <e0a7b3b310c69350d8e2c0561e0991bb7045a66d.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:
> +static int dump_mtimes(struct packed_git *p)

nit: you return an int here so you can use it as an error code...

> +{
> +	uint32_t i;
> +	if (load_pack_mtimes(p) < 0)
> +		die("could not load pack .mtimes");
> +
> +	for (i = 0; i < p->num_objects; i++) {
> +		struct object_id oid;
> +		if (nth_packed_object_id(&oid, p, i) < 0)
> +			die("could not load object id at position %"PRIu32, i);
> +
> +		printf("%s %"PRIu32"\n",
> +		       oid_to_hex(&oid), nth_packed_mtime(p, i));
> +	}
> +
> +	return 0;

But always return 0 unless you die().

> +	return p ? dump_mtimes(p) : 1;

It makes this line concise, I suppose.

Perhaps just use "return dump_mtimes(p)" and have dump_mtimes()
return 1 if the given pack is NULL?

Thanks,
-Stolee
