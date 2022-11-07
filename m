Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880BC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiKGTcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiKGTcI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:32:08 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CB2529C
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:32:07 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id e15so8811570qvo.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ba9QFMuvvheBn1w0kD3Ek2Lxsfh/c+2zVHPGkx/dZ0=;
        b=KkUqiRtWGD998qkFw6oco8Ue28uQoV5TzZWiYOIVG5hIeBtmPt+a1iv1iH3iGP9WUo
         sb1U1frktqK5EjlT/ShaVRGPHfDpaC8lPv32rH2ugrLYFkNrpUPpMTChw2aiaHaZmIGA
         zCJc2xzmLLmho05htAo5/Nrk0L6mchI6JF6hiBaoP7RFL1H5sG++TTeHZOACjWYwDcpn
         QDIK4ac98BfD3692ujicyC9nNf1L0LR74w2dRqEbRjkq3Q0ZoACB3uwalEPT+ucrD2Uc
         bwsOBL39KK4rNEfmatITlRYgdwQZm//J9cj4Gvf29bMjPyD4XdoNFmxWTkHWUmAFNv89
         WDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ba9QFMuvvheBn1w0kD3Ek2Lxsfh/c+2zVHPGkx/dZ0=;
        b=i3ZSMwuZiQjfG4ZkewUl8T3t+rLLk8I4UYt1Kqb8twm22JakmBYLNcpBKD/Ast9SKP
         Me6z6f0Pf6LC/60cJmDKvZyl3ypL4MdaFmOZjFDyGSjGdo9vhUti3xLctzh2ro9WHJFs
         F9ZH0daxzkGMbQD9YlUPxa2e8hwPMEAAJsQsIDPwEIDmJdAygk3ySnJGtZp96yDPE0/S
         673DlIvDKxl3Ab+57Kb7SPyIXG4rmJdYsHAu4EKVbMhtePZgG3AcJIgYoRbW1d/r4yL0
         6JLBsPiig6I4C1O1UHrjFDo2tvTfHW4lkUyaYkuGOOGiXVFMr3ovv+kOBRaMR/IzbAZo
         MhcA==
X-Gm-Message-State: ACrzQf3FmvL7lzWcAq7zIEVvNiACw81VbE0QeVF2hpgMumZZkt0kEiiv
        QfamSd5HkbdN7Qtq755CvXL0
X-Google-Smtp-Source: AMsMyM5Y6FfdWmCTSRy/FYgnFrBSgaMYY3gMcbwcWMLO6lTjioPzMu6bYhBRioxW4yewgri1ap4gPQ==
X-Received: by 2002:ad4:5941:0:b0:4b4:46b5:e36b with SMTP id eo1-20020ad45941000000b004b446b5e36bmr45827245qvb.33.1667849526964;
        Mon, 07 Nov 2022 11:32:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id b14-20020ac844ce000000b003a527d29a41sm6606089qto.75.2022.11.07.11.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:32:06 -0800 (PST)
Message-ID: <2c59cbca-05fb-8aef-a671-61b4a463a368@github.com>
Date:   Mon, 7 Nov 2022 14:32:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 3/4] builtin/repack.c: write cruft packs to arbitrary
 locations
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1666636974.git.me@ttaylorr.com>
 <c0f4ec92a057fdab905447bb917ff09e9bcaaab3.1666636974.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <c0f4ec92a057fdab905447bb917ff09e9bcaaab3.1666636974.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/22 2:43 PM, Taylor Blau wrote:
> @@ -714,7 +717,12 @@ static int write_cruft_pack(const struct pack_objects_args *args,
>  		if (line.len != the_hash_algo->hexsz)
>  			die(_("repack: Expecting full hex object ID lines only "
>  			      "from pack-objects."));
> -		string_list_append(names, line.buf);
> +                /*

This line looked oddly out-of-alignment with the next one.

It seems that the comment is preceded by spaces and not
tabs. Perhaps Junio fixed this during his application of
the patch to keep the builds happy.

> +		 * avoid putting packs written outside of the repository in the
> +		 * list of names
> +		 */
> +		if (local)
> +			string_list_append(names, line.buf);

LGTM.

Thanks,
-Stolee
