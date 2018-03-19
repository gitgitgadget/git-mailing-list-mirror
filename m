Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37AF11F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967012AbeCSQTu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:19:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36346 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966659AbeCSQTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:19:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id x82so3992903wmg.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eY5JubTPL0GbwF4fcaZIKvZYCF3mxH+C5jmp3WyDRMY=;
        b=W9HPolCywnmLozncFlrJkjHp44G4xYbQ15i4usQXPcJiNF96nPyTncgWj3ritIJ9Pk
         Gz2qauIFm8DadzzknhtRQV3zyGmsy8YMoi+e0sq2VVieXrH5mxG8S1c3MQENCl5D1u6s
         ASuZEG94yme/tXOu43Yjp8E3UisI+21BjoGZcp1GknTkI/yj2NAfTg8xAzp2r/VGe/Tu
         WvhLUN6/43Blqtf6htfdSJrI8OHrUKSm2Qplk+EGak2ZdzQELKNi4ejAoM8OZ/SOxlBw
         4WJ+37dt6xeeSIeYig0lmW/+4RUX0Mk7e6QR4UJxQ2p3s9OCfu5252BTC0J9cEo/um5y
         vgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eY5JubTPL0GbwF4fcaZIKvZYCF3mxH+C5jmp3WyDRMY=;
        b=Q1znrAwU9Uy2Dve8KMIEvkoeEGgSzHWKuAygrL2GhHJEvCRovdbtGi7LRq1BRfKknH
         dd/G/49BdWcsEm9MYL6+zdCvVdnDavoVzqWnJR6Gq0S2KFlIoVf2ja20msTgfyFxtg69
         27SRg/JXEAqaVmR0PBuT7VHtUk071fFDudGnvWRsVDi94kLgSXIeAeE1J5/ssKBJsPFT
         KHk0I0wGl+tc6u4cGEfQjgWgi4M9k3/Xp4CxGGdSkEVK85HC6Uku/ucDMLSfG7TANNRP
         EAY7LtKnsz1xtCPOb5RRO7E0BWJGrmW1c4BQeUavbgn9KHXThPlEUCJPAxm9hU+GQgCT
         6aYQ==
X-Gm-Message-State: AElRT7H+BtlqgLPEksa54Uabv9EQ6vmcKRcISGUAnjQV8GN6ZqrZu9KD
        UmcsgRRgIHILXrjsGEBiUU4=
X-Google-Smtp-Source: AG47ELta5AaUaALom72ePunK70Ms5kjfgI28CJMqfcxQ84tfiT7CE+UXhrDhrYXkMm1yHsVUGC9IOw==
X-Received: by 10.28.22.210 with SMTP id 201mr8491130wmw.66.1521476384657;
        Mon, 19 Mar 2018 09:19:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w6sm492134wre.25.2018.03.19.09.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 09:19:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
References: <20180317141033.21545-1-pclouds@gmail.com>
        <20180318142526.9378-1-pclouds@gmail.com>
        <20180318142526.9378-10-pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 09:19:42 -0700
In-Reply-To: <20180318142526.9378-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 18 Mar 2018 15:25:24 +0100")
Message-ID: <xmqqzi34vy01.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +static inline int oe_fits_in_32bits(unsigned long limit)
> +{
> +	uint32_t truncated_limit = (uint32_t)limit;
> +
> +	return limit == truncated_limit;
> +}

I do not think it is worth a reroll (there only are a few
callsites), but the above has nothing to do with "oe" fitting
anything (it is about "limit").  Do you mind if I did this instead?

	static inline int fits_in_32bits(unsigned long size)

... or other suggestions, perhaps?

