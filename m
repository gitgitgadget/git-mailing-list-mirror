Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68591F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753747AbeCFUuc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:50:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42498 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753504AbeCFUub (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:50:31 -0500
Received: by mail-wr0-f195.google.com with SMTP id k9so22313571wre.9
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZCB1VQIP5oHtvYU8Zz+L2H5BF2XOagnuK6EGasN4Dpk=;
        b=apWvqBOkgHHsWRQsAAOcnpEPd2FrKSxMvjl/4b3BOcByVL3R8szbUZeuG9QIklQsZQ
         7ZWeWPW4/lKoKOiga1DQpn7ptn1F+cIQyT+dsVobttMu8eWK4NEWFGnJH02YRdkzokAl
         h0LBFmi9O8HDVshToJvLrRoJjGIEOEwAnKdv5qG2/zRWbtOFhj1m+Ts6eCIf+2DI/JFB
         C3lC/X+jUD0A7FOSc/hjAB4bsdOpAJOASwDLG/p3i0DBxd41K0W9xrHBIPxuVXhh2y/z
         42NcbVxu5c5MRS9OP6mT+px70Ig7kjCKR1BxbLhNmc4hnUdkIAMPvwC7MAz3nL+NT02l
         z80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZCB1VQIP5oHtvYU8Zz+L2H5BF2XOagnuK6EGasN4Dpk=;
        b=JQQxcBNa7nlFPz+UplA73CnsYdZNzR8r/1cdSKZPgheo9DzvIwAPWRVkjR6eqPZ3Kt
         i9xF3JPSKYWAofe1LesP9BsbsE3C+ysR1mBzn9Hq2v45w1+fmyrjut97b1ZUbG+WNw47
         LmxXqUr8hAeigPMj5hXhGcKFARhBRJbWZ45cihsNEzgD/rVIF1/HuKUQCVNrtU53jk3H
         bQeEEIheCnBrZaCQ8Ue32VsKN1SfMH0EOsdtIxwOhOmWbunPmYGqS8nMncN3Aij7UXbM
         7MO2HmKcq5T345/l5yKaUF96qH5FiJ6c+bQ5rp3OHaKpBDpUHtE6xn/0jnLFP3HpY9U7
         Va3w==
X-Gm-Message-State: APf1xPDgu2vUeBlTgfHLpUIjbQ1eKNNSrj79Ievc+XD0QgLYY4G1MGp2
        qjR60vEk5cJ/xis5VCPHcE6/eqab
X-Google-Smtp-Source: AG47ELtpp1P7BLSdt8bf9rfM7O4rjto9zXxecKYv+L67pgBCUE28oZLT8uTuONp6Aeb9wlCH7++UfA==
X-Received: by 10.223.156.206 with SMTP id h14mr15928112wre.281.1520369429980;
        Tue, 06 Mar 2018 12:50:29 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n29sm3897637wmi.32.2018.03.06.12.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 12:50:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
        <20180304201418.60958-5-lars.schneider@autodesk.com>
Date:   Tue, 06 Mar 2018 12:50:28 -0800
In-Reply-To: <20180304201418.60958-5-lars.schneider@autodesk.com> (lars
        schneider's message of "Sun, 4 Mar 2018 21:14:14 +0100")
Message-ID: <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
> +{
> +	return (
> +	   !strcmp(enc, "UTF-16") &&
> +	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
> +	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
> +	) || (
> +	   !strcmp(enc, "UTF-32") &&
> +	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
> +	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
> +	);
> +}

These strcmp() calls seem inconsistent with the principle embodied
by utf8.c::fallback_encoding(), i.e. "be lenient to what we accept",
and make the interface uneven.  I am wondering if we also want to
complain when the user gave us "utf16" and there is no byte order
mark in the contents, for example?  Also "UTF16" or other spelling
the platform may support but this code fails to recognise will go
unchecked.

Which actually may be a feature, not a bug, to be able to bypass
this check---I dunno.

The same comment applies to the previous step.

